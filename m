Return-Path: <linux-kernel+bounces-428270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92D69E0C43
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7841652BC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA341DE4FB;
	Mon,  2 Dec 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHUeUUMR"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4491DE3BC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168292; cv=none; b=Jxwg6MIu80E8468vkKTwRBZL+ryw1E75Nl1zL6AxwvSGHj+nIGTFSPmErwRPiUyJJkDxK3mZWQuHK9A79GNnsNdPrxvzP8MRk2yFNAMB6Nqec91HVKcz84HaRRtc2JYwHs+Byp5/1hHh2hlzPbqrpYAXymzwAWvqBcD8l0PyvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168292; c=relaxed/simple;
	bh=azL3ggP5+v/afEqoQjf1Wv9DZ/T0hzvBjzmZeNazDFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GabJS8Qt8OaMR5SmS05qTeeBJVePOMyI5ueWrJbbk4Epq+Lvjkvq0moQPWD3pEw3o91JaJCNS9EJSxLAv0esXAfn1sdJJsyHTqVdW/ocH07qabk8b7N7drROqZt+oTBVFv3K40n6S2amQqZTIMnhNOxwnA4fONc7yHAs4SyqwxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHUeUUMR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d87ceb58a0so27315026d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733168290; x=1733773090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxzZa/FeaHenizjIU+OA48psYXufFL/hW5pMalhLMKg=;
        b=CHUeUUMRVs5S3gdM25tydr+GOD16mA9/O2IW13fA4i2V1Z9ZHoRkU7/1yl/OTip6vW
         kW6sRINnFuStSjY4t52307hFjImDocY9A12q3xFNRRxy/A2r/bXFiOQyfsmWYH9yW65E
         xT5X/EmwpRfiZtcB/49MZvoY2DuO4aguHTYBAPk1ptsBY2XSPxAJjE/8FwojU1lNxAgL
         rvAY1HqXAl68CaRj3dmoeZAEXFE7iF/rc7u2BhqySavtb9b68gN5CQfdoRlDM6nunWL3
         1Xmwuk5h9/Q2pyswVSjJ23mhxC2W2Dh413YGVRvxsfl7PGwIyNP8MlaT39tU82drpJDN
         Y1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733168290; x=1733773090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxzZa/FeaHenizjIU+OA48psYXufFL/hW5pMalhLMKg=;
        b=PwPBXhaa2sVJD22n7auSP82C9IEk/XtKesR6NLhvgn/dSF6W7nXhjdKceZNAM+paE+
         9atPxLVRYCItf1Mlrvn7WoM5S5oeYb7OyGve7H+i/Kyo8z9BOMo6FobGJWtOCQWulLoI
         SRdib0/l1pjxvbQeyzyz2bLA9hiXxyiRmPwazYHRJhYMN63OPYaXgoSOEfnCjCojLeNu
         VsJRUwClo05JLt2pv4vzD9HppEFHrVONFzyQsx833AhaXBRTlaA9DfRiYPAmGcQtEbJa
         8aMMKfjmE3azhCpdoYWE+gpiVRJv8shQ1Iv0YvGb0B3fl5Bkc8348zqEekWdTmry9WJe
         SJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq+JTW58tiJkQme24lRIwsPoM3Dmb+D9gzLBsLY7zAgU/VEgkYtCNrQ06Hh0LIwHj3czD7zkIe9NqZixU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5jewEqUtv1dhkNLbmihis4wzP2Ctc2y29kTcomXVFwGqwIijT
	ugEcHzPVtrGzWZSsYin0eluQvU3YuNJByQvuEMpY2BsSXC/Y9NhSm8KsZMe4lz6zb5hvK+V0MZ6
	gGc21rUdCConjRMMf9q2HkajaG6HZacNsihHT
X-Gm-Gg: ASbGncvwdLtpQpf5LxSfnmJ0I93/vZMTPk7HxNzuXjkQGDxC+XcxLrULrNQ05prmY+B
	e/9zOZWFi5aigIA0Jt5WQACa2LDxV
X-Google-Smtp-Source: AGHT+IHxJdu5xIM6BIgrsiHPcVu7o/uvaOAXgt3dUjkQOdUQsKeM/9i7bc65ZyYHF2Tld/jcYUd4DpRB8Av3RKj6IhU=
X-Received: by 2002:a05:6214:c6a:b0:6d8:b371:6a0f with SMTP id
 6a1803df08f44-6d8b3716e20mr18594046d6.31.1733168289587; Mon, 02 Dec 2024
 11:38:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-5-ryncsn@gmail.com>
In-Reply-To: <20241202184154.19321-5-ryncsn@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 2 Dec 2024 11:37:32 -0800
Message-ID: <CAJD7tka9L-4VZVi1QkC_DuKCLyA71LbLd2chSPNK66yQRS2K+w@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, swap_cgroup: remove global swap cgroup lock
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> commit e9e58a4ec3b1 ("memcg: avoid use cmpxchg in swap cgroup maintainanc=
e")
> replaced the cmpxchg/xchg with a global irq spinlock because some archs
> doesn't support 2 bytes cmpxchg/xchg. Clearly this won't scale well.
>
> And as commented in swap_cgroup.c, this lock is not needed for map
> synchronization.
>
> Emulation of 2 bytes cmpxchg/xchg with atomic isn't hard, so implement
> it to get rid of this lock.
>
> Testing using 64G brd and build with build kernel with make -j96 in 1.5G
> memory cgroup using 4k folios showed below improvement (10 test run):
>
> Before this series:
> Sys time: 10730.08 (stdev 49.030728)
> Real time: 171.03 (stdev 0.850355)
>
> After this commit:
> Sys time: 9612.24 (stdev 66.310789), -10.42%
> Real time: 159.78 (stdev 0.577193), -6.57%
>
> With 64k folios and 2G memcg:
> Before this series:
> Sys time: 7626.77 (stdev 43.545517)
> Real time: 136.22 (stdev 1.265544)
>
> After this commit:
> Sys time: 6936.03 (stdev 39.996280), -9.06%
> Real time: 129.65 (stdev 0.880039), -4.82%
>
> Sequential swapout of 8G 4k zero folios (24 test run):
> Before this series:
> 5461409.12 us (stdev 183957.827084)
>
> After this commit:
> 5420447.26 us (stdev 196419.240317)
>
> Sequential swapin of 8G 4k zero folios (24 test run):
> Before this series:
> 19736958.916667 us (stdev 189027.246676)
>
> After this commit:
> 19662182.629630 us (stdev 172717.640614)
>
> Performance is better or at least not worse for all tests above.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_cgroup.c | 56 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 15 deletions(-)
>
> diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> index a76afdc3666a..028f5e6be3f0 100644
> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -5,6 +5,15 @@
>
>  #include <linux/swapops.h> /* depends on mm.h include */
>
> +#define ID_PER_UNIT (sizeof(atomic_t) / sizeof(unsigned short))
> +struct swap_cgroup_unit {
> +       union {
> +               int raw;
> +               atomic_t val;
> +               unsigned short __id[ID_PER_UNIT];
> +       };
> +};
> +
>  static DEFINE_MUTEX(swap_cgroup_mutex);
>
>  struct swap_cgroup {
> @@ -12,8 +21,10 @@ struct swap_cgroup {
>  };
>
>  struct swap_cgroup_ctrl {
> -       unsigned short  *map;
> -       spinlock_t      lock;
> +       union {
> +               struct swap_cgroup_unit *units;
> +               unsigned short *map;
> +       };
>  };
>
>  static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
> @@ -31,6 +42,24 @@ static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SW=
APFILES];
>   *
>   * TODO: we can push these buffers out to HIGHMEM.
>   */

While you're at it, I think the comment above is quite outdated :)

