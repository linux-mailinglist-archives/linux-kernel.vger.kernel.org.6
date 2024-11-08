Return-Path: <linux-kernel+bounces-401589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FC99C1CA4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FB51F24387
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30221E5713;
	Fri,  8 Nov 2024 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/AHMdy9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587EB1946CD;
	Fri,  8 Nov 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067578; cv=none; b=cHNuzAnN8+IfLh4SdYfVpGcDe82WeKZRdRIgtvbVX7F301JgsHf3Enx01HyWsd/jHVgk8CWO5Focbo+YfcbaH3oFnZMAUzWXKH141m0Rql0tnAyXmiQxzuTgRp0GVOLB3GSMIU+KJhfbpz53I03bERds2jN3QajA246qM0sXHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067578; c=relaxed/simple;
	bh=k5V4h6BxNiZ+5GYsC8AtHJH1Y19abwPsT5oODrt+aKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pc3qNnf7eHgrAYP1546pfQjfrXVDrD+vCBOpZdBHaYGgiNlDTMzs5cmO7k/ta7sbMHK0VqmxbCi+9SC4sE4NNm0nesHehK6Kd4Pfb6WD9FbzbWPgg2gh3peefToPlLuvaDKQ9lG2kS+hn1lEXGyXj9hM5tIvI6qY8Jd38R2TcP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/AHMdy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37874C4CECD;
	Fri,  8 Nov 2024 12:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731067577;
	bh=k5V4h6BxNiZ+5GYsC8AtHJH1Y19abwPsT5oODrt+aKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/AHMdy9/JzZBChFnHYv2tNmzP3nyMNnbQOOIQoPba0k9deXm2DApl+QKXgIkcODQ
	 rNanJwJ79m6P7dbg7aKXjMLgEHBPiDAhIEGiOuHuo83nR6LIu436pqquVvQSK1L68+
	 uihqNx80DI4cE993ukfB3koO6d3O6L/G/4ex+R9qcsQOecrwWeWHmkc7/J+NKIhSUS
	 T7WDxS5A3kdguO+eeM99p6cyaq/NKSRZD7QGHzZwv0J4FY+gz6NJ/KUx1gKfwIOY9Q
	 PSL93Ga0y2zSKBpY4F+ZEzxk//NTuJA6wFUerc4ku1L0gL0HxiE5jardhgntx7adlI
	 ebK7SCVRHHFHA==
Date: Fri, 8 Nov 2024 13:06:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
Cc: James Cowgill <james.cowgill@blaize.com>, 
	Matt Redfearn <matthew.redfearn@blaize.com>, Neil Jones <neil.jones@blaize.com>, 
	"robh@kernel.org" <robh@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, 
	"arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>, 
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>, "andre.przywara@arm.com" <andre.przywara@arm.com>, 
	"rafal@milecki.pl" <rafal@milecki.pl>, "andersson@kernel.org" <andersson@kernel.org>, 
	"konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, "nm@ti.com" <nm@ti.com>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "nfraprado@collabora.com" <nfraprado@collabora.com>, 
	"johan+linaro@kernel.org" <johan+linaro@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: Add Blaize vendor prefix
Message-ID: <bxihsbvuj5yvasexkcjjlyz6q2uiotfsh2utwkcogkww33cgpy@wk2dbb5yhnzc>
References: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
 <20241108103120.9955-2-nikolaos.pasaloukos@blaize.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108103120.9955-2-nikolaos.pasaloukos@blaize.com>

On Fri, Nov 08, 2024 at 10:31:55AM +0000, Niko Pasaloukos wrote:
> Blaize, Inc. (www.blaize.com) is a SoC manufacturer with integrated
> programmable Graph-Streaming-Processors for AI and ML.
> 
> Resolves: PESW-2604
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>

This has checkpatch issues. Your patches claim to ignore them
intentionally: sorry that's not accepted.

The checkpatch error you have here is very odd and points to
misconfigured system. You must fix it.

Best regards,
Krzysztof


