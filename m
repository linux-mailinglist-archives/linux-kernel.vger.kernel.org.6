Return-Path: <linux-kernel+bounces-184183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EFE8CA3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB751F21D34
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91065139CF8;
	Mon, 20 May 2024 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY+wyvYK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DEE1D531;
	Mon, 20 May 2024 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239181; cv=none; b=D+15wpNDC9voJK5j62VaYcPIiPB0hdne0AOU9DZcVxUtXBwT4JU4bBOAMyUmh+OCS/hzz7rmtlVBHAeNypLmOhKvJTppPgZnNWyhK13I+xyVmgEodNQ8lOHg5ydxJ4TttbXKL3f/0tGWdLo2Py1M0D2ug30ZRyxsjabrUnn50pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239181; c=relaxed/simple;
	bh=X6Yvl2HDN1mwWgAijkjfXODat3krxuLgb+ypTVFjGv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDTnMvEQ9msGphF+wczSUKPuAu7KIhr4zOSziXqvcLZx8JPWwxZHJS/wTlzbkYv8Na+pcC5BXzI7IgXE2i5F55AaNbClgRoeicpjQe2Mtt+O+W2bIPv3Hz1JfwBNK4hIsZPj+rv2i8yEbw3PHogLCJQmdAF1eqlNJlfk8hHRR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY+wyvYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E099C2BD10;
	Mon, 20 May 2024 21:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716239181;
	bh=X6Yvl2HDN1mwWgAijkjfXODat3krxuLgb+ypTVFjGv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EY+wyvYKPs8iGaPysYr7Et988UMSXiwI419njQKsmPThaJp3i+bwsK0gM1n3tBUkB
	 osmpByAYYVNe54/ioOCak1Lp7AvjpuVoNYhNZcFYn+SMDJQI1oKJkEnUsexNdOJQwc
	 qZ3AblTs96k6TCOErZT9GOfAU54MpoJcrdK18Wv9WaCz/cAjEKlvsn6mrL43d5NE09
	 PmiP5kyGdcupvO58nw69rxigTy/H6mQOesNK6zfogwSbcOxjN8X7q9dA5VabLSq/b7
	 fDIjfZIFnMwdFg8wMX2IVbuyIvkGnLgKqYEMr5vQuuKhuBDF28ZVWve74ryr1bvmNo
	 znWOeHo8UqtlA==
Date: Mon, 20 May 2024 16:06:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-arm-kernel@lists.infradead.org,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	linux-kernel@vger.kernel.org,
	Lars Povlsen <lars.povlsen@microchip.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	UNGLinuxDriver@microchip.com, linux-mediatek@lists.infradead.org,
	Daniel Machon <daniel.machon@microchip.com>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: soc: sprd: sc9863a-glbregs: Document
 SC9863A syscon
Message-ID: <171623917700.1507883.13414727469852068344.robh@kernel.org>
References: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
 <20240519-dt-bindings-mfd-syscon-split-v1-2-aaf996e2313a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519-dt-bindings-mfd-syscon-split-v1-2-aaf996e2313a@linaro.org>


On Sun, 19 May 2024 20:42:17 +0200, Krzysztof Kozlowski wrote:
> Document sprd,sc9863a-glbregs compatible already used in DTS and other
> bindings example.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/soc/sprd/sprd,sc9863a-glbregs.yaml    | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


