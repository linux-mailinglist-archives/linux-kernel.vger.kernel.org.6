Return-Path: <linux-kernel+bounces-309713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE4966F91
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDD61C21B98
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06BF166F28;
	Sat, 31 Aug 2024 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lizxhwrv"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58511537BF;
	Sat, 31 Aug 2024 05:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725083837; cv=none; b=TjfG/DyOIHnuMyNyxzVrUdCmtMvRrlVppZdGPpb4oh0wj9JsN5t4USTWUPvYjypvaMPILs06wUdYYwMCt38E2ihE/7B+9I4mE+W3Ye5tF1p/vFoPWcgt7hZc/HtV0lukOf4w2umanc8xTO5/44veuly/o/GutRSiqQvAZ3sOOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725083837; c=relaxed/simple;
	bh=9su/Y9MlO6MXAM8Bt2sijpIlEdQJjfOz4vTGsWn3PGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9YoXOKmSKXEwRNk+haLZCRQwzVdEb0Dzf8wIQce9zFHNHZsGXbTGtzmqIjTbe8M3APXWALT3wdJ0S4txHa2HBn4CUPJJAPRomnLTvtQcPN4Aj84OmmATSYosGRaANh+tqirXaVDby4a6xf/C9c00LHsBnLQ0ObgBKAextN0riA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lizxhwrv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2053f6b8201so6749815ad.2;
        Fri, 30 Aug 2024 22:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725083835; x=1725688635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/aYPkj2NtDergsDX2rHe3JcKu2TUi+kPfkt+iApdo8=;
        b=lizxhwrvyx9UG7QH6eY9LZGFXYGfKuRnprzza2oeEAMJVhmy28gmrHUFWFk98vRJsg
         GK1J4mMVSBwq0GnwXbtBObjVM9aFM9MaqVDcg7+0wSNImdh64oWDBv88rIdSS97x8DYz
         Ob3XcDno4oiVos1XQIjtZmrKl1Rf9/QcYMwedsc1iao+qUAvcCQ57zNTh+etdCspo8Yx
         k86/+Bx8mtj4k6lpgIc3yHlbhyv8FpEA2EKGPuVhcHyOowf7fYSvv/PuVr0XakGioed7
         Ifko70kvvIWvQ7OK+749bmSQK1bvpO2SQLPESSZOSSwXkJ/KlStGWzUs58n8qUAPtVpd
         JB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725083835; x=1725688635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/aYPkj2NtDergsDX2rHe3JcKu2TUi+kPfkt+iApdo8=;
        b=gpo97sFH4JjoFgVLSki8pVFumrSc59m9OxfYv4F6jhO9SPmK10KKjX167o1c+48Oxp
         tMIWmEteE6KMusZIB01ewLs1E85CQh7OPwW5oQKdP8pBa0zeNRRqc6NtmH0ym529Lj2T
         6S05P8cgKBP1BY8XGwmJ2/lHGyUqPOAaqldLHYhAk/2tsffa/yf7Yc/+P3ZWYPtFUEop
         oZGl76fJ7XAElRL1nINMbkiCq2nM4fnbq6kjNvD44q7tMhnqRFflyEsfMp6EpfzsNLcc
         YYUuTSGW31oPY/xXjFjLZTn1F4GmFsVcunVd6TQrZC9BBC17ZB4Etal96hMjp21dPOFL
         nsRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzMr4Bg3F2fbDNjQJijJg8SQ1iSaBy0FJ2Din9kyBr19zokHVQNdI7bKh3k+5nesGszLbzgOUXiXv6aUxS@vger.kernel.org, AJvYcCXMpOdJMPN43OjeZW5Qyyns3lcHKiqXVv5bVkVqOfpJXwpsg1AGM2o+w6TuHVCMEqmCvmhXWw2fTIe5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx24t8eHi3vHWa+h54dKaoBXoRHCvSkt8g8PEyKYa1i7yBXS9rB
	x9corLti3YgUaLAZzTtlQE1Mc+rZ5fv0Y23fYKkQnMSEMBMcv88x
X-Google-Smtp-Source: AGHT+IGMvuTVKZ6LSJxB8CtCU4+d+sEou4o2/Fylk2vt34a2ffeFEJ4j/x7jh+K22k3uivREqt3WOA==
X-Received: by 2002:a17:902:d545:b0:1fd:9e6e:7c1f with SMTP id d9443c01a7336-20546b553bdmr14689055ad.56.1725083835095;
        Fri, 30 Aug 2024 22:57:15 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2053aa8cb4asm12027045ad.271.2024.08.30.22.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 22:57:14 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	konrad.dybcio@somainline.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 2/4] irqchip/apple-aic: Skip unnecessary setting of use_fast_ipi
Date: Sat, 31 Aug 2024 13:48:17 +0800
Message-ID: <20240831055605.3542-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240831055605.3542-1-towinchenmi@gmail.com>
References: <20240831055605.3542-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use_fast_ipi is true by default and there is no need to "enable" it.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/irqchip/irq-apple-aic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 5c534d9fd2b0..8d81d5fb3c50 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -987,9 +987,7 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	off += sizeof(u32) * (irqc->max_irq >> 5); /* MASK_CLR */
 	off += sizeof(u32) * (irqc->max_irq >> 5); /* HW_STATE */
 
-	if (irqc->info.fast_ipi)
-		static_branch_enable(&use_fast_ipi);
-	else
+	if (!irqc->info.fast_ipi)
 		static_branch_disable(&use_fast_ipi);
 
 	irqc->info.die_stride = off - start_off;
-- 
2.46.0


