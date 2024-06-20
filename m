Return-Path: <linux-kernel+bounces-222392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACB99100BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113321F26123
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241A61A4F2B;
	Thu, 20 Jun 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M37OBhf5"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15856433BB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876875; cv=none; b=heOiPiI7ZYnxbExzn4P+Vk/gI03gVHUUgR8CFOXSWpuJ8CfkyYrCsZ7l3xBVsiyQ/JTIRS2nIovg7NoHmGYLAl2n/OW6PPDyCJA3LJMvV9NjuPvc5OufikNg1qnLysRveV7ssNYtNAPbSAnWWbn1KqKcvEzqS1puVP13EUSPHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876875; c=relaxed/simple;
	bh=j3C/MSc68szGmgajk/pVH5MuPLTbquJACCDFlK1wIts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fs5HlDAa2IKVCBwpXmTUIaKd8UE3Kmax8Rq+0SBKiXTAirawfI6gOXfnQoyZxc1Ii1V6aaoaPG030K1w3OrkaRxK4ajS0hn/y8ZFjBb6O/vJAal5puf9LoJpnyGW+DBf45+osA+dqc1srex6Jg4WsiXIg/BJGx6qPf1UIvlzjpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M37OBhf5; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ba33b08550so275717eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718876873; x=1719481673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbS6t0OdeyDit4R19wkIMr1rdbV1YFpFh7032Z/OFdw=;
        b=M37OBhf5FhzzVItweTqh8Mp/sqTOQCwO0dgwQjZuPbaEj8ieemLaV5QZFaGt9u2VVj
         YAdvpjCY0Vch+HLuQzsu/o9aJpYWdJvIKmg791ZiTv2a/jlIrgo9SvxenyyIx46QGQQ/
         gq1hza2oCC4CYrBPJ735BPXMi9bNBbIF0Oyw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718876873; x=1719481673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbS6t0OdeyDit4R19wkIMr1rdbV1YFpFh7032Z/OFdw=;
        b=jGS/4hbj2Hg2JKF0qKpfFawXapHmSx3q6YOKUpKRWyru/0h8TlRnGDcXRi40NRypK/
         +LLJ2bpm155D94Dt6MiojRXzTSkUhIj1xCiyd9AqUdIVeE5I4DebKlUse2ZSC8SqY7dO
         hY6E4fsViJEeoUAqa3Xo1ZaCAEdvQ15oegzMd1v5ez/3ibPs3iQDgVASmGcK06MVsDPR
         drKW0GmBXC54WHZFueCL2khlrBQ0L4r11aGsgHnQkEIB+YkAunxEDBlww8l8vYt+W0It
         NavkVx9HUul7DXP3hL/meq8LBCvC+w2En3Lhr81YAUmfNvPuwrp6P7wJBAGT/YNB0xH0
         435Q==
X-Forwarded-Encrypted: i=1; AJvYcCVawjoi0soFQyFq0xieKZQKzW4tlt2wubB35NRoUr+N2yrSS0aJMa6H7J4gGYZLheo/CuXe1h1wANp5tIJ7sfFWkEUahopLKsHUh+5l
X-Gm-Message-State: AOJu0YyKdctk4iaLb+MwHeUUJVcNylsxKFjPhZSsOe3A1bu/9N34NmMA
	ua+gyv4XNXUXWN7BaLBQ/zfZ0IDkbjuy5ACIJW5GENyEPRgwepAJwg0dDCioEA==
X-Google-Smtp-Source: AGHT+IFjs9uCv20/yMoZbU/Ftof/qYHTbGsf6GsGiZo5ajKpwKplyAlUwHWHGLe5nJe1VzJUareDMQ==
X-Received: by 2002:a05:6358:6f12:b0:19f:6172:54ce with SMTP id e5c5f4694b2df-1a1fd45a713mr577519155d.17.1718876873177;
        Thu, 20 Jun 2024 02:47:53 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c53a:5326:7f72:759f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-70dbae52920sm4164469a12.42.2024.06.20.02.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:47:52 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: mediatek: Add MT8186 Voltorb Chromebooks
Date: Thu, 20 Jun 2024 17:47:35 +0800
Message-ID: <20240620094746.2404753-1-wenst@chromium.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This series adds support for the MT8186 Voltorb Chromebooks. This is yet
another product based on the Corsola reference design. This particular
version features a higher end spec-ed SoC, necessitating a beefier
regulator for the big core cluster.

Patch 1 adds an entry for a new regulator IC. How this differs from
the previous iteration is not totally clear.

Patch 2 adds an entry for the Voltorb devices.

Patch 3 adds the device trees for the new devices.


Please have a look. I expect either all three patches to go through the
MediaTek tree; or the first can go through the regulator tree, and the
other two through the MediaTek tree.


Thanks
ChenYu


Chen-Yu Tsai (3):
  dt-bindings: regulator: mt6315: Document MT6319 PMIC
  dt-bindings: arm: mediatek: Add MT8186 Voltorb Chromebooks
  arm64: dts: mediatek: Add MT8186 Voltorb Chromebooks

 .../devicetree/bindings/arm/mediatek.yaml     |   7 ++
 .../bindings/regulator/mt6315-regulator.yaml  |   6 +-
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mt8186-corsola-voltorb-sku589824.dts      |  13 +++
 .../mt8186-corsola-voltorb-sku589825.dts      |  25 +++++
 .../dts/mediatek/mt8186-corsola-voltorb.dtsi  | 103 ++++++++++++++++++
 6 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589824.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb-sku589825.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-voltorb.dtsi

-- 
2.45.2.741.gdbec12cfda-goog


