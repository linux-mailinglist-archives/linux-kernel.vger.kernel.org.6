Return-Path: <linux-kernel+bounces-397043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F18049BD5FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A8AB21C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864020E024;
	Tue,  5 Nov 2024 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlZfRNyS"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA04212EF0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835345; cv=none; b=l14RtgxdOTZmfSFDKKINbT7sF5phgCFRVNaEKwopFOOZSSYncMrhFK7fUvuc/mtvYVS1pJXMfrMAQPXbijQCff/IIEClSnii1hPS5zsn8lycvl2ltWt+YONa2mlZwIg+R4kK6xJNxLqYXiQACM2rCdTxacSZ8uoSwM1vkRnfy74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835345; c=relaxed/simple;
	bh=34EBB02qLglczeLB5qc7NWhxtQbeKZXTV9/H28It/fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuodwiTsXivZjhZItKMP49FAhz5BMJ4XAsJnxUq+K+p68948MzNotPTlMj/WHD8isaCdI7Dz6175kk2AehhR7DLv18gvry6mPowi2tK/cxO58FEqDJvHxxyaxDfi220pP5wgmTh2rLULcnIr4oIX7yHWswzGCb+h2a1Cve9fiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlZfRNyS; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbe3e99680so31826286d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 11:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730835342; x=1731440142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34EBB02qLglczeLB5qc7NWhxtQbeKZXTV9/H28It/fc=;
        b=mlZfRNySXS0tiFr5A7UpVIN+alDrl0hak5l/4IDINN1iYS5VZ5HW7pW0b1zSssjdzu
         6D+FecgZn3zWwoQPSVsEytIaddVfDZJ1foxs3JTCmGxelVJO4APjAnHBCdnWCthekyby
         ETkQqU1j3LC0EEBFpJDLMQpkuGM/0BGJpNr/XHrDIoJjFYo2xlNAw0hVJTF2WkBw4209
         b2BThaulhNduBqF4jE/+s+StAadwXfykLGJm2HcgLtlbRK4CIUnwOznw84Vm26FS8mT9
         T8RqOxVpOJKivw6MACxBnyLn27pj84MRM/BxSmd6sT1r86x0vDgrequpR0MN9OSVH22y
         my4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730835342; x=1731440142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34EBB02qLglczeLB5qc7NWhxtQbeKZXTV9/H28It/fc=;
        b=VS7zJn6SU7KKZtOoR/3Docgf9VGa/NtEDAPifYfsjcfjL6qVrskHUPixkRuTIJEyT6
         QXrlClmP4kK1ajrED3AFF8MysobggD5xtl3/pLx4NP8/qx/sHykUIg9fAZoInXGMDYtE
         h2MxkNooI7IZ13kYdeIApsEwlYh9Evr62evDbB7bLT+Th2mewAXRfSORSvE54ASdboGt
         JiswUwpP6ZltCuxqLYbtz6GV4BTL/7Kaoi75vP0FvDphB8ueYh48gng+vdf66CSpzLBO
         Ry7xRo2TgYQlfIHLGvve/TC8kB1wOuTMnX1QfRzF97wwZ7UuHjFHOXYJnZoff9Zz67Dq
         hYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNkM0QV37sFX3KSHt4vexU2N3yDBgY/rD+2Uc6i2ZTGbX/Fjk220229o9gRwYW1WOV2Nx2g398kygvvIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycl9VZiTEXvT6FdxVxP0FPvtKWoV+pNpxeOuCmyKIfB6BNjLkL
	OvFRr/IpyE7JySS8O2lyECxJTwgTXYizwcHynOLi0on3lQgjapSqLz9UWJU92ubM5UHGu9UIPvN
	gmevUfzhaSiiiUjTaJaI6gT630yQ=
X-Google-Smtp-Source: AGHT+IHUiYLp/JoQQjAX5DzYlllLrbDkaCy2q+uKnPJMvfHv4JT7Du9uZLkU/K7awIA3IagbTglqj9Izb1fwu4yRa/Q=
X-Received: by 2002:a05:6214:5d93:b0:6c1:6e3a:6d17 with SMTP id
 6a1803df08f44-6d185674992mr551096586d6.6.1730835342334; Tue, 05 Nov 2024
 11:35:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102101240.35072-1-21cnbao@gmail.com>
In-Reply-To: <20241102101240.35072-1-21cnbao@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 5 Nov 2024 11:35:31 -0800
Message-ID: <CAKEwX=MTX9-rhV7muW__2=GuXKfbuKX8nAT+CLmM=-wEMZ5Y-Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: count zeromap read and set for swapout and swapin
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Usama Arif <usamaarif642@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 3:12=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> When the proportion of folios from the zero map is small, missing their
> accounting may not significantly impact profiling. However, it=E2=80=99s =
easy
> to construct a scenario where this becomes an issue=E2=80=94for example,
> allocating 1 GB of memory, writing zeros from userspace, followed by
> MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
> and swap-in counts seem to vanish into a black hole, potentially
> causing semantic ambiguity.
>
> We have two ways to address this:
>
> 1. Add a separate counter specifically for the zero map.
> 2. Continue using the current accounting, treating the zero map like
> a normal backend. (This aligns with the current behavior of zRAM
> when supporting same-page fills at the device level.)
>
> This patch adopts option 1 as pswpin/pswpout counters are that they
> only apply to IO done directly to the backend device (as noted by
> Nhat Pham).
>
> We can find these counters from /proc/vmstat (counters for the whole
> system) and memcg's memory.stat (counters for the interested memcg).
>
> For example:
>
> $ grep -E 'swpin_zero|swpout_zero' /proc/vmstat
> swpin_zero 1648
> swpout_zero 33536
>
> $ grep -E 'swpin_zero|swpout_zero' /sys/fs/cgroup/system.slice/memory.sta=
t
> swpin_zero 3905
> swpout_zero 3985
>

LGTM FWIW, so I'll leave my review tag here:

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Too many emails in this thread, but my opinions is:

1. A fix tag is appropriate. It's not a kernel bug per se, but it's
incredibly confusing, and can potentially throw off user space agents
who rely on the rate of change of these counters as signals.

2. I do think we should use a separate set of counters for this
optimization. No strong opinions regarding combining this with the
zswap counters, but it can get confusing for users when they
enable/disable zswap.

If we are to combine, I'd be much more comfortable if we have a
generic name, like the one David suggested in v1 ("swpin_skip" /
"swpout_skip"). This would still require some API change tho, so not
sure if this is the best approach? :)

It would also be appropriate if we bring back the same-filled
optimization (which should be doable in the swap ID world, but I
digress).

