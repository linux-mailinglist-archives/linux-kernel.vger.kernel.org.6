Return-Path: <linux-kernel+bounces-249107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A81592E6BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AAD1F277D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDF0167DB9;
	Thu, 11 Jul 2024 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r0C3YnWX"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1A115B964
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697292; cv=none; b=oO9W2OKB0w9NFe5/yjftWn5JEKn+Rpf4Y0dbRRGI3Q2QqU0BBt0MOLOKJUdpgktfo3hx18zk6WrPA9YvhoJwSwyZNX6aMnwEJobWGSdfrsP5zcf8CvAxzXFOVaVCAGhEmq1x2dCWn8KJbP7u2AhjkxXaoFhICZPfFKtDRxLoXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697292; c=relaxed/simple;
	bh=ue/D6aaMj20smtKi2jAbMVRAEMMLERO+XAiZ94XCja4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFkjT4+QuV6jK6xRqQEDBVOUg9F/NPlgKAnWR/06+hncB3PtLXvUq4j5d1ABXxm8b2kwc/vxDKUHpZ5RJg/bkFFilRdBzzWRH3ztrKAMHI1bICbN/vyk1aVLUX/j9lbijRnpwK5IeUtFgCbQl2THTZTxr+5oJMNRC2KOMT430uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r0C3YnWX; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48fefaf11f9so254244137.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720697289; x=1721302089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4IagqgBEWB1oo5Cqg5iaPlJgTTeYOkk6mC1e1sE7v8=;
        b=r0C3YnWXAJsxJkmItfRo5ybrRyuMf29JIRjN3bMrW9xlXMrtswSLUSom17XDNtRzH9
         LmtPZ8BBn1rHmF6lDTts+a0M2QsxbFHONkc9efTku7unyMx4zZnSNAI8INo94D8RchbU
         QeWaq/lrez2BxqO/WbFJXma/TRhVmalOHJfgUOTyBEMzpZEOIOmpFkSSR3I5fjwipDqg
         V4dNccCRMMt0jlGi/RyUdcIcHajUEKAWrvWFHY0jVse+zgHCwD30tYb886vIThPWG/Vf
         yWd3hO5IwugiPdYai51yqYEFqNRzxkpyElLz35sVHSUiZmjKAqn2E5jkM2a4v60cjj3c
         AiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720697289; x=1721302089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4IagqgBEWB1oo5Cqg5iaPlJgTTeYOkk6mC1e1sE7v8=;
        b=PtaNHqEKtQX7x0H7cLo/zfpy6AYEPEmZHTM6zoWfSA789SnoZbJhf4O9dCp8YBb/nJ
         bvZXB9ANpEzn/9DQIZaptbAQ8edPLHg33SLE+/3Jmgc4hrODakXFFNVMOg8VAE2VWM4U
         edK/zvyL3d4Br5xUFMosZAAmoJcvOL2E19FMWvW8Y5jKV5rlU/iDbJ/8Dc3ZbKYXy6uk
         XNQOfxd30T9oBBBP/oP2KphKjpBoTh6MkjxSSABIUKao3DIr5ifreDF492XOcuKLB5UD
         2k+Hzt1fWIobWyODBR7p+91W33x/sdZZds0EKeUe3jL+krrtqLwHiINzZmubB6QfjZoC
         uLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmRDh5Ku4exoH2m6DKkOTC3ywsf0byXGobOqz0PDzh/8r660psQ1o51fiWdm+Nd/YUQIeXTFJCsw52B0sIDvJ8qt+zoWf7dor3vRdb
X-Gm-Message-State: AOJu0YwfOot+xSJ3bExzZDGzBhSx4kFsy4FNtuouWGqYOxfn9XoGbpfG
	RALgTD/T9Zj1VlHLD6/Y9y6cx0BRMsWe+5+w5EJB/hChEkS6FOX8kXdF3swy/r8=
X-Google-Smtp-Source: AGHT+IE64NYEOMzUTR1HNV/M/f92iVl/wBjraeYffY438wDyec46/vZDcyXmkgrZkYcLIj4zwnmaVA==
X-Received: by 2002:a05:6102:38c6:b0:48f:9751:198b with SMTP id ada2fe7eead31-490321f8006mr9003557137.23.1720697289268;
        Thu, 11 Jul 2024 04:28:09 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b3d293sm29021281cf.25.2024.07.11.04.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:28:09 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: axi-pwmgen: add .max_register to regmap
Date: Thu, 11 Jul 2024 07:28:02 -0400
Message-ID: <20240711112803.3942189-2-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711112803.3942189-1-tgamblin@baylibre.com>
References: <20240711112803.3942189-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was missed in the basic driver and is useful for debug, so add it.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index aac4f395497b..3ad60edf20a5 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -51,6 +51,7 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.max_register = 0xFC,
 };
 
 static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.45.2


