Return-Path: <linux-kernel+bounces-542845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE06A4CE65
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AACE188ED6F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C161F23312E;
	Mon,  3 Mar 2025 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="JNfuVWDF"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDAD22DFB6;
	Mon,  3 Mar 2025 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041386; cv=none; b=Vs+gJ23IreEps6hB/Wb18FxrVrfHNFGV7tS97WNP5+m6dBflSX/sPze48w/1qmaVH6+0v2KpdKwc8sqrcqR5rGPw6v6pgnZcYwfBtegu8IGC+xoOYRINeaGDa+tKazPJnpOrgEOhPiRZ6we563b6n+Aw+gqjBYoq+iPV6gCY+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041386; c=relaxed/simple;
	bh=1bRhjZsL2z2GZrqZLcbmsx0EFYTgtSq9PfISuQOdCnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlGXgoqffi6MYSbVTf57S3L7gUWlzJ9nsPvMliSqCK6AJv1S7aFLtt4c7PYG8ONdrDGN/xngWbcbSihHYVRhXDDpcuHtBAh4gU10PNjiI2WGCQahKhPkRmfshWbZY3+QOJVtsgHVAb9u29iXvy3Bi050IywN2E5k0tOM+WTMAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=JNfuVWDF; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5EOXFMVC6+7oiTirA0ot5v+5pSqEybCdk9aXbZ9tQ+0=; b=JNfuVWDFIye54QW5L2Yg44pbby
	+ehzxUfqV3vdBNYpO2rmcVeZ6SiaSvoJHG8/uemnPHagfcxEat8dO9RPml2Ku8RyM6w2oaY512unK
	zCQBrHyPSzT7BakWFT5j67mA6afkF4APHp8VSw3L0UcNVLSuqi8nigmyjL0nW3bG3E9WTjRhU4Vhx
	AhilD1kh9ztYP5FIRQqanbfm0XcunNe8LtskZ/el5U+DbvKADL2i4GDAFaY8cQWdaqI4FjAh512gt
	FLZOd36yxWaosHknsnz/rY0FT4JknB6OkBXD4g/WuieP/m+xKu3LKkMNi7BThx7X9FmFgd6FW6+ne
	8aYZT8Bg==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpEOT-0005wL-Ig; Mon, 03 Mar 2025 23:36:13 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	didi.debian@cknow.org,
	chris@z9.de
Subject: Re: [PATCH v2 0/2] Slightly improve hardware description of Pine64 RockPro64
Date: Mon,  3 Mar 2025 23:36:10 +0100
Message-ID: <174104113599.8946.16805724674396090918.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1740941097.git.dsimic@manjaro.org>
References: <cover.1740941097.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 02 Mar 2025 19:48:02 +0100, Dragan Simic wrote:
> This is a small series that introduces small improvements to the way
> Pine64 RockPro64 [1] single-board-computer is described in the DT files.
> This applies to both production-run revisions of the RockPro64.
> 
> The introduced improvements boil down to eliminating some warnings from
> the kernel log, by adding a previously undefined regulator and by adding
> some previously missing references to the regulators.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Add avdd HDMI supplies to RockPro64 board dtsi
      commit: bd1c959f37f384b477f51572331b0dc828bd009a
[2/2] arm64: dts: rockchip: Add missing PCIe supplies to RockPro64 board dtsi
      commit: 64ef4a4320e7aa3f0f267e01f170f52b90bf0b1b

I've moved the pcie12v supply up one line.
While in a mathematical sense it's true 12 > 3.3, we're sorting
alphabetical, so it's 1?? < 3?? .

And yes I sympathize with 3.3 < 12, but also have come to appreciate not
having overly many special cases :-)


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

