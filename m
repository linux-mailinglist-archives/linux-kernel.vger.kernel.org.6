Return-Path: <linux-kernel+bounces-374684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E7E9A6E85
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031EE1F22CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18921C4626;
	Mon, 21 Oct 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rxbEmSVN"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1E1CA94;
	Mon, 21 Oct 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525495; cv=none; b=VidsKG8RnZdrjSvMAevWpQPak56Rqzd/+y19VXkyWjez4uEpMpCF0StOfIhwQ8nEpXrGn/4CDLJPA4VaVPbPdQKo2Cp5t6KomHhVFSlFFF1pxeYnzXpHH1ujLlgn7FYXdUrnSjnRgBtf047eEjXnQtMF0J5FnLfgwGKzc5RXsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525495; c=relaxed/simple;
	bh=z40zYb/uGDV/Ot/dAQw0WDTjKGPVzBZo+7dbkbk/cs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFahev1nNHRxUOmQILD+lIG7SObjhjI5thxZ6GIjofG1TETNX/5wWQYG92BwkYN9M8yCuqAXM6OVJrOFwfE0i02xjcspedE2q5IjCRXoqQC1ds2N18H1ZqvQyATOIU+l1Qb3MwIrgnfqKVH4v6LpA73tNY+Ist3GXN+BEuz45Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rxbEmSVN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZFqUWUYVKQfYjVjIVoyPAgypYvN0JyBpBGjvuN4/2aU=; b=rxbEmSVNrNAPEhP6zHqMTwoc2W
	wU9lMMLycOLCvVQAc1mmTCf3p2ul3+CXI+zopIZFPiPr+Ti0rXsnPe651IzL7ETvYSJ3Mw+Y/s7Js
	3DPOBhvgsEehfXcCKNq5J8yWdApl6LoJsflMs2S3mpuoyJA4NvAeDCBca6ZFrmroIvEArakzEqJ7y
	Aa2p8DlfoieughJJmumLpogRQf78V8qlotm/SfVpuRbklwAznpnuqZ4I83PXppMGKnazQFe13N3W2
	Zk9A7y0wKNH3AF6hul+91omAjEIUQrl4bG8YZKGH1KdLJGZeLF6jgbEfXI/AQ975+eq/iwPKwa3ZE
	5vnxsA1Q==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t2uaG-0005jR-LE; Mon, 21 Oct 2024 17:44:40 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Drop invalid clock-names from es8388 codec nodes
Date: Mon, 21 Oct 2024 17:44:32 +0200
Message-ID: <172952545659.1342338.7302771759427165029.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241019-es8328-dt-fixes-v1-1-ca77d5ce21ad@collabora.com>
References: <20241019-es8328-dt-fixes-v1-1-ca77d5ce21ad@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 19 Oct 2024 03:38:10 +0300, Cristian Ciocaltea wrote:
> The binding for Everest ES8328/ES8388 audio CODEC doesn't support the
> 'clock-names' property:
> 
>   rk3588-orangepi-5-plus.dtb: audio-codec@11: 'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'
>     from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#
> 
> Since the related audio driver is also not making use of it, drop the
> invalid property from all es8388 codec nodes.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Drop invalid clock-names from es8388 codec nodes
      commit: 6df447d57800b7f9adb8eb673f1853331be20bb3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

