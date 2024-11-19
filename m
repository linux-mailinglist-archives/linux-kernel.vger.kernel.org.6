Return-Path: <linux-kernel+bounces-414355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F82E9D2733
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9987B212BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794951CCEF5;
	Tue, 19 Nov 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ffQuBpZR"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2764EB38;
	Tue, 19 Nov 2024 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023011; cv=none; b=OC99l3SEhJZmRvrZpdFHsMuE98B9a2q1/DW5UZ56GASo+nhH4xx3QlaBFSoH3+0NPqyaCd0KqqRannvWPX/YoU8flgUmicUkV88w9qC6dWUmDOVJEfV4788SsvI5RJDdg8R5GIYXVjaYB+HcxhGwB+s+7+8VZuA1zqgEfGW9ZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023011; c=relaxed/simple;
	bh=kGj+GDP0ykdpYT3mxMJibuDlYw/CkU8W4X9/0aldrxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEUcamPSjLwiv8Iibe4j8mzIN7XHt36JO3hI8s6EuIYd2rx8uwJkD26ftbmlouWz9bPnSlQgd/5sN9HbM1W29riMYbR+lyR6Ewkrn+JRccW0xtYkMRQDZ/oHiJwRL9IG1CaYSohPtpeMshp9NAQVOc96v4gQ3zVxZnwyIMAhzWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ffQuBpZR; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CwSrNWXTaOvTSfS5toosqs8SZ/vkl62iKBpjVyFO1BI=; b=ffQuBpZRkJrsyKP0W2/ScBQULf
	6nF5GYWZ2sZrzNHF3uMMue57xe0HQ99W/h5hNCiBLcPg+lCCaRhXjjadGSdvQRHp7tBIDAnk1stnq
	/6bu1gHkw8mI21mgUZJNgOdnmRBXsEo/WruRv6n+V7D7fHsx02QNOKjaLW7E4bBnBs3iFHvy+WrLm
	dsH/0wbRXlTVh2dfa5VqqblVaSgkpFKC3AzywHpBEmgIBXg2lkDBQndWXQkW/z8vN/kgi+XsvYF5y
	mWZupjy94gCe8DGWJGxwTeRKev3ZMEUOrEobQkw8h9tmDyg253E8l/XEBrJ6eTVtUn8JAxpeXNst9
	VA9Q57ng==;
Received: from i53875a30.versanet.de ([83.135.90.48] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tDOIm-0006z1-TJ; Tue, 19 Nov 2024 14:29:56 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: srinivas.kandagatla@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	detlev.casanova@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	sebastian.reichel@collabora.com
Subject: [PATCH 0/5] RK3576 OTP support
Date: Tue, 19 Nov 2024 14:29:11 +0100
Message-ID: <20241119132916.1057797-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enables OTP support in the nvmem driver for rk3576.

I expect to pick the clock patch (patch1) and the arm64-dts patch (patch5)
myself, after the nvmem-driver and -binding patches have been applied
(patches 2-4).

But kept them together for people wanting to try this series.

Heiko Stuebner (5):
  clk: rockchip: rk3576: define clk_otp_phy_g
  nvmem: rockchip-otp: Move read-offset into variant-data
  dt-bindings: nvmem: rockchip,otp: Add compatible for RK3576
  nvmem: rockchip-otp: add rk3576 variant data
  arm64: dts: rockchip: add rk3576 otp node

 .../bindings/nvmem/rockchip,otp.yaml          | 18 +++++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 39 +++++++++++++++++++
 drivers/clk/rockchip/clk-rk3576.c             |  2 +
 drivers/nvmem/rockchip-otp.c                  | 17 +++++++-
 4 files changed, 74 insertions(+), 2 deletions(-)

-- 
2.45.2


