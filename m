Return-Path: <linux-kernel+bounces-411181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8339CF44C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81BE1F27542
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D125B1E0DEC;
	Fri, 15 Nov 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+LzpIoo"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB518FC89
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696598; cv=none; b=luf2tPvo1kZlmHeRisWI2qKYmGCjZawNoRvFn+o0G1vQmevJDwpq89g2lgejmH+bCJQH3PeiIk3ilN4HoF5JG1gZCUzLrCEbTi7FANC8azRMMVpyQLRY1xlvJnaF5/uBulcu3e70+IeJMbEdRWeL1RBBsSsSuMfE+BZI5cJomwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696598; c=relaxed/simple;
	bh=Om7YxPHmwZq2QQ/5gr2pqCjY3zJBC5S+xdrZjk/11j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWUXtrbHvgK230PCWevTOHRwqupbYQxCdYIFrZPic5xaBi9L6RYGG4hX9iQ66HQpRNFsTNvUvCWbLdv85CmixJ0CQUJU6fqAagESzudK/vt0j1HDENkEJO9SjxQd+JOxqDHlsPD3u2beKSF9PrcRTbq0oM9CGT94+mwCHDtIkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+LzpIoo; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a71ef98bc4so4435ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731696595; x=1732301395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcYHSX3eSDOwYJlyrykU5iDBubtq2D6dUMemXp5e0I0=;
        b=Y+LzpIoouOLzWZobAV3pFlDimIuwiH9fsEl7KMjscoXFGlWHd7iVbATLTOqtJTo6/r
         PEsn8X2z8zj/SHwEDyj64kQNZucPl4DUWWTESZBEUSg2xKSpv3jy9ahYlfbkbPTuFa+1
         aux/yttXjWBlx0EqhkmSFotWzF36nmS41scpXi5eFtDWDhqVtqRxhZHGgXZA/OWmbT8y
         xZ9AYYA/m5k9F+Nq+9Ebr70xUNO90fdVyoWvJhvDki8QdPYsWP0EYEAZtZapx5UQl8+o
         TqjaVI/NTh2DZcV2bGHxbTiEZVy9Ju6fxshXXCCznuNG5VfDjY5Oc1FNs/eUQ7a/Briu
         c8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731696595; x=1732301395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcYHSX3eSDOwYJlyrykU5iDBubtq2D6dUMemXp5e0I0=;
        b=VcLVZgrJs6Ubm+A3y4yooeMT0fKgjc5Oppm4B5XW3EHmrpRN0UUMto9XkWLyRrLuEF
         sSyJ0jTFCwJwC8fa9aUZmfOTnd3w/kcrcd6sevknu9ok0zwRaDtZWRB8+FN3dTEfMQp/
         7FswW6OsNu0ktj9ddYWDQQf6Vu+pCAYkjtg0f933MB1iK7T++6Bkn5aYBgmoB6dOlEaw
         AWD7txrGnD9pPVX3Zh+W86uulOZb1FEtW5dN3Rli+4lClPJr6tk5AOm+1wkHm0TYEdkN
         h2w7/+zC5R8drDe5mmM6eGQYNH92QEJy0hBWciQ5ES5iySDYznSy8gJGpiBg4h1gPF0l
         3lHw==
X-Forwarded-Encrypted: i=1; AJvYcCVfvuwwNbKKsRec4qBXjLJMsb5+2inuBDzeywUXPOCciJV4er7k1yLoU9bftfpg+H9qCw9mI47+Drty6Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVrNSkANud5OXr80ohUqglNmSRHcwh3xs97Aukz5L6GN6bVRIv
	IwwLWAv5cbdEobIn8MAsTg8BwAW1wvPPqZ49QDqiqu9g5ZX9Mc8U1SaYRZgui3iI/2l67hwGKE/
	5ZN0QheK+b1ym+9mVw9A8K/6bMCMMgzczVkdG
X-Gm-Gg: ASbGncsF1Uqc6Lkfi6AlA8udEz3tAYLAkM0dIaveXR10tRwCFRVxoug30PCteCu7SdA
	+6Og2cdEeV94U8+T8C1FlYsxc8ucF6w==
X-Google-Smtp-Source: AGHT+IEhu1BH+cd1vIZd8xbAt/mAqKxv62ZcAyQ4CJgMWhaBBDisA56AaUhZRVzAvuHocnDLaxzWybCfvXvkAWw+wcQ=
X-Received: by 2002:a05:6e02:13a1:b0:3a7:493a:59ab with SMTP id
 e9e14a558f8ab-3a74f7b097dmr980945ab.17.1731696594832; Fri, 15 Nov 2024
 10:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <39d41335-dd4d-48ed-8a7f-402c57d8ea84@stanley.mountain>
In-Reply-To: <39d41335-dd4d-48ed-8a7f-402c57d8ea84@stanley.mountain>
From: Andrei Vagin <avagin@google.com>
Date: Fri, 15 Nov 2024 10:49:44 -0800
Message-ID: <CAEWA0a5vMq4vGRj4FVQXUR2unN-xAmsFt5ymi4SL+H0yfNpdfw@mail.gmail.com>
Subject: Re: [PATCH] fs/proc/task_mmu: prevent integer overflow in pagemap_scan_get_args()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 12:59=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> The "arg->vec_len" variable is a u64 that comes from the user at the
> start of the function.  The "arg->vec_len * sizeof(struct page_region))"
> multiplication can lead to integer wrapping.  Use size_mul() to avoid
> that.
>
> Also the size_add/mul() functions work on unsigned long so for 32bit
> systems we need to ensure that "arg->vec_len" fits in an unsigned long.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and option=
ally clear info about PTEs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Andrei Vagin <avagin@google.com>

> ---
>  fs/proc/task_mmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index f57ea9b308bb..38a5a3e9cba2 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2665,8 +2665,10 @@ static int pagemap_scan_get_args(struct pm_scan_ar=
g *arg,
>                 return -EFAULT;
>         if (!arg->vec && arg->vec_len)
>                 return -EINVAL;
> +       if (UINT_MAX =3D=3D SIZE_MAX && arg->vec_len > SIZE_MAX)

nit: arg->vec_len > SIZE_MAX / sizeof(struct page_region)

Thanks,
Andrei

