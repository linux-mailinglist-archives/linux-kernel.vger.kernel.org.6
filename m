Return-Path: <linux-kernel+bounces-258538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDCE938961
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25472B224DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301C7EF09;
	Mon, 22 Jul 2024 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aVot7Q7c"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3281C6B8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631252; cv=none; b=YWrgRO1/Ra7ef/ZSvh1r9AH9c9JVgJM0VmqpdUonF/IkGnOF15UQ3l6rVDHVAyv3vUd2wVRJsy71Fw/bNz3Dc3rSfhIAsKI4uGj6IcV6bprBcUKT45AUTy8FwxWzlUCVV7lWYi3bt6pHinf73DTtvfOIYBlHE5QPbYRV0AQ1zR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631252; c=relaxed/simple;
	bh=Bna7lGeZ34+vVkeOzBYfhldONP25svJS8tOELxKnAgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kyBM15dGQKcxoa1hfO0yXdN7t34XX7zccEPleR38h8oFSfNg7CELh1EgGqjm7Q59HDgmGkdeJBHJHrUYk9/mSaryUBy87/5vBN6GNvtyFaWeLNc14LTEeCVQGetP5PIwekv5LmLeG1Rp6Gdq1E4NMt58ElQUTwDJW+AzA8vKdIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aVot7Q7c; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so3114613a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 23:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721631249; x=1722236049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+u7W92havYZUIlpwYblhqqwSvlNhEzQdYNsq1VBwl0=;
        b=aVot7Q7c6NBEa4bAhXmi9tyj3DX/rdcvxh2IISWwX9l0xsr+mkclXgAJewKB2JM/1P
         u70qHjAB1eA322lcHu1C+fxPOcyuuA+sIO7tNO2/UtGSAQ7M/qQl+3gjlA8E0Yew6ikK
         yDp03ZgSZMvNXq6jdk8CIijMOGDR8btlZATcH0luWjXvkODpL5OF0ver8rrLxaVhGoRN
         We4kPhVjECUGNJPed89RVHD3qpH4dE8M+ottQe8z/oW+IBjr+O5s/NDiO7HfJeBVhc8L
         D0+gloyOhjK1svVdvEEvACpPxgvNdBHJ4ZPkdjCoQccT/OZjGitRYdZ1kjgeHqdAAo3c
         wTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721631249; x=1722236049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+u7W92havYZUIlpwYblhqqwSvlNhEzQdYNsq1VBwl0=;
        b=DQzMl9AZzc839K98669RytCB6i1K72DGNuH7yie2qYRyO5Yzb56rIgW2mZ68QaJn4F
         mOpj2nuY4VQD/I+ACXghFM+9/KcIi1a3D3htOjVyMjh+8yst85h5KdrvoytenuOWjEcQ
         j9SeVEx9Vs0a387LJSO4v0EUfCuRCCx3DqzChzJT2hDw0oCskClHT9eQWEik9BM7P7Go
         MnfH/FMhOBYm/uxqxvq2I9DiX9Et4rGvxMu7G4BfRO7lvg26XAel6Idl+Bd45MseUY2c
         gXSeHmO5wYmGyb/f7vAy1Syds2p4GOgkn4uGDuKMslsrA6AOdiqCc+Ge6PFqrE3UCE8W
         0FQA==
X-Forwarded-Encrypted: i=1; AJvYcCWktnJY3ncItR1eG9GIJcqeF3OTv5jCnvbMr95W5YuSkEa74KQcXSEkjZAfuBF2YYnJL8xTIMw0P0/IH0mAr91EdkAyjUmmD5ICxa5d
X-Gm-Message-State: AOJu0YyR9FZhVzUArVjLLaM051Ig3+FMqIF+ZLob/8zrEmC5Ls333Mvh
	BywtSMIibmFYczK7fm4WQiWEJQoPbB8ENQrz67JVHIvhs2dtx3oNIPVj3zE/Xho=
X-Google-Smtp-Source: AGHT+IFujFs1sGJ63tkG3t7eMu1L5vDcioENHIjwLFIzn8k7Yeds1uPgGTvzxdZX7AvLMdrnfahf2Q==
X-Received: by 2002:a05:6402:11cb:b0:5a1:225b:4233 with SMTP id 4fb4d7f45d1cf-5a47ab11d7cmr4605872a12.23.1721631249220;
        Sun, 21 Jul 2024 23:54:09 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5a69c1f56a0sm1982126a12.64.2024.07.21.23.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 23:54:08 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Mon, 22 Jul 2024 08:53:43 +0200
Subject: [PATCH v7 14/16] arm64: defconfig: enable mt8365 sound
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v7-14-6518d953a141@baylibre.com>
References: <20240226-audio-i350-v7-0-6518d953a141@baylibre.com>
In-Reply-To: <20240226-audio-i350-v7-0-6518d953a141@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=860; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=Bna7lGeZ34+vVkeOzBYfhldONP25svJS8tOELxKnAgI=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmngHxfVG6iGXjQ3z31grSqs43cXnJ8FDoaVpwi344
 ojLOAjiJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZp4B8QAKCRArRkmdfjHURb7yD/
 wLghhgERwAWzgSENdpf8qwjr9EiINrnkjpHshQg2NvDsSIy1UW/NMQy6Myi//74u8oHK5pJO+TaH4c
 Ed2SXiuRRDhe7S3zuA21M76Jr4Iv4f0UuDj80IzZJBTGlRYOLfNqTVHae/d1gh9im520TqF7TP0aXZ
 wukLxf3ne058bpAR6fEbjyur714glk8JJCjTruN7K8RctI2aPazvPLGS66ANsZ/dF2zR1dGCUiGRaQ
 XXLxBDpMtK9fZvAbk+QP2oH182xD1cZGK5KlwqbjNk3yf5YOBANZgXeJyrANpV1Dyym69dHJfaxzzy
 czFDKbl35fJqiehFpoPmTZN8O+S5A3a9WIJf8KAleXeralPjD0/EkyVg8HPr0U2PxlY/TYQX2ikeHw
 M1pXop4pqlmZTXGBcAiJW+CzmVmDASqyVkg/eBvs7503s/NxC0qWBbVgYu64nTmAeafjD4R8PKGV4R
 GohN9mo7c6ZUDz4uI6LkA6qr8IcaGawsEPiuPdnXzUWYPS0NRQYmZzogAoXz4af0U4fVf5u1ECsxPc
 r1ERZ8jJ7bkO+Wsrx0+sRsdf0RDr8IdCOqQ+Y1QJfiirrIwq4ue8xqTl+Usbw3+gN6erRmvhftYUng
 /DTVMBN6rV4SgL6SEwU7MLGsshxHkqWfqNooLzCys81e6/o112VdofNKAnew==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Enable the MediaTek MT8365-EVK sound support.

The audio feature is handled by the MT8365 SoC and
the MT6357 PMIC codec audio.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a6c9688fee0e..f16ac6a0fd46 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -949,6 +949,8 @@ CONFIG_SND_SOC_MT8192=m
 CONFIG_SND_SOC_MT8192_MT6359_RT1015_RT5682=m
 CONFIG_SND_SOC_MT8195=m
 CONFIG_SND_SOC_MT8195_MT6359=m
+CONFIG_SND_SOC_MT8365=m
+CONFIG_SND_SOC_MT8365_MT6357=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_QCOM=m

-- 
2.25.1


