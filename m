Return-Path: <linux-kernel+bounces-246535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F46C92C336
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D777F1C22AE2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A17180058;
	Tue,  9 Jul 2024 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dhqQ3Q3l"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BDA12D766
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549260; cv=none; b=hTbtvh2FJgFgBveGzGWKtYCqAydU+PhLayv33kveozMSDh2AkYZvXxJiJ4B4w321UMmKrjCRRf4+flBLFb6rfBn3EcbG7SW3K/6DYcA2rU56M6fEfQ6K7Ob25wjYWyMTKURX+TW5p0ZHMcaOi5IrhpwIbAClsNeQUEaOrbYz50E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549260; c=relaxed/simple;
	bh=jwZGJyfU07UoYWIzsMHX/3TK3hvf2IuoCeBvu8j4bfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1nhBgafWgot/NTJb2zvLP2Ftkw47xdvjS+IvT3j7H/0FCNPFBP5ftCLi0PMe3qnIJ35ZxBnFyCfyTMNCPgFF3YrR9CZnD3RxXNoOTLMRtTVqcoY+pvM8XVCCtzwI5e22KoBNZmToA2PdsxMAeh4jO9CVcneHWWmiFsZ0gi7fLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dhqQ3Q3l; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b06e63d288so27883796d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720549257; x=1721154057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9E6V6cY/cj8ZiaAnveer+zyrlVrfa8IU5zVqzB39Oxk=;
        b=dhqQ3Q3lNCjXjzQcHCwiWX05alRdaNb7JqRuy487axXXizZ+JdiawR54I/CWCtUH7N
         ys4SvFVb6/puLUHG3RZD5QFuUhojjN6/GBqHudZYCnLHz2RJYMbnUPc4UWbwGuyFs2w1
         GFaQS6E2JjH3e1vg7FvUIA8vFF2AAHM39FAuQBY13NBvnCMxWfwP+GZGLiEnyB+tka1E
         BxGzu4upBGu42CplekX2fnuYx0XZoIZGrYGh+cEZ4DSu1bRvqQws4g98YikXVgKbljv5
         3ZR5rC9Bb3Tqu5qJqkJAzvLgSrLKszsNs96IlsHJ7AfjdHIYt2sEzwP8+cZgEnErYixK
         YpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720549257; x=1721154057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9E6V6cY/cj8ZiaAnveer+zyrlVrfa8IU5zVqzB39Oxk=;
        b=rNGxG6l60jJ5nm/vCbm8bvBZJP9cRZVsgESxM6HSPi1ex9aDYh1TIn6FS/k26/hYu8
         M0yxEdOCjthqzOschikFwCyBLcyk9nFkCq/TMyi00GpdMqnjsNT11e+c1vbgNcAVo+yj
         CtPFHlSGygNbcYDDXsnV9gSzeNUwiA+XslIreZZUzXv7uVlyYQqbO0mWC5smPlLufjyN
         tBvHv65HyQ08KlJCxnnyovGzXsiatI5gRdHIu9p7E6z6wSAmMZ7CF9hxpLTY+3AUSVbl
         JjPhltoKHWdzPhdA+48L7GFUFzxJCxP3uWUfB+3G5P1GrDeea/S0V20LDEFa2gTzE4UC
         4pUA==
X-Forwarded-Encrypted: i=1; AJvYcCWZCO1BT+8zI9tCshFMnDlpqFnsfNjJEE9DIWg5s8SPzE/gO6EvW6qjRGuVp/+Jn/y6U+XQhiEpraf4cfbDy3/v6uOS+dINpyQlAark
X-Gm-Message-State: AOJu0YzYAt9uSYqX9PocTcgalkXOLAbsiRih5AzP8UeYyYeeTkW6+RkL
	hibpvgSw9iXzKjGlyX3qWHieQt7hzXsKS1bexgahY+rGxRYay0QilL57Qg0LEug=
X-Google-Smtp-Source: AGHT+IHQcPysG+/lYer4BWdKZGOo1vfS8mkZYftL/MoxoyxLIYr0KVtgkTjjYF2ckPALt1hH5llLkw==
X-Received: by 2002:a05:6214:240f:b0:6b5:e58a:6388 with SMTP id 6a1803df08f44-6b61c1c50f0mr42298536d6.46.1720549256724;
        Tue, 09 Jul 2024 11:20:56 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba73984sm10845926d6.75.2024.07.09.11.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 11:20:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRFSQ-002pM4-Eq;
	Tue, 09 Jul 2024 15:20:54 -0300
Date: Tue, 9 Jul 2024 15:20:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Rob Clark <robdclark@gmail.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] iommu/io-pgtable-arm: Add way to debug pgtable
 walk
Message-ID: <20240709182054.GJ14050@ziepe.ca>
References: <20240626204033.255813-1-robdclark@gmail.com>
 <20240626204033.255813-2-robdclark@gmail.com>
 <20240703150205.GA6012@willie-the-truck>
 <CAF6AEGsgN8O2eJGqcJm1UaPzV2rWSXskAc+A8uk0mVbsj8Wm8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGsgN8O2eJGqcJm1UaPzV2rWSXskAc+A8uk0mVbsj8Wm8A@mail.gmail.com>

On Wed, Jul 03, 2024 at 09:18:43AM -0700, Rob Clark wrote:
> On Wed, Jul 3, 2024 at 8:02 AM Will Deacon <will@kernel.org> wrote:
> >
> > Hi Rob,
> >
> > On Wed, Jun 26, 2024 at 01:40:26PM -0700, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Add an io-pgtable method to walk the pgtable returning the raw PTEs that
> > > would be traversed for a given iova access.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++++++---------
> > >  include/linux/io-pgtable.h     | 16 ++++++++++++++++
> > >  2 files changed, 41 insertions(+), 9 deletions(-)
> >
> > Non-technical question, but with patch 2/2 being drm-specific, how do
> > you plan to get this merged this once it's finalised? I can take this
> > part via the IOMMU tree?
> 
> I guess if need be, I could merge the drm part only after the iommu
> part lands.  We've lived with an earlier iteration of these series as
> downstream patches in the CrOS kernel for this long, it isn't the end
> of the world if it takes a bit longer

We should try not to split series up, there are too many cases where
the other parts don't make it and we end up with some cruft.

This is only two patches, get iommu or DRM to ack their parts and send
it through one tree.

Jason

