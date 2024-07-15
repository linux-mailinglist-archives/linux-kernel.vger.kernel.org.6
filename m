Return-Path: <linux-kernel+bounces-252256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EC39310A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA0CCB22703
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5F3185094;
	Mon, 15 Jul 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lqCheDuH"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B04CDEC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033551; cv=none; b=gYwi3crg+pjIkacRfgtPFX5/MnOiIlFID61vktPp0LFy+0Yrv2qE52wVVuQNnBnNSYyLwkhcjFImDOrrEmP3K7g8hMLSiNrDE+xSCDAPDAuppKoVMqrt075e1FuXenuLrtSDpvNHLTe9H3rEd8iWGvVbIcFHemrHZpbex+Al/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033551; c=relaxed/simple;
	bh=MIFpZl5p/ktVxSENpSPhRpEignOYsjsDZTzD8m5IENU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e83R2laZcoocHVml9pZbx/0Xh0lrvppD01gjwrWnClqgrNmSiKy+dA7V+NfOf+WhWUNDMGoNzzZqIem+TDw/UGF+NTIcbLnM6ZXApu3jNlZgCeeqkHnjEaUeU5hymh2ehn4GTPFqOW8WMmKimL3rxRLTRcUVb7KqCJfDCQPAAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=lqCheDuH; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ee9246ab1fso4926061fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721033548; x=1721638348; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFtI2KoVZL8zpxDmxsiji21hGTTPGlau5bq5V67S++I=;
        b=lqCheDuHpdxnC5dncSmTKUJt+W6J1BgtQ6+6pA9haUmlXGbXsjuvDjcqQf2nTivSAQ
         nGdiZYKHgT0uIUfrznQOhWrRDkpc8/NsxXqvyf6XMb6b67u4iWRkMc6l44WzxsT2I7BL
         T1byK3oIuVTmIhJjkE6Yw5kw8QDYZTOaaS0tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721033548; x=1721638348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFtI2KoVZL8zpxDmxsiji21hGTTPGlau5bq5V67S++I=;
        b=mKOiPOLGzE03NN0PHtZMKyWd/V/60iW05s93BlSJz5sf6ZL33TIwx5kYbrKc5x0lNn
         pbBiGI4ZNS01Kwa/Sflk7Sfmqc9t58f1g+Chq5unGHFaghq2rsLD0iKhMDhJIkcXdoY/
         G/1b5dvjuhS8ahXJQ5EyAWNo6v84NarhEbgd0+ZZ27FUz6eHGQb6emUE6Vqr6fqEM3w2
         OE+/mhTJ1qyQhhVX9VLuwAAgpBTySBwOEZzPya/Kwx24njg2pYh77vcVwCment8ihOd5
         CfAZkNd6UIt8W4TKpvqVr1ArhN2vzZR84KIB/GMnYXHqGLudLM9Ge8GOG7Vsml84/dv/
         P+aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKKCh0thtU0Qhlt1/kJTajn91SaebwXeF4wmgwrI8P27Se5xLFejD6mPio/XOK2LSIRkZvLEMeIcrTWnJIYeGYv1Fa26YL5jaEQkzx
X-Gm-Message-State: AOJu0YzbgtMjnDPrXZAL8LauFpVPBQ/YkcKrh5VNaAyy5B3hVlKQYjZw
	NFTRspzcH8EAvfXwjQ6dTHSNDYo/f+1byuonBj83w7npfjZJfpTFRAxm4ckeigc=
X-Google-Smtp-Source: AGHT+IHmjsFZ+qyY6qOuWBh0tmFYh3x5Sbnw2EXZYOBODf4NfNY2g4S0U+DdM2RcQHVCl5EcvZtu3w==
X-Received: by 2002:a05:651c:198b:b0:2ee:91b7:860 with SMTP id 38308e7fff4ca-2eec98be531mr64924681fa.4.1721033546536;
        Mon, 15 Jul 2024 01:52:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc306sm113442395e9.30.2024.07.15.01.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 01:52:26 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:52:23 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Lei Liu <liulei.rjpt@vivo.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrei Vagin <avagin@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Daniel Vetter <daniel@ffwll.ch>,
	"Vetter, Daniel" <daniel.vetter@intel.com>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH 0/2] Support direct I/O read and write for memory
 allocated by dmabuf
Message-ID: <ZpTjR-7dabdyREXS@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Lei Liu <liulei.rjpt@vivo.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrei Vagin <avagin@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	"Vetter, Daniel" <daniel.vetter@intel.com>,
	opensource.kernel@vivo.com
References: <20240710135757.25786-1-liulei.rjpt@vivo.com>
 <5e5ee5d3-8a57-478a-9ce7-b40cab60b67d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e5ee5d3-8a57-478a-9ce7-b40cab60b67d@amd.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Wed, Jul 10, 2024 at 04:14:18PM +0200, Christian König wrote:
> Am 10.07.24 um 15:57 schrieb Lei Liu:
> > Use vm_insert_page to establish a mapping for the memory allocated
> > by dmabuf, thus supporting direct I/O read and write; and fix the
> > issue of incorrect memory statistics after mapping dmabuf memory.
> 
> Well big NAK to that! Direct I/O is intentionally disabled on DMA-bufs.
> 
> We already discussed enforcing that in the DMA-buf framework and this patch
> probably means that we should really do that.

Last time I looked dma_mmap doesn't guarantee that the vma end sup with
VM_SPECIAL, and that's pretty much the only reason why we can't enforce
this. But we might be able to enforce this at least on some architectures,
I didn't check for that ... if at least x86-64 and arm64 could have the
check, that would be great. So might be worth it to re-audit this all.

I think all other dma-buf exporters/allocators do only create VM_SPECIAL
vmas.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

