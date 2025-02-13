Return-Path: <linux-kernel+bounces-512362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B7BA33810
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B703A802C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0522207DEF;
	Thu, 13 Feb 2025 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Thtf4hO5"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54971206F2A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739428926; cv=none; b=UD1SQMP0Wztil89N1p/RnFFfsBlhCzjWfP4AbZbaHzA1NvPjcO6GDYByG/hCERw4fzBKbFE20c5NeInfuUsBbMCNIBtXJzkLZdUg/UTDAKD5Ohc/Mkk1Yxo8XuKvbmj6ApQdeY0Q4Vp2VwTL1Y5jDL/7BJMx7KS4VC5VGZ57+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739428926; c=relaxed/simple;
	bh=oTmB7Ig1eQii2PQt8Vq5KK5KdLNWvxjjdgsBUW1hd1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8xLx4/Fu4T+F+Q9UIe+3uZD20jbh8bfzeZryzP8w0cCt761yGv9YHK8MTnJIHoR6tRRnsxchatD2K/Av8qCgYS9MPGKlfcR7SO4dKzn8AkhGboKFiLDWLIQeKzKU4XxU8kAXMRyF44oAkunJMlqmlXEvuwdRE6cffHKnNqnMCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Thtf4hO5; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4bbeb009101so136335137.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739428923; x=1740033723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oTmB7Ig1eQii2PQt8Vq5KK5KdLNWvxjjdgsBUW1hd1Q=;
        b=Thtf4hO5DCGU3BEzEy00+Dy3ebWOuQt2rpooh0TWuYvocBm0Z9P818nDy+VXE8acj0
         2eAOTA96a6H9BoCElR6U/I0gmedIol0+F8eAuxBSkoFEsPjDt8J9U+P1MN86oHlsP8xr
         oqBwUYesQk7N+WAnaEM7kZAXWQsaBwXPyRn6S+u2125pgQEGd+Dlvi0nC3+YylM+KKBu
         5JC+Ws2XClqgtgjQ1ZhCQA0Yn/jAe4qa6rO8yyMcmPtBU4kVyffry7B1/aNNmjs+BBnU
         aiutxWKo99nbfF2YnxFAmAqHdtRCqUlq+Q9mN9r7BKXBLDlXiHkvtvnHfESrkwEskGrp
         XzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739428923; x=1740033723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTmB7Ig1eQii2PQt8Vq5KK5KdLNWvxjjdgsBUW1hd1Q=;
        b=rWOo+AI/PLXW8vW1EoKqKsU6KLfEKo+RK8YXj4TT4mTPJ/5jRHt22VZYKRxI9vSauQ
         MuheuXtAgW4CDBanBOIAgL9HbinG/GaiipcARIg2oNxR5ZvNpg0q1Ld57g7g0lwJBHvz
         li+XNZU8X6aRfE3DXSaAWtN6szIg/N5NbgLKO6LpoDOiKhIK1lbmGS5aVC2h7KmetwbD
         dXyKT0EhAjBNU3QB6aMmf+EmTmuMvoRQJTgoB9EZmPqf42PvvMJsDfVBpo8yz4ivrkca
         fedTCrT6/e2BkSpShIOejQhRchtYEm2frxjWajQSDMeDynuiQ1pRuPTSonu3QXdyt5Jz
         NxBw==
X-Forwarded-Encrypted: i=1; AJvYcCWSgjYkcLGNxBVKcVZeAkipBEpF2ueVDcvV398oS9BlOmZmTPRa20IhMjL29gTrpE1nrrC7u41fdCiLitk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqcxUGDUPxgz2ZsLtSdECE8u+IwGXzbVNjaqamGEi+JF0l6xog
	R1RDGBGCrALAFTR3duEBQaSA1RzM1bgTAwSmgoY+O5UJgO708A562ESgPR03TFL/kds6+rWJgFp
	sbvw0TifCKUKAXTekVsm9vpcmtVLuT6HB2UcukA==
X-Gm-Gg: ASbGnctfvUjcrx5WKNHnL2e9w4PjxxDyX/Xrf6ihH6geUbsYthOZJgFJwfxesIVaOGX
	Hh0LL8Cqjt1/DU1JnJ6oWWqYFcwvHxiBNxtIKfurttffGbNfMzsEWPbOcd17gYzr1hV/RUg6Mn5
	s=
X-Google-Smtp-Source: AGHT+IFhSui+oRYa0yiUwlfe4d8Dd+KjfAVoX7QGNMnwQAifah82de3Os5iBk5Pb0QFnrRe9uhZGgxrDA5ujKbbjaVg=
X-Received: by 2002:a05:6102:2c08:b0:4ba:eb24:fb06 with SMTP id
 ada2fe7eead31-4bc03562833mr2668789137.6.1739428923140; Wed, 12 Feb 2025
 22:42:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217100809.3962439-1-jens.wiklander@linaro.org> <20250212205613.4400a888@collabora.com>
In-Reply-To: <20250212205613.4400a888@collabora.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 13 Feb 2025 12:11:52 +0530
X-Gm-Features: AWEUYZkoZwXb13fMynlvth-g3hUZ-u2ftHq4Gn9B-5c6gMjO7S6PRx1iL7ELE6c
Message-ID: <CAFA6WYOaGEPj0xNEDBCoEmjJreEHChjQ2hyXRJ_CYoGhiBonfw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, linux-kernel@vger.kernel.org, 
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

Hi Boris,

On Thu, 13 Feb 2025 at 01:26, Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> +Florent, who's working on protected-mode support in Panthor.
>
> Hi Jens,
>
> On Tue, 17 Dec 2024 11:07:36 +0100
> Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> > Hi,
> >
> > This patch set allocates the restricted DMA-bufs via the TEE subsystem.
>
> We're currently working on protected-mode support for Panthor [1] and it
> looks like your series (and the OP-TEE implementation that goes with
> it) would allow us to have a fully upstream/open solution for the
> protected content use case we're trying to support. I need a bit more
> time to play with the implementation but this looks very promising
> (especially the lend rstmem feature, which might help us allocate our
> FW sections that are supposed to execute code accessing protected
> content).

Glad to hear that, if you can demonstrate an open source use case
based on this series then it will help to land it. We really would
love to see support for restricted DMA-buf consumers be it GPU, crypto
accelerator, media pipeline etc.

>
> >
> > The TEE subsystem handles the DMA-buf allocations since it is the TEE
> > (OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QCOMTEE) which sets up the
> > restrictions for the memory used for the DMA-bufs.
> >
> > I've added a new IOCTL, TEE_IOC_RSTMEM_ALLOC, to allocate the restricted
> > DMA-bufs. This IOCTL reaches the backend TEE driver, allowing it to choose
> > how to allocate the restricted physical memory.
>
> I'll probably have more questions soon, but here's one to start: any
> particular reason you didn't go for a dma-heap to expose restricted
> buffer allocation to userspace? I see you already have a cdev you can
> take ioctl()s from, but my understanding was that dma-heap was the
> standard solution for these device-agnostic/central allocators.

This series started with the DMA heap approach only here [1] but later
discussions [2] lead us here. To point out specifically:

- DMA heaps require reliance on DT to discover static restricted
regions carve-outs whereas via the TEE implementation driver (eg.
OP-TEE) those can be discovered dynamically.
- Dynamic allocation of buffers and making them restricted requires
vendor specific driver hooks with DMA heaps whereas the TEE subsystem
abstracts that out with underlying TEE implementation (eg. OP-TEE)
managing the dynamic buffer restriction.
- TEE subsystem already has a well defined user-space interface for
managing shared memory buffers with TEE and restricted DMA buffers
will be yet another interface managed along similar lines.

[1] https://lore.kernel.org/lkml/mzur3odofwwrdqnystozjgf3qtvb73wqjm6g2vf5dfsqiehaxk@u67fcarhm6ge/T/
[2] https://lore.kernel.org/lkml/CAFA6WYPtp3H5JhxzgH9=z2EvNL7Kdku3EmG1aDkTS-gjFtNZZA@mail.gmail.com/

-Sumit

>
> Regards,
>
> Boris
>
> [1]https://lwn.net/ml/all/cover.1738228114.git.florent.tomasin@arm.com/#t

