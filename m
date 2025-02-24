Return-Path: <linux-kernel+bounces-530083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 032E6A42E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47AB179C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D341957E4;
	Mon, 24 Feb 2025 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jIdJHDqg"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98218FDB1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431304; cv=none; b=HCM7SRrQ3LseQv7TwF7bjLFo/9DF5tjdDsAvOwibkfk8an3N32KQKW5JQSGFGVLxad6BvfeatFQ3Lv9/yzcW0JdswjXZbm5gwOaQD/foL7pzjpaYCl7ZSUlLbRNYPZTKNMF2VDKM8F1D48i9zK7hCx4E+kRaWkjDeTxwP3hmiPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431304; c=relaxed/simple;
	bh=S+J4+Y3K6hYWfP2jr6yZLfknW9XR99HY0StPBmeTumU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YVU/7mPSihgVsX9Qv9dwJgju0JRom/CZmHqyLYgi/sy4w6bXuzR60i/2YaoFQpEL8N1vCHy9cKMVSu0q62NnohlVYH/uBZj24sVy/xdXxwX9YS7Kr9ckFkPU5Sti/TpbPHsuGvj4eqfkeJfspHWn9JnxyWL55ac5qMvtZ1r/SVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jIdJHDqg; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f409ca7c14so100292b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740431302; x=1741036102; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqwUM7z/MlyrwkKgNvJiV6cUle8dIMYryU69NwoTdgI=;
        b=jIdJHDqgktQl8LCWZfVCpEFpXRLbx9VSub2P/saZGbhoKVu9634Os+0hNgETnmAlsT
         Z/6yG1uTh+XtqTc5EEnt/pG3YVqQ1ZN49SCSFQY1ZI181oiPPXNUm2uOVlH2yfTYe6z8
         ZKoG4hQPQgLyFqw6czUYA1kS2xLItYBP6rwZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431302; x=1741036102;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqwUM7z/MlyrwkKgNvJiV6cUle8dIMYryU69NwoTdgI=;
        b=FCZP4WLkxa8d+8E6dhZRWeQREEWJQRrc2wCzBPSi5oc9TrtbZzJkqvz01VvebdXMFf
         k1oTlWh8XVh6EKUAqEL+eMJPJ6hSc6jLwTPQSRTUXzrZhs0BPB6+ykmhn8A71VECNVmr
         iYJ0+kHENLGgsZPjln6mTKBlTBiNyy17NxtwoXYXEyRwYPWBpAUn5oBkvfqkCdpjhM53
         KnjygdRkkJn4aVbGpA1Mi7T3PtEh7QdKEzll1VWWXOeQAISEsfRL2ae8z3bG9Rpq5W69
         OdGTSf1HkLqNSFKZ4oOTjQJdAHyqKYE6YUXIr5yQ6EjBZPNsH1/pW5jk+5cn1REerVqZ
         R+Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUU0C/L4iPkoT7O4yNJnwCv/AjSF83Q4nyUnjtf9NQwJhcsRWsx8jkf2ckMCGlvCF4pPduwdFN8/XswzYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3lUZSFLreaoL9BMxFTIYfrvAA30IDlVjTOh5PMPaerM7VkKCl
	tqJLfQLQ8rnaP2xd/OujLvMnYpm6ZgPW9Lx3jBy/Kol+TNbpNgwUwywKoiLIps14Zz8aSfOider
	62rmwNLqCFFVpVpYMnGfUsdPdLLoKQP4vM/m4
X-Gm-Gg: ASbGncvzPU2iwVoiP82RR8VmYORaOChjICouEzGyseuEDiO8JbzQghIns2VRHw95mzX
	/v+mKcgs55GN7KHveKJVJ2t0gVEfsiKZoWy7KcxSL9g0+bdlujQl3PWgnqZZd4Mnt6CkUb9GfX7
	BevzY5+BIxx2XN0qxy8aegwEWOzMsS4q50r8N5
X-Google-Smtp-Source: AGHT+IEyLdD3QO29qr9sIDUjsytjn1KwgsoakcrCoJ1Ge7lYHKGmGvOWBLOc9ojbyxwW1LykKldxYU6ZYSJ+uRm5UBo=
X-Received: by 2002:a05:6808:1598:b0:3f3:ffde:7718 with SMTP id
 5614622812f47-3f42479a661mr4694342b6e.4.1740431301718; Mon, 24 Feb 2025
 13:08:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com> <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
 <CABi2SkV-RwWjfXZfK4tHzQWG=dCJU7CRGmthSA8vqhHcbeCiQw@mail.gmail.com>
 <202502241123.D398A24@keescook> <CABi2SkXLdL37LxLuo+W=rUOrBKfMbxgkkR+s3TqnnS-eAQbakg@mail.gmail.com>
 <krwnfnuhjmes4al5pquxax2khy7laurjnvvzntsrk7xpenoc7m@k24fekzllylc>
In-Reply-To: <krwnfnuhjmes4al5pquxax2khy7laurjnvvzntsrk7xpenoc7m@k24fekzllylc>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 13:08:10 -0800
X-Gm-Features: AWEUYZkeA9uH_WH28esMZG2-V_Fo4Bt7LyXoWGFWIzH4LgxhwR4_Q7Am0Wxgglw
Message-ID: <CABi2SkVTm4m=rUseaQUnJR7CQVuoULSmPB7ho8vKdmDY-pDdnQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 12:13=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [250224 14:42]:
> > On Mon, Feb 24, 2025 at 11:25=E2=80=AFAM Kees Cook <kees@kernel.org> wr=
ote:
> > >
> > > On Mon, Feb 24, 2025 at 11:10:22AM -0800, Jeff Xu wrote:
> > > > On Mon, Feb 24, 2025 at 11:03=E2=80=AFAM Liam R. Howlett
> > > > <Liam.Howlett@oracle.com> wrote:
> > > > >
> > > > > * Jeff Xu <jeffxu@chromium.org> [250224 13:44]:
> > > > > > On Mon, Feb 24, 2025 at 10:21=E2=80=AFAM Dave Hansen <dave.hans=
en@intel.com> wrote:
> > > > > > >
> > > > > > > On 2/24/25 09:45, jeffxu@chromium.org wrote:
> > > > > > > > +/*
> > > > > > > > + * mseal of userspace process's system mappings.
> > > > > > > > + */
> > > > > > > > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > > > > > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_SEALED
> > > > > > > > +#else
> > > > > > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_NONE
> > > > > > > > +#endif
> > > > > > >
> > > > > > > This ends up looking pretty wonky in practice:
> > > > > > >
> > > > > > > > +     vm_flags =3D VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_=
PFNMAP;
> > > > > > > > +     vm_flags |=3D MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
> > > > > > >
> > > > > > > because MSEAL_SYSTEM_MAPPINGS_VM_FLAG is so much different fr=
om the
> > > > > > > other ones.
> > > > > > >
> > > > > > > Would it really hurt to have
> > > > > > >
> > > > > > >  #ifdef CONFIG_64BIT
> > > > > > >  /* VM is sealed, in vm_flags */
> > > > > > >  #define VM_SEALED       _BITUL(63)
> > > > > > > +#else
> > > > > > > +#define VM_SEALED       VM_NONE
> > > > > > >  #endif
> > > > > > >
> > > > > > > ?
> > > > > > >
> > > > > > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't pa=
rt of
> > > > > > the build. This is intentional. Any 32-bit code trying to use t=
he
> > > > > > sealing function or the VM_SEALED flag will immediately fail
> > > > > > compilation. This makes it easier to identify incorrect usage.
> > > > > >
> > > > >
> > > > > The reason that two #defines are needed is because you can have m=
seal
> > > > > enabled while not sealing system mappings, so for this to be clea=
n we
> > > > > need two defines.
> > > > >
> > > > > However MSEAL_SYSTEM_MAPPINGS_VM_FLAG, is _way_ too long, in my o=
pinion.
> > > > > Keeping with "VM_SEALED" I'd suggest "VM_SYSTEM_SEALED".
> > > > >
> > > > How about MSEAL_SYSTME_MAPPINGS as Kees suggested ?
> > > >
> > > > The VM_SYSTEM_SEALED doesn't have the MSEAL key or the MAPPING, so =
it
> > > > might take longer for the new reader to understand what it is.
> > >
> > > I think to address Dave's concern, it should start with "VM_". We use
> > > "SEAL" already with VM_SEALED, so the "M" in "MSEAL" may be redundant=
,
> > > and to clarify the system mapping, how avout VM_SEAL_SYSMAP  ? That
> > > capture's, hopefully, Dave, Liam, and your thoughts about the naming?
> > >
> > Liam had a comment in the previous version, asking everything related
> > with mseal() to have the MSEAL keyword, that is why KCONFIG change has
> > MSEAL.
> >
> > How about VM_MSEAL_SYSMAP ?
>
> I don't recall if it was this set or previous ones, but seal is becoming
> overloaded and having mseal would have been good for this one.
>
> VM_MSEAL does gain more greping, but since we have VM_SEALED,
> VM_SEAL_SYSMAP is going to show up on VM_SEAL grep, but not VM_SEALED
> greps.  Maybe VM_SEALED_SYSMAP would be better for searching.
>
OK, I will change to VM_SEALED_SYSMAP

-Jeff

> Thanks,
> Liam
>
>

