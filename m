Return-Path: <linux-kernel+bounces-288731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FECB953E14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5586F1C21D82
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB51156C65;
	Thu, 15 Aug 2024 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2fLnwzB"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63A370
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765816; cv=none; b=s+7s45RrC2kuoQF3+A1eHbwSvg+dIDbvoeMBv7xRrqWnXGA/I1jJ+N2wqd1R0rSQJeldpcO+nFx8j+bnvQlvLhEhx7JzMu0h6TBB9tKdONeNnFg2JWec8ccjJmHbyy7Bfo3JLrVs61kYZscia4azQeX+NSjXfH+w/INKrSkg3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765816; c=relaxed/simple;
	bh=SZDPhOIdPJCyArxQ9COi/h7zib5gBYIY6G0irQv18bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYhek1+MBomBIdGP27CoF2/2zJIvQ24mG6bPeontFzJBFk/7MBZY+dQUrftm31MAVyXxMQEBz36L8eyZw+XJT1yOSLTN+tur+mWLkm4aZRDlGaNJuzQKWvytYpdiBrrscT0rSg8JC7Lc87aCckgEIpNW3PILWuH7BFdfwtCa+co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2fLnwzB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70eaf5874ddso1242850b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723765814; x=1724370614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXW9s6Cf+sYC+rm2Tr0W88BqGARgUcJhbSNatwBSpV4=;
        b=m2fLnwzBjEEo9Z5Pmg1LqJIwDd5wZozILGkq4+VUSvL4owCDW7+ORDQ45KBVhasjXY
         grFL4mVs6REBc/OVao+WKmaxtE/PlaFVZ4jbgIfBoH3E8igc4Dpj3HJKAbv/3dtXvOZp
         nhtfZI1NU8IymRvlewV4jM0Y2I6ons0xMQXl74kq0HT4/2HtwaFVH4NNeV42nN7n7yv0
         1qBSJAj7EQV31U4DJFJ7xGpP3rhVf8ULAYk4kNTR1CaBhQkkxDiqUmHoVUMfLoZl1Jwi
         BMIqERCJvLuRgX4lyDYaV34zK/4o7qJlKJYb+Z/ToyXOvISRuiXWd/tYoyb7uUbumHj5
         kMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723765814; x=1724370614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXW9s6Cf+sYC+rm2Tr0W88BqGARgUcJhbSNatwBSpV4=;
        b=tjeItjdVjlZpBnDzcYQJNZ3X5HN5i85zSgBgRpfc37HGpntP8UVKCBoYTmiAE+poYn
         1nUdRO8lR7NwZxaILjrlvosfg3USlpF4PtKClkws1ezzp5Zb+RBVh3joEGmSWBbmbsy1
         f3wEHORMDvHRGxHkgqZ732ZddCeh0fPqm7ryNP1Ft8RBFA5H7980oEPma5o4N+sKC3Q2
         2IZNEwt3uGGtN/WHzwXGOibu98GaYHVl4FUdlWCnjhtmMTekUkj+sJoQc5toC9MkzsXq
         VjGa8WCMjQcI07bcbSapsA1EnH7M6U850df42qw+buCXGpMsUifubgOoMxNLyZeaQt/K
         km1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYl70QJY/Y+uZoMDD/Q6Yue9qIFXEnG7TV3nbtZ6Duu0hQ4g13sbALVp9Qafwox1cPgbA7V5MAozcZ7cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcEZ7unFYT5GOVoVxzM73cyY4gj90BMuNYgZgIXN9ZN/TFYXx
	WBV3UdKC5c2nnCcqk13lujgW+1S6ZWCD3oAK6uLAhi15SjAbHSAM
X-Google-Smtp-Source: AGHT+IEYZSWvtE5ZNK1eCqLALbCYPnafx6mp4YMq/5DLNOtLNi+A0QIk7Jld2h+9aJJNVkLomKvT4Q==
X-Received: by 2002:a05:6a00:9448:b0:710:5889:9c62 with SMTP id d2e1a72fcca58-713c4d89b16mr1565578b3a.6.1723765813942;
        Thu, 15 Aug 2024 16:50:13 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0e220sm1548204b3a.74.2024.08.15.16.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 16:50:13 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	corbet@lwn.net,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com
Subject: Re: [PATCH v4] mm: Override mTHP "enabled" defaults at kernel cmdline
Date: Fri, 16 Aug 2024 11:50:00 +1200
Message-Id: <20240815235001.96624-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6e23c705-3d67-419b-b085-f19f5101124c@redhat.com>
References: <6e23c705-3d67-419b-b085-f19f5101124c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Aug 15, 2024 at 10:26 PM David Hildenbrand <david@redhat.com> wrote:
>
> >>> +static inline int get_order_from_str(const char *size_str)
> >>> +{
> >>> +     unsigned long size;
> >>> +     char *endptr;
> >>> +     int order;
> >>> +
> >>> +     size = memparse(size_str, &endptr);
> >>
> >> Do we have to also test if is_power_of_2(), and refuse if not? For
> >> example, what if someone would pass 3K, would the existing check catch it?
> >
> > no, the existing check can't catch it.
> >
> > I passed thp_anon=15K-64K:always, then I got 16K enabled:
> >
> > / # cat /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enabled
> > [always] inherit madvise never
> >
>
> Okay, so we should document then that start/end of the range must be
> valid THP sizes.

Ack

>
> > I can actually check that by:
> >
> > static inline int get_order_from_str(const char *size_str)
> > {
> >       unsigned long size;
> >       char *endptr;
> >       int order;
> >
> >       size = memparse(size_str, &endptr);
> >
> >       if (!is_power_of_2(size >> PAGE_SHIFT))
>
> No need for the shift.
>
> if (!is_power_of_2(size))
>
> Is likely even more correct if someone would manage to pass something
> stupid like
>
> 16385 (16K + 1)

Ack

>
> >               goto err;
> >       order = get_order(size);
> >       if ((1 << order) & ~THP_ORDERS_ALL_ANON)
> >               goto err;
> >
> >       return order;
> > err:
> >       pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
> >       return -EINVAL;
> > }
> >
> >>
> >>> +     order = fls(size >> PAGE_SHIFT) - 1;
> >>
> >> Is this a fancy way of writing
> >>
> >> order = log2(size >> PAGE_SHIFT);
> >>
> >> ? :)
> >
> > I think ilog2 is implemented by fls ?
>
> Yes, so we should have used that instead. But get_order()
> is even better.
>
> >
> >>
> >> Anyhow, if get_order() wraps that, all good.
> >
> > I guess it doesn't check power of 2?
> >
> >>
> >>> +     if ((1 << order) & ~THP_ORDERS_ALL_ANON) {
> >>> +             pr_err("invalid size %s(order %d) in thp_anon boot parameter\n",
> >>> +                     size_str, order);
> >>> +             return -EINVAL;
> >>> +     }
> >>> +
> >>> +     return order;
> >>> +}
> >>
> >> Apart from that, nothing jumped at me.
> >
> > Please take a look at the new get_order_from_str() before I
> > send v5 :-)
>
> Besides the shift for is_power_of_2(), LGTM, thanks!

Thanks, David!

Hi Andrew,

Apologies for sending another squash request. If you'd
prefer me to send a new v5 that includes all the changes,
please let me know.


Don't shift the size, as it can still detect invalid sizes
like 16K+1. Also, document that the size must be a valid THP
size.

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 15404f06eefd..4468851b6ecb 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -294,8 +294,9 @@ kernel command line.
 
 Alternatively, each supported anonymous THP size can be controlled by
 passing ``thp_anon=<size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>``,
-where ``<size>`` is the THP size and ``<state>`` is one of ``always``,
-``madvise``, ``never`` or ``inherit``.
+where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE and
+supported anonymous THP)  and ``<state>`` is one of ``always``, ``madvise``,
+``never`` or ``inherit``.
 
 For example, the following will set 16K, 32K, 64K THP to ``always``,
 set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d6dade8ac5f6..903b47f2b2db 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -953,7 +953,7 @@ static inline int get_order_from_str(const char *size_str)
 
 	size = memparse(size_str, &endptr);
 
-	if (!is_power_of_2(size >> PAGE_SHIFT))
+	if (!is_power_of_2(size))
 		goto err;
 	order = get_order(size);
 	if ((1 << order) & ~THP_ORDERS_ALL_ANON)
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry


