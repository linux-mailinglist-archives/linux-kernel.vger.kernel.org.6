Return-Path: <linux-kernel+bounces-227810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C807C9156BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855342846AC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B301A08A3;
	Mon, 24 Jun 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZxpY2kri"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C891225D9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255276; cv=none; b=F8cd0esJ4zwo7DwRdtAhs6l/WZWdiY6vlsuBNRnWO4QR5eF41M/InCgabIFT0Rb/IrvanNIDPqGLNlFe/AGvhpJ1JVMPCo+QleD5TkeYUjztNT99/Yp3JedY1hagDgkc8pzjUBkh8v/xUdxmv4Xh1OgU1WwL21CFlGwEY4SNoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255276; c=relaxed/simple;
	bh=+aHo+RDnT/WvmjPAgH8TsZySNNBozthwDDf/TaQIdEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtYCGWfXi5/55XPkqQZi/rN1UlIpSZw6n0Qv/fICbKvXwIty+yQR5ZDU0vcWHqr7djncrfxc+QhebjJBXR7n7k2h9IlzACd1od3PLz7jt1MmRj8VyLEJj+Fl5NofTwaH1kphgMoqFAXMFHUwe7B93GuC4VE/qDpOhCn9ja4cIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZxpY2kri; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ce6a9fd5cso1232917e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719255273; x=1719860073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aHo+RDnT/WvmjPAgH8TsZySNNBozthwDDf/TaQIdEc=;
        b=ZxpY2kriKXZVCGJgdoDSQUPdPhFdksQytCEp7w+eEaABxzV6A9Bd+fVZa7QkRt3ol8
         pLo5u1TwbgcHfoaFv2w8ZxtZIfjP2piHn6vfqstar6RRLVcvdUpMXCc0xUJVSnvV9BAl
         NbSJanPVrs5YSHSIPkG/r6LsttqfLXrPwayH8lqxpUj86AbX9alQQkRpMCSWMnWIxJYu
         0yuU4YaSJjgTylVrqfEoa+9R666y44DTS98Dyjq1dO+zxD0VOKAEbWGONAUxcKDkQDS5
         v9rsuvrQVxCbL8WXww7oq8IftuwGpHew8YYRuL/8L8VnQfNLizmw3bLbUdU3nuSm2rpd
         SZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719255273; x=1719860073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+aHo+RDnT/WvmjPAgH8TsZySNNBozthwDDf/TaQIdEc=;
        b=qYxcubUVYR4N17GbbaEmvUgr7Be8yYWouKllbABb4FAnoBQrhTq14Y5w5wd6o6FX9u
         hlAzbeVsmNrG8pTf7s/XKnzZpGY7rmUlYg45E7qjYHmSuxTFHGHLlTbsk2w0j4q0+G+g
         uftUdOV9VTsFwtsuOMrSehSVl1LihVeYY8oLTxo6i4ZhUUVH2mdj5A/pXuqMaE6YC8Zs
         DHSONFtGVoC8nXNRavorm5c8gFnyrisRt1Bo2rfJvXUECn7VdHyExOlO3dXoilMgdyfN
         kPV2BMXmaG1H66QxuF955MYiQvPomYc5xB6xs5cmTP5zAyYUdeJOKR3xugyjPxmZe+tr
         Zv0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdUtyUiMMSKzFa76ZAF8JjlCpJ21Fe69Zp8/tdNDGSzNBpKBuGJY1hZB/A52sERs+yxTnCFSKuFLQs/wFD8RAUn6Mo1+ucgBxQWCez
X-Gm-Message-State: AOJu0YxR6C96PbUze5oeM8e8N4T6ShZjnXAdMAocKW8CZ3X10+cxRJyS
	Wai5Ota4u0O3KchfQPOFvLQjFX3F+ChOnOZ4RV0uMfKAJxMMVWiNoqZN4viFgb8TeeU0aI5yN+i
	jk10wNLYnCKt7skW3/yY+2V44nVTq3iORmEtQ
X-Google-Smtp-Source: AGHT+IG2Ylwf4qP53KT8n9LuQFgtOaFeplGVLRIskw5ThK8EM33Q7t3846sahBbOoJlS7aJZoeVlMm+NykS0UDg32fQ=
X-Received: by 2002:a05:6512:1cd:b0:52c:859c:91dd with SMTP id
 2adb3069b0e04-52ce18327aamr3287502e87.5.1719255272205; Mon, 24 Jun 2024
 11:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406241651.963e3e78-oliver.sang@intel.com> <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <Znm74wW3xARhR2qN@casper.infradead.org> <ad18c6fb-7d00-494b-a1f6-3d4acfbd2323@gmail.com>
In-Reply-To: <ad18c6fb-7d00-494b-a1f6-3d4acfbd2323@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 11:53:55 -0700
Message-ID: <CAJD7tka3FZuMhmmt_FJ9yHWRnr_JS3FSbsNKmSSatp8qPL2QZg@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 0fa2857d23: WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
To: Usama Arif <usamaarif642@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, David Hildenbrand <david@redhat.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:50=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
> On 24/06/2024 21:33, Matthew Wilcox wrote:
> > On Mon, Jun 24, 2024 at 05:05:56AM -0700, Yosry Ahmed wrote:
> >> On Mon, Jun 24, 2024 at 1:49=E2=80=AFAM kernel test robot <oliver.sang=
@intel.com> wrote:
> >>> kernel test robot noticed "WARNING:at_mm/page_alloc.c:#__alloc_pages_=
noprof" on:
> >>>
> >>> commit: 0fa2857d23aa170e5e28d13c467b303b0065aad8 ("mm: store zero pag=
es to be swapped out in a bitmap")
> >>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
> >> This is coming from WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp), and
> >> is triggered by the new bitmap_zalloc() call in the swapon path. For a
> >> sufficiently large swapfile, bitmap_zalloc() (which uses kmalloc()
> >> under the hood) cannot be used to allocate the bitmap.
> > Do we need to use a bitmap?
> >
> > We could place a special entry in the swapcache instead (there's
> > XA_ZERO_ENTRY already defined, and if we need a different entry that's
> > not XA_ZERO_ENTRY, there's room for a few hundred more special entries)=
.
>
> I was going for the most space-efficient and simplest data structure,
> which is bitmap. I believe xarray is either pointer or integer between 0
> and LONG_MAX? We could convert the individual bits into integer and
> store them, and have another function to extract the integer stored in
> xarray to a bit, but I think thats basically a separate bitmap_xarray
> API (which would probably take more space than a traditional bitmap API,
> and I dont want to make this series dependent on something like that),
> so I would prefer to use bitmap.

I believe Matthew meant reusing the xarray used by the existing
swapcache, not adding a new one for this purpose. See my response.

