Return-Path: <linux-kernel+bounces-187500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EEE8CD2A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2515B1F21E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4B714AD38;
	Thu, 23 May 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="deZBBX3f"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5021474BC
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468570; cv=none; b=JuMk+1x1+TDiMmO7GePvHMoPwDMN559dk/KcbRKHNzB22VcUOBF7hAwyieeqjkJu5JDsf1vFfDMq7Tp5byJzM2/uxcjofKKWbT4Eatb75rDJYiEo/lP3T6IvWA2zNiBCmUPJJuQOCcKkDN/YnyKLkbQDwhnuN+akrtq/C3mW/6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468570; c=relaxed/simple;
	bh=C7fb6vzetq5ZU7eJKZoB5RoOcLjPpbbNJrU4NnwRSZc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iHQ7SL784T8yFxb3ayEstDZ1SC8r+Nh/ldhHyI3Rx0HGgfqDici4uHfUdVhTGXxMgW63z44caq4m3x1zNicnoIy7yHNioqc6dw+mCKmHvQcpSjaIUAUCK/q6Tl2VIPMMQ0yOT7SrP+6IbE+2UCLKdUGko1E8DbNsMR8yNAlix6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=deZBBX3f; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3504f34a086so5010322f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716468565; x=1717073365; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5RaZkdxauaYXfbvyvKa6gyD2x+fNrK3XRhxpmIfkZk=;
        b=deZBBX3fc8fYaXGCmLQBAcG4md7CNcI/yIW86QSK2qvE3ljd1yr0WvmsvXHKzB3rNc
         vU1D8osWyK0wADtNVvKj1whsjbefb4nQFRQZ2uhEvGje4NpvnQlaWd7Nx7EneyXXffN2
         IwAuftEZRzWAyFqKcIX/Oo59SC/QY4fQXMSGlbRr9KQLlA1wsrYTE6KG+h/fO52L99Ua
         M5d8m8ZlaOA6Gqp38w2ibC0j+g+KFVIkrgIDHNgqYULDsj5dlWaZejAnsLVU7n0qxNqc
         FmLC373ZLKVVe5ZqwwYNf3Qel//4QDy49rj1GFqnpyo3fzkUa3+UsLPngfngKTS2Gdnj
         jGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468565; x=1717073365;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5RaZkdxauaYXfbvyvKa6gyD2x+fNrK3XRhxpmIfkZk=;
        b=cvg8zGPRmhLeEE3C8Ia9h0CNVchr4h+B6Zo2m2McW6yohxWLeihA7/2FL+7xc6T//k
         CoJtlmCRWblntwdiCh8C5YxhPM31P9lopZXFcNPKl47eIacURFLwve3b8XaNHB2lB+mh
         ls68UHSBg6FqWM4YuB+AnQd3Jp78FOHlBJukyiV9H3+TDTonWkZTZu9irrCKAi6cPD8y
         yCXY6aHTSbCUK5kpdKIki+nQJFaOc1zRqhyYKpspI8JRFGb6cxK8ylRUUyg6DS9R4zNZ
         ceg+aEQaSG9tavklxydlW4sGLgcbl8L6URcTdZ/Crx8eIKP80fobVFKgOXqpgVmtThFH
         bDvw==
X-Forwarded-Encrypted: i=1; AJvYcCXA22jAS+OXACOuBGxQd0XuYqxwC4iEeRSFhTR5sVBPzLTokZ60drHxGdNb4OJqTh9BEq3j80W/NZNqVhExtJ8zT+IpTRzqSwBgYiKg
X-Gm-Message-State: AOJu0YyaWfCucGNFgfblQ2+NEY69IK9WjICLMBRarR/fCiUXLPJxatv3
	tKLqauwJyjn2w6bDNcEa0LTXzuYTpet4lrVTtRmq0HOm5o0Ei5vyR12GXZ/I4S1r0nzVL8+oC23
	xmA8=
X-Google-Smtp-Source: AGHT+IHqEiyqrTp7LMxvNs2yc3pjoFF6b/IfjewpD+KY1pkilwCf+jGNlrljBdFDIaw7VPg2BoJfJA==
X-Received: by 2002:adf:f509:0:b0:354:bc5c:6963 with SMTP id ffacd0b85a97d-354d8cccc64mr3588960f8f.16.1716468565082;
        Thu, 23 May 2024 05:49:25 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-354faf3fa68sm1259611f8f.116.2024.05.23.05.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:49:24 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 00/15] Add display support for the MT8365-EVK board
Date: Thu, 23 May 2024 14:49:13 +0200
Message-Id: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEk7T2YC/4WOTQ6CMBSEr0K6tqbtK1hdeQ/joj8PaYJAWiQSw
 t1tWRoNi1nMJPPNLCRi8BjJpVhIwMlH33fJyENBbKO7B1LvkieCCeBJ1Pk4tHqm8TUMfRiprSR
 XBhhKfiapZXREaoLubJN7I8aR53wIWPv3tnS7J9/4OPZh3oYnntP/GxOnjJZWVQxdaQHM1ei59
 Sbg0fZPknGT2EGIhACwqFQljRCnHwjYQUB+AaBUDehAfr9Y1/UDgMizT08BAAA=
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Fabien Parent <fparent@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4708; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=C7fb6vzetq5ZU7eJKZoB5RoOcLjPpbbNJrU4NnwRSZc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmTztT5Bhxm5XHOggjDXk9dLGPF/rwS5HRGXuNUV8E
 eM1x+yKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZk87UwAKCRArRkmdfjHURdJyEA
 Cg3bDewemZXZpwMZ+hzD3CnNlWwVQriRJfA5CX9ph6pBGMPNiCEYY7KANNRnxaoUIl7MNQEclY8ejc
 y3Q0AXGTTlWOHpaggbs8cbHVjo+3aog4DleQAlRZ+Y2zCaEt9GQrnrVnAyp4iUDB8Z9KHK9YXUb4er
 ImGYYDKAbGRoa31tg2Vm7zgd5aGwTfqdkDHaqIcT72dvC+4QPXXxwodYR8joFiiGooWRgX5DmZ/+Ur
 dimhH6AlR5y7lXCKyqGF8hVMHwI8s5fNWpV/IIE/av6jKl4o5893ShBb+Ygl8fSvETaI3atvD0WiRH
 hwXDAWeK7gw63JOrp59psmbfmXI9LepAg0rdCG0WZI2RM2OFGee+WyoVI0NINhRWC2WzdM03f5oelC
 1K8ptO9Q7rvO5r4TGYdF23reILcNaHhGgvVGXTa+IpUzi32VH2ZCv6NlG1g+2CR1QZZlGW2ZOU1yyi
 fi0WwWTzydOo+uV/YrO06djxYOrDdO07aZPmHcagUb/A9c1+sgUJG8udE20+Hy9+Lr7kOHg7nbEH6c
 H4NVpjHKjkM5GqQn4sJvKjozTxapmOiBPLzzHHC/DzMv+EdBFgnsptY8lEg5XZagqMBorrKNjEQIc4
 MEewmx6cVDHOFn33OkHzqitJKWDriemTrwBBtqxZke/24biWUOFfqIsoKWgA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

The purpose of this series is to add the display support for the mt8365-evk.

This is the list of HWs / IPs support added:
- Connectors (HW):
  - HDMI
  - MIPI DSI (Mobile Industry Processor Interface Display Serial Interface)
- HDMI bridge (it66121)
- DSI pannel (startek,kd070fhfid015)
- SoC display blocks (IP):
  - OVL0 (Overlay)
  - RDMA0 (Data Path Read DMA)
  - Color0
  - CCorr0 (Color Correction)
  - AAL0 (Adaptive Ambient Light)
  - GAMMA0
  - Dither0
  - DSI0 (Display Serial Interface)
  - RDMA1 (Data Path Read DMA)
  - DPI0 (Display Parallel Interface)

The Mediatek DSI, DPI and DRM drivers are also improved.

The series is rebased on top of Angelo's series [1] to
use the OF graphs support.

Regards,
Alex

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v4:
- Rebase to "next-20240523" branch.
- Patch merged, then removed from the series:
  - dt-bindings: display: mediatek: dpi: add power-domains property
  - dt-bindings: pwm: mediatek,pwm-disp: add compatible for mt8365 SoC
  - clk: mediatek: mt8365-mm: fix DPI0 parent
- Remove mediatek,mt8365-dpi compatible from mtk_drm_drv.c because it
  use the mt8192's data. It's a miss.
- Add MT8365 OF graphs support, remove the hardcoded display path and
  rebase on top of Angelo's series [1].
- Link to v3: https://lore.kernel.org/r/20231023-display-support-v3-0-53388f3ed34b@baylibre.com

Changes in v3:
- Drop "drm/mediatek: add mt8365 dpi support" because it's the same
  config as mt8192 SoC
- Drop "dt-bindings: pwm: mediatek,pwm-disp: add power-domains property"
  because an equivalent patch has been merge already.
- Add DPI clock fix in a separate commit.
- Improve DTS(I) readability.
- Link to v2: https://lore.kernel.org/r/20231023-display-support-v2-0-33ce8864b227@baylibre.com

Changes in v2:
- s/binding/compatible/ in commit messages/titles.
- Improve commit messages as Conor suggest.
- pwm-disp: Set power domain property for MT8365. This one is optionnal
  and can be used for other SoC.
- Fix mediatek,dsi.yaml issue.
- Remove the extra clock in the DPI node/driver and fix the dpi clock
  parenting to be consistent with the DPI clock assignement.
- Link to v1: https://lore.kernel.org/r/20231023-display-support-v1-0-5c860ed5c33b@baylibre.com

[1] https://lore.kernel.org/all/20240521075717.50330-1-angelogioacchino.delregno@collabora.com/
[2] https://lore.kernel.org/lkml/67f13b3c-18b2-4042-9908-b4d41c24cdb0@baylibre.com/

---
Alexandre Mergnat (13):
      dt-bindings: display: mediatek: aal: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: ccorr: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: color: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: dither: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: dsi: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: dpi: add compatible for MT8365
      dt-bindings: display: mediatek: gamma: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: ovl: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: rdma: add compatible for MT8365 SoC
      drm/mediatek: dsi: Improves the DSI lane setup robustness
      arm64: defconfig: enable display connector support
      arm64: dts: mediatek: add display blocks support for the MT8365 SoC
      arm64: dts: mediatek: add display support for mt8365-evk

Fabien Parent (2):
      dt-bindings: display: mediatek: dpi: add power-domains property
      drm/mediatek: add MT8365 SoC support

 .../bindings/display/mediatek/mediatek,aal.yaml    |   1 +
 .../bindings/display/mediatek/mediatek,ccorr.yaml  |   3 +
 .../bindings/display/mediatek/mediatek,color.yaml  |   1 +
 .../bindings/display/mediatek/mediatek,dither.yaml |   1 +
 .../bindings/display/mediatek/mediatek,dpi.yaml    |   9 +
 .../bindings/display/mediatek/mediatek,dsi.yaml    |   1 +
 .../bindings/display/mediatek/mediatek,gamma.yaml  |   1 +
 .../bindings/display/mediatek/mediatek,ovl.yaml    |   1 +
 .../bindings/display/mediatek/mediatek,rdma.yaml   |   1 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts        | 236 +++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi           | 336 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |   8 +
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |   2 +
 14 files changed, 602 insertions(+)
---
base-commit: 5fe1859247a981fa491507de2b1ba63e84addc38
change-id: 20231023-display-support-c6418b30e419

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>


