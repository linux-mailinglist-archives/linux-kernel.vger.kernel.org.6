Return-Path: <linux-kernel+bounces-247314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A6292CDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CDE281620
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CFC18F2FE;
	Wed, 10 Jul 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ch4Pts1w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07323C39
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602482; cv=none; b=g7CHXwgpmksMWa9Zh/B78DZAQkDeLB4N5VYl/t7pNa2EjBWYwjgjbPSAzm0SlVpJIPqbIMISlh4aCgXcpfBPoxWAvptfAxoUWIyukrh2hEZMU5I8Y4cMuNoiyyKhVXjWubcJhqKejjkR96w8sAW3W6FH1CrWTE8OhrjkIf61bK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602482; c=relaxed/simple;
	bh=PNr8+CnhM/2U7tIVgxUJ/2XYsvJvXzRxPg4eal0lEWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCGQxurVZ4Ia+TidncthZtSWwcjmlr81ilPHlRAIoopKD+I81fBBDEJ8FfIKvz0iLnvfJ04CPfj+Yo+OtT+aMCk4fodcSBOCt4DfuZn6AdPeSC+GuuWjXS4Be9qBwXYfERFxRjH6EJt3orfUMC7b3nmgqgDzIdTcpTSsf3Oywl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ch4Pts1w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720602479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1KleRwxeUd/xYw7yMlB9Pv44J4tuhsIQNdU/RRGJeFU=;
	b=ch4Pts1w7kh7SJx9uV1Ykgc6mdOxbHbzGb/5kJ9s6PWSg58YzjlPb3sy06du32ZaEO0Sud
	2y1wFBjEeUbEFw3AgFs4lu1muSXvy4iAsM8v3VJkg1sS5LmbQ51PDAByzYPJmz6OpNPXJy
	Nk14lPBrNNXev8ojt47oK9nzImbfYPk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-eaUg1uOYP4-Fmx3hGQtKtQ-1; Wed,
 10 Jul 2024 05:07:50 -0400
X-MC-Unique: eaUg1uOYP4-Fmx3hGQtKtQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A01A1955F44;
	Wed, 10 Jul 2024 09:07:48 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.91])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC07A3000181;
	Wed, 10 Jul 2024 09:07:44 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: psample: fix flag being set in wrong skb
Date: Wed, 10 Jul 2024 11:07:42 +0200
Message-ID: <20240710090742.1657606-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wrong
sk_buff.

Fix the error and make the input sk_buff pointer "const" so that it
doesn't happen again.

Also modify OVS psample test to verify the flag is properly emitted.

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


