Return-Path: <linux-kernel+bounces-206940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D0090101A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243FA1C21109
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7346E176AC4;
	Sat,  8 Jun 2024 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="FUUP1n5u"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D92179BD;
	Sat,  8 Jun 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717834325; cv=none; b=Xntsu29VYmotjsZzrdYYG1GN4dKKd3vZcRS6XwsvhLQLfS6B1stTc86Y/mt7BQWkFcPG4CsO8ePL+cK21f11Fc5BoImyEMhrBwRK5eHtleYuuwGPQpxI6SHoKcJCb+qtB5y/1QxAV/5b2mCkGrk6dWlsZFjw0VCJlsuTbndvVvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717834325; c=relaxed/simple;
	bh=mSAtMziJwT6otOmglq283kjJDCUOWw5xEQy3724mXwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MgLkcrb5Gj+5D25axajw9K3HY0L63bzbTMKJZongEAFGaWHUPCm7szYSbaM3gbR9UZQirjVfiG4l8elZy0STIY54/Tr95LFIFPTDaPWxAEB85Euf5PDh7NuTJSd8wMOrm7K+4Mc9P0VAuy0t5LoUd/slmwHS/I5kOnq8ld/pSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=FUUP1n5u; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout1.routing.net (Postfix) with ESMTP id CDF4840271;
	Sat,  8 Jun 2024 08:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1717833946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NxOmAqAC7peWQq3km72FKb2gwXAq1zrzMdr4NQiTNtU=;
	b=FUUP1n5uRODU9HEEy3sXxbh5VIJfd1a999zTRgPZCO43UvHCDAtY+V/gh6FkM7COhtYqvu
	i9xJ7veuRXCuTjPRGZ7GNDv42v0wjPs0f0igbD30LuoyRmsvYSbWq46ZZNDMguYYZryMtk
	RVr+XdOkLrz7ibCP1Mquoxk9RJ3k9NY=
Received: from frank-G5.. (fttx-pool-217.61.155.199.bambit.de [217.61.155.199])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id C67CA8010F;
	Sat,  8 Jun 2024 08:05:44 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v3 0/2] rework bpi-r3 dts overlays and add SATA dtso
Date: Sat,  8 Jun 2024 10:05:28 +0200
Message-Id: <20240608080530.9436-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: a095108b-ad1a-4ad1-bf03-eef84b485d3d

From: Frank Wunderlich <frank-w@public-files.de>

This Series adds check for bpi-r3 dts overlays on buildtime
required by rob herring [1] and adds SATA overlay

Last version seems to get lost so posting v3 with updated sata
overlay syntax (removing the fragment).

[1] https://lore.kernel.org/all/CAL_Jsq+f9bq5Mab9m1pzDeiw304TMeNDmJk+ofG6M8J9QD3cvQ@mail.gmail.com/

Frank Wunderlich (2):
  arm64: dts: mt7986: add dtbs with applied overlays for bpi-r3
  arm64: dts: mt7986: add overlay for SATA power socket on BPI-R3

 arch/arm64/boot/dts/mediatek/Makefile         | 26 ++++++++++++++
 .../mt7986a-bananapi-bpi-r3-sata.dtso         | 35 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso

-- 
2.34.1


