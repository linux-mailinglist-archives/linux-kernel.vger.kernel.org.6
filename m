Return-Path: <linux-kernel+bounces-522015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD65AA3C4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9758A168EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770541FE44A;
	Wed, 19 Feb 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vke7Uwod"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F011FDA9D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982225; cv=none; b=ZXsToeAVFEej+jfP+wNCDyFyrhXA0rzpOVpQiYMbOdUW/I1OUF4mXoBJZmZIMUCohbLcdnABhiRKxXEJnk6Td72gQaLMooif7eU9uqtAQMe89N1sxWkn7QG4WHFwiAQ3aqcyuZjF5xPEE7s8vlPM2ADOK3Z79wwm0MgF047bk1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982225; c=relaxed/simple;
	bh=tZwVmZGIy/eSt0F/uS5uvIVQSBhlXJtKuOQbLfRhrCg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eICV9UQj2a6JYbNnHWAlSHGQLmv6bm2CskNIP5nScBfod6cwZiDMGxl4TJyCH9J14pw2NljTkMkvnp2IApGIzaT0rDLi7ZO+ezinWUx6EnkNsNrnL5TbUoV6ImiWk9diZaYI4aVuQeZVVil7SumBGElLTp7yZhmxBZJV3C2pHaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vke7Uwod; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f29a2c6a2so661979f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739982222; x=1740587022; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/JVUNmYdeWSnzu6tb+ukMUUG1W+l3NrvPTKiVQ7u4Y=;
        b=Vke7Uwod9f7K4ip6hKiQccBOYt0NbTcfWchbUqvinJJwaibX9kpRwsTNN5DhgSY3l8
         BBNUKwDzDihtRSJ4Og1RA6UU3Va+gwkQ4vgREButi11pEYSaV20EeK5uwejPogyf2S4L
         A43b9bZ9xn6v7OFWuQnTL5MdO7WRN8M2zVc7PcWTgBqZYjVpjccolj96HjEhGVvE5SUN
         jiQDAU/30fXar/GOF4BJfkh3r2Cbaf/X18ffQpn0PYlqt5kCY3oBKkyV9Zm34+i1A6ke
         Jlz42DWPDlATsJtV/EIOGBfOGEGYdRsGcLr6tftr2ai2uU3+RugOyS23SUmYyfoAgeSD
         fiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982222; x=1740587022;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/JVUNmYdeWSnzu6tb+ukMUUG1W+l3NrvPTKiVQ7u4Y=;
        b=g8doGW7LPVfldhpybkJMFbeIg0X2oVXGebSEBC3q8CJSmJiNkzBWDN8+4/nGWbfDH1
         lNpSM3o3Y6YnNfcy3wYMlGcuWU7etTmM1sDV5JpZGb8LLbP1TroX7mC8l/3KqXshILbg
         vYlibt+zjJR4beixWNGhCWfAK+rimxLCYFBdCJbkW5cbBvqXsD44EWaSBaGGsRgYSaQ3
         8ri2vZFcAQ4Bk2iA52YyE51siMlSHhgOztIgV3/XzmC50ShVVvuI7AcRtvbNBMLtlnnc
         YNXwfO9pZx6Y5cuTeNP/e/xNY4tXM9itIH53LzJ7cAUo1uxjnK95egB/ELoz1Z4UheB7
         524A==
X-Forwarded-Encrypted: i=1; AJvYcCXONL7fDHl6ng/2+1rYBqOuEDQvE7Id2cQ1BQBCeaYVAKUdz4rAdyrKwfO3bNQigHnmLthBiBVuuJ6U1mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvoakPJhQkgoyS2/Cf3wj69zzGZ3tNf1Ia9Aml3xdGJy6XzmG/
	zpzQXd7LI0FXcMII6BDGG1VTJT85SZILJJcTtFS5Qre0Vw+WtpRoGxyR76LIia2mNwjO/04Rs/N
	uc3E=
X-Gm-Gg: ASbGncucE9BDzBCjEJCdBLif8VDxC/UPmSoQY2QQ/Up+YBOSFVQX6WVnOR2cIQuWT+r
	WqNrvwVtNW7GFaol2fP+VEhL3NyfcPoSExZX5XNRhMzwp9yXoZtRBWb0WDtcC3fSqBmB8crXzxo
	oiGnV3RR2+PPlD/KZnZfUflc0UpLCU8b1VKJdJE/EC3JCQtdr4h31AQ71nFG977+13FEW3u56hX
	VANBv2CalFyFcopofqi0U/Om2hMoDjg56ye7JowP5qxVDT4S6d37dDOICNk/bg4WjZkQJ16fP6g
	9RXq0FgbxbyomH3IBn/uOvHhlz36RfE=
X-Google-Smtp-Source: AGHT+IGBdM3lo0D85OcGM+X/7yDsIYEa3ff6Dvt0fm3r6ukYvpu2eEqg39AxdYMVjgmIP9+/XM39uw==
X-Received: by 2002:a05:6000:210a:b0:38c:5d0b:71ca with SMTP id ffacd0b85a97d-38f33e87b96mr6342208f8f.0.1739982222200;
        Wed, 19 Feb 2025 08:23:42 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fe5esm18442417f8f.99.2025.02.19.08.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:23:41 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 0/2] drm/msm/dsi/phy: Improvements around concurrent
 PHY_CMN_CLK_CFG[01]
Date: Wed, 19 Feb 2025 17:23:31 +0100
Message-Id: <20250219-drm-msm-phy-pll-cfg-reg-v5-0-d28973fa513a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIMFtmcC/4XNy2rDMBCF4VcJWneKZmT5klXeo2RhWSNb4BtSM
 THG7145m6YE0+V/YL7ZROTgOYrrZROBFx/9NKbQHxfRdPXYMnibWpAkLVEh2DDAEAeYuxXmvof
 GtRC4hYK1cbquK+tyka7nwM4/nvLXPXXn4/cU1uejBY/1f3NBkKBMVbFjQ1zaW+/HOkyfU2jFg
 S70C5FU5xAlqMzJoMobbYneIPUCYXYOqQTJKlOm1LIgat6g7BUqzqEsQShzIy1ap5H/QPu+/wC
 XLcutmgEAAA==
X-Change-ID: 20250131-drm-msm-phy-pll-cfg-reg-7e5bf5aa9df6
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Rob Clark <robdclark@chromium.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1781;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=tZwVmZGIy/eSt0F/uS5uvIVQSBhlXJtKuOQbLfRhrCg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBntgWG39erfPCkDuCBdlsjBei3XeCpr5sf5QY1l
 egU/afYzjaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7YFhgAKCRDBN2bmhouD
 1zQOD/0c+MQ1gae4xMmQAO8dgpOXfEBJ6P5vw2BXNnqg8SilK01Oks0ZGEoEacDx49ZndSz3WA4
 Sv2hqvKyFS3oF2gQ5Nar78q/04ZvrWxRW9Jde/J6ivRid+0TwEODwpA6JqyHoDhHYMDU5Hm2C+j
 cdC/GKKl/1oYT++nmzvSU+3d+RtuSleDwzjNmBL8G2fMDH17tU6KwKuWBK4+e6I99qPAPexWGzq
 qmcaIqXGsoU76ltjMb4W0QBVKdproY0F99tH9O+DW/g5wS5SGPrkTKCnHxTje3aLAF0FoDhFI/M
 yKWZbwklNlSbuiRHWddbyoy2JEywnLkeKSlQLk52VB2JJMMWYdrO4uMUqW5ThmF6LuMnv2m2ZiO
 3nBybqToaOZ1Tsb5AezUdTsj7IKrM0Se19X71latB2eVGK7KOejtRWmK9GDIp11jPq9KrvnWuoK
 IZ/bUDh2KlgHkUm3JOhMCwkv0e2u22epW0r++EKWSIqIkqUx477N0qXZX+iSP/v6qrZjpxkDDV3
 5BH4kEzJRtGNCEoJsztwmwJYf8+wBsL+nnLazTWjVlVHPI68H3Lr7+Ud4A9CvXEQQFr7UIyd+sU
 4oTPnHpykDkR0YEIkj/BKKW8QSqy00tv2yUMH3mno2Lx1ZSx7vYv1J7Dt0/Dxan0ObifeqColxR
 vZQ8uPeFGafll1w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v5:
- Drop applied patches 1-3
- Split part touching pll_7nm_register() from last (#4) patch to new patch
   - Thus: new patch #1 in new numbering.
- Link to v4: https://lore.kernel.org/r/20250217-drm-msm-phy-pll-cfg-reg-v4-0-106b0d1df51e@linaro.org

Changes in v4:
- Add tags
- Patch #4: Add mising bitfield.h include
- One more FIELD_GET and DSI_7nm_PHY_CMN_CLK_CFG1_DSICLK_SEL (Dmitry)
- Link to v3: https://lore.kernel.org/r/20250214-drm-msm-phy-pll-cfg-reg-v3-0-0943b850722c@linaro.org

Changes in v3:
- Define bitfields in patches 1-3, so move there parts from patch #4
- Use FIELD_GET
- Keep separate cached->bit_clk_div and pix_clk_div
- I think this implements entire feedback from Dmitry
- Link to v2: https://lore.kernel.org/r/20250203-drm-msm-phy-pll-cfg-reg-v2-0-862b136c5d22@linaro.org

Changes in v2:
- Add Fixes tag
- New patch #4
- Link to v1: https://lore.kernel.org/r/20250131-drm-msm-phy-pll-cfg-reg-v1-0-3b99efeb2e8d@linaro.org

Calling these improvements, not fixes, because I don't think we ever hit
actual concurrency issue.  Although if we ever hit it, it would be very
tricky to debug and find the cause.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      drm/msm/dsi/phy: Use dsi_pll_cmn_clk_cfg1_update() when registering PLL
      drm/msm/dsi/phy: Define PHY_CMN_CLK_CFG[01] bitfields and simplify saving

 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c             | 18 +++++++++---------
 drivers/gpu/drm/msm/registers/display/dsi_phy_7nm.xml |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)
---
base-commit: 15ad9d0efd6a8b1db4c098ac0a5e66b736ca774a
change-id: 20250131-drm-msm-phy-pll-cfg-reg-7e5bf5aa9df6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


