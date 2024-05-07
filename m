Return-Path: <linux-kernel+bounces-171905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDFB8BEA52
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE9B1C23B9F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE31607B3;
	Tue,  7 May 2024 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlvXGbvw"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC113D63B
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102267; cv=none; b=CJn5LXXRVXWhlZk6ZbSIrgDFy+FOts+J40PZzWpEmqSm9Dd+bdawO8iPCl/1MU+BZWso5X3Ltd9tPU+hRCfcg6V/GJeBgbBO7q1RljxiOq4E+bW+RtD+JL6edF1QTp0wHwR7vh9fk9EjgjQV3a+WPv5LS4v+7Eaown+EGcT4NV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102267; c=relaxed/simple;
	bh=Wxsc7dN4OIswSJE2MtNAs04aLoVPOnnvcVBuaHnxab0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKVeuZAJCENgrZSgCp7MAd6f1bzH40llqH31+TNrJsVh8ZZN+bgL5hoj8ZBl/BDgeQgo0rVgb/j2sVMHIukdwF/UyZ0CNrU+PPr53RMTM7YtJhMjqJd8lNFDmr1mnHEKb2ud1+P1HFDwjdm902ussp4cKDtFa25xFGy7oFUUlNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlvXGbvw; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5206a5854adso2813907e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715102264; x=1715707064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wxsc7dN4OIswSJE2MtNAs04aLoVPOnnvcVBuaHnxab0=;
        b=MlvXGbvw+fdH08WBBnJ58qn6Vv88Ue51FEWVptnWwRDlgbqhOfmcJDNZB9ArVsEqJ5
         CCDwOJ6RuOZDaB6xir2zzGs9ASe+/u6dZReYeSqSzq65M/cp/+gw6ydyphUEqV+dU4u+
         rLX4tJMcDryic4Di4pkTtYSf66eQq2QrxhXzfa0a3WCJ72UnccfMxBe1z7ffpRHJCeH+
         b94tFGQ97TxbqxPa1614huJPzL5orhUjmqKZ/AVZbR6eeUvg6pgy0G9tfDWcWjKrECBB
         c98gbfYBKeLGp0+m/H2sQk2/o+bekfZAmjS/HURO2iMmS78Sqv59Fyfrfi1sISlixbWm
         X6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715102264; x=1715707064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wxsc7dN4OIswSJE2MtNAs04aLoVPOnnvcVBuaHnxab0=;
        b=sL1AjPaNxG9yLMvAUIyWGpn0NyQiMHk9xcEsi3o8WQPbstXAu214xV6MfQDMI0vUG9
         xGfQOp5BshtO+LC6t9ZRaJ+AfjiRAiaWPjYSI0hSVePitVOUVzoSzCjE5+q3Qv+ZKWoc
         PMe0F76uCD0IvLYwdVUyIjllROGfTl7Yf+pWXJbzd2HDji3kCotESx4+OedYzQIyz79m
         V0RdvOtA3seQShOIWu+f+ZKsCYxnvbsy6ZNqaDmg5418QE/Br2+OVZb6Fv16NMYnurOZ
         Xjn8klsUdMT80A4NTvhZxzTVGhG0tsmE5jDAY7D6MGy7qzTVostK9bffx+tTm4OFfkhd
         8lUw==
X-Forwarded-Encrypted: i=1; AJvYcCUWmBKmICOf+1IhXazK8XPc63qBADzqc2Unyz6cGaAEaZ09YkWPNfF4iZ/jiaCWzaDBbbqSBfvt4K5zEpCjsxvoiXzYWMNjTNpqABxw
X-Gm-Message-State: AOJu0YyrX3+0A+qRk3Fy+F51Dg8VWH4IBkqY5Z4qtMyLP4WIM36qiIwl
	j2Q1z+/hNGM2TBdGHe6PL1EwM5k2+fqY/5EvXLrulOAqT6KNpHWG+NeJXl5PiHgS33LkqskzJ2g
	hR4viFFqGZ1uR7UX8abBfX1rLIhE=
X-Google-Smtp-Source: AGHT+IHVwKMCSFFBxlt95XXjiIUjjLsx3T4M43BlxdbErkVnuwQChSJWblnS5btztEvxe9Ned7nhidvJJtYHyi/LhbQ=
X-Received: by 2002:ac2:5df1:0:b0:51d:b7fc:29a6 with SMTP id
 2adb3069b0e04-5217c3714e9mr124940e87.7.1715102264281; Tue, 07 May 2024
 10:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com> <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com> <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
 <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com> <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
 <b84e2799-2b6c-4670-b017-3a04ec18c0f2@arm.com> <dea802da-2e5e-4c91-b817-43afdde68958@huawei.com>
 <1dc9a561-55f7-4d65-8b86-8a40fa0e84f9@arm.com> <6016c0e9-b567-4205-8368-1f1c76184a28@huawei.com>
 <2c14d9ad-c5a3-4f29-a6eb-633cdf3a5e9e@redhat.com> <da24d8bb-3723-48fa-86f4-8b24457d3556@huawei.com>
 <2b403705-a03c-4cfe-8d95-b38dd83fca52@arm.com>
In-Reply-To: <2b403705-a03c-4cfe-8d95-b38dd83fca52@arm.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 7 May 2024 10:17:32 -0700
Message-ID: <CAHbLzkq9BQFfpjxG_ozrgzWOO3XJmtre-mgY03McY6guVn7U9g@mail.gmail.com>
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP boundaries
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, 
	cl@linux.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Ze Zuo <zuoze1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 8:53=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 07/05/2024 14:53, Kefeng Wang wrote:
> >
> >
> > On 2024/5/7 19:13, David Hildenbrand wrote:
> >>
> >>> https://github.com/intel/lmbench/blob/master/src/lat_mem_rd.c#L95
> >>>
> >>>> suggest. If you want to try something semi-randomly; it might be use=
ful to rule
> >>>> out the arm64 contpte feature. I don't see how that would be interac=
ting
> >>>> here if
> >>>> mTHP is disabled (is it?). But its new for 6.9 and arm64 only. Disab=
le with
> >>>> ARM64_CONTPTE (needs EXPERT) at compile time.
> >>> I don't enabled mTHP, so it should be not related about ARM64_CONTPTE=
,
> >>> but will have a try.
> >
> > After ARM64_CONTPTE disabled, memory read latency is similar with ARM64=
_CONTPTE
> > enabled(default 6.9-rc7), still larger than align anon reverted.
>
> OK thanks for trying.
>
> Looking at the source for lmbench, its malloc'ing (512M + 8K) up front an=
d using
> that for all sizes. That will presumably be considered "large" by malloc =
and
> will be allocated using mmap. So with the patch, it will be 2M aligned. W=
ithout
> it, it probably won't. I'm still struggling to understand why not alignin=
g it in
> virtual space would make it more performant though...

Yeah, I'm confused too.

I just ran the same command on 6.6.13 (w/o the thp alignment patch and
mTHP stuff) and 6.9-rc4 (w/ the thp alignment patch and all mTHP
stuff) on my arm64 machine, but I didn't see such a pattern.

The result has a little bit fluctuation, for example, 6.6.13 has
better result with 4M/6M/8M, but 6.9-rc4 has better result for
12M/16M/32M/48M/64M, and the difference may be quite noticeable. But
anyway I didn't see such a regression pattern.

The benchmark is supposed to measure cache and memory latency, its
result strongly relies on the cache and memory subsystem, for example,
hw prefetcher, etc.

>
> Is it possible to provide the smaps output for at least that 512M+8K bloc=
k for
> both cases? It might give a bit of a clue.
>
> Do you have traditional (PMD-sized) THP enabled? If its enabled and unali=
gned
> then the front of the buffer wouldn't be mapped with THP, but if it is al=
igned,
> it will. That could affect it.
>
> >
> >>
> >> cont-pte can get active if we're just lucky when allocating pages in t=
he right
> >> order, correct Ryan?
> >>
>

