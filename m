Return-Path: <linux-kernel+bounces-235322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CA791D3AC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 22:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42311C20C0E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553CD15A841;
	Sun, 30 Jun 2024 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOyb+Oga"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6015990C
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719777528; cv=none; b=Jdo4WiJiPqmbQ0HEV4lTT0FcI2zuL+vOAe1pru2NcQo5w5sUQiKar1ie7nicsTZCd/hTv5GVvmI62FnNQ0gvpXTwMZu488u92ZT38dnFk0Xe6mOMsDwRqVWGiOt6am5zjfvwZjSOQX2t+U8U/kFE58ahxtZ74Z4otoX05z4Bujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719777528; c=relaxed/simple;
	bh=rhrUK4kSWPb2+QOzvaLUotusmiPqRE5EK/ab8QLEDrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+xALt5ndYmk1mbrD8eJM84nwqyFU5VthWjbTFWDxUMmCA8l8sic8GINOLC/5JDmvLCf3GLY51kpyl2r4rrg1Wheaiuj2W2hTc6DaFaGoCFEEa174EwMsxZiHqno/FaSOyo4xlLF6fFglggt44WDIkS70QtXUHf6k7vkkCTJxS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOyb+Oga; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719777526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCsarsE51WIWuJR3kqpDN3VLDdV6+uotyzVsuXmGHHw=;
	b=UOyb+Oga0+tkUrSOycSnpayKjQt+tzFIlTPwumBMHY5pp+c/lB9XI2zaxvZe+A0Za1oM0U
	KGte560pMRHgUcTy6KUB6oUTSzoBE4WvdUrxXJ9KrERurnpCbH54JX+0DET+eyz/4qsG1s
	71tHDPRZxxu7teNkrZqMN0dtq31Rc4A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-a_8bqvVCNjupThVZTJfYiQ-1; Sun,
 30 Jun 2024 15:58:42 -0400
X-MC-Unique: a_8bqvVCNjupThVZTJfYiQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CD4A19560B3;
	Sun, 30 Jun 2024 19:58:40 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB60119560AA;
	Sun, 30 Jun 2024 19:58:34 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 09/10] selftests: openvswitch: parse trunc action
Date: Sun, 30 Jun 2024 21:57:30 +0200
Message-ID: <20240630195740.1469727-10-amorenoz@redhat.com>
In-Reply-To: <20240630195740.1469727-1-amorenoz@redhat.com>
References: <20240630195740.1469727-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The trunc action was supported decode-able but not parse-able. Add
support for parsing the action string.

Reviewed-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../testing/selftests/net/openvswitch/ovs-dpctl.py  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 4ccf26f96327..e8dc9af10d4d 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -863,6 +863,19 @@ class ovsactions(nla):
                 self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
                 parsed = True
 
+            elif parse_starts_block(actstr, "trunc(", False):
+                parencount += 1
+                actstr, val = parse_extract_field(
+                    actstr,
+                    "trunc(",
+                    r"([0-9]+)",
+                    int,
+                    False,
+                    None,
+                )
+                self["attrs"].append(["OVS_ACTION_ATTR_TRUNC", val])
+                parsed = True
+
             actstr = actstr[strspn(actstr, ", ") :]
             while parencount > 0:
                 parencount -= 1
-- 
2.45.2


