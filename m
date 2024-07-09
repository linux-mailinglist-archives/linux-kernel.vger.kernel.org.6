Return-Path: <linux-kernel+bounces-246057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C43292BD1F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADEBB272D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8353719E7F8;
	Tue,  9 Jul 2024 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfwwOy8j"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC319E7E2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535760; cv=none; b=u81Zdq/yW56leI1nfiJGAbKPkcshgTbglbKrwmowBjoNXvkTAa8W5/cd/nx+c7P+QtYbaZ8s9jYEUzrltkAsi7HB4zEtfRLqLTb1DACJl6rYOVtYd9KK2DXCM6i6Dv1B/FQevB2/ZxbLoOn3Zxv+i5snqW1CuhMGxBZrg9ECqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535760; c=relaxed/simple;
	bh=iuF5P7QdVZM0rmEN+/T2h0jV/gqPV2iphoX9QOof5BY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F6MUuWlWBEuDheCOB87mtRb0tAKk3HQq0X8dYmRszSWcdQDK2O55HrqXBtOVV97zoVxTloumHGl72jhRVRfHH/ELbuoTpuzLd5IbHePPKLBYHsK9KJ7TJ8d5o459aFrhc/rqJpmBFYekMfRaR8IteNdFoSqeKALytjkdTd3pNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfwwOy8j; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-48ff70394fbso1498300137.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720535758; x=1721140558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PjX1xL+hMVlCmCMu07z260TgAr+cz1WYtrqWTblIH4Y=;
        b=GfwwOy8jRGPLVMED84WD/ed29bGW7cySY1MUMKhd+LlZ5eHb28jSn2WT+vYEmJm9bG
         f+Q6qw+QXr3QK0LS2jQP054lnmvrN2sMMmJFJMcvMi9+Z1GHjgUnXM+R/udEWDTC/T52
         UYivncDFYDdZhh7n0OZNOFq1ET1dEE72xdf2iF8c2oxjhECzW7f6FZkR0f4pUjbIGAHe
         /JGoONdyEH2+Fu92nkzuUlHscZWYv8mXJUKeZS3vsFA0d1Jt29T+XOzKyMhp4QByBKOI
         GCn6WbyDxgo74n38FKorS4QW+IxKeK0SrTHLICjHIkDxdj+h5LTbE7McMqsES/EgziCE
         uuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720535758; x=1721140558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjX1xL+hMVlCmCMu07z260TgAr+cz1WYtrqWTblIH4Y=;
        b=JRJ+zZPsefJyCNomOSCGgmSXBS5fDueZgiH5guCpuVIRETGEvnRKQ0FEqs9VhXgr6+
         +fWjwdRAZkz1sQGR2HOountsQMatsMOlwBEGab3z3ohKnOnn9XSRh2wyxmY935CMyaxf
         Bs9yA639QvmXIi2+6py2bnIjtRzfqesO5BACofnhqjjU1XOCvb2VQ3xhrK7MJFJeH1zg
         nbaJM4Z68RU77YQgpiFhhhaQeOMMoXjGb6VyLW3VFe7tiM1ZZtlBQeUUIR9B1UXp5yN3
         T0KvAO6PJg+X8vcX36394E2Ldg5Fq2kg35le15bJwgQS4VAZpSu/SKP3HfQb6Yf4ttow
         JYlA==
X-Forwarded-Encrypted: i=1; AJvYcCV3uzohOBAqY5wxgs3b1Zk4oGll2M3+DTfh4FrJyrj/qRCBXBrJj+oXVF9zhPsfjkK88FJ3zUp2a2r8K/zbu/oIyC2HBkIMsrj37IIJ
X-Gm-Message-State: AOJu0Yy3z3jbIWBB5bGtg4KzJaX23PJ5H4Qkf5eu9dvenEqVCNM9fjX4
	Vtrsv5zw6MnGOgPWZhXxJURLcz2hKI44bbmporoqXvJcXK6XdlWu
X-Google-Smtp-Source: AGHT+IEcptUClsIFM9Md/kEl1v3WWdt35t46lG9y2rbzIy4j3iWxnuXi+HjMva0kISYK813NU5SPaQ==
X-Received: by 2002:a05:6122:14b:b0:4f3:45b2:b757 with SMTP id 71dfb90a1353d-4f345b2c180mr1459069e0c.14.1720535758232;
        Tue, 09 Jul 2024 07:35:58 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-490313bead5sm383447137.4.2024.07.09.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:35:57 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: David Hunter <david.hunter.linux@gmail.com>,
	julia.lawall@inria.fr,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH] powerpc-km82xx.c: replace of_node_put with __free improves cleanup
Date: Tue,  9 Jul 2024 10:35:53 -0400
Message-Id: <20240709143553.117053-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of the __free function allows the cleanup to be based on scope
instead of on another function called later. This makes the cleanup
automatic and less susceptible to errors later.

This code was compiled without errors or warnings.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
 arch/powerpc/platforms/82xx/km82xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/km82xx.c b/arch/powerpc/platforms/82xx/km82xx.c
index c86da3f2b74b..5791c9c5acd0 100644
--- a/arch/powerpc/platforms/82xx/km82xx.c
+++ b/arch/powerpc/platforms/82xx/km82xx.c
@@ -27,15 +27,15 @@
 
 static void __init km82xx_pic_init(void)
 {
-	struct device_node *np = of_find_compatible_node(NULL, NULL,
-							"fsl,pq2-pic");
+	struct device_node *np __free(device_node) = of_find_compatible_node(NULL,
+									     NULL,
+									     "fsl,pq2-pic");
 	if (!np) {
 		pr_err("PIC init: can not find cpm-pic node\n");
 		return;
 	}
 
 	cpm2_pic_init(np);
-	of_node_put(np);
 }
 
 struct cpm_pin {
-- 
2.34.1


