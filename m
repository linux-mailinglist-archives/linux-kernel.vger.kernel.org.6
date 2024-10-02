Return-Path: <linux-kernel+bounces-347414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE29598D26A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDF928459B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D91EC014;
	Wed,  2 Oct 2024 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NXOW+9ZD"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99F16F84F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869611; cv=none; b=fzYL4reUr9vVCvrql7KukyMGh28pn9WcGY9wcCwwkon/k7rQLq5VJ2WCO/9AXX4EwkJDyfonsio1wRkqGgNb2gz3onby9waj7+BvSgKwcxkFwmqgVhCWGscnCIoOdnfVBGgeM8e58sv9w/uf327+ncb2JcotpF7DRwZLFsFgMGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869611; c=relaxed/simple;
	bh=8lToTeMFzcmQ2OeSW1NrdkbW1d5M8jub/9AQnAZGsxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3gCkTwMfo4HI25oop+lS8bGmVG96vIt7yPvtThnhSAm1sQoGHB0da6PxxebjrdqCWzccylPhQc4Qef5fN8LnsU1XjEhhciznwQzqIYd1O9p1v8XP6hZdephFx1sTv758MWlOP+tKAq0hND/B9QjJN2GNMWTY0dzSM7iNmQ7i30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NXOW+9ZD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71979bf5e7aso4771083b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 04:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727869609; x=1728474409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MvXbEXUNdq4h1cZ1tBAnoLDdp5iJf5TUxbfcrMQtOlA=;
        b=NXOW+9ZDDnR5e+ZE/Yt35UbpsAOWDbl6IktTGi27+u5dolkFVpDUyFglQbr9c/+cib
         ACelcGMoGqvZLPUMKT3kl4us6GVjEERqEF8puUp3AGRRgx3z1aAcwLXNokpctIaXzfZ4
         iUXiudVfjtBsTXIsJluQVW8yHBqq0kAKeD+B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727869609; x=1728474409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvXbEXUNdq4h1cZ1tBAnoLDdp5iJf5TUxbfcrMQtOlA=;
        b=rXB+4MdKaHqHWpNNj0+KZznU572BC8tyXXW82VnDKp2BT2Bk/9PDPd6p83EkVWbLMr
         IZbvulXDqZBz6CKxH8VlTrmssYzLKncxncEV321bDnHnmxpVkvezZhdz5fO5AkDKUz0R
         78bB+uqw4V7Lo3lx5BI6XQRJ5NtQUrhc/nAyrjjWeCbStRHNL8Gus+Hhrmn6HQvV+SM8
         0Xqef4BeAyPsDiOx93eemestbDV3mMrLx+S6EEp8NhiYehChKHRI5aDJvZY0rRHNRfz1
         SXrNi2PYNm4MEvM0jFn7QxKW+ODJYsOexUIcZclNnCS8M9xbiW3oMjF/S3lxvjessanp
         w15A==
X-Forwarded-Encrypted: i=1; AJvYcCUJDYkuszbJjKoYUkZz2BM0usiPOcBe1Zr87aWi3///e39scic8S2JGcA0OOXqaeEZEOR6aCgVaSUwlNTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEOrRgdoVx65TisFPfj0nzEjgOpGAKE46j/UHC48UlNCahwnOG
	mru9Zo0ncpP37fBC/1UaWrm0Ut0p09LuCT1+Oq4b/KBUjCOjSa4C/Y7cF9n8gg==
X-Google-Smtp-Source: AGHT+IH38Uq7NXWfIYE1q4kGGCRLr5x4PpVHTxwtFl/L4xZTss5jzvTLpCR6rd3v1IX3zgI8HbdufA==
X-Received: by 2002:a05:6a20:43ab:b0:1cf:6c65:5dc with SMTP id adf61e73a8af0-1d5e2d4bb3emr4565200637.49.1727869608746;
        Wed, 02 Oct 2024 04:46:48 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:3bd0:d371:4a25:3576])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652baefsm9639627b3a.180.2024.10.02.04.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 04:46:48 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 0/9] Add platform supports to MediaTek MT8188 SoC (part 2)
Date: Wed,  2 Oct 2024 19:41:40 +0800
Message-ID: <20241002114614.847553-1-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series is based on top of my previous "Add platform supports to
MediaTek MT8188 SoC" v3 series[*].

There's nothing to change or address in that series at the point of
writing, so I decided not to resend it and start this new "part 2"
series instead.
(if I need to update both series next time I might consider merging them
into one)

Specifically, this continues to introduce the following platform supports
in MediaTek MT8188 SoC to lay the groundwork for the board device trees:
- PCIe
- MIPI DSI panel
- video decoder and encoder
- JPEG decoder and encoder
- vdosys0 and vdosys1 display pipelines
- DP-INTF
- eDP and DP TX
- aliases

Please have a look and feedback are welcome, thanks.

[*]: https://lore.kernel.org/all/20240911143429.850071-1-fshao@chromium.org/

Regards,
Fei


Fei Shao (9):
  arm64: dts: mediatek: mt8188: Assign GCE aliases
  arm64: dts: mediatek: mt8188: Add PCIe nodes
  arm64: dts: mediatek: mt8188: Add MIPI DSI nodes
  arm64: dts: mediatek: mt8188: Add video decoder and encoder nodes
  arm64: dts: mediatek: mt8188: Add JPEG decoder and encoder nodes
  arm64: dts: mediatek: mt8188: Add display nodes for vdosys0
  arm64: dts: mediatek: mt8188: Add display nodes for vdosys1
  arm64: dts: mediatek: mt8188: Add DP-INTF nodes
  arm64: dts: mediatek: mt8188: Add eDP and DP TX nodes

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 641 +++++++++++++++++++++++
 1 file changed, 641 insertions(+)

-- 
2.46.1.824.gd892dcdcdd-goog


