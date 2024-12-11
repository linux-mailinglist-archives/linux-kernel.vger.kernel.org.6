Return-Path: <linux-kernel+bounces-440783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD99EC433
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DC1285782
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280F71C07E2;
	Wed, 11 Dec 2024 05:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RC8+PZ2G"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC611BEF74
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733894676; cv=none; b=HV1HkGJhUw1IItDtE3A4+6fkbg1KyatN1VyS5kqzIQkN1JF0cM3Y4ZtKkzgmHgzzSFGqojWIfJD5vTTdQrCTb51/JVBJbolXJFncRBWdyChYhO8cHO2AZANw5/PgWHeyW1nH8+C/zuqR0OVCcSz5fP8Wk/B79vAXg67TGrRV/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733894676; c=relaxed/simple;
	bh=otYeShkAnGaMRzpsS7tfYUNkIhd1EXYWi/E+Tcp+/7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3B321eU/miLNzQ/1tULx1V/YQOaFRC6dxi0jluYZN0XIcCq6Lm3OcLSOBKexO/A27nIYbkKf4dnEnXJrXNIE/Z+qHbPqTXUWpzj3OZ0v+2EA3a6jrkXsz5YsCbcw9Z82qfv8Lwpio8iY/v/9olFxNcymZDhuhfrAnZ7637EdVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RC8+PZ2G; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728e729562fso1044108b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733894674; x=1734499474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9rNAO84080ar9QYUBnFcj+nugyjxelBE79eeObQSfkg=;
        b=RC8+PZ2G5wzJnsG7YEbQp2+TmszGV3VEzRzqcy9/MSPdFOq8YjNYBKoRCGLG6fB7nT
         U2x53v9z1nTusdefaMbYFjmRNhw4VLfWC3ReuPcLoIcfrehrxWBvV9KTBAbBGNnxO2ao
         FxDC8Wg7y3rQH081XmEzaxTbWt4HQL6hxQs6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733894674; x=1734499474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rNAO84080ar9QYUBnFcj+nugyjxelBE79eeObQSfkg=;
        b=Bd7z/f8yCjXQELQo9KczSv9y/ZSkXrzTEkgSTUoQg8sD4U8TTSkTq4yaZxJ9gQFf0w
         VP99UNL9EmbCOa4E5j0NCbx66mLfG09Xk5fiiuY9Xbetg2vBqoEHCsofMVwdF5GK/n1V
         0XrX/Saw+hVIJ1Jy3JENF2iudftNFj3eZFl1zlNKQ6Ioyl4i8mHVMfXizSkskvogQ3tl
         +Q2iNc7g2JPz3sH4DzngB0Jx4ZUiMeshbpun9zluiWC4aZ5VLu/Mp3NVn4Mc6m3sAtQ3
         wJKhdUR9mXvABAMi6ihq6a3vBYutMCgIsUxhCPusVOf9YB4Ue+OxtqPAIwzcJ3JKgK7V
         MabQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv+dgF39WJ6foJPOKI4vrXRGQZ4T/jMSwkTkjrFtgleaBsO22t0kZehtyc5sKP6lyKak/VHw7B6TP0ORI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaOSDFD4lWdUg5fWc+u+UP4MZo+KCI99is2z7wdKJCAvdhjtMY
	RYbMK8HjSqthxkxcE/JjnShdE1ikYIrKJj+AqVfy+aQAhhRoLa7IzjjqtSmUjA==
X-Gm-Gg: ASbGncuzCB0mpYrCGBddtI1+K6dxVbVa7+05bvuwCNmZTuLfRQTo8s4xux9hpVVmAM8
	SF2dh37BklGZR60i6glSU1kLpO9Ccug6DqxRgaW9HWiFLknghSYAURI4JsSV8SUVlPkR9JoPX4U
	9fYqoeMZuU/QuQyYlvHUr+akkzSnL2CLtuQyV3+Ai/VMG+HmUgKdh71FiBO4fbI2R+vAH14uNNF
	07Gm22UG6sJXQAde4QtZnZFeBgJJKvEnjgk9RZXwEmI16fRFyFpW1WDENhv6NR2Kxg3yiC6
X-Google-Smtp-Source: AGHT+IGRXZyCR9vBPnWrRkfxCl9FFb1KFJmcBVsUf9/kW06iS0cwlLUslN7QIGTATGDeY32DTij/Zg==
X-Received: by 2002:a05:6a00:1915:b0:728:e969:d4b7 with SMTP id d2e1a72fcca58-728ed3e8533mr2451508b3a.12.1733894674483;
        Tue, 10 Dec 2024 21:24:34 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:4dfb:c0ae:6c93:d01e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e66801e2sm5397702b3a.160.2024.12.10.21.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 21:24:33 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] arm64: dts: mediatek: Drop regulator-compatible property
Date: Wed, 11 Dec 2024 13:24:18 +0800
Message-ID: <20241211052427.4178367-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

This series drops usage of the long deprecated "regulator-compatible"
property from MediaTek device tree files. The property was introduced
in 2012, and then subsequently deprecated after two months. It was
never carried over during the binding YAML conversion.

Drop the property from the MT6315 regulator binding, and all MediaTek
device tree files. IMO it should never have been used to begin with.
This also gets rid of any validation errors [1] related to them.

Please have a look.


Thanks
ChenYu

[1] https://lore.kernel.org/all/173386568696.497617.3727087837255802552.robh@kernel.org/

Chen-Yu Tsai (8):
  regulator: dt-bindings: mt6315: Drop regulator-compatible property
  arm64: dts: mediatek: mt8173-evb: Drop regulator-compatible property
  arm64: dts: mediatek: mt8173-elm: Drop regulator-compatible property
  arm64: dts: mediatek: mt8192-asurada: Drop regulator-compatible
    property
  arm64: dts: mediatek: mt8195-cherry: Drop regulator-compatible
    property
  arm64: dts: mediatek: mt8195-demo: Drop regulator-compatible property
  arm64: dts: medaitek: mt8395-nio-12l: Drop regulator-compatible
    property
  arm64: dts: mediatek: mt8395-genio-1200-evk: Drop regulator-compatible
    property

 .../bindings/regulator/mt6315-regulator.yaml  |  6 -----
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  | 23 -------------------
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts   | 23 -------------------
 .../boot/dts/mediatek/mt8192-asurada.dtsi     |  3 ---
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |  2 --
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts  |  9 --------
 .../dts/mediatek/mt8395-genio-1200-evk.dts    |  2 --
 .../dts/mediatek/mt8395-radxa-nio-12l.dts     |  2 --
 8 files changed, 70 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


