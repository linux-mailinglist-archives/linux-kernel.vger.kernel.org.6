Return-Path: <linux-kernel+bounces-527415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D119CA40B06
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BACE16C94E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7AE20C496;
	Sat, 22 Feb 2025 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy1MOtdp"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466413A258
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740249842; cv=none; b=Bysxk7Tmh1wnhjBX5rUKatvBN9J88d0NNRbrXdn1ghLtb2/jwmoY59gtYCeKqhbqvJm4KkxEgHqWneJeJQm6geumsdqY1W54cUqoojK4RapfHqHNciq5FDXvupFdGzbMwANv7lyZZUSdbXkT4i3pqCwh95vR8yKOSA8r2WpZofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740249842; c=relaxed/simple;
	bh=u9CNX1lK65MuV1qJkFaCmogB64VpkcZJQhWje5kiI3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kc5Qd5wJyf6i1yvJkszF+I2QgxHhBPdZEocF355+NNF/sHjZeJ665FRHd/+3rkWX5+NXLgEd8Z8i9iY3G0okkrBvs2/ojnPVU2cy3OoSHNZjZP37kGH6f5cOWoPI0ginLb7ueLaAibVWjfQ+Fgq3esep9y0cGQB4eEFHGwf9E90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy1MOtdp; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30615661f98so30400551fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 10:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740249839; x=1740854639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+jmeUiRFgrLTZopYI9v80YSYwCYyzfjXIRGcBiLAVw=;
        b=Gy1MOtdp4QmhtpnUKfgAVQODgYe9ivTblw5OKq+KYSZaJzRVrwYr64LEu5PxlTAHHQ
         GxC+cTsilpNq20H4UVI0nE9HPoXNDIXB5BO7HEIXZJcPuZHn7sS2FOzjYSXoQq53O2xx
         meZXDAdXRRKcN4qTnAL6PVAyPvIG/NrgjjGru0kRoO+nPHq3T743F3Nx+R/FLs88yYJQ
         SFba5j5+7ozL78PKW27IyRlSbgsSj+NpqVA0o9VURD7L8xpoMDWrK8yw8z/Ho56MMdC4
         FIQWK0iIvF9Dot9AsogWRxfEynw6Z0LQYPI2AImURKvb0hebE0fO5JZDQOwkuYbdvjfA
         39VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740249839; x=1740854639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+jmeUiRFgrLTZopYI9v80YSYwCYyzfjXIRGcBiLAVw=;
        b=GcPRXe0dmDrjvTqcD4BfWBNwI2WT7QWBFVxkuXd12+iSiMuezw7M8Ja1pE1EYRAxYs
         Ko/fgUCpj03dS40IRv7RYKNOsL64H6T+9JPBeTHOZCgk6jmiCmRbZcKVB7LW7yqwQNBU
         8FStDmpaaXUIkhwD4egCj63+7RKSEhhrTXOw4zX37Ay5wpn5YOgvBGwjE8BEZ/ZcN2sI
         yQpmYCmnJVX0YAXoTUsLsLM7JUWvKFR6Qha2uCWL6GKut2tToU4AKG37cFrV+zst6uQm
         4KlNU3QA/uY9zg/YBBGZPW+aULvQ6IV9RCMyMSs/rTsO+qiZWxuD6dmykD5NcJlX4pw5
         IddQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPDNqdXIXUvXTJKsMGNyPz4RuPZrtfxs42piIUafYro97KKO3F+mBy48w2iUQWOWTPdjnoS30S3U7Pa84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wEJPbOo6iCTLqZIC28UI4bQkPo26X+HgS/uuZYs+PvlIw8pv
	qLZhDPfUzfc44cpxPEhELpEJwvV1ybkzaiM3zLqeeKmmvqLrx49JD2WT4Pfpv4m6I74sB+hQZCt
	e4rNerBKy90DP9QKhjgSQ3N+TpoM=
X-Gm-Gg: ASbGncu1/llIHD6ycuYcqGVOrgXpN8Cu3u38fxBPprmUcPi6lwPlnLghwhsZob9bx3+
	OOuQANue/8FuJ+4L8hFp8ar6wE+xwJDJ+AhtIPNCEqN4CjhmDFhpOyCRfvqoRPbd3DwjaqUGrLK
	VblxiEe0o=
X-Google-Smtp-Source: AGHT+IHVnRQdOCRBMeRYt98eC4fNCl4k6Xa1RLOox2zKGp3H+ftnrThhe7xLnLL/s7EE5e/CTGvBlnh+EdQX7U/0Dk8=
X-Received: by 2002:a2e:9416:0:b0:300:38ff:f8de with SMTP id
 38308e7fff4ca-30a598909d5mr26356111fa.16.1740249838510; Sat, 22 Feb 2025
 10:43:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222160850.505274-1-shikemeng@huaweicloud.com> <20250222160850.505274-4-shikemeng@huaweicloud.com>
In-Reply-To: <20250222160850.505274-4-shikemeng@huaweicloud.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 23 Feb 2025 02:43:42 +0800
X-Gm-Features: AWEUYZlcPWRlcwjN0BHXG8TxtcCkPpE5iDcq2AJ1DErFnAQonwkp3WiXwC8-bmc
Message-ID: <CAMgjq7DwUciLTcw-jsCzTz9bz+KMKqzbzCYSr58ZFhCNKPVpaw@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm, swap: avoid BUG_ON in relocate_cluster()
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 3:12=E2=80=AFPM Kemeng Shi <shikemeng@huaweicloud.c=
om> wrote:
>
> If allocation is racy with swapoff, we may call free_cluster for cluster
> already in free list and trigger bug on as following:

Maybe capitalize this "bug on" to BUG_ON to be consistent with the title.

> Allocation                        Swapoff
> cluster_alloc_swap_entry
>  ...
>  /* may get a free cluster with offset */
>  offset =3D xxx;
>  if (offset)
>   ci =3D lock_cluster(si, offset);
>
>                                   ...
>                                    del_from_avail_list(p, true);
>                                     si->flags &=3D ~SWP_WRITEOK;
>
>   alloc_swap_scan_cluster(si, ci, ...)
>    ...
>    /* failed to alloc entry from free entry */
>    if (!cluster_alloc_range(...))
>     break;
>    ...
>    /* add back a free cluster */
>    relocate_cluster(si, ci);
>     if (!ci->count)
>      free_cluster(si, ci);
>       VM_BUG_ON(ci->flags =3D=3D CLUSTER_FLAG_FREE);
>
> Despite bug_on could be triggered, call free_cluster() for free cluster
> only move cluster to tail of list and should be fine.
>
> Check cluster is not free before calling free_cluster() in
> relocate_cluster() to avoid bug_on.

Same here.

>
> Fixes: 3b644773eefda ("mm, swap: reduce contention on device lock")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/swapfile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 425126c0a07d..fc45b9d56639 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -653,7 +653,8 @@ static void relocate_cluster(struct swap_info_struct =
*si,
>                 return;
>
>         if (!ci->count) {
> -               free_cluster(si, ci);
> +               if (ci->flags !=3D CLUSTER_FLAG_FREE)
> +                       free_cluster(si, ci);
>         } else if (ci->count !=3D SWAPFILE_CLUSTER) {
>                 if (ci->flags !=3D CLUSTER_FLAG_FRAG)
>                         move_cluster(si, ci, &si->frag_clusters[ci->order=
],
> --
> 2.30.0

Thanks, other than minor commit message issue:

Reviewed-by: Kairui Song <kasong@tencent.com>

