Return-Path: <linux-kernel+bounces-187510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217898CD2C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CF71F22D52
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9702214F9CE;
	Thu, 23 May 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b6rNvJsU"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C07414F10E
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468582; cv=none; b=n/N/TtvtdaPbgc7TWOmufke+GYMku/DCQl05+/82SFEE+ng3J+lswWpB93VXNOAnY4amnk3ZXx0O+TCG85h1AgdxlnSJQL0mM48W3AlJr5MWKkMa2NuQQ35fKmHo7YRSRTO/iAvj6/KkQHb/BTWLxYarJHAJK1C+kottj1/D5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468582; c=relaxed/simple;
	bh=9RgySSODKXDFtNBIppDoD83d/BgQN7IfDe8Mj9kVPEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTpVVBErDaMIiKHWsKVwuhTXf5jhLrmkZg4n8zi1YhZMa//g+kjT5ffsSU8WhFVqOsSIQiEookPMoKSQm3za+65c6nOQLh0gPdgTChdeHX+D6Ef2mg3ZfF/j7C9ebbv8LCfRZHYQ+e+STV5h7bTFndQgZzcKDyEqTW7Y8PviIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b6rNvJsU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34e7a35d5d4so1771324f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716468580; x=1717073380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hq7fu9lKeXTgrshzdpFsaVgKo6fIiiCmJ+5OHF+gZs=;
        b=b6rNvJsUEoDucLwd82BSSUskgq3/jx/lmJ1nq4X402KQKg39/0TJD3mVt0f1cZMiZ2
         eWY6cKUznGdc2BfWez41DudoGrnsXJz9MDCPRm447imeyc+vfTVGE4audsfC1ygLikQm
         hFXScMI7nCzk30wIJGqGLtJSIqDFvGAP2A0KgPLKz1LPqTUdR5n6sboZGhxdFqYcwVYG
         jkBttJIvkkN0sWbbH8zPHDDUjKbOh7wOLgtGZj+c+nIdbhmDt2G2wgCRxLSR6EPKdfcM
         3nQhpAuqFPcq7gRBOQ7jwGv6M93W2T8hBz3j74PMeAp97OK6q6XXiMdk+Y7NwKmuwGrR
         GiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468580; x=1717073380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hq7fu9lKeXTgrshzdpFsaVgKo6fIiiCmJ+5OHF+gZs=;
        b=sOyitOpDAKTa5EnqklkzykrAh7oqqtfO9x6tXOCzeBWk4LcucM9JX6+Y11NmcWH4bG
         vyMKGt2OCRC0RJmxWCTboxap3GiH9LVtM6MOFRSOpvuZNQAuvW1wMUjBJfb9VGuRHpIt
         2gHNVnaoVOTgR71SwKITGo0QEx3tQHBSb8Ms5ZY99zHNz/+p8c6Jya9EhJlHGu92TLkU
         Aywqa0ct4HLYZr6jZlCWGzWJcMxg9XHSWS7chodifwh9+TaFX9Ui6AyWFKzuAh4ErYxb
         /KEvxiozwYN240H/92suzXtBAMxN40dhFRivF6xZHQkiWveiVwOVhIgu5eLc01Ibh7e7
         7XkA==
X-Forwarded-Encrypted: i=1; AJvYcCU7zcGqBoj+moxcQ7QA8i6Wz7/oy059ylzdrRE9zi4fCN79Jx/5xckWLj2rFTs/ZVPOitCvXbbn+/PnFz3IrSWQs6Fl34AMZPJ1Z18d
X-Gm-Message-State: AOJu0Yw79I77ZoBDNMva52grwoZthC25zcnnvrNgfXc0oHMHLVALs961
	vyIRVdJ79TQ2U31Et7pSxLtO8X6gqbFUR14/dhQcVpO8elQ/AMY8+6gZekSd1S4=
X-Google-Smtp-Source: AGHT+IHtfgcFAHCNKc1JJLUdRiLvcwprOJFdCfAdBFglIGxFEJ4vrqXkikSCSJEtDhSqbfnzmVOiFw==
X-Received: by 2002:adf:ab18:0:b0:354:de96:d26a with SMTP id ffacd0b85a97d-354de96d776mr2915534f8f.17.1716468579794;
        Thu, 23 May 2024 05:49:39 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-354faf3fa68sm1259611f8f.116.2024.05.23.05.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:49:39 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 23 May 2024 14:49:23 +0200
Subject: [PATCH v4 10/15] dt-bindings: display: mediatek: rdma: add
 compatible for MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v4-10-ed82eb168fb1@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=9RgySSODKXDFtNBIppDoD83d/BgQN7IfDe8Mj9kVPEc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmTztTqPg+oDl98yeTzoXSSrSOvhaYdFezpli0P5FR
 JKM6KpCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZk87UwAKCRArRkmdfjHURcEQD/
 9EtbGsiu3ulrzzGjMJ5wGDXHsuyanF+WSqI4Z5YunbLAde+LdkO85gVphFDcYO0YIWuC9O42glwNHG
 y/TXwlPvfq9vD06dRmVngxd2P9BxMQQe4Ewsu0Tx/pXqaQZlJuO6xFXSLi73EjcfrACF+LXwFFSo3s
 /yvIZbuFDuqPO4l+fISmSq26J1z3rqPPVvdD1ZgKyjvEWg7MGsQ+RaHPhhuet4vU+S+SNjojFMQpJA
 YjCctmauXTlMyYkt16f41ffwOadhdgF0dPMJYGr2jLMN77d74XDGQ2ZrGqqeTgJ5ReMSls215GFtgR
 nWcLvLbv7dvRQ7DAM0Ie0XpXxkQqowIe3sz8SwpGkutorS28xGe2lYy3s3+FuKi03neXlPmnKO40UE
 vYCZtzy0NEziDBPwTDwiI4z7Pe/Xivpm6eonaEcI5x3bFIndvdP44rjNl97teO6vcfjCP5QRDiNGGU
 WHJwbRtl8ZZyfXp1FZFnNWzUfcsM/DyHtnBqpCorGoz3sgoS/InosNtERdgZKdBwaSFBrzcOrKyg9b
 9FpcYphA399Icm1nHIDqKnFvWrCps0aBliBj82wUnp1mbiHSQIAISFpd1/L9DYlqI+x9vbxhHjNTqU
 u9LXP46Bh5oZGiXUKLnnpKoflsjNGN0pMoml7UHpEXqjGyHR7v8lphTIRbOA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Document the display Data Path Read DMA on MT8365, which is compatible
with that of the MT8183.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
index edb8d3b67025..878f676b581f 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
@@ -45,6 +45,7 @@ properties:
           - enum:
               - mediatek,mt8186-disp-rdma
               - mediatek,mt8192-disp-rdma
+              - mediatek,mt8365-disp-rdma
           - const: mediatek,mt8183-disp-rdma
 
   reg:

-- 
2.25.1


