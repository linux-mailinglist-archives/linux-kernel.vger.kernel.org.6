Return-Path: <linux-kernel+bounces-310599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2248967EE0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF561F224E7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D3914F12D;
	Mon,  2 Sep 2024 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkI+z5Hx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2588A149E03
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725255648; cv=none; b=NYvuQlrtobAO+FBi1GmcKKB0ChAWdeFCTjgvyP0rUHb34q+c+L/oNb9ClgwolgMTc4DJ5L3ONKkelfyebPlH4CZSrSocWkeQqyslEOi8RfWY5xODw7j1mg138fv027R29tpmbTbgUwCkgxwI3mG2sEi8pY2b7/W1v44d8JvmOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725255648; c=relaxed/simple;
	bh=ZKgLXVxqGBlMX/HSes9KJsdiqRiK6uEOxtIu0/mc+1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AraAiHzmoJC2Sl+rsfpv2wJY22NbvIX4KrE7+deCJR1zeKZy6zts7fvCZdOz2+2wsHv9l1QIZZb1oSsZn9TDtqBZmT80LzVwmfyKJVohrLO4BTaub97eGoEXSjhcaSjojNGhfSFPYVpUSCJec/7QwaZA0a5TRJlDArPpEkgOLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkI+z5Hx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725255646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRnSBt/Y5eceLh55m3HnCPqU2nMHi0V+SDsqesK2W8g=;
	b=CkI+z5Hx18ajs7DF2Dvx7iz6FopIzK63wEKXNUPc0aADgVnK+0vS+giDDuqRQp6txdSJqi
	V4QgUK2cBT/YKbkjta7Fj+igXnQznrvrZbkLV76oU4q4EQuGnMr348n3xVhR2Dh+Cdjcz1
	MI+eRIgjDMM5IFBjvCTIF+XuSM3eM9I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-ayr4-XJKNZW3xYhnj_W0tA-1; Mon, 02 Sep 2024 01:40:44 -0400
X-MC-Unique: ayr4-XJKNZW3xYhnj_W0tA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6c366f8b1ebso11646966d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 22:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725255644; x=1725860444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRnSBt/Y5eceLh55m3HnCPqU2nMHi0V+SDsqesK2W8g=;
        b=gJihplUu7xBqC2yix81dv/7ibki0l7iVd1XwVh10bDYtoK5k/R0GRNkTDG4QAptRcb
         C8olEnB47tGTFJdbCOs/mqLpULbn43xKE9R5ygTly5IQwbqIA3UJ+g6yslEI1+NmHNy7
         sOfUglHYO+Pu+NMQDFSCmu0zI+E1VVc/+ZDJTD/VoFXi99NoNkCwrne5HOnKYUWlb0qO
         kqc4DjMz0htKhWVYMIwbzQHXsN52C92albSpfekOHvfHmQLKKT6+5G7rMTpA4adY7EtN
         48QUPGJXQ87Y+OFVoi7juuWrRd1zR9LzReczzPvrC2i2+qGKKmV8dIG3+xXoF3lsTonN
         mNzw==
X-Forwarded-Encrypted: i=1; AJvYcCUlgH2b6ph8j1sbrGImWsoEbpPniHtHlZZkK5sx9wfPW13O2ROR0qjw+dXqMidKIOlia+BQJw1kgbYcAGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQPVdv2tp63xkmoVRpogG/X0bt1QJPhz7wk8lYJTMrU+pp/dAj
	4OcF5I5MPCpLqM4wZ2d6XN7zHzHOuZsBxYGJNrHIejDvjvWxH5vwvorqQq0WwT/Kk3VuCPHX/EU
	Qq8Wjlpvd0cVBksgRV//5IWMlXbZYlOC5pM7vkMY8QUg8zhm8x8Na+cuWsIGArFtKSNnYoeDE7G
	ubc3scnDOvEe02A2DVipfH0HausqNuKQx+l33h
X-Received: by 2002:a05:6214:412:b0:6bd:738c:842e with SMTP id 6a1803df08f44-6c33f33ba2dmr247844976d6.7.1725255644360;
        Sun, 01 Sep 2024 22:40:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLG3n6qFXQd6j9fD3rpLTzswKzCAwE4mH3nVuq4KI5nupSC1ibIcr0+CQALAep1tMuUKdJQcZNOkRaJG2tSkY=
X-Received: by 2002:a05:6214:412:b0:6bd:738c:842e with SMTP id
 6a1803df08f44-6c33f33ba2dmr247844836d6.7.1725255643983; Sun, 01 Sep 2024
 22:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
In-Reply-To: <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Mon, 2 Sep 2024 13:40:33 +0800
Message-ID: <CAF+s44QWjyswV3Huh5AWJzDwRCjvdjjEX2WDPaie9KrH0QOxOg@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 1:08=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
[...]

Hi Ard,

Thanks for sharing your insight and thoughts.

>
> Thanks for putting this RFC together. This is useful work, and gives
> us food for thought and discussion.
>
> There are a few problems that become apparent when going through these ch=
anges.
>
> 1. Implementing UEFI entirely is intractable, and unnecessary.
> Implementing the subset of UEFI that is actually needed to boot Linux
> *is* tractable, though, but we need to work together to write this
> down somewhere.
>   - the EFI stub needs the boot services for the EFI memory map and
> the allocation routines
>   - GRUB needs block I/O
>   - systemd-stub/UKI needs file I/O to look for sidecars
>   - etc etc
>
> I implemented a Rust 'efiloader' crate a while ago that encapsulates
> most of this (it can boot Linux/arm64 on QEMU and boot x86 via GRUB in
> user space **). Adding file I/O to this should be straight-forward -
> as Lennart points out, we only need the protocol, it doesn't need to
> be backed by an actual file system, it just needs to be able to expose
> other files in the right way.
>
> 2. Running the UEFI emulator on bare metal is not going to scale.
> Cloning UART driver code and MMU code etc is a can of worms that you
> want to leave closed. And as Lennart points out, there is other

As for MMU code, if the 1st kernel does not turn it off, it can be
eliminated from the emulator code, which should not be hard to
implement on arm64. And already done in x86.

> hardware (TPM) that needs to be accessible as well. Providing a
> separate set of drivers for all hardware that the EFI emulator may
> need to access is not a tractable problem either.
>
> The fix for this, as I see it, is to run the EFI emulator in user
> space, to the point where the payload calls ExitBootServices(). This
> will allow all I/O and memory protocol to be implemented trivially,
> using C library routines. I have a crude prototype** of this running

Yes, that is a definitely promising method, By this way, we can handle
device operations more elegantly. In fact, I used it to develop and
debug part of my emulator service code.

But when debugging x86 efi-stub, I encounter some problem with the
privileged instruction, which causes segment fault. It originates from
kaslr_get_random_long().  I think it can be worked around by emulating
the instruction if the instruction reads the system state. But if the
instruction tries to update system state, it can not be fixed since
the system is still owned by the kernel instead of owned by the
emulator exclusively.

So here we need another agreement on the stub's behavior before
ExitBootServices().

> to the point where ExitBootServices() is called (and then it crashes).
> The tricky yet interesting bit here is how we migrate a chunk of user
> space memory to the bare metal context that will be created by the
> kexec syscall later (in which the call to ExitBootServices() would
> return and proceed with the boot). But the principle is rather
> straight-forward, and would permit us, e.g., to kexec an OS installer
> too.
>
> 3. We need to figure out how to support TPM and PCRs in the context of
> kexec. This is a fundamental issue with verified boot, given that the
> kexec PCR state is necessarily different from the boot state, and so
> we cannot reuse the TPM directly if we want to pretend that we are
> doing an ordinary boot in kexec. The alternative is to leave the TPM

Here, I miss the big picture. Could you enlighten me more about this?
As I thought, the linux kernel will not lock itself down onto a
specific firmware. So the trust is one direction, i.e. from bootloader
to kernel. In UKI case, systemd-stub takes the measurement and extends
the PCR 11/12/13 as in
https://uapi-group.org/specifications/specs/linux_tpm_pcr_registry/

Later systemd-pcrlock appraises the value in those registers. If the
sections in UKI are intact, the kexec reboot will go smoothly.


> in a state where the kexec kernel can access its sealed secrets, and
> mock up the TCG2 EFI protocols using a shim that sits between the TPM
> hardware (as the real TCG2 protocols will be long gone) and the EFI
> payload. But as I said, this is a fundamental issue, as the ability to
> pretend that a kexec boot is a pristine boot would mean that verified
> boot is broken.
>
>
> As future work, I'd like to propose to collaborate on some alignment
> regarding a UEFI baseline for Linux, i.e., the parts that we actually
> need to boot Linux.
>

Do you mean that user space code and kernel code? And I think for the
user space code, it should be better to integrate the code in
kexec-tools so that we have a uniform interface for kexec boot.

Looking forward to the collaboration to make kexec able to boot UKI soon.


Thanks,

Pingfan


