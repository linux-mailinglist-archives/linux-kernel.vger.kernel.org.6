Return-Path: <linux-kernel+bounces-187513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969578CD2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52985280FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4701514D8;
	Thu, 23 May 2024 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P4dvIqxi"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE4150984
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468587; cv=none; b=MR59/GOe9YHgzyFDQ19oBd+1TSX06OR4vdmPWdSAsmiwj6eU8MhdTcrOaoX5o9EGQOpC8CbjQhGM1Ibs5CwNpgq+Ulhejqme2KN4L4q3K53AoW9gWMXjEV8AVSo93XdnIZAIu+hxLA48i5FoVLs0dqZ37efnf8k6YgF9O6gC1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468587; c=relaxed/simple;
	bh=lT6J9gv517qEQpypdtd6Iu9RcuwU5IxfY3HAdtX+bNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYJ6zd8yRDdypIHAP3Z8sstvft5Zk6fBs4NV1Wu1KPESogoyGh1PnUanShQPTEKz1M7Q3yXGkFnSG4XdmyZS5+Q/YaM61GpoaffYkIQKgrfYQRc8f4iLz/Rl14W8G42FgvciR6jwdMt/uwqXoCWcyv/O/YlTbbgm7nvc1fy2u/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P4dvIqxi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-354cd8da8b9so2046116f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716468584; x=1717073384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tla+QFcP97ewfTbQi7g23xuxojyfOlpLXvPFzq8Qwg4=;
        b=P4dvIqxiPIVq3ruZ6yleaI8khH7zLdXbHq4hp04/DallqrM4w0Da3g7ZRD7EWFl/UC
         +3jHIYXpMvUgIGq4s0y39Vk4UGEnsrcpUUW7TKQYc87GIgCwpKpVTAcfUNcyT8pcMRcu
         T3dW3GK6st9neMRhsvGqA2TLYbqw64ggP/dtlUPmZK3Ckag7oreQPKk3Zjqh3fJB0IrL
         01z4Rt6YrYAXca+fTSUCQ+vskz+sa5aEPEy5UnDGEp/UUTnC7TxM8YkYOc7/Zb21KP+l
         cfu+chmgzvp7Oyr9z12LsV9EonM9PVMGd96KTW7aNxIMJ746pdmkUvXcTK2bmDJ4qLbn
         GVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468584; x=1717073384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tla+QFcP97ewfTbQi7g23xuxojyfOlpLXvPFzq8Qwg4=;
        b=ZIBpOu0DBRE/nl9uHMg4RfAF4fZ0Md0vFzY4szWwuIwpGqyET7nqifXUfMpTT+elH7
         CtKbXnzxuJKX+Ss/zinYqNdU2SXFhbyYzHfiZ6y4CH5c1HvGged7F8/1eu6cDFZOhuoh
         C9+Z9LM/H3rT/4+t0Ra+RQ3xU69fDr+9ZFJ0vVpPR/pxhIrd0eRy6i2oXE68Q/GHqFbH
         Yw3JO3kkFZ/F047ksVX9TvpVFLmFXQUOLwCa+NbLnshZ62CkxPrT5quOOmozAIigQU/1
         Yv73aWYcT15TBbfjmlzF9LmGSNNlRkiFanGbJwzB3fbQ0quICcu5ZMXOh0WEwNE1qAFU
         7zMA==
X-Forwarded-Encrypted: i=1; AJvYcCVmHblpMn5YoWhTuj0paxgWI2v24fAnyIquz5WPpYMbkKmr+P2MAa7iiilkp7VeLZiiHvOK3x8xCdW0EnsBY+peUVtwUEDQT8ob7jso
X-Gm-Message-State: AOJu0YxWHkdem8iuVDfxncdhj09JBAtBWcwARZ0AgQqUhWPubT2Ysgr6
	SyXDVGiHWlx+34UIEj4WDzsrfqO9zsxfOanFFeMW536bSX0RzeGungXaaPWJ/1A=
X-Google-Smtp-Source: AGHT+IFLhyC8Xpob3M3s4Cxdqi4ACW/Cye9oy07BDePPRH9xUy37KKFTstNcxwjc/zHabOXrMLcPSQ==
X-Received: by 2002:adf:ef8e:0:b0:354:f6f1:82d with SMTP id ffacd0b85a97d-354f6f10b38mr1729718f8f.67.1716468583878;
        Thu, 23 May 2024 05:49:43 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-354faf3fa68sm1259611f8f.116.2024.05.23.05.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:49:43 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 23 May 2024 14:49:26 +0200
Subject: [PATCH v4 13/15] arm64: defconfig: enable display connector
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v4-13-ed82eb168fb1@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=693; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=lT6J9gv517qEQpypdtd6Iu9RcuwU5IxfY3HAdtX+bNM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmTztTj7oyWFDNqOH2/emBzEE6Rhg5Wol/HE4THuRE
 L+4q3siJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZk87UwAKCRArRkmdfjHURZ8LD/
 sFyC5Joy1O1vuXzM9ubKBm4QaSmd7AWbmjAQLbyxBipVHccFjqq0cUG5F1a0/awy6JyazMrSGvTeaS
 Pw2cJiYytxRFt9wnaU95dJR0iBlzRsHJv9LegsXbVeDQhDdFs62sQoE/GYZx7xXQ+jewDmloFf0x+B
 WEbrMNiYBy+mNfXPakQRAkudGwHFaNjOjrjo84cdxcFaRw/Yj2VPqNejmLW44onVsu0oPAPKY16LCd
 3nDGa5pH4RFvtmh7q2bgdMZG6+EpV8vllDQD4C8rLQtbbgRlSWT6x+1MP/RfAx5fRrHPaA2cu7i1cu
 4uJOHNHTkMWr5Q9K5UcfowqO45Ngs/2QCu7gR8fgvpkVTE/7MsWqIxTr2SMEMJ2HjFWbUAeTEvW4d/
 SGohMB3IfKQt54delkSDE7qZCiBDCG+gJ3kAXdgwzmZYE/bwcjGQsFMeACBnC/buhruAT1hsJpulFQ
 /+S4osrgiCBiBRgvg3tggDrDuUrX8RMsyapeXXdkWJ30m+monbTvWJdlFeZtjBrFvGQdP04lwgUtts
 k2DG79Vq8DhBvHCZQkvAxGy2mE5WGFVTsoq/QCpQmdds8beUX5EgAzb/WfSFYww/d03x/B0kpmyCmJ
 jcQMzsE1Hex3G6qXQQCVaOFOJBfr8fWMLYQVZ5eCN7ggFPGVFzCVfyXlh4Ow==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Enable this feature for the i350-evk HDMI connector support.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6281975199c4..7dac8f92b0b9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -881,6 +881,7 @@ CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
 CONFIG_DRM_FSL_LDB=m
+CONFIG_DRM_DISPLAY_CONNECTOR=m
 CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_LONTIUM_LT9611UXC=m

-- 
2.25.1


