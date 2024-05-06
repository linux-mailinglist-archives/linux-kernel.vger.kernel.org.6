Return-Path: <linux-kernel+bounces-170117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8977F8BD20E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7991C22580
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFC5156231;
	Mon,  6 May 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lw0affc9"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75903156246
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011273; cv=none; b=VD2TRd6454a30G8dNNxcisRhtsn2utiX4pIVhFoI1MUqeYA244/Brm24eHx720VHRrUJmP6nt0AXcd/myYAlVXRHj8KHVCUeAlj8VhOqExdKp0QjHHi/7wGcqGZxbZlyOAbIiEfkkXhpn8IQ3beEyRhlUswjDQeHOcHecXxA7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011273; c=relaxed/simple;
	bh=/8X2gnEiS07MSb4K2ujaIaVEy+MjBkGptcmS2MVFUUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmSYl+QMuK/sDFe3jDMyAoYpQl5WNf9d58kn0+hUImUKozRfGdOjPgJNDJzTkRz5Xveo8F5KWgILfqDfyxC6vTtI128xtBFoNo93lwbvpBZgdBGPIVWftm8SUoyG88H6tCYJ5rSOOLwjMMw/PJfnmMXBfYN+RZ1tfqZurJ9PBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lw0affc9; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1965752276.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715011271; x=1715616071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE9GPEEi4QiW/KNtAtOnI6oG/6EjA9xFbSRzbj2009Y=;
        b=Lw0affc9WYlsWSr+0CrGfjai1EjfS46NczBQ8rW+cfAgFbJ3x2OQ4cAd54LJTjg31T
         7SZUrgkID5F8DxkGzWYpIaRhh+owJWA0dZUUahS36o14DUa+gvawiDsn77cpM+CxcYEv
         9bsN9iuBZJclXINRj00pe2hQouwpdzZsDo67oCE5rXl1sHpcwzjB4bXwjJ7t+nm0RV3a
         E8xmIrQIsFjofHcEsjRWvGxRiFTC5Jf72alC0myVC7ZK1wTYP+5eOpGUnpLuTZTn69Kq
         FuW7uJhksLyZYGE8iiCf0izD1XIGLnrWHU56e98qRWkqGf7FhuCCmBI9vEhRk3GNKiRc
         JgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011271; x=1715616071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE9GPEEi4QiW/KNtAtOnI6oG/6EjA9xFbSRzbj2009Y=;
        b=dXAc01WTJKm5T1jAom4sDR5CtCDyeDbyGyKYnSUpthcBJhMk6uKMu72KcdtBewRG9P
         0rYNNTu3W0QrE5LdibDx2tolhqYOP8kiBhgmmycpRuC3n43h1AUKuZH/2IW7DBev2TcU
         Gz7livStQ80/4/dRi+htR48zi3MtR2XlpTTlchAbWFABuYyco8XL8ecHAgk0Y+z0Mc7v
         hLEd4B6w+ia6GwgvRMTrdj8GleY8PXPxHwYLnurKrE21xMbjh7EjH5iZaU9NvpTHvHzm
         eumjxJMWgLtJf3cMtkvYnYO1EyLBR5fm4gQY2FpXAGLr+JnBHbtFG9N4W4b9F+a0PPBS
         MWqw==
X-Forwarded-Encrypted: i=1; AJvYcCXV24uaTEVzp8LS/42BY4Zm3pmsSJkh955IiRQpwGFzHnmZHi5Jv2pIxz3jvYpP3Eer2BPU8McEFZgUjkBG3pHWZUCwAt3NLVT4ybsv
X-Gm-Message-State: AOJu0YzNg+r1NhAL6Fgl3c7P18PQb1aao5bJSpy6hJRk3IE/DdgPnb3D
	FokgB8f/iftOGxet2eTrMvCluW/A25ss9iDF9IkOahOzvpPQEnB9PNpqkygrHGRDAiVdmGLE8PA
	XITaf08h5sAkxw69mmA0tm0tajq3XNubzmIgV
X-Google-Smtp-Source: AGHT+IG8HH5pkx30Vizp/TXJUP3BkqxJAP2OHSMcx+YHDtQcvmWbDHRVh1Gs07OExx6zhgjFxd8AIqm6lMkRRE3SQ6E=
X-Received: by 2002:a25:698d:0:b0:de5:4c3a:5ab6 with SMTP id
 e135-20020a25698d000000b00de54c3a5ab6mr9641262ybc.3.1715011270989; Mon, 06
 May 2024 09:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503183713.1557480-1-tjmercier@google.com> <20240506052955.GA4923@lst.de>
In-Reply-To: <20240506052955.GA4923@lst.de>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 6 May 2024 09:00:59 -0700
Message-ID: <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	isaacmanjarres@google.com, Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 10:29=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Fri, May 03, 2024 at 06:37:12PM +0000, T.J. Mercier wrote:
> > As of commit 861370f49ce4 ("iommu/dma: force bouncing if the size is
> > not cacheline-aligned") sg_dma_mark_swiotlb is called when
> > dma_map_sgtable takes the IOMMU path and uses SWIOTLB for some portion
> > of a scatterlist. It is never set for the direct path, so drivers
> > cannot always rely on sg_dma_is_swiotlb to return correctly after
> > calling dma_map_sgtable. Fix this by calling sg_dma_mark_swiotlb in the
> > direct path like it is in the IOMMU path.
>
> I don't think this is the right thing to do.  Despite it's name
> sg_dma_mark_swiotlb really is dma-iommu specific, and doesn't make sense
> in context of dma-direct.  If anything we need to find a better name
> for the flag.
>

Oh, that's disappointing. I'm looking for a way to quickly check if
any addresses point at a SWIOTLB buffer without doing a potentially
expensive call to iommu_iova_to_phys. Since it's meant to be dma-iommu
only I guess I could use sg_dma_is_swiotlb if iommu_get_domain_for_dev
returns a domain, and is_swiotlb_buffer otherwise for dma-direct, but
it'd be nice to have just one way to check which it looked like the
SG_DMA_SWIOTLB flag could be used for.

