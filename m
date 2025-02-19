Return-Path: <linux-kernel+bounces-521353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64EAA3BC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37EF177F27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30861DE8B0;
	Wed, 19 Feb 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOR8/a4n"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F31DE891
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962477; cv=none; b=V2xe9LpEwhZCXlmZ6hJIsxizz3RfvG2uvpeVhh05PVdktrYso4WlEyKVOCjgrOdFRnzyhY28/G2oAkgvTgc6DzZMn5vGwkarboZ9QUuj+ggviGLcLWxPseuuWq/cOsQtz3jczT5sWsieje3GoLKT9zywhhBlHa0sA4hP4dxurZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962477; c=relaxed/simple;
	bh=inp63xnVl0zLneh8KilxeF8rih2+WOCw/JT9WY/kxqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZebFspnXKxxkBjjveGN9ZqUXdkyTQgEObALImXhkxum4b1X+ZjTsNBfMMfwcF+YAvCrPBEh0HB66fEeb87D8O0ODvjmWtPAb8s6Y/JO4yNdf+faWhXNb8B5eWCKPLdaFvghqWEoVK7rQ/K2Jyo2/x+bm4rC0iPXIJ/YQEUo43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOR8/a4n; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220d601886fso87566035ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962475; x=1740567275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfmj99E5nF700uXzwTkIiBrbuZR5VJirYG+7BOy/lwo=;
        b=EOR8/a4ntP8RhRLZL3JEyKeTdkDNtPUOxiF/2FcwhSqpJSiqSUftqWnmYSwdcBjS0u
         7xR3E92PDr/cZTqyDnnPxxbKwDYa8YDZZWOfb9SHLrVtjJ14E/tWcELNLIzQB/5tI0YD
         ir5pPyvvosFGy3+8I4h4l3r5f9f3fFl+vGm/HxrYRdisKlWU46Dco8EP4KNf7EAxDBbg
         FTyzdqlaS2nX79B06q8oq8yLpToR1G8SXxRoFDcAmXGI1fHG4oKS4pzQhzvvQ9d/G7BR
         h0xNTYubnB85v4XPvUxLPM/ZgJzhcyS1VnUQ6S4oYOzk2iVDIRSEBAqdx2YQBFVAF1G7
         6SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962475; x=1740567275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfmj99E5nF700uXzwTkIiBrbuZR5VJirYG+7BOy/lwo=;
        b=BwKVlKB2Ai6ZvZn7bdv0JZrsvXjyWqmZN0hkiTtGNz54RywxRCdHyMR//STrqvbpcA
         6RrfXF4rx9lkvjVQRL69V0RX0pyH9BA0Jit9VGxk6bfpz68egYlRLvm9YOx/LLwmfIcd
         GOtMJdPjXRhVQpmxm6d+VbQqRg3zV4gP2w0rtDzAWS8HlxyhRnLj68/yKKRG9FRN6c8U
         9PZS90JLO6EhhzwMDY8wpVjXLIhMpIzLqPe1Uxx6Lf+oAKbMiME38Gspp6+ibqmS0fI7
         bMr/EKvFTK6wlfxOIHQ/MpxNpYPsd6XcjOKxGXlaKXn8LdkvzqdoHV6KLF1Zj4/ch8kG
         7kow==
X-Forwarded-Encrypted: i=1; AJvYcCWaw1n3KHuA9grpBDT4ld++wJ+gEEhA4uj4mIrZPq2/JBpKcUkmPqqn5Vyal2fSA4Hic/1R55DztaRKz8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4o4V3Fqy6YpXEeRD5/+92aXvgHkf1fNBlKffQyQD2S83nXHJ8
	3Tn1W927e5dzqE1j+PALgpTCLc8IbQW7xhbIGAXz2vt5k4syezkwspN2aP8O
X-Gm-Gg: ASbGncvqj/Y+5NAnjj9viC231aBl/IFq036Xvsq87UMLVCq5ZNdpHwuYBHWwrbIvRe0
	mQXEviEKZyuZ/BJ0RDzrDYnGY2hQ6sanjrqOYwx4LygzqcJTpJc2Klv84we2NuncSLkV64gJkL2
	AW5F+LnR2ntlXTnfE1+X4mo45lSbU/sr+gLyLy3PTI0Y76dIgVOBOms3Zp7BhRIo34ymZcj2BxU
	Vx+mxp0ziG761ixK1i3O3h1Ktk4e+dH94/mS3Q8bqfXBzOFoo3ZCAO5RZiyRLog5UpKFjSgpgXZ
	VekiZbjtjH9RW0FnGKBk28TZrRuSLhboS7k2KtFlXwXphQ==
X-Google-Smtp-Source: AGHT+IEz78X5zWQhTB+EMNYjdr2n6pZ5lHab8dXaoEyP99Eo4xdokhvPivhFVuTWK+S5WfuesEyPmQ==
X-Received: by 2002:a17:902:e550:b0:220:d078:eb16 with SMTP id d9443c01a7336-221040bf81dmr259337615ad.37.1739962474987;
        Wed, 19 Feb 2025 02:54:34 -0800 (PST)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364503sm101827285ad.80.2025.02.19.02.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:54:34 -0800 (PST)
From: Chongchong Gu <chongchonggu21@gmail.com>
To: vkoul@kernel.org
Cc: kishon@kernel.org,
	aford173@gmail.com,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	guchongchong <guchongchong@xiaomi.com>
Subject: [PATCH v3 1/1] phy: freescale: limit div value in FIELD_PREP()
Date: Wed, 19 Feb 2025 18:54:11 +0800
Message-ID: <19ac11d6b9e5988d190025255c5ffe08c57c8023.1739961770.git.guchongchong@xiaomi.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739961770.git.guchongchong@xiaomi.com>
References: <cover.1739961770.git.guchongchong@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: guchongchong <guchongchong@xiaomi.com>

In fsl_samsung_hdmi_phy_configure_pll_lock_det, the variable named
div becomes 4 after loop. It must less than 4 in function named
FIELD_PREP(REG12_CK_DIV_MASK, div).

A way to reproduce when run the following shell command
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j4

Fixes: <d567679f2b6a> ("phy: freescale: fsl-samsung-hdmi: Clean up")
Signed-off-by: guchongchong <guchongchong@xiaomi.com>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 45004f598e4d..0ad766359cbe 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -337,7 +337,7 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
 	/* Find int_pllclk speed */
 	for (div = 0; div < 4; div++) {
 		int_pllclk = pclk / (1 << div);
-		if (int_pllclk < (50 * MHZ))
+		if (int_pllclk < (50 * MHZ) || div == 3)
 			break;
 	}
 
-- 
2.48.1


