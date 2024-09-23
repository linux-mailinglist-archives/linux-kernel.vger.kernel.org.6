Return-Path: <linux-kernel+bounces-335444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA71C97E5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62163B20F25
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17D617597;
	Mon, 23 Sep 2024 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="EINMc9/f"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0860C171AF
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727071167; cv=none; b=Zu2MRz8nMufJQzje6RKKTpGRd2I5L1XSuNH2aF0mRs54SohPazrRLvDE+BJ0LOjTtHAH/wzMMz7LOkDqZtBb7bq1hI/92M46VYLpuIuH19VD6uy+F7Jj47MpoW2XdMLbN2VEW9IxLQbQeGEC4Gl3sCgEifnJtPwI5TTjr2Jfs+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727071167; c=relaxed/simple;
	bh=8Q5BWXK24teTd4/4sKSAQLQnF11r5s4GE28Y8H/LMBI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bWw6h+vvhq/KvAWfQBmScs+PRTBMDXNTqZE/tM3cyqgxbekVgLiLb9ObQj5EDb1q5b/Qvqm+LAg4whqFpEJ4EoI26L6PHo/zqDpv1OsurUTNG5jopsnycs1Km/JzYojcNlC5mhF9OIw+20XzF6Hit/mcbvSj9FjnEZkqF+BXoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=EINMc9/f; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1727070855;
	bh=/Jm3ihsi6kbPKFKGYfUVqcgUc5C1RRsOQArlQQYXQ7Y=;
	h=From:To:Cc:Subject:Date;
	b=EINMc9/flhPlqK8HnyhCrZHsOIVfuezlLp4oAabWGSZyncHtjAz1Yjc8XcN9UokEh
	 2xYg81/d7pk90a7/6PX1jICYx/oGma1VxAGRnbjIbJaZLOhQo3Vq2pI8XClaqmSSgO
	 VfTZbIUesHDno5nVHjhDlmZkFf1DWZJgMPhFz0F0=
Received: from localhost.localdomain ([113.57.176.32])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id D870A00E; Mon, 23 Sep 2024 13:54:07 +0800
X-QQ-mid: xmsmtpt1727070847tgcoskm69
Message-ID: <tencent_1EC4FAC68C2622C5B605B30A1F8E9DF1D809@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jFS+cwMcWDyk15aK4lFUyb1fU+KzeL9/AoLng5KMPOslqGVzWou
	 LrTRgY2K7nd9tJOehPSsaH2pv5aCV8lmmBlrFbr8AoHKF3mlmAu05s3/isJtHcIm6KUnx5IaAlq0
	 sSEKvSGescvlDr6Vo7DHJ0gMCLyiiMqcFBvaplj16rKtUZBuLDsaoul3zd7ahNS3lwQ9ruMG8ghe
	 D7IhEhiSYb/TzQLF0TlajbWfScrT+hWVx9z1SnDl5ErjoNdHcqf2JYHqKVOPIKzYUXKa9wPXGdOm
	 sh4qK51JPcmi/k0N5OX8grALde9UEK5JzwRY0lRrAqV0g9rAtIcvw9Rtua2YAXIA+irZ8/Jxghjr
	 EAQz2CB7frCMOusfSnW9GilXbqsqscyiQdvWXcne8vsC4PIYR24mRClJ9C2Q8AYJO8mr1wWGBt9O
	 QpRTm5NitX4p7BooKcIqof9gLlkIR6lrpVXhFH04psnUVrjvVPYIT7pxTiZZJ64hjINzIvSn05LE
	 NcTX0N2BoBzj6ER4M+D7Q6sUf2uQZnDdsaZ6375KsIUu1yD/h8P/HoirJjRHov77xdwPMebX5wKO
	 oR8czVLUqFbJv9P0PgoYODQ2+v03vGAf7C0H+jnSIL0Cp0rMQ3PWFue5cZyMfcxo6da0qdhKyUdh
	 yd4MftYybQ9SdREmm0PcCNf9Xwh6x1DzeoZfOsKRKJvWnVdbeEiF0avEq4LNTV+40GoQiQswjdpR
	 uPuCxrT6sVpwUiln48omkUVNSGV/KNVwvCJbLj8y9a1DZCFrBrn/XNTPQk/61JoBfZMadLZGaGjs
	 UxqXrG6k+n8gTK/Z5PPx+Vuh3hoflGDM1/meccD/S+Us2wMtmLaV+/45kB3iNnfH8CrpthTD7t2h
	 4fkQq2Q8etcW7RlQ7nwqxE2XxaikCWw0be3NFDFfAMNAMfviwHSEEkWNLm6/Vr7ZJRUsktSdgjz2
	 hdNAS+HyED05G96OFdAzDm+/RMWt6eprjoXPJJOFTBMoXfDke3+CffZZeNoylNjrHBRZY1pfpV5R
	 Vzd5qyC8rElyLSEI2VZTK76H+zCEViN4ruXuC2++dc5FZqD2sfMwiK2AfRCwgKz2OzhCfX5Q==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Canfeng Guo <gcf2000@foxmail.com>
To: mingo@redhat.com
Cc: peterz@infradead.org,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	Canfeng Guo <gcf2000@foxmail.com>
Subject: [PATCH] sched: Complete Renaming of scheduler_tick() to sched_tick()
Date: Mon, 23 Sep 2024 13:53:44 +0800
X-OQ-MSGID: <20240923055344.46618-1-gcf2000@foxmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scheduler_tick() was already renamed to sched_tick(), but this was missed.
The previous commit record can be found at
https://lore.kernel.org/all/Zer1o5bhkiq1cxaj@gmail.com/

Signed-off-by: Canfeng Guo <gcf2000@foxmail.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8dc9385f6da4..6866908a100b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12478,9 +12478,9 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 /*
  * This softirq handler is triggered via SCHED_SOFTIRQ from two places:
  *
- * - directly from the local scheduler_tick() for periodic load balancing
+ * - directly from the local sched_tick() for periodic load balancing
  *
- * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
+ * - indirectly from a remote sched_tick() for NOHZ idle balancing
  *   through the SMP cross-call nohz_csd_func()
  */
 static __latent_entropy void sched_balance_softirq(void)
-- 
2.20.1


