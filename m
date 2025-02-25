Return-Path: <linux-kernel+bounces-532569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9892DA44F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDAB1888745
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001432135A0;
	Tue, 25 Feb 2025 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="MGmORMnX"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F8213256
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520760; cv=none; b=LqZxLpS8948DO9EbPTKP7FhKRKie0aUQDUF8HzCK0xVWaQ+Hljt5mcSLuscHD59YslJMY82vjkQL48M+3Vqdj1e7CAzUVw9YiXY8OmhfJKZS2yvYYsWYTbjViOpUfQ8EZPcuuaoyle9XwWR+RFSkLzaeSHzMwRQqO1T2QRXKr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520760; c=relaxed/simple;
	bh=lhlRVTyXQdUVVfNqKiQrllxx1N3vzrAL5haFxdHIUL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDglES39QcJ8YkSirmJUuNswElA7y9O/ba81J9FmRzW8G+qUVjluWEaWUoK4VOPaGr1oHB3gjGvQzt7UoK14vbWvhIYS0G8mCV3L0ruQSNJ2UQ6+eOfU5u8r9m339daS2e78ZW0X97OksfwwWa/8EyKrgTvGqwj7y43oJzjvEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=MGmORMnX; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c0c5682c41so422818185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1740520757; x=1741125557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lhlRVTyXQdUVVfNqKiQrllxx1N3vzrAL5haFxdHIUL8=;
        b=MGmORMnXIEUkVIeyRQhMJ/3DoyWUOme+DrF2ZO0qhOQ+0v7fykiV163UOnsDhWEXjc
         xBytLhtpN7LztkmrA+bduQVw+j1x5pW+OWW2O5kkL/AGLYRiokziTPs29i2U252j0oVd
         zEw6zbHwGpD9IojvjXIve+hWafmVY3Hq8nGjQbzFQBOr/25NwBMDDw6rp8k0AFK0FAyf
         wPWgkgwat48CHmS/Zn5Ve0igsbcYkGCAqswYk16j7iHyhzaWqYdGIv3G074lKyVJuPvT
         q6XTARejOwxkm1NmHB2scpDF5Mh6xqvBS8g3zc39uH6pqUBnjGVjRBZk6ImzLc0vs+fq
         k76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740520757; x=1741125557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhlRVTyXQdUVVfNqKiQrllxx1N3vzrAL5haFxdHIUL8=;
        b=V6GnjMpiabHc/Fgq3R1iGnog38SnzxcQ+v+piP36vpxgmO3iZ5HjAK3JUhrFNzUW2N
         uQ8x7mT/J1nvTzebt72pLPZWNU/b8NKhOSF5upzA430It2XtE95Teedi77KeTtJxIlgb
         72HLSxvr0NklKKIsQbNFwPEfga+2+IWLA13iCBba/qqMscgI/Yf69BDwoeucIhi8z+ar
         s8wv5MPJ96GkFeNFYGGenukYAnjc+TndHsn2LNiWUQdyJCPWXBkpChw7Mb2wXXfZjp/U
         pXCNiz/8hb15CI5hCXZejh0smhaWEhe6WwmfV8VtSTJlHSIu02+PRAbslR6qcR5cUpBk
         62aQ==
X-Forwarded-Encrypted: i=1; AJvYcCX53cwyxUhrWq9brWUK+74lX1fZkWNSzcwFvKNj+9hpLAzn+4D34BdvAlbp8XugZz9rFikWKT230xuoGJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWY6DNeE4S71jMSFZJTi7h3LfGpT316qMBZupN4S4BBvAqta6n
	lSfJGujFYLL207UTxyHzttFSsrymNp9rb2g2v3KgyzbsQ/szD8MPTu9cuYeenjEW+WnzYqdsHlQ
	GsMh2sH5Siruq7p3VVidLFr37VL4DgxsHy0r1oQ==
X-Gm-Gg: ASbGnctPkQ+4j45kYLyxYuZRHQRW9iZlGdAhiPLw4Ts6xdVWLNfNLYKJ4p/CTAmkRXA
	TIhsgtBO4muDyfkqGsUiIQAPq1yjrjJ7Kg6zZAN518YYIsL1Pp4HB5sR/Bgd7ea7AnL0eFJ3wbe
	batkyQ0Q==
X-Google-Smtp-Source: AGHT+IHayo9PtL6kjpIMX2v8YKQ15rB6H8J82Goph6no5zjxnEkePH22x+kK7BRT9XWlzl9eTGw2l4h92HsV0xvaCj8=
X-Received: by 2002:a05:620a:4883:b0:7c0:c7aa:d829 with SMTP id
 af79cd13be357-7c0cf9504a2mr2399399285a.42.1740520757416; Tue, 25 Feb 2025
 13:59:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225-apple-twiddled-modifiers-v2-1-cf69729e87f6@rosenzweig.io>
In-Reply-To: <20250225-apple-twiddled-modifiers-v2-1-cf69729e87f6@rosenzweig.io>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 25 Feb 2025 21:59:06 +0000
X-Gm-Features: AWEUYZmTADfb83tXUekSIDeFibRB5L8olGgSSUtW8nnT-NuSQ4JhGFcoTWxAp7E
Message-ID: <CAPj87rO3N2=3mNQg8-CUF=-XTysJHLmgArRKuvDpdk3YZ2xMvQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: add modifiers for Apple GPU layouts
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 25 Feb 2025 at 21:35, Alyssa Rosenzweig <alyssa@rosenzweig.io> wrote:
> These layouts are notably not used for interchange across hardware
> blocks (e.g. with the display controller). There are other layouts for
> that but we don't support them either in userspace or kernelspace yet
> (even downstream), so we don't add modifiers here.

Yeah, when those have users with good definitions matching these, we
can add them here, even if they are downstream. Anything the GPU would
share out of context, or the codec, would be good for this.

> +/*
> + * Apple GPU-tiled layout.
> + *
> + * GPU-tiled images are divided into tiles. Tiles are always 16KiB, with
> + * dimensions depending on the base-format. Within a tile, pixels are fully
> + * interleaved (Morton order). Tiles themselves are raster-order.
> + *
> + * Images must be 16-byte aligned.
> + *
> + * For more information see
> + * https://docs.mesa3d.org/drivers/asahi.html#image-layouts

This writeup is really nice. I would prefer it was inlined here though
(similar to AFBC), with Mesa then referring to the kernel, but tbf
Vivante does have a similar external reference.

The one thing it's missing is an explicit description of how stride is
computed and used. I can see the 'obvious' way to do it for this and
compression, but it would be good to make it explicit, given some
misadventures in the past. CCS is probably the gold standard to refer
to here.

I'd be very happy to merge it with that.

Cheers,
Daniel

