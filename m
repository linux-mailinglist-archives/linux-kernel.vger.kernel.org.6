Return-Path: <linux-kernel+bounces-333907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9CF97CFC3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 03:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483991C232D4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB69AD51;
	Fri, 20 Sep 2024 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7AexSrZ"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE33C625
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726795451; cv=none; b=kfUCnAjbHSaJzRydyA/Am5V6aoGjTWxhjgjT0CA1kSK3i8fHOAuQATbYlmeYjIqLyESPzrJ6NzQvI/1MIWAQe+DvFzxai2gDSShQVKWJcwsnETRSnmbh/6mQQ85xZno1G9V01rLDaOvEOH1cccemXZ4WyRelwJhsEpypDAz9Vpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726795451; c=relaxed/simple;
	bh=AzkZSflXBjly92tkG9lH0PnqaFL9d4/V3oNosNLR5UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2ci5NFEMKQpUb8JpQVsIQ3aCxkYLy9eW4CayvCWjnrFQgMOIDG0etmAMiGO3kNU4tdlsgGEbb6sndK03FcJT0oySyHi1Aw2J4uXmF4iWybXfN/UubhTK7omzrKAy9Ni589ARjdO9I1NdXBtv72PycLdrgBCOJ1KpmX3T5eMIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7AexSrZ; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-846c5c2a8e9so337327241.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 18:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726795449; x=1727400249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzkZSflXBjly92tkG9lH0PnqaFL9d4/V3oNosNLR5UM=;
        b=L7AexSrZtQ7rnr+Md85mAxC0qfuWFcheDhXFvVTBSyYb1N9g3O+P0wBDjio31u6P8W
         eA7P+RzjqHplCizuObiZG8XzmvbUrVAvMsok18KnpVEdNeEQVvl6CFHCKoeOnrUuI1QQ
         0OE+2ZgeFQAiTe3iRwE0i72a0c3GkJIdkT78ynMyWUhDbZJY3Xa2w2qWZx9LCpo1Orx2
         RRCak83i6RnCBsogmOJ6ojYaThKAZ6UZvyEO5SXTUXORowSfg6R4u+4JQ9PmTw8pR0YS
         CnmRrdp2l+FKjFFC3TfiefQAZ9KDdu+UhAb8c8u7S5rdZZdydAqtWhV+2yGUtvw4seg8
         qXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726795449; x=1727400249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzkZSflXBjly92tkG9lH0PnqaFL9d4/V3oNosNLR5UM=;
        b=PcIGVtHU0ByzBNLpEqnWr7SSV3LH0D3iHtOGRl58k06cDKAwtTypEN4N81pBghNcSK
         0ujt3qQlQaJT7GGjvDyEQNfEtvMg5ZkSD1PRBkE2Soy0FTWhs3i/LNpYdZgpV9v5/FIH
         PcPSBLJM8wuj89BLEYGNH9tL+BFMspjcCOfDFZUDrVd4mUsU3dXdBwf5IB/zhJPdTAXl
         XeNUM01ymnPIjqEAWe9/cpiFzKHMS+n3cRBXQEXuu154JwsHi2joN/WBxKkoZdIo8+hw
         lps/tRtKcO+05He7o52o8DdE78wZAIhTBdqIPQAQvUHBKOC6gSoMtm0yfzm6YmfQ0+DL
         Fisw==
X-Forwarded-Encrypted: i=1; AJvYcCX71Ka0mIWEBJnh70G8IPTjv9zu90fprQVp+3nyIxUzugKSvQHMf+Bj43zGOwXUmseHijxAgZZ+LazGvSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFrSHkddLCtOGuoDdtQO1Y2u3c9CCiG0mrFlmGZMOrJg0ZHPF
	aabatAzXb75OmFUk1WQYv1hVZBZ2AdcAYeAIsPEfwf7yTyeLlYCYdboEkfl3CXT3mv8dF2zCHX+
	X0pcKFQ+kvth+McWeIWNWZ/7SKTM=
X-Google-Smtp-Source: AGHT+IFUNLr3vEjbLt0YkTQCpqSxtunUvo+MgiEZYImWolTuoGNUXjLxkjHDmhCSBVsZShkd6eZ0m8VhQFixiY/PCy8=
X-Received: by 2002:a05:6122:901:b0:503:9ccf:f2b6 with SMTP id
 71dfb90a1353d-503e40ba7efmr422098e0c.6.1726795448779; Thu, 19 Sep 2024
 18:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914063746.46290-1-21cnbao@gmail.com> <92f97c8e-f23d-4c6e-9f49-230fb4e96c46@redhat.com>
In-Reply-To: <92f97c8e-f23d-4c6e-9f49-230fb4e96c46@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 20 Sep 2024 13:23:57 +1200
Message-ID: <CAGsJ_4zdqXtvUS8fHzUhM=iGrPpC8X7uw8wt4sSfCvsrh7um3w@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mglru: provide a separate list for lazyfree anon folios
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, mhocko@suse.com, 
	fengbaopeng@honor.com, gaoxu2@honor.com, hailong.liu@oppo.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, lokeshgidra@google.com, 
	ngeoffray@google.com, shli@fb.com, surenb@google.com, yipengxiang@honor.com, 
	yuzhao@google.com, minchan@kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 12:02=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 14.09.24 08:37, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > This follows up on the discussion regarding Gaoxu's work[1]. It's
> > unclear if there's still interest in implementing a separate LRU
> > list for lazyfree folios, but I decided to explore it out of
> > curiosity.
> >
> > According to Lokesh, MADV_FREE'd anon folios are expected to be
> > released earlier than file folios. One option, as implemented
> > by Gao Xu, is to place lazyfree anon folios at the tail of the
> > file's `min_seq` generation. However, this approach results in
> > lazyfree folios being released in a LIFO manner, which conflicts
> > with LRU behavior, as noted by Michal.
> >
> > To address this, this patch proposes maintaining a separate list
> > for lazyfree anon folios while keeping them classified under the
> > "file" LRU type to minimize code changes. These lazyfree anon
> > folios will still be counted as file folios and share the same
> > generation with regular files. In the eviction path, the lazyfree
> > list will be prioritized for scanning before the actual file
> > LRU list.
> >
>
> What's the downside of another LRU list? Do we have any experience on tha=
t?

Essentially, the goal is to address the downsides of using a single LRU lis=
t for
files and lazyfree anonymous pages - seriously more files re-faults.

I'm not entirely clear on the downsides of having an additional LRU
list. While it
does increase complexity, it doesn't seem to be significant.

Let's wait for Gaoxu's test results before deciding on the next steps.
I was just
curious about how difficult it would be to add a separate list, so I
took two hours
to explore it :-)

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

