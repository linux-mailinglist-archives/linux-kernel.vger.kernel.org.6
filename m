Return-Path: <linux-kernel+bounces-389836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31F9B720C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A2B1F23E94
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB00371B3A;
	Thu, 31 Oct 2024 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maQAUBKZ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3007445025;
	Thu, 31 Oct 2024 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338824; cv=none; b=fTNv+aSKa1JwQDrqklA+ZuNAvdjz0ONyxgX3oYJ8LNP4m8vkVr+bnFcOedRrI/Hq6gMFZS68GVxaJ8L9w9UVv/Y+NcfAYJeOmcJXkccJs8eabRwAL4cxLxAHj0U/yJqxoc8bbEn/fY512ka64FAgmP2HZkWwj9sRWXXeQyQA9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338824; c=relaxed/simple;
	bh=podcbddspYpvHJXXihg9dE2KxIjh8shQLhcEgSSNyfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLEo86GvjJ7e3sU67FwzIINJ95CmNYlpzACSba/gRoV3NQofpQhyKN6tEO9e7Xb0ktgslAKtbbM3lAb5xVyXShgZLqxDFtw5cxvPh5KCHLhYQIvs2lsGUHWLXtXvDgLqGNxFGwjX+Kl3vrIiS3mag6ekrnUFMlceASWND61qRcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maQAUBKZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso621805a12.3;
        Wed, 30 Oct 2024 18:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730338818; x=1730943618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFR+bKCwvRVUX/BxiY5sWjZTz3GjZpROxqvWLTi/ADs=;
        b=maQAUBKZyrkQ8RQY++EsROsRe9wO5+1lt/OQ4eePoPUomfnYaeqEdjiaToCT1CB5FY
         EN2TG2tAGm3MPQ3vcCT43NTxdL0JJlDmc6iQqOr1+WjlJekTnuhcBzhb7bpPBvIbAh2Z
         4JM8j8dh3/UXHFcHnhq/Qj0oP8g2u/xcMbTMR/joPUSrMQ8BZiHaHGuFNt/PW+rUnL41
         7JN02+I2NMjnN7AZXtFglGlkPbMKJe9rgIFvZ13W+CmInBWJOcb5x4psi5vwSMd3Ffht
         nwDpObpWlNYqmugoe7r7POgaqA8CeILGfKfAZr444E5YOvyDmxRoDlo7mTfIThths1GY
         5mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730338818; x=1730943618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFR+bKCwvRVUX/BxiY5sWjZTz3GjZpROxqvWLTi/ADs=;
        b=fZZUc14fSvXfSe7GtqYrMfyO5yYlyTxnr/bp+Jkr/fwPyNs/UyaJzGiKCl3s8kBJ6B
         1FwKTeQuzdhsc5U+Kf33bGvOR7vmjQo3B7dwjVVGNx5GS6PzC2H4faelYIDCxwSQ0oIX
         QOq36UdhWAul8HrYRnjnT05CyWhU6A72NBbbSr6qvErs4PFqNkRuYzCE+ad2UYI8FYil
         Qts43WyAmOxJJo3f6WGMVY6rSd+cYmKOsEDvXjFTkBKjXhDviGyEd2SnNDlvHVH4Fr9N
         YuWQ4WC0VHwnlTDMUN1kzKzWt8MsaUBdNJFoR2Nxak96lGaB4ES77HSl6mzqWqNbzobU
         s/jg==
X-Forwarded-Encrypted: i=1; AJvYcCUtebUGE5/llhZx0B7ovQrTBSODU/g1Bt60cjpD25PREAjRBtgOtw3KjXYVjbhuYE9f6AJ7ehNgqRE=@vger.kernel.org, AJvYcCWUxroT8jhNirRGahyJjgod6R6XPgKmcNFr8BPxGFeKvrO2uPFnmf/QgxerFilg8aRaMGF/wBWpc/EWC4JH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjn8wfMdB0l0WZLfW9MMTQWWDlmHThHROj1HgaN5mQkYOtQ9m5
	nqsEmquMupdjzB6Zw3h0rMvTKZ54Y64XSS6tMzqxvuO8oXg23kF/LS6llDNR1UF8ZK86aTHyZZO
	2Bm5uu8XiOcMX/fM8XomspvrJX4w=
X-Google-Smtp-Source: AGHT+IHJgLaqlTk3oM2roWzZFSZzpTQuATiSid0TpEirjsjoVUFKzoTKPH5jyfrAx515v80ao8diru9MxcSS6gEH6o4=
X-Received: by 2002:a05:6402:2550:b0:5c8:a01c:e511 with SMTP id
 4fb4d7f45d1cf-5cbbf892059mr13375133a12.10.1730338818227; Wed, 30 Oct 2024
 18:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030130308.1066299-1-mcanal@igalia.com> <20241030130308.1066299-5-mcanal@igalia.com>
In-Reply-To: <20241030130308.1066299-5-mcanal@igalia.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 31 Oct 2024 09:39:42 +0800
Message-ID: <CAK1f24=BNmnhkUWpRZ8hKapN7ZwFp3G+967hVV79bdaxqMsaLg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: huge_memory: Use strscpy() instead of strcpy()
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ma=C3=ADra,

Looks like a lot of kernel code is still using strcpy() ;p

On Wed, Oct 30, 2024 at 9:03=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> Replace strcpy() with strscpy() in mm/huge_memory.c
>
> strcpy() has been deprecated because it is generally unsafe, so help to
> eliminate it from the kernel source.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Feel free to add:
Reviewed-by: Lance Yang <ioworker0@gmail.com>

Thanks,
Lance


> ---
>  mm/huge_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f92068864469..8f41a694433c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -989,7 +989,7 @@ static int __init setup_thp_anon(char *str)
>
>         if (!str || strlen(str) + 1 > PAGE_SIZE)
>                 goto err;
> -       strcpy(str_dup, str);
> +       strscpy(str_dup, str);
>
>         always =3D huge_anon_orders_always;
>         madvise =3D huge_anon_orders_madvise;
> @@ -4175,7 +4175,7 @@ static ssize_t split_huge_pages_write(struct file *=
file, const char __user *buf,
>
>                 tok =3D strsep(&buf, ",");
>                 if (tok) {
> -                       strcpy(file_path, tok);
> +                       strscpy(file_path, tok);
>                 } else {
>                         ret =3D -EINVAL;
>                         goto out;
> --
> 2.46.2
>

