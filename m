Return-Path: <linux-kernel+bounces-548783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8F6A54959
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD16A1896789
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE40720B7FD;
	Thu,  6 Mar 2025 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AjAjpKvL"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143220B209
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260640; cv=none; b=M5Etb4T15UBEdPZwkLDyWM81+t+puIruHQeJMB3ToADhzqrl+FMcSgpFuVS28nBqn6zv0OXpNDezqJyDTLZ595/QV1vEPFDjvAEEzIRcny4r6y/sh3yH/64Wk3SSTPkNjPHl15FZyIe+4U3uWIwz7xiFERbXilC+dc6yRAU9A4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260640; c=relaxed/simple;
	bh=awl6YwE5UVjc3KUbwMt94afSEc7QEcOUZKoHgRnGp2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klSITALc8bjzETouHmeyFW2fbU1028WsMB9yzsmQCKOPlXhFXe2UgxlUG1O7DY8/6f3uSK1i5pbIXG9adinJqyNaCvgTwZMbWwp1k13uSlxjeefWvFElhwqcTk9ARhMUFObkqHXSsDwg1z16kS8KXJfXI9V+bgmDAxVWBGayvs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=AjAjpKvL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so3225545e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1741260635; x=1741865435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXAgzqp6YN1DpD4nDAOaVXpHZiShYKGqmKOr0HW9Cag=;
        b=AjAjpKvLWLpEZIn7P0jQL1vXOvTnP8I4QdvjtZ3swcP/0C1ZuykKdeCfsBSg5zqRGV
         enoj3LgG9LXLS1+OTxXyMLM45F6dZK/ySDIOee+3za0U3eVr6nHRHPVVzLiFP5gXqeBN
         uwEYJ6chZP2qthcmedbitPgATRCIJfItXzOho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260635; x=1741865435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXAgzqp6YN1DpD4nDAOaVXpHZiShYKGqmKOr0HW9Cag=;
        b=qPgvQdf3LvnNUNvxU0UQi6pwVXQkS2JbDbH/Qq3oOgc8OxxWLIW5mxXR7+zuoZO6z1
         VCjDZ6F2/Se1qvFSA9zsLkbVB0CfDKho1TKmglG7LHR9kTLoV7ZcJGCZzk0CD2hSd3rV
         NRLbKHEFYBWNxaUpJ52vonAjLfsP9HBuhboH5r78hrg+f2BDpPRgdQVF9mQBoMnDmTxX
         8pO4xtItblF+RtequzAMPAfGx92HC2zuFbTcLlW66LveWsiQQs6csqVO5EFlauMOYTlJ
         4Y5UIxamabnH8sR+qFqRK7X+ODeLEd3GtIXg/X65XUp/31IdHwY3xcEG5+2lQRh7p54v
         9wyw==
X-Gm-Message-State: AOJu0YzFUNxmJIzOwUfyMuWs5kkTtk+oyke1p4KObCOvtZRjPTgIUA72
	R6uv8HQWPGbtU88xmnVOH0l168YC5+99sRrzVAGu24O11BZA2w+cYNlhktl01OyEvVwpvu69e08
	C
X-Gm-Gg: ASbGncsYvufY6oAEsJSpY90citgZzr3CksPyo6pocs9MvJoKkMU5iRmQp98/WpKJtJe
	lN3lHAwjYVLXGrmPJiw/0S2vPQ0lzFXh1trmzKEvk3MmdSM55H88qMyDHLatZ7BJSa7bvFoW7j/
	KSgEI7k7MpiNkyDy+SLxb4JMQzW3i0Wa2KGgmJeqJLQWYoz3KbvJJ3dgAJP+G31cnr4v9KHR/Pq
	5S9//vBoth72Olgc+eHPhv1v0fjG42oO6t/fx4SxoGx/NbrszdTalVXVBMoacDP/9ufG4g8iVXw
	+dcaz+Kt7p1nMSwpyemJ5JQQE4WH7gUURsvbqpPHlwxe4+i1twP9Kn7DegscReJxzjRHSg7GghN
	gDMbCxA==
X-Google-Smtp-Source: AGHT+IG3ZzVC/+YAhqXUSUBguJ9sdHvmMerSHx1MRYH1RjvKYlLNCXCShFnWwLA+ImNN8EPcYV+HPg==
X-Received: by 2002:a05:6000:2cd:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-3911f76f519mr6861730f8f.31.1741260635466;
        Thu, 06 Mar 2025 03:30:35 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:4703:aa8c:6eab:8161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1749650f8f.3.2025.03.06.03.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:30:35 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v10 02/18] clk: imx8mm: rename video_pll1 to video_pll
Date: Thu,  6 Mar 2025 12:27:51 +0100
Message-ID: <20250306112959.242131-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
References: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike audio_pll1 and audio_pll2, there is no video_pll2. Further, the
name used in the RM is video_pll. So, let's rename "video_pll1" to
"video_pll" to be consistent with the RM and avoid misunderstandings.

No functional changes intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---
The patch, which simply replaces video_pll1 with video_pll, highlights
many warnings raised by checkpatch.pl. These are not generated by the
changes made but are inherited from how the module was originally
written. Fixing them would have meant "obscuring" the actual changes
introduced.

(no changes since v7)

Changes in v7:
- Add 'Reviewed-by' tag of Peng Fan

Changes in v5:
- Split the patch dropping the dt-bindings changes.

Changes in v4:
- New

 drivers/clk/imx/clk-imx8mm.c | 102 +++++++++++++++++------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 342049b847b9..8a1fc7e17ba2 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -28,7 +28,7 @@ static u32 share_count_nand;
 static const char *pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
 static const char *audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
 static const char *audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_ref_sel", };
-static const char *video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
+static const char *video_pll_bypass_sels[] = {"video_pll", "video_pll_ref_sel", };
 static const char *dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
 static const char *gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
 static const char *vpu_pll_bypass_sels[] = {"vpu_pll", "vpu_pll_ref_sel", };
@@ -42,22 +42,22 @@ static const char *imx8mm_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pll2_500m
 static const char * const imx8mm_a53_core_sels[] = {"arm_a53_div", "arm_pll_out", };
 
 static const char *imx8mm_m4_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m", "sys_pll1_266m",
-				       "sys_pll1_800m", "audio_pll1_out", "video_pll1_out", "sys_pll3_out", };
+				       "sys_pll1_800m", "audio_pll1_out", "video_pll_out", "sys_pll3_out", };
 
 static const char *imx8mm_vpu_sels[] = {"osc_24m", "arm_pll_out", "sys_pll2_500m", "sys_pll2_1000m",
 					"sys_pll1_800m", "sys_pll1_400m", "audio_pll1_out", "vpu_pll_out", };
 
 static const char *imx8mm_gpu3d_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m", "sys_pll3_out",
-					  "sys_pll2_1000m", "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+					  "sys_pll2_1000m", "audio_pll1_out", "video_pll_out", "audio_pll2_out", };
 
 static const char *imx8mm_gpu2d_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m", "sys_pll3_out",
-					  "sys_pll2_1000m", "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+					  "sys_pll2_1000m", "audio_pll1_out", "video_pll_out", "audio_pll2_out", };
 
 static const char *imx8mm_main_axi_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll1_800m", "sys_pll2_250m",
-					     "sys_pll2_1000m", "audio_pll1_out", "video_pll1_out", "sys_pll1_100m",};
+					     "sys_pll2_1000m", "audio_pll1_out", "video_pll_out", "sys_pll1_100m",};
 
 static const char *imx8mm_enet_axi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_250m",
-					     "sys_pll2_200m", "audio_pll1_out", "video_pll1_out", "sys_pll3_out", };
+					     "sys_pll2_200m", "audio_pll1_out", "video_pll_out", "sys_pll3_out", };
 
 static const char *imx8mm_nand_usdhc_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m", "sys_pll2_200m",
 					       "sys_pll1_133m", "sys_pll3_out", "sys_pll2_250m", "audio_pll1_out", };
@@ -72,28 +72,28 @@ static const char *imx8mm_disp_apb_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pl
 					     "sys_pll1_40m", "audio_pll2_out", "clk_ext1", "clk_ext3", };
 
 static const char *imx8mm_disp_rtrm_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll2_200m", "sys_pll2_1000m",
-					      "audio_pll1_out", "video_pll1_out", "clk_ext2", "clk_ext3", };
+					      "audio_pll1_out", "video_pll_out", "clk_ext2", "clk_ext3", };
 
 static const char *imx8mm_usb_bus_sels[] = {"osc_24m", "sys_pll2_500m", "sys_pll1_800m", "sys_pll2_100m",
 					    "sys_pll2_200m", "clk_ext2", "clk_ext4", "audio_pll2_out", };
 
 static const char *imx8mm_gpu_axi_sels[] = {"osc_24m", "sys_pll1_800m", "gpu_pll_out", "sys_pll3_out", "sys_pll2_1000m",
-					    "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+					    "audio_pll1_out", "video_pll_out", "audio_pll2_out", };
 
 static const char *imx8mm_gpu_ahb_sels[] = {"osc_24m", "sys_pll1_800m", "gpu_pll_out", "sys_pll3_out", "sys_pll2_1000m",
-					    "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+					    "audio_pll1_out", "video_pll_out", "audio_pll2_out", };
 
 static const char *imx8mm_noc_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll3_out", "sys_pll2_1000m", "sys_pll2_500m",
-					"audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+					"audio_pll1_out", "video_pll_out", "audio_pll2_out", };
 
 static const char *imx8mm_noc_apb_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll3_out", "sys_pll2_333m", "sys_pll2_200m",
-					    "sys_pll1_800m", "audio_pll1_out", "video_pll1_out", };
+					    "sys_pll1_800m", "audio_pll1_out", "video_pll_out", };
 
 static const char *imx8mm_ahb_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_800m", "sys_pll1_400m",
-					"sys_pll2_125m", "sys_pll3_out", "audio_pll1_out", "video_pll1_out", };
+					"sys_pll2_125m", "sys_pll3_out", "audio_pll1_out", "video_pll_out", };
 
 static const char *imx8mm_audio_ahb_sels[] = {"osc_24m", "sys_pll2_500m", "sys_pll1_800m", "sys_pll2_1000m",
-					      "sys_pll2_166m", "sys_pll3_out", "audio_pll1_out", "video_pll1_out", };
+					      "sys_pll2_166m", "sys_pll3_out", "audio_pll1_out", "video_pll_out", };
 
 static const char *imx8mm_dram_alt_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll1_100m", "sys_pll2_500m",
 					     "sys_pll2_1000m", "sys_pll3_out", "audio_pll1_out", "sys_pll1_266m", };
@@ -108,10 +108,10 @@ static const char *imx8mm_vpu_g2_sels[] = {"osc_24m", "vpu_pll_out", "sys_pll1_8
 					   "sys_pll1_100m", "sys_pll2_125m", "sys_pll3_out", "audio_pll1_out", };
 
 static const char *imx8mm_disp_dtrc_sels[] = {"osc_24m", "dummy", "sys_pll1_800m", "sys_pll2_1000m",
-					      "sys_pll1_160m", "video_pll1_out", "sys_pll3_out", "audio_pll2_out", };
+					      "sys_pll1_160m", "video_pll_out", "sys_pll3_out", "audio_pll2_out", };
 
 static const char *imx8mm_disp_dc8000_sels[] = {"osc_24m", "dummy", "sys_pll1_800m", "sys_pll2_1000m",
-						"sys_pll1_160m", "video_pll1_out", "sys_pll3_out", "audio_pll2_out", };
+						"sys_pll1_160m", "video_pll_out", "sys_pll3_out", "audio_pll2_out", };
 
 static const char *imx8mm_pcie1_ctrl_sels[] = {"osc_24m", "sys_pll2_250m", "sys_pll2_200m", "sys_pll1_266m",
 					       "sys_pll1_800m", "sys_pll2_500m", "sys_pll2_333m", "sys_pll3_out", };
@@ -122,47 +122,47 @@ static const char *imx8mm_pcie1_phy_sels[] = {"osc_24m", "sys_pll2_100m", "sys_p
 static const char *imx8mm_pcie1_aux_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_50m", "sys_pll3_out",
 					      "sys_pll2_100m", "sys_pll1_80m", "sys_pll1_160m", "sys_pll1_200m", };
 
-static const char *imx8mm_dc_pixel_sels[] = {"osc_24m", "video_pll1_out", "audio_pll2_out", "audio_pll1_out",
+static const char *imx8mm_dc_pixel_sels[] = {"osc_24m", "video_pll_out", "audio_pll2_out", "audio_pll1_out",
 					     "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out", "clk_ext4", };
 
-static const char *imx8mm_lcdif_pixel_sels[] = {"osc_24m", "video_pll1_out", "audio_pll2_out", "audio_pll1_out",
+static const char *imx8mm_lcdif_pixel_sels[] = {"osc_24m", "video_pll_out", "audio_pll2_out", "audio_pll1_out",
 						"sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out", "clk_ext4", };
 
-static const char *imx8mm_sai1_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out",
+static const char *imx8mm_sai1_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll_out",
 					 "sys_pll1_133m", "osc_hdmi", "clk_ext1", "clk_ext2", };
 
-static const char *imx8mm_sai2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out",
+static const char *imx8mm_sai2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll_out",
 					 "sys_pll1_133m", "osc_hdmi", "clk_ext2", "clk_ext3", };
 
-static const char *imx8mm_sai3_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out",
+static const char *imx8mm_sai3_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll_out",
 					 "sys_pll1_133m", "osc_hdmi", "clk_ext3", "clk_ext4", };
 
-static const char *imx8mm_sai4_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out",
+static const char *imx8mm_sai4_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll_out",
 					 "sys_pll1_133m", "osc_hdmi", "clk_ext1", "clk_ext2", };
 
-static const char *imx8mm_sai5_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out",
+static const char *imx8mm_sai5_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll_out",
 					 "sys_pll1_133m", "osc_hdmi", "clk_ext2", "clk_ext3", };
 
-static const char *imx8mm_sai6_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out",
+static const char *imx8mm_sai6_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll_out",
 					 "sys_pll1_133m", "osc_hdmi", "clk_ext3", "clk_ext4", };
 
-static const char *imx8mm_spdif1_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out",
+static const char *imx8mm_spdif1_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll_out",
 					   "sys_pll1_133m", "osc_hdmi", "clk_ext2", "clk_ext3", };
 
-static const char *imx8mm_spdif2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out",
+static const char *imx8mm_spdif2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll_out",
 					   "sys_pll1_133m", "osc_hdmi", "clk_ext3", "clk_ext4", };
 
 static const char *imx8mm_enet_ref_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m", "sys_pll2_100m",
-					     "sys_pll1_160m", "audio_pll1_out", "video_pll1_out", "clk_ext4", };
+					     "sys_pll1_160m", "audio_pll1_out", "video_pll_out", "clk_ext4", };
 
 static const char *imx8mm_enet_timer_sels[] = {"osc_24m", "sys_pll2_100m", "audio_pll1_out", "clk_ext1", "clk_ext2",
-					       "clk_ext3", "clk_ext4", "video_pll1_out", };
+					       "clk_ext3", "clk_ext4", "video_pll_out", };
 
 static const char *imx8mm_enet_phy_sels[] = {"osc_24m", "sys_pll2_50m", "sys_pll2_125m", "sys_pll2_200m",
-					     "sys_pll2_500m", "video_pll1_out", "audio_pll2_out", };
+					     "sys_pll2_500m", "video_pll_out", "audio_pll2_out", };
 
 static const char *imx8mm_nand_sels[] = {"osc_24m", "sys_pll2_500m", "audio_pll1_out", "sys_pll1_400m",
-					 "audio_pll2_out", "sys_pll3_out", "sys_pll2_250m", "video_pll1_out", };
+					 "audio_pll2_out", "sys_pll3_out", "sys_pll2_250m", "video_pll_out", };
 
 static const char *imx8mm_qspi_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll2_333m", "sys_pll2_500m",
 					 "audio_pll2_out", "sys_pll1_266m", "sys_pll3_out", "sys_pll1_100m", };
@@ -174,16 +174,16 @@ static const char *imx8mm_usdhc2_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1
 					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_out", "sys_pll1_100m", };
 
 static const char *imx8mm_i2c1_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
-					 "video_pll1_out", "audio_pll2_out", "sys_pll1_133m", };
+					 "video_pll_out", "audio_pll2_out", "sys_pll1_133m", };
 
 static const char *imx8mm_i2c2_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
-					 "video_pll1_out", "audio_pll2_out", "sys_pll1_133m", };
+					 "video_pll_out", "audio_pll2_out", "sys_pll1_133m", };
 
 static const char *imx8mm_i2c3_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
-					 "video_pll1_out", "audio_pll2_out", "sys_pll1_133m", };
+					 "video_pll_out", "audio_pll2_out", "sys_pll1_133m", };
 
 static const char *imx8mm_i2c4_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
-					 "video_pll1_out", "audio_pll2_out", "sys_pll1_133m", };
+					 "video_pll_out", "audio_pll2_out", "sys_pll1_133m", };
 
 static const char *imx8mm_uart1_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m", "sys_pll2_100m",
 					  "sys_pll3_out", "clk_ext2", "clk_ext4", "audio_pll2_out", };
@@ -213,19 +213,19 @@ static const char *imx8mm_ecspi2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1
 					   "sys_pll1_800m", "sys_pll3_out", "sys_pll2_250m", "audio_pll2_out", };
 
 static const char *imx8mm_pwm1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
-					 "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll1_out", };
+					 "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll_out", };
 
 static const char *imx8mm_pwm2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
-					 "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll1_out", };
+					 "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll_out", };
 
 static const char *imx8mm_pwm3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
-					 "sys_pll3_out", "clk_ext2", "sys_pll1_80m", "video_pll1_out", };
+					 "sys_pll3_out", "clk_ext2", "sys_pll1_80m", "video_pll_out", };
 
 static const char *imx8mm_pwm4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
-					 "sys_pll3_out", "clk_ext2", "sys_pll1_80m", "video_pll1_out", };
+					 "sys_pll3_out", "clk_ext2", "sys_pll1_80m", "video_pll_out", };
 
 static const char *imx8mm_gpt1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m", "sys_pll1_40m",
-					 "video_pll1_out", "sys_pll1_80m", "audio_pll1_out", "clk_ext1" };
+					 "video_pll_out", "sys_pll1_80m", "audio_pll1_out", "clk_ext1" };
 
 static const char *imx8mm_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m", "vpu_pll_out",
 					 "sys_pll2_125m", "sys_pll3_out", "sys_pll1_80m", "sys_pll2_166m", };
@@ -234,31 +234,31 @@ static const char *imx8mm_wrclk_sels[] = {"osc_24m", "sys_pll1_40m", "vpu_pll_ou
 					  "sys_pll1_266m", "sys_pll2_500m", "sys_pll1_100m", };
 
 static const char *imx8mm_dsi_core_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m", "sys_pll1_800m",
-					     "sys_pll2_1000m", "sys_pll3_out", "audio_pll2_out", "video_pll1_out", };
+					     "sys_pll2_1000m", "sys_pll3_out", "audio_pll2_out", "video_pll_out", };
 
 static const char *imx8mm_dsi_phy_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_100m", "sys_pll1_800m",
-					    "sys_pll2_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out", };
+					    "sys_pll2_1000m", "clk_ext2", "audio_pll2_out", "video_pll_out", };
 
 static const char *imx8mm_dsi_dbi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_100m", "sys_pll1_800m",
-					    "sys_pll2_1000m", "sys_pll3_out", "audio_pll2_out", "video_pll1_out", };
+					    "sys_pll2_1000m", "sys_pll3_out", "audio_pll2_out", "video_pll_out", };
 
 static const char *imx8mm_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m", "sys_pll2_500m",
 					   "sys_pll3_out", "sys_pll1_266m", "audio_pll2_out", "sys_pll1_100m", };
 
 static const char *imx8mm_csi1_core_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m", "sys_pll1_800m",
-					      "sys_pll2_1000m", "sys_pll3_out", "audio_pll2_out", "video_pll1_out", };
+					      "sys_pll2_1000m", "sys_pll3_out", "audio_pll2_out", "video_pll_out", };
 
 static const char *imx8mm_csi1_phy_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll2_100m", "sys_pll1_800m",
-					     "sys_pll2_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out", };
+					     "sys_pll2_1000m", "clk_ext2", "audio_pll2_out", "video_pll_out", };
 
 static const char *imx8mm_csi1_esc_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_80m", "sys_pll1_800m",
 					     "sys_pll2_1000m", "sys_pll3_out", "clk_ext3", "audio_pll2_out", };
 
 static const char *imx8mm_csi2_core_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m", "sys_pll1_800m",
-					      "sys_pll2_1000m", "sys_pll3_out", "audio_pll2_out", "video_pll1_out", };
+					      "sys_pll2_1000m", "sys_pll3_out", "audio_pll2_out", "video_pll_out", };
 
 static const char *imx8mm_csi2_phy_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll2_100m", "sys_pll1_800m",
-					     "sys_pll2_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out", };
+					     "sys_pll2_1000m", "clk_ext2", "audio_pll2_out", "video_pll_out", };
 
 static const char *imx8mm_csi2_esc_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_80m", "sys_pll1_800m",
 					     "sys_pll2_1000m", "sys_pll3_out", "clk_ext3", "audio_pll2_out", };
@@ -286,9 +286,9 @@ static const char *imx8mm_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", }
 static const char *imx8mm_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "dummy", "sys_pll1_200m",
 					  "audio_pll2_out", "sys_pll2_500m", "vpu_pll", "sys_pll1_80m", };
 static const char *imx8mm_clko2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_400m", "sys_pll2_166m",
-					  "sys_pll3_out", "audio_pll1_out", "video_pll1_out", "osc_32k", };
+					  "sys_pll3_out", "audio_pll1_out", "video_pll_out", "osc_32k", };
 
-static const char * const clkout_sels[] = {"audio_pll1_out", "audio_pll2_out", "video_pll1_out",
+static const char * const clkout_sels[] = {"audio_pll1_out", "audio_pll2_out", "video_pll_out",
 					   "dummy", "dummy", "gpu_pll_out", "vpu_pll_out",
 					   "arm_pll_out", "sys_pll1", "sys_pll2", "sys_pll3",
 					   "dummy", "dummy", "osc_24m", "dummy", "osc_32k"};
@@ -327,7 +327,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MM_AUDIO_PLL1_REF_SEL] = imx_clk_hw_mux("audio_pll1_ref_sel", base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MM_AUDIO_PLL2_REF_SEL] = imx_clk_hw_mux("audio_pll2_ref_sel", base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	hws[IMX8MM_VIDEO_PLL1_REF_SEL] = imx_clk_hw_mux("video_pll1_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	hws[IMX8MM_VIDEO_PLL_REF_SEL] = imx_clk_hw_mux("video_pll_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MM_DRAM_PLL_REF_SEL] = imx_clk_hw_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MM_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", base + 0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MM_VPU_PLL_REF_SEL] = imx_clk_hw_mux("vpu_pll_ref_sel", base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
@@ -336,7 +336,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MM_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll);
 	hws[IMX8MM_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
-	hws[IMX8MM_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
+	hws[IMX8MM_VIDEO_PLL] = imx_clk_hw_pll14xx("video_pll", "video_pll_ref_sel", base + 0x28, &imx_1443x_pll);
 	hws[IMX8MM_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
 	hws[IMX8MM_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
 	hws[IMX8MM_VPU_PLL] = imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74, &imx_1416x_pll);
@@ -348,7 +348,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	/* PLL bypass out */
 	hws[IMX8MM_AUDIO_PLL1_BYPASS] = imx_clk_hw_mux_flags("audio_pll1_bypass", base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MM_AUDIO_PLL2_BYPASS] = imx_clk_hw_mux_flags("audio_pll2_bypass", base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_sels), CLK_SET_RATE_PARENT);
-	hws[IMX8MM_VIDEO_PLL1_BYPASS] = imx_clk_hw_mux_flags("video_pll1_bypass", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels), CLK_SET_RATE_PARENT);
+	hws[IMX8MM_VIDEO_PLL_BYPASS] = imx_clk_hw_mux_flags("video_pll_bypass", base + 0x28, 16, 1, video_pll_bypass_sels, ARRAY_SIZE(video_pll_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MM_DRAM_PLL_BYPASS] = imx_clk_hw_mux_flags("dram_pll_bypass", base + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MM_GPU_PLL_BYPASS] = imx_clk_hw_mux_flags("gpu_pll_bypass", base + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
 	hws[IMX8MM_VPU_PLL_BYPASS] = imx_clk_hw_mux_flags("vpu_pll_bypass", base + 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
@@ -358,7 +358,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	/* PLL out gate */
 	hws[IMX8MM_AUDIO_PLL1_OUT] = imx_clk_hw_gate("audio_pll1_out", "audio_pll1_bypass", base, 13);
 	hws[IMX8MM_AUDIO_PLL2_OUT] = imx_clk_hw_gate("audio_pll2_out", "audio_pll2_bypass", base + 0x14, 13);
-	hws[IMX8MM_VIDEO_PLL1_OUT] = imx_clk_hw_gate("video_pll1_out", "video_pll1_bypass", base + 0x28, 13);
+	hws[IMX8MM_VIDEO_PLL_OUT] = imx_clk_hw_gate("video_pll_out", "video_pll_bypass", base + 0x28, 13);
 	hws[IMX8MM_DRAM_PLL_OUT] = imx_clk_hw_gate("dram_pll_out", "dram_pll_bypass", base + 0x50, 13);
 	hws[IMX8MM_GPU_PLL_OUT] = imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypass", base + 0x64, 11);
 	hws[IMX8MM_VPU_PLL_OUT] = imx_clk_hw_gate("vpu_pll_out", "vpu_pll_bypass", base + 0x74, 11);
-- 
2.43.0


