Return-Path: <linux-kernel+bounces-421716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263509D8EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 00:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87DD289A92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2178F194AE2;
	Mon, 25 Nov 2024 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0quqGKh7"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E6C1CD2C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 23:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732576874; cv=none; b=t9CdCgfYJX/KEmB3tx9xPXHPtDULcXgllddH9WeIIxIb0lKTFXkrLqwTx/1sgaNvob+h0ZVSmsfLAdhsak8jut48M4I/8VKBfe3DIw4A4k2F7aXouq7eXX9l0R5i8N387h3Bxs72fuooSkqdQKwLyVYSGhBpHu1hgMLAqGCs9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732576874; c=relaxed/simple;
	bh=JDO63Vt2zUeewcO0avIggf7SJKJ8NVtQjIKTIhFu9pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rw8ox39WgSYIFc/0ss5+xvDzAuquTwmtJoCBZ5puQ0aF2J+bOQbb1guDwbA19rmMfLmCs3q2roI4aXBv9cSUY0kzxRruwACrxOdZhEfoBD4W2nGmwI3n6+y4ru9HYo83ghcyTiMbkdESYN03NEeIARUFVT230daIrKTmZI6uMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0quqGKh7; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4635b03a3cdso26611cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732576871; x=1733181671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knlwvECQqDVjMzgrFvwnm3om8IEysGDo7JBjjkbDRnY=;
        b=0quqGKh7xTk6/vDEl6MWKd7vM6FkCoMwjcQpKs2DisuHuDyObMOfrKBcsv1wsOgABp
         onOrKmZ100dlfsU+cGMTxCuSvOsrNlvpkw4D8cKDi0YcOmMW3n7LXdK9Sz7LFqQmjcuL
         VI60Jz4cizyNlc9HGETAOGcwD98bbenStp9B+/qoQ5hGPzooKp76L7CFBQENYBz47L59
         vl2ShFCESBjAvcnC/Ze14g79Gawf5AHpmNPjAUHtE/Pjy/Khzf2XvmeJwfR6p2LyDbHU
         QWfOJLi4i9RkRCAbFk6bfkRl4ZnzMr1FITTiHJE4R+vc7bDRLVp4HJwkjqPLP64kXvx4
         mGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732576871; x=1733181671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knlwvECQqDVjMzgrFvwnm3om8IEysGDo7JBjjkbDRnY=;
        b=mdxLkDhTxac00beRHsyja7BPrc21pbF7k6q5fA6jXE3XH8mB3lgI/2baVDmPOARMN8
         XnNW8lBOIXw/PSCDcjI1IIjpVPtFDa746Hw+mL30wlHlo1SC92evrBlr4yt9O6rNbkWz
         +rGZD4dHBlXKBai6t1EnrMNo6j8g6Y3IoympuKg4SCYPYzX/zYzF+n9cMV6i68YfC0u+
         dB66ODTvV/kKxuHo1TeXoL+ZGBYbOxKEUQhna7znIDeCC1wbLbXwFA8xLoDoSbFa8llu
         21YydQSryFn0yuPWYTOw7PaklBNxFXoA8dhra4srUvU310Zbh6/K9VWVdQ6hUJejedFs
         p/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWDp3YOs2Tr06pMvIdSfElKnYEez0tWdAi/MOgiQCis7c3TpTOu+dC/YWw2we/y+iuCJqXuvpS8pjS+Ss4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Nn9Zh3rrrq0XGbxjhJRLjobuP2aYipsfS5HOoi3gjrEuu4Sq
	98lciZgZPQpjtO7PnmuXsHVFIBuwc41TX0x8FasNw7Tg/eUGpWmGmZ39Uu8WKKZxlycAsR0IWgr
	rdaHvf73zkaontyT5SjSw9nb2GSPkqqTuPM20
X-Gm-Gg: ASbGncs3zye8r/33cymHftbPQTW5jTcBxM3X996gv5ZFol+hB7FfmBZeYYc7AH6I7u8
	e/NlB1/6Z45bRifCUEu+3lFif9X0V3PDj2iDijL5M2jpMjJnkoKJZAxPIMwdGFA==
X-Google-Smtp-Source: AGHT+IHmSxd94r8C7grBqTd45WeWFajX9adxDqBqnVOa3dcxOvJmZFZJ3CQZajOpLqwQSbgtFelKCyDRCSSUaXjoOjI=
X-Received: by 2002:a05:622a:5104:b0:45f:89c:e55 with SMTP id
 d75a77b69052e-466a4849250mr1267711cf.8.1732576871409; Mon, 25 Nov 2024
 15:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd252b78-077b-441e-8371-106d71258ff3@alliedtelesis.co.nz>
 <84d9200e-25b4-4bd8-8eb5-c954ff92ac08@alliedtelesis.co.nz>
 <CAF1bQ=RU2dZU3ENy3MLM4FvrZNaZprgPAM5vbRtUVDixJNQ_zg@mail.gmail.com>
 <c6719149-8531-4174-824e-a3caf4bc6d0e@alliedtelesis.co.nz>
 <CAF1bQ=QEL3XZYsNL-f7jmbDOVWHSVfhZSYx0iddct3nz8_Yf1A@mail.gmail.com> <5eeb60df-e966-47ae-a381-bc7496d4fa8f@alliedtelesis.co.nz>
In-Reply-To: <5eeb60df-e966-47ae-a381-bc7496d4fa8f@alliedtelesis.co.nz>
From: Rong Xu <xur@google.com>
Date: Mon, 25 Nov 2024 15:20:59 -0800
Message-ID: <CAF1bQ=TK_ip7WPXn910NGDW0PZcNFd9a_jbY=4h=6FHpH7C4fg@mail.gmail.com>
Subject: Re: RTL9300 (mips) fails to boot with commit d4a7f2510ff4
 ("vmlinux.lds.h: Adjust symbol ordering in text output section")
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: "Han Yao Yeo (atg)" <hanyao.yeo@alliedtelesis.com.sg>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Masahiro Gotoh <gotoh@allied-telesis.co.jp>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I sent out a patch using the __HEAD method. Compared to the
"*head.o(.text)", this only places
__kernel_entry at the beginning of the text section, and leaves others
reordered by the linker script.
I think it should work. Chris: Could you test it?

Thanks,

-Rong


On Mon, Nov 25, 2024 at 11:26=E2=80=AFAM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
>
> On 26/11/24 07:48, Rong Xu wrote:
> > Thanks for confirming this! It looks like we do need to put all
> > symbols from head.o before any other symbols.
> > To be clear, the patch I mentioned was not trying to do that -- it
> > just makes sure the _stext is in the right places.
> Looking at other architectures it may just be a matter of adding __HEAD
> to an appropriate place in arch/mips/kernel/head.S and HEAD_TEXT_SECTION
> to arch/mips/kernel/vmlinux.lds.S. It might even be possible to drop
> mips from scripts/head-object-list.txt.
>
> > I'll draft a patch for this.
>
> I can give any patch a quick test on my setup.
>
> >
> > On Sun, Nov 24, 2024 at 12:40=E2=80=AFPM Chris Packham
> > <Chris.Packham@alliedtelesis.co.nz> wrote:
> >> Hi Rong,
> >>
> >> On 22/11/24 18:02, Rong Xu wrote:
> >>> Does the following patch fix your issue?
> >>> https://lore.kernel.org/lkml/CAK7LNAQSpM2hh2=3DWgribb92nHF5_peRb+gxdO=
1Bt1MkeL8N+hw@mail.gmail.com/t/
> >>>
> >>> Masahiro Yamada already applied the patch to kbuild-tree.
> >>>
> >>> I also proposed a similar fix as yours. But we believe the above patc=
h
> >>> should also work (and probably is better).
> >>>
> >>> Please try and let us know.
> >> Looks like linux-next already has that patch and no it doesn't fix my
> >> issue. For the record here's the start of my System.map
> >>
> >> $ head System.map
> >> ffffffff80100000 T __split_text_end
> >> ffffffff80100000 T __split_text_start
> >> ffffffff80100000 T __unlikely_text_start
> >> ffffffff80100000 T _stext
> >> ffffffff80100000 T _text
> >> ffffffff80100000 t run_init_process
> >> ffffffff80100138 t try_to_run_init_process
> >> ffffffff8010018c t put_page
> >> ffffffff801001d0 t nr_blocks.isra.0
> >> ffffffff80100208 T ack_bad_irq
> >>
> >> It does look like whatever is supposed to put head.o first isn't kicki=
ng
> >> in for me.
> >>
> >>> Thanks!
> >>>
> >>> -Rong
> >>>
> >>> On Thu, Nov 21, 2024 at 6:29=E2=80=AFPM Chris Packham
> >>> <chris.packham@alliedtelesis.co.nz> wrote:
> >>>> On 22/11/24 14:58, Chris Packham wrote:
> >>>>> Hi Rong,
> >>>>>
> >>>>> I was just trying some of my in-flight changes against linux-next a=
nd
> >>>>> found that my RTL9300* based board no longer boots (nothing on the
> >>>>> serial console after U-Boot hands off to the kernel).
> >>>>>
> >>>>> A bisect between Linus's tree and linux-next/master points to commi=
t
> >>>>> d4a7f2510ff4 ("vmlinux.lds.h: Adjust symbol ordering in text output
> >>>>> section"). A build on d4a7f2510ff4^ boots successfully. That series=
 is
> >>>>> well beyond my area of knowledge, there may be something that the M=
IPS
> >>>>> SoCs are doing (or not doing) that is being affected by the section=
s
> >>>>> moving.
> >>>> Based on the sparc change that accompanied this commit the following
> >>>> does seem to restore working order for me:
> >>>>
> >>>> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlin=
ux.lds.S
> >>>> index d575f945d422..e90b0f68290c 100644
> >>>> --- a/arch/mips/kernel/vmlinux.lds.S
> >>>> +++ b/arch/mips/kernel/vmlinux.lds.S
> >>>> @@ -62,6 +62,8 @@ SECTIONS
> >>>>            _text =3D .;      /* Text and read-only data */
> >>>>            _stext =3D .;
> >>>>            .text : {
> >>>> +               /* Match text section symbols in head.S first */
> >>>> +               *head.o(.text)
> >>>>                    TEXT_TEXT
> >>>>                    SCHED_TEXT
> >>>>                    LOCK_TEXT
> >>>>
> >>>> No idea if that's appropriate
> >>>>

