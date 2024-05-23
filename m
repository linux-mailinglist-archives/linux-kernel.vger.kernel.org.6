Return-Path: <linux-kernel+bounces-187503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8618CD2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA3A1F2215D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D8414B084;
	Thu, 23 May 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Re/XG4Vw"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD014B095
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468574; cv=none; b=MK+rjRHh9bJqomD92ZedflxT1LuT/xyIQSD/ck4GxZuee+NjZzSExViK68jEtXhUMZTEwoNyZsmzOm+hCQzrAhIKLxrsQ41QD+odKeeo8Jh/Yq22Os9vGqEieqk/hnnj3r/HySJcLaRVwpd2r6xbyvGxF9oQEdW4GaU5qOB/sc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468574; c=relaxed/simple;
	bh=pgul3jyPnwLlRqrVeieDrjKje7AnvTfN/5pB8LOeEww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u08GG2TiEsxge0/+LgzYJ1G2KrLXiwTw/K31z9s+WdASHBI119HdA/JCKdNoAXD8fzK+N6DVOsW7+xnhSumaPThT0d6ZlMbWllxJJTjsMTIINyQzlF95vxQvMmIYw1owUlBeRtm2Gd7BTuML/9Z8mFUj4Qrbhddro2LJYKNKJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Re/XG4Vw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-420180b58c5so18487135e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716468571; x=1717073371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4+lhQwg6d0dw4D/M2LqzYSihjAzASjj+z4J8l/ZvJA=;
        b=Re/XG4VwYGiPHvbqo5ZLfjLMWEzikX+nEe/TQQuLIOGxBO8iDAVy71Hvn2x0QRO0ie
         sKKg002LDKH9Xu7CUIhMuYKvCusZqOVyXe54W6kvFgv7N19AR9FhVl4qy1KkgAdQ3ke8
         kps+17yCalgVPt7Z0KVQiXnji1qZT8cJ+6R/rPvW82hdxdmxNwumgMpPSSRRU/Cqm6k1
         xl7k4MJl1jWw5j+ZctxZKe9M6iIkBfreS6kKn+XrukcIKBkirKXicIIal+iMFQ07DI8e
         vsXxNp7ymGy1ojDNfLHcBGkcXWCPFYfc9+JS7MehK4rE7FGaXru+ABVLjLHRTuABokXX
         rOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468571; x=1717073371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4+lhQwg6d0dw4D/M2LqzYSihjAzASjj+z4J8l/ZvJA=;
        b=InmvXNSBZTiqOSRywatXMiotaufO64CGB1wZ1GW54tXpEtlL+/CRZD5hVdyNO5UFeU
         O822Z6JxVt0hdTlUId+veu2xyOhyj2+LRFlEtjtwHnNAqJlTfONhMH3pZ4RHNLIOQeub
         6Z6DVif384gxlU5QhWfGNHzcNk0gMao5BQJU9K622pp1O+28aSS6RGKBNMT+kQQq5jLG
         sczMiw0F/TL1LOM3+d0IxnmgVlxOPTN7nTCLZ2fgt064d7JU3I9nKXyuPchqboj8I9Gy
         AlL+iKtNlCRcYRf4RciJJ7Vg8ryg1NqAImFZr8CIiLMOVANmNUeMU9jMH6wbAtFu/du3
         a0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWeNHC5C+eWXw/rXhgAEXXx0FFY/qarHe1+dS3QhNjSuXFPEHjzg5XLrZZh/ASC+jLk49wM8nhJpDhU+Tak6O7W/DyjCzhBE+n41E69
X-Gm-Message-State: AOJu0YwPM6Ytob7saDBacbMgFUr+AzXrS9e9ZAqnzH86jnz1D4BYGyhL
	tXWeqZwEsPuWGZafJqkAmMaKXb4RleVz8BcRpRosaFrkcRMMHNWj6xvIfOHm3ic=
X-Google-Smtp-Source: AGHT+IGE22UqtsLajB5J2AZLCW6T1wLmkDjk6Ujukx8eL5dtqwesn4j29CTzSuVzDnzCA/oY9cqPCA==
X-Received: by 2002:a5d:5486:0:b0:34c:cca6:3d18 with SMTP id ffacd0b85a97d-354d8db5facmr3414527f8f.68.1716468571321;
        Thu, 23 May 2024 05:49:31 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-354faf3fa68sm1259611f8f.116.2024.05.23.05.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:49:30 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 23 May 2024 14:49:17 +0200
Subject: [PATCH v4 04/15] dt-bindings: display: mediatek: dither: add
 compatible for MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v4-4-ed82eb168fb1@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=pgul3jyPnwLlRqrVeieDrjKje7AnvTfN/5pB8LOeEww=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmTztTJWMDmQgV1eFukFRne6luvhDCe/jawZVZUNOA
 UANg9eWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZk87UwAKCRArRkmdfjHURddGD/
 4pQDxdcLdE71Q27pfLrGFAI9JkPgBfXW99J0aWLRqy4VHlnPMUPUDxjN4uPw88EKX8/ofiTBGYAReY
 jVxWJwulOWiVE/UL6hHcI/dZRtlosGVE/nTzt3hM4o/yNfdvClPtgO+huPOGUW32N5UXMjkhW+zXlV
 L2aIFffducIIGxuuD1pJONWfkBvA9RNeyqZvRj2M5ouTSvnastV5wdWKkz0DDp5250jDvDz0B+/trM
 /temZhZwC5129b92SQdZqEYq33AS2tU04hHcmlpV23FNBlvWLblgTG5mOSQ50nfxrunMWV/I6ZQzNy
 ZbElei5EV48g4kbgPdAg8M1rsLaLZ1Inv9zV1AiHE7tly+gtBLAAOm/8bqTq5AFLJyK8z72nA4finq
 oTZ87Ohrw4Vyi3T+EGk5/EFoPUI4aYWS8O4oUDbN/Aw443qJbjtMrizwXKrTjXtZtJL3wl2Arkdb4I
 yeeW+Okn9sPqwjb+EqKyAYWA3iVLuT0heByHfKrRmcRFj6sn/CtYtJ+APQCzEC85GoJlcVzqcVCj5o
 k/QvVNe2a47syYoSyljC2jLLH0D6VyqAWdJ745H38BqBxX60vIOcMNRztD3vkIMgwZWeUqisK/yFqy
 2TsKkN97isXcuv/g2FhAR2TSbpHgw38WDbw40Ipzc8htIkhT9fmcWAf4kaKg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Document the display Dither on MT8365, which is compatible
with that of the MT8183.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
index 3d4ab3f86294..abaf27916d13 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt8188-disp-dither
               - mediatek,mt8192-disp-dither
               - mediatek,mt8195-disp-dither
+              - mediatek,mt8365-disp-dither
           - const: mediatek,mt8183-disp-dither
 
   reg:

-- 
2.25.1


