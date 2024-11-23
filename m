Return-Path: <linux-kernel+bounces-419224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B49D6B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F61161B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC7719B3E2;
	Sat, 23 Nov 2024 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx75J/UL"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318915666D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732389319; cv=none; b=RLR7tyFxFPDNgnHNkEaDo5MkwUmgbNHgb0Dscs9zLnTwzx57UiZ/Efui/k9NNJd9v/wzTPf+VfvMGHW8PbAWwzaQY4gWX7K0a5u4PiR7/+M4tIFZv1stnbRUU6qsOIiX9bEL1TNQnS/551gvrD4oksq+i8jwPveyQoOm+ejKn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732389319; c=relaxed/simple;
	bh=vIdT+2Ww75o64OjS4hA1/FUsDum2NjeJznqbZWB+dqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwCVulAKZrnQ3v4nLe1qzlbwjHGTTufpVNzq6u77WaaBOEGX9zYCo2s/IKtdtNAY/tTKHYsTakCkBtDtmGnMRWB+wx/s5+ZmjIxUDXKJHV8bOpvJg4pMC/dL4Z9WrmAO29pgXgdHuwMTmaMD4OyVMMnlmqn6cJgoHwKb4n1ptqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx75J/UL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so3773942a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732389316; x=1732994116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3siSsmJoeQyqChfSTAzBFj2JJGuY8dGGjMZNDcgh7g=;
        b=fx75J/ULs1dGQmxMocjkIKz9Wh/ce4SEFsFP4ejOospwROhLdt0NeXX48x+poP+Fwg
         aKgb5ddTR+qCIXIolM/2pBPfeRSb+EUhq/7KzOq66gzvFU3tSKEtDdt55K0V+bQjsqNO
         Zpx7a9jwNgT9+suVwYmT+q3JoT3NWwGrtj6vAxqkHV7KWfy8L4MA1v1jd0IYkA4hl9tv
         kHdng1YGOd2lejfM6CHeXmB4mhVHO61Regj+I8S7R4s4VH3G8HtJi4uRW9saZLSk97zt
         sIz/KBluSfgcO3N6yCp11aeLanGzyLu3mUaNlw2ETBLc4rCNVfUWhD/xdMBL917jCSZP
         agyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732389316; x=1732994116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3siSsmJoeQyqChfSTAzBFj2JJGuY8dGGjMZNDcgh7g=;
        b=IYORvc0jpvSkn2XucJEJwqDyxyVpjPJs90zutjXOqnhivMWSAFlUFAn/xplPz0dLo0
         +fyXD2T92KBpgEtXKjlC3Glrv4L1TBByhkvU0tuyOL+Xx6gw6TdZZt8cZ7AO5p+qS0wR
         Qq4YJO42SxC/2v/DgPibMqQGXQC8ZWtfnk428g+HocPoardLGFTDx+ovku1GA6rPkhgY
         mVcmsNzgx1cFu61lumqoAKaPCtbP8FQWHuKUYOUIB2lP90TUCa3MowuUgsWYTs8M+wzS
         3A9613oxX9zzpLO1HT4fnhWDOWffPEhj7iPNTXHzU6mippC2KePQg7IQF7i38S8f9gyd
         AHZg==
X-Forwarded-Encrypted: i=1; AJvYcCVbcIJXwFdx6SMWBA241SKt2rYd5YEJRAmWiLMM1v2PjlMMw4bnwPNs7ECAQxKv/7+4k3X0lGLcsg2yKzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylqt3jqvPfMvfnYaM2xOw1vWFHaC2afCOIwLUFGLhDRpd1Zd+x
	DSpQ3JElGnEulbb0RITLiqLU8IkFL/hKylJVVXF3ySWiGmNqn7tqWSnKGMzA0zq4364rVJvTVki
	XYFs0d1N9OdUMwmBxX1+6i7QC5ywrvw==
X-Gm-Gg: ASbGncvPH7mBEn1FJHX5sYIOahtN9wgXsuUbtPQebBzV9MLjNsvjDOEJMK/6ffZ/oya
	jpBOM1S+8XXLw2EnOcbjC3Exd+tPIrXw=
X-Google-Smtp-Source: AGHT+IF7XmFe/cS2IBmFMVvkPVeaoC51w7XyBYTAY4GzUrAsarRMIVXUHXTXeHTmp6s35cPwn+HVta8IqhQzHRvxU50=
X-Received: by 2002:a05:6402:2713:b0:5cf:bcb4:7aff with SMTP id
 4fb4d7f45d1cf-5d02069448cmr6693472a12.22.1732389316015; Sat, 23 Nov 2024
 11:15:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123094729.1099378-1-mjguzik@gmail.com> <20241123094729.1099378-3-mjguzik@gmail.com>
 <5f510b8238824aa6b3534e755f965d85@AcuMS.aculab.com> <20241123190922.GA3314432@thelio-3990X>
In-Reply-To: <20241123190922.GA3314432@thelio-3990X>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 23 Nov 2024 20:15:03 +0100
Message-ID: <CAGudoHGATcA06Q23mCWbz10SSkO8H72jWN2k8gZGgm+h_ogG4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] string: retire bcmp()
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Laight <David.Laight@aculab.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"bp@alien8.de" <bp@alien8.de>, "andy@kernel.org" <andy@kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 8:09=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi David,
>
> Thanks for the CC.
>
> On Sat, Nov 23, 2024 at 03:13:09PM +0000, David Laight wrote:
> > From: Mateusz Guzik
> > > Sent: 23 November 2024 09:47
> > >
> > > While architectures could override it thanks to __HAVE_ARCH_BCMP, non=
e
> > > of them did. Instead it was implemented as a call to memcmp().
> > >
> > > These routines differ in the API contract: memcmp()'s result indicate=
s
> > > which way the difference goes (making it usable for sorting), whereas
> > > bcmp()'s result merely states whether the buffers differ in any way.
> > >
> > > This means that a dedicated optimized bcmp() is cheaper to execute th=
an
> > > memcmp() for differing buffers as there is no need to compute the ret=
urn
> > > value.
> > >
> > > However, per the above nobody bothered to write one and it is unclear=
 if
> > > it makes sense to do it.
> > >
> > > Users which really want to compare stuff may want to handle it
> > > differently (like e.g., the path lookup).
> > >
> > > As there are no users and the code is merely a wrapper around memcmp(=
),
> > > just whack it.
> > >
> > ...
> > >
> > > -/*
> > > - * Clang may lower `memcmp =3D=3D 0` to `bcmp =3D=3D 0`.
> > > - */
> > > -int bcmp(const void *s1, const void *s2, size_t len)
> > > -{
> > > -   return memcmp(s1, s2, len);
> > > -}
> > > -
> >
> > As per the comment I thought that clang would sometimes generate
> > calls to bcmp().
> >
> > So while the two symbols could refer to the same code I don't
> > think it can be removed.
>
> Right, commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")
> explicitly added bcmp() to lib/string.c because LLVM will emit calls to
> bcmp instead of memcmp in certain circumstances [1], an optimization
> that still exists, thus this patch would trigger new errors at link or
> modpost time:
>
>   ERROR: modpost: "bcmp" [arch/x86/kvm/kvm.ko] undefined!
>   ERROR: modpost: "bcmp" [arch/x86/kvm/kvm-intel.ko] undefined!
>   ERROR: modpost: "bcmp" [fs/quota/quota_v2.ko] undefined!
>   ERROR: modpost: "bcmp" [fs/dlm/dlm.ko] undefined!
>   ERROR: modpost: "bcmp" [fs/netfs/netfs.ko] undefined!
>   ERROR: modpost: "bcmp" [fs/ext4/ext4.ko] undefined!
>   ERROR: modpost: "bcmp" [fs/minix/minix.ko] undefined!
>   ERROR: modpost: "bcmp" [fs/fat/fat.ko] undefined!
>   ERROR: modpost: "bcmp" [fs/isofs/isofs.ko] undefined!
>   ERROR: modpost: "bcmp" [fs/nfs/nfs.ko] undefined!
>   WARNING: modpost: suppressed 254 unresolved symbol warnings because the=
re were too many)
>
>   ld.lld: error: undefined symbol: bcmp
>   >>> referenced by fortify-string.h:715 (include/linux/fortify-string.h:=
715)
>   >>>               vmlinux.o:(load_pdptrs)
>   >>> referenced by fortify-string.h:715 (include/linux/fortify-string.h:=
715)
>   >>>               vmlinux.o:(kvm_arch_irqfd_route_changed)
>   >>> referenced by fortify-string.h:715 (include/linux/fortify-string.h:=
715)
>   >>>               vmlinux.o:(vmx_check_processor_compat)
>   >>> referenced 438 more times
>   >>> did you mean: bacmp
>   >>> defined in: vmlinux.o
>
> Please do not apply this patch. If we need to shore up the comment to
> make this explicit, I am happy to do so.
>
> [1]: https://github.com/llvm/llvm-project/commit/8e16d73346f8091461319a7d=
fc4ddd18eedcff13
>

Hi guys, I just tested and indeed clang will convert some of the
memcmp uses into bcmp.

However, given that this is counterproductive in the kernel (it merely
adds a detour through another symbol), the thing to do here is to
convince clang to *not* do it and then whack the symbol

I admit I did not bother checking how bcmp came to be because I assume
it's a leftover -- it was the standard comparison routine back in the
day in the BSD land for example.

--=20
Mateusz Guzik <mjguzik gmail.com>

