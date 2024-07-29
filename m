Return-Path: <linux-kernel+bounces-266463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA7940036
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C8B1F2252F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8E018C348;
	Mon, 29 Jul 2024 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k5qdzrT9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0C80038;
	Mon, 29 Jul 2024 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287787; cv=none; b=uDHClLINNydcADQIOzouAXJ7N+8UmxyuWZtKpyIBIVTAAUpR7ljOHYBGE7jErdeYk2UiKxpDpKSLd+Z04V+Upb1NBLVaADNdmAUEKeP4WASz5S2ZTyekyaZZQ14JGmagyRu0/bdotUbC3A/io14gjB/e/BYpXZT9NhjO0WAi1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287787; c=relaxed/simple;
	bh=LOZJvW/JL7dJF2U2piC6XH9x32IcP9JJ89yfsFfMpIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivj7pSUjfpSkM94E8uEvZ5RizuwoNSjoGc0+b1k55EqLaH1gTAM8PIOrhRBGsyTvWZsiJ0ZWm71AYvwB4Hb/JiipFhlmZzsvAhZqtc+0XG74Of+1C0HvXyJqgo/bjIrovKg0NWaN8lwgirssWxDgqiBaRfrqfRsfUYkerkCmSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k5qdzrT9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722287784;
	bh=LOZJvW/JL7dJF2U2piC6XH9x32IcP9JJ89yfsFfMpIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5qdzrT9Ou4tuZtEMBs5zQ0gIzg6Wfd3Y7dsWRh3OMGzUMuIvKTXvlGM1Lf2Xj4pN
	 mpIeolAWd7gF9Mi2XrA+Bq6U2IWi2zbqHUcRRrjHovqpKZwOuFmO2ZMDlzC/S26I+F
	 7koLBQsqBNgMMaoH2S4gnfY/TuOIOdlGaGo2qTX38fnG7CcbJyTW/SuIRBOhSeDu7L
	 NlYpGJlN1VrzXKqJpqkERy8LcoGlIsg5Vb36VQYxRErnrMXayWWQV8DPY4mjcSX6av
	 Se6QOAv+rCSePEorqDFNbOCjY/ZXRme3dwsN61WbUZM1K4RMzRAryrbqncoLuewJ9Z
	 cChufSEGXJrSQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A74DF3780530;
	Mon, 29 Jul 2024 21:16:21 +0000 (UTC)
Date: Mon, 29 Jul 2024 17:16:19 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: mediatek: cherry: Specify pull resistance
 for RSEL GPIOs
Message-ID: <1fc31d16-dbc6-4d92-b594-27f7df3d6215@notapiano>
References: <20240531-tomato-rsel-gpio34-35-fix-v1-1-64ab2545f182@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531-tomato-rsel-gpio34-35-fix-v1-1-64ab2545f182@collabora.com>

On Fri, May 31, 2024 at 05:51:09PM -0400, Nícolas F. R. A. Prado wrote:
> GPIOs 34 and 35 on MT8195 are of type MTK_PULL_PU_PD_RSEL_TYPE, meaning
> not only can they be configured as pull-up or pull-down, but the pull
> resistance can also be configured.
> 
> The current bias setting however doesn't specify a resistance value,
> resulting on the following errors:
> 
> mt8195-pinctrl 10005000.pinctrl: Not support rsel value 1 Ohm for pin = 34 (GPIO34)
> mt8195-pinctrl 10005000.pinctrl: Not support rsel value 1 Ohm for pin = 35 (GPIO35)
> 
> Specify the pull resistance for those GPIOs to fix the errors.
> 
> Fixes: 5bf7dabe40f2 ("arm64: dts: mediatek: cherry: Document gpios and add default pin config")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Hi Angelo,

it seems this patch fell through the cracks. Do you want me to rebase & resend
it? 

Same question for this patch:
https://lore.kernel.org/all/20240606-mt8195-dma-scp-node-err-v2-1-e14702e9d3f2@collabora.com/

Thanks,
Nícolas

