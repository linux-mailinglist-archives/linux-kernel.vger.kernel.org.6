Return-Path: <linux-kernel+bounces-268566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE3E942649
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA2B1F2564A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CC116087B;
	Wed, 31 Jul 2024 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="nlIc327F"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B084161313
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406503; cv=none; b=JJRKrx/Du1HTaLnc13xiuui/PhL1e99/fwAUpDRLG/F0JBRqfrCV34dMbKgAkICzXmpe9cnqq1PjQmWEFtQZSWN1VldN3PZoE4jWhB2k5qrLkcQKDLny8+dZ/nB3VjDOPVdZLIETryIf6FO+ubHQD+XKtyWQoJHXb2T9d4LpPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406503; c=relaxed/simple;
	bh=3qhd4SE6YoyKmVa0gQyG4Is1h6oEVGw8BykU91343Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z3sRm+V8jOTb9MTw8ddZ3FISe6Gy/+abkfQOaVS1edwGQcJINv4H5evZvfXHxeL5rhB5AJlK8j7og1mw05s9cHhh6nKYPu+kzh6tAF2LTEPRP6ukpzTpMEHSeHtbD2S7GuNCEaym/6gRSxx4ZqSuqWvxHc/2cZjR9P8gpa/EU+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=nlIc327F; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc692abba4so37464585ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1722406501; x=1723011301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mC3tXuwifMCr47H/ReF2rBsHBnKM2KWjJi3hvYggrH8=;
        b=nlIc327F9hPlv+ofO2AdpPmDRyN526KjxIhTA2mFsoGuFlQ6ALR727I4VSefxLgRqj
         TZUbR8ekRzG7xFpJWuXPyH+5wKmvsalVznjipfenGBtuD1ZG/iph4MU20ThaQXwbakaM
         Q5Hx9MfQuZ7swxnN3QVZlISeYm20sA9Wr1Akoe9B1a6j6xK4CN+waqAgvJ6hkw4nZ3O9
         +psZkTHRp5EihIcLsulS0Da11DAaa8kEgSOs5g2KYsx/9XSLiwbybXoOwuSUV0dzmiHv
         DKSWxk5dA8IkU3FHcjiv3qu/ip1JDaORce7s9sdZz2dKJ6lZ67gVtW+XU9TL5OrtwNf9
         nMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722406501; x=1723011301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mC3tXuwifMCr47H/ReF2rBsHBnKM2KWjJi3hvYggrH8=;
        b=QfcYQ4FBqryAxhctXayWeljsqw+wwapmgganG6GogtU7Aqvy7/zm3Ro9/o2y5bIzgj
         n40bKZ6cvHamE4LOvXUUn43wcYzG42YnfoPTm5ABp418izmoDxX8puUMkBi3ggTM+/MT
         GOKnlMyyxlZO0qe9lcwdZggpLuZ/CDzkUE7ayJiaRMd+dd8ElKURrRQo7q48w29KfXAP
         z+AdyJOiuMWj5PW/gO3qEnO0Rp6IVL2O+JYH0TZ+M+O+JUH0FIqZDPdCraXgEeQVlHB4
         TA1DDL7gc0iikeTvMzDfWwg2OMtsEWpQYB9vPZUQ7RYVN15mo3mjYhnR5tAiMpvjrQ0k
         p71g==
X-Forwarded-Encrypted: i=1; AJvYcCU8OeNzhyGB3f7A/flrG7GE8HcPGZE3KNWQn/m5+IjbDheAarQFedcC5aJ0mBP2yoNLAs4Q67urIV+nWPhBTLZI4xxTZT7WCTtEtI5+
X-Gm-Message-State: AOJu0Yxfz4ikdQHYkPVtNBBK0xPWeJ8OX21YVyk3B9o9TA6Ca42yeRxd
	xzKiN48nZrzXfijPXBf6Ih00VpDzuJUhLjEUDXmA4cYd/Exo0Qu+ZySTpczMSf0=
X-Google-Smtp-Source: AGHT+IHAm8yRTbqgNkd3W/umYT9moh5/2wBAdYnIzsqz4npYm9ETZcWZ1wL+JK+URtWlkoJNxI+00w==
X-Received: by 2002:a17:902:ce0d:b0:1fd:a360:446f with SMTP id d9443c01a7336-1ff048afb6dmr108366915ad.65.1722406501309;
        Tue, 30 Jul 2024 23:15:01 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1802:170:4520:8165:b9e7:a203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fff8sm112384435ad.53.2024.07.30.23.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 23:15:00 -0700 (PDT)
From: Drew Fustini <drew@pdp7.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Drew Fustini <drew@pdp7.com>
Subject: [PATCH] clk: thead: fix dependency on clk_ignore_unused
Date: Tue, 30 Jul 2024 23:14:40 -0700
Message-Id: <20240731061439.3807172-1-drew@pdp7.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597; i=drew@pdp7.com; h=from:subject; bh=3qhd4SE6YoyKmVa0gQyG4Is1h6oEVGw8BykU91343Uw=; b=owGbwMvMwCF2+43O4ZsaG3kYT6slMaStvOZ/XWZz2cX5vivMZj5qWLAguf/bGbbNAdUbj0otr lFsVJN/31HKwiDGwSArpsiy6UPehSVeoV8XzH+xDWYOKxPIEAYuTgGYiNprhn/K3J2smRu/PufJ OrJz25NFps82VTE6uLhX/Evbd53357dKRoaLzjcCUovLf6TmbpuoMcP+pAvTlonTri6+GDuZL7R e7DIPAA==
X-Developer-Key: i=drew@pdp7.com; a=openpgp; fpr=1B6F948213EA489734F3997035D5CD577C1E6010
Content-Transfer-Encoding: 8bit

Add the CLK_IGNORE_UNUSED flag to the vp-axi clock (CLK_VP_AXI) to avoid
depending on clk_ignore_unused in the cmdline. Without this fix, the
emmc-sdio clock (CLK_EMMC_SDIO) fails to work after vp-axi is disabled.

Signed-off-by: Drew Fustini <drew@pdp7.com>
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b 

This is based on v6.11-rc1. I've been reviewing the TH1520 System User
Manual [1] and I am uncertain why "vp-axi" affects "emmc-sdio":

 - EMMC_SDIO_REF_CLK_EN is bit 30 in PERI_CLK_CFG (offset 0x204)
 - VPSYS_AXI_ACLK_EN is bit 15 in VPSYS_CLK_CFG (offsset 0x1e0)

I don't see any linkage between them in the public documentation.
However, the addition of the CLK_IGNORE_UNUSED flag to "vp-axi" does fix
the boot failure when clk_ignore_unused is not used.

I've pushed a branch that has the dts branches on top of this patch [2].

[1] https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
[2] https://github.com/pdp7/linux/tree/th1520-fix-clk_ignore_unused

 drivers/clk/thead/clk-th1520-ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index cbc176b27c09..17e32ae08720 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -738,7 +738,7 @@ static struct ccu_div vp_axi_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_HW("vp-axi",
 					      video_pll_clk_parent,
 					      &ccu_div_ops,
-					      0),
+					      CLK_IGNORE_UNUSED),
 	},
 };
 
-- 
2.34.1


