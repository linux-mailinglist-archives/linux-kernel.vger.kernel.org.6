Return-Path: <linux-kernel+bounces-209067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF3D902C93
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A1A1C2143D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AEA152533;
	Mon, 10 Jun 2024 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s1yaOO5q"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739893C0C;
	Mon, 10 Jun 2024 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718062993; cv=none; b=qLf2YY5OcJ7gsjc3G/fTGe3P5+Zo3DNR3HkbozdoFzidStv1rlejFBHgHg9Rtq+poVTjvoz/T5PZL+I4cB5Cel5k8g0SQPsZceqttGhMhNZzmip208X6s2lMPka6OfATY6C8Dx/Yi2DbDyER1nvtibsibFlOo2oDgRR8UlRyDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718062993; c=relaxed/simple;
	bh=nPNzVptm/f18wTbcMhm0vYE+658NKVvbwwpRS+Up3zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GpATaIuXWhTayiswpSSU/TkpAIuJ+SYs/Mkt819m+iaeaLyqVolZLzbzy5FYQqK+l43Ttc/aE2xVMaVpPKNYK1Yzj9nexFR5+3F1OWjLRplyha6sxCkb5W5ftzejGKmfE3lV0IOjhITkCz4+z5XiZyngGORk6jm8MsHczvBvc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s1yaOO5q; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718062990;
	bh=nPNzVptm/f18wTbcMhm0vYE+658NKVvbwwpRS+Up3zA=;
	h=From:To:Cc:Subject:Date:From;
	b=s1yaOO5qxsDnFtvgvS05IYym3DEKp/WuUAfZ7uDnQIhh4IFz7bnNuc3835QkZHhkS
	 O0Ep2yeX96b6O2nYGZDtRwyFSi5Dky6ZTZg2pJ8wMa04LYS9cG0MbS7YL1F46YE+yc
	 f86xBX5VRcvgdxre4ANSpsxQmENzZm3uUQF3nMYD2Zq/YSoslxdMe7CrI4KKQl7ACV
	 C6yp9H/3lCBRLHda2Yw90L8TqqIsdggCM6ANHVSLf0zutxwcErMuF/Yqepodt48xvZ
	 TtLcdtxpX+1Oxbcz+g/KGwEIHFANTSkShmnRDl/kr517dyfYd+dnpC5ze0umnpo1NP
	 rpjAmCP7xLNzQ==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D4AAE378065F;
	Mon, 10 Jun 2024 23:43:09 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Christopher Obbard <chris.obbard@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/1] Enable HDMI output support on the Debix Model A SBC
Date: Tue, 11 Jun 2024 00:42:37 +0100
Message-ID: <20240610234307.96766-1-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series brings up the HDMI output on the Debix Model A SBC.

With support for the HDMI transmitter for the i.MX8MP SoC in mainline,
we can now enable the HDMI output on the Debix Model A SBC.

Changes in v2:
- Do not set SION (Software Input ON) bit in pinmux pin config register.
- Small changes to commit log/cover letter.
- v1: https://lore.kernel.org/linux-arm-kernel/20240415114135.25473-1-chris.obbard@collabora.com/

Christopher Obbard (1):
  arm64: dts: imx8mp-debix-model-a: Enable HDMI output

 .../dts/freescale/imx8mp-debix-model-a.dts    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

-- 
2.45.1


