Return-Path: <linux-kernel+bounces-530815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FE9A438BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6253717DD77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD923267AE5;
	Tue, 25 Feb 2025 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S/RE2gc5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EADD517;
	Tue, 25 Feb 2025 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474159; cv=none; b=QQL0POko5PDcsmgU/OeKX0EjhkKZNkASP7CiJQSj9FFEaGJjPn3HKgN4TQLVYcxaEMsMmMZdle1wOsJCN9CPtJ/NO+lHIIQ1A/gxgszMbYZ8wnnpumGTg6ohert/IzniFQ8EZUXW/58o//2fpuvKHPcfGlry/Yyb2JVjXvwyIz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474159; c=relaxed/simple;
	bh=GFEfTorG2zuWJ97TPko5rQZtvEKeuqQGPMRIfo2OrTw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pEIQAcVTFDcnWizkoo8/BaB2NyeK0DWS88ApxBvmA3k+SJk5xWplrOCY6hpI6GidtcuDoothHGLv8l6UHhBYqt0a3kvHqEGcxthabS3gcNrIb0mN24P82bhVKD0kb4KZ3YIRtufCNv9TumTmzySyqD3R3fIwNvBi2KNwV2XmdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S/RE2gc5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740474155;
	bh=GFEfTorG2zuWJ97TPko5rQZtvEKeuqQGPMRIfo2OrTw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=S/RE2gc5EDyN1SrEb2R9W642N50m8FsfRZ8bRHF3PVg1aUG1WzgVkxIFT6NDriogy
	 WdnxD5k5YT47acDuj/yQUYBapJvHYIA2nKsriI8rlWRvja3Nq1tjZxsPkYRiLyRC0b
	 Xv+71o/UZEzvQU6kwD1QM1xsIblLaR7Ff9zxCchBd/ITmzaPbL5jAcRoErtZHdCKk3
	 ZS2HYEV+Ti/XpOlMdHSKh8LhcU71UEIPdaH9QsbuBZpA9ItcNknmf+oXr19w2OHYzj
	 7SERwnx3yXbv3++KdygVOM6BvCi0yNR6TVtWjK4tMwK0krpW+R6+2oyX4ce0+sb0/n
	 8evHq8R3JTM+w==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BD42117E0E91;
	Tue, 25 Feb 2025 10:02:34 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, matthias.bgg@gmail.com, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, pablo.sun@mediatek.com
In-Reply-To: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
References: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 0/3] MediaTek MT8188 MTU3 USB and Genio 510/700
 TypeC
Message-Id: <174047415469.19243.15192184553085173709.b4-ty@collabora.com>
Date: Tue, 25 Feb 2025 10:02:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 20 Feb 2025 11:55:11 +0100, AngeloGioacchino Del Regno wrote:
> This series adds MTU3 nodes to the MT8188 base devicetree, fixes the
> Geralt Chromebooks to use it, and adds support for all of the USB
> ports, including TypeC Power Delivery, Alternate Modes, etc, found
> on the MediaTek Genio 510 and Genio 700 Evaluation Kits.
> 
> This also adds the missing SuperSpeed port to the mtk-xhci binding.
> 
> [...]

Applied to v6.14-next/dts64, thanks!

[1/3] dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP
      commit: 454a1e3cd36c113341d7b71e8e691c6e47ab4a8a
[2/3] arm64: dts: mediatek: mt8188: Add MTU3 nodes and correctly describe USB
      commit: 598c4ad870d3942ea948d2b99c55239acdde3224
[3/3] arm64: dts: mediatek: mt8390-genio-700: Add USB, TypeC Controller, MUX
      commit: 1afaeca17238ef6480b1a76e7fd8b3c33d406ef7

Cheers,
Angelo



