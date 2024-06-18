Return-Path: <linux-kernel+bounces-218634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2140D90C2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 06:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70054B2193E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220F018036;
	Tue, 18 Jun 2024 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh6Na5MH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7C53A9;
	Tue, 18 Jun 2024 04:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718686107; cv=none; b=gvD/YlOrPwp7FlCEH0yNCTn5sswcYNLtyrAEOwXEohskf9p68P8JA7VAf5K1KW8Pisy/zmPontjSATo5kIs+Nye1EQo3Jo0BE4vQ2fh+MReuWSwIjcl0AkVyIYQ3swgfXTBerLYyNEk3ho+jv+OAgd+yJ5oS+/WIyrM8bV8yH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718686107; c=relaxed/simple;
	bh=uQRT705hswxV4eHkecwYH5nnl/fTVa9ZyWh6LbZP3oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPacbMyM3YsPwIzmOxDnVcO9MzLKlghrKaL02VWhaG8OBG2Fm1ZJ0nw+gF4F2aWWEyaaK01qqJn5LxO42oATLIleoCStXbA+7FZRolQAflXDhMcT8pmU+yqE6x7QnK/s/cPFjA/W9ATbZvPYLuYylnH6TNfZvZXlTpqfnx4/sxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bh6Na5MH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92685C3277B;
	Tue, 18 Jun 2024 04:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718686107;
	bh=uQRT705hswxV4eHkecwYH5nnl/fTVa9ZyWh6LbZP3oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bh6Na5MHc3JrAvMbsJpyCpZKvDy2XEoJrEmyR5EvCKzupYOrvNfZogz7BJtaibGlm
	 fYBMJkQONTPddF47mFqhUbUTi/T832VplagecpzuDma3vWQnxjImCiAxuk4n516Zfx
	 ueMvb1lpkIBFBTmtdXj8CSo1lf9btx8mnO4JDrofcdsCyUJN/KG9ohJ5Wa6qc3mdx7
	 8FhaxrQz87M3Vh+dRwj6vVA/3vmqFvZkovmoqYNCrUJYpChnLGj3fWI4g2nnqdfWtH
	 V1FhxpfJT5gGQ4nwmXEzFsg++64f6qdQSzLAqyE9PylKgo9sAlYumN4wghb2pk6MCU
	 LMG/+hx82la7w==
Date: Tue, 18 Jun 2024 12:34:27 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Yixun Lan <dlan@gentoo.org>, Yangyu Chen <cyy@cyyself.name>,
	linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jesse Taube <jesse@rivosinc.com>
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
Message-ID: <ZnEOU7D00J8Jzy-1@xhacker>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <20240616-exorcism-computing-e11e26084a62@spud>
 <20240616224811.GC3983622@ofsar>
 <ZnBEBQjTQtFs-fXt@xhacker>
 <20240617-synapse-carmaker-0a59c7c6edb7@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617-synapse-carmaker-0a59c7c6edb7@spud>

On Mon, Jun 17, 2024 at 04:32:59PM +0100, Conor Dooley wrote:
> On Mon, Jun 17, 2024 at 10:11:17PM +0800, Jisheng Zhang wrote:
> > On Sun, Jun 16, 2024 at 10:48:11PM +0000, Yixun Lan wrote:
> > > Hi Conor
> > >  Thanks for bringing this up
> > > 
> > > On 19:35 Sun 16 Jun     , Conor Dooley wrote:
> > > > On Mon, Jun 17, 2024 at 01:18:52AM +0800, Yangyu Chen wrote:
> > > > 
> > > > No MAINTAINERS update, so I figure that means you don't want to maintain
> > > > it going forwards? If there's someone out that that does care about the
> > > > spacemit k1 (Jesse maybe?), then I'd be more than happy to have them
> > > > look after it.
> > > Yangyu kind of has limited time, too many stuff for him..
> > > 
> > > I'd volunteered to help on this if it can fill the gap
> > > Also I'd be more than happy if anyone willing step forward to co-maintain..
> > 
> > Does maintainership work like this? Is willing to do enough?
> > FWICT, maintainership involves active patch contributing, reviewing and
> > maintaining the whole SoC. It is better to take over the maintainership
> > after showing enough patch contributions and understanding of the SoC.
> 
> I was going to reply to your other patch about providing more complete
> "basic" support for the SoC, but I guess I'll reply here and address
> both points. After the k230 and th1520, which were both merged with very

When I saw k230 a few minutes ago, I assumed you mean k210 since I
didn't found k230 support in linus tree now. After searching the
maillist, I found oh there is a k230 series which is similar to this
series, no pinctrl, no clk, no reset. Since the incomplete K230 initial
series hasn't been merged into Linus tree now, is it possible to drop
it so that we can avoid the same mistake for k230.

> basic support and have made very little progress towards being a useful
> platform, I'm pretty reluctant to merge another platform in a super
> basic state. I was going to make this point before you brought it up,
> but it's good to know I am not the only one with that view. To be clear,
> I'm not pointing blame for those platforms, I'd just like to avoid a

Yep previously I thought it was fine to use a fixed clock or dummy clock
during the initial patches, but I changed my mind now, especially after
Samuel complained the cv1800b reset dt changes.

> repeat. If Yangyu doesn't have time to do any development work on the
> platform, I'd like to see someone else (and as I mentioned Jesse is
> interested) take on getting some of the basic driver patches written and
> merge only when those are accepted. Having no in-tree clock and pinctrl
> drivers is definitely a hindrance to other people doing parallel
> development of drivers and I'd like to avoid that.
> 
> Getting back to your point in this mail, whoever gets the platform to
> that state is well suited to looking after it going forwards. Some other

The person who can bring the platfrom support to a well-moduled state,
IE, proper clk, pinctrl, reset drivers shows the passion, the code
contribution and solid understanding of the SoC, sure he/she is
definitely suited to maintain the SoC. I just don't think it's 
a good practice a person can became maintainer even w/o one LoC
contrubition to the SoC, because IMHO code contribution matters
for maintainership.

> interested parties could also join as reviewers. I don't want to see
> people joining as maintainers that are not going to have an interest
> in the platform going forward, as that'll just end up with me as the
> defacto maintainer.

> 
> Thanks,
> Conor.



