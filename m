Return-Path: <linux-kernel+bounces-337585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795F2984C11
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173A81F248C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C4E13A87E;
	Tue, 24 Sep 2024 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dq1i9AA1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C2E8120C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727208960; cv=none; b=mgHwzkwdxoV6ZkoYi2SkiliLNRik0kYJWc4QfkKWLLRvf+dJZYRFlZunUouTLlHAHa8tikaeXu/rRK/Rsqf8Y9jRWccgsDzoN1jKtFZ8jwi2D1F4wgCaSIeaXrLDdkrrPoHTz6091w8uWcev365kUsn8zbEeeEveFfjcvI6WfjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727208960; c=relaxed/simple;
	bh=20rvow2syaLu5tVCk+B78yC3MbGGW7ZTvE1Kq3+uOwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbzELjJkLuE+57YmnLIX/Nt0ULnIBmaNQyL/NSXhxCnkifKrvRrl/tR+UHKpjhJRb40e8/9CasTs8SFB1GY+sH5aqUDDZ7c9yffopUuYt8CG41cQeR8Ohzx6uw0DYmZR3UT4hmiMXXqNpD3Oy/QxdfCdx3jEghIjMsT7qdQxQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dq1i9AA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F283CC4CED3
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727208960;
	bh=20rvow2syaLu5tVCk+B78yC3MbGGW7ZTvE1Kq3+uOwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dq1i9AA1LNuzBFTScXwDCiStXABMuacKaRCcDzRxsiux5L9oZCJ1MWTyDnYm4lG2a
	 ZGERXQY3o1F+QXsBh9tHxil0PID4v5ZHrKMC7BkPf35VynYCdYcALmZXj8re/59zu4
	 WSP/i93h5si96ZvDE6Vi4X1xEjHWFM1Gacr3iRR9N/WSc9uiRTaGzIS/m4bo07bpwo
	 ZO+C+YAv1gdJ3E0gdJgO4T+DLX3d7zzNxgHNGlENjpe+7m5W1eQTxL6ZI+zebXXHAh
	 l2drT75a4uN/wY49Dx7YTrtqaDAPLxoTUaGzER4Tpip2GXhgALauTaXFNEZLeLrxQP
	 cBvA2mMXT4mUg==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6c3f1939d12so46780117b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:15:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVk/iyJzxQyqhr5axz3CExvHuYGLMSZgc+Vki20XKoixwZ4afGk0VhuUWHmkEw9a4Mn/FqG7O0YR6UzVzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyTsVBDm3/wZnNl+5cFyxdkulG/bVwJ3om9mvAqK1YzeckNRSx
	8b6W0/UREdzboC81j+b8g53kqwqHAftA8JlvTDlrQkctcjngLuxbFNzsyQDhDExzaJBwN7Z5ds9
	HgbuxyhRj4/qHLrGzLWfeyu1eddQWk30opfUABA==
X-Google-Smtp-Source: AGHT+IFjFDhhWZCGuynZdnWE2t03n++ZLaLN0gFiJSIupkqGUvhjKjkLAc8km6EoRyp/6Z9QgbBb7Squf0Dmm8RRHqI=
X-Received: by 2002:a05:690c:d83:b0:6dd:bf2b:d52f with SMTP id
 00721157ae682-6e21d6e189emr7058087b3.1.1727208959070; Tue, 24 Sep 2024
 13:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com>
In-Reply-To: <20240923231142.4155415-1-nphamcs@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 24 Sep 2024 13:15:47 -0700
X-Gmail-Original-Message-ID: <CACePvbV+iaqKGGy46xa3CJQvKsay_aw3w4nqs6rESW6Cu8T-Lg@mail.gmail.com>
Message-ID: <CACePvbV+iaqKGGy46xa3CJQvKsay_aw3w4nqs6rESW6Cu8T-Lg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	hughd@google.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, david@redhat.com, kasong@tencent.com, 
	willy@infradead.org, viro@zeniv.linux.org.uk, baohua@kernel.org, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nhat,

On Mon, Sep 23, 2024 at 4:11=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> The SWAP_MAP_SHMEM state was originally introduced in the commit
> aaa468653b4a ("swap_info: note SWAP_MAP_SHMEM"), to quickly determine if =
a
> swap entry belongs to shmem during swapoff.
>
> However, swapoff has since been rewritten drastically in the commit
> b56a2d8af914 ("mm: rid swapoff of quadratic complexity"). Now
> having swap count =3D=3D SWAP_MAP_SHMEM value is basically the same as ha=
ving
> swap count =3D=3D 1, and swap_shmem_alloc() behaves analogously to
> swap_duplicate()
>
> This RFC proposes the removal of this state and the associated helper to
> simplify the state machine (both mentally and code-wise). We will also
> have an extra state/special value that can be repurposed (for swap entrie=
s
> that never gets re-duplicated).

Please help me understand. After having this patch, the shmem swap
entry will also use the swap continue as the only way to count shmem
swap entries, am I missing something?

That seems to have some performance hit for the shmem. Because unlike
anonymous memory, The shmem can easily have a very high swap count.
I would expect there to be some performance hit for the high share
swap count usage case.
Do you have any test number on high shared swap count usage that says
it is negligible to remove it?

Also if you remove the  in the SWAP_MAP_SHMEM, wouldn't you need
remove the counter in the shmem as well. Because the shmem counter is
no longer connected to the swap count any more.

Huge, do you have any feedback on this change?

Chris


> Another motivation (albeit a bit premature at the moment) is the new swap
> abstraction I am currently working on, that would allow for swap/zswap
> decoupling, swapoff optimization, etc. The fewer states and swap API
> functions there are, the simpler the conversion will be.
>
> I am sending this series first as an RFC, just in case I missed something
> or misunderstood this state, or if someone has a swap optimization in min=
d
> for shmem that would require this special state.
>
> Swap experts, let me know if I'm mistaken :) Otherwise if there is no
> objection I will resend this patch series again for merging.
>
> Nhat Pham (2):
>   swapfile: add a batched variant for swap_duplicate()
>   swap: shmem: remove SWAP_MAP_SHMEM
>
>  include/linux/swap.h | 16 ++++++++--------
>  mm/shmem.c           |  2 +-
>  mm/swapfile.c        | 28 +++++++++-------------------
>  3 files changed, 18 insertions(+), 28 deletions(-)
>
>
> base-commit: acfabf7e197f7a5bedf4749dac1f39551417b049
> --
> 2.43.5

