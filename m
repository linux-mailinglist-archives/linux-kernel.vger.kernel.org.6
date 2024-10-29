Return-Path: <linux-kernel+bounces-387445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDD89B516C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C755F2838DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0B1DC06D;
	Tue, 29 Oct 2024 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8kRZ40L"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994B1D63F9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224543; cv=none; b=YMO9I6kl+CLKGjBxn7WzUD046hjxWTlSowuU3mUIAZnzNuJTN4Xf3Uod1KvfZAZzswyd73TYeuBOxE+jtSpBs9KUjOJScQU3tl+Y/jDv+EcoItLj9eayVXiCA2hGTHKPJ1UAzlBe6Fh55mLTihlj4VR0xofmkRQmjjcBSD3gYgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224543; c=relaxed/simple;
	bh=TWizXjh7MMKlGpScIu+bnk4puSeswl1Ahkm2QmAqlO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkNZQkYFVaNsiwSpW09PMhtP5BkT3T/X9EbJRuoHdsakKQ+7/3+LDzVden+hez94TY6oZv/rdrWxyJlsJ2a05d1YxgNl+n7iAuPnCrJjKYaD5DStGNbz03NXg0sJn3e9GWm5qnMtBv1fcSwoZhf0MNgGUJUfKf8161wwpQmdz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L8kRZ40L; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbf340fccaso830076d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730224540; x=1730829340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TWizXjh7MMKlGpScIu+bnk4puSeswl1Ahkm2QmAqlO4=;
        b=L8kRZ40Lm8i6FCT5+JBQJPcgd/LgMjIICaHr1ri/uS78qv9vzUoKS8Je7jyJCbjtW4
         ETg60fcNW6j1AqhhKHvlo8z7YkcLxj6tDwl6IgqmxXmC55vVwPC7ixNT4oTgOueXHY2V
         SUxB6hFYDpsCHBVxbSdhPtVbwR2598MTQm/sfhI0Wdf2pkAdOYTanhZlvOVpTkAQ7hX1
         ++Gdz/0jpIz7ifqZi6wFpgDBkSeK3yzi+v5dapTGiXPRV1hm1172+GgsacuE+ihfoXhY
         DA/FzXKRHnzJ1yZr4GxYq3OTySdjCITxxHEujeWaxBJPMIMJPlEmj5Cc5OYxZELIw5xX
         eKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730224540; x=1730829340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWizXjh7MMKlGpScIu+bnk4puSeswl1Ahkm2QmAqlO4=;
        b=FIqolMsX6TBdMf+peGxCm4Q8/AGLlUhI6X1t8/OfSr2z1yy5NOP54XdqWFJlQOdAzn
         PqreZPmxLDkJD0ygqkE0xfzA5juWlCY6OFsChgib0xBj7Ww56agqmLT/Emc4wssAOhcl
         x+QRJzN7AaFsnGJ+H4UV2fU4ZFS5W5Z7jgTGQl9931Vgg+QjP/HjUGmH8HRq0uW+T/QQ
         DNZDeGCNu9AkLbSfRo6fT3ev/Hz4OkUydzW5YxDxX5PmfgYKT02K4kAo6k+BI2z27jFb
         KO1xjgRlSEvfbLXu0rbS3sptj+s589hR48jmma5x5OLkouQv8NmMkIRob5/JsO8llVgq
         MMIA==
X-Forwarded-Encrypted: i=1; AJvYcCWkkj3KFVDz4ZBFQDnb0e7EUz1nhhWJk7b9WwDGkJKiRxvhNV+JEhGrfoyZrqA+hgBgVNfbw8CLILCKhOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvnPJgaJ1+tZLSD6b7UFlHLflMjW1AVKsZMG5xR2XPMOArp4RE
	+toczRnSrnSYrbqxLs/X+UsD2nrEm66RaeKNGZo2zv9kn+QmiLgI49W4FvUxUaXlsE1x3qgo53B
	pnmXZ1kKfcgn++o89i0Qbl7L0zuqP1aF8bVs9
X-Google-Smtp-Source: AGHT+IGnVqBio1zlKGUMToQfAK4cV8yQz2U2vGERd0VOLHEomgPLoa49Q6KNrjxkO7TF7Sp+1ac34yO6/sa++XFtBPc=
X-Received: by 2002:a05:6214:40e:b0:6cb:c9cf:cd40 with SMTP id
 6a1803df08f44-6d2b48b67d1mr52075746d6.8.1730224539928; Tue, 29 Oct 2024
 10:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027011959.9226-1-21cnbao@gmail.com> <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com>
 <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com> <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
 <6303e3c9-85d5-40f5-b265-70ecdb02d5ba@gmail.com> <CAJD7tkZpO1nEvdh7qPWt4Pg=FU1KZfEd3vA9ucEpqdc-7kF0Jg@mail.gmail.com>
 <64f12abd-dde3-41a4-b694-cc42784217fb@gmail.com> <CAGsJ_4zQmaGxG2Ega61Jm5UMgHH-jtYC4ZCxsRX6+QS9ta25kQ@mail.gmail.com>
 <882008b6-13e0-41d8-91fa-f26c585120d8@gmail.com> <CAGsJ_4yBkry-rw75AciT8OiYWrw+=D0okcxiyXzzNrz=QJxiBA@mail.gmail.com>
 <cba36cb0-66c7-45c1-97c3-a96ea48a6cf0@gmail.com> <CAGsJ_4wXO2Hjs0HZBGsGegBAeE8YxJbCF6ZXQQ6ZnVxgR82AuQ@mail.gmail.com>
 <228c428d-d116-4be1-9d0d-0591667b7ccb@gmail.com> <CAGsJ_4zLNA-1+3j4snNLiujT3NLcmKEVFA4+eD1Sk1bOkqAGYw@mail.gmail.com>
 <03d4c776-4b2e-4f3d-94f0-9b716bfd74d2@gmail.com> <CAGsJ_4zRZFpJ0rWQ3XzspfSXN6xXN4eftCdL3xHPTqqYLUhQcA@mail.gmail.com>
 <CAJD7tkYPB=2c23LMi1+=qrPO+rcr5zJB4+2TPrcjAZHhsm=Vsw@mail.gmail.com>
 <CAGsJ_4yxoBVEY-Zpp3YNbiCCwbKO+v3-9R984uGVRHAtMSLDLQ@mail.gmail.com>
 <CAJD7tkYmBgp5WK9pD=ap=WuqWiiHvEhG0N0J_TiYdGRNaxwLVA@mail.gmail.com>
 <CAGsJ_4yvWjkYNXu7+FkovEA3RGHu31g1DRAYtNdoQYKhnWcYwQ@mail.gmail.com> <CAKEwX=Mxh+G=6Yq_gSuSoB3XjpGepYEGPg-eYh1RU_690tGedA@mail.gmail.com>
In-Reply-To: <CAKEwX=Mxh+G=6Yq_gSuSoB3XjpGepYEGPg-eYh1RU_690tGedA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 29 Oct 2024 10:55:02 -0700
Message-ID: <CAJD7tkZWVUsQ0iq_kbpszJGtwXj9g=6A3EzxcB52NKBcja1MXQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Nhat Pham <nphamcs@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"

> FWIW, the swap abstraction layer Yosry proposed last year (and I'm
> working on right now) will allow you to store these zeromapped swap
> entries without requiring any swap slots allocated on the swapfile.
> It's basically the same thing as swap/zswap decoupling.

I don't know if I said this before, but thank you for keeping this
alive. Much appreciated :)

>
> Not stopping you guys from optimizing it, since all I have right now
> is a (most certainly buggy) prototype + there might be benefits if we
> can get around the swap subsystem altogether for these zero mapped
> entries. Just letting you know there's a backup plan :)

