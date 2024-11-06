Return-Path: <linux-kernel+bounces-398899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545C19BF7B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786CD1C20FAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C86208225;
	Wed,  6 Nov 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMXvEUDM"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B28205E0C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730923288; cv=none; b=j4mKX8lBtv7250S8mnEVeXaDSfw6wYxHC1zAzLEuUIuhhvCctmVxdXEQ4R/sw6lC7k3Yx4H4+/8hgwyTzPUqXGol7O/LJGFj/8E7Xtc/lzCZ8SE9SMxki8ZHV+FGNuA6fTmMh9+NW5Ru/vy6P2hM+hiKFrwNXp5I1l2KKJ6fNXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730923288; c=relaxed/simple;
	bh=lr74ySSLf5fxQH2o6kKiS46c4VRHrk3SnGBZdLF2hfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxSCx4rwRj9WxOWYSURxVvZO8RMYhl5YAVB6lZPlJuJ9WDVyuJaQYRE5cByuMxxmJF76vJJYO2N0IhuocscJ7h5uGF90v8itq+OROCU2SZeoVpd8UctjW1XAcmzbyzDpJNoNjVVZLSQqvxqAJQrZM67fCu0ZSzi7ApHDtB8traE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMXvEUDM; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ebc04d495aso95331eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 12:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730923286; x=1731528086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr74ySSLf5fxQH2o6kKiS46c4VRHrk3SnGBZdLF2hfk=;
        b=hMXvEUDM9mFvHrbXgmK4hxss7ceYBWRen0tFZnhdraZuQaZI3hPIvd35HggMzw4e0J
         KT1O3OBDzm3YEyO94mNulDHQPQ+end/H1G+mHjPRiQrXjYCah63MqJ0kMXD+3ddnAxgm
         Kga4odvyIlJ/oqfOzz2+CQgCK3nEOlUt7pgWz8JtV4KdVmR0dWahlYc43AgoqJlUFOd+
         epzRoxTseYkS+5pNJh27Wa8rXRQpy+O8Mzi+a9B7Zxnv5Bobf9zf9kewHqV3gr5L+jJM
         7A9XUdEHfFR4Eb3FeywCCf485lGEZu8Kby5sfF5cGU7r6+wLI+usHxGMR6rOuV5P50fg
         YWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730923286; x=1731528086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr74ySSLf5fxQH2o6kKiS46c4VRHrk3SnGBZdLF2hfk=;
        b=F/4b7OTmZW45KTnYCuYX5TMPo2ctoEv/DGNiAmYj+ZGu5m9b0eyc+mbUCZjMELIwe6
         nO5+8qFFEGlgwrx6ezrfDk5Xjq0lnlZpQuuEhQnp4FsTsvjYy0cIHCa4LFGrvR0hyj3j
         vv8p2ZqqB6NAwmyplH+cb4je7XOjmjDO4XeRyt0tuGj3MTBq065/j5o7WRJZFks1N61U
         MN66V6eVUpqUXQS2C3w67wCI4tDiA7gQYbByXMsP8MhGZHWh+NKCA/LfyRIau/KVtlLc
         Src3W7zDfwAcvoz/C/vlbTTqxk8RMH5WgQDqKK941sJqcM3LWIJwjcmMbCFzy9u6qsfg
         hSwA==
X-Forwarded-Encrypted: i=1; AJvYcCXSJD162i3sI7NpAgIc2QHyD5n+ZQgGpp+Ej1faiwsxCHc8UVQotXCWRZ18VyrnbaTScpgPWwcS90r23m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbH/DYMAsQatE5cfAEzElIo2O3utAABvmeOWVQb4T627TT+czx
	fKNXvCWsQdhl/854okdsLfk0OkbLH3wex377OxB4+SBJbfpwC6UtQ+XZ4WdGaYZOhbFL3rZ/nGw
	HcdCz8nTo6+yauJAqXsFH7skCsW8=
X-Google-Smtp-Source: AGHT+IFoPiBUrTrffy0X8fy7FjiYQMjqbgK55GJLKvYYJcgYflSdmLS+zuwS5Fc03HI1i9OCgrJsO9GP99yeCOHL8Bg=
X-Received: by 2002:a05:6358:5295:b0:1b8:34fb:9696 with SMTP id
 e5c5f4694b2df-1c3f9e976b7mr2055978155d.14.1730923285755; Wed, 06 Nov 2024
 12:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105211934.5083-1-21cnbao@gmail.com> <20241106150631.GA1172372@cmpxchg.org>
In-Reply-To: <20241106150631.GA1172372@cmpxchg.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 7 Nov 2024 09:01:14 +1300
Message-ID: <CAGsJ_4zYiRzG6mBnW-2wh7YCo_PJQc7u1syd05DNdic7MaE7Zw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: count zeromap read and set for swapout and swapin
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Nhat Pham <nphamcs@gmail.com>, Usama Arif <usamaarif642@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, 
	Hailong Liu <hailong.liu@oppo.com>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 4:06=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Wed, Nov 06, 2024 at 10:19:34AM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > When the proportion of folios from the zeromap is small, missing their
> > accounting may not significantly impact profiling. However, it=E2=80=99=
s easy
> > to construct a scenario where this becomes an issue=E2=80=94for example=
,
> > allocating 1 GB of memory, writing zeros from userspace, followed by
> > MADV_PAGEOUT, and then swapping it back in. In this case, the swap-out
> > and swap-in counts seem to vanish into a black hole, potentially
> > causing semantic ambiguity.
> >
> > On the other hand, Usama reported that zero-filled pages can exceed 10%=
 in
> > workloads utilizing zswap, while Hailong noted that some app in Android
> > have more than 6% zero-filled pages. Before commit 0ca0c24e3211 ("mm: s=
tore
> > zero pages to be swapped out in a bitmap"), both zswap and zRAM impleme=
nted
> > similar optimizations, leading to these optimized-out pages being count=
ed
> > in either zswap or zRAM counters (with pswpin/pswpout also increasing f=
or
> > zRAM). With zeromap functioning prior to both zswap and zRAM, userspace
> > will no longer detect these swap-out and swap-in actions.
> >
> > We have three ways to address this:
> >
> > 1. Introduce a dedicated counter specifically for the zeromap.
> > 2. Use pswpin/pswpout accounting, treating the zero map as a standard
> > backend. This approach aligns with zRAM's current handling of
> > same-page fills at the device level. However, it would mean losing
> > the optimized-out page counters previously available in zRAM and
> > would not align with systems using zswap. Additionally, as noted by
> > Nhat Pham, pswpin/pswpout counters apply only to I/O done directly
> > to the backend device.
> > 3. Count zeromap pages under zswap, aligning with system behavior when
> > zswap is enabled. However, this would not be consistent with zRAM,
> > nor would it align with systems lacking both zswap and zRAM.
> >
> > Given the complications with options 2 and 3, this patch selects
> > option 1.
> >
> > We can find these counters from /proc/vmstat (counters for the whole
> > system) and memcg's memory.stat (counters for the interested memcg).
> >
> > For example:
> >
> > $ grep -E 'swpin_zero|swpout_zero' /proc/vmstat
> > swpin_zero 1648
> > swpout_zero 33536
> >
> > $ grep -E 'swpin_zero|swpout_zero' /sys/fs/cgroup/system.slice/memory.s=
tat
> > swpin_zero 3905
> > swpout_zero 3985
> >
> > This patch does not address any specific zeromap bug, but the missing
> > swpout and swpin counts for zero-filled pages can be highly confusing
> > and may mislead user-space agents that rely on changes in these counter=
s
> > as indicators. Therefore, we add a Fixes tag to encourage the inclusion
> > of this counter in any kernel versions with zeromap.
> >
> > Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitma=
p")
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > Cc: Usama Arif <usamaarif642@gmail.com>
> > Cc: Chengming Zhou <chengming.zhou@linux.dev>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Cc: Hailong Liu <hailong.liu@oppo.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: Chris Li <chrisl@kernel.org>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Kairui Song <kasong@tencent.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!

Oops, it seems that it depends on Kanchana's 'mm: change count_objcg_event(=
) to
count_objcg_events() for batch event updates,' which also isn't present in =
6.12.

Otherwise, it won't build, as reported here:
https://lore.kernel.org/linux-mm/CAGsJ_4whD31+Lk0m2uq-o=3DygvkRsw1uXcPeqxBO=
NV-RUXkeEzg@mail.gmail.com/

Hi Andrew,
What=E2=80=99s the best approach here? Should we include Kanchana's patch t=
hat extends
the nr argument for count_objcg_events() in 6.12-rc as well?

Thanks
barry

