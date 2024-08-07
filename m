Return-Path: <linux-kernel+bounces-278063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E02394AA66
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6567281E04
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB17D8002E;
	Wed,  7 Aug 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjmEc/25"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7208F757F2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041448; cv=none; b=LDNWp+ywm9RL3dooZNVzwCzgfUMOuen9EYxoC1ujaA6iKsceEbcqb3818mDU/v+5HTb9BXx/gXB2RdRx2BDT0pBOYfRYGK7b7dtKr0v2cNni+Q32BNZwJd1BlnJ3MrHCvrdxhV0M75oRcL4Dhq7B7RWVXSOwuOOaZ+e2weedr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041448; c=relaxed/simple;
	bh=yCdkQ7/2tMkcEeFdGMDnJIR5LtLUAVGR0TVpFDG8DMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUGWJazl2xT/cZfaD+kMHTPVfyWdQrd1DXuX9C9fUONZIZ6uAyA7GJhpIDQv2+G1lS6LUBOE8GLH3samsWJYe+npJIaJHUPPbbNKH89ZEVEQ/vueNUPho4a5/O8geu90fJV6/dG/1uzxRjdw7KefkvHJFxgUc4L2lEDVd0/lEy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjmEc/25; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f1870c355cso19655391fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723041445; x=1723646245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDq7CBu31RtHS+zX+Dsqd1NEBtaTlUV0/5eE9A6umII=;
        b=KjmEc/25PvOJPOfCm5POdhe5S3I3vl/JH9tOH3Fsv5/NU6laWBDcXpwSopcoS2GYMh
         56mBZl7HvZxPiBhBrtR9Prsmox9AB+74Nwvtao85hjLRtmJluyOjiRA8HTyZsi9+qm97
         qWSSUujxM4Ej9QYFwNXdILwEZqMWInGTBQSISzO3el/eSgTmckXj3XNKfRp1m3hSHyck
         jSGHCtr+r1xz0oG8sNl8yEyywINlEmBS68OJjXJM5sCm0HwS+Uy+N6Ld+18GDqN/PpPd
         wdYRRcGRxX5I6rdUnE57UpnDdsMw4imalQFGCzzr91x37gKohKHrUEcCTwZ+6HOliWy5
         KG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723041445; x=1723646245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDq7CBu31RtHS+zX+Dsqd1NEBtaTlUV0/5eE9A6umII=;
        b=HnbrM6f+vcNRRK1Us7f6cC7YCDWdkC7IsemASh7bwl/z/VqT7zUEEe5GD0JMp+VLYA
         rvc7DgueE5pAE2W1OTHrxg4vamnJApy+nv8WIP42aSssvzEyzZw+SezgYe/3NR41z0qf
         gTX8623NP8G487IyHqv9wApxCGpAbrkEGUN0AAABxcTTXEUzeyx1AxTogMJYurseU/Rg
         cQTYT4/N0DmOArsGbE77ogr1NE2rZdlJrmSrZ3YlP2TYy1EyTk3UHg9tF2inX0gygDl7
         KIamyezf6ZE1CflrR41za29iMXLRPi7zyGUng/g0FWMHdpkyFEEAfC8QIoJgQZ6d2Tn3
         pskQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHa3xJ/FK0QTj+T5QCfe84w8XJhqdd+me02zHfmUmpUifTZEEhrW1qJRuvFholBFxvjS5fxoM0L3Emzuh7CWv8Iaf+DaW/WR3psjHx
X-Gm-Message-State: AOJu0YwHs9Fn0ROWMHPv1I0p4g5HyrjxXuWXIQT1Xx7ExfT/HGLmAwZz
	JJDdvcOYM9dAq00jtG5Q9Ug7/Mi1z66JO+Zm4H0zYyIJEw71kh+utSbU/Uh5Mb+WFTMXkTjmLpR
	4xCIrTtuBEXOAdsd4YPp/Oz55Hv8=
X-Google-Smtp-Source: AGHT+IHUixa64DDNXcCvuHmzvxQeIQKCd9G6ETNw3IrebfGG8OtK8H/UfalAmhoErP9xz76uypwDkXTJP2OyuWuClPc=
X-Received: by 2002:a2e:8e98:0:b0:2ef:24a9:a75d with SMTP id
 38308e7fff4ca-2f15aa95c7dmr120690541fa.14.1723041444208; Wed, 07 Aug 2024
 07:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zq2qQW62G63dr70s@archie.me> <8734ng4e91.ffs@tglx>
In-Reply-To: <8734ng4e91.ffs@tglx>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 7 Aug 2024 16:37:12 +0200
Message-ID: <CAFULd4YZbK5bvLCfEnX7y0qZUgtQuw6FfGMBKm-qjVMZvH8XWw@mail.gmail.com>
Subject: Re: Fwd: error: 'const_pcpu_hot' causes a section type conflict with
 'pcpu_hot' when compiling with -flto
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Takashi Iwai <tiwai@suse.de>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Stas Sergeev <stsp2@yandex.ru>, mrwizardwizard <terrym3201@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 4:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Sat, Aug 03 2024 at 10:55, Bagas Sanjaya wrote:
> >> when compiling linux kernel 6.9-6.10 with -flto
> >>
> >> compiler outputs:
> >>
> >> ./arch/x86/include/asm/current.h:42:25: error: 'const_pcpu_hot' causes=
 a section type conflict with 'pcpu_hot' const_pcpu_hot);
> >
> > He could reproduce the build error on mainline:
>
> That's caused by:
>
>   ed2f752e0e0a ("x86/percpu: Introduce const-qualified const_pcpu_hot to =
micro-optimize code generation")
>
> Uros?

I have taken the discussion to the bugreport, where the potential
patch is also posted.

For reference, my answer is as follows:

--cut here--
(In reply to mrwizardwizard from comment #0)

> when compiling linux kernel 6.9-6.10 with -flto

You need a whole lot more patches to successfully compile kernel with
GCC LTO. The last revision can be found at:

https://lore.kernel.org/lkml/20221114114344.18650-1-jirislaby@kernel.org/

The patchset defines CONFIG_LTO, which can be used to disable
offending optimization, something like the to-be attached patch.

Ideally, a LTO-compatible "const __seg_gs" qualified alias to struct
pcpu_hot should be declared, so LTO can retain the disabled
optimization, but ...

... the LTO patchset was rejected mainly due to:
- the performance is the same
- the resulting image is bigger
- we need a whole lot of ugly hacks to placate the linker.
--cut here--

Thanks,
Uros.

