Return-Path: <linux-kernel+bounces-294347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03328958C71
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C80FB2318A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584291C6894;
	Tue, 20 Aug 2024 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrbWAU4M"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB61C689F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171942; cv=none; b=enybFfcCG2dqPwDXVchZSozg0gRd2XMgWyh0ExfBmFUvrpA6bzwJoSdjG50b5FSZHuOl1twixyoAFLn15D7byXPsQe8tRtq7+9mYslAg0sbos3s4/wYeu8Njib4ppLoVYwPwJ9d72Tjf2IW5k38aifLDRYTC9hhIJSi/jyTNjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171942; c=relaxed/simple;
	bh=ouBZJmIIWyzlEwtcA7FRf12ZdCEGayS+qwQL4CI9gs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fp5YW0/kmSBL4h/ewXzq9gqm0XvZj4smdqFlEYDYHd7FYztUMKC+z4TnW2j1t+C4kJnWtXPc2Ra4nSKZ+6CbPE2rA6gB+PoajRgTM93Dz95H/4QUpJt5o/AC7RJIx+HqOn3xHobWxKErX5xB7gwPzQ5Uifa9aWcvcw35a8MiE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrbWAU4M; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso765655266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724171939; x=1724776739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRCmyfsJfipKUStIwzuNn3CaXC7WIGQGA1adF+b+w+M=;
        b=UrbWAU4MQEg1x6ngr/WhKxgplfGEehkOcZ7ExZUJMxYZMA1FKnujcC6R+HPQJ6iPIY
         20kFFBmr4PaWsSpJcmsEWSf91tcEttaFbQQObEHJzGaWL5DVx7I2VZE/GXN8s8pRMYSm
         OnPK3wM/aE3j2dN9vyue2vjbJi1OUI1KYeDY1GigPKn8DbD8/Kr4/ek2lRb17nE0PZsS
         5ixZRuwiZ3uvMgj1fuDftb0cEtkH8oSOWlCFGPlRdcBC55lzN2E5AEkBXlwwt3T1ZQMV
         5Ew3y22IUhYqclA5iVvcMrFAd+cwhi5VrT1izPGB6JMtmnNYq5ny2ZU5nbARoQcbYost
         /xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171939; x=1724776739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRCmyfsJfipKUStIwzuNn3CaXC7WIGQGA1adF+b+w+M=;
        b=HEC7unblZMXc61NByj/7dOv3lTq3+gdugU0Ws7wS4FF0GXE1ibygzzTp6Rgu4byO7O
         O3R+ygzFz5O9o7KA8IDiL2CpV2fUlji9Aji0BOz6Zi/Sh3NVRvto8doPQb8WNxoW9K9a
         Rfe1pR5H1kKo5fEjOwGdrJAYxr8DnompHe00zkxvpDrcghSwvY/NwXKaIRcQYPJhofPh
         nqs1lR/FpShMzuEkWxh5w+FArOaGQqfqYWaW5Z16vkQfBoOYkIEOdOBZGRjiMYUESj1s
         hN5G+30QOu5THwk5Npa6MNaXbb9UknLTPj04I1XsBNJLb9EnzwSp8D/x/U+15Swq0zmI
         /okw==
X-Forwarded-Encrypted: i=1; AJvYcCVsx8uOVxhiiVliqv/p90lOnPDel/n/QrjSqralR0aTSTbWfa+3lEmkCV4zfHcE2G8GHhYP7tXIbYEhIw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2op675DTqM2m6exsuxf8Ek+ZwabxgKRqfEZrbsWFAgE54muXw
	tU5n3oGV3ckqpjbAsv9U1LLxgkp/F5xF6oMVMh29fv3taPhudzXVNld0tJqp2yoZb6onnXK4FsD
	dtrE20DA8TmPnS8PVQpedoS0fiCg=
X-Google-Smtp-Source: AGHT+IHG6w3sYGVsmqVqAoCdN4BiLWHhRRQ1j4Bw53D98oHKDQDeISbUZ0mC0nNznh5RdHU7dDR10H3G/Uaj4F6Pk+U=
X-Received: by 2002:a17:906:d7d2:b0:a7a:97a9:ba23 with SMTP id
 a640c23a62f3a-a839292f2afmr1045838966b.22.1724171938714; Tue, 20 Aug 2024
 09:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812230121.2658059-1-cmllamas@google.com> <20240816125046.GA24389@willie-the-truck>
In-Reply-To: <20240816125046.GA24389@willie-the-truck>
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Date: Tue, 20 Aug 2024 09:38:46 -0700
Message-ID: <CAOZ5it0ih05MBMzQxKuD8LYTL-by5qppjj_YXqA6iuyikm0_6w@mail.gmail.com>
Subject: Re: [PATCH] Revert "scripts/faddr2line: Check only two symbols when
 calculating symbol size"
To: Will Deacon <will@kernel.org>
Cc: Carlos Llamas <cmllamas@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 5:50=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Aug 12, 2024 at 11:01:20PM +0000, Carlos Llamas wrote:
> > This reverts commit c02904f05ff805d6c0631634d5751ebd338f75ec.
> >
> > Such commit assumed that only two symbols are relevant for the symbol
> > size calculation. However, this can lead to an incorrect symbol size
> > calculation when there are mapping symbols emitted by readelf.
> >
> > For instance, when feeding 'update_irq_load_avg+0x1c/0x1c4', faddr2line
> > might need to processes the following readelf lines:
> >
> >  784284: ffffffc0081cca30   428 FUNC    GLOBAL DEFAULT     2 update_irq=
_load_avg
> >   87319: ffffffc0081ccb0c     0 NOTYPE  LOCAL  DEFAULT     2 $x.62522
> >   87321: ffffffc0081ccbdc     0 NOTYPE  LOCAL  DEFAULT     2 $x.62524
> >   87323: ffffffc0081ccbe0     0 NOTYPE  LOCAL  DEFAULT     2 $x.62526
> >   87325: ffffffc0081ccbe4     0 NOTYPE  LOCAL  DEFAULT     2 $x.62528
> >   87327: ffffffc0081ccbe8     0 NOTYPE  LOCAL  DEFAULT     2 $x.62530
> >   87329: ffffffc0081ccbec     0 NOTYPE  LOCAL  DEFAULT     2 $x.62532
> >   87331: ffffffc0081ccbf0     0 NOTYPE  LOCAL  DEFAULT     2 $x.62534
> >   87332: ffffffc0081ccbf4     0 NOTYPE  LOCAL  DEFAULT     2 $x.62535
> >  783403: ffffffc0081ccbf4   424 FUNC    GLOBAL DEFAULT     2 sched_pelt=
_multiplier
> >
> > The symbol size of 'update_irq_load_avg' should be calculated with the
> > address of 'sched_pelt_multiplier', after skipping the mapping symbols
> > seen in between. However, the offending commit cuts the list short and
> > faddr2line incorrectly assumes 'update_irq_load_avg' is the last symbol
> > in the section, resulting in:
> >
> >   $ scripts/faddr2line vmlinux update_irq_load_avg+0x1c/0x1c4
> >   skipping update_irq_load_avg address at 0xffffffc0081cca4c due to siz=
e mismatch (0x1c4 !=3D 0x3ff9a59988)
> >   no match for update_irq_load_avg+0x1c/0x1c4
> >
> > After reverting the commit the issue is resolved:
> >
> >   $ scripts/faddr2line vmlinux update_irq_load_avg+0x1c/0x1c4
> >   update_irq_load_avg+0x1c/0x1c4:
> >   cpu_of at kernel/sched/sched.h:1109
> >   (inlined by) update_irq_load_avg at kernel/sched/pelt.c:481
> >
> > Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  scripts/faddr2line | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Acked-by: Will Deacon <will@kernel.org>
>
> I'm assuming that Josh will pick this up.
>
> Cheers,
>
> Will

Acked-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>

Good catch. Thanks for the fix.

Just curious: What compiler did you use to build the kernel, where you
hit this error with 'update_irq_load_avg'? I was unable to reproduce
it with LLVM 14. Thanks!

-Brian


-Brian

