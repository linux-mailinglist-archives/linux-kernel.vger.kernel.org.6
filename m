Return-Path: <linux-kernel+bounces-204779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B628FF373
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0901C21AF0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8F61990A2;
	Thu,  6 Jun 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E99QoOUo"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D6198E86
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694062; cv=none; b=Y5a0RJkEHDijawD6oEfwMJL6Rhhaul1HznQQiCxHl9prKKj4T5zBy10OsAwL92i5OLR04eFHqmZ22l8kMGEsVcA8Xe2OZiT/k/TwqIWWcOrmBbxxmU8Z4GUq93Qw+QrIWy4VoaT8ctLQzNyLJGSuTMOJfrEFsDBjCdhmt/1C9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694062; c=relaxed/simple;
	bh=+/1l2hgdu4GOtQ+Ob2oTmSMpsc9q1e6vX4IAFQSksuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXG9dyCwmry3UXp0/yq3h68IV0n74CeQEtyrgMbGbXmogDVzUjPxB8KlXEnR4LtNRcBEb0qE4f/9e5CvGrEDicwCv9FqQXAdxSHFhjaOgn16R4XkDK2Ie0yUNTazQQ/LHDVO9YI35jZte87eRQpTwZJ5kRHNKteHMq+idwxXiGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E99QoOUo; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d208a05f97so728094b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 10:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717694059; x=1718298859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/1l2hgdu4GOtQ+Ob2oTmSMpsc9q1e6vX4IAFQSksuY=;
        b=E99QoOUofKUzp//EMJk4mjJew1LALIfQ4uPwYM+Z8yUmKdjR7Usp+fjIRtAohTOX2N
         MvpkyDeBgfoTwcCt2y13Ct+RWoiLhwrjv/HsC1vx/SZbW7VP1dX5nwrFvD3vjgL2AQ8Z
         7gUIJrztOU/fA15oVsHuezvxA/ePprT+8yOdCem338+LVV+ZX/H9ntrIio+x8FvBw9A1
         9BFiNT8acXhFwaUr/pfLNWrOlsJpm5Ew7C3+fWHzJpoiXajaSltMn/z19O9IcIOuVgbd
         +Vc7MkD+SOHaL6eCcWumfKcTV2mZaVlsbHFrrTvUVMh826YnYT/tQ47NLLpzY21gTplJ
         nYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694059; x=1718298859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/1l2hgdu4GOtQ+Ob2oTmSMpsc9q1e6vX4IAFQSksuY=;
        b=Hf7IHoWChZOSDb4dhcWhHltUxynJXNiek6Q0p2mbkkx6VBtl+vR6FBUeoJ2d5QXvc8
         2XR9LkX/gUjHsWdDUbYmVPAZSBrI2abUeceOulwrLn1pYnDsVKVJL9V5swFwHYbrd3yK
         ktigkmbUPjg+GPvo1LkEXIrpoJm1bVtTw950vJY3FkuQiR/8Ferer0tDAnkdjldoF0ks
         316n8XK8TC1CHEaK3hfZnPRhQReCUjFmR/BG7AwZmmk65vnpVnpsUzz4dctBZA9jR0aj
         gNqKPfL2AQ/tb+Y74aAMtIa0KitcnQ6FgQDR1K792KQwQaTlKTE4F2zGESRAy/oUyg8w
         anTw==
X-Forwarded-Encrypted: i=1; AJvYcCX7jj4bbVnpdiqUV1Q7++9NmV91+ZRfaikqjSvzOglSCYBwqvKdhe+jdjQRIeAHLKq6q8rdd5CQT/YKGHHItJd+EJ6COryzcjA2fIbc
X-Gm-Message-State: AOJu0Yy+Ku3+gymX7spi+ZQgXbJlZRSNi0eIKOvdFv+H7UHi5VEU6rRG
	74OSgA7xMVJekeBllX49klaUMsS5zANXw0yrgtkND5t6cqaP7eERZ62Ffbo57hLw2/BbO1118S0
	R14j5iP+ELe1M+pi6W+cMKXdYpJW3OLlpCifDMqQG
X-Google-Smtp-Source: AGHT+IFWj6gKymPuX65qB3SLiTcr/L24kWgHP0A2qAXzrNU1UqM44JmLCxgMounxH46aeClTSRC9dMKKMGyWy81enQM=
X-Received: by 2002:a05:6808:618:b0:3d1:e059:fec6 with SMTP id
 5614622812f47-3d210d2b29emr63262b6e.3.1717694059455; Thu, 06 Jun 2024
 10:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
 <20240604134458.3ae4396a@yea> <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea> <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea> <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
In-Reply-To: <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Fri, 7 Jun 2024 02:14:07 +0900
Message-ID: <CAPpoddc2vOLdQJ7HwG7x+=oZsTz221+YJcNbUtKvPjA9AyeY2w@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Erhard Furtner <erhard_f@mailbox.org>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B46=E6=9C=886=E6=97=A5(=E6=9C=A8) 8:42 Yosry Ahmed <yosryahmed@g=
oogle.com>:

> I think there are multiple ways to go forward here:
> (a) Make the number of zpools a config option, leave the default as
> 32, but allow special use cases to set it to 1 or similar. This is
> probably not preferable because it is not clear to users how to set
> it, but the idea is that no one will have to set it except special use
> cases such as Erhard's (who will want to set it to 1 in this case).
>
> (b) Make the number of zpools scale linearly with the number of CPUs.
> Maybe something like nr_cpus/4 or nr_cpus/8. The problem with this
> approach is that with a large number of CPUs, too many zpools will
> start having diminishing returns. Fragmentation will keep increasing,
> while the scalability/concurrency gains will diminish.
>
> (c) Make the number of zpools scale logarithmically with the number of
> CPUs. Maybe something like 4log2(nr_cpus). This will keep the number
> of zpools from increasing too much and close to the status quo. The
> problem is that at a small number of CPUs (e.g. 2), 4log2(nr_cpus)
> will actually give a nr_zpools > nr_cpus. So we will need to come up
> with a more fancy magic equation (e.g. 4log2(nr_cpus/4)).
>

I just posted a patch to limit the number of zpools, with some
theoretical background explained in the code comments. I believe that
2 * CPU linearly is sufficient to reduce contention, but the scale can
be reduced further. All CPUs are trying to allocate/free zswap is
unlikely to happen.
 How many concurrent accesses were the original 32 zpools supposed to
handle? I think it was for 16 cpu or more. or nr_cpus/4 would be
enough?

--=20

<flintglass@gmail.com>

