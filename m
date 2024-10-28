Return-Path: <linux-kernel+bounces-385869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F00259B3CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BB21C223C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F83B1E9083;
	Mon, 28 Oct 2024 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGY9+Nnf"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1C1E22EF;
	Mon, 28 Oct 2024 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151226; cv=none; b=bTQYv82bWUyG8DqLMpmbxlYtLEpd58ZM26+BvIlmO4MmjB8RMgISWKrsIq2QwPuTvVYyypyq4xhhbSxw6NPV/ugsU9LzRA3nKtiwRW/usCiq4XcH3E0tJceFlRK/sXC9fclEZnubkDoT1leMS/mJu7ZvBtDkutz02bvf6WxRzGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151226; c=relaxed/simple;
	bh=STa130djmrgKfV31Y9bvm8ZICR75RZ40uDFiej2FfV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z853IdcweHLz8ImT7kSTFOtJrrQY4ENcrz/Ic1saiwmzNUBvZjoF4XvGJencsi8uH0qDs9iTyKF0obOWQiFhp72CIhiXifSPeVyhzN/6MeAUh9SrxOQsQjQ/8gJqlqPRZMeSj8nixlT7+Ay0VtqYANXCByhFz9NoLdum5GnpHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGY9+Nnf; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so5502163e87.0;
        Mon, 28 Oct 2024 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730151222; x=1730756022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P3jhy7g92HAelJpeRVsKB0qQVe3H+zDTlj5MJNUzblc=;
        b=SGY9+Nnfyi0MArb8sZ86RX0txbEeLOvF6Gg2pj680hIpUXb7Ii16r4Cx+G9BKPvTD6
         yX+jYeSzjvQC1rXn1v30nwUe2vuHprg42qnMG9yTsXMFijpWb33OasZWluLojCdqb3XO
         0/CuaDyQM+6flZ+ZAqghgVnzSd0JtUa5PF2TP1Gmy1p+clFk8HbXxVjygVr1KrK/SzYL
         OJKRjJ36/P3lrjgaxqjVOn/HDRMM5NSPCIllup6tjmCh34LfaP7dq6y+Lup4hJ4Ombxu
         BYPa/Mt4Qt/qKpjZcr7Qs60o2FGLTpq9BXvoIDD06ktUhhhWkJBV/ZCeZW36/u83lqsS
         wLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730151222; x=1730756022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3jhy7g92HAelJpeRVsKB0qQVe3H+zDTlj5MJNUzblc=;
        b=SYubkjqKvypfLcH0W/EDnLNCTd1+II2RstOvl9hH/J5SUHy2KD6qq4HQSTXea0JIwQ
         XyvSawceKzIdwKUQ3vGv1+yfo8lIiGv3VNAvNoWIYCtg1+c7ipHz7hc7cySATc0a8gyk
         CDfGtr5WClcqLk5nf6OqrJquSTS3EDf+2MKE425egL6gmJDhFktJbVzBYrEX4WHuceJX
         b91PY8y4JJnAs4W8vW+T1FDFN1fGoGryVr7QxTfbPLbNSE/gyilyzQSAlPPzNPojmuKW
         3PjiyOYa0ZDtxZyxFGRBuHB1SgYr15YgatdgRq9Giv5oeX3SiRkt2ey4aeT43bwwbl+s
         VNCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeb1AAPxVaTw1/gthL7ZOQjNmhdMS5RMty/dggVsoEuE6zVA2trlbft5nNo9on3abWKodM90Mefm7u8q3i@vger.kernel.org, AJvYcCXKE3lrfCIn4cMl8XPRujS0f8+B/qNltKGEcKuF7SJGKhvsiTrKwHGuEGAhzJSRN8LjH5eosP9j7dIh@vger.kernel.org
X-Gm-Message-State: AOJu0YzNvBAjq/PNBY/OTjOVSr6IKYiS7ixDUET9Ziy9OIiKAgvWD/sA
	vMpJjlqv1OJRw0syAcb7YZZ7cKW3EiGmCIIgUapxvmKBmwW8+TaZJYGdmA==
X-Google-Smtp-Source: AGHT+IH8QWe0UkauZn2bm3eeSh3k+dWuXtsVQf4Au1Nx9JEZxSU0NN5Ic64IUzcAKVKuVoc6QI2zug==
X-Received: by 2002:a05:6512:3d22:b0:539:f6c4:c29d with SMTP id 2adb3069b0e04-53b34b39798mr4508983e87.54.1730151221818;
        Mon, 28 Oct 2024 14:33:41 -0700 (PDT)
Received: from localhost.localdomain ([91.90.219.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c98b9sm1204625e87.224.2024.10.28.14.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:33:41 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>
Subject: [PATCH 0/3] arm64: dts: rockchip: add Banana Pi BPI-P2 Pro board
Date: Tue, 29 Oct 2024 02:33:11 +0500
Message-ID: <20241028213314.476776-1-dmt.yashin@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add support for Banana Pi BPI-P2 Pro based on Rockchip RK3308
(RK3308B-S variant) made by Shenzhen SINOVOIP.

Patch 1 fixes rk3308-codec DTB warning.
Patch 2-3 adds binding and dts for the board.

Dmitry Yashin (3):
  ASoC: dt-bindings: rockchip,rk3308-codec: add port property
  dt-bindings: arm: rockchip: add Banana Pi BPI-P2 Pro board
  arm64: dts: rockchip: add Banana Pi BPI-P2 Pro board

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../bindings/sound/rockchip,rk3308-codec.yaml |   4 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3308-bpi-p2-pro.dts   | 362 ++++++++++++++++++
 4 files changed, 372 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-bpi-p2-pro.dts


base-commit: 9220a541da2bc49ac79e0475843048ba29e4d076
-- 
2.39.5


