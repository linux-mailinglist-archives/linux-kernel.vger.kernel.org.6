Return-Path: <linux-kernel+bounces-556839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D4A5CF52
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3D217C153
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E570264620;
	Tue, 11 Mar 2025 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd8ps7tU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B672AF06;
	Tue, 11 Mar 2025 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721190; cv=none; b=jg6Yg+ThMHf4NmDtdohLDhOlZLmfB3wOiMoY6bGIrjvSN1jCioKfQe+wDlGYlAsY+UMUUD8QVPe+5k7P49ZHi++cqJuxGXXBDaG1/NSy4fKtogiHj+MJQoyGjJagt9T8xOZhj+V0B/e6/a3hmIEpBHh1fncdMaJiqYGtj6l/Y3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721190; c=relaxed/simple;
	bh=LXvcff6ovrE+lWjEH283+ozibg6lrSmGszx8SWB2Els=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/NYMC576HlfCq1YOH4o9SpN4NDydS4lLNdVI3rKJ6E1M3b67lujFbfU2wxAA91oikyaONI88KJd9B2Fv5kOrPE10UD0gc9UbEAyLS6vv0qlduIfKihBSdoMm9WYfQef1PfrhcJX0466sMIoyD6ygwutt5m/VVTGIgtI0jQ0EaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd8ps7tU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD70DC4CEE9;
	Tue, 11 Mar 2025 19:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721190;
	bh=LXvcff6ovrE+lWjEH283+ozibg6lrSmGszx8SWB2Els=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gd8ps7tULO8XXkXmP6AJtLdw+gDpnZW1O7goGVI+cGeI/JW4cOn6A6JcyERONifij
	 9gBP8rzLd+fParVkgKJ94dsTCp+tvIWhI86mTGjq9wbs2D2wGQRWf24o7MYCzBxyFc
	 De8dxrxBsCVzhjG+aTDtSvTtUM1XPOMFoqW4f2qLAF/wFPdSx5yavcD8t+7CsmKoVA
	 FsHsVOHQ/XeNAotS4vJEelArSnl8OPrPDvNE7k86Wd0Bq3C8V4oz67X1FUSvpSWGw8
	 0tMR5lTtsVic6R/dQLOAldO0FPK33H86W6OHkrmP8T5kazlUs5yShRi4fl4zWj/X+1
	 Wo0ie+Nrl/gAQ==
Date: Tue, 11 Mar 2025 14:26:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ASoC: dt-bindings: meson: g12a-toacodec: add
 support for A1 SoC family
Message-ID: <174172118794.4169317.149338949275613581.robh@kernel.org>
References: <20250309181600.1322701-1-jan.dakinevich@salutedevices.com>
 <20250309181600.1322701-4-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309181600.1322701-4-jan.dakinevich@salutedevices.com>


On Sun, 09 Mar 2025 21:15:59 +0300, Jan Dakinevich wrote:
> Add support for "toacodec" audio component found A1 SoC family. On this
> SoC the component supports capture streams, additional DAI ids are added
> to configure this feature.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  .../devicetree/bindings/sound/amlogic,g12a-toacodec.yaml     | 1 +
>  include/dt-bindings/sound/meson-g12a-toacodec.h              | 5 +++++
>  2 files changed, 6 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


