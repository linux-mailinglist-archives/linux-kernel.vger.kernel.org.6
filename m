Return-Path: <linux-kernel+bounces-538265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A875DA4966E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F621896DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B87D265CA3;
	Fri, 28 Feb 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h0YKAcRk"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423C25CC9A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736881; cv=none; b=MvWPbPQAnXYgQ7d7+H3u9DwTbiaIZ5wHa6Cn/oAPttBeglrB5+WmpXXct/Aiyj6aX06RaoiYckxeq2GsRxVqYvn+s6niqwYoQjAdi091eOitT+f3r3vS+zFobfU9ELygygAmVfeIMPlkdX7xd8ye2aIl26J8iqBrM37Rf6L5HTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736881; c=relaxed/simple;
	bh=2rXI3ClDmBMPb/nTHq47U3JbT34v5Vk5CODpFCMD7go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FS054uhBRqswgV/7cWzoaxrP28snDf4G6Ra45qmCGMxMLljXg5oVf0WBkuzXJNE4kDYBVKICq0SbZH3+aTItE/vpW5NqtZMIFTMZCQgzvsQijGzCb8/aOmmp0G28Ra77sMyEU9698zPGPdqnPioqDxF+KNjUfcnak/JyENKzV64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h0YKAcRk; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e0373c7f55so2852213a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740736877; x=1741341677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rXI3ClDmBMPb/nTHq47U3JbT34v5Vk5CODpFCMD7go=;
        b=h0YKAcRkwDRU0QkLcB3rfKAsZ8b+Z8++KE2dkuP3IOB1T8okZMlmGWKFR+sPPv/Qdq
         N+GwIvFPa0NXSm53a5Io/5XH52c0mMIzvgjav+gFPm/x+KKs8NZWY/F6yWfBzqM6Mosz
         ggJ7KyAydSan+LmPyWI6CnyIjRa8mKBGwStMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740736877; x=1741341677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rXI3ClDmBMPb/nTHq47U3JbT34v5Vk5CODpFCMD7go=;
        b=FxIpMJ4bbCn6B9Xh8TqA95BQhZu5JXNGsyTJKhWU0oakU0nE0yUaC838V3Kx1iBoXi
         WumaVKWx4dvVAxukASXkUXObFQ8zu5bUGCa/MM7b8FC8E+sQGz9jdoi6S3isqRhCgWyn
         kN8fw5UfwCRL94REh0VQmbqi3/XI6MLXRkw4LzhDoiOpBAKT0juYvl/NrPElV4rULKT2
         QqUnh/QtEqWMuXNfvvbWgwLdlC4JOeAozgGyn2auEoIMmwsBOVFi09xL68THr6WouTzw
         p92xHnQTSHSTBGaVVbB/3uYxbQ2BuTQsm/68cFbFfgPGTQI3/Vx3JRnL5EbV6RJ3Pvxs
         eZjw==
X-Forwarded-Encrypted: i=1; AJvYcCUwPWsUoK0G/GOya602LKzbPbm8nWTHV11fN0ac3m8JmCHIPGSNpi18nUdk3O0Rgcvq1VA+CQmDzldUfpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYbFB6sm8B6VZwpyyE+b26jATTKJ7fF8VYQAtL15sZd/K58rSy
	4n0xToSmask/2krd4/LNBWCCNdbJwedrsJooXTxgvaaFwwedFIU6glUKO8sMEX6nu3jbsbuyY6E
	=
X-Gm-Gg: ASbGncuQWLKtCPdAfvw9VzKG3pJ2XxnTlE7aY63idMFiIrHbYVo3Y9y7I0rzPrH4Ix8
	45vGb0XWuEEWMTjXLaMIOPqsAb9/0Y4QEmqvaxyBd2l30tAOr84YEzQ88TRyqSmxggPrZRrjF6t
	jCzlmEflZYYJrVKAjty5uyHaCZmagruWWGsE1Nq6pXFSt9w9yMKrUGWlElOFE1f6VrGywU3P6xV
	rO7lqwwaqfwQtM5wsGMV9YXW2SM3f+eFZ+COqJ93JVn25aHbwn+QPT7/iy6IHREDVu45Hb0+rzB
	ou7bqq3sR979e/PHhZtLz1lWxevWArb5dWCn3PKwzv5SchATqDtSP7hhwXy/nA==
X-Google-Smtp-Source: AGHT+IEbYRrbirRp09ZvXEXnr8M0yB962oL4EF1znlSwjeo1uJvDDJZFb5Zy9yO1UpKJUK3ayb2NHg==
X-Received: by 2002:a05:6402:5188:b0:5dc:c531:e5c0 with SMTP id 4fb4d7f45d1cf-5e4d6b83d0emr1847963a12.27.1740736877350;
        Fri, 28 Feb 2025 02:01:17 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb66fbsm2266991a12.37.2025.02.28.02.01.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 02:01:16 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e05ac70b61so4482a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:01:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYPp0bxs0Nok5Kyao95ujaq2KiSOb82/8t8R1Lso8LYM0sHUlxWnHPgGWehJYrrgZW82038KXqu7u0klc=@vger.kernel.org
X-Received: by 2002:a50:ee06:0:b0:5e5:7c1:43bd with SMTP id
 4fb4d7f45d1cf-5e507c1454bmr6895a12.1.1740736875259; Fri, 28 Feb 2025 02:01:15
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102-b4-rkisp-noncoherent-v1-1-bba164f7132c@gmail.com>
 <20250103152326.GP554@pendragon.ideasonboard.com> <87bjw9s4s3.fsf@gmail.com> <dtfv2slbtj3ar2wvlcnd74p3xtlvggebkk3fj5ocm3eil7kyqw@al3brwf4y5dw>
In-Reply-To: <dtfv2slbtj3ar2wvlcnd74p3xtlvggebkk3fj5ocm3eil7kyqw@al3brwf4y5dw>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 28 Feb 2025 19:00:57 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DS2x3sX59EdkTEMuO=eXc=Q0jD44EUwMisP6ocWz11qg@mail.gmail.com>
X-Gm-Features: AQ5f1JocdLsXSFHYJ8IXhWDm1nRVG8G1TcpnZe42kpdJDZJxd7C4Oq_p5gzB7_w
Message-ID: <CAAFQd5DS2x3sX59EdkTEMuO=eXc=Q0jD44EUwMisP6ocWz11qg@mail.gmail.com>
Subject: Re: [PATCH] media: rkisp1: allow non-coherent video capture buffers
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mikhail Rudenko <mike.rudenko@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dafna Hirschfeld <dafna@fastmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jacopo,

On Fri, Feb 28, 2025 at 2:11=E2=80=AFAM Jacopo Mondi
<jacopo.mondi@ideasonboard.com> wrote:
>
> Hi Mikhail
>
> On Tue, Jan 14, 2025 at 07:00:39PM +0300, Mikhail Rudenko wrote:
> >
> > Hi Laurent,
> >
> > On 2025-01-03 at 17:23 +02, Laurent Pinchart <laurent.pinchart@ideasonb=
oard.com> wrote:
> >
> > > On Thu, Jan 02, 2025 at 06:35:00PM +0300, Mikhail Rudenko wrote:
> > >> Currently, the rkisp1 driver always uses coherent DMA allocations fo=
r
> > >> video capture buffers. However, on some platforms, using non-coheren=
t
> > >> buffers can improve performance, especially when CPU processing of
> > >> MMAP'ed video buffers is required.
> > >>
> > >> For example, on the Rockchip RK3399 running at maximum CPU frequency=
,
> > >> the time to memcpy a frame from a 1280x720 XRGB32 MMAP'ed buffer to =
a
> > >> malloc'ed userspace buffer decreases from 7.7 ms to 1.1 ms when usin=
g
> > >> non-coherent DMA allocation. CPU usage also decreases accordingly.
> > >
> > > What's the time taken by the cache management operations ?
> >
> > Sorry for the late reply, your question turned out a little more
> > interesting than I expected initially. :)
> >
> > When capturing using Yavta with MMAP buffers under the conditions menti=
oned
> > in the commit message, ftrace gives 437.6 +- 1.1 us for
> > dma_sync_sgtable_for_cpu and 409 +- 14 us for
> > dma_sync_sgtable_for_device. Thus, it looks like using non-coherent
> > buffers in this case is more CPU-efficient even when considering cache
> > management overhead.
> >
> > When trying to do the same measurements with libcamera, I failed. In a
> > typical libcamera use case when MMAP buffers are allocated from a
> > device, exported as dmabufs and then used for capture on the same devic=
e
> > with DMABUF memory type, cache management in kernel is skipped [1]
> > [2]. Also, vb2_dc_dmabuf_ops_{begin,end}_cpu_access are no-ops [3], so
> > DMA_BUF_IOCTL_SYNC from userspace does not work either.
> >
> > So it looks like to make this change really useful, the above issue of
> > cache management for libcamera/DMABUF/videobuf2-dma-contig has to be
> > solved. I'm not an expert in this area, so any advice is kindly welcome=
. :)
>
> It would be shame if we let this discussion drop dead.. cache
> management policies are relevant for performances, specifically for
> cpu access, and your above 7.7ms vs 1.1 ms test clearly shows that.
>
> >
> > [1] https://git.linuxtv.org/media.git/tree/drivers/media/common/videobu=
f2/videobuf2-core.c?id=3D94794b5ce4d90ab134b0b101a02fddf6e74c437d#n411
>
> I would like to know from Hans if the decision to disallow cache-hints
> for dmabuf importers is a design choice or is deeply rooted in other
> reasons I might be missing.

When DMA-buf is used, the responsibility for cache management is
solely on the CPU users' side, so cache-hints don't really apply. It's
the exporter (=3Dallocator) who determines the mapping policy of the
buffer and provides necessary DMA_BUF_SYNC operations (can be no-op if
the buffer is coherent).

Best regards,
Tomasz

>
> I'm asking because the idea is for libcamera to act solely as dma-buf
> importer, the current alloc-export-then-import trick is an helper for
> applications to work around the absence of a system allocator.
>
> If the requirement to disable cache-hints for importers cannot be
> lifted, for libcamera it means we would not be able to use it.
>
>
> > [2] https://git.linuxtv.org/media.git/tree/drivers/media/common/videobu=
f2/videobuf2-core.c?id=3D94794b5ce4d90ab134b0b101a02fddf6e74c437d#n829
> > [3] https://git.linuxtv.org/media.git/tree/drivers/media/common/videobu=
f2/videobuf2-dma-contig.c?id=3D94794b5ce4d90ab134b0b101a02fddf6e74c437d#n42=
6
> >
> > --
> > Best regards,
> > Mikhail Rudenko
> >
>

