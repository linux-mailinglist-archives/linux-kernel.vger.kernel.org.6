Return-Path: <linux-kernel+bounces-243512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EF992970B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 10:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9CD1F2165A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421DCF9EB;
	Sun,  7 Jul 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmgDTS6Y"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3F7FF
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720339942; cv=none; b=ThkDTXAnC/9PT1XzvTz1bSOOrGl5iG9S1ooX79AheQ13jPmWDrptwWhryy3AA/DWbe/ICstaiiLY9V0vRZiT/4XqBTXaBsV5ANrAGwwx+cBgGbysLk5FjCsyZ1Y7Au3Na4UvxYQZRUaBr4GwqbHdEJvqimGIn1Pzig4yFjOIFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720339942; c=relaxed/simple;
	bh=sjlaSQkHcIegINmraidbVbGxor/drjf3WB6FSzaRhvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8+jbVjpCgIVx2Aihf7YvgGAOVRm9xvgKrohXt6twJejspYcMBcHWoMIMISmPQNdOTSX7iZs5FBoZXFFG9HqUU9mLRPCNPuSsimF6azzw19N2Sr5qzhXxVWsp3x27vSKTKOP0WokrrY+7OjKeaLnaJecyXT057f3geFsEQkKetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmgDTS6Y; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7035b2947a4so1050937a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 01:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720339940; x=1720944740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFpie4PTNsoMWbDRDvwqxE8zyMFGx2b17ygGgwi8cRE=;
        b=hmgDTS6Yvh3+JAHehdy+6qYgYn6ESBaoQ1wuWTbcXIhWNDt2tXM+vAok0QX0uwC9UI
         rCxkF7wOYl/FI4cqMOUK0phlBxFgCIv+THvGbsiy68st6crTOxPZA7xdBbygqzPiCVvg
         Sx09EJZYONwkH8BQXA/QZFg61oieBFWYvM8uvKf8OQoQb1SkL3eYQTWF9umOJ5sYlfPL
         oeYn2ofZHrLk07SiCM/eZ6KfDrQMbB7NJE5JpX/biWB9tmjsr8QhQ9fpgbTyWEDJOLna
         VAAxVK8K3/plNpN41lHujlIb9Y6P7tdRrAxUaNyP2kDzpIwgn6cMkuX6muJ9b00g9zvk
         jWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720339940; x=1720944740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFpie4PTNsoMWbDRDvwqxE8zyMFGx2b17ygGgwi8cRE=;
        b=XUD+CuMOlkc1xh84dZONJTnIKv2jAToDEQOqPOrNvZd0sEZ2YVxx7bcM+a0U7Sf7mv
         x1589Sal4wN23E9p6yj5q7ipwuAytUk2v8jJqlYfiqAkJM32yL3Nh5h2RNiKxT5J+Wr/
         eSE7h/57nvSO2FeA9pa0vD+l6UcS4km11WN7AahzyDVHIzoFuxbL9w+VBWko/viTeQlx
         WHeF+1mToFMWps5xPmA24vx4YNPvQasQXxDCna5U9KE7vypPxS/3GCANj+me43MU3BR9
         PglLE3Jmnnmhm/c0EhOJgRU8jg9kfhTvZvinVvFkLNSvM0rLS++bXtN3N72ym2TzPx+2
         IubQ==
X-Forwarded-Encrypted: i=1; AJvYcCV93RkrdKdhLA61S8LiNdcn9GplV8gGFhO1eX48epClOeV83gCF6z7MPCA5J4vnuHwwixLo8vCHrfY1NsN9KYgzQSoWF3Bal0XzdMU8
X-Gm-Message-State: AOJu0Yzrgu4FckwXMXaWhC01qE6AEpUBJR3jUeUC1gAGlrkfMS4mnTAC
	hvV+wLyvhtZdihanUPY1mBAlDbN2bJoaFJitjVL24y44MBLfYjcMgpAyDzD9uGsXhZpb23SbTbB
	iizCM9erORMA1gRzYSFTjMqfPxIg=
X-Google-Smtp-Source: AGHT+IFY+L7sQOal4yf8wQbrG6IrzX1JOhyjrhHWxI/zVy0m7b5kst5TDs2RFEk+QYiIqaMDsAtImgmTAuC96RJpsqA=
X-Received: by 2002:a05:6358:5929:b0:1aa:b7d7:2227 with SMTP id
 e5c5f4694b2df-1aab7d72faemr262383355d.6.1720339939758; Sun, 07 Jul 2024
 01:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <47e0483d-6e3d-43a8-9273-25278a4a74b9@gmail.com> <0c095098-4b3e-481b-b866-29cacb9f165d@milecki.pl>
In-Reply-To: <0c095098-4b3e-481b-b866-29cacb9f165d@milecki.pl>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sun, 7 Jul 2024 10:12:08 +0200
Message-ID: <CAOiHx=nmcf1mRy_i9vUDNtqOZTQ=PFWY8MGEV1FZfgt=GHqj5A@mail.gmail.com>
Subject: Re: [PROBLEM linux-next]
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: Mirsad Todorovac <mtodorovac69@gmail.com>, linux-mtd@lists.infradead.org, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Jul 2024 at 09:38, Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl> wro=
te:
>
> Some more descriptive subject would be nice :)
>
>
> On 7.07.2024 02:10, Mirsad Todorovac wrote:
> > In file included from ./include/asm-generic/bug.h:22,
> >                   from ./arch/x86/include/asm/bug.h:87,
> >                   from ./include/linux/bug.h:5,
> >                   from ./include/linux/fortify-string.h:6,
> >                   from ./include/linux/string.h:374,
> >                   from ./arch/x86/include/asm/page_32.h:18,
> >                   from ./arch/x86/include/asm/page.h:14,
> >                   from ./arch/x86/include/asm/processor.h:20,
> >                   from ./arch/x86/include/asm/timex.h:5,
> >                   from ./include/linux/timex.h:67,
> >                   from ./include/linux/time32.h:13,
> >                   from ./include/linux/time.h:60,
> >                   from ./include/linux/stat.h:19,
> >                   from ./include/linux/module.h:13,
> >                   from drivers/mtd/mtdpart.c:10:
> > drivers/mtd/mtdpart.c: In function =E2=80=98parse_mtd_partitions=E2=80=
=99:
> > drivers/mtd/mtdpart.c:693:34: error: =E2=80=98%s=E2=80=99 directive arg=
ument is null [-Werror=3Dformat-overflow=3D]
> >    693 |                         pr_debug("%s: got parser %s\n", master=
->name,
> >        |                                  ^~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/printk.h:376:21: note: in definition of macro =E2=80=98=
pr_fmt=E2=80=99
> >    376 | #define pr_fmt(fmt) fmt
> >        |                     ^~~
> > ./include/linux/dynamic_debug.h:248:9: note: in expansion of macro =E2=
=80=98__dynamic_func_call_cls=E2=80=99
> >    248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt,=
 func, ##__VA_ARGS__)
> >        |         ^~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/dynamic_debug.h:250:9: note: in expansion of macro =E2=
=80=98_dynamic_func_call_cls=E2=80=99
> >    250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func,=
 ##__VA_ARGS__)
> >        |         ^~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/dynamic_debug.h:269:9: note: in expansion of macro =E2=
=80=98_dynamic_func_call=E2=80=99
> >    269 |         _dynamic_func_call(fmt, __dynamic_pr_debug,           =
  \
> >        |         ^~~~~~~~~~~~~~~~~~
> > ./include/linux/printk.h:610:9: note: in expansion of macro =E2=80=98dy=
namic_pr_debug=E2=80=99
> >    610 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
> >        |         ^~~~~~~~~~~~~~~~
> > drivers/mtd/mtdpart.c:693:25: note: in expansion of macro =E2=80=98pr_d=
ebug=E2=80=99
> >    693 |                         pr_debug("%s: got parser %s\n", master=
->name,
> >        |                         ^~~~~~~~
> > drivers/mtd/mtdpart.c:693:50: note: format string is defined here
> >    693 |                         pr_debug("%s: got parser %s\n", master=
->name,
> >        |                                                  ^~
> >
> > Offending commit is 5b644aa012f67.
>
> Actually it goes back to 2015 to the commit 8e2c992b59fc ("mtd: mtdpart: =
add debug prints to partition parser.").
>
>
> > Proposed non-intrusive fix resolves the warning/error, but I could not =
test the code.
> > (I don't have the physical device.)
> >
> > -----------------><------------------------------------------
> > diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
> > index 6811a714349d..81665d67ed2d 100644
> > --- a/drivers/mtd/mtdpart.c
> > +++ b/drivers/mtd/mtdpart.c
> > @@ -691,7 +691,7 @@ int parse_mtd_partitions(struct mtd_info *master, c=
onst char *const *types,
> >                          if (!parser && !request_module("%s", *types))
> >                                  parser =3D mtd_part_parser_get(*types)=
;
> >                          pr_debug("%s: got parser %s\n", master->name,
> > -                               parser ? parser->name : NULL);
> > +                               parser ? parser->name : "(null"));
> >                          if (!parser)
> >                                  continue;
> >                          ret =3D mtd_part_do_parse(parser, master, &ppa=
rts, data);
> >
> >
> > Hope this helps.
>
> I'd say it's simple enough to send patch without actual hw testing.

Though the kernel's vsprintf will already handle NULL pointers and
print "(null)" [1], so I'm not sure if this is an actual improvement.

The only way this can be NULL though is if the request_module()
failed, so maybe a proper error message would be better here instead
of an obscure "got parser (null)". You don't even know which type
wasn't available. E.g. pr_debug("%: no parser for type %s
available\n", master->name, *types).

[1] https://elixir.bootlin.com/linux/latest/source/lib/vsprintf.c#L696

Best Regards,
Jonas

