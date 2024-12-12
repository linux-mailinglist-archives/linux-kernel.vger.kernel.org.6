Return-Path: <linux-kernel+bounces-442665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6899EE004
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0881883B14
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A387209F44;
	Thu, 12 Dec 2024 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKRfAJmn"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55504207A23
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987412; cv=none; b=cbVu6b6W/YyGNZOxIpJWG+fTQ+B9q3byc25VHrR7SuziUfivid7oYNFZ4h4mkHmiC79OMA/9/27BJJ/x7BLbtP4oKrsm/91yE86K7RioZ/8Ypo4W51h1QsESynaacbku9uW6IS0a+VL3Th5TSWDYMY5Go1EOCw1l5jqqBFgfcTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987412; c=relaxed/simple;
	bh=ZEpkzoQHg7VjPKxwvVaVbbSYksenc7gg2QSxNhBVA2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEZ65fLAN3GKNnI5GvEd66LqX0nmVqDdp+PtUZ8Zj21xZzM2XK1PUKt7Xf0FGOzkha4Zat2GZcyPXK3KEY59TPocL08VNQMc4pqu22YOcuE2r/WN8cnl8EYEuvVjSAzE2+17JQmZInpxJ+BN1yofDdtYtWt3xHffyC8VA12sJnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKRfAJmn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4675936f333so111281cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733987410; x=1734592210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSwCXQ5wEcG34n6FNAmRCNPsG3IEf6YvAYA+YW6hhoo=;
        b=hKRfAJmnuzffbld7CHNK7YtBNBcNE5asSoVBMUKXkrbgtUD6CORXM1lKi+pTErQ+6H
         IbZY2bBSRyYWanN8fqKdnWCF30BsMr7SpeJL5OhulQ5gsFuGydvJARqtg8w4kEaM5W9J
         j6KSazlP2F6RS2Z2NS4okVyYpMULzWqSSdNjrGqt9TdBayhint1T33WyTMuKXI9lpoN3
         GwN9loq6ZZGpVnXANz7MCF4xEUuKrYHDMx7P0F/fisP+/qpNw1oOH6fYEwvWmxCfWoRV
         9hBhZy5dWhC0FK10O+Zkd/8uakN89DgqWgmbCx+YZhTYcE/9OLxqOy1lEKh49Vi8n5Wt
         mXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987410; x=1734592210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSwCXQ5wEcG34n6FNAmRCNPsG3IEf6YvAYA+YW6hhoo=;
        b=Jea/W6VChyX2OF5jBOebHnz2FUM1PUlbUEzsS6MrmO1T3q/4ReiJRF6CO8Nra3UjJO
         7ouNDWJCdLcIS81gANb2KiQPSxVVfVhGPfBtf4vnasUDDAF+dcviQGm6v70I97tyMNeZ
         5HjXIYvg9NCDyXnKI+lNw+KYeDTQM+8VKuERo3XzjgdkozsYy05i8P2hEDGMhifIVba6
         mBI/SY/z0FC8TiaTuwqJlkFqbVTH6yzFjcGf3cy6eQfTYGGIfSukvnpnzBt91pAOExdB
         RG4BITl6Dthy2Wm9UOs+ggApQv5MgaE59f7v+B07bQr44idclWoKj95kZShFCAHXMaRr
         K6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSANjHMqTwFSoGWp+Z95N1x/7iH8ewhSGUvak7ILDo9qpB9kAVIqNQbiGXOHGMRs+FPIUwo9725coOBCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxlj6LYvUvgMrrnohBj8UZM9rhg90ya4R5gms2WQNiI76BJPu
	0P6S1PIPYLpE5u23aRVIcAaXrBsuGb/CuTIHdFTxnEbta8Q3Tjy/iV2eJqr7L1cAvrJDfQaTROU
	QjRBIJ0s/ygvQyeDFlWO7aoYlDBT/K4h600gLPeeSy6SZPUVeZkbtrcY=
X-Gm-Gg: ASbGnctNJfNDVHHPz8XMKXjjlLVYTkkfR48oJLAGtJ4GmyQgcMWseyRDdocHkymmrdi
	6ynywo0/JDGrs/WCW8z+BD3w2N/GaF50tjamRQwitGkpmRDy5NjZWuCy6jIag9Svb2q1X
X-Google-Smtp-Source: AGHT+IEZrdSuhp9JcuQTIIQJZBkbpF0vMp40RBneVKA9c4WUVk9y6M0BTQ1rdOkrhr1FEK5rG9fO8zodIjUEBJLN8nw=
X-Received: by 2002:a05:622a:4c12:b0:466:a22a:6590 with SMTP id
 d75a77b69052e-467981bb57emr1778861cf.9.1733987409934; Wed, 11 Dec 2024
 23:10:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202412112227.df61ebb-lkp@intel.com> <20241212040104.507310-1-00107082@163.com>
In-Reply-To: <20241212040104.507310-1-00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Dec 2024 23:09:59 -0800
Message-ID: <CAJuCfpGJp-U3t_SHRhuSRTu7Hjkz23oqKSNbVL79O1OQhgJndw@mail.gmail.com>
Subject: Re: [PATCH] mm/codetag: clear tags before swap
To: David Wang <00107082@163.com>
Cc: kent.overstreet@linux.dev, yuzhao@google.com, oliver.sang@intel.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lkp@intel.com, oe-lkp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 8:03=E2=80=AFPM David Wang <00107082@163.com> wrote=
:
>
> When CONFIG_MEM_ALLOC_PROFILING_DEBUG is set, kernel WARN would be
> triggered when calling __alloc_tag_ref_set() during swap:
>
>         alloc_tag was not cleared (got tag for mm/filemap.c:1951)
>         WARNING: CPU: 0 PID: 816 at ./include/linux/alloc_tag.h...
>
> Clear code tags before swap can fix the warning. And this patch also fix
> a potential invalid address dereference in alloc_tag_add_check() when
> CONFIG_MEM_ALLOC_PROFILING_DEBUG is set and ref->ct is CODETAG_EMPTY,
> which is defined as ((void *)1).
^^^
Good catch!

>
> Signed-off-by: David Wang <00107082@163.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202412112227.df61ebb-lkp@intel.com
> ---
>  include/linux/alloc_tag.h | 2 +-
>  lib/alloc_tag.c           | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> index 7c0786bdf9af..cba024bf2db3 100644
> --- a/include/linux/alloc_tag.h
> +++ b/include/linux/alloc_tag.h
> @@ -135,7 +135,7 @@ static inline struct alloc_tag_counters alloc_tag_rea=
d(struct alloc_tag *tag)
>  #ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
>  static inline void alloc_tag_add_check(union codetag_ref *ref, struct al=
loc_tag *tag)
>  {
> -       WARN_ONCE(ref && ref->ct,
> +       WARN_ONCE(ref && ref->ct && !is_codetag_empty(ref),
>                   "alloc_tag was not cleared (got tag for %s:%u)\n",
>                   ref->ct->filename, ref->ct->lineno);
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 35f7560a309a..cc5fda9901c2 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -209,6 +209,10 @@ void pgalloc_tag_swap(struct folio *new, struct foli=
o *old)
>                 return;
>         }
>
> +       /* clear tags before swap */

The above comment states what we already know from the code but does
not explain why we do this. Better to describe the reason and not what
we do. Something like:

/*
 * Clear tag references to avoid debug warning when using
 *  __alloc_tag_ref_set() with non-empty reference.
 */

> +       set_codetag_empty(&ref_old);
> +       set_codetag_empty(&ref_new);
> +
>         /* swap tags */
>         __alloc_tag_ref_set(&ref_old, tag_new);
>         update_page_tag_ref(handle_old, &ref_old);
> --
> 2.39.2
>
>

