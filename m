Return-Path: <linux-kernel+bounces-337458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5529B984A56
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB971F24A12
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D251AC437;
	Tue, 24 Sep 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBBQnEma"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F141AC435
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199418; cv=none; b=GVYh3DMmVfyLTx7wYe1ixLOop+krAsdLb4717QQF4jS4j7Wx0Q1Wrp97D0Yj3cNTtOE3CvvuB7aNcwOhLi93yAQt9b8Ds5bhhjpsJa0xJ8XMqF0s4pUf632NoD/zOY1iuAlqZWebqmIM2BZdNfS5OWfqy9OxW5dtJ1y2lYDb7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199418; c=relaxed/simple;
	bh=QTpk9fRA5cyVik4A1bKSMnR25JfcXCwI8OmpG1qW230=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSu8oMX6qNwbeaG1RJ8lR1nXOjbgb09Lo9OxYWxSmdoBcfU0mvpwYxICw4w8KiDAszCbUaSExDNwoNwQbMFU8KWRbaW2uscW/tipa0hJhNqvBLe/xz6wR4r3LwbSMvz6AsPFeSe7Jyvu/Iuv40NJvIgcYk7Up3RZ4yA3aukMNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBBQnEma; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c358b72615so49204796d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727199416; x=1727804216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el7mpitvTq3TeI5YW9jZkgFyQ1Av1rGm2Mp4Ji+jS4E=;
        b=XBBQnEmaKzMvHHUaj0n6cTjj0zp7sYxyOn5u4zLCc8idA9InUukBTENnIaep7FCR5b
         BWkqwSxVM1ONKWEfyi0rXRKdwECVJvr8+u+9KkoHOPycPyXuNBcLmHG0MLPT11MwQR5d
         4HYAlztKhPlJyJcdfUQyFqHNRuFwXPS6LNOP5fyYKIrRxZi+66hLmui0ArJg9SLZnsiX
         DKkJhDtH0Ogj9uJr7ywWSEhCtht8OQo8/PhZRilF4kqvL79psXItCL6W6f02YlaLhhqT
         75NbATNGZyBFY4p2Cw0Um4NazrqB8PGvx2GZ6toyZXHi9I/3dodRxvlSVpK9uYo5GSn1
         /2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727199416; x=1727804216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=el7mpitvTq3TeI5YW9jZkgFyQ1Av1rGm2Mp4Ji+jS4E=;
        b=MOrrSuY0GJ8sVQPFJZL1VIP7qeDKwxVIsqw3MrvkadBuM8fuRSiztIdNkR2nJFW/Fu
         ffDH5XZu/RrlabU20a7PhsH15xDtA6cDzlT2QoD5lh4oPwlyXaVfJVfK4xLbi/zjwxTE
         EtqhkdB8TkVHscMtus43KDwuYMCtWtBTzEO3T77glOtVUOfiw7x5/sEdjHMER/E3RcCy
         kq2oKvKFu/Z3XGSbIjo3Ss8T3x6yfrtSJJ8eYB8Bt8FnnLeczusriChQFi7kprE9e5gE
         MOuMj1+aeHRo1IldHsD/PjsTRN+O0zmMXxwZb2IIK04VHOUmyZHN5ZOdi2bYYvuugPwq
         VO+A==
X-Gm-Message-State: AOJu0Yw8fty7a+6+aOHqaCkNw4wKu94dL5BRlzcqNAYVxW7LbNYO/ZpN
	o/GPyBuNRHD9rViATPDD5OYiyc38rTiMABDQ8vy/a13gxaqoHcIg/sPW/5md3/FpYa/l+ZQDu14
	g/xzed00IH2EunZACVsbbkNLxYik=
X-Google-Smtp-Source: AGHT+IGRIu1mP2kMXxQp0JO91zZwyZFjWrE+cosVJ5wVwIeC/5HGNkAQRvbVOaYKjGlu5m9Lq0bdLMfkGVfP6zybHKY=
X-Received: by 2002:a05:6214:449f:b0:6c5:ab2b:3a9c with SMTP id
 6a1803df08f44-6c7bc65b698mr261418056d6.4.1727199416090; Tue, 24 Sep 2024
 10:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com> <20240924011709.7037-9-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240924011709.7037-9-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Sep 2024 10:36:45 -0700
Message-ID: <CAKEwX=Og85V4YHZXSxZTqCr2dXNgZLOXG76RBfwGr2tF7xEbOw@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] mm: Document the newly added mTHP zswpout stats,
 clarify swpout semantics.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 6:17=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Added documentation for the newly added sysfs mTHP "zswpout" stats.
>
> Clarified that only non-ZSWAP mTHP swapouts will be accounted in the mTHP
> "swpout" stats.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index cfdd16a52e39..a65f905e9ca7 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -530,10 +530,14 @@ anon_fault_fallback_charge
>         instead falls back to using huge pages with lower orders or
>         small pages even though the allocation was successful.
>
> -swpout
> -       is incremented every time a huge page is swapped out in one
> +zswpout
> +       is incremented every time a huge page is swapped out to ZSWAP in =
one
>         piece without splitting.

nit: a bit weird to capitalize ZSWAP no? :)

>
> +swpout
> +       is incremented every time a huge page is swapped out to a non-ZSW=
AP
> +       swap entity in one piece without splitting.
> +

nit: "non-zswap swap entity" is a bit awkward. Maybe swapped out to a
non-zswap swap device?

