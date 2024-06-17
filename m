Return-Path: <linux-kernel+bounces-218073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F9E90B8F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017331F20FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062DD199E89;
	Mon, 17 Jun 2024 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M363FGMK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21A81993B1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647363; cv=none; b=AYcr8XVtzL4AIxf4Vh+Ns1YV9cANJ5DMNmpoXWQUhdgFpORLyUyZPjOThmWhIthS57Mi1cGeCboJL7SNqaV/64K9VtC0E4lDFKpW/FDWtH65OwwvvQOZ82X9kMR70vA1l4Z1P+eV/zc2llmkRwyL8E6b+48bdj6qvrtYLs+Ib+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647363; c=relaxed/simple;
	bh=v2RLB6gYzEDX+VCX5LHy5PgJ4jOX5BIh4g4psyqxrzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXt3aQkU87BS3vmdPQMwORQBixl0gsBxvcrtXp+mt9YGi6qGKqN9jR8dsvCxWmZDdnzc1DtipTZPlYD1EVDrhwnyLexE8xxLb/v9nsMXcc8bTvwMMnrTBPYM4dAxdtxL42R7q5rojbAAWJbF5HSAlwF0DC92Xh+V7qGUDVPYdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M363FGMK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718647361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XDaQsqwAgS9Ix3vAlEwU82EinwRpR6JSa/aEwAYx6g=;
	b=M363FGMKHhfm49Bm1Jx4cP9Lb2aPaYyn/HBbBHlo+e4F0Vu92z3QFxGRLK+blhxNM2y1Tn
	ep+G8dS+H8x9mkBGFGIqdIj9tb3jj42obT1prAfrh5IvjWP/wjl0ePHxoT6xgXjYDeKxzg
	1Fpg/laFPMKq8MMFWS+tvg0NgQclRFk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-eYR_E4J8NWOG5yY3yqKsmg-1; Mon,
 17 Jun 2024 14:02:35 -0400
X-MC-Unique: eYR_E4J8NWOG5yY3yqKsmg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7485D1956071;
	Mon, 17 Jun 2024 18:02:32 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 636001956087;
	Mon, 17 Jun 2024 18:02:29 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 3/7] selftests: openvswitch: Add set() and set_masked() support.
Date: Mon, 17 Jun 2024 14:02:14 -0400
Message-ID: <20240617180218.1154326-4-aconole@redhat.com>
In-Reply-To: <20240617180218.1154326-1-aconole@redhat.com>
References: <20240617180218.1154326-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

These will be used in upcoming commits to set specific attributes for
interacting with tunnels.  Since set() will use the key parsing routine, we
also make sure to prepend it with an open paren, for the action parsing to
properly understand it.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 37 +++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 4db20b38b481..4c235ff07aeb 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -284,7 +284,7 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_UNSPEC", "none"),
         ("OVS_ACTION_ATTR_OUTPUT", "uint32"),
         ("OVS_ACTION_ATTR_USERSPACE", "userspace"),
-        ("OVS_ACTION_ATTR_SET", "none"),
+        ("OVS_ACTION_ATTR_SET", "ovskey"),
         ("OVS_ACTION_ATTR_PUSH_VLAN", "none"),
         ("OVS_ACTION_ATTR_POP_VLAN", "flag"),
         ("OVS_ACTION_ATTR_SAMPLE", "none"),
@@ -292,7 +292,7 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_HASH", "none"),
         ("OVS_ACTION_ATTR_PUSH_MPLS", "none"),
         ("OVS_ACTION_ATTR_POP_MPLS", "flag"),
-        ("OVS_ACTION_ATTR_SET_MASKED", "none"),
+        ("OVS_ACTION_ATTR_SET_MASKED", "ovskey"),
         ("OVS_ACTION_ATTR_CT", "ctact"),
         ("OVS_ACTION_ATTR_TRUNC", "uint32"),
         ("OVS_ACTION_ATTR_PUSH_ETH", "none"),
@@ -469,6 +469,18 @@ class ovsactions(nla):
                     print_str += "clone("
                     print_str += datum.dpstr(more)
                     print_str += ")"
+                elif field[0] == "OVS_ACTION_ATTR_SET" or \
+                     field[0] == "OVS_ACTION_ATTR_SET_MASKED":
+                    print_str += "set"
+                    field = datum
+                    mask = None
+                    if field[0] == "OVS_ACTION_ATTR_SET_MASKED":
+                        print_str += "_masked"
+                        field = datum[0]
+                        mask = datum[1]
+                    print_str += "("
+                    print_str += field.dpstr(mask, more)
+                    print_str += ")"
                 else:
                     try:
                         print_str += datum.dpstr(more)
@@ -547,6 +559,25 @@ class ovsactions(nla):
                 self["attrs"].append(("OVS_ACTION_ATTR_CLONE", subacts))
                 actstr = actstr[parsedLen:]
                 parsed = True
+            elif parse_starts_block(actstr, "set(", False):
+                parencount += 1
+                k = ovskey()
+                actstr = actstr[len("set("):]
+                actstr = k.parse(actstr, None)
+                self["attrs"].append(("OVS_ACTION_ATTR_SET", k))
+                if not actstr.startswith(")"):
+                    actstr = ")" + actstr
+                parsed = True
+            elif parse_starts_block(actstr, "set_masked(", False):
+                parencount += 1
+                k = ovskey()
+                m = ovskey()
+                actstr = actstr[len("set_masked("):]
+                actstr = k.parse(actstr, m)
+                self["attrs"].append(("OVS_ACTION_ATTR_SET_MASKED", [k, m]))
+                if not actstr.startswith(")"):
+                    actstr = ")" + actstr
+                parsed = True
             elif parse_starts_block(actstr, "ct(", False):
                 parencount += 1
                 actstr = actstr[len("ct(") :]
@@ -1312,7 +1343,7 @@ class ovskey(nla):
                 mask["attrs"].append([field[0], m])
             self["attrs"].append([field[0], k])
 
-            flowstr = flowstr[strspn(flowstr, "),") :]
+            flowstr = flowstr[strspn(flowstr, "), ") :]
 
         return flowstr
 
-- 
2.45.1


