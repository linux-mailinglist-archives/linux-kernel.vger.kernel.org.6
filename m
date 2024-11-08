Return-Path: <linux-kernel+bounces-402232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8404F9C2549
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AAF91F251CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B191AA1FC;
	Fri,  8 Nov 2024 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KD24XlpR"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5AA233D88
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092496; cv=none; b=BFtoVnxegcD8mVS6dxPXNuV0xyRlE3LsFAjigQZYb/Lo6qCmGgO6KsT0wV/A3/ptLxX0Ilq9Ijf1Bcvj5D2K2+8AcDAVw6CAXEy4EQS0rqoYd4m0i9G4ChDvrJhu/diNcqDKsME976YKbLHpTB6XvI0/0qrV42CQ8bYUS67wh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092496; c=relaxed/simple;
	bh=9YZfKkm5Xm6q9I83U7E2uBCjStEOALP97yzB7VUmGcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkF+c0aombiNEIwTFD7duf3kCZ2uAnZD+lw18penL9a4FHPiR/AnR0MtYtQcGxV1mDhBJtzGxg3BaZYGxEAw5JdA5Foj3fPYLpZtCi8cLfxG4WJpzAVSP5gfbC7AkqJc/BCC5eH8i5k59sXmHapTRfewxqHqV/vqwwz5DrajsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KD24XlpR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460b295b9eeso20491cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731092493; x=1731697293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YZfKkm5Xm6q9I83U7E2uBCjStEOALP97yzB7VUmGcM=;
        b=KD24XlpRl3Pm7Dj4QP6974TPlX1Ar0QMz9wm4bEp7tRaeK2Wp6Wux69899rqa+g3o/
         ESjbuw4ICbpih5El4EOwtDpQr/Mi2wYyUmiy/hKghsJI8AEyLO4wrSf9WRhVqRNSmtVC
         sFONd9u3tEZTfYvLvpRiFvvEbTkzoalwBdg/DGa7tdm5z9qHEOqDY8UvaqhyMt2i23WH
         1VHgDMHhytK02MsF/pHlNBX57rJUpiRHPRImky/kb9RSvn3U+K2S1jQPH50Ph4VpdPI5
         rkVxedQYZVZzvbmm15/nW1NFUMFAkciaky3N390vSWsF6lZkdAJA8GYNXLp0O8++m09c
         pgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731092493; x=1731697293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YZfKkm5Xm6q9I83U7E2uBCjStEOALP97yzB7VUmGcM=;
        b=gYUMg8Bpki4hQOWZgiGYEX1WCpldRX7dlrsufExet0qJ3PCe/KzQL9ZH7TUWXqAU19
         /y0h4ctBl8W/O9SGtJFBi/KiF733R6Cu00ajZvtPJJD6xRzu/2dQtDqFyRHxlwpgz4VM
         YX+7mCbPlbSqkdRRg2c6l2UdQJ4bitAB2cgJ855OVCOxWjXGBvr9UVek7cQXFNovo8ZS
         IOQzcxwhbJYngqT27rirBNCnGGfNIT4BGeKwQ6GlpxMERnxTFdS/Ug5cGjNwfrKzsxcH
         DSW5/xFWXGFNTBqjgNx3N69gJguxiyzgMZgp6+ADpkOd+8E6+Zcl0x4wuWvYZOt+jv6D
         jR8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSJDuM3Ck6YBkafNkDpS1xMYQW7SrkLn1IN+vkx3Ppo85jhquDhhkqK9ssGJW5MdWjFRscY6hKPuwBXOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6lrfSJdUOmOWpQlpmx3VHFSThl8O51iYrc8Z/J0K8rSlEQbnt
	MeLWllH8dpUPEsFwc5iMnZewcPLyf0e3Ev9p2TQ1UqOj+iCisW2m331P8nN3r7S8nAfqDtQtM54
	m+tMj5z0AxR/YND0/x74jSt73DklhdNycw6Od
X-Gm-Gg: ASbGncupqitfwamFgvxGhkHx6cKXsmIzgk24j94NCFjavqIudYwapCsV8pCphSusB2I
	JXu8inSPCOVrMZcLofA9MK5XDiNIIL48=
X-Google-Smtp-Source: AGHT+IGbCOeS+ZcoLeCOyqoYJYL1pCl2h+4gAy3C9to8d+om3vHCWullkz5bf7ktdN0S0DGx2SXYCBFb4aR0ASs0DRw=
X-Received: by 2002:ac8:5e14:0:b0:462:c96a:bb30 with SMTP id
 d75a77b69052e-4631695f5d9mr163721cf.2.1731092493297; Fri, 08 Nov 2024
 11:01:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107212309.3097362-1-almasrymina@google.com>
 <20241107212309.3097362-5-almasrymina@google.com> <20241108141812.GL35848@ziepe.ca>
In-Reply-To: <20241108141812.GL35848@ziepe.ca>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Nov 2024 11:01:21 -0800
Message-ID: <CAHS8izOVs+Tz2nFHMfiQ7=+hk6jKg46epO2f6Whfn07fNFOSRw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] page_pool: disable sync for cpu for
 dmabuf memory provider
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 6:18=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Nov 07, 2024 at 09:23:08PM +0000, Mina Almasry wrote:
> > dmabuf dma-addresses should not be dma_sync'd for CPU/device. Typically
> > its the driver responsibility to dma_sync for CPU, but the driver shoul=
d
> > not dma_sync for CPU if the netmem is actually coming from a dmabuf
> > memory provider.
>
> This is not completely true, it is not *all* dmabuf, just the parts of
> the dmabuf that are actually MMIO.
>

Thanks Jason, I can clarify the commit message when/if I send another itera=
tion.

> If you do this you may want to block accepting dmabufs that have CPU
> pages inside them.
>

How do I check if the dmabuf has CPU pages inside of it? The only way
I can think to do that is to sg_page a scatterlist entry, then
!is_zone_device_page() the page. Or something like that, but I thought
calling sg_page() on the dmabuf scatterlist was banned now.

But as others mentioned, we've taken a dependency on using udmabuf for
testing, so we'd like that to still work, we probably need to find
another way than just blocking them entirely.

I'm thinking, we already use the dmabuf sync APIs when we want to read
the udmabuf from userspace. In ncdevmem.c, we do:

sync.flags =3D DMA_BUF_SYNC_READ | DMA_BUF_SYNC_START;
ioctl(buf, DMA_BUF_IOCTL_SYNC, &sync);

Before we read the udmabuf data. Doesn't that do the same job as
dma_sync_single_range_for_cpu? I'm thinking dmabufs with user pages
would work as long as the user calls the dmabuf sync APIs, so we don't
need to block them entirely from devmem tcp.



--=20
Thanks,
Mina

