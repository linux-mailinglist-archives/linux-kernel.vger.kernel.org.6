Return-Path: <linux-kernel+bounces-317627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFADD96E13E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D83B261DD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604FE1A38D8;
	Thu,  5 Sep 2024 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvm5EpLb"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49919D06D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557808; cv=none; b=WSdxctRPDVCMhR6iWwpXCH36Iic+pN+7csdz3v3csZfoBMWfhYLh7E569UkZxyBuHORS9FULomQAJjYCuwX2HCzKt8DF6FicPo67Nrt66bpfCLvFXS+Rgzc6OV5sGI0XY1MlAJHWmUc+eSEvXzE61C+2n/XRiw6AZ7xSZfOM1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557808; c=relaxed/simple;
	bh=4iSlrb2nnX2YmeZ9VNADCnw8Fv2K8MPDBikeg5JmHUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtcNECINj5pbS6ySlXLpRFSG6Wyp/1AiA8dYLIQxfCzGTXrRqDfmGvyohG/XG/0dMiFcbe7v1QngKBPJVL9AZuGV8TGMCFp1W2aSRlmUVNQp6iCL2BdUQJxo7xboJNXey7D8P5mJhEkK3ebqmW3S9Qys1PkMFWN2NVmrOtXmjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvm5EpLb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so1125506a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 10:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725557805; x=1726162605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UM2g72fniLrPpHAJ7GqOnShEWlEjFXue9+ErTDOIp4E=;
        b=bvm5EpLbqxM9TVcEiAugGaX3J3BjqeJadEDiXUCpzZA1Snib2Wy5mkqscBY0kKeutZ
         mfONx1LZmKEEH8P1zPCP36IZM0yZ+FyAnAryvIYH5sE9KDdFRP6tM0X1AZIhMjBfhtPD
         6N8E/cdzwMiQV6qVu4l/86b/yigYozQ4kENiJ8bO2z9ZkEU5a4sCcC2ffCzBDOx8hjee
         rR+QsjwQYLrJSDMdtVb8chBiMRXoJchL08XqXEpkpyvpedFVaERtAfq/qjuoJZvTkkIq
         QBbMf1xL/A3QT88xuOa8maVZ09w2XnVukp3WdKYPE4iqGwwro+Jt1otGsNpLE4EQvvUj
         kzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725557805; x=1726162605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UM2g72fniLrPpHAJ7GqOnShEWlEjFXue9+ErTDOIp4E=;
        b=o4Cz9SCg8tqsNXksJTdNLL+3+yfZZDaIwucGWoTJVlywv3nmrjDMvOpt6uQk52lR+v
         +XKQFiX8PSqmN1zrhUX6FN64HdsVUO8YiIVCJK2ui7l5mhJxg+kA5/x3ky3hYorHGGkf
         qmQQMSFg5g+fYnWSUjNH7QLVDqtW5G4dO0P3xv3dbmrdveWrSoj3zQPOsljmqKPagNFs
         GtBaUXNQlMUh17Pg462dMCkxUUFRiFHaYxvnIlD04FTfaLrfGOqQnemxPRQ+ifEYfS6d
         0arJ3fATdfTeJkpGcBD4o4Oju2VsAP66zJ7H2eKCg6yXA7KY/4zGUDtQaLh7+plydEHp
         cFhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7Zim8ORc23okcNcI+VZc+C70+UkHHZu3K7ejwNdlkfypnNcmwmdDsG2IRcATHcq6ujMkXElF5S11qoAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSAl04IYaZFwWiRV0YJ5Ngq2JEbnqd0ePoR5nX/Rwa4HD9crIY
	DQsjOLlXBXFkRFYuEDk602AEYcY/6a3l3dmtg2hR0PKsMEm43Xfb5f/6sswO6PiPre6jAO7LVSf
	SkkOcxf70p0r6f2fPjHbSnGSC2I9qRfYQ8xQ3
X-Google-Smtp-Source: AGHT+IFVsqcC5vgfkAPbLy2xZ2+kBQWZCMyiZeQj3BWOgktt31rtTCQagTWJ4wB/saFVJsnWxjIs9RgWKzTHkeYsYBI=
X-Received: by 2002:a17:907:d5a5:b0:a77:dd1c:6273 with SMTP id
 a640c23a62f3a-a89a3512fedmr1532468766b.12.1725557804885; Thu, 05 Sep 2024
 10:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com> <CAJD7tkYNn51b3wQbNnJoy8TMVA+r+ookuZzNEEpYWwKiZPVRdg@mail.gmail.com>
 <CAGsJ_4w2k=704mgtQu97y5Qpidc-x+ZBmBXCytkzdcasfAaG0w@mail.gmail.com>
 <CAJD7tkYqk_raVy07cw9cz=RWo=6BpJc0Ax84MkXLRqCjYvYpeA@mail.gmail.com>
 <CAGsJ_4w4woc6st+nPqH7PnhczhQZ7j90wupgX28UrajobqHLnw@mail.gmail.com>
 <CAJD7tkY+wXUwmgZUfVqSXpXL_CxRO-4eKGCPunfJaTDGhNO=Kw@mail.gmail.com>
 <CAGsJ_4zP_tA4z-n=3MTPorNnmANdSJTg4jSx0-atHS1vdd2jmg@mail.gmail.com>
 <CAJD7tkZ7ZhGz5J5O=PEkoyN9WeSjXOLMqnASFc8T3Vpv5uiSRQ@mail.gmail.com>
 <CAGsJ_4x0y+RtghmFifm_pR-=P_t5hNW5qjvw-oF+-T_amuVuzQ@mail.gmail.com>
 <CAGsJ_4zB7za72xL94-1Oc+M2M1RtxftVYUAUk=1yngUoK65stw@mail.gmail.com> <CAGsJ_4yBFpyA4Znfgr7V=eoHAnhuLPDTqaVOre9waTKZ+R3R9A@mail.gmail.com>
In-Reply-To: <CAGsJ_4yBFpyA4Znfgr7V=eoHAnhuLPDTqaVOre9waTKZ+R3R9A@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 5 Sep 2024 10:36:08 -0700
Message-ID: <CAJD7tkZWpWtim72u74AM67E1yEZ49-2EnDUgoDuaf-X=aYUFmQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Barry Song <21cnbao@gmail.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"

[..]
> >
> > /*
> >  * Return the number of contiguous zeromap entries started from entry;
> >  * If all entries have consistent zeromap, *consistent will be true;
> >  * otherwise, false;
> >  */
> > static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry,
> >                 int nr, bool *consistent)
> > {
> >         struct swap_info_struct *sis = swp_swap_info(entry);
> >         unsigned long start = swp_offset(entry);
> >         unsigned long end = start + nr;
> >         unsigned long s_idx, c_idx;
> >
> >         s_idx = find_next_bit(sis->zeromap, end, start);
> >         if (s_idx == end) {
> >                 *consistent = true;
> >                 return 0;
> >         }
> >
> >         c_idx = find_next_zero_bit(sis->zeromap, end, start);
> >         if (c_idx == end) {
> >                 *consistent = true;
> >                 return nr;
> >         }
> >
> >         *consistent = false;
> >         if (s_idx == start)
> >                 return 0;
> >         return c_idx - s_idx;
> > }
> >
> > I can actually switch the places of the "consistent" and returned
> > number if that looks
> > better.
>
> I'd rather make it simpler by:
>
> /*
>  * Check if all entries have consistent zeromap status, return true if
>  * all entries are zeromap or non-zeromap, else return false;
>  */
> static inline bool swap_zeromap_entries_check(swp_entry_t entry, int nr)
> {
>         struct swap_info_struct *sis = swp_swap_info(entry);
>         unsigned long start = swp_offset(entry);
>         unsigned long end = start + *nr;
>
>         if (find_next_bit(sis->zeromap, end, start) == end)
>                 return true;
>         if (find_next_zero_bit(sis->zeromap, end, start) == end)
>                 return true;
>
>         return false;
> }

We can start with a simple version like this, and when the time comes
to implement the logic below we can decide if it's worth the
complexity to return an exact number/order rather than a boolean to
decide the swapin order. I think it will also depend on whether we can
do the same for other backends (e.g. swapcache, zswap, etc). We can
note that in the commit log or something.

>
> mm/page_io.c can combine this with reading the zeromap of first entry to
> decide if it will read folio from zeromap; mm/memory.c only needs the bool
> to fallback to the largest possible order.
>
> static inline unsigned long thp_swap_suitable_orders(...)
> {
>         int order, nr;
>
>         order = highest_order(orders);
>
>         while (orders) {
>                 nr = 1 << order;
>                 if ((addr >> PAGE_SHIFT) % nr == swp_offset % nr &&
>                     swap_zeromap_entries_check(entry, nr))
>                         break;
>                 order = next_order(&orders, order);
>         }
>
>         return orders;
> }
>

