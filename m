Return-Path: <linux-kernel+bounces-408417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5E79C7E82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0DEB22A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D3118C323;
	Wed, 13 Nov 2024 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdO+w99O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925818CC17
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731538659; cv=none; b=jJDZETpIAKxaAjUL7jaNWOBSDoOzQA1N2us1RvqwuZxN5DsTym9Y/vdKeBm2Hf3CeaZY+rGKd0eYVbf8o9FsXgWL3raj9GgMagxTnnp9UAdjdVyOrc8b6xUa7lxb4Z/ESRxtjUPzEuq6X4mRMIO+SKqmQimLBWLpjM1gpxvOmz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731538659; c=relaxed/simple;
	bh=F4qFuD+NQ8SIX+ADfHBwvzYGmCbsun2Tf1dOJWCsWxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzyhNQ+0z1IzwTgjHfe1vVZFSvL2LyMzcQDxyX3DH0vE/gHSeTttdKxNuWXW7LCqozWRXRuAIMPdqB2hU3SiKDv7a0H/IRrfN58EDFG8+Ct4WForHWYknQqxaWvIFnU/sU2v7UiynopQx7NVwICoxIHtYepqndOeqMNckzdtG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdO+w99O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE4BC4CEDC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731538659;
	bh=F4qFuD+NQ8SIX+ADfHBwvzYGmCbsun2Tf1dOJWCsWxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fdO+w99OpOrMupwTzAUHnGCR/diV1gpZ9fpWsrfySX7rPuC77hJFk3yPZdeXu6tw8
	 4e+Gi5yYgo7gliqpQldCRe9dbnlmqAoQrSq6y6J358s61Iogs9A3dJ0MmEzNOD+EfZ
	 0ddnZPPZjqD/S4e7RLetQEUx0nvZUw7FZZK5hVI7xVaMS1ELKLS7uhc3G2zKhMgS4Y
	 rMeJv0TeMHXcatX2nro9DkFNIvGS8T0rNw7EhqYQ7ONaflO43jFL0l1xxTinQrVUMR
	 2QC8rWV86/bZ6UECLWQM4Pb+DJqUqsg6dytD4QvUh1L0IELYIORbsckVMfjL9rH4X0
	 kKyCFcX/GN9UA==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e5e5c43497so181937b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:57:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVaaXYWBgqPS+qRWm9PIJ3wJL2QwQi7onIH3DRh3kLZJUgk/gASS8uQQHkZxdy/V2avjwEEpB9d18BeQcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRIKdqV6LNiwEFxoB2bLbFwbGGc81gv4iC4ZfCjDJgYKwT2XZQ
	N9CAgIi8Q5MsruZPVUt7VANCMtbc9a4WzilzToWVUV9FqPjOYWdW0wmUP6csciDrhLE6R4acR2N
	tPBFuWRWxwiq2asnQwE9kWmq2eYJ2XttY4q3+eA==
X-Google-Smtp-Source: AGHT+IGX+AZeH4tjTm507csFHxymMzI73TISRu2RbxyjeBezahjdShvm95sJmzw2uv6GLXp3B4unFzSSrpn7m/y4tT8=
X-Received: by 2002:a05:690c:3504:b0:6ee:40f0:dda8 with SMTP id
 00721157ae682-6ee40f0e2cfmr4232327b3.30.1731538658317; Wed, 13 Nov 2024
 14:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81e34a8b-113a-0701-740e-2135c97eb1d7@google.com>
 <C4ECCA8C-FBF6-41AA-9877-4376EC94E021@nvidia.com> <6fcaaa72-4ef6-ebda-cf37-b6f49874d966@google.com>
 <3c995a30-31ce-0998-1b9f-3a2cb9354c91@google.com>
In-Reply-To: <3c995a30-31ce-0998-1b9f-3a2cb9354c91@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 13 Nov 2024 14:57:27 -0800
X-Gmail-Original-Message-ID: <CACePvbVXL8i2_ptfeOcwfDJ=5O_DR+ch+p5D-jLnZ86jfvtSPA@mail.gmail.com>
Message-ID: <CACePvbVXL8i2_ptfeOcwfDJ=5O_DR+ch+p5D-jLnZ86jfvtSPA@mail.gmail.com>
Subject: Re: [PATCH hotfix] mm/thp: fix deferred split queue not
 partially_mapped: fix
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Usama Arif <usamaarif642@gmail.com>, Yang Shi <shy828301@gmail.com>, 
	Wei Yang <richard.weiyang@gmail.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Matthew Wilcox <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Nhat Pham <nphamcs@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hugh,

LGTM.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Sun, Nov 10, 2024 at 1:11=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> Though even more elusive than before, list_del corruption has still been
> seen on THP's deferred split queue.
>
> The idea in commit e66f3185fa04 was right, but its implementation wrong.
> The context omitted an important comment just before the critical test:
> "split_folio() removes folio from list on success."  In ignoring that
> comment, when a THP split succeeded, the code went on to release the
> preceding safe folio, preserving instead an irrelevant (formerly head)
> folio: which gives no safety because it's not on the list. Fix the logic.
>
> Fixes: e66f3185fa04 ("mm/thp: fix deferred split queue not partially_mapp=
ed")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/huge_memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 03fd4bc39ea1..5734d5d5060f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3790,7 +3790,9 @@ static unsigned long deferred_split_scan(struct shr=
inker *shrink,
>                  * in the case it was underused, then consider it used an=
d
>                  * don't add it back to split_queue.
>                  */
> -               if (!did_split && !folio_test_partially_mapped(folio)) {
> +               if (did_split) {
> +                       ; /* folio already removed from list */
> +               } else if (!folio_test_partially_mapped(folio)) {
>                         list_del_init(&folio->_deferred_list);
>                         removed++;
>                 } else {
> --
> 2.35.3

