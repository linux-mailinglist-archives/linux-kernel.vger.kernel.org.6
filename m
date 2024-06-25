Return-Path: <linux-kernel+bounces-229382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F63916F19
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7B71F21A64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3F017C7C7;
	Tue, 25 Jun 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaWKz+eI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B017C211
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336185; cv=none; b=eZMImxoQuHIQQC0Ciz04JrZ5SeYVv5Z4yJXmTQUUEbN2LzS66XqMg2SIreg6qY73dS5NLXFef4Gxz1C91jr4jbyxyTIK5/G6pkSAVX7KNQcra/c6DypSQnjOYuo0RVgkJnBjapBAFINMSZFMg5DAOjp0iiUoW/wd0D7/wfQveew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336185; c=relaxed/simple;
	bh=kHVuyUmfTJRBFd1k+cHMycEzcwL36CsKp2EZmQ/0jG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/d0zQwK2rCWnj3ZcXr/83mIxueCWbzwNYHENzgqQgXgiaET5z4QVTZfcH8Crh2yis4tEhvlbpltZNUvz2MfElRMz4NLCGJ9fdZ+EnWt7Kv2K8xThb6lZJclj1yqaLfYSP3fKuY4cWcALYMW07/a12nroQQVrYBMta3opO35gYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PaWKz+eI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719336182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCDOyPFv9FwUF8iHM+GW0Vwe8aRTlUCkirTtkTwjThI=;
	b=PaWKz+eISlQnVQhd28B/RGyzkxfQKSIC72xKAhmnCPK0uzu2AAnIOPWIf1FwZl1n1YyASA
	KjR+WboW7Z2LxWMgzPeVFQ73dE8VGwFJdhaa9Q8u/fjoC1/dk33iQ4GlznHqXv2kx24CBq
	h6tFlk7nHCIeOetceS1gWhaAt8vqoCA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-tx3rdwt4NEKHQ3aHBlAVAg-1; Tue,
 25 Jun 2024 13:22:58 -0400
X-MC-Unique: tx3rdwt4NEKHQ3aHBlAVAg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92883195608B;
	Tue, 25 Jun 2024 17:22:56 +0000 (UTC)
Received: from RHTRH0061144.bos.redhat.com (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D5B81955E72;
	Tue, 25 Jun 2024 17:22:54 +0000 (UTC)
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
Subject: [PATCH net-next v3 3/7] selftests: openvswitch: Add set() and set_masked() support.
Date: Tue, 25 Jun 2024 13:22:41 -0400
Message-ID: <20240625172245.233874-4-aconole@redhat.com>
In-Reply-To: <20240625172245.233874-1-aconole@redhat.com>
References: <20240625172245.233874-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index 6bbe15daca74..00a8d6c0163b 100644
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


