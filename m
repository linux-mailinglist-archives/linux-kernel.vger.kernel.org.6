Return-Path: <linux-kernel+bounces-370475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 972E39A2D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 240AEB22587
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46C21C194;
	Thu, 17 Oct 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVBuHu+3"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281851E0DC3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192074; cv=none; b=YKYaAlGOYhkL7AYGNFfL1GsLt4CpYy+vCQJVpdmK16OMFHwQKsDanQtRhA1jOke8qhgDgAb51gEvVJHEANNCH7N3ZywonJIR2KPzuOSpi/N13fFnnU9mqisUqLkbB4H0sZQj5CdDeGpa2AuWDIzhkPcBTjz3B3kMoF0qD/esbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192074; c=relaxed/simple;
	bh=4+ixJyekF1jl6uiAyjfdWox0tZfOmu1tTOx5QFEdE0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dM/0/qOoKuTBtyxy3IKO5O/orph4c8bBMhwP4pHubHDi05o3s3ufIHE+9bbQniu558eM5ivoo9pGJZh+rSJBySs5cnn6C4qqjFwscudQWI00FIU0t+eqsRpSmWg5su5eTDUeX+7lxHXE16yL+S5kJMixZU8pEm80QTnPSLy/SAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVBuHu+3; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so4914a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729192067; x=1729796867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uixfl2jtVqbJqFwF+ymcJ/PUl6a3StJk/DrSTA+CVC0=;
        b=eVBuHu+3iIsWKuaLIQweQNQ6zGI9Ek5ZllO41IKg3KRNgGfDumdXWGf9JZLWU0d9JF
         FYaM5BatJ3Sgh8YD1fWV8Vute3gbEdyyKkK54vSPNqsD1tC3aEfUXu6HKsIIP/dwAe+5
         d1dJTD1qb7vNjX7CaK19thK3es6jUuVtCXB5zF+PZdgBFNlE2hC1VyMSZiYvFk7qfZHw
         j7LiTEE/c4oCWtg94qW+KQ5KwzhVtXidwhlTa6NtiWbBsdIBexWvOpXHKd3EsO4tH5rQ
         O4+iD4fn96Fw8OiDhu39edtw2Q5HO4AbiYzXziR8gPJO1VMzLTCKBNYXQ/iqEobxn75e
         ALSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192067; x=1729796867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uixfl2jtVqbJqFwF+ymcJ/PUl6a3StJk/DrSTA+CVC0=;
        b=ncK9ypKDLj061FurjssoAaSrAvngxxWIz9qwPNOHSSQDAI3jQ/Jem/tIMzTzpAOb/W
         D2W1kTrfm0mwUol2yOrdf7pJhQ/PHVPaMSDB2C/Rp1F+rbFmHIeNM2CuekkVHmKAAkkU
         WrtwyWUp3sEZLdXzWe7gJEe2H9FLSZkXmqNirwPyMfBxBinIQyCI+ST+JUqF+xCisiPe
         D5iq7/ZjQL6nhrpuA1D1easdMSnzz9D4J8GZBni5a7bTnSgMKglnzOBH57bAsimuY4J1
         k+zZsCUaohf6xVUIE7DLUYtDmc8RRZ3pjlXCCxkAHlkCv57XLPvt59cZlhvRM22Gtjsg
         lE/g==
X-Forwarded-Encrypted: i=1; AJvYcCW2EuMiIwmsLkynJ2QsagV/TRoa0kx/xVAJmt5oDnnuBnu4BaQVVBOIdZrOin95BfTXuRT176I+POIxfEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7dIvz5xW+dbHdi3QFenIXKIPGiJu3UrRRPrAqT0NAvhWz1DXR
	TCHdWizAdT/svwyE/JWrlXxW1tcirPL6WFe/4RRuzyJK2s03KdQ/rurXYruiAd4J7LJ5Odrr4Pa
	lXlp2kRvY5CoQ6vVtMK7NOUQ7fHcUPCXdlQ/l
X-Google-Smtp-Source: AGHT+IGJ5bOtzlZwtV+s5IaY9jBglbZpjiJuoBwT3AgW89JKzeUwi0aGlcdr06htRSmxbUTs1hCk4iI1TzT9Wa0QxxI=
X-Received: by 2002:a05:6402:2709:b0:5c8:84b5:7e78 with SMTP id
 4fb4d7f45d1cf-5ca0a186b93mr58751a12.4.1729192066673; Thu, 17 Oct 2024
 12:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com>
 <202410170111.K30oyTWa-lkp@intel.com> <CAG48ez2T7i_qCAcGi3nZqQeT8A3x42YSdL=rWqXOUDy5Eyaf6A@mail.gmail.com>
 <ccc4e0a3-34f5-4793-bd05-ee0955c9c87b@mev.co.uk> <cf1a2818-1b78-4422-bb76-421732c428c0@mev.co.uk>
In-Reply-To: <cf1a2818-1b78-4422-bb76-421732c428c0@mev.co.uk>
From: Jann Horn <jannh@google.com>
Date: Thu, 17 Oct 2024 21:07:10 +0200
Message-ID: <CAG48ez1RWTEW_ZJBYbt6WWJX90haM61pwqqb3u9Pq8C_q71bQQ@mail.gmail.com>
Subject: Re: [PATCH v2] comedi: Flush partial mappings in error case
To: Ian Abbott <abbotti@mev.co.uk>
Cc: kernel test robot <lkp@intel.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, 
	Frank Mori Hess <fmh6jj@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:48=E2=80=AFAM Ian Abbott <abbotti@mev.co.uk> wro=
te:
> On 17/10/2024 10:29, Ian Abbott wrote:
> > On 16/10/2024 23:05, Jann Horn wrote:
> >> On Wed, Oct 16, 2024 at 8:05=E2=80=AFPM kernel test robot <lkp@intel.c=
om> wrote:
> >>> [auto build test ERROR on 6485cf5ea253d40d507cd71253c9568c5470cd27]
> >>>
> >>> url:    https://github.com/intel-lab-lkp/linux/commits/Jann-Horn/
> >>> comedi-Flush-partial-mappings-in-error-case/20241016-022809
> >>> base:   6485cf5ea253d40d507cd71253c9568c5470cd27
> >>> patch link:    https://lore.kernel.org/r/20241015-comedi-tlb-v2-1-
> >>> cafb0e27dd9a%40google.com
> >>> patch subject: [PATCH v2] comedi: Flush partial mappings in error cas=
e
> >>> config: arm-randconfig-004-20241016 (https://download.01.org/0day-ci/
> >>> archive/20241017/202410170111.K30oyTWa-lkp@intel.com/config)
> >>> compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
> >>> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/
> >>> archive/20241017/202410170111.K30oyTWa-lkp@intel.com/reproduce)
> >>>
> >>> If you fix the issue in a separate patch/commit (i.e. not just a new
> >>> version of
> >>> the same patch/commit), kindly add following tags
> >>> | Reported-by: kernel test robot <lkp@intel.com>
> >>> | Closes: https://lore.kernel.org/oe-kbuild-
> >>> all/202410170111.K30oyTWa-lkp@intel.com/
> >>>
> >>> All errors (new ones prefixed by >>):
> >>>
> >>>     arm-linux-gnueabi-ld: drivers/comedi/comedi_fops.o: in function
> >>> `comedi_mmap':
> >>>>> comedi_fops.c:(.text+0x4be): undefined reference to `zap_vma_ptes'
> >>
> >> Ugh, this one is from a nommu build ("# CONFIG_MMU is not set"), it
> >> makes sense that you can't zap PTEs when you don't have any PTEs at
> >> all... what really impresses me about this is that the rest of the
> >> code compiles on nommu. I'm pretty sure this codepath wouldn't
> >> actually _work_ on nommu, but apparently compiling it works?
> >>
> >> I don't know what the right fix is here - should the entire comedi
> >> driver be gated on CONFIG_MMU, or only a subset of the mmap handler,
> >> or something else?
> >
> > Given that it would also affect a lot of fbdev drivers that would also
> > benefit from zapping partial mappings, I suggest that gating on
> > CONFIG_MMU would not be the correct fix.
>
> Perhaps just add an #ifdef CONFIG_MMU around the affected call for now?

Sure, I guess that works, though it's not particularly pretty.
(And this codepath looks like it won't really work on nommu either way...)

I'll change it that way for now.

