Return-Path: <linux-kernel+bounces-558057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE82A5E10C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF131881DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D402571A1;
	Wed, 12 Mar 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKuCFdJ0"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A718A6A7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794676; cv=none; b=AflrLcF1VrlM5v8cuG0pLgguKPVhtU2VKDSHsfK/k5iR9dSkTWsqA/qJNotIXcBPyVEJL7BuUpGQNPxB1gg91y7skpsTzQ1rEXb4TwfWae1MWODX601VnexK5cD26v3SkHoeGp7mrgA14nNYCD0nw9WxsnTkrByJlGcZe+8DxLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794676; c=relaxed/simple;
	bh=wdNCJTzoJSuLjTqXfTxcG2O0gkSp4rOOYD8MKqoeeaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POOqiwfX6li3hdwpRmYuZ5llkh6vJwhfsflzg+tf9lh2okmks0z7h7s3VE2GiYphFFGG1vSxRg9EAdfWJMtgIrSwkkbem+GxcDqcBBZ/DoDmMtkDGEl3SaAlLjrc/EebwfM4mtdwdqeindER9gM0iKaUmbNY8wPu6SCCUAUAREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKuCFdJ0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fef5c978ccso75541a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741794673; x=1742399473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4waYuPFx6L6goSYkoo7WhTZHz9gZ3Nxcbawn3orXnWI=;
        b=JKuCFdJ0bnW3vlkDJUJQeIBNNXct8eOxX8LvSkUzYW3k/HSS/CgCrcAnwQvowAzkk3
         RjIUDvVe6b32sGVKNd7pUp4Rrgj755Ob3dfw6ZZHYMO/XFCptLNE5RG5p/g3ArAmN4uh
         Epw/nFV0RxMrAD4pevLTkB5Hw6UvMESuAiDAkBffcdUl6t9j82+ycsgwztPPW+uQ1Kxi
         PbAd6PzNzPf2lGh2SiEThOH5ZMquMBVPYJdRNcRiESDAW4TWrjNYVLT6eQdcD4EybWhO
         b6VZJEdSIJQfvs16BkWFwQgGH2XxvvbdIy5lJinUhUQFrRYArm/OF7vRC2p/pvSVYznC
         Lhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794673; x=1742399473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4waYuPFx6L6goSYkoo7WhTZHz9gZ3Nxcbawn3orXnWI=;
        b=YYPFGzJQa4yVXS4imscgkA/D42lsphgitAYf3SrUe8HtW5IXKaUPTveRuz/qrWxLgX
         0UpYI//bjwrM2bD/0ume4ausaGbnbHclZhKeEiMbDcSqBRqWAK9XjY293QzZiFmG4BKz
         YfmabzOKhWsbJQRHV9UZu1N0lumYzcgeAxCCiBdN8+siRYmdezAgw5gxsn6zhUhRx1Sk
         +jCe3ExDgU+WuZBSk5f1ASdagXBsgBo1LUozNXUvq744bduiYC2MavtxNaI6NafBY0R5
         TnxjcueUG3kMnNQOVDVLvPO/ojrQ8QxiywSftJbk42kx50DTBm85gTteGJJvOxRZNFZF
         mjSw==
X-Gm-Message-State: AOJu0YyOWv3m+7dL1xB3bD6cqM8wEkwlgExL6MGnnjZTcmKm/a/azAoo
	5duaZLGX53w/3F9J6hGspitATY9oIiy18/jt6BKQJ6l91C95z9eTldtXlxZV/tyVwE/DpRtHDhG
	G/LOF4fo6G/b7cW/vJd0AbmS8zAwQ2wyXbpM+
X-Gm-Gg: ASbGnctPHJqPnYI1MdvNd9uJmqwvNVDzwmpduq0Z2+YE30/2ELNPFWYRRMtJhl6Q8XR
	mTA+5h2FCppsj794bodh0CshOT6ckv/VmgPhD/Om68UbATXWUs9q6s4x+7F671xcCWrqLIN/X4V
	stTFpxOf7ApIt5O5hD4nVFzPzfsoKsbqbSqnpYuTT9Pw1jCHyCnXUF7EINaxsW6uZKllSXHQ==
X-Google-Smtp-Source: AGHT+IGxEBodeV+/yMZZaDdgVXjLm0ljYHatWRv38P75PhL5DIaId/G9DlTGJaKiO/EJxaRirPI129so8i6lFmu+wqo=
X-Received: by 2002:a17:90b:2fc7:b0:2fe:ac91:4667 with SMTP id
 98e67ed59e1d1-2ff7cf1d266mr31811537a91.29.1741794672597; Wed, 12 Mar 2025
 08:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308034606.2036033-1-liumartin@google.com>
In-Reply-To: <20250308034606.2036033-1-liumartin@google.com>
From: Martin Liu <liumartin@google.com>
Date: Wed, 12 Mar 2025 23:50:34 +0800
X-Gm-Features: AQ5f1JoGKRqr_zxgpVnFUvr04vIAdj97OFW6F_Uv6QoZM1DoRozKvQsjmIZTEG0
Message-ID: <CAASV4h4_xgJPZOvh8k5snJc_ocvwPih+SvK9D8+_Fid2chcz6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add tracepoints for lowmem reserves, watermarks
 and totalreserve_pages
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, minchan@kernel.org, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I hope you've had a chance to review this patchset. I was wondering if you
had any concerns about merging it, or if there's anything I need to address=
.

Thanks,
Martin

On Sat, Mar 8, 2025 at 11:46=E2=80=AFAM Martin Liu <liumartin@google.com> w=
rote:
>
> This patchset introduces tracepoints to track changes in the lowmem
> reserves, watermarks and totalreserve_pages. This helps to track
> the exact timing of such changes and understand their relation to
> reclaim activities.
>
> The tracepoints added are:
>
> mm_setup_per_zone_lowmem_reserve
> mm_setup_per_zone_wmarks
> mm_calculate_totalreserve_pagesi
>
> Changes in V2:
>   Fix coding format error. Feedback from kaleshsingh@google.com.
>
> Martin Liu (3):
>   mm/page_alloc: Add trace event for per-zone watermark setup
>   mm/page_alloc: Add trace event for per-zone lowmem reserve setup
>   mm/page_alloc: Add trace event for totalreserve_pages calculation
>
>  include/trace/events/kmem.h | 78 +++++++++++++++++++++++++++++++++++++
>  mm/page_alloc.c             |  4 ++
>  2 files changed, 82 insertions(+)
>
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>

