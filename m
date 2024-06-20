Return-Path: <linux-kernel+bounces-222078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869AB90FC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CEE1F21664
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC4939ACC;
	Thu, 20 Jun 2024 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yk3hTnqR"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310D3BB22
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863965; cv=none; b=XfwB4H3kUgGVYQAzGRDD/NjnYRv2u/nZz9GFrYi+DGPdTxY1d0ybUI6emcUY42OncgZzmrA18bpU5B4xM1Md59ioIiflgRsmg+jYuQnD7Y5dR9CB0bfQkw7A4aEug5besIkzjgi+wKYo8nSkPI0gxeBCTQvSemeg1T6XgUEVQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863965; c=relaxed/simple;
	bh=bnwS0zZtUiFHEqo63k2vFUk3ZY0yjiiR6Tefx/0fJaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2E9lU1qLYQ1XRszK97L5SocAu6u+Ww7SyMie0r2ui8dBMe6b6/Je49DB1xwWfqih8vaQENauo67ZhM21ECeHDkj8/E9Meupg/lTuy7NQmzwOjhxlYcH9DLhkxi33rjeOYaltRRhexOWAE9109U2xkRkq/zsuEEutRC89LjR8S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yk3hTnqR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d00a51b71so22403a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718863962; x=1719468762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojZjb4RYoNn9RkUlQwL4cAo1p0U6fC/Z8le1JTxXLy8=;
        b=yk3hTnqRUXvJ7VnjMBrYxsgUjyAoRVv/nLx/UNKzcHEUMxIpQg4xXB0Is2SF5sVM0J
         3wRzW/F7AGzklsCe5p7kGKp5C+IZJ8Rt1IiYugsxYnXNmhYlqzdiz7ZW2tf98Zl+Hjlo
         Gm6NSUptwTZUBVMY8Ap0vEMUYpElSQL9Zl8pE4O9b7ktAsba9la6ayaxbzuLHiikonEY
         ZgVV1SVohsXIFsxS14JULswY7jfVTtVj66vzgWGNYUu4ix6QEkaYERO3s72D5pHw2HIJ
         S4VoOiBFPggeYZBs9g1Xh65vIHpvtsGVzMis+HX9aqWV2XWdgNf/EfEZyDazqrVboDMp
         y13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718863962; x=1719468762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojZjb4RYoNn9RkUlQwL4cAo1p0U6fC/Z8le1JTxXLy8=;
        b=pXXuTxMqBLIZ9xAxYtD1HnjsolOXFY/1FrL1RGfqGxXh7dEuUqIy2i3TT7cwawGrlt
         sE4+dXzLswt3YtoNk6P4Eyp9myj+/7EVfvkSEAWN28PTIyh1jjEan7xbQHdMdRSLMi5c
         z5OHGrILimd1F7AzsFOxztjgHlJ01ctBs+8LSI6IYcD1XNpEMF7lU4t0IxLEnUW87w8o
         yDEN8Yx/QlKrHIJ6XBJ1FATJlHwtekme2IIPbrU+bUXtHv0wfNeJZ3eLZlTAzDyh1kv5
         TuHWgIOTkT6iTYThXh1rl6Q++A5+NoU39oaMswA1pVdKJiZpjAIm3VmdyKyZ83/w3RXr
         Jlxg==
X-Forwarded-Encrypted: i=1; AJvYcCXjvMrTHcCLdMTPLLF/AJPDAY08KsSYwq33G6ayARKpYpcp/I9ck46c8aFFhLatJBnnT+GcqR5Tz4KV/uO9DpnJutQ7INUZvMmkgv72
X-Gm-Message-State: AOJu0YxVeiyg41fnfWTdQ4BuBUXq4EwN1YWkXSqqpE9jREuRkofYKMGw
	6UiDbHiv64Aqndv51W+A+2qxYcNz8CQbBXz+hX8VeXIAHNwxssczwAukJLwLZ9jQukz0eOWu761
	flfFsqRmD3KqorX8zvbl0WVEC7Lm0E+X9pyvo
X-Google-Smtp-Source: AGHT+IELb8eVtZ6ww8aj2w5Do0QHfTsDehfhWAtcTePwnv57N9+e28vxnzXC5Vpw70w6LIGKBaH9PyRZPrLwbCqFg0Y=
X-Received: by 2002:a05:6402:4304:b0:57c:b80b:b2f4 with SMTP id
 4fb4d7f45d1cf-57d0d6d1871mr297161a12.6.1718863962205; Wed, 19 Jun 2024
 23:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com> <413866f2f2d996cfbb5c906467b36c96b1a82e2d.1718690645.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <413866f2f2d996cfbb5c906467b36c96b1a82e2d.1718690645.git.baolin.wang@linux.alibaba.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 20 Jun 2024 00:12:04 -0600
Message-ID: <CAOUHufavGxeE4nyBnjRMo+BqFyTRUJMyoqBkEDV_c=x-PibvEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] mm: vmscan: add validation before spliting shmem
 large folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, chrisl@kernel.org, 
	ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com, 
	shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com, 
	da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:54=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Add swap available space validation before spliting shmem large folio to
> avoid redundant split, since we can not write shmem folio to the swap dev=
ice
> in this case.

We don't scan anon LRU unless we know we may be able to swap. Even if
there is swap space, we may still not be able to swap. See
can_reclaim_anon_pages().



> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/vmscan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1807e5d95dda..61465f92283f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1237,6 +1237,14 @@ static unsigned int shrink_folio_list(struct list_=
head *folio_list,
>                         }
>                 } else if (folio_test_swapbacked(folio) &&
>                            folio_test_large(folio)) {
> +
> +                       /*
> +                        * Do not split shmem folio if no swap memory
> +                        * available.
> +                        */
> +                       if (!total_swap_pages)
> +                               goto activate_locked;
> +
>                         /* Split shmem folio */
>                         if (split_folio_to_list(folio, folio_list))
>                                 goto keep_locked;
> --
> 2.39.3
>
>

