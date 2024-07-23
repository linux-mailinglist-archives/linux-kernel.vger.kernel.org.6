Return-Path: <linux-kernel+bounces-260038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D6093A1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4109A1C21AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1B15358F;
	Tue, 23 Jul 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyFtVrgD"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4315252F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742317; cv=none; b=nUG/9gw7MN6fbYUtjvJsadaaofiTlFBXxPc64UPqWQ8m16BFm0aDD4Vt+VuZtoMmmKfluBk5AG8rTQ4vSWGJXr2dF7MuClu9ZxPF3HwNPkLzv8ixeCntHqYsXw+jLT0AebGiw520/YbjeZBIKCKW89tGGfR11Pe31XCbt3gPUEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742317; c=relaxed/simple;
	bh=6xkjqOLIBWCUTPE9oBNQS4lln363uqAs32mI8+U9f9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4pepTy9dEDkv5kOA+UwprqLEVT8uNjacmfKj0vU1hGbKItE9K7TnnF/TxrtPcNxTmXqr+zSnSY0KNb0XqYomDZlEZGTwgpAE2xdTUnOiAqQaXEkQypyFezxgRlXAtJGJODu5S8nFCfNGZQhjXpeFwEqTFdPs4T3gc7KbLvQRaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dyFtVrgD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427db004e36so26460165e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721742314; x=1722347114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUdMWNOBxPL41aWSwiOcRVd4loEgCh7RfPYqclIT7HI=;
        b=dyFtVrgDQT4HGJy7mwMP45yt9KHjTz1iQRKwXv3LXF6XVBP6QvKPhK5a9xIXPyLMDw
         leLdVFDUpOLOTReqFgDT58OlZ75HDlKZdzwlm1U2ypjwBF3jiBwm6BO0rFSJm0wzRf4X
         FzVAXsQ1UJ9i/P2T3PDei3AiIkkUBiHDXHZHyScUC+Dt7SsIl0XNZ5azUKayfCYBbzpt
         cQlNRgBHJQUm6bLg68dK2kyW3jP4Ax0QSHGcDdqYhvqfCmf5wSiS/14lrYNSVB530507
         RzvTcpwsPEzVfed8SHFbWVfgeqmgNC23z7jxeFFW9hvpJIOIPFw3UefaE944qYLHqGjp
         n0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721742314; x=1722347114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUdMWNOBxPL41aWSwiOcRVd4loEgCh7RfPYqclIT7HI=;
        b=dBY/q6MJgL5VYKR64yObu+ylpjgwBORytpSOBHP0Q7ASMbGPp+XTw8DMyRkE0CpY85
         YSDF3lx0REqEmwlWYbGu+9JNaph8742ic47iw9jdUJ7kDQ5ALo7hFcQK+djzP/cRTIfh
         3vAkvDoaIr0g3D61U871HDWva2AREvl0DdMJi8Fakjehn2jRNl/6HIlByJXWFuNp5SMo
         ggfuKiaIfMAr7AcSfcTgsBK0cqdhuAfJqs90QRD+jhRXFjv3fHqDWNDjAvDZRrRETraS
         sgb3XI/VSBPnjSCMR+TU7v/pvVsZAucFY0M/9k/39YZe+YeKS/bYmcQTaR7OPRruD9Ry
         8VIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVLwTFusJvi+iAb2YzZY20D1pcQwz+Ra6sJBw8GxUUap9q7h+5Iu0ljEGMdRFdbE9HRh0Hf9EJO9wnEs8PMjHyIMoGnfUws5Txqza2
X-Gm-Message-State: AOJu0YyCDi8OpP61prKbtPlLmlVer6m/Nw5iDyG5KZfdLOdK+D8Xw/xC
	oEOfoBTz5r+PLLTfgRSTBD2ytc4pRav8k8aMb94gJRo+Wbx+tU1JxNz/uw3HUDbjGyBd8p9zsh0
	pRRdnUVfSO4MnrN4V5u1cvMrC5kXyi/e8XF+t
X-Google-Smtp-Source: AGHT+IHE07qpK67Cz8iYBi6jnbzau27/24LxetDWy9auAduK98VBHyUDWeLTN4ggypdv1nYqnHsdiccef4R76g+qUzk=
X-Received: by 2002:a05:600c:5493:b0:426:6ea2:31af with SMTP id
 5b1f17b1804b1-427dc5753a9mr56168485e9.37.1721742314015; Tue, 23 Jul 2024
 06:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <CAH5fLghWQQfrKWFr+vd0B4YjxKwEd+pMV5zeiTCnRtX3_1oRYQ@mail.gmail.com> <4A1B4B2C-7FAB-4656-90AE-B30DC636349E@collabora.com>
In-Reply-To: <4A1B4B2C-7FAB-4656-90AE-B30DC636349E@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 23 Jul 2024 15:45:02 +0200
Message-ID: <CAH5fLgitm2qrGn3BBFyspmTD7Km+pp2qbvA9GN4fjyUnuWffWg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Danilo Krummrich <dakr@redhat.com>, lyude@redhat.com, robh@kernel.org, lina@asahilina.net, 
	mcanal@igalia.com, airlied@gmail.com, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 3:41=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Hi Alice, thanks for the review!
>
>
> >> +        fn alloc_mem(&mut self, size: usize) -> Option<*mut u8> {
> >> +            assert!(size % 8 =3D=3D 0, "Allocation size must be 8-byt=
e aligned");
> >> +            if isize::try_from(size).unwrap() =3D=3D isize::MAX {
> >> +                return None;
> >> +            } else if self.pos + size > self.capacity {
> >> +                kernel::pr_debug!("DumpAllocator out of memory");
> >> +                None
> >> +            } else {
> >> +                let offset =3D self.pos;
> >> +                self.pos +=3D size;
> >> +
> >> +                // Safety: we know that this is a valid allocation, s=
o
> >> +                // dereferencing is safe. We don't ever return two po=
inters to
> >> +                // the same address, so we adhere to the aliasing rul=
es. We make
> >> +                // sure that the memory is zero-initialized before be=
ing handed
> >> +                // out (this happens when the allocator is first crea=
ted) and we
> >> +                // enforce a 8 byte alignment rule.
> >> +                Some(unsafe { self.mem.as_ptr().offset(offset as isiz=
e) as *mut u8 })
> >> +            }
> >> +        }
> >> +
> >> +        pub(crate) fn alloc<T>(&mut self) -> Option<&mut T> {
> >> +            let mem =3D self.alloc_mem(core::mem::size_of::<T>())? as=
 *mut T;
> >> +            // Safety: we uphold safety guarantees in alloc_mem(), so=
 this is
> >> +            // safe to dereference.
> >
> > This code doesn't properly handle when T requires a large alignment.
> >
>
> Can you expand a bit on this? IIRC the alignment of a structure/enum will=
 be dictated
> by the field with the largest alignment requirement, right? Given that th=
e largest primitive
> allowed in the kernel is u64/i64, shouldn=E2=80=99t this suffice, e.g.:

It's possible for Rust types to have a larger alignment using e.g.
#[repr(align(64))].

>  +            assert!(size % 8 =3D=3D 0, "Allocation size must be 8-byte =
aligned");
>
>
> >> +            Some(unsafe { &mut *mem })
> >> +        }
> >> +
> >> +        pub(crate) fn alloc_bytes(&mut self, num_bytes: usize) -> Opt=
ion<&mut [u8]> {
> >> +            let mem =3D self.alloc_mem(num_bytes)?;
> >> +
> >> +            // Safety: we uphold safety guarantees in alloc_mem(), so=
 this is
> >> +            // safe to build a slice
> >> +            Some(unsafe { core::slice::from_raw_parts_mut(mem, num_by=
tes) })
> >> +        }
> >
> > Using references for functions that allocate is generally wrong.
> > References imply that you don't have ownership of the memory, but
> > allocator functions would normally return ownership of the allocation.
> > As-is, the code seems to leak these allocations.
>
> All the memory must be given to dev_coredumpv(), which will then take
> ownership.  dev_coredumpv() will free all the memory, so there should be =
no
> leaks here.
>
> I=E2=80=99ve switched to KVec in v2, so that will also cover the error pa=
ths,
> which do leak in this version, sadly.
>
> As-is, all the memory is pre-allocated as a single chunk. When space is c=
arved
> for a given T, a &mut is returned so that the data can be written in-plac=
e at
> the right spot in said chunk.
>
> Not only there shouldn=E2=80=99t be any leaks, but I can actually decode =
this from
> userspace.
>
> I agree that this pattern isn=E2=80=99t usual, but I don=E2=80=99t see an=
ything
> incorrect. Maybe I missed something?

Interesting. So the memory is deallocated when self is destroyed? A
bit unusual, but I agree it is correct if so. Sorry for the confusion
:)

Alice

