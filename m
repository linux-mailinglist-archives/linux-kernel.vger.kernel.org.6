Return-Path: <linux-kernel+bounces-297447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DB995B862
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35A428710C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FC21CBEA2;
	Thu, 22 Aug 2024 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QI0rpc2+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527A1CB135
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336989; cv=none; b=ZK/kwYhvefnPCWHlz5Fc4zFvsjXQr4Y5ewSKBQyxEHp9a3iIdEfW8cGinANiPV2sbXQZfGpU6nJJ2GioPGZZB1NyKs1reLhdjPL7iwgduUEFciuDb6V6LOw1OqlCaf0GrkAow4qSEtgNtF6UGczvJbZ9yoHbRCz5qA3wkSGnKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336989; c=relaxed/simple;
	bh=4hgjKSXqmD4wuXTEVqitwJr2+8LzfnOsifWBPu0BPjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVgYcXLKNCVAJClK6Sqh4Tu9l2TxJXSuR1fkhtGC4R3Eshi5qWZjHg+r3J9Fj9HXfQwKdYNT+5xMB8DjdR33mO0bb8AhPinokXXq6v6XMtFoPjWVyprCnoprUk9l+d0/qrKckEgLMPn4GNBwHV/s/5OwJOTzNvuCuGMusjrIQl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QI0rpc2+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724336986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/6AxOb6WsbLr7G2jGoOD1ehnx93Ji/pJCnzGUX2sbo=;
	b=QI0rpc2+8pwGh79wJR2S5Dje/1j6W2qro2kzFG/qeE4ML5RBoCkaYtnfnvQfRkmLZ+0s93
	fRSFx9P7ayUDxmVWY135JlF5GANRdJsQ+B5EEUZBIMkehdtGZf5Hl3wEDa3hi4pL8oefdk
	/Y1iV8ysqD9tPGpFCJM6cVK+2+P/tKs=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-kGtXJzQzNRGIgQN7pPdxvA-1; Thu, 22 Aug 2024 10:29:43 -0400
X-MC-Unique: kGtXJzQzNRGIgQN7pPdxvA-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5dc9ed1d3baso981439eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724336983; x=1724941783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/6AxOb6WsbLr7G2jGoOD1ehnx93Ji/pJCnzGUX2sbo=;
        b=dTS5Csy2qlPq6T+1NnXH9fMTwKwUhV0ZMXDtL+XHDTOU+ec+Kol+qFNBOuMHLzJ0qM
         9DypEwGUmg9n3lP8j+XZC2jz4GngIeaSiheDowvLyu63s2zdJf4T8GT+2tjZ9sixq4Ty
         PQ8zQlCaNVYN+L9SnBoMyXiYjH1kDF9fOPOdnbmdgFLYbh37eMurq1IPPzDajfCuv/MM
         7Wt82zX7+mQPJ21sphk3WMMzhNwlAnAe26PmfqSkJ8ybGKgM/Xq+knbeWJH26L8+0clp
         EjLH0KW0XvJuljb6RHUAor5CX8iPdfqOR0OOlYdQ3HrVugLL4TMm8mO6Au8jogwuuGrG
         cT6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdxRhp+MIY/ND6XVUFbxIhZ8Ly68GFvO0NsHqpGSYXpD7wwCltEFPUMUXp9wCX/H0eSDaqcgOT6kfWCqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvC+lx+dKchs7LXkQwRJRLsLzU2fiLRl2Zia0JtSrcn5RpX2v6
	3i3i3kR2dPV0r0PdJjFgtl+z7j209RUuz4Gcj7sdzFs4xxkgKBjdqOQw1zAU7T6CKIZqSRT+m9O
	jF8NOBbIcTQRNtmfqtEThazSrquzyWiWDu0T1iR7c+GTYBWdi8tiB/tx8fWEJ3rE4jeO4vwm4Fr
	ChlyLOf+8ms/b9ubpsjn4LNuTa+EPxZHrFGaVe
X-Received: by 2002:a05:6358:980d:b0:1b5:a037:f238 with SMTP id e5c5f4694b2df-1b5a037f311mr612517355d.0.1724336982756;
        Thu, 22 Aug 2024 07:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+brQfGyYU0BpsvYX3In5ntxKlxV2usDwSemakngx24acx/det+Wm07KEOH4KNbGPDEw/r7dG0Fhsa3BZCjPg=
X-Received: by 2002:a05:6358:980d:b0:1b5:a037:f238 with SMTP id
 e5c5f4694b2df-1b5a037f311mr612515255d.0.1724336982430; Thu, 22 Aug 2024
 07:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com> <Zsb1isJ2cYRp2jpj@gardel-login>
In-Reply-To: <Zsb1isJ2cYRp2jpj@gardel-login>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 22 Aug 2024 22:29:31 +0800
Message-ID: <CAF+s44SQtRxZz=2eSJ-xP44ORLqvq0doEQ8qrw+1RaKFhoje8w@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 4:23=E2=80=AFPM Lennart Poettering <mzxreary@0point=
er.de> wrote:
>
> On Do, 22.08.24 13:42, Pingfan Liu (piliu@redhat.com) wrote:
>
>  > On Wed, Aug 21, 2024 at 10:27=E2=80=AFPM Lennart Poettering
> > <mzxreary@0pointer.de> wrote:
> > >
> > > On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:
> > >
> > > > *** Background ***
> > > >
> > > > As more PE format kernel images are introduced, it post challenge t=
o kexec to
> > > > cope with the new format.
> > > >
> > > > In my attempt to add support for arm64 zboot image in the kernel [1=
],
> > > > Ard suggested using an emulator to tackle this issue.  Last year, w=
hen
> > > > Jan tried to introduce UKI support in the kernel [2], Ard mentioned=
 the
> > > > emulator approach again [3]
> > >
> > > Hmm, systemd's systemd-stub code tries to load certain "side-car"
> > > files placed next to the UKI, via the UEFI file system APIs. What's
> > > your intention with the UEFI emulator regarding that? The sidecars ar=
e
> > > somewhat important, because that's how we parameterize otherwise
> > > strictly sealed, immutable UKIs.
> > >
> > IIUC, you are referring to UKI addons.
>
> Yeah, UKI addons, as well as credential files, and sysext/confext
> DDIs.
>
> The addons are the most interesting btw, because we load them into
> memory as PE files, and ask the UEFI to authenticate them.
>
> > > Hence, what's the story there? implement some form of fs driver (for
> > > what fs precisely?) in the emulator too?
> > >
> > As for addon, that is a missing part in this series. I have overlooked
> > this issue. Originally, I thought that there was no need to implement
> > a disk driver and vfat file system, just preload them into memory, and
> > finally present them through the uefi API. I will take a closer look
> > at it and chew on it.
>
> It doesn't have to be VFAT btw. It just has to be something. For
> example, it might suffice to take these files, pack them up as cpio or
> so and pass them along with the UEFI execution. The UEFI emulator
> would then have to expose them as a file system then.
>
> We are not talking of a bazillion of files here, it's mostly a
> smallish number of sidecar files I'd expect.
>
> > > And regarding tpm? tpms require drivers and i guess at the moment uef=
i
> > > emulator would run those aren't available anymore? but we really
> > > should do a separator measurement then. (also there needs to be some
> > > way to pass over measurement log of that measurement?)
> >
> > It is a pity that it is a common issue persistent with kexec-reboot
> > kernel nowadays.
> > I am not familiar with TPM and have no clear idea for the time being.
> > (emulating Platform Configuration Registers ?).  But since this
> > emulator is held inside a linux kernel image, and the UKI's signature
> > is checked during kexec_file_load. All of them are safe from
> > modification, this security is not an urgent issue.
>
> Hmm, I'd really think about this with some priority. The measurement
> stuff should not be an afterthought, it typically has major
> implications on how you design your transitions, because measurements
> of some component always need to happen *before* you pass control to
> it, otherwise they are pointless.
>

At present, my emulator returns false to is_efi_secure_boot(), so
systemd-stub does not care about the measurement, and moves on.

Could you enlighten me about how systemd utilizes the measurement? I
grepped 'TPM2_PCR_KERNEL_CONFIG', and saw the systemd-stub asks to
extend PCR. But where is the value checked? I guess the systemd will
hang if the check fails.

Thanks,

Pingfan


