Return-Path: <linux-kernel+bounces-410789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D199CE30A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB25AB35A16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C8C1CEAD1;
	Fri, 15 Nov 2024 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4LGXIKQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDE912F585;
	Fri, 15 Nov 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679828; cv=none; b=jzUdyqI9PuMpgkg5vk8APrWnuxDzQGdL/gmVttP6K6qopmH2Q2yzgrsP1KN5FyDEsI2FnimnAa0bj6TqRTyJceefjaAStGuYvZd0JWxBw+huJHvJPCeIYI7sw+1ASIVm1RZ77rtLLZGga2ooxWEYplKVZyG2ZQU8B8ktFNfy6ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679828; c=relaxed/simple;
	bh=8CSwi+zLM3ewH0q5v5yP7A9xGFhlcIhP7HN+w9H2H84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+EDwatqQQHZbENC9/BtcCnjogtMcx+HiOAvoVkhQ46tKaG41qf7Qdfic1gSP/adTboxCIOk6WSb1yM4GHLqlKJRx7HGdzXFpOTjxFvn1v3DUAKIhH8jV+38aC8dya8KJgrmhydSExO1R6S3VTQikNxFEqHbZoIBn09HjxsqSOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4LGXIKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD0CC4CED2;
	Fri, 15 Nov 2024 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679827;
	bh=8CSwi+zLM3ewH0q5v5yP7A9xGFhlcIhP7HN+w9H2H84=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F4LGXIKQnejA/xtyDR+CZAuDhnASsY/r7MFj28/Q50y5I/BIOT3N6+t7VWbBMGOT8
	 4P46s4uf3LW/HD5irCXeQJr7iAqGWkWlvDVrxhthCiZTMz479sWgAilGub1OWcCXTZ
	 hBDZqwNuNPx7kTfVypIADM01/zVb5cAVk0p8BoxLbsgiQHWJmUJJZUQrpXI9lL/d4P
	 KHs8rqYZk9wpDPZ7RpSKnFEf7WkJNrmhBQgxSZjCFpIvjKYyMWMaMW4311dOqcthwy
	 gZJawSiE2nlKmzKx3LjG5p3M6zB+Y5nTmEShxpcqHzPKcrFOTLCjoEk7PH4XRB8dmh
	 CNnQ2YFK9X1ag==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e382350652bso885187276.3;
        Fri, 15 Nov 2024 06:10:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbzf3h+7hhHBpSMezepbAXAYOsa5K9czU8x2wizDTNKG4GrLZprPYqe2vn88fON5wMKXOeLfQyaZHaEUsf@vger.kernel.org, AJvYcCX7RGWSKxOaj5lFOmm0fkGf8RuMTWJY33I0MSgufaV4++x0IQa5fDVzsLQJ+ZVhNawolA0oYWVYhdO1@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+13bee8f8/SNX8iM9jCzrSUus/Czz7CHYz8igOYERAgVg65C
	zwpwAFZQp79lya9OlIDGH6thERNcgjSXgH/8/sdGz6sI4Ivf/qDgSj5mf+KP4EOVYB0qm4jEpdV
	WYI2Zq6ACUd07tIH5iFi4mHNIfg==
X-Google-Smtp-Source: AGHT+IHryldJ3ukfy6/K9XYjT+zG+pVX4OOyz2cm6ONsY6VlQexu1ggrxHZf21CfHDkABwxYg58gi7ylStJXS609Zfc=
X-Received: by 2002:a05:690c:6707:b0:6de:a3:a7ca with SMTP id
 00721157ae682-6ee55cbc10cmr35436367b3.32.1731679826592; Fri, 15 Nov 2024
 06:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106171028.3830266-1-robh@kernel.org> <87jzdfcm3l.fsf@mpe.ellerman.id.au>
 <20241114125436.GL29862@gate.crashing.org>
In-Reply-To: <20241114125436.GL29862@gate.crashing.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 15 Nov 2024 08:10:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+OCMa1P_AAxL7LxRjo7iJ368wwYFOhZ_-rSYbs=0QbWA@mail.gmail.com>
Message-ID: <CAL_Jsq+OCMa1P_AAxL7LxRjo7iJ368wwYFOhZ_-rSYbs=0QbWA@mail.gmail.com>
Subject: Re: [PATCH v2] of: WARN on deprecated #address-cells/#size-cells handling
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Saravana Kannan <saravanak@google.com>, 
	linuxppc-dev@lists.ozlabs.org, Conor Dooley <conor@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 6:59=E2=80=AFAM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Thu, Nov 07, 2024 at 10:35:58PM +1100, Michael Ellerman wrote:
> > "Rob Herring (Arm)" <robh@kernel.org> writes:
> > > While OpenFirmware originally allowed walking parent nodes and defaul=
t
> > > root values for #address-cells and #size-cells, FDT has long required
> > > explicit values. It's been a warning in dtc for the root node since t=
he
> > > beginning (2005) and for any parent node since 2007. Of course, not a=
ll
> > > FDT uses dtc, but that should be the majority by far. The various
> > > extracted OF devicetrees I have dating back to the 1990s (various
> > > PowerMac, OLPC, PASemi Nemo) all have explicit root node properties.
> >
> > I have various old device trees that have been given to me over the
> > years, and as far as I can tell they all have these properties (some of
> > them are partial trees so it's hard to be 100% sure).
>
> Many SUN systems won't have such superfluous properties.  But does
> anyone use such systems at all anymore, and do people use dtc with
> those :-)

There's still a few presumably. Sparc is omitted from this warning
already because I suspected a problem which was confirmed on v1 thanks
to the DT dumps here[1].

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/davem/prtconfs.git/

