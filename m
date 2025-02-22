Return-Path: <linux-kernel+bounces-527004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59414A40618
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276AC17616A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140B2205E0C;
	Sat, 22 Feb 2025 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIuX2DyG"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1AD16F0FE
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740209633; cv=none; b=ZpVLPoIMb2PymSdjiI89r+DfX59LWrS5AKiCwK8ZZze0OnaU/qTX7wJdqM3E4yvx2STzOcvnkDWjVe4R6D0L1s2EVY+Yd/hrQqjTJs1wMbEF1ya8+6MRMWBnmrEbq6TQnUDAJikZPVcWuQDS7E7nLnMKR1HimCrf8v3k2VTKpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740209633; c=relaxed/simple;
	bh=YKBWvaVc+h2gV7yAjR+Fq2+B1m8TJ1LTNzJbvo10D1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTIhnIe26+KFFXmx0CP+tSpTY99lemedcj4ULSvDvufDoPCYaIrNOSxM0aOgjxyETSRu5mE5Zmw5JUgErBSnpkOvutWE0MtBsMcMjjApPi5C9rSHsG/msevKmW2dvNgGsNAmPLguvlldjQhySb6qwVybvsfigVqOinggq3pH3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIuX2DyG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3072f8dc069so30060261fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 23:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740209629; x=1740814429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7ZKJryv9NGH4ZmWrLm39lrMCcjM9XDhWwT1fHx65SY=;
        b=CIuX2DyGRGaB8Id8+DaR2TyEfquqV3UfClMOXQoDq1no9rRp2xY/epmC9w5tfxzSoK
         W2bdXGFTfChcS+323O9yhmURg4kSM8n5BiUAbxWrc2OYz+zyTnVsZmkALLOmDwek9iyB
         eiJdujW+Y8whP3BlTpNJs1eEpz+vtPEaOjmk7Hv1KDTjGMdYpHVq+Ms4q2oKv7Th5DmF
         nL0cugQmq6Yj65nL2pYh5dj2GEeW9DrHHagdfBaCZlWAMvJh+sdfNoOO6V59KrY+8QBj
         l7rRbAeYu5r+8XEEPsZdWKYUC7ICISEN2Kgm/kTYjR51sO6HcOdnHATSFCjZko/BYNqx
         8lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740209629; x=1740814429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7ZKJryv9NGH4ZmWrLm39lrMCcjM9XDhWwT1fHx65SY=;
        b=d+snMjEwxgGRPzyHAhFlXQJIMn6aMGor63BEjQuepgBCWbNIMsO70i7+9FJZYqcuYj
         hK7a1+d4MLgnCR3rZmnW0fqkCzpWsxe4V/4AWSk+gtahsIORq0vobP1HiUl7MQ4kWE7R
         2n8eEXV3vs1DuXmF2Ub/dotOANuHYTIsRWLip2PnPBnYMd0m41/XZThZH2OABiFwKhY5
         HE6UaVC/eaJ4paOSRHiN46Wvj3r+oHkLEsPmvzr+xhpVYsF8AZERBYc5ucvbY+sIgGRF
         Fot63R7WpIEwxwtbxqNH2H2vhQmmUXK97uuCbCVcnveABGbnyXbr9rnxhdvMaktkgs3N
         0xxg==
X-Forwarded-Encrypted: i=1; AJvYcCXsnybNunS9pt3FyeFwdQ194c4luH4tHZrLVty250tCBshDuIGJrI5Js0V8nFlnNtgWimNVTbUUCJ7mUrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD8XSrhQ0iCTbxUHYWsPH9PvnIUSXLEDZLJxyXYr8C9bkoptHn
	gszEhHfnMNZm3wQp/7pU4SX/22kP7bJa+B0AzkYsqelZAXRBAKupCu9apN63ujwcOTmGaluWDPA
	4x8KXPfS3Fen0cHE0oElSC8IG5J4=
X-Gm-Gg: ASbGncudJwZTLfvoJFf1OaGXnKiEiib3wzjNGTgKKAfRIrz29QqoMh7kqg+bR2SFG6i
	Od4FbhKdZhGixR4nzwIGOoRVEFqj2IoPaySjsFiHssvwI8P3x4o1Xl6KtubXcUnrxOzy2TORl7e
	6PZGNQBKE=
X-Google-Smtp-Source: AGHT+IE+5wfin6b8qJx/gOSmboC8SXpDUmpz+zf3njf90+6h3Xw4tyRxa1iHNH6nyq10vKtwnv+c/HJVjVeQhPrV7ho=
X-Received: by 2002:a2e:869a:0:b0:302:3e14:34c8 with SMTP id
 38308e7fff4ca-30a598f4533mr19695191fa.22.1740209628882; Fri, 21 Feb 2025
 23:33:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
In-Reply-To: <20250222024617.2790609-1-mawupeng1@huawei.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 22 Feb 2025 15:33:32 +0800
X-Gm-Features: AWEUYZlfZbcM0FF1w8WoaqGDQmgeXg4HMMe0nmegtAUmY82DcLsXZJ5sMuPUiBU
Message-ID: <CAMgjq7AfZnwGAHoyCEhO5p2km-gPLk65WLL+2vO1i8hQDaTy+A@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
To: Wupeng Ma <mawupeng1@huawei.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com, 
	chrisl@kernel.org, huang.ying.caritas@gmail.com, schatzberg.dan@gmail.com, 
	baohua@kernel.org, hanchuanhua@oppo.com, willy@infradead.org, 
	gaoxu2@honor.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 10:56=E2=80=AFAM Wupeng Ma <mawupeng1@huawei.com> w=
rote:
>
> From: Ma Wupeng <mawupeng1@huawei.com>
>
> During our test, infinite loop is produced during #PF will lead to infini=
te
> error log as follow:
>
>    get_swap_device: Bad swap file entry 114000000
>
> Digging into the source, we found that the swap entry is invalid due to
> unknown reason, and this lead to invalid swap_info_struct. Excessive log

Hi Wupeng,

What is the kernel version you are using? If it's another bug causing
this invalid swap entry, we should fix that bug instead, not
workaround it.

This looks kind of similar to another PATCH & Bug report, corrupted
page table or swap entry:
https://lore.kernel.org/linux-mm/e223b0e6ba2f4924984b1917cc717bd5@honor.com=
/

Might be the same kernel bug? Gaoxu mentioned the bug was observed on
Kernel 6.6.30 (android version), and neither of these two workarounds
will fix it completely, the invalid value could cause many other
issues too. We definitely need to find out the root cause.

> printing can fill up the prioritized log space, leading to the purging of
> originally valid logs and hindering problem troubleshooting. To make this
> more robust, kill this task.
>
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>  include/linux/swap.h | 1 +
>  mm/memory.c          | 9 ++++++++-
>  mm/swapfile.c        | 2 +-
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index b13b72645db3..0fa39cf66bc4 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -508,6 +508,7 @@ struct backing_dev_info;
>  extern int init_swap_address_space(unsigned int type, unsigned long nr_p=
ages);
>  extern void exit_swap_address_space(unsigned int type);
>  extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
> +struct swap_info_struct *_swap_info_get(swp_entry_t entry);
>  sector_t swap_folio_sector(struct folio *folio);
>
>  static inline void put_swap_device(struct swap_info_struct *si)
> diff --git a/mm/memory.c b/mm/memory.c
> index b4d3d4893267..2d36e5a644d1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4365,8 +4365,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>
>         /* Prevent swapoff from happening to us. */
>         si =3D get_swap_device(entry);
> -       if (unlikely(!si))
> +       if (unlikely(!si)) {
> +               if (unlikely(!_swap_info_get(entry)))
> +                       /*
> +                        * return VM_FAULT_SIGBUS for invalid swap entry =
to
> +                        * avoid infinite #PF.
> +                        */
> +                       ret =3D VM_FAULT_SIGBUS;

This could lead to VM_FAULT_SIGBUS on swapoff. After swapoff
get_swap_device will return NULL.

