Return-Path: <linux-kernel+bounces-227165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E7C914954
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EFF1F24EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAA213B2B0;
	Mon, 24 Jun 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N787CqEx"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2132E636
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719230796; cv=none; b=aflILFfMgREDjc9JbEY3Z/xlabqcNqktzFH1WRltN1vbTqx0UA3RCTIegV1Y3LYcdDnt2gRA7QzYihBrwxR+vCa14GrnvI0d+zNVAiHoqY8wLmnWpodrm0l6fDkyrDxXXIjlvOmtciwziLwjdh/UsDJxfX5ruuc9fVSaUJo7cu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719230796; c=relaxed/simple;
	bh=N2Ye8UlFO/9bFj19GHT6YROH8QmOdP64rM3WllHkw6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFGo7ovUzmNtvd3D0ifZGL8gg+GegKGbzYi+0I2JAwycXnJ/PFJPQnxy5slR60TNPW8oH9GjPRBTyAewdWI6sfARjEzGH2iQvFscLRogiRA1GHySwyuwUZg73d3x7zAsm5f4HXqQze6ykIbjNAtvLMzLnrYmfRMOb26BnG78I0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N787CqEx; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57cb9efd8d1so8474801a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719230793; x=1719835593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2Ye8UlFO/9bFj19GHT6YROH8QmOdP64rM3WllHkw6c=;
        b=N787CqExNV0FfN/ioVRc167uM/o/0YCHbz73yLpZYnnnaMscz/gDwW1rx8+lbOiUCD
         gmA47nBOaxKjkJtvJ4PokY0/U5lbABrzH0PrVQTuNpO3QiKbZIYSK3x4R9nWoSOL0m2H
         FW7A054YZB7NkrZSayWoHTU0/B6YmYlA6ormyiVZQUSX7+3f3aNs3PK1wi5v9zKSoXg/
         p5q+RBntkFFdsyT0BNIeVv5pRsW0gjAEFeVNixwk1Mj32Gp5uQd9fyK3mPtbgakvt5s5
         QvtHEgi4+KdFjeMTfJz016XoysVJ//wcvM3EOzj8ZEzMro/X+fud9GifnkoYpXd76+sc
         pUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719230793; x=1719835593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2Ye8UlFO/9bFj19GHT6YROH8QmOdP64rM3WllHkw6c=;
        b=nSgDFj3DFDD+Liyo+YyE7ioE1VErnT2t27RFlTfb8gGbU7so1fYTcfc/Zy8gmekujZ
         LSBsoNW5s+2v2q4Z2QoK7Xa60csr7MlKK+ToUg+eB+0EsWqpt/j6bvpqSuzwLqosXqLL
         9YvcAG2iqBXTO8HQDp3vZ5th9sN/5OL9oA1FVeG9Zsl8Js89BGHSoCBLfhtoWA1xQ2VU
         oeKyO8idrengr77qWVIeADg7oeP6t5UlzgJxXVMSZ+9VjQuDUE9rSwum1XmQAPD7Ny2G
         AyaJX8qrU+QXM+A78WKIHKJoG07+55CZVRF2VfzI/ZJFXivTlct59wCQBYDieyeW1TLr
         ruuw==
X-Forwarded-Encrypted: i=1; AJvYcCXs+HF6dzEQOJSao4vevjkqOOeaB9VNfELn1/eYa41TxLhzri7FRWz5SNHPMqe8RSTscAMCqfYiZoTICty5d2CHXPk5wv9RwRJ3yZPB
X-Gm-Message-State: AOJu0Yz4GYZ/XOLuXJSYD8OqF8q7UG+tDmoS0p5R/SAvGkEZqsSNL81I
	+o2Fl58rlruAHiiT7t8+e1Gt213dywR4G81f0T3wPa7yoktDYuSUhN28kmdnt3zAc6owNdrRSHY
	0rJYJcHIN3BNDXwd6iE+0p1rTsYySrN06OVtp
X-Google-Smtp-Source: AGHT+IHNbHupo5acr2B4R/P/hsgga+93sAkzQ/xIPu1nrmVLsRmIQlcAe0rDHcwgQa/2R4VXwD7MHFj2EsLxttIyVH0=
X-Received: by 2002:a17:906:f909:b0:a6f:62c5:87be with SMTP id
 a640c23a62f3a-a6ffe270a03mr393937866b.4.1719230792180; Mon, 24 Jun 2024
 05:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406241651.963e3e78-oliver.sang@intel.com>
In-Reply-To: <202406241651.963e3e78-oliver.sang@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 05:05:56 -0700
Message-ID: <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 0fa2857d23: WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
To: kernel test robot <oliver.sang@intel.com>
Cc: Usama Arif <usamaarif642@gmail.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 1:49=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_mm/page_alloc.c:#__alloc_pages_nopr=
of" on:
>
> commit: 0fa2857d23aa170e5e28d13c467b303b0065aad8 ("mm: store zero pages t=
o be swapped out in a bitmap")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

This is coming from WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp), and
is triggered by the new bitmap_zalloc() call in the swapon path. For a
sufficiently large swapfile, bitmap_zalloc() (which uses kmalloc()
under the hood) cannot be used to allocate the bitmap.

Usama, I think we want to use a variant of kvmalloc() here.

