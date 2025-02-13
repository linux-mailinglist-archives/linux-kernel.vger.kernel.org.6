Return-Path: <linux-kernel+bounces-513597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD448A34C25
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AA87A2ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6204B211A36;
	Thu, 13 Feb 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="cXbg4Xsg"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEA9221700
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468388; cv=none; b=efI2Ux3Ovo/B4TxSBCyaPhBxwIDBEq4Nv4Tf1fvwegvOI4XkUGWkrU6mTq35moQ9+QuhpHQkWTxMqwRCBXymT0ESaQn+6Ho3Y0kLt5W1BOlnx/ijb9nXKNKppBjxnwWv05qFdrMSAyQbObnm8Rij8hSxZVW69mHKn39XKvXgXto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468388; c=relaxed/simple;
	bh=6ZpVr1zXfeW4p4aAqTJktWD02PA9u9B2cOeDG/0jTAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EM99+N7yqQA7+lAb8sYD5+fOBnDrYZ1cS84hqSh4Wic5dY/C9SwoLDFdPjmUvhUwBLelZ0kqY15AU71PYyJPkES1W4NHHTbst5ys3slSOL4E2iRfdeN1N6XKw/5kNdWlnAvEg+mKwKAMhMrPNKd3T/53Vz8avLbQKuFZbM/Ce18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=cXbg4Xsg; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4717fe0735fso12028991cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1739468385; x=1740073185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whhYbCC8Ye/92zXnbL6IJWDNwsx8j4boIogQLPts9MI=;
        b=cXbg4XsgzmZTXsu7KJQYatRLkjyHCTikDhbFGnU/GtiLOp0SJ1Q0a2uj1CZwmYhzlv
         pFG7b5yz9tlOyM7H1Vz3kRjnj5x5D+gNqVOQfLhzo7cguPOqeiE4h0r/ICI+0PXjIqPw
         lnug7O0t1SxrBTg3kE3hX8EHfw8W/4m1IxfCGnNDR48KlbgYuPdOL/Hp+UciDsPj4BOa
         Q31247c1kORCInSC0Dud/C9GIfNVXMJdZqBsHvZm6aTr8tEGb4nXyp2DBAVw2zSXZ/sL
         Qe4Fg0TuaKODvbRpeQtgWZIRDBbwlZN4QQ5HuIMI05kr37DEvafZhDAZvSAlVV4v9UNg
         5qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739468385; x=1740073185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whhYbCC8Ye/92zXnbL6IJWDNwsx8j4boIogQLPts9MI=;
        b=YgRfaNona5A/OBz8AauU53IaNI0wfd9gKz00QCQjCZIYsMYrnBjemHYd3lF12p4jYy
         9cBJbhj3KbLT2uRTH3m+FQP34R/hqP1w0YxcCaBqxynsqRh5LSkYKEABk65vr3MXK1FZ
         GJ5WkJgFipU+pRrPjtOqSfqVsBBJRwN8Ue1e4ozyaJB8OBS7/SXi0/375OH9UyU2OnIu
         TTJI/yX6Y3tuucmu2BWS9GhC9rZ6O+Fh455duroNMmIJgaZEYYPrIZqIwnJKZFtrVRfq
         Ew3s75oKBhwrp5ST6LbRvd0geYNQajGWbeLK+QcLxoADjPwcLgff9M3LZiLg7Kb4fRis
         uEiw==
X-Forwarded-Encrypted: i=1; AJvYcCWmXKcatDUWxYD1p7fwV/tTzno3LjpMljR37k4ejAOBzfroyDo2FCQpay7Dz9d/5HBe5Hqtp9vk57MUXDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/xSsLBd+PK0XbxQJz/sSyzDvoFm9TTlioT85awerPrXJKWwzy
	CY9Thu5qEW2TAQDdlCWdgQnGR+7aa22mme8WOPioXrUUhD9h363LfRzJPKmZhFdTgRyUEsayIWg
	ESofF8HGBka5Vm0Pm+YOCjytAGDXPgVNVUPDJsw==
X-Gm-Gg: ASbGncvdybjHd2tr1ObN49Mfr9LKHoJW+5U2YLhGytYvHzAPBgkvKE4AJT76Ugn109R
	W/04LCXeNJPb9dVFyv58Olesn39JcNlxneic+AeWEgYZ4WL7bInPFJ1LEaCIlDGJdwKzf2EM=
X-Google-Smtp-Source: AGHT+IGE9qUAgteAk42h8NRzlwUiEVQLmyQkmiwetNHn7TWQ4JRreBJYCr8hrD0N2jIsyDYrKQ939hR7SXW12F654hE=
X-Received: by 2002:a05:622a:418e:b0:471:bd5e:d5dd with SMTP id
 d75a77b69052e-471bd5ed804mr90077321cf.16.1739468385599; Thu, 13 Feb 2025
 09:39:45 -0800 (PST)
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
In-Reply-To: <CAHUa44G9hw-z6wzxg=HkVAxPKEW1yES5JTEqRWMvJUJAtcUDkQ@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 13 Feb 2025 17:39:33 +0000
X-Gm-Features: AWEUYZlDafBpFokqUpKbJAhQu7Ep0JLs4xPUNmdO9fz5XX0E98BWFTHCpoumcPo
Message-ID: <CAPj87rPHnME5Osgnf5-FSAu22mDpLj=dzvhi_NqEcOwr1ThgGw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Sumit Garg <sumit.garg@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, 
	Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, 
	Florent Tomasin <florent.tomasin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 13 Feb 2025 at 15:57, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
> On Thu, Feb 13, 2025 at 3:05=E2=80=AFPM Daniel Stone <daniel@fooishbar.or=
g> wrote:
> > But just because TEE is one good backend implementation, doesn't mean
> > it should be the userspace ABI. Why should userspace care that TEE has
> > mediated the allocation instead of it being a predefined range within
> > DT?
>
> The TEE may very well use a predefined range that part is abstracted
> with the interface.

Of course. But you can also (and this has been shipped on real
devices) handle this without any per-allocation TEE needs by simply
allocating from a memory range which is predefined within DT.

From the userspace point of view, why should there be one ABI to
allocate memory from a predefined range which is delivered by DT to
the kernel, and one ABI to allocate memory from a predefined range
which is mediated by TEE?

> >  What advantage
> > does userspace get from having to have a different codepath to get a
> > different handle to memory? What about x86?
> >
> > I think this proposal is looking at it from the wrong direction.
> > Instead of working upwards from the implementation to userspace, start
> > with userspace and work downwards. The interesting property to focus
> > on is allocating memory, not that EL1 is involved behind the scenes.
>
> From what I've gathered from earlier discussions, it wasn't much of a
> problem for userspace to handle this. If the kernel were to provide it
> via a different ABI, how would it be easier to implement in the
> kernel? I think we need an example to understand your suggestion.

It is a problem for userspace, because we need to expose acceptable
parameters for allocation through the entire stack. If you look at the
dmabuf documentation in the kernel for how buffers should be allocated
and exchanged, you can see the negotiation flow for modifiers. This
permeates through KMS, EGL, Vulkan, Wayland, GStreamer, and more.

Standardising on heaps allows us to add those in a similar way. If we
have to add different allocation mechanisms, then the complexity
increases, permeating not only into all the different userspace APIs,
but also into the drivers which need to support every different
allocation mechanism even if they have no opinion on it - e.g. Mali
doesn't care in any way whether the allocation comes from a heap or
TEE or ACPI or whatever, it cares only that the memory is protected.

Does that help?

Cheers,
Daniel

