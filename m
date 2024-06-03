Return-Path: <linux-kernel+bounces-199584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 784E28D8918
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02001C22DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7A213A3F4;
	Mon,  3 Jun 2024 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fy2w9xqe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223E139D04
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441043; cv=none; b=lQrcE0pKGo2HnWSB9rWcwHapW4ZagNh0kbPvTxp39a09VwHbO9dRkbi71b8YOAVd1XlJ9iQSC+tmjX2nHsdIXQ0erhYEWpRDWc30RGyGtwMUxVnMxD75GQ0nkq/0AC1j5QAn9ie82IxhPci79P7PSSNxFw/hzSmAP3H9vS1P1II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441043; c=relaxed/simple;
	bh=yM5qseCWt564Cmf039ulCGk2NlpYr8Eqlkdgkt1H3Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8gWOQqkYvBRwkwIcdgnHxFR6NTu3TccuzvG3K3q4yU8a4kIL7z7cHioJz8zPvqVUYA/NUHVL3fiGKY8BkJfUSzook5252e53opWuujz32am3WiAU6PMjw71MIrjI5A3BTu2OB+ppb7GooXTDyZzewBPIku/c1E1mU6j6CUpg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fy2w9xqe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717441041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CzlCyA1y81ZtK6UbQuoaGFwW2RItiC/hGJ5T4RGkSU=;
	b=fy2w9xqewHrGjwUYyo6DL3w6QV7lkpV/eIUlN4ywaPdMIODpnuydKnxglDBTkvcTmu9Qiu
	4hcuO8hT6naDni7fOI+3sDNCvs++XyRd93GtmpbUgLPoazaLT5MtQGFY9Ox4fKYScDelcy
	tHZp8rS2M0R6DuSvnTqBs1ybPUqoKsc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-IqIftfUPOlqDpI0MlbJ9sA-1; Mon,
 03 Jun 2024 14:57:15 -0400
X-MC-Unique: IqIftfUPOlqDpI0MlbJ9sA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB1DC191DAE1;
	Mon,  3 Jun 2024 18:57:13 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C073418B916A;
	Mon,  3 Jun 2024 18:56:58 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/9] net: sched: act_sample: add action cookie to sample
Date: Mon,  3 Jun 2024 20:56:36 +0200
Message-ID: <20240603185647.2310748-3-amorenoz@redhat.com>
In-Reply-To: <20240603185647.2310748-1-amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If the action has a user_cookie, pass it along to the sample so it can
be easily identified.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/sched/act_sample.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
index a69b53d54039..5c3f86ec964a 100644
--- a/net/sched/act_sample.c
+++ b/net/sched/act_sample.c
@@ -165,9 +165,11 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
 				     const struct tc_action *a,
 				     struct tcf_result *res)
 {
+	u8 cookie_data[TC_COOKIE_MAX_SIZE] = {};
 	struct tcf_sample *s = to_sample(a);
 	struct psample_group *psample_group;
 	struct psample_metadata md = {};
+	struct tc_cookie *user_cookie;
 	int retval;
 
 	tcf_lastuse_update(&s->tcf_tm);
@@ -189,6 +191,16 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
 		if (skb_at_tc_ingress(skb) && tcf_sample_dev_ok_push(skb->dev))
 			skb_push(skb, skb->mac_len);
 
+		rcu_read_lock();
+		user_cookie = rcu_dereference(a->user_cookie);
+		if (user_cookie) {
+			memcpy(cookie_data, user_cookie->data,
+			       user_cookie->len);
+			md.user_cookie = cookie_data;
+			md.user_cookie_len = user_cookie->len;
+		}
+		rcu_read_unlock();
+
 		md.trunc_size = s->truncate ? s->trunc_size : skb->len;
 		psample_sample_packet(psample_group, skb, s->rate, &md);
 
-- 
2.45.1


