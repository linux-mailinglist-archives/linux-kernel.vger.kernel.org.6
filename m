Return-Path: <linux-kernel+bounces-187499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479308CD2A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3CC1F21E59
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C0C14A0B9;
	Thu, 23 May 2024 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Hg0cjJnF"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7514A0AB
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468569; cv=none; b=cVTj1XiIqotpD28xVQPRSjLhka1Y9caaJPI7PDEg6ygEa2/rtnMtkVKx62W6csyGXc331aBq0fzmIvtl3lQtlYad6MeAmFADE5prU2C17Ds3Kckd15SL+GsTMYZGXfclZ1MK1SGXLMsrhLGebqY138/RrUVlTQO7wd+tdGVI5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468569; c=relaxed/simple;
	bh=rYGWQnXPl7e+8ZR2q/kPCuviQpIOkOcbGurCO7CSNDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PckoISSyhyiAG1+PEIdM5PqQsowpDVdC++6oPtuEgW75QPhtNAHZ8QEY9xbIulqcG1Gh7bvmA2eD/bLl5WwzaYd9f7OhFq/4qMvUl0k/zMZrdTJmELPrP7bgauhCHnavH+8b4I/SB8/PaUHstHD+foSP/y5bjTeRBdT9VGpcpFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Hg0cjJnF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-351d309bbcfso1319963f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716468566; x=1717073366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDc5dZ2G0NhI2V2Vx4EMLzhVv0NLoW/2hnjkjc8WSGo=;
        b=Hg0cjJnFvE9lMBjA4bFAb8xIk037l7smad1/X2CxAASrTB16+mf+2BwyA/baigDAlP
         qjYk5RhEdqcVgL7V1BcPJ3aqlRAJrB/GsFOJ51Gx7YDw1TT9BRv2jB1mRckdpkhdxZxm
         d5gGujReO2cgTWImtiaLxY4qzHoEMBeGsikvhGQtpQhFccqVN4p1qjTxpFjVEWxZoIGS
         ZKIxP8IYpO8VQL6cx0NZTtmUE56MfgDhKxaKt+FwGtJ5iUdavjZ4vDgWz4V/y5a4JO9p
         VlxKFMTLegXw6uPEXaJQxLAVF51i77IZBh4MGS6D65oJnbuqrrjoqAPbDItXNoVHhM3j
         dUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468566; x=1717073366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDc5dZ2G0NhI2V2Vx4EMLzhVv0NLoW/2hnjkjc8WSGo=;
        b=xCM9OZ4DrXv01tRWtaHcZqFaAn3LrQyOx+sQY2AAoH2aHy55dc7/x3eoIs63YQP8K4
         6l7ZILB8M5GN+408kzQsYL9cH13FwUtEG8xoRuUGb5yUFc6Cd45LTXysUaHYVTRUHA+s
         Tlv24cD9E7Mj/0j+0zOcbH3xMx7CAQokOrSRqHshLz+C5PqNSIWI1qeakWdMGEADEDts
         CCgty1m093Y7f+3uFAVDjAyOOz7fkjIXIv824JVcz9d6BKbrmS/j8jiPJY76jgpIdwZ+
         JlHT7/NbRvsk0dviZhmuku+PSkOViCj519WI8DF4pTZ224/+S9PrgVy5GQGQArapmpIa
         /Bdg==
X-Forwarded-Encrypted: i=1; AJvYcCXGJYt0XYMjxIfTtArXXYHs9krwzPxDzAO27SDs0DO8HemDTfLMrKBPIRAqZ0Fte3gRFVu9Zb9TVPlqDHkoE71L6XZWAjYtqMwnngEi
X-Gm-Message-State: AOJu0YzJ/rTBuiUryj1GpBUNIxwqq2FWvqx2mCy2UDYz0sWQ/P6lymwP
	Yf2fsUwxo5mzFK3zTpKJ87CzVLdrO355vYa26gREfyq22k/IQR0JxbK85/kS05c=
X-Google-Smtp-Source: AGHT+IH8/w/D/ym66Jp2uFgYUse59/CTDw+EvixC5vITkP0BBwv3oWzuRnk1t8GSb3ZKNNdCd/k3Bg==
X-Received: by 2002:adf:efca:0:b0:354:f500:51c4 with SMTP id ffacd0b85a97d-354f5005628mr2531090f8f.23.1716468566458;
        Thu, 23 May 2024 05:49:26 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-354faf3fa68sm1259611f8f.116.2024.05.23.05.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:49:26 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 23 May 2024 14:49:14 +0200
Subject: [PATCH v4 01/15] dt-bindings: display: mediatek: aal: add
 compatible for MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v4-1-ed82eb168fb1@baylibre.com>
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
In-Reply-To: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
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
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=rYGWQnXPl7e+8ZR2q/kPCuviQpIOkOcbGurCO7CSNDc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmTztTHJzX/pP0aymwYIu7QjbfH/1r3N3y2tzTEGvp
 Qh+njumJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZk87UwAKCRArRkmdfjHURW/LD/
 0ZN8rHNVNvvNKuViGWaqPBEkwuwXd1VhlMXVPSXv1j7GbVtwNjsJbNXSXZenNBqXVnAUqKwSbFl1km
 7jYjqzscujGwOt05W3nhbgW2S8onp1G8X+JZkbkyjju/doC/uymiO1LuVXSeY22VGZFkcZwAVXEklV
 CIsGYSmmcg187TLVBBIFf/XagsIYbphmgzMdlNTVf7f/BP7qHMWQHdWfxCwm3IYTx2PqFa/jjHZD22
 ZQDg2MW7Xcx/pmsOxNr9esxW37O8eg6Ckh86y32Sn5KfsNfQeKMWNud9NEsDhdHirwWLFUBCm6p5XE
 aI+DSCwoCFKtBnJy9DeiRLun2nFtszXfTgfP518hMF7h36vCQCMPbZDDZp2HCfJ/B0BLStYwzgn1X+
 6hyzyDJgTHatE6cXE3V3Ut17QmZryJrFkgHs5/WkinIyT8SURQXURvewEv8v95T3LZrbOo9tnwb+Zq
 QYXKlf1k0GgpNGt6DWLMGbQrvsXb6qQN/IVVmUc7Q8W950Q1mPs1iktinGiS8AccGGOUaNSviWP458
 xJph6E9/jrH7ObFUK4BA+Pl429CwQnFjd0g5tVL4MrN+/tvmGOxEBb9M03ekQKA9XcfuCm0Oh0kv5z
 Fr1Qrt/7xTf8hqiexLhXY+5v3Y/ZKqgQgvHPsW9VsDt2wf8uiXTfG8+PqYuQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Document the display Adaptive Ambient Light on MT8365, which is compatible
with that of the MT8183.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
index 623cf7e37fe3..47ddba5c41af 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
@@ -36,6 +36,7 @@ properties:
               - mediatek,mt8188-disp-aal
               - mediatek,mt8192-disp-aal
               - mediatek,mt8195-disp-aal
+              - mediatek,mt8365-disp-aal
           - const: mediatek,mt8183-disp-aal
 
   reg:

-- 
2.25.1


