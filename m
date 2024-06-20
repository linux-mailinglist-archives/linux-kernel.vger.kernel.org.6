Return-Path: <linux-kernel+bounces-221997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0791E90FB88
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F04D1C20F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BE61D556;
	Thu, 20 Jun 2024 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Dx+n6G+p"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9C134A8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853010; cv=none; b=GgVvzwy5ZClLMi1oJQk0bnJ4cnnbsShMnCVbYc2D6GCTH923O4muryrBIYmvwnqEqPRj6Ri/wYX5m9xwq86maGCsMZAr/IgMFT3yA4YshN0BP2JbxsIxQh+8jT/Td+mYE9gEjLkgGLy0LFDHuvzCy7Cxc3Y4vsOD839iW9igGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853010; c=relaxed/simple;
	bh=H1+biln5nPkedb0VFkQthLFDnNrRRqfIHiuLSlxSfI4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=lweUfhnmSOFXuRg8f+D0nqa69/NRMlIAW79pLfBnVzttqf21+/RQRmo5o+MiVFFc5ZlOKDFlOJlqt3KhO891StyZGFE8sLSK6XdZSoInDdoT7lRCPSGjVMawvmnCyjAwOf329RxQ0tbARC+GvrII0DInbkY/s5lWIE1CNZTkRho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Dx+n6G+p; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718852685; bh=MvLnBQtWyz44qgWyFen+YAfvkf/NA5LiTAc+ar/gjwc=;
	h=From:To:Cc:Subject:Date;
	b=Dx+n6G+p5vKiPV6thBEC4kK3X9IRgtbMPh6ZjOd3Z4Jz/KXU+XxZM1wgFVM5mL/SX
	 AB0IAdoaZDzbrGNVp0fcx617NCG//7DAAY5SWUeJiKlnIePNSR1ApshzbXu9MekS4Q
	 qb+ZFaGSfmTEPyd14eSy4DA4ibA7L83s5aLgABIo=
Received: from Yangyus-MBP.lan ([2408:8207:18a1:970f:f545:a993:a6:36e4])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 12A15E7E; Thu, 20 Jun 2024 11:04:42 +0800
X-QQ-mid: xmsmtpt1718852682txuyjzpm5
Message-ID: <tencent_7B71486CE305DF8AE084B6BB6313EE550C06@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8uL2HVuJBhrdaCUDh1ERnAUZ8/tYbi4vw0i8bJKcrZyMIbx3h8c
	 dMmP4OuYNT7Vsvpcb6lzbOmrbWPOqdnRmbRcYOXbbQ0Y3V0Vv7QFx1mQN1j/FTxSbPq5npDj2f91
	 HODXYEunqsrMHTRPqRfLg1A6hsPz+a0c30zMb/2OzdpnaL2BhNmyJmUN+HqgE2IZlUmJeN6A0XVQ
	 Po4NW30aUHKQlcW8waIC2WT0ss/Ws5PfmXCz8R8re1ibKdaGtd7Vt05M48o9LCIgdTYbLDyV25yj
	 t4fReppM1slQwKzwma/EOZyXZe/9K2qglOhoQ+RoI9C5VSaylVbpuelSECOGOU2jAtUEXHmFVE8R
	 qcURW5QDkdbxdo5eFvr9NC9M3JiEMHX/lEfW2VQVu9kPGj4kMzjQlQhL2eoarms2U0U5HiEZ6pVJ
	 pOj83xD+Jg6sbkwv8ekYNzhKKN9YCJr4h6m6SErK6JcxxPaLL7ziTK0jqp2fAzCcpglJzFHfyODD
	 gozJjUB/P7ckIq3tXKz1G0PzpH2pxhRikm7+6lAu1vp6/kafvuqJXi2xJZlMZhJjkX0rDqlb8yJb
	 /PILJKw5H3wj0kBBl7VxHqZsOMHbEog4h9rc4R6MMpwKFsKD7spDBdUMyE81+sgHxcxXBF9dsAh4
	 bMrHD8AncHgbRJmRl8Zj4yCgzEYLcFXrJdFUZ5rg/k6syi3cT5hqNlnh03L3XTE/zUc6/t/j+6/s
	 lLQAu9ekA3rZ4PaVQM5Kaxoqwk7+4y2NOFZfvjNsGr3A2jas+okPXJMmeDLDIZzU/zoyyHoDehNS
	 IRVOAxmRZWGWwU+js7OIRqk8LcO941U1CFXyN35KlN8LjiorWZF887nYbz4d7kwCzo+L3AKwKXWy
	 oWg8mdSr7jY+Q5/oTD4rJWJYvdd1p+9tOrw1IyQldM2pCpGpxmWjBHib1tTqIDcl4+iY+/Ir96uJ
	 88b4uZ8kNzV4edFHgfTpmR9mLQDKPtr7/ui/HP3PQcW2kkHiTtradwtciQIOFr
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>,
	Asahi Lina <lina@asahilina.net>,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v1] drivers/perf: apple_m1: fix affinity table for event 0x96 and 0x9b
Date: Thu, 20 Jun 2024 11:04:28 +0800
X-OQ-MSGID: <20240620030428.1832-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Events 0x96 and 0x9b can be installed on counter 7 only. Fix this to avoid
getting the wrong counter value.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 drivers/perf/apple_m1_cpu_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index f322e5ca1114..b8127e5428e1 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -107,12 +107,12 @@ static const u16 m1_pmu_event_affinity[M1_PMU_PERFCTR_LAST + 1] = {
 	[M1_PMU_PERFCTR_UNKNOWN_93]	= ONLY_5_6_7,
 	[M1_PMU_PERFCTR_UNKNOWN_94]	= ONLY_5_6_7,
 	[M1_PMU_PERFCTR_UNKNOWN_95]	= ONLY_5_6_7,
-	[M1_PMU_PERFCTR_UNKNOWN_96]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_96]	= BIT(7),
 	[M1_PMU_PERFCTR_UNKNOWN_97]	= BIT(7),
 	[M1_PMU_PERFCTR_UNKNOWN_98]	= ONLY_5_6_7,
 	[M1_PMU_PERFCTR_UNKNOWN_99]	= ONLY_5_6_7,
 	[M1_PMU_PERFCTR_UNKNOWN_9a]	= BIT(7),
-	[M1_PMU_PERFCTR_UNKNOWN_9b]	= ONLY_5_6_7,
+	[M1_PMU_PERFCTR_UNKNOWN_9b]	= BIT(7),
 	[M1_PMU_PERFCTR_UNKNOWN_9c]	= ONLY_5_6_7,
 	[M1_PMU_PERFCTR_UNKNOWN_9f]	= BIT(7),
 	[M1_PMU_PERFCTR_UNKNOWN_bf]	= ONLY_5_6_7,
-- 
2.45.1


