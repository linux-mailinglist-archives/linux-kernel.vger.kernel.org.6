Return-Path: <linux-kernel+bounces-287090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 417389522CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751EB1C21C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87561BE876;
	Wed, 14 Aug 2024 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="GITHaWje"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77398370
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665001; cv=none; b=FwRMCPVqezKZE6HjJYrK5k/jcFRTdg55iD1eixB1JCvmPTzMPI2ESntFNKPfQEfwZ9+Aflmoy1t55q6MtVTmkDKzEOFItZTZfgsbg1QTQws39DbymAlpeksK8J1lQdVqq4m11vAvkwzbWlmfS4wyYpAtOGkGBsdGdMHLU1+mNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665001; c=relaxed/simple;
	bh=uNGDtklnyXrgX227pyk2/PduqBSORZuNKm1ZBFTIwMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uzWARwNrenmygwd8Aisc7H1x/W2CSmiNRiF30y73QEyL9OJ5z1JeQy0WpwTxCQH2ZFlgDv0uOMlm+bHaC3cY3Jijqr4vRRgSRqYyaDAU+CrHog9teJFtFPXbRbx07Y6hXtwTIkI2KDpCGsPNEd3P6VmLaeYBUAj8Pb790Ojry44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=GITHaWje; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281c164408so989185e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723664998; x=1724269798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7z7h8zcOW+FCbWugSVIr3pP+RsvDPXO9smknTWuYPI4=;
        b=GITHaWjelHTGNFsdqVYeUZ7bOiOxXaWKtVM21SodJFXsfgnAlsCrTLHuJuZ2nh+1fR
         qESf9kh5HrrUAWEhlPWZYY7WOmUwZVtKPtZST9/uM1kSDbptMGaqRjVp1/WvkmWnW4kA
         iYkf8SVXh8JypoJAciF6M04LKpYP0oPPAai/xjbSae3boATGq0clBsEB04SJV38hjQwV
         9p+i/c8ChvJk2ewd8G31SKS0ggbghXr75YimDWOtOe7rStuNaF0SPf2q6wexXSJi/dTl
         T0rrY4tHAXiwQMdzno4PY3KWE16z5t2GszHD1FpuM0mOLJbccnkvW3/XbFF5LNsoCz4B
         i7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723664998; x=1724269798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7z7h8zcOW+FCbWugSVIr3pP+RsvDPXO9smknTWuYPI4=;
        b=rLtewaGijLd2Ee4BFtsDNNQDu52PxybRRgTrIeHIfbp0W2ZHN5f3hyjD65ihIeeV7W
         PDdj2IjH3YkFuTTHKd5YmqnS0cL+m2QrDEJpZj2q1MabfUht8e7WAZGELRQkWdpDjLVW
         mIWhqfbRdTNhdiLhp3dg69MnFX7a9QgVTPRkodunDA/b1ko6oSn8W9WLgEZskAGDLnrK
         +yTBFL8qb6oghcXB3rdxXq4VNLlduHYVxJHEoYeGI2XEINsaMrf8A3Vh/87hcUPf7gY+
         Cdyju3U4OCJ31BttHm/TaRCtb6yhw0xRQ+srqS6WXL/doQcoqarxeirRTZlR3lXkJMDb
         c8Og==
X-Forwarded-Encrypted: i=1; AJvYcCULW8hzs2JmRNlMhTzh+8V2udcIka3Ya9HExZuMhEnlepY0A/iB7dd/iSWmQVHbeH0FX4fmSqvDxDyII/SkBvii5bNKT96EoEBMEbqm
X-Gm-Message-State: AOJu0YyPCBZhPWkh5204Z8ZH+C+vHUj7Mekd7CrxJeHXGtm9U9avq9DQ
	r8Xew8rdlpc8zzmn71bX1GmQGW8bqRt99izRVq7wEiQkQhtTG9xSS5TF9693S7A=
X-Google-Smtp-Source: AGHT+IGe2hj4C917Qi/gRbbGz9xJ9hOoCto7Uxc41LGCxi0afw8sSDza/B1LH/zFro4WwIkpA4BC/w==
X-Received: by 2002:a05:600c:1990:b0:426:6eb9:db07 with SMTP id 5b1f17b1804b1-429dd236c3bmr30316645e9.13.1723664997669;
        Wed, 14 Aug 2024 12:49:57 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded71ecdsm28300485e9.37.2024.08.14.12.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:49:57 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dinguyen@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] clk: socfpga: arria10: Optimize local variables in clk_pll_recalc_rate()
Date: Wed, 14 Aug 2024 21:49:38 +0200
Message-ID: <20240814194937.1868-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since readl() returns a u32, the local variable reg can also have the
data type u32. Furthermore, divf and divq are derived from reg and can
also be a u32.

Since do_div() casts the divisor to u32 anyway, changing the data type
of divq to u32 removes the following Coccinelle/coccicheck warning
reported by do_div.cocci:

  WARNING: do_div() does a 64-by-32 division, please consider using div64_ul instead

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/clk/socfpga/clk-pll-a10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-pll-a10.c b/drivers/clk/socfpga/clk-pll-a10.c
index b028f25c658a..62eed964c3d0 100644
--- a/drivers/clk/socfpga/clk-pll-a10.c
+++ b/drivers/clk/socfpga/clk-pll-a10.c
@@ -35,7 +35,7 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
 					 unsigned long parent_rate)
 {
 	struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
-	unsigned long divf, divq, reg;
+	u32 divf, divq, reg;
 	unsigned long long vco_freq;
 
 	/* read VCO1 reg for numerator and denominator */
-- 
2.45.2


