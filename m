Return-Path: <linux-kernel+bounces-385391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6630B9B3699
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D31D1F227AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759611DED79;
	Mon, 28 Oct 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsRNCn1O"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6891DE4D5
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133316; cv=none; b=XJev/ql4KSFoj0BHJNLg0YLC1RfFaNE0O09ZKh6K0h6zNbK1mjrEex+oGTLdk84byj5vG2NKRi53IDIToFKi0YyldZpQC+gVuteagjkxFvaJ49rIw16k/8Iy9Vtrln8/qpKml1n2YUKYj0IzD8kowwK+jaCDZlTbVByU53GEbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133316; c=relaxed/simple;
	bh=ArHABq8A1o7mvQVSdTyEkPlEWyFq15IqEPEW8pMS9is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE0rFPYc15LU8dbQiTPZLazpifhobj6GVtz8uPnSz8T56jCjeEJDY6w3emLcO9MEU2Adt3zGvwHT4nqAPn1ZJmXX9BynJAuAzNaxPToSoPzF5XBid2c5wRMjBvzOMdOESzKR5uixoY9uuj3Dfnv4+UL9fwaSKXuYd5fQbCsQsXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsRNCn1O; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cc250bbc9eso33805006d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730133313; x=1730738113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArHABq8A1o7mvQVSdTyEkPlEWyFq15IqEPEW8pMS9is=;
        b=hsRNCn1OLWtlFh6bds3JOxsGB/9Q4WC9uaa8wQZRaRD3ernl8aOcYiZVq8LpazKnbY
         pHlq//4mPEp+JHueXSA5ONlsnFLkV2EMkiH6sjrA7H3ML1MvEcaHjkLmC/FhYU+amyjO
         lvXZsRjbM6YHmvZuk0w9exdK3m4T7h3l5eLWazN8gVxdvsHvskK1vawtVo71Z/De4NX8
         Bf4k0pPNQBX+tauqJ+UXCNtaGrt41aCsq9X1HgJgxLzvSFqAPpzdx4E7NHirGai+wFk7
         oFIftwQP7ixAL0VWHW4i2/lnUvUkyzb5zkOkDEjPNAG+7Xu1bXA1u/JOZepAMfgLz5i+
         MTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133313; x=1730738113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArHABq8A1o7mvQVSdTyEkPlEWyFq15IqEPEW8pMS9is=;
        b=oQW7LkLeq6e6jcveGj3qIfTaYCCLwgZgUe0CCOoN76VvFIkgQv6yaB7Ebx6FNiJ/aX
         oc6aBm9D4tCcPrnog7jcy1FZ1FX8GUrxFQK/MBa+AYfTGb60I36mtZEFw2cPN7Y+Fo5/
         5kpOdsaRt2nOWia4ORp+ArwxlPCHwJO0OiJ+wQ9or5H5Bnla4hUu6qLpVFTMIzQY0YGZ
         s3WMQkjwUYSGYao+Gxk6k6XV8O50M/rbMwZJpGaKPe85lU2lIecrtvG4hsA+FwSZIeft
         fMEyTe+mHVjOstHYVVNZ2aZSaSW2jjCGxNKa0hmtZKDCEoilr4QHJ1Xi521nMtqLQPly
         TrRg==
X-Forwarded-Encrypted: i=1; AJvYcCUzoPAV4sc3FkCjbJnmUsgNNV5PjWUHsYfInbqv1gsk4AZaI9mucMNsT4JJ1W9fJgKBAudzt2gNk6LrmpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy653M786gvpEkgLO1wGy0Z/+2h8xnVHyRYiu+3Tzmsrm5YY9Vq
	43EwMZ78Vnufw5k+vawyxctmqOHh0Ba+A8p1xV0c2BqUTgD6e113gmxVQcrYV81ozartoC03y+J
	yGeF/fi61Cg9yDR7ZdP6PW6w+F3U=
X-Google-Smtp-Source: AGHT+IH61ILdb5H3FJChKqS1gcJ6npw27iJTDqjwBaYydJHQPH7Yw5ElEtz8gM9Cxt0ppTZ2ftQPvTViJ3iPXQmxySQ=
X-Received: by 2002:a05:6214:5b0a:b0:6cb:e90c:7c72 with SMTP id
 6a1803df08f44-6d1856eb507mr142485766d6.21.1730133311527; Mon, 28 Oct 2024
 09:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027011959.9226-1-21cnbao@gmail.com> <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 28 Oct 2024 09:34:59 -0700
Message-ID: <CAKEwX=NH9ubWSgKyEJJ0sjxoYXhCV3r4VCJf7UZxHdVX5GDA=Q@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Usama Arif <usamaarif642@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 7:32=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
>
> agree it is better to have a separate counter for zeromap.
> then it raises a question: what is the proper name for it :-)
>
> zeromap_swpin, zeromap_swpout seems too long? and zswpin
> and zswpout have been used by zswap

Hmmmmm. How about zeroswpin? zeroswpout?

zeromap_swpin and zeromap_swpout is not the end of the world, FWIW :)

