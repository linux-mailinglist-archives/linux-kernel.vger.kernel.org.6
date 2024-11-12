Return-Path: <linux-kernel+bounces-406275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02399C5CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9141928450A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107D12040AA;
	Tue, 12 Nov 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ME4LXGhI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9720401E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427398; cv=none; b=LBcZnRHsTR0Q5eFWnIXgWwXT6+t1EtWcQkMuUy3NT3Rry65aCJ7F+2c6px4jjvj583vF1jWpaqVEWO5mew6ZR4GtfSt7Kb0TK9SrZOmt72AHTd1m6A5G0Jb8Zis9AtGdUKRj0luQyo8uJcpN/bzA0TXyobK3lfPuSmSkbjQb+3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427398; c=relaxed/simple;
	bh=diQxAT+E5lOTi+/dgq2Ao1VMNrV6gxJsBPnA38LAlmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utCSfDmjs6pXLWU7Lfg8TAEeq6rEuSY56E5xphPaMH71ySmW+CXgvKdVyCF9fqYV8q7NlODi+EWsAQKSDv5Mo8rMhB07yfUnrQnko3qgzBThOw5wXO5wwNDAT8ax4sPUn4rntac/kqm1R8wAhyg4t1qFgs0bb6+3x/lvANipvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ME4LXGhI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731427395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGjpopU//5Z3ijsaSdLB1L4ysYnNj5d6t1WIT5/TMSI=;
	b=ME4LXGhISvfQeratkAwqLkGO8suqycqHncwzPYfN787I8pv5KUfM2qXkNGNbuEzD9te8sF
	VHTwsrFS69seG3zIUL2liEn47rKswhU+nh1jBbT1GrGdvrG/S7m8wt6jnzz7J+5yP6KIgt
	XCWGno+thzfUelglfKdbEI5YDWJ3oD0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-cGnkejyrMsWUACW1k7gFcA-1; Tue, 12 Nov 2024 11:03:13 -0500
X-MC-Unique: cGnkejyrMsWUACW1k7gFcA-1
X-Mimecast-MFC-AGG-ID: cGnkejyrMsWUACW1k7gFcA
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3e65ee7154bso133371b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427393; x=1732032193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGjpopU//5Z3ijsaSdLB1L4ysYnNj5d6t1WIT5/TMSI=;
        b=lK9UAVKC0+Qj9tpbv+6mw16p9Wjma5SeLsvdr7w/97pIQ5/5KhwZIqXHx4ATwnLbTZ
         HVDLMu2ciAcndQVF2KRj1762fx2eLQ2AFz7wPj1QdthnxeK3nYudwV7EFlPtmhmZ/Wji
         94WWzPat1oENcbHM4ghwQLXtfsMfxw7MLqoHfN64FDc6nBX4Kaw1qVgWRuWJfLhAtCuK
         vhpSSewSPQr5+YU4Z9ScWfXDnaC/WnxRV6BFnNgsRmnE+VA2XqbMjY/mRYLnr7wA78E1
         ZrQfmScLo1OMNrfbLN2mNMTR1xiukflTXO5k3hULUn28IsvRJKr+0eh3nn/fLKaHZThz
         mytA==
X-Forwarded-Encrypted: i=1; AJvYcCUOPDVX+M1WAIQULTvY5NEc0pQUaGbGXrt7sYK8lNiQDGOg6KMKPlJ50/4jjG1fQqgtUPeEDiUx/HqPQPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWM72kRZiMKI1bCIg13144BlH7ljBOCSP1FMqUuW0Jac4qX6T
	2pOdp5GthnaZ5/2y1Bo1cB1u24IY62QzkF2tfmdRwIwEYVvqOb+LpLGxOx36/KgiDz2u6wSvyO1
	BSizNX/zYpRQT2o7h52oaOmuPTkL6gu1LD3JrxoTtiIFC55A3qr4F962HZLsLa0SjQFBSe0X7uh
	+vIOYx9PFnqI/AWA08830eDaLbfcDYYF5aNW/I
X-Received: by 2002:a05:6870:9d18:b0:291:cb6:f3cd with SMTP id 586e51a60fabf-295600f04b3mr3378954fac.8.1731427392799;
        Tue, 12 Nov 2024 08:03:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6K30AckXB3aEumZtFVfs7n1j8qvpk6yUxT6SWtcwB5Q41cmA94cAVxxZej7fXm079vvCRy6HcYFAc5PeZ48s=
X-Received: by 2002:a05:6870:9d18:b0:291:cb6:f3cd with SMTP id
 586e51a60fabf-295600f04b3mr3378934fac.8.1731427392148; Tue, 12 Nov 2024
 08:03:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE0LRvJ-n77oU=O9__NdSLw2v33zMK+WYkn2LcwWMwHCbohQw@mail.gmail.com>
 <CAC_iWjJEXU+dodjvWQYM9ohPa3P2p0bFG=exGoi-iYFrLLbCTA@mail.gmail.com>
 <CALE0LRtUz8hd4pdR9sX2Sb6tOn=K4wkRnGG9B7f72qU8JFQSYQ@mail.gmail.com>
 <CAC_iWjJLSSTO0Ca7rgOWAHfWzbkBkKHkQedRUbcwsoU0dtrsGA@mail.gmail.com>
 <CALE0LRvN3tYgWig1XnCiAZvdzE8x=cdLanGxbUvpPr5nfexSPQ@mail.gmail.com>
 <CAC_iWjL4mp-sTsp5a+yFkUauXuMvZ1yoTAk_60nm-CCKUgwayw@mail.gmail.com>
 <CALE0LRsYXXaao2uCUMFkd8Y6f5Mxgoc-Qpft_y8wWW3ZiekbbA@mail.gmail.com>
 <CAC_iWjL+J9tNxEdh0AoYD19h013N4nk=KmaT=RACo4-oVwuRCA@mail.gmail.com>
 <CALE0LRu2oDSo6KOhO2fTDMiqX7iqjqNjNGD_67MJFS7BJWqT_w@mail.gmail.com>
 <CALE0LRvFT3fDdoBLXHK2e47cibD02pxXAuZ83rTqEfrzU3HnKA@mail.gmail.com>
 <CAC_iWj+STZib+VOZrQtZk95skWzyLqe7_HpNM60G6axNa3Lnnw@mail.gmail.com>
 <CALE0LRsqc6L9EunhOyvyOR_KgG28zb10YBR1qN2qgZ9iJvaHEw@mail.gmail.com>
 <CAC_iWjKLqDFb1wSUQ1uMqOfbeRtzGNX9gyTHtQy5-71WvBiiLA@mail.gmail.com>
 <CALE0LRt7cwwwQ0Rh+0qJsUzTsNULEQSYgAoviQp5F5SXeJk8LQ@mail.gmail.com> <CAC_iWjKkdS71Fh3LZ0CJR-vnC+PwGKGndxjU3WjjUPnZ84DYWg@mail.gmail.com>
In-Reply-To: <CAC_iWjKkdS71Fh3LZ0CJR-vnC+PwGKGndxjU3WjjUPnZ84DYWg@mail.gmail.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Tue, 12 Nov 2024 17:03:01 +0100
Message-ID: <CALE0LRt2ct8onNyPvTNzy3Ps1kqduqx-OMmnQse-SXsk5M451Q@mail.gmail.com>
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Manorit Chawdhry <m-chawdhry@ti.com>, 
	Udit Kumar <u-kumar1@ti.com>, "Menon, Nishanth" <nm@ti.com>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 4:07=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 12 Nov 2024 at 16:39, Enric Balletbo i Serra
> <eballetb@redhat.com> wrote:
> >
> > On Tue, Nov 12, 2024 at 2:23=E2=80=AFPM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > [...]
> > >
> > > > > > > >
> > > > > > >
> > > > > > > Unfortunately that didn't help, but I don't see this code bei=
ng run.
> > > > >
> > > > > That's weird, look below.
> > > > >
> > > > > > > Who sets for the first place the uefi variables, is this u-bo=
ot
> > > > > > > writing them to the rpmb? or is optee itself?
> > > > >
> > > > > U-Boot sets the variables, but it does so via StandAloneMM.
> > > > >
> > > > > > >
> > > > > >
> > > > > > I tried to compare the behaviour between optee_rpmb (works) and
> > > > > > efidebug (doesn't worrk). I see that the first thing optee_rpmb
> > > > > > command does is open a session against the TA application, some=
thing
> > > > > > that efidebug doesn't do, shouldn't efidebug do the same to acc=
ess to
> > > > > > the rpmb device and read or write the efi variables?
> > > > > >
> > > > >
> > > > > That's a bit more complicated and explained to one of the blog po=
sts I
> > > > > pasted above.
> > > > > We do open an OP-TEE session, but not for talking to a TA. We sen=
d the
> > > > > messages to StandAloneMM, which then usese OPTEE RPMB APIs to wri=
te
> > > > > the flash.
> > > > >
> > > > > The weird thing is why OP-TEE does not format your RPMB when comp=
iling
> > > > > with that flag.
> > > > > If done correctly, OP-TEE will wipe the RPMB contents the first t=
ime
> > > > > it tries to access it.
> > > > >
> > > >
> > > > It does if I call optee_rpmb command
> > > >
> > > > E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****
> > > >
> > > > But I don't see any attempt to write efi variables to the rpmb
> > > > partition if I use the normal boot workflow or calling any efi comm=
and
> > > > from the prompt.
> > > >
> > > > I think I need to read a bit more about all the pieces because I mi=
ght
> > > > miss something.
> > >
> > > You don't need the command above to store variables. You need this in
> > > case you need to use the RPMB from the command line.
> > > Do a 'printenv -e && setenv -e -bs -rt -nv test test1 && printenv -e'=
.
> > > Does that work ?
> > >
> >
> > No, `printenv -e` gets stuck. This is the log with some debug messages =
I added.
> >
> > =3D> printenv -e
> > > lib/efi_loader/efi_setup.c:227 Initialize once only
> >   > lib/efi_loader/efi_setup.c:234 Set up console modes
> >   > lib/efi_loader/efi_setup.c:242 Proble block devices to find the ESP
> > MMC: no card present
> > mmc_init: -123, time 2002
> >   > lib/efi_loader/efi_setup.c:249 Initialize variable services
> >      > lib/efi_loader/efi_var_mem.c:223 efi_allocate_pages
> >      > lib/efi_loader/efi_var_mem.c:236 efi_create_event
> >   < lib/efi_loader/efi_var_mem.c:244 - ret=3D0
> > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
>
> Please try again with the FAT reset config flag in OP-TEE and without
> doing any reads and writes from the U-Boot console
>
> > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > ... stuck here ... traces indicates never outs from the efi_setup, so
> > looks like hungs
> >
> > Let me try with BeaglePlay and read a bit more, as I feel I'm a bit
> > lost right now.
>
> Sure, let me know if you need anything else.
>

Same behaviour on BeaglePlay, so either it's currently broken or I'm
making the same mistake in my process on both boards.

Ilias, by chance, do you have in which versions did you test?

Thanks,
  Enric
> /Ilias
> >
> > > >
> > > > =3D> optee_rpmb read test 4
> > > > D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> > > > 023f8f1a-292a-432b-8fc4-de8471358067
> > > > D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> > > > D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358067
> > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
> > > > D/TC:? 0 ldelf_syscall_open_bin:135 > ldelf_syscall_open_bin
> > > > D/TC:? 0 ldelf_syscall_open_bin:164 Lookup user TA ELF
> > > > 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> > > > D/TC:? 0 ldelf_syscall_open_bin:168 res=3D0
> > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellation)
> > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 492 bytes
> > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 532 bytes
> > > > F/TC:? 0 read_compressed:178 924 bytes
> > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> > > > F/TC:? 0 read_compressed:178 248 bytes
> > > > F/TC:? 0 read_compressed:178 760 bytes
> > > > F/TC:? 0 trace_syscall:147 syscall #6 (syscall_close_ta_session)
> > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > D/LD:  ldelf:176 ELF (023f8f1a-292a-432b-8fc4-de8471358067) at 0x40=
048000
> > > > F/TC:? 0 trace_syscall:147 syscall #33 (syscall_cryp_random_number_=
generate)
> > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> > > > F/TC:? 0 trace_syscall:147 syscall #4 (syscall_get_property_name_to=
_index)
> > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> > > > F/TC:? 0 trace_syscall:147 syscall #41 (syscall_storage_obj_open)
> > > > D/TC:? 0 rpmb_fs_open_internal:2356 >>> rpmb_fs_open_internal
> > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > D/TC:? 0 tee_rpmb_init:1253 >>> core/tee/tee_rpmb_fs.c:1253
> > > > D/TC:? 0 legacy_rpmb_init:1142 Trying legacy RPMB init
> > > > D/TC:? 0 rpmb_set_dev_info:1111 RPMB: Syncing device information
> > > > D/TC:? 0 rpmb_set_dev_info:1113 RPMB: RPMB size is 32*128 KB
> > > > D/TC:? 0 rpmb_set_dev_info:1114 RPMB: Reliable Write Sector Count i=
s 1
> > > > D/TC:? 0 rpmb_set_dev_info:1116 RPMB: CID
> > > > D/TC:? 0 rpmb_set_dev_info:1117 000000009e93ab30  13 01 4e 47 31 4d=
 31
> > > > 35  4c 10 27 91 28 07 a9 00
> > > > D/TC:? 0 legacy_rpmb_init:1162 RPMB INIT: Deriving key
> > > > D/TC:? 0 tee_rpmb_key_gen:308 RPMB: Using test key
> > > > D/TC:? 0 legacy_rpmb_init:1176 RPMB INIT: Verifying Key
> > > > F/TC:? 0 plat_prng_add_jitter_entropy:68 0x61
> > > > D/TC:? 0 legacy_rpmb_init:1180 Found working RPMB device
> > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> > > > D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
> > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> > > > E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****
> > > > D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 2
> > > > F/TC:? 0 plat_prng_add_jitter_entropy:68 0xD3
> > > > D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> > > > D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
> > > > D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
> > > > F/TC:? 0 dump_fat:1951 flags 0x2, size 0, address 0, filename ''
> > > > D/TC:? 0 read_fat:2221 fat_address 0
> > > > D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
> > > > F/TC:? 0 plat_prng_add_jitter_entropy:68 0x18
> > > > E/TA:  read_persist_value:338 Can't open named object value, res =
=3D 0xffff0008
> > > > D/TC:? 0 tee_ta_invoke_command:798 Error: ffff0008 of 4
> > > > D/TC:? 0 tee_ta_close_session:460 csess 0x9e925a50 id 1
> > > > D/TC:? 0 tee_ta_close_session:479 Destroy session
> > > > D/TC:? 0 destroy_context:318 Destroy TA ctx (0x9e9259f0)
> > > > Failed to read persistent value
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > > Cheers
> > > > > /Ilias
> > > > >
> > > > > > =3D> optee_rpmb read test 4
> > > > > > D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> > > > > > 023f8f1a-292a-432b-8fc4-de8471358067
> > > > > > D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> > > > > > D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de847135806=
7
> > > > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
> > > > > > D/TC:? 0 ldelf_syscall_open_bin:163 Lookup user TA ELF
> > > > > > 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> > > > > > D/TC:? 0 ldelf_syscall_open_bin:167 res=3D0
> > > > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_comman=
d)
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellati=
on)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_comman=
d)
> > > > > >
> > > > > > =3D> efidebug query -bs -rt -nv
> > > > > > MMC: no card present
> > > > > > mmc_init: -123, time 2002
> > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > Thanks
> > > > > > > > /Ilias
> > > > > > > > >
> > > > > > > > > =3D> efidebug query -bs -rt -nv
> > > > > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > ... stuck here ... I need to reset the board
> > > > > > > > >
> > > > > > > > > Will continue to see if I can get more useful messages
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > >   Enric
> > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > > /Ilias
> > > > > > > > > > >
> > > > > > > > > > > I'll try to add some more prints to verify if REE is =
used as a store
> > > > > > > > > > > system, I assume this should say something about RPMB=
. Am I right with
> > > > > > > > > > > this?
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > And tracing the function calls gives me that:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >       tee_stmm_efi_probe() {
> > > > > > > > > > > > > > >              tee_client_open_context() {
> > > > > > > > > > > > > > >                optee_get_version() {
> > > > > > > > > > > > > > >                  tee_get_drvdata(); (ret=3D0x=
ffff000002e55800)
> > > > > > > > > > > > > > >                } (ret=3D0xd)
> > > > > > > > > > > > > > >                tee_ctx_match(); (ret=3D0x1)
> > > > > > > > > > > > > > >                optee_smc_open() {
> > > > > > > > > > > > > > >                  tee_get_drvdata(); (ret=3D0x=
ffff000002e55800)
> > > > > > > > > > > > > > >                  optee_open() {
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > >                  } (ret=3D0x0)
> > > > > > > > > > > > > > >                } (ret=3D0x0)
> > > > > > > > > > > > > > >              } (ret=3D0xffff000004e71c80)
> > > > > > > > > > > > > > >              tee_client_open_session() {
> > > > > > > > > > > > > > >                optee_open_session() {
> > > > > > > > > > > > > > >                  tee_get_drvdata(); (ret=3D0x=
ffff000002e55800)
> > > > > > > > > > > > > > >                  optee_get_msg_arg() {
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > >                    tee_shm_get_va(); (ret=3D0=
xffff000002909000)
> > > > > > > > > > > > > > >                  } (ret=3D0xffff000002909000)
> > > > > > > > > > > > > > >                  tee_session_calc_client_uuid=
(); (ret=3D0x0)
> > > > > > > > > > > > > > >                  optee_to_msg_param(); (ret=
=3D0x0)
> > > > > > > > > > > > > > >                  optee_smc_do_call_with_arg()=
 {
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > >                    tee_shm_get_va(); (ret=3D0=
xffff000002909000)
> > > > > > > > > > > > > > >                    tee_shm_get_va(); (ret=3D0=
xffff000002909060)
> > > > > > > > > > > > > > >                    optee_cq_wait_init(); (ret=
=3D0xffff000002e55910)
> > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=3D=
0xffff0004)
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=3D=
0xffff0004)
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=3D=
0xffff0004)
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=3D=
0xffff0004)
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=3D=
0xffff0004)
> > > > > > > > > > > > > > >      ... continues sending this forever ...
> > > > > > > > > > > > > > >      ... Hit ^C to stop recording ...
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > >                    optee_smccc_smc() {
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > [1] https://docs.u-boot.org/en/latest/develop=
/uefi/uefi.html#using-op-tee-for-efi-variables
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Thanks in advance,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The most common problem with this is miscompili=
ng the tee_supplicant
> > > > > > > > > > > > > > application.
> > > > > > > > > > > > > > Since we don't know if the system has an RPMB, =
we emulate it in the
> > > > > > > > > > > > > > tee_supplicant. How did you get the supplicant =
and can you check if it
> > > > > > > > > > > > > > was compiled with RPMB_EMU=3D0 or 1?
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm using the tee-supplicant provided by the fedo=
ra package which is
> > > > > > > > > > > > > built with ` -DRPMB_EMU=3D0`, I think that's corr=
ect, right?
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, this is correct. We fixed the Fedora package t=
o compile the
> > > > > > > > > > > > supplicant correctly a while back.
> > > > > > > > > > > >
> > > > > > > > > > > > [0] https://www.linaro.org/blog/uefi-secureboot-in-=
u-boot/
> > > > > > > > > > > > [1] https://apalos.github.io/Protected%20UEFI%20var=
iables%20with%20U-Boot.html#Protected%20UEFI%20variables%20with%20U-Boot
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Regards
> > > > > > > > > > > > /Ilias
> > > > > > > > > > > > > Thanks,
> > > > > > > > > > > > >    Enric
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Thanks
> > > > > > > > > > > > > > /Ilias
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >    Enric
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


