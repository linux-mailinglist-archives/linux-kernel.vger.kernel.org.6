Return-Path: <linux-kernel+bounces-344900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5878398AF69
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C39281521
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B0A18784E;
	Mon, 30 Sep 2024 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="F1IEtTq+"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44BF15E97;
	Mon, 30 Sep 2024 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733009; cv=none; b=kjqlu8C93ATcmWCvYIhB6GdugWgoPI5YUWLb+jyNR5h0M5E1iaXeS3BF/Fn9SSNgx+zxGAUHPYSahbbRLcaMOSNXfwOtqoHnzFrZw2GB8XA5sz0D3C0q/vAdKYGOVJ/Z4L0vp6VChitKvF3J/JIIjN1UrnrCX3/AZdKCFF2eehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733009; c=relaxed/simple;
	bh=ysHQ6RSA1ZQmQEzSQ6JOaBp1bxlvC3b+Sdi3bfWk4o8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnHdhCpT6TX+v4sdi29Bo1DcsDvRcTgr7XZepq/RI3u5ZqodSxV9eMqASymEUxTTCmLZO1b26fDyejgWXwcAIf6Dr3Hyll5UlkocIiW9cwYQhTbVb4n2Unh4OzenleUWVafkwDP7grazRps00MNlPZ7KDFlIrlv54rl3V6/EcC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=F1IEtTq+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pd6814i89htvWyhjmtyJ5h0pHcm1ipN8hWN0NT65AdQ=; b=F1IEtTq+t9XUZfPYk3nUoFYcVr
	Df+wZirxD4D25zIUGndfjJlMKOA4TxhdkElfbpIsAB1AOfxDR502IAj3vZvGumpPtUju67msd9y3+
	ILkmLofYcROMyAqkaqhNov5qvn6m2Npg/j4hXYMOOoM27ZA6qRXi9lDMZNyL0BNXOl2fTaiTqp3j0
	W8PvDMzkj6exgbn6dZKE0R3pErVsbLEchuCSOIaHWWBpUreitW3VXZWDZsw8UPfYNCOv5BuGq7LZ1
	Si5yLfaSqM2gJw9/43g+nij4KkaAZCtPMVBNt/PzHL9xD2i7B6Gb05lDUIhJcIaLrxH79pEnRldyL
	EHXSMcug==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svOHL-0008So-0v; Mon, 30 Sep 2024 23:50:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jbx6244@gmail.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] rk3328 cru dt-binding conversion
Date: Mon, 30 Sep 2024 23:49:58 +0200
Message-ID: <20240930215001.1999212-1-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Johan already did the heavy lifting of converting the binding in [0].
The binding conversion itself already got a Reviewed-by from dt-people
only dropping the superfluous compatibles needed a bit more investigation.

So I did go through the mainline kernel and also the vendor kernel,
looking for any obscure usage.

The cru should really only be accessed by the defined clock and reset
subsystems of the kernel and thankfully there no users of the cru-dt-node
as syscon and also no syscon-get-from-compatible instances for either
the rockchip,rk3328-cru nor the strange rockchip,cru in either kernel
sources.


[0] https://lore.kernel.org/all/20220329163016.27458-1-jbx6244@gmail.com/

changes in v2:
- explain that the superfluous compatibles are not used at all

Johan Jonker (3):
  dt-bindings: clock: convert rockchip,rk3328-cru.txt to YAML
  arm64: dts: rockchip: fix compatible string rk3328 cru node
  arm64: rockchip: add clocks property to cru node rk3328

 .../bindings/clock/rockchip,rk3328-cru.txt    | 58 ---------------
 .../bindings/clock/rockchip,rk3328-cru.yaml   | 74 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  4 +-
 3 files changed, 77 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml

-- 
2.43.0


