Return-Path: <linux-kernel+bounces-512210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67FAA3359F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82078166C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AE0204080;
	Thu, 13 Feb 2025 02:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7tJK2xe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E923BE;
	Thu, 13 Feb 2025 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739415070; cv=none; b=K8eb/vphAmt1q6+V1FofC32EBGUyMJ03dy3QfMeq0RE6+8zyyqRsi0mgkT6N8zeZ5mPUMfoMlDr3tIgG/m8fGxkprBMDfHKNJhH3PZfB977qFN29999hpjJhnNmV2vHYaenM0J1xofvJOvHNTfo0aZTY00h1uvpQpzFmnY3AycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739415070; c=relaxed/simple;
	bh=D5FcE6li1n/xmFgPW5rMrv2CGWOnvJjA2ZyGHpiMP3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZk7Urh72JIOVevSA60pVaV4RhI3+JFDKSskAfePkG65IRrv4tyHquZzhl5TBH/iqSkQIVSb12GjPQwVVhz/N5sd/ZYmDHoOTyuPoQl0OjSQ6O6GGlTLQD8swvgx+TOz71tp16zZZM2kTpPAmlGaZHqn+8WwzK72kjW7lDMphbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7tJK2xe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C93C4CEDF;
	Thu, 13 Feb 2025 02:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739415070;
	bh=D5FcE6li1n/xmFgPW5rMrv2CGWOnvJjA2ZyGHpiMP3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7tJK2xe+nnWqa4qPU/UsuL/Q4BwMQEI2HZQLC+ATf7gUiSqwfjzBxd/B/7jWw3p8
	 cma792rh/j3zQIfS1W0+irVN3oOrAPOtcDBkvM0I6zLATOj4VxZOD9kEsN9hQCVzBW
	 XxWktZaiyb6Fed6z3whVITTd+srup/hjWndKH18MRohkBCPrJtdISkNFI+uarcudXT
	 u0euR+v1BuiRMsyFIeBDoDqKMg4YG/oq9Hnz02DyYkJ15UfiXD1ARrDBB1pIzbU3FG
	 Z8PlLf2Ah+GvvvAdvhqIqne7J6Ki/8GT9KoQsf0R1yx4+MF2wXnNJV97Do7ltHUaAZ
	 TYvN0yT+auVDg==
Date: Wed, 12 Feb 2025 18:51:08 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
Message-ID: <20250213025108.svqgj5nzseqs6qox@jpoimboe>
References: <20241217010905.13054-1-yangtiezhu@loongson.cn>
 <ef1e3e7c-0117-175c-5a85-091382696748@loongson.cn>
 <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn>
 <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
 <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
 <20250211233056.q47mp5askk7qrxcp@jpoimboe>
 <CAAhV-H563HcK2bck2k+VLTvrf0C7=cEMr8BJpQhFdJNc+dFOUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhV-H563HcK2bck2k+VLTvrf0C7=cEMr8BJpQhFdJNc+dFOUw@mail.gmail.com>

On Wed, Feb 12, 2025 at 03:22:45PM +0800, Huacai Chen wrote:
> > The new series now has 7 patches:
> >
> > Tiezhu Yang (7):
> >   objtool: Handle various symbol types of rodata
> >   objtool: Handle different entry size of rodata
> >   objtool: Handle PC relative relocation type
> >   objtool/LoongArch: Add support for switch table
> >   objtool/LoongArch: Add support for goto table
> >   LoongArch: Enable jump table for objtool
> >   LoongArch: Convert unreachable() to BUG()
> >
> > I was planning on queueing all 7.
> >
> > In particular, patch 6 should stay with the objtool patches since
> > they're directly related.
> >
> > But I was also just going to grab 7 as well.
> >
> > Please let me know if you disagree.
> What about you merge the first 5 patches, and then I merge the last 2
> to the loongarch tree? (I prefer to merge the whole series to the
> loongarch tree with your acked-by, but that may be inconvenient to
> you).

I want the first 5 patches to go through the -tip tree because we'll
have other patches depending on them.

I'll go ahead and take the first 5.

If you take in patches 6 & 7 separately, that might introduce a lot of
warnings.  But it's up to you.

For patches 6 & 7:

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

