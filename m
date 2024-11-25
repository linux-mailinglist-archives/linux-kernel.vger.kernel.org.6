Return-Path: <linux-kernel+bounces-421526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 948BA9D8C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317A8B2A86C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE681B87FB;
	Mon, 25 Nov 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXWQXGW9"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C6A1B85D0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560502; cv=none; b=SH6+1s0e6e7tJKbemQdKkRdR9T47Y7iqKMRhuU8pTf1ng7+k0gLG9BdQPB1qUdlohO/ZYwTUPmz2lARzka26vcoxX+zuIGfkX1MSo+gyC7+1DNp+gfqLTdbSAFlwyrLFFjfPd93yacLB19wql6l/cvB8UlFahUdaFEmWbK2zlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560502; c=relaxed/simple;
	bh=o0LAhU0U8nC7QUJI8ywMMY9AbpnQ1yZpDdqBR+ACi7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDYzWvmbZgS7wK6LTA0R893ugMsuR3jqHiszm0quc3CDQCS79gEmJh0g2TbzmwR0ww/pYU2gj5vrdlqxgamyXp1F7WKXg9p9zG/u/3AaeYwP6AUhfmo+T510I7eJMFEm85Zj0xQZlV5+ayGsNmmJFSi4eCBm1QYgy0AsUsysLPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iXWQXGW9; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4635b03a3cdso10011cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732560499; x=1733165299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1R1Jcugf3q9SkQGyzKFZdgHWnoNvKou2YarOZUBQQ4=;
        b=iXWQXGW94cGp3bY98cOfAg1duHSCJ2ZNvNYxrvWlLt+0ZcVvCGOZnQ5XSK0CWcVi83
         d6apfWGzr2grjxbKZKzlyhQlIm4VaSzirepx3rO6VXGaQ6x0+cqapSrSXtJdaixw5Xvu
         THxvez4zL+2VebaRtqskXxYnSxGFUAQBU/hMMtttX+lqEcQtieq6JYMeB5yQn4LSeKoR
         eioDVWBIMuEI4uky5EHBF7coDIIS5LpKDG+tACs8Zo2QFI/p5tY0Grc6pZCGuF9MP4V+
         9RIc965RnOgRWdY5g6YO50O2ZRzg1GLSw0G/ElZOcSV+z3Yb9cmZPJql/bcfksmOarJG
         ZX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732560499; x=1733165299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1R1Jcugf3q9SkQGyzKFZdgHWnoNvKou2YarOZUBQQ4=;
        b=rVMiD9S/a3RC0c+uUvH5t0DR92jOV1QcFW0lsH9YDgCyFENCJEgF590SGFx7zArk9O
         I71fkvh9vOP7iibS2neuTXX0Ij2UGYxJqOJIa7E4MHfewkPQT4b/YCgr+JbFzoSfKQYN
         MVawSr329u/HeWZZXi3fJ9eZ7L6A7Je2fVsVSgi58rTuHSdVxvUSCgmUbM9G/XXW/19M
         g1y4VDKKYzZlonSAOtItaWFaJ3zySlJvvkmbPYDRx1zndG3TTmg7TlSW/A+HHFlVpTRV
         TCfaXWc7Mb7huPADLxSqhiEmBrR6mU9v6QPybK+3hQfIdj3mEoQdD+f2NTEDrSjrKJGC
         RUEg==
X-Forwarded-Encrypted: i=1; AJvYcCV2h1YRj/8JLcyQOaQPbWm4bIk2wclCAQI2D0f1we6/JYnv99I2fojm+t8xONyj+5cyT+rXLpYXME0SIts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyCRnLp6Wzx65gBjez+KFl6yTsALU4Ujlkw6eIIAYLKKgTbeDR
	dk8HXsxNjBCMIHTs6h/kQy+peywuC1C50r9wiWCClUVLEIYoRWVeigSJI844mKFjXaETW596DLj
	WSZ5J7sq7hqYNxU+l61OKOL9w3bV+hazPGESp
X-Gm-Gg: ASbGncvZGvW5AejKemXdztizwkZbh6QUHY6YDEoi6dvz+9P38+tgyw5n+m8HcKqqZP2
	WnSnYrLEXUrKc4DWvNn/Kym/1kvwdGVzIrRmrzljgZyCujVzXKiz1O8XrG9fCJA==
X-Google-Smtp-Source: AGHT+IGFWABXotexkrSzRTJC/p+T5eM5vBKUtT0VyVorJwkIzAja1G3XupgLC8Y99gEa5OaGBRY9emDlxg0EYIMOXcQ=
X-Received: by 2002:a05:622a:5b86:b0:466:923f:a749 with SMTP id
 d75a77b69052e-466923fa7aamr3443181cf.15.1732560499024; Mon, 25 Nov 2024
 10:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd252b78-077b-441e-8371-106d71258ff3@alliedtelesis.co.nz>
 <84d9200e-25b4-4bd8-8eb5-c954ff92ac08@alliedtelesis.co.nz>
 <CAF1bQ=RU2dZU3ENy3MLM4FvrZNaZprgPAM5vbRtUVDixJNQ_zg@mail.gmail.com> <c6719149-8531-4174-824e-a3caf4bc6d0e@alliedtelesis.co.nz>
In-Reply-To: <c6719149-8531-4174-824e-a3caf4bc6d0e@alliedtelesis.co.nz>
From: Rong Xu <xur@google.com>
Date: Mon, 25 Nov 2024 10:48:07 -0800
Message-ID: <CAF1bQ=QEL3XZYsNL-f7jmbDOVWHSVfhZSYx0iddct3nz8_Yf1A@mail.gmail.com>
Subject: Re: RTL9300 (mips) fails to boot with commit d4a7f2510ff4
 ("vmlinux.lds.h: Adjust symbol ordering in text output section")
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "Han Yao Yeo (atg)" <hanyao.yeo@alliedtelesis.com.sg>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Masahiro Gotoh <gotoh@allied-telesis.co.jp>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for confirming this! It looks like we do need to put all
symbols from head.o before any other symbols.
To be clear, the patch I mentioned was not trying to do that -- it
just makes sure the _stext is in the right places.

I'll draft a patch for this.

On Sun, Nov 24, 2024 at 12:40=E2=80=AFPM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
>
> Hi Rong,
>
> On 22/11/24 18:02, Rong Xu wrote:
> > Does the following patch fix your issue?
> > https://lore.kernel.org/lkml/CAK7LNAQSpM2hh2=3DWgribb92nHF5_peRb+gxdO1B=
t1MkeL8N+hw@mail.gmail.com/t/
> >
> > Masahiro Yamada already applied the patch to kbuild-tree.
> >
> > I also proposed a similar fix as yours. But we believe the above patch
> > should also work (and probably is better).
> >
> > Please try and let us know.
>
> Looks like linux-next already has that patch and no it doesn't fix my
> issue. For the record here's the start of my System.map
>
> $ head System.map
> ffffffff80100000 T __split_text_end
> ffffffff80100000 T __split_text_start
> ffffffff80100000 T __unlikely_text_start
> ffffffff80100000 T _stext
> ffffffff80100000 T _text
> ffffffff80100000 t run_init_process
> ffffffff80100138 t try_to_run_init_process
> ffffffff8010018c t put_page
> ffffffff801001d0 t nr_blocks.isra.0
> ffffffff80100208 T ack_bad_irq
>
> It does look like whatever is supposed to put head.o first isn't kicking
> in for me.
>
> >
> > Thanks!
> >
> > -Rong
> >
> > On Thu, Nov 21, 2024 at 6:29=E2=80=AFPM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:
> >>
> >> On 22/11/24 14:58, Chris Packham wrote:
> >>> Hi Rong,
> >>>
> >>> I was just trying some of my in-flight changes against linux-next and
> >>> found that my RTL9300* based board no longer boots (nothing on the
> >>> serial console after U-Boot hands off to the kernel).
> >>>
> >>> A bisect between Linus's tree and linux-next/master points to commit
> >>> d4a7f2510ff4 ("vmlinux.lds.h: Adjust symbol ordering in text output
> >>> section"). A build on d4a7f2510ff4^ boots successfully. That series i=
s
> >>> well beyond my area of knowledge, there may be something that the MIP=
S
> >>> SoCs are doing (or not doing) that is being affected by the sections
> >>> moving.
> >> Based on the sparc change that accompanied this commit the following
> >> does seem to restore working order for me:
> >>
> >> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux=
.lds.S
> >> index d575f945d422..e90b0f68290c 100644
> >> --- a/arch/mips/kernel/vmlinux.lds.S
> >> +++ b/arch/mips/kernel/vmlinux.lds.S
> >> @@ -62,6 +62,8 @@ SECTIONS
> >>           _text =3D .;      /* Text and read-only data */
> >>           _stext =3D .;
> >>           .text : {
> >> +               /* Match text section symbols in head.S first */
> >> +               *head.o(.text)
> >>                   TEXT_TEXT
> >>                   SCHED_TEXT
> >>                   LOCK_TEXT
> >>
> >> No idea if that's appropriate
> >>

