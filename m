Return-Path: <linux-kernel+bounces-417187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E98F9D5025
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7950283691
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10D02AD00;
	Thu, 21 Nov 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BuF1eEtC"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169F43ACB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204394; cv=none; b=Q618XJZXQdDa/SPJHucbV7KGPSIGz+f7gh8oRSkTXRc34ULaI/QTBZrdpRgKlT3Pv/ZoBdHM1FucSFdtS9uAwV8GVZxBclz6UepO9VxzboLFD3HBrYKtVlYpdsK1bMiFpnahYUlR596Rz+ZHDtJHkZAbEKMis040xHjJOgiRolw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204394; c=relaxed/simple;
	bh=gQ/7o3NtNQdkt1xIyshCgRb4euFWzBcL0D8LiXhMi8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov6NDBjSN18fbtklHsseBlEvO3pwxBAM2qNbA7ubtp3t08V8EX3acQkXa+CuV8GMIKwDki+IRD/uBd0yEJ9FOaz9sEPZJbzpFYzkXJT2aMbq6yBJ46NwkZvOC2HCe1j3hFzYwcEoekQlZuteA3uOVWU9PktAQvhUB0Htkg2JPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BuF1eEtC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21145812538so8197775ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732204392; x=1732809192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rvge4gVLXbEkzNxyNWuzrgHVGstxhxPYrLjNP2/nbGw=;
        b=BuF1eEtCOBnbv5Emc1wfPA/e8TErV9NGEFfLj6sle9dBortvh+3ogEzhunQDRmgTkK
         rMLymbh/EJhfAVzbTlPUWBwGCKHd79Jc4QLorMBvDZJg18PuccWpFhVMjs69SSdNzOQ5
         4xA8oQN2tLRfrC5i8l31qhq4p9nzNUhcs3Dr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732204392; x=1732809192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvge4gVLXbEkzNxyNWuzrgHVGstxhxPYrLjNP2/nbGw=;
        b=Kkm2uYChIQmyzcYXrc+YG3pQcxW/NAfFukshHvDh6ZDwwtWF4pwcSv7FLtf5ChCVDo
         UyC51tzLLTfMiJf6hMYuqNKR/AV2KruCfI6MzsR1l3D/dmNCqnApdh64z86VZN1bED3K
         fCxe/iFKnFYo3OGNVHhxQ3bXRYnQxRkVRNwckDCfeZGf5KIPQw/oCgHhP5hu6Z1WpH42
         PMR+Fxi+fTub0HVxxuyKNdMIQLpg8dOkJFl6TSyKJ7flzfxdvziOmWfJRg5dLhrKUUKV
         gGasuwB/TR7uEWPEt0huGQ3Ql8vUpLzYrx1GKXl4dVXfsS97On6pxw/aEtf3lNxJjhC3
         XSyA==
X-Forwarded-Encrypted: i=1; AJvYcCWF+EffJ4X7PueHqc4oLC6FSDiHfZNj+hHuWmwDxbpcIES6EZgklLOKcoTC4WynQFBLW9nZx2nPPgLi1XE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3izAKIawT1Hyu+38HlLmss6ROoN8TUY2WGhZ450WNzPMQV75N
	cYTNKDlzrZj/yTNOR27uXmYrpRHZ/CxFO20+t6NAr/MSwz0RJNypNO+ci6ubI+PayPf0+sTg8hc
	=
X-Gm-Gg: ASbGncsYrDVr0MkCeRE3rWf5VMKrkB3El68V7lVfpMo+enGpRBONxAO6c8ImR3lRPdb
	5kLUriwWyQIuNqMUzZ0xB3PCXbQGl6kqtQYBbvvj5NekEsGOUknQW7alOko/lhhIxqJjr+UdU7k
	gHLWvYOf6N/92yUca4djUdtCM5IOprl9yB3JSbToycaSTs6KPOGeciACzJ8NUE3XrMvDN4WLcQV
	6Th71pin+bzIbj3Nj+bbiGk/JcCkvosKDA+7yEW+mOTzqxy5uFjjQ==
X-Google-Smtp-Source: AGHT+IE+4igqunFl1DvRHlIVf/Bz4JhFZQ5n3pWuSu4BGR0fCPYVbkpfSbpwwNCtGXhrwwn3VneJ4Q==
X-Received: by 2002:a17:903:41c8:b0:212:b2b:6f1d with SMTP id d9443c01a7336-2126c1299f8mr101602745ad.32.1732204392296;
        Thu, 21 Nov 2024 07:53:12 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:4a18:f901:8114:dc7d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21287ee13fcsm15302955ad.145.2024.11.21.07.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:53:11 -0800 (PST)
Date: Fri, 22 Nov 2024 00:53:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	"minchan@kernel.org" <minchan@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"terrelln@fb.com" <terrelln@fb.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] zram: introduce crypto-backend api
Message-ID: <20241121155307.GE2668855@google.com>
References: <20241119122713.3294173-1-avromanov@salutedevices.com>
 <20241120031529.GD2668855@google.com>
 <20241121121120.ch4qbmbiuje2cjog@cab-wsm-0029881.sigma.sbrf.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121121120.ch4qbmbiuje2cjog@cab-wsm-0029881.sigma.sbrf.ru>

On (24/11/21 12:11), Alexey Romanov wrote:
> > Sorry, no, we are not adding this for a hypothetical scenario.
> > 
> > > For example, he can use some driver with hardware compression support.
> > 
> > Such as?  Pretty much all H/W compression modules (I'm aware of)
> > that people use with zram are out-of-tree.
> 
> At least we have this:
> 
> drivers/crypto/nx/nx-common-powernv.c:1043:    .cra_flags        = CRYPTO_ALG_TYPE_COMPRESS,
> drivers/crypto/nx/nx-common-pseries.c:1020:    .cra_flags        = CRYPTO_ALG_TYPE_COMPRESS,
> drivers/crypto/cavium/zip/zip_main.c:377:    .cra_flags        = CRYPTO_ALG_TYPE_COMPRESS,
> drivers/crypto/cavium/zip/zip_main.c:392:    .cra_flags        = CRYPTO_ALG_TYPE_COMPRESS,
> 
> Anyway, if we want to completely abandon Crypto API

It's more complicated than that.

> these modules still need to be supported in zram.

We support what we have always claimed we supported, namely
what is listed in drivers/block/zram/Kconfig.  That's how one
enables a particular algorithm in zram - during zram configuration.
If those algos are not in zram's Kconfig after so many years,
then it's most likely because people don't use them with zram.
If we ever need backends for those H/W algos, then I really would
prefer a patch from folks that have a corresponding hardware to
run and test it on.  The thing is, zram, in its current form and
shape, imposes strict requirements on comp implementation.

So we should not add algos just because they are there (especially
H/W algos) that's how we added 842, lz4hc many years ago and now
have to carry them around.  We are not doing that again.

