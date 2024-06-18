Return-Path: <linux-kernel+bounces-218629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 481AF90C2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F038B1F22CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E7A19CCF3;
	Tue, 18 Jun 2024 04:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTi7MVJl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92DA1C01;
	Tue, 18 Jun 2024 04:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718685255; cv=none; b=aOsn4/54SLnuuwBx0J/ov/QDNBtvCT7Byh4QAcp2zzbEMY6VJvZbJOz6xI89Q2kA1zV800X46mI8JDz6gDERWZdqHi3z6oto2z40S+ip7jAzM8uptlgARdzYJSNCJH4R0ySg6GmccuUOe/XvFfgehkz7pg58/ZX7cdUFPjNFMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718685255; c=relaxed/simple;
	bh=cVWaqdmlVB3MhB8ZS2KfEGlzyVZFQobqyrEiIiYPoSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TI8YZGGnW7dD6DlGFuSSUzQcdZu77t2JwfsQxUsz7DnxeFVIoDqTvfYHJPAqjnhjBZ3LMooPfiEbI3jqILTUpPO+1hh7RgCFc4aVyP2cGOuNvsBI+JIF4OuYzXiEWOAn/g5keTBP6GAbIWdryGygRuGQGGeqA9ktpf+XfcTTzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTi7MVJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812B6C3277B;
	Tue, 18 Jun 2024 04:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718685255;
	bh=cVWaqdmlVB3MhB8ZS2KfEGlzyVZFQobqyrEiIiYPoSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTi7MVJlvd3DqJpnKOKwG1xNN9+M3Gsd6MebltbzdgYOGnNyiv6Qeq+xhqfRbROut
	 SMeCl95OGHDBKyeXsKqzjZiu8nRdzT8VF3nwmPVGyANifUQ4IVXBEyLiZbRBuA+r0p
	 kkJXl0ojinTkXRpSpsx3wYcxcPeHcuHbPZKbHXToNiDVwXn/Rz1XfUQPLNhFqQRota
	 Ji/Wh9lpLMGRuNhNmj0DSutuZbOngGorasQOGUjC3tgjSPUjrrJ+nW6aPnlpo7rFMl
	 BobHJwR5iAtT1Vvtyk20SeGII31d7mB1TqYIv6xVcD0QEwS+Lp2lQuDtie5Zzz8Zc+
	 WZdChbx6OiHBA==
Date: Tue, 18 Jun 2024 12:20:13 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@outlook.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v2 1/6] riscv: dts: sophgo: Put sdhci compatible in dt of
 specific SoC
Message-ID: <ZnEK_cg1xLbKOUAD@xhacker>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
 <20240612-sg2002-v2-1-19a585af6846@bootlin.com>
 <IA1PR20MB49534C9E29E86B478205E4B3BBC02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240616235829.GA4000183@ofsar>
 <c75601a1-1389-400e-90b9-99c1e775a866@bootlin.com>
 <ZnA3O14HOiV1SBPV@xhacker>
 <20240617-exuberant-protegee-f7d414f0976d@spud>
 <6a993b58-3d9e-4f92-bf47-7692c9639314@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a993b58-3d9e-4f92-bf47-7692c9639314@sifive.com>

On Mon, Jun 17, 2024 at 10:57:54AM -0500, Samuel Holland wrote:
> Hi Jisheng, Thomas,
> 
> On 2024-06-17 10:40 AM, Conor Dooley wrote:
> > On Mon, Jun 17, 2024 at 09:16:43PM +0800, Jisheng Zhang wrote:
> >> On Mon, Jun 17, 2024 at 11:16:32AM +0200, Thomas Bonnefille wrote:
> >>> On 6/17/24 1:58 AM, Yixun Lan wrote:
> >>>> On 18:47 Wed 12 Jun     , Inochi Amaoto wrote:
> > 
> >>>>> Is this change necessary? IIRC, the sdhci is the same across
> >>>>> the whole series.
> > 
> >> sorry for being late, I was busy in the past 2.5 month. Per my
> >> understanding, the sdhci in cv1800b is the same as the one in
> >> sg200x. Maybe I'm wrong, but this was my impression when I cooked
> >> the sdhci driver patch for these SoCs.
> >>
> >>>> I tend to agree with Inochi here, if it's same across all SoC, then no bother to
> >>>> split, it will cause more trouble to maintain..
> >>>>
> >>>
> >>> To be honest, I agree with this to, but as a specific compatible for the
> >>> SG2002 was created in commit 849e81817b9b, I thought that the best practice
> >>> was to use it.
> >>
> >> I'd like to take this chance to query DT maintainers: FWICT, in the past
> >> even if the PLIC is the same between SoCs, adding a new compatible for
> >> them seems a must. So when time goes on, the compatbile list would be
> >> longer and longer, is it really necessary? Can we just use the existing
> >> compatible string?
> >> DT maintainers may answered the query in the past, if so, sorry for
> >> querying again.
> > 
> > For new integrations of an IP, yes, new specific compatibles please. New
> > integrations may have different bugs etc, even if the IP itself is the
> > same. If there's different SoCs that are the same die, but with elements
> > fused off, then sure, use the same compatible.
> > 
> > I expect the list of compatibles in the binding to grow rather large, but
> > that is fine. No one SoC is going to do anything other than something like
> > compatible = "renesas,$soc-plic", "andestech,corecomplex-plic", "riscv,plic";
> > which I think is perfectly fine.
> 
> And you can do the same thing here for the SDHCI controller: if you think sg200x
> has the same controller (and integration! e.g. number of clocks/resets) as
> cv1800b, then you should keep sophgo,cv1800b-dwcmshc as a fallback compatible
> string. Then the driver doesn't need any changes until/unless you eventually
> find some reason they are not compatible.
> 
> It's better to have a SoC-specific compatible string in the DT and not need it,
> than find out later you need one and not have it. :)

Good idea, this solution looks better! Thanks for the suggestion

> 
> Regards,
> Samuel
> 

