Return-Path: <linux-kernel+bounces-555533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A11A5B934
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C80217030B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740E51EF38D;
	Tue, 11 Mar 2025 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GHzioj3D"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BC1E5B6D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674427; cv=none; b=PlBCEXQb6c9rWqAvqcBxEMYH1E+nDQPCgUtC9pvkhDgdQEmtZqZ2/yncbtnzkUiTIEJu+8bNdMzDj0iozfXXtV865J391ZfMHhUp2t68qszm2jMTMV21LFVt/lmFN3Ek0naTdYD13x6MEGUhGLc6mW9bn1RW7XCHGgfzQJgGeA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674427; c=relaxed/simple;
	bh=JKsSL0u4YPjHyf+BYF31K9+WAPulKKTFywTLuMNjNt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOP4bTIHbDw3xgxr4Mv01k1DmgIcwghUhlLRUsKa0vBa9KXmucS7b3iRzFb/ztT1B1vtwZn6y2tlRahT0w6CTdjMIEmjBIzsbCydNTTQH75dhcV1dpFAVRCclso5dZnT85kYajGMqVovuc0MM1kLvf0DNNhUDM1asMbPeZ0AFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GHzioj3D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso7915275e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741674422; x=1742279222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuOFf9HoIeyoNdzWGpyEjnbtc53ZPD2jJIIiEozQVbU=;
        b=GHzioj3DfiLdp962R0cg11mSmUU63MMjHjBe9pOPDhpQvuMokxMORDXNZm/atDaYoi
         psGkAOI//A56EWssWHzpgWXVQj1FU6j+qU195o+Nzb7sKxAj/64LzeN/A6v6DzNGisQT
         TeK6V2gTSDlDJM1JgQTKEAmphb4s451s+Vh3erRDFhNd7VcJhFvPHOeqivUaDkML27Tv
         kq/2j30Clr3lNDhvfNtVMmSsRtituqmOABOuGWLlamtFS+R2WWSBnXDTmOA2fkfxrwSz
         RgBxO5hE7vpCZFBbyzmJBUvi3URZjZzcj55Ra7qBB9DWmM1bicA6A+syAbneIioIFviI
         JpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741674422; x=1742279222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuOFf9HoIeyoNdzWGpyEjnbtc53ZPD2jJIIiEozQVbU=;
        b=ijRpMWpGELTvLxZ81HPogl+vCtDKGjxMt9S0zi0DZRwZvX3xdJtVzw6Po+j8HZRqza
         odNlcFz19NtvLe44F6kO9/0454wt+gbLzs6QV6VgkhFgjNzII1BubUM1F+5YwjF4Lr0w
         ualm+cXi3vDnD+B5xircz4iVVMIzWR+wB3rSZoN8Nm4ix2pKwl3dMg7x6aUcFTJfROdS
         namuTn5JYb9jyY8XQ3zEEwBMixCCqFQqGDrhIOY7LHzy/oyRzRLAU4lBRHR1ljnHg8ux
         E358l0faQ3S0M1sMy8MlVp13C0UyXbYkRT6lnYXcbxqDeGI1XhT23dlMw1jdJmCQXeDN
         hyWw==
X-Forwarded-Encrypted: i=1; AJvYcCXAozKu/HMfdGXqpJiAxtLtIz/xvtctE+ZRY4ir+fN1/CLqaHgk6e/1WoWKKR1syQTP11uFsYGlorB+FxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu6KQAC2Li7OjV98QvmJu2IOPNg/aUgvUjEorctmDd4sYGE177
	yqQjYVsRawIigjHohL/MTGBHejro6yYp7JiQle6U9QnkHUk05Je+3P5TO2d61yg=
X-Gm-Gg: ASbGncvcCnHCe5KiZe3ynjtp5wPnPNybWjYKPs/LDOqKz8Ce7w7063HK3WAH1LweX3p
	2D45zAlp+83GbeepxzyWoqSow6bnEInFgSRLsub0dEAciv6t4D3JT9r/3tVB/ZgUAYvjn6PY0KC
	NyiXETIwQBbEtmqQDI6IbimghJ3ho3Ym7JihXNzGN1WkfU9BdR8FhiE61tjkMkv+5IFu8RnqOPw
	HDnm3ADjFYjGQD3UiwPaPdG68KSWa7mEkqH4rQ8yhPdCKTRp5w9dgQZtn0MT2JaidgDNfVt7uUv
	70WENUVGYGWchupiDar5DxNdJRZLilJSgUswH9IqZddH+mTJiXGtmwTXZjgV8u8Khd23IfnJ1m8
	ePeeFWHtq
X-Google-Smtp-Source: AGHT+IGJCKTIXUq41N/f5zPpUWFIGR/W8B5MRTPF/3AmIhFmDDE4ZQ976M6o2Dznx2Uw8tr+EA8N1Q==
X-Received: by 2002:a05:6000:1a8f:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-39263b00732mr2820277f8f.9.1741674422470;
        Mon, 10 Mar 2025 23:27:02 -0700 (PDT)
Received: from dfj (host-82-56-170-15.retail.telecomitalia.it. [82.56.170.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f10sm17246064f8f.65.2025.03.10.23.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 23:27:01 -0700 (PDT)
Date: Tue, 11 Mar 2025 07:25:45 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: ad7380: add SPI offload support
Message-ID: <7abliglzeag4il4dhzuzlvimvfeveqefowq3p2rawjvdpjfgpe@dxasa2dkdksi>
References: <20250310-wip-bl-spi-offload-ad7380-v4-0-b184b37b7c72@baylibre.com>
 <20250310201311.04b56522@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310201311.04b56522@jic23-huawei>

Thanks a lot.

regards,
angelo

On 10.03.2025 20:13, Jonathan Cameron wrote:
> On Mon, 10 Mar 2025 18:39:51 +0100
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > Add SPI offload support for the ad7380 ADC.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> I've applied this to the togreg branch of iio.git and pushed
> out as testing for 0-day to take a very brief look.
> 
> This might well be the last series to make it this cycle depending
> on how busy the rest of my week ends up.
> 
> Jonathan
> 
> > ---
> > Changes in v2:
> > - fix return value on offload probe,
> > - add documentation patch 2/2.
> > 
> > Changes in v3:
> > - fix tabs erroneously added,
> > - fix documentation syntax error,
> > - add a note for the 4 channels ADC variants.
> > - Link to v2: https://lore.kernel.org/r/20250304-wip-bl-spi-offload-ad7380-v2-0-0fef61f2650a@baylibre.com
> > 
> > Changes in v4:
> > - add offload support to adaq4381-4.
> > - Link to v3: https://lore.kernel.org/r/20250304-wip-bl-spi-offload-ad7380-v3-0-2d830f863bd1@baylibre.com
> > 
> > ---
> > Angelo Dureghello (2):
> >       iio: ad7380: add support for SPI offload
> >       doc: iio: ad7380: describe offload support
> > 
> >  Documentation/iio/ad7380.rst |  18 ++
> >  drivers/iio/adc/Kconfig      |   2 +
> >  drivers/iio/adc/ad7380.c     | 511 ++++++++++++++++++++++++++++++++++++++++---
> >  3 files changed, 495 insertions(+), 36 deletions(-)
> > ---
> > base-commit: 73b788d05b5bd82c40193165583a9dcad2d8410e
> > change-id: 20250220-wip-bl-spi-offload-ad7380-6f1c27cd815d
> > 
> > Best regards,
> 

