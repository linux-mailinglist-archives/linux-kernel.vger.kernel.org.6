Return-Path: <linux-kernel+bounces-539517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22E6A4A56F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA71C3B3FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BBB1DE2C4;
	Fri, 28 Feb 2025 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBfYwbSn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919701D9A50;
	Fri, 28 Feb 2025 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779668; cv=none; b=SdXFph5/BdaFp5coDO5OUEmm9iXk/2u2c/ai/Re0vfKa79xjmSKInGFMcZcloWHmXAhk9mXqyK61sWy3RTFLuzmQxenjBCutuDcM5syiO/V9egrE3s1CfWz39szMUyXLdzgapIrsgWBpbx43OtYEIiS884Lys9mnM3SS4cqVjWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779668; c=relaxed/simple;
	bh=lPLFh+00xp78235bh44TfGLXIDG+nOh0mclninRKRyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmLZj081h2+McKrrp2mWbfzL2qJ3xYYbK6C2iyaSQGF2bs96kMuEGbzmVH9LuTU7iJWj78G59IdCkKl/N9LfP2GohxXSkazGx+acRfpIl3FjA9zILZPWRaD3jO1yBrxwWYcOHIpdVC5zp0M1eWaPX6ksGGnft13lbXGOF0erEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBfYwbSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28DAC4CED6;
	Fri, 28 Feb 2025 21:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740779668;
	bh=lPLFh+00xp78235bh44TfGLXIDG+nOh0mclninRKRyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBfYwbSngjDbqOzR37piyYJJcx6t1dyst5pJ6u5QbGRVsI5Wu4tc5qP/SD0Nw0BzE
	 ONw014XSi7UKWKvJdb+MHaHs5D8sKdo5SrTUVqZGEr+QO4F41ztzXcC/Jm/1OqaKab
	 EmwWw91YTylLtqIt4Gi7fjSotl5uiEboYIqoBhAJn8X5A0saOO/GKC7QleUfY1EGmO
	 Gqyy/IRssEDpX5gH4JSQDPpdIOZhujelNTaCFZrdF5nBfriVDUxn0cJ3FWZ/LcgIJ4
	 ghbLoGVGmVgYc+X+cddNHGq6MA6ruxhvVkrmtlB92ltBiHsS4iQr7bh1ZSl5zAGw0M
	 jjnvymy+QCHjA==
Date: Fri, 28 Feb 2025 15:54:26 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: jiebing chen <jiebing.chen@amlogic.com>
Cc: shuai.li@amlogic.com, Jaroslav Kysela <perex@perex.cz>,
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-clk@vger.kernel.org,
	linux-sound@vger.kernel.org, zhe.wang@amlogic.com,
	Mark Brown <broonie@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>, jian.xu@amlogic.com,
	Michael Turquette <mturquette@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 3/6] dt-bindings: Asoc: axg-audio: Add s4 audio tocodec
Message-ID: <174077966526.3761473.14676912177806602380.robh@kernel.org>
References: <20250228-audio_drvier-v3-0-dbfd30507e4c@amlogic.com>
 <20250228-audio_drvier-v3-3-dbfd30507e4c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-audio_drvier-v3-3-dbfd30507e4c@amlogic.com>


On Fri, 28 Feb 2025 16:04:11 +0800, jiebing chen wrote:
> Add the s4 tocodec compatible
> 
> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>
> ---
>  Documentation/devicetree/bindings/sound/amlogic,g12a-toacodec.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


