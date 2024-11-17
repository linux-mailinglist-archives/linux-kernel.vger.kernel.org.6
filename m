Return-Path: <linux-kernel+bounces-412241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0BF9D05BC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 21:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC361F21B0E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 20:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055381DBB31;
	Sun, 17 Nov 2024 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cPJckVm9"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74C1DB551;
	Sun, 17 Nov 2024 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731874775; cv=none; b=gyxlI6lnRjwTrlc9xRZMMKf/z4yqicbbaoem0oRUjZWzMfJu1Xi/wCAQGbg+t7Wfo+ZK47UMzB9HcuBX9hT4pFOiO7d6c67w1PZQtCl0fTz4UJX2JNEkPw/vQeKu/eXzpQPbY63c/rKQ2BSzsC5wYNHjuJx1eVhyOBcEqnjnuUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731874775; c=relaxed/simple;
	bh=ZYeJsKC4idvAStX7lCs51IZNTYMJxM6qrYJaSb3XrWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYDZPaQA33rf6E3H79mI/q/n/f0fetag/jW2YbDu+N6OZcAydjmP27ryPotHUbH6sVGb2qVKzwLlneEo8+eV51de1/CBe04FHWX8jOvfNGbgFNxh2PRFp3c9eaUoaEnsGQa+3KzO9NRSOgta+bbGh4Lduf39IoT8UeGniP3TzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cPJckVm9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=96aPTgcJmyf/nNkBF02AGuwprUpi9s19DA42nDAZD1E=; b=cPJckVm9tgpiNdGGsXKv+fPvFL
	Eyf7jabTzBweHsJUEaqfOexNX1PUqAOlmb16f6BSbG3OmO8ynXMnjRXXiHEUuhiwYrpsr4mGkF6tx
	5v+C8bm3SojWRhADaqLTdznStpXAeTHb93GuvRYkT+kOK1qQgVJZaFsGwftf/6Vc5RdFdzOat/JUd
	YjjigLEa1dIUbhrIi9Y58G9SE08msxtG06Y6zGmVoTsMsqyB0FlYBnDbMpbJhqRA4t7/8061OBswo
	CULbov/RYpkSL+4wnQ+xwyHT9h1WYkS+sKNGpV8LqpDOmulNQ/lQP5jdQMH6PstWHApjPzwBxxMG9
	10kxECuA==;
Received: from i53875a30.versanet.de ([83.135.90.48] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tCljt-0000cF-6j; Sun, 17 Nov 2024 21:19:21 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Rockchip - add Firefly ROC-RK3576-PC board
Date: Sun, 17 Nov 2024 21:18:53 +0100
Message-ID: <20241117201855.789945-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a second board based around the rk3576 SoC.

Heiko Stuebner (2):
  dt-bindings: arm: rockchip: Add Firefly ROC-RK3576-PC binding
  arm64: dts: rockchip: Add devicetree for the ROC-RK3576-PC

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../arm64/boot/dts/rockchip/rk3576-roc-pc.dts | 745 ++++++++++++++++++
 3 files changed, 751 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-roc-pc.dts

-- 
2.45.2


