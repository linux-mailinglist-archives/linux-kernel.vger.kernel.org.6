Return-Path: <linux-kernel+bounces-515158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA31A36104
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A810916AE10
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF75266592;
	Fri, 14 Feb 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1UY37yn"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AFD3595C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739545747; cv=none; b=osZ/QIZAlXJJolk4elTGHCnxoGIGzkSvg26x7cRW580bxRtCtbZZFJ243uCwKWa/+xfr5WgTlOgnjPuuDdRDGOlfwvNy9Zs5leABiwpbgkbSW928AuGlLGwEz1Wb5qqMG0378MxTUvLioWa8h1oP1eZoamnWFxGxmJUGgQptlf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739545747; c=relaxed/simple;
	bh=u4YT2mRDI9vOEz0E0V9HN6GrYA7SOM0GmXxkYSP3BpE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bridY8AqMPfSOO8o3xui9T2Q0VitWlqKV7ZcD4i2TIGDZ6hiDZqRK44kK1kfXSQPcjIfBQkAz0NKeoq7gcv+uo4+NFPRjyodL5TPPbM4gcDIFYZMpYKX5tK3sxVsd3VMY/24uJoEYdNSqJx+OnGw+kfWR0Y1KwCvDrszZM9J8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v1UY37yn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7bf29883aso35798766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739545744; x=1740150544; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTE3gACjDkJBHSXQFkTCbxcnRZQf61xIHWSy/iDp6UQ=;
        b=v1UY37ynH5e79M0GZ4U496POAWl0fVacHSsgcG5Y/ccVDQKxiCzSrEBbDLC4BCFnO+
         SYe/6N6WBt4sXLQBYFno33liaJ+W7JVVIJ/XxncJcZaYyVZq52LE2cBU/A4OwEWcNSvq
         bwSWneIwodaFg79iJVOUKPRJMGqxM4xWPAMSth9G7Tw86WOm2Ikn2UVFtoJxVh9CaM74
         FCHVCByGX7TlT1ojJQMddMktZ5+EUDbYNZtqTcRisD72o1SpzlGzrmWh8T5cshsB+kCi
         QghAdep6HfRsFcpvLYBINsuDeWtzqZGrVDz1A+qke5Nba/Dhop0SGpiKeROZY7jFX54a
         iSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739545744; x=1740150544;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTE3gACjDkJBHSXQFkTCbxcnRZQf61xIHWSy/iDp6UQ=;
        b=EVC71KJIDLsVDaPtd+dccWKr/MewdGBllbOdZaopDHE5gai1Hz2wo8WB3u1BBTTQX2
         uh7GagYKIyfU5uGS7rd7QB5ORJueLoRT+UBjBYt1LbE994dVHbu+q62magjNEfR6uLcN
         E0vMWe3ZanWQV6Eb59Ex6PabOp3u2A95DOKkq82XRCsFEHb2XUZHA2nFhOLfRDujWn0Y
         ETgYOwxa+5dJhi8OJ5bOA2jCVQ+9iXNfdf8MJcBTvjIJ2O+MvyN44ljZS6ocT3rNiY/G
         DEO5NdB5D/3/TmxZQVe5VHFcAS2Sy0Gmw8mqcbYFRorIgTFdHZPPMZYcalDtHoxJzVXv
         SW2w==
X-Forwarded-Encrypted: i=1; AJvYcCUf2P2fR9Ti1v3qyuTWVLPhjiMuH3g/HeB++9n2ZJqrslHJhCwW7q9EoEIiMo/eZBCLWr7lndiArpKzk/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLaBhQDpHpolEQx0dij5y5UJbLLXOFlX+9pv/0BwVLELNlpqf
	yZpO/vHLpQUVx80g5zIkekXQRuVhfbB9VsFBBr5XjwWZgEsqAHcbWt1WX4nzxV4=
X-Gm-Gg: ASbGncujTgCsG4SGglnAzJQDqZNkVfSOGStNhUum8jihK6oSInBIAw7btU8dJI/YZUt
	lC/ubu/EzH5sHtzy3931lh3XO+BL/7c2I5dj7DPKMtGoKdb9/g+mqI1pg0rDqEafEIZGTShPaZd
	hRR85+G3xQM4ov37t3rzBtbvfePrjDiHK7XH6QTtS+6XSCpeYcXUrIih0xERNxKwT7l4UgYOfBt
	dtZ03SG4Nu8rKRCrLTvyJ6ypgACgs/30KkIXrpf/fQpCdXL5z5wNA0T8qjlTQepE91IJBBbOIbL
	pyXNeREBgFPZ/Ws2wHswLnIqgBIpO4w=
X-Google-Smtp-Source: AGHT+IHzgKaRbHiTLvYxrSndh1cA0zCykbFaeMqxfMqSMgTgRMaXFYxANRLGE/AUS2gP7blBaOGXAg==
X-Received: by 2002:a17:907:8686:b0:ab7:cd83:98bb with SMTP id a640c23a62f3a-aba6939dff4mr107008966b.5.1739545744014;
        Fri, 14 Feb 2025 07:09:04 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bf70asm356266766b.180.2025.02.14.07.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:09:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/4] drm/msm/dsi/phy: Improvements around concurrent
 PHY_CMN_CLK_CFG[01]
Date: Fri, 14 Feb 2025 16:08:40 +0100
Message-Id: <20250214-drm-msm-phy-pll-cfg-reg-v3-0-0943b850722c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHhcr2cC/4XNQQqDMBCF4atI1p2STIjVrnqP0kU0Ew2okaSEi
 nj3Rjeli9Ll/2C+WVmk4Ciya7GyQMlF56cc8lSwttdTR+BMboYcFRdSgAkjjHGEuV9gHgZobQe
 BOriQaqzSuja2ZPl6DmTd65Dvj9y9i08fluNREvv630wCOMimrslSg1SZ2+AmHfzZh47taMIPh
 Fz+hjBDVYmNkGWrDOIXtG3bG7tTcx4IAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1419;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=u4YT2mRDI9vOEz0E0V9HN6GrYA7SOM0GmXxkYSP3BpE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnr1yHLLYyDJehS+Lyl5tVRCFBKAPeBmUjWYfvx
 4mbFH7/R6SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ69chwAKCRDBN2bmhouD
 16LiEACVvDtCLRMfuiT8VpQkuEZNPQh4VQo2O3u0UY/cT0x4qq2KF8l36vj4gL5Dt+BVNgdw0S5
 h3f3cq22DDVS1SqE7I4jIq25kHBHC7so1BPzOGChBxRbhjshsWDVwsTMDdURwLcPYFpZ+I4J7RP
 7HfNUR5lBUz+DRnITEtsfrEnG2xo6+GQZFxD0OynwUUyv3+TvK4maJGI7IEHYDOY5oRgYMRESkm
 UTOchy/Pt7bbmzXCKyO7/9VToAh07H31wz/OCkkyYiUveXSH7jPrIoD5vwhCMAf2k/dHHTa8tec
 xAOuSD6Di44KoxAQgEl4hbAW6GCCC39rXAEVEiJj45iw1KfjiR8q8d9luZhFjEOjLskntN/YiZE
 HB1/hNkErm3URpdzohJfncZWf+KGeGQXg70GpsFj3HPQiDqAsHxWwWN0Lz7z7/8UDY91R3X3Q3e
 Xq/gydE4d2uJGTr5XDo83fmWKKtLTlFarHqH+g9yErvskpQ3kKuSO783sqabF0pBxs61NcPbvAg
 cBHZMYvA3BPSSXOutPYBvWXvh3iN62uQbguq8NzNNzpyjMQ52TeZqsW3h/8udSQf08yQNH/dByj
 fZUBLRk2bbtR/vyDTT8241tFnwQ9BKBPo0kaebPofsmWzm8SL7pHQADR5zRzLg4WMQNqbjG48Yq
 N8x4UNYoVNrekKA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

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
Krzysztof Kozlowski (4):
      drm/msm/dsi/phy: Protect PHY_CMN_CLK_CFG0 updated from driver side
      drm/msm/dsi/phy: Protect PHY_CMN_CLK_CFG1 against clock driver
      drm/msm/dsi/phy: Do not overwite PHY_CMN_CLK_CFG1 when choosing bitclk source
      drm/msm/dsi/phy: Define PHY_CMN_CLK_CFG[01] bitfields and simplify saving

 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          | 63 ++++++++++++++--------
 .../gpu/drm/msm/registers/display/dsi_phy_7nm.xml  | 12 ++++-
 2 files changed, 52 insertions(+), 23 deletions(-)
---
base-commit: 883d3876ff4bb50d1b9431f525b4d3b257ead6f5
change-id: 20250131-drm-msm-phy-pll-cfg-reg-7e5bf5aa9df6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


