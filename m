Return-Path: <linux-kernel+bounces-529910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7741CA42C68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C24170F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FF6155CB3;
	Mon, 24 Feb 2025 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GYzoG0fr"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07D189F36
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424236; cv=none; b=Yr712GK8FkffvmzhhaPVMTATMWj5LvFufkc2v4NxBfjXvziZqyOSG/9nX/p/YD3R+lKatuHGSJSNfWOLm/WlMk0VTTLMvN7gJA6aJ47y6uvL6fPOzVjCl9spLhFGgwDGXiWuLVjV5K2zO+FjOzD1FvgePOFbK2xtScXg5B7YjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424236; c=relaxed/simple;
	bh=JJqwJdyWEpP4WKiHJPh2dMaurzmP+l2Jd9yHTkji/14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dOX8usSsNdXd6gK9UNePQs+FyluT07tn9xigQoc20eXHsnyVXaZkPZqeedA4GQWhiohZIWArnXL/guRbsSXboaX5ZaGFv35+wx6v89d6DowogwiCdV0TNt1AzHvizav8Aawx6J1u/PBW93KcjEvACFxEFPJ3TWPlr7ByY9GOFN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GYzoG0fr; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-724daedf8c3so1222333a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740424233; x=1741029033; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9GUPPHtI/YKh17WuuJkLZZaFJrQQSx3CAYW3DjQ3WE=;
        b=GYzoG0fru+lRDiHghSLjjSUyuXZjUWR4g92Y3KChJ7ewHbwE/DdkVUHgos/NR9/9Y5
         sdPXwZVhrhNnzVLPjZohoGxgnskln2fz7D7wEjZNUEE2K2ux3/1t7hZc9EQhXGplaVIU
         uy31plx6ocVNEhz7uqhQoZJ9I4a/lpL6+P/sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424233; x=1741029033;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9GUPPHtI/YKh17WuuJkLZZaFJrQQSx3CAYW3DjQ3WE=;
        b=viL/hNcYNN4uOFTccsCD+rRGbFl9v9dkQmk/uusKg4ktyOuvT/ReW0HQcssNXHNY3a
         cX6WqR8GsCkuCs6YORrQAtH8sGzMf2cW+qDNWqapKIkxu0rV0SESOUXGEk9z+gVqExD9
         bxfSbOQH+AuUQfSEhHWDlcssUi/DKsij6+CkhSAJEULNtwGBTjxApNIC8hLug2vT4Amb
         pcQ2bibiUl6cEi3Atq91lo0gsOp68GF4Ffd+Iq0t0zu9x3J1OdLkpanalOKJU7GTLUrT
         M6XSJfq/r29yYnuG80MuHALrtzqsQD0bg5mHxnXyWCIwXX16YAbbhHuU+DNLqrCKWj2G
         XrFg==
X-Forwarded-Encrypted: i=1; AJvYcCUYg74OS34s4G1mkrcSteVtBsaOIte33cRZvYudBfm/vOpxGY2N9Y8qX8QjHprpwnyFcmSDautwMXpVRMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4KBU/Re+oZsNIUgqyGhwBerN+i4UzD77imNwksKA9X8DTU8cK
	UZie0vpwBmsocW5CVzng+nFkZ/Kh3/2R8mWBbeKKIrzTYthO/SGxwl5w8m0sM8XRzNu9ERZRTdT
	67Yd1SFF28HoBA6LucfQgIKOt4CvRsHn7Iq/P
X-Gm-Gg: ASbGncuL/RsKw3ZzJaTyMtWZAoBpQB52qspVuK9xDJlWJj5sXvv1Ha1CeNFkl4BGzdy
	C8yVaY6rHzZs80quvIU5FwfL2IXPw+Cuo9CTS45UExE4Vyeds3pdtlv6eN3H0SX/DBZql7P2l62
	wEOGcV+hTJRP9J7lOo7vSWnge1LLopKnhFIUJa
X-Google-Smtp-Source: AGHT+IFlDVsxYo9mfEvAqcvS4ITFW3i/z/MP2mONGiYQhwahTiLBP8R5L4zcHu5ETCTa4Vq9saY30CuDm1u91AncVR0=
X-Received: by 2002:a05:6808:2227:b0:3f4:ad6:519c with SMTP id
 5614622812f47-3f4246b3b10mr4256084b6e.2.1740424233263; Mon, 24 Feb 2025
 11:10:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com> <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
In-Reply-To: <3nxcy7zshqxmjia7y6cyajeoclcxizkrhhsitji5ujbafbvhlu@7hqs6uodor56>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 11:10:22 -0800
X-Gm-Features: AWEUYZmwpnqiN9sqZHdi21X3o8pzG8dSdU0zfO4HZpkMFe9rZXpLE-Vov3pXiB0
Message-ID: <CABi2SkV-RwWjfXZfK4tHzQWG=dCJU7CRGmthSA8vqhHcbeCiQw@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header change
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org, keescook@chromium.org, 
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

On Mon, Feb 24, 2025 at 11:03=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [250224 13:44]:
> > On Mon, Feb 24, 2025 at 10:21=E2=80=AFAM Dave Hansen <dave.hansen@intel=
.com> wrote:
> > >
> > > On 2/24/25 09:45, jeffxu@chromium.org wrote:
> > > > +/*
> > > > + * mseal of userspace process's system mappings.
> > > > + */
> > > > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_SEALED
> > > > +#else
> > > > +#define MSEAL_SYSTEM_MAPPINGS_VM_FLAG        VM_NONE
> > > > +#endif
> > >
> > > This ends up looking pretty wonky in practice:
> > >
> > > > +     vm_flags =3D VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|VM_PFNMAP;
> > > > +     vm_flags |=3D MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
> > >
> > > because MSEAL_SYSTEM_MAPPINGS_VM_FLAG is so much different from the
> > > other ones.
> > >
> > > Would it really hurt to have
> > >
> > >  #ifdef CONFIG_64BIT
> > >  /* VM is sealed, in vm_flags */
> > >  #define VM_SEALED       _BITUL(63)
> > > +#else
> > > +#define VM_SEALED       VM_NONE
> > >  #endif
> > >
> > > ?
> > >
> > VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part of
> > the build. This is intentional. Any 32-bit code trying to use the
> > sealing function or the VM_SEALED flag will immediately fail
> > compilation. This makes it easier to identify incorrect usage.
> >
>
> The reason that two #defines are needed is because you can have mseal
> enabled while not sealing system mappings, so for this to be clean we
> need two defines.
>
> However MSEAL_SYSTEM_MAPPINGS_VM_FLAG, is _way_ too long, in my opinion.
> Keeping with "VM_SEALED" I'd suggest "VM_SYSTEM_SEALED".
>
How about MSEAL_SYSTME_MAPPINGS as Kees suggested ?

The VM_SYSTEM_SEALED doesn't have the MSEAL key or the MAPPING, so it
might take longer for the new reader to understand what it is.

-Jeff

