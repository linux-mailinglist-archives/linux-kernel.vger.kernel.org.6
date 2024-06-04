Return-Path: <linux-kernel+bounces-200964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DD88FB779
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6211F29A68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B58144D23;
	Tue,  4 Jun 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okCS6UOQ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA199BE4A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515243; cv=none; b=o9jLN8YSc385MlG6I5EmsyLYe/GOttf1zgs6FHOA9/IVRnnsWM5kzRFm+SyM+5Ytd3ZznQcVnKXnI8yjpar0yEocCr9WzPED4ahLcTtZ6SYCkc4T4qOHW+RhSyFTdjHXpbPO/2tuaHpCZM1FESvdKbZd78i4MN5PZF4N9tfvNDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515243; c=relaxed/simple;
	bh=0gkxDEDNZebYl39ZT7lT0Mi1PYh+9m7VTOYWw+I09lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCSTUlTFTd83AsXCVoy++UyeE+e5mILPIwfQtokXvfozZiNyqVEUef5ELUaftwB0Lp9XnJgmwPnWVK2QiRMAa7Jdn+pFEkrpr2eOJQu7ZQ3D7O4AMQLnqC8HY94j9P/bZGI4iEDsTZhjNxWE5nz21dsczspRkZOGL4Jqp4n6p+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okCS6UOQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4213a2acc59so104535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717515240; x=1718120040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPrZTWhMGfW1Op6H/y2W3cwWgY4x9WIkaqKqTA6XOsk=;
        b=okCS6UOQwijySB0DKl3VKVbyV3JOUdUipFxjnDf4H2Bqk8rsNzILpX+VWyMvs5bKZq
         h6+fSHMvdboaYBswAgysRpEpNBI2v17xVeWjlvJ6SJModGV2DN8Rvhhbb40x/7jwDwmT
         E7fp3aNLpWx9355j/ecvl8uo9Sw7TZ+VhwbP8R3kWojCciorYoL3vjmy1n4d/bXEzsSs
         Q0OA+YviN5rxEHL9xWhnznPdTGMiQOgPD/TQwUMfAgh+zxC3fQd7YfS3fIFFiJF4Iowj
         9xWBVJnbJiWllQpHAa+O16PG1uscH/czYPiICDzZZhPZg6uxUuOwGFwEmEm2Gjw+YUhB
         xckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717515240; x=1718120040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPrZTWhMGfW1Op6H/y2W3cwWgY4x9WIkaqKqTA6XOsk=;
        b=uQ8UMVyOjzDd1gWHcu4YYYE0JrsFC7Ga8wNMV95H/+Jpf8ScmJ0UABzeO5EqkvtE9E
         7NI5rBf3xKV9m8TjgB4bEw3rZYZ5HyefDDLJYGpYKe4KPg7dNHKKmPd2leTAqYb0qOg3
         nZB8gDrl4XhcAQjFbTgxZdxmbRgl8KNj6i6aOhO9cr8osWi6j1NepEO7dKHOypeHzr1x
         CxThwO1T+f4UjFf/2QwTW7shFcsP5106TmiED+1UZs8jO0LSqbemKjNypA4UIhd1oWvE
         rQGPX2sIGMc8DsNGtKZtqELpImrwbGVV1NnqNEP8f9rNQi/O+UEzPqzGFYHkF8DgND1N
         CrGw==
X-Forwarded-Encrypted: i=1; AJvYcCX35UsunDBkYJtxp6fa2t8j3v82sbM7kNNgh7mU1IL4VQYJsvUkxwOwkU4i3Vk+h1033k+X/1DiAp7ANqiOZjSz165xGhmMm1jJaPKx
X-Gm-Message-State: AOJu0YwGTn0qJ5UWdbolHa6rwO2dFGw5yDGvZ2Q1q8mVRX0AznEdKcEH
	Obeq1JQLuI4SYo9+6Ym8WIt1m6EleECwF1qx2Lf5Vtf1RelHXH8hkc5b/wLy1IdV3xcFL6Bd3Mx
	jphC79wZB1CVIp8ILtImLrp0URdRsOGN++4A=
X-Google-Smtp-Source: AGHT+IGgt6qVmKsMEINkAA4HYjs0uN2WeNDrPuAe6rAIuy/AuDyc36S0WKxfN4JyUkzqKUjfzg5pNUGXlPz9X67UZxY=
X-Received: by 2002:a7b:ca46:0:b0:41b:8715:1158 with SMTP id
 5b1f17b1804b1-4214947b20amr2777065e9.6.1717515240106; Tue, 04 Jun 2024
 08:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603114008.16235-1-hailong.liu@oppo.com> <CANDhNCq50zPB+TS+_Oo0HY0aUuBAdik2KrC8eJRTygbis293sw@mail.gmail.com>
 <20240603172148.gb7txpg2ya43jyxn@oppo.com> <CANDhNCrwgce7G5_-4tNfgTHcdL12zt3JKBg=o3bHrzMmfFMctg@mail.gmail.com>
 <cff79c75-4c9c-46e0-a3ac-b9c0e8cad6f0@oppo.com>
In-Reply-To: <cff79c75-4c9c-46e0-a3ac-b9c0e8cad6f0@oppo.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 4 Jun 2024 08:33:47 -0700
Message-ID: <CANDhNCq1O9T6WxCpe9yNBycMu7U0SCVYBdW3R=J8jEqyqWYCiA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] dma-buf: heaps: move the verification of
 heap_flags to the corresponding heap
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	"T.J. Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	21cnbao@gmail.com, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 11:30=E2=80=AFPM Hailong Liu <hailong.liu@oppo.com> =
wrote:
> On 6/4/2024 2:06 AM, John Stultz wrote:
> > On Mon, Jun 3, 2024 at 10:21=E2=80=AFAM Hailong Liu <hailong.liu@oppo.c=
om> wrote:
> >> We now aim to improve priority dma-buf allocation. Consider android
> >> animations scene:
> >>
> >> when device is in low memory, Allocating dma-buf as animation
> >> buffers enter direct_reclaimation, longer allocation time result in a
> >> laggy UI. But if we know the usage of the dma-buf, we can use some
> >> mechanisms to boost, e.g. animation-memory-pool.
> >
> > Can you generalize this a bit further? When would userland know to use
> > this new flag?
> > If it is aware, would it make sense to just use a separate heap name in=
stead?
> >
> > (Also: These other mechanisms you mention should probably also be
> > submitted upstream, however for upstream there's also the requirement
> > that we have open users and are not just enabling proprietary blob
> > userspace, which makes any changes to dma-buf heaps for out of tree
> > code quite difficult)
> >
> >> However, dma-buf usage identification becomes a challenge. A potential
> >> solution could be heap_flags. the use of heap_flags seems ugly and
> >> contrary to the intended design as you said, How aboult extending
> >> dma_heap_allocation_data as follows?
> >>
> >> struct dma_heap_allocation_data {
> >>         __u64 len;
> >>         __u32 fd;
> >>         __u32 fd_flags;
> >>         __u64 heap_flags;
> >>         __u64 buf_flags: // buf usage
> >> };
> >
> > This would affect the ABI (forcing a new ioctl number).  And it's
> > unclear what flags you envision as buffer specific (rather than heap
> > specific as this patch suggested).
> >
> > I think we need more details about the specific problem you're seeing
> > and trying to resolve.
> This patch mainly focuses on optimization for Android scenarios. Let=E2=
=80=99s
> discuss it on the issue website.
> Bug: 344501512

Ok, we can do that if you need.

But if this is ever going to go upstream (and it's more and more
important that we minimize out of tree technical debt), conversations
about how to generalize this will need to happen on the list.

thanks
-john

