Return-Path: <linux-kernel+bounces-214021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BA907E10
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9D5BB24359
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A513DBB1;
	Thu, 13 Jun 2024 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uapetDXZ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F7C13A260
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313748; cv=none; b=FabX4aDlUxOOpLctLf5YYCwwsJU729d6/Vfj8wLpnTfjXV65NrYaxqatnzPNW2nsagcuqmXZsveZ9M7Sk+S1rqzKBeLt+FHqzhTlenGDTKqiL1EvFrxRxuj0sXcf0hkGBz45fEHUSb5OUnRFMy2QsQFl6VpESampmdA+cDrzno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313748; c=relaxed/simple;
	bh=DvpeA/1HRnfLZyI1RmxZmnl2ghDAFMHZ/pZktbhRNJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6ghi2QTIybPAcvLU3//mULvTIC9/iRyfI99wq2+nEA8CBhIRLNeMeYm5siGDEaaNoMc8UdLV9hN8EyR2sfe3nBCOu9sEN7mZZgczmtsa80BmHHfKWbapIcPwWrn3U/ZAuArCxWgT8bXX9Rkqz37b8+yJwyW6U0tY1ABa8TJ4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uapetDXZ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52961b77655so1579956e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718313745; x=1718918545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvpeA/1HRnfLZyI1RmxZmnl2ghDAFMHZ/pZktbhRNJ8=;
        b=uapetDXZL2tfiG1M9rlLm+e3l9/Yv4Skt38fcHX+8yTLzeD3qkNh56Pb0BY6Up0mWO
         dLmIk//IX8YfISloLuolDLxcHxHgZWMesVXPc6i3b5Lys2mnpg5Hjt5HZsbIrPqyNf84
         6D4/SCj5lMkT/Efnxb0Kxb2xeVbDPYv1pnRzGPyRjEauzOxs6mCAUe160aEX0ChrI7Ns
         yz0keC/aP5LazAYNU9k3eSYFVjg2VMDIvMu2Ppr6ScOgqBm4NGOw5/vV2aUHL1hbQRZH
         qIY1ddUZMVXy8R6cQGRWV+m4kexi4PiwT+UGi5Pue/39LpobW6Bp9weYyotXwY3ljffc
         xWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718313745; x=1718918545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvpeA/1HRnfLZyI1RmxZmnl2ghDAFMHZ/pZktbhRNJ8=;
        b=nswupClw6/01PoGvW3zCFqp9VjiXPSs7wF9PD+9JLyzCyX5szo11z7qWovQVUikLVv
         A9mAYgJ/PsgJ8yvl3ZPZhf9vXtzgqqbHb1JYq4+WP7cIjhgunTNmnFKPbbCB1Cd4w5YX
         9AfsxBmS+HKaGnTI58oCOHz0i8uFDqLBGfJlXp8hmYI9NW2KTT7ZtpbkwtDfDIgO288G
         lY9to3AaaMx8xZiZyplAnJ6e0kkP/LH6McdvZi3s7dqmjFFSI5yqluqe3LADNoU7ctkn
         ugpSz4aN9wUEhYdRFMvzZg/n0rbSnq/Gi6LgJYgkKy+zDXGw5/7woauP8OLl8hNfC3fM
         WbLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUruCqI9sbNph3qXROTI4Dy0zZSe7ZQ7VI+A11rCxuLo+tmkZWRtyykwcn6Qco8EHb/MtE6NFyvyeDRlJEaDaGmIP8kYhgzaEd1og/O
X-Gm-Message-State: AOJu0Yw0RfaNOq+IFPObHXj3z9v9Aek/DBbM2IzmOzVT79xpMN74MChg
	759yhmNcVHPOAzeQLyEjHPN0ZKV4PdjQhh0Ii18XyVAILLw2wWuHA7d1eVOHxRHjoR7NmvL+IdY
	ORPOw/OwhkJAoSiTw/dKTM6q40YY8yF9uo7Y2
X-Google-Smtp-Source: AGHT+IFMJjg0s0ZFkpT9FjDot5/rGhh6fqId5ocyCohFuRj4gm6D2a1YSR0zkLByFCM9X6pUHqADSOmQqcapzFUROdM=
X-Received: by 2002:ac2:4247:0:b0:52b:c14f:4f84 with SMTP id
 2adb3069b0e04-52ca6e658ecmr524796e87.21.1718313744315; Thu, 13 Jun 2024
 14:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610121820.328876-1-usamaarif642@gmail.com>
In-Reply-To: <20240610121820.328876-1-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 13 Jun 2024 14:21:45 -0700
Message-ID: <CAJD7tkZzHhvVNjECqMiFKEu988eteiFk4aGpE=f=gXE4tnF4NA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com, 
	ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 5:18=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> Going back to the v1 implementation of the patchseries. The main reason
> is that a correct version of v2 implementation requires another rmap
> walk in shrink_folio_list to change the ptes from swap entry to zero page=
s to
> work (i.e. more CPU used) [1], is more complex to implement compared to v=
1
> and is harder to verify correctness compared to v1, where everything is
> handled by swap.
>
> ---
> As shown in the patchseries that introduced the zswap same-filled
> optimization [2], 10-20% of the pages stored in zswap are same-filled.
> This is also observed across Meta's server fleet.
> By using VM counters in swap_writepage (not included in this
> patchseries) it was found that less than 1% of the same-filled
> pages to be swapped out are non-zero pages.
>
> For conventional swap setup (without zswap), rather than reading/writing
> these pages to flash resulting in increased I/O and flash wear, a bitmap
> can be used to mark these pages as zero at write time, and the pages can
> be filled at read time if the bit corresponding to the page is set.
>
> When using zswap with swap, this also means that a zswap_entry does not
> need to be allocated for zero filled pages resulting in memory savings
> which would offset the memory used for the bitmap.
>
> A similar attempt was made earlier in [3] where zswap would only track
> zero-filled pages instead of same-filled.
> This patchseries adds zero-filled pages optimization to swap
> (hence it can be used even if zswap is disabled) and removes the
> same-filled code from zswap (as only 1% of the same-filled pages are
> non-zero), simplifying code.
>
> This patchseries is based on mm-unstable.

Aside from saving swap/zswap space and simplifying the zswap code
(thanks for that!), did you observe any performance benefits from not
having to go into zswap code for zero-filled pages?

In [3], I observed ~1.5% improvement in kernbench just by optimizing
zswap's handling of zero-filled pages, and that benchmark only
produced around 1.5% zero-filled pages. I imagine avoiding the zswap
code entirely, and for workloads that have 10-20% zero-filled pages,
the performance improvement should be more pronounced.

When zswap is not being used and all swap activity translates to IO, I
imagine the benefits will be much more significant.

I am curious if you have any numbers with or without zswap :)

