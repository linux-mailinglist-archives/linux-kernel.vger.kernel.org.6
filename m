Return-Path: <linux-kernel+bounces-247999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BA792D730
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C3AB208AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961B4194C73;
	Wed, 10 Jul 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2maEPyu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E912E19249E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631417; cv=none; b=QclSZ9hOI2L/8IWNnWDM/EhpskqvwER+iANo+FHQ0/MM9hSycFPgVOr/pV7zvTRqnYx/EuCtKD+23TZxvnah6efgZDtZVh00AhSL9Pi2laQGU9Y0P1G5o7D6W23ZpyJaPzJu5gJkqN0f7yaB9sYrui1thJvjSbQgWSVpo5J9EFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631417; c=relaxed/simple;
	bh=YJePqKbJhayPCJzvOtfPEL+ouvYJMXaz/kpQzC0kJSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyYN3dMhjrQW5LlSAxMAM++OAK/xqtfrYk3uHOSFLYcUhq5JIDs4IdUKMbkaItmiqeweB89Z0NN0tbADVE80BRv8T+v+uLiucR51yG2T4Q+gUqNFMrUCbqi2VQeCoiklhoipE1sadjM26j2EWzGwkPHf9wmB0uwWjiH8F19fNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2maEPyu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720631415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mcy+wNIe0q9N+oqBLiAPk19+fhTgEc8OMbZkXd8L5aw=;
	b=i2maEPyuRkC8slRdC6dxEaj2p66sV7GQjce+oZuDNlz4w9XLkMnJrlY49Ys5ktAhRdQXOA
	vB5V18c6AOZDiGHjcory+oW7Pj8Qt0wQee88A5KB0uouldfnXMVMGO3VwgKrmyzs7mqN6N
	CoxznjTZpFDnFdmFltx8NMA2H5MBKFQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-oJIOfG6xPd2r_6j8ARAhnA-1; Wed,
 10 Jul 2024 13:10:11 -0400
X-MC-Unique: oJIOfG6xPd2r_6j8ARAhnA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BE38196E01A;
	Wed, 10 Jul 2024 17:10:10 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.91])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5CCF1955F3B;
	Wed, 10 Jul 2024 17:10:06 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: psample: fix flag being set in wrong skb
Date: Wed, 10 Jul 2024 19:10:04 +0200
Message-ID: <20240710171004.2164034-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wrong
sk_buff.

Fix the error and make the input sk_buff pointer "const" so that it
doesn't happen again.

Acked-by: Eelco Chaudron <echaudro@redhat.com>
Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/net/psample.h | 8 +++++---
 net/psample/psample.c | 7 ++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/net/psample.h b/include/net/psample.h
index c52e9ebd88dd..5071b5fc2b59 100644
--- a/include/net/psample.h
+++ b/include/net/psample.h
@@ -38,13 +38,15 @@ struct sk_buff;
 
 #if IS_ENABLED(CONFIG_PSAMPLE)
 
-void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
-			   u32 sample_rate, const struct psample_metadata *md);
+void psample_sample_packet(struct psample_group *group,
+			   const struct sk_buff *skb, u32 sample_rate,
+			   const struct psample_metadata *md);
 
 #else
 
 static inline void psample_sample_packet(struct psample_group *group,
-					 struct sk_buff *skb, u32 sample_rate,
+					 const struct sk_buff *skb,
+					 u32 sample_rate,
 					 const struct psample_metadata *md)
 {
 }
diff --git a/net/psample/psample.c b/net/psample/psample.c
index f48b5b9cd409..a0ddae8a65f9 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -360,8 +360,9 @@ static int psample_tunnel_meta_len(struct ip_tunnel_info *tun_info)
 }
 #endif
 
-void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
-			   u32 sample_rate, const struct psample_metadata *md)
+void psample_sample_packet(struct psample_group *group,
+			   const struct sk_buff *skb, u32 sample_rate,
+			   const struct psample_metadata *md)
 {
 	ktime_t tstamp = ktime_get_real();
 	int out_ifindex = md->out_ifindex;
@@ -498,7 +499,7 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 		goto error;
 
 	if (md->rate_as_probability)
-		nla_put_flag(skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
+		nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
 
 	genlmsg_end(nl_skb, data);
 	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
-- 
2.45.2


