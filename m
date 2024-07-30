Return-Path: <linux-kernel+bounces-266893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CEF94091C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FF12844CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1584118EFF3;
	Tue, 30 Jul 2024 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fnk/43Go"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF9C150981
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323482; cv=none; b=WrdFSLm0Rh0RiizivrmGyOQkJK6sO+/ljGcUBAMqflXP1Zshzzd4s5xKJ2RkTDrF9MSxVIPUHHkxwS6r37a+ONX7yfumOFlg7pjEKVFvZrhcuSunRch77DCZuZ8JTrlhgP5UX5S31wlQP8yjsmizguwJSnqBf9/1hzmy1Babbvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323482; c=relaxed/simple;
	bh=GEPj04JmoCgXOe4WCmAyy3NgAbiGw36D79b9P5r4TRs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=mF85GU7OH52MoZmxr0vP3dijMQUzqTQTAFldRT2UPrqHUj74qBljRQR/vHtwuTlYfkE+ZwPaM6Y5/1iYtZF9SN2u8cx1wtoFH4CPDOi5aq2OSukohVIPbSEOiqlyC9LPEpwQRmLm5AMF3jLZZP7cv2wSREyLMoHSHNLAzmfDQSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fnk/43Go; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722323476; bh=hsKrDsbFmiXtekqhMmrRnCYwYxG76SWUBxZQ5Lytsdw=;
	h=From:To:Cc:Subject:Date;
	b=fnk/43GonYvpvTb8rHb2R/U6oStODxa4DaVbfqUHUsSEDOY2Wu0r8eP9qwMwvu3B2
	 4Y0F0f6ujKuyDXHg1PPHO0Xbj9QUx69cgAe1TH6uHhfyOlyy9/7BoCVxVXUVfe9Nl/
	 xYVunzwE3U/h2UQww9G3zY6rBsK0iulrKXaumTRk=
Received: from localhost.localdomain ([36.111.64.84])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 2CD88887; Tue, 30 Jul 2024 15:11:13 +0800
X-QQ-mid: xmsmtpt1722323473t9w32s7wc
Message-ID: <tencent_E2C5C1A1B50F453656C6C7FB140CD3AFB305@qq.com>
X-QQ-XMAILINFO: NAtipnnbTPea/lPgy65sokbF3GvXJm4tAMsp4fpZ/fjMmk0+iSyOefNnLNX+Or
	 8aFm017/+YZ8//41ds5NwMYcvX3EPMABaIF/wU8qrq607WNke7B2BGvFzLJLe3+bRv9n02QVWqEj
	 e7eTcJEB+V4RyqQYLWQ/W0cofRQmo3hRWi1GlzC9+x5mrLAP0RgkLhOv2h7t+R1YWUm3rXoqdjOy
	 LNa7u2ZBVlaAZYCvG9OL5KaOEPU+sxER/iQLVR6f57Zt4NPbYdeXkEMhPukNt5lG7aAdO46mOjH/
	 6SxcVtOosmy4/MOWyYRc/wo7If5DrgHaxNU0WHg7nSa8bvTXod7PdaEO3WjT4lF2WG+Smvp0gUBW
	 ttxENTjZKDJH67QAeS4PlDQkV4fPCbeJcaHcDVFOLU1hQBsWgRRAMIye9CoJh17yVmpEyHV9gmXv
	 AAFHNyMX0IuQuboPnGDTiQeoKoFfP93cJAvbNYlpJB/QEWExPhV+Yrsf9bMvTlS37Dray8a+aGGk
	 U0Sa6nIK+I+1i7MLti7H1Kmj++x1wRU6blEhGec6ARZPFHj4fheYK6Qvx4pl+DR5QyxeyuwKg/DR
	 iAoFDt3zClvxCkanhcv/q0JmptM0UtsWobUmgfoRdG3Pg+8rZx2NbyX1yPZg1sEOK4cPDXcnW3f4
	 qzxcvqAwJLj8M3etLO98VuiOat9wBBRE1am8esMVgyADv1S4Jwp29+QMaS2kSLE8gABwCHPTiLzQ
	 VPr+/BO2AF6r9I+sXBmzRQfRlBlJFVTR5kn7c3F5/BSnuOOS6lvSxq3HnkUON717ZJ/303Q40VeD
	 FdBrRcrAv+u2wZY5MuUC3JEOSp47/YBhOTKkGP5J07562Jky2sExwMzek2amB+vEvuCKeFz6utj4
	 o6ARJyyYL2yFl+ddL0Z9UshckWdEuWYz7igO9mVwRyt8LpaOO8wENdiOoAnQxXQouyzwmYQ77Ix+
	 xjOqu1oK3Wg0YSbtL62RVZp/MUULoWzJFGq4AJrlreAL7iEb7NEg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: wujing <realwujing@qq.com>
To: mingo@redhat.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	dongml2@chinatelecom.cn,
	wujing <realwujing@qq.com>,
	QiLiang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH] sched/fair: Correct CPU selection from isolated domain
Date: Tue, 30 Jul 2024 15:10:50 +0800
X-OQ-MSGID: <20240730071050.78478-1-realwujing@qq.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We encountered an issue where the kernel thread `ksmd` runs on the PMD
dedicated isolated core, leading to high latency in OVS packets.

Upon analysis, we discovered that this is caused by the current
select_idle_smt() function not taking the sched_domain mask into account.

Kernel version: linux-4.19.y

Signed-off-by: wujing <realwujing@qq.com>
Signed-off-by: QiLiang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 09f82c84474b..0950cabfc1d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6171,7 +6171,8 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 		return -1;
 
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+		if (!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
+			!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
 		if (available_idle_cpu(cpu))
 			return cpu;
-- 
2.45.2


