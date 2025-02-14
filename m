Return-Path: <linux-kernel+bounces-515003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2933BA35E82
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342F9189AA10
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C891264A76;
	Fri, 14 Feb 2025 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8be454q"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6EA2641CE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538448; cv=none; b=HuTx7YK36p6ZMPq7AsIewCgzo49hFO0zE1UpGm7lcwuR8tvWEP9bhtpoZAm9ign5T6O+e5AEi9EX8vgXYEr4xbnz5B5GuRtIydxeHPionuL2YClwCiRO6lEXgsKCqqoIrko9GZPcdlEMv1nzMTSzZTCq1xK3iGOMP2l5/8D2Hm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538448; c=relaxed/simple;
	bh=NXRz6jedmFY/bHyVZo7hYUPjarW9g7mwWvxKzc/RriM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQhTvvtaQuMdYdQbGugEn5LOJUs9Vb4gW58X3qapi7f8AtrwwsQliU9GcRi/EDltf1Vzaf2Tje88TtWxfXmb9lz35U76eyIGF8ds5mhdep8RoOw7lRMa7qkFXlYlgoxezMTQFvjKgnwnnODcgYak+liJu/2bHpWMU6RZsHVkA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g8be454q; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e46f491275so33614816d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739538445; x=1740143245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNnj7+IGvRtmWRtdYlqf7RvYRLfXlCqJXD/wP+Mfkkw=;
        b=g8be454qgUJpVQpGkA+R/3vLpIflxmNNWV3jSbmlcqYObvMEkTFnrY6bFY3ACVUDqL
         pYXWKvEjk4Lbk0/DcXg6faALUx4/zdrozRJDc3s6nzfPf0TBFCp2SpePME0nrR4L3QJj
         tLM22UiDYURTjmm1BevBQ9f9SHoLHzHwMlSCq4OdOkQFH0YWWSa+7NPzX/YLoASFCKXx
         aaXN499wJ23RYkLzwoMvXsQHmE7zYx5r6CJ+3fEMDC1xJiGCr+5Ku7ZDHbSuYCB35koR
         ma0la+AxKfbLTmgPtR931Tcwq/O590L9Dg311RHCzKEYUv5j86Vk1wuWlE4MX0mhXb3V
         Wt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739538445; x=1740143245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNnj7+IGvRtmWRtdYlqf7RvYRLfXlCqJXD/wP+Mfkkw=;
        b=qCnWS6UtSMqmOnoz3q1UJ85qxr4yst4bLWJdN2630xvCqVvRGfH+Of2LCpmjqvaFKM
         dI5BYCyUKKvUO+Vg+VCaQqZ6DbpFdBaU0WPee+Ck1DdBHT/QM/aoRkSZjm2/kKU/Yw/I
         YesBANLmz3jrmmsz2xeXgEbAzWw4rUrEBNwYDd1vlOdIzE/FW4+tVRocoq/y2rUeNtrt
         LDMiagqVuZZTZcO4vXfcgi+V+FHspCVOeLe4GKBKwL8XpTAzHO1FsOfYgURvohZSZQoX
         77l43fHG3uvvbBVCk8Syb29z8YyLq2euF3DwP+UIGLfX0wwRZQPZSaizrlz0bUDdW2Ed
         8wbg==
X-Forwarded-Encrypted: i=1; AJvYcCX8eGnWDhzF0ZSi89+6aMz6obEYbwgT0QzEPjT94t1jG4/PSiC0aFgFvGrxDDaXOh79tQP17Zaus2y32gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL721/mmGBhNPkL2aYzbjE55SPGXx3dTr4gMpUXfr7vee+9Itq
	u9q3fDLXGWyu9f6YDD5fsoLTeMM2P/XyJypArkjaMjJzFCD1DEk5V5sPR9koH9lat4eFxS3uDgh
	oZmrd32gMbKvu3IhPM80KCnppHbqaXPJDcV6PkA==
X-Gm-Gg: ASbGncuew3O+RfFIik1RHzpRDvkreDWNHDzK7sGx0acdzyTRiCtnjO7Ys8boAvl2xly
	f35nVuuP81b0oeLqI+4Wg9h55lkYnNk/lO4CiO07mvOFGoQU13/CQdgI6g4GJv1/66P9KMUFsaN
	c=
X-Google-Smtp-Source: AGHT+IE3ByM7DSgjLBAaQUp9tqk81OqGvrRN0VTqQ2J9pH/WZcBHm5+t6oEWmrDoJ+W5s9rNaAD7/fQhaTsa/R2yq4c=
X-Received: by 2002:a05:6214:469c:b0:6e6:6225:a907 with SMTP id
 6a1803df08f44-6e66225a975mr79026126d6.31.1739538445485; Fri, 14 Feb 2025
 05:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217100809.3962439-1-jens.wiklander@linaro.org>
 <20250212205613.4400a888@collabora.com> <CAFA6WYOaGEPj0xNEDBCoEmjJreEHChjQ2hyXRJ_CYoGhiBonfw@mail.gmail.com>
 <20250213093557.278f5d19@collabora.com> <CAFA6WYOJkSRsH-15QdqXNMd08Q=Dg4NkRd1Cr9LXA+5nozTF6g@mail.gmail.com>
 <20250213134008.4cbef142@collabora.com> <CAPj87rM5Y=-Jgf4mwukicF6Yb-vccn2fpG2X1jNq0upH2+cAEQ@mail.gmail.com>
 <CAHUa44G9hw-z6wzxg=HkVAxPKEW1yES5JTEqRWMvJUJAtcUDkQ@mail.gmail.com>
 <CAPj87rPHnME5Osgnf5-FSAu22mDpLj=dzvhi_NqEcOwr1ThgGw@mail.gmail.com> <CAHUa44Gs0D1fBD0=+EDgcQUMeDv4knci9trUkYEc1J98qFV7HQ@mail.gmail.com>
In-Reply-To: <CAHUa44Gs0D1fBD0=+EDgcQUMeDv4knci9trUkYEc1J98qFV7HQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 14 Feb 2025 18:37:14 +0530
X-Gm-Features: AWEUYZnJYqssuMMtIO5Ohg5UzNEocwYL0hODNzFGJUyN-biak0SnkML6hDkQjD8
Message-ID: <CAFA6WYOuTwRPEh3L7+hMyARB_E73xmp+OwhKyS-r4+ryS7=9sw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
To: Jens Wiklander <jens.wiklander@linaro.org>, Daniel Stone <daniel@fooishbar.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, 
	linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, 
	Florent Tomasin <florent.tomasin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2025 at 15:37, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Hi,
>
> On Thu, Feb 13, 2025 at 6:39=E2=80=AFPM Daniel Stone <daniel@fooishbar.or=
g> wrote:
> >
> > Hi,
> >
> > On Thu, 13 Feb 2025 at 15:57, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > > On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Daniel Stone <daniel@fooishba=
r.org> wrote:
> > > > But just because TEE is one good backend implementation, doesn't me=
an
> > > > it should be the userspace ABI. Why should userspace care that TEE =
has
> > > > mediated the allocation instead of it being a predefined range with=
in
> > > > DT?
> > >
> > > The TEE may very well use a predefined range that part is abstracted
> > > with the interface.
> >
> > Of course. But you can also (and this has been shipped on real
> > devices) handle this without any per-allocation TEE needs by simply
> > allocating from a memory range which is predefined within DT.
> >
> > From the userspace point of view, why should there be one ABI to
> > allocate memory from a predefined range which is delivered by DT to
> > the kernel, and one ABI to allocate memory from a predefined range
> > which is mediated by TEE?
>
> We need some way to specify the protection profile (or use case as
> I've called it in the ABI) required for the buffer. Whether it's
> defined in DT seems irrelevant.
>
> >
> > > >  What advantage
> > > > does userspace get from having to have a different codepath to get =
a
> > > > different handle to memory? What about x86?
> > > >
> > > > I think this proposal is looking at it from the wrong direction.
> > > > Instead of working upwards from the implementation to userspace, st=
art
> > > > with userspace and work downwards. The interesting property to focu=
s
> > > > on is allocating memory, not that EL1 is involved behind the scenes=
.
> > >
> > > From what I've gathered from earlier discussions, it wasn't much of a
> > > problem for userspace to handle this. If the kernel were to provide i=
t
> > > via a different ABI, how would it be easier to implement in the
> > > kernel? I think we need an example to understand your suggestion.
> >
> > It is a problem for userspace, because we need to expose acceptable
> > parameters for allocation through the entire stack. If you look at the
> > dmabuf documentation in the kernel for how buffers should be allocated
> > and exchanged, you can see the negotiation flow for modifiers. This
> > permeates through KMS, EGL, Vulkan, Wayland, GStreamer, and more.
>
> What dma-buf properties are you referring to?
> dma_heap_ioctl_allocate() accepts a few flags for the resulting file
> descriptor and no flags for the heap itself.
>
> >
> > Standardising on heaps allows us to add those in a similar way.
>
> How would you solve this with heaps? Would you use one heap for each
> protection profile (use case), add heap_flags, or do a bit of both?

Christian gave an historical background here [1] as to why that hasn't
worked in the past with DMA heaps given the scalability issues.

[1] https://lore.kernel.org/dri-devel/e967e382-6cca-4dee-8333-39892d532f71@=
gmail.com/

>
> > If we
> > have to add different allocation mechanisms, then the complexity
> > increases, permeating not only into all the different userspace APIs,
> > but also into the drivers which need to support every different
> > allocation mechanism even if they have no opinion on it - e.g. Mali
> > doesn't care in any way whether the allocation comes from a heap or
> > TEE or ACPI or whatever, it cares only that the memory is protected.
> >
> > Does that help?
>
> I think you're missing the stage where an unprotected buffer is
> received and decrypted into a protected buffer. If you use the TEE for
> decryption or to configure the involved devices for the use case, it
> makes sense to let the TEE allocate the buffers, too. A TEE doesn't
> have to be an OS in the secure world, it can be an abstraction to
> support the use case depending on the design. So the restricted buffer
> is already allocated before we reach Mali in your example.
>
> Allocating restricted buffers from the TEE subsystem saves us from
> maintaining proxy dma-buf heaps.

+1

-Sumit

