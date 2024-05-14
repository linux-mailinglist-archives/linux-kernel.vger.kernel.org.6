Return-Path: <linux-kernel+bounces-178414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B55B8C4D43
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EA8282A36
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975AB15E81;
	Tue, 14 May 2024 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQL7oKoM"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887C11C83
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715672818; cv=none; b=R8OMVbI2qzPp9xXuwADHjpegX52FNMjNfFNy62fJ0SHrRQNDZUuAPhOhbyYnWULHw1HvWoeNS9qHKZt53R94luOXSEpMZk0UvcO78jdJfFtwzozTQ6F6gDws+xrxKkHiSF2sxVXd5vRR4Gf4v/B+BP4qOrLhIztFAZtwzw6OLZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715672818; c=relaxed/simple;
	bh=Tthyu0z4ugp3pvNFE5UCiEhx+tR1a5u1KgjnXdlccMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkK0UKUl6v3gQw0uckd2kRcQ4gnT3QUSgg50S+T5yopaC7FkaTAxER5hcf43cAsmsspbwaI847GIl8UHK40Og+Tz4mxFGBldob2pnbNvboZxiZhclIJiNom1F/zRGhyLMsX7BCTDisFzL7D/fVxgapzdXBnVCMeu0x1tbUxw7jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQL7oKoM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so552384866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715672816; x=1716277616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDDRioPzmPP6+LE9lNoP/oGDK/+i7IaW61Opfh8Z7TM=;
        b=UQL7oKoMDT4RMuRqJ7EgveTWr7v25Ju2qGDbHQS4FR/tZo5nOqmEmYxRBUDGhyXKeq
         z4KXs5kWHbatv3GxJPt/EPwnLRO04IzkIloat3BgN4R0VXzwA/zkm080v7/9GwhUtL4R
         Wb4HD79+982axM5SFltIQ1m5wWASnQlPS/J++AIriaH+QHassNMbYbWDCtPGAluYe/nB
         K7yMGIaezrqK9MRDUmvkn+nQcjliRDLG6dvRvKLeNEDsA7BemWnuPA7xAmwqbqKMnoQ4
         sMPl9xKhyDRR92yWqf8Su7Gao+zRRCE7KR2/RpJazz/Z9MhFFFBBulEtu6y11iBSQjJI
         WFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715672816; x=1716277616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDDRioPzmPP6+LE9lNoP/oGDK/+i7IaW61Opfh8Z7TM=;
        b=JQtpyvHOmUYK+drumRvm0Icjk0QKdWL9xhrN6WwLc9RqPtDcXwtjfHG1gTm4v3HgcE
         u9fpc0mZliUCldhVj7Xkclju2YVzdTt2u5sgce4974mWNnw2D84QqqxCzSu8Wm78JNSw
         XvfNJwdcHwZhoe+AfTUu5gK8gLMCh0OoXi3ydODsOoijoaQ+IyZHgaf3hnYrB3XStCA7
         QjZ9l9iA11HWkdvSuwiyFViyGjJM7FP2TrodXRiYJdQXjzusow0ms8rFkIRcXSGMYEUd
         i1Lz6EOz/793+m3itaDhC+NWPRMBOQDFI6e1yqrdjllhlt7TWUSDQkr6F/q3pwrGDSAH
         qkuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjXZ/X4txLB3McHr1sIMaxEQIG8BH7DrTiXMmxFiWAa7Cx06VlNEcRp9v2eU6LXo3FTJy2aG6/whXoKri3yGzbbhmUmRBF2J3HmOmA
X-Gm-Message-State: AOJu0YyL2/5cUzKhKjUQB2Kk5a31mzSbHXEL6AX5zJmpnUny5pEUe5ov
	KuD9L7owm8h6gP0+0D7Sgr++2UiNAWRiYzPXAJGDcrXetse3atpDxNMSQprWtlDjFnJJevhEriW
	8egREqTy0cL/cUVJ//+t5FU4Ua1g=
X-Google-Smtp-Source: AGHT+IHucBQ7dc7PnYTMhlvRTAb71c+Utt2cAvwC/TxIIrr8TZCHbS3SmsoI/ipJJDw0jdBr0COkROaqJdC6raI/78o=
X-Received: by 2002:a50:a417:0:b0:570:5b70:d76d with SMTP id
 4fb4d7f45d1cf-5734d67aacamr8193173a12.28.1715672815530; Tue, 14 May 2024
 00:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513074712.7608-1-ioworker0@gmail.com> <20240513074712.7608-4-ioworker0@gmail.com>
 <f22c9fc8-2356-46c6-ac8e-dc97328d7fcc@linux.alibaba.com>
In-Reply-To: <f22c9fc8-2356-46c6-ac8e-dc97328d7fcc@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 14 May 2024 15:46:44 +0800
Message-ID: <CAK1f24n=fT6MDCkN_2ycCmxV3fTkdqRdg7iiq_aXX+AvQ7hXmQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 3/4] mm/mlock: check for THP missing the mlock
 in try_to_unmap_one()
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, david@redhat.com, 
	21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com, 
	wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 2:41=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/5/13 15:47, Lance Yang wrote:
> > The TTU_SPLIT_HUGE_PMD will no longer perform immediately, so we might
> > encounter a PMD-mapped THP missing the mlock in the VM_LOCKED range
> > during the pagewalk. It's likely necessary to mlock this THP to prevent
> > it from being picked up during page reclaim.
> >
> > Suggested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
>
> IMO, this patch should be merged into patch 2, otherwise patch 2 is
> buggy. Quote the description in the 'submission patches.rst' document:
>
> "When dividing your change into a series of patches, take special care
> to ensure that the kernel builds and runs properly after each patch in
> the series.  Developers using ``git bisect`` to track down a problem can
> end up splitting your patch series at any point; they will not thank you
> if you introduce bugs in the middle."

Thanks for bringing this up!

I completely agree that this patch should be merged into patch2.

Thanks,
Lance

>
> > ---
> >   mm/rmap.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 4c4d14325f2e..08a93347f283 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1671,7 +1671,8 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
> >               if (!(flags & TTU_IGNORE_MLOCK) &&
> >                   (vma->vm_flags & VM_LOCKED)) {
> >                       /* Restore the mlock which got missed */
> > -                     if (!folio_test_large(folio))
> > +                     if (!folio_test_large(folio) ||
> > +                         (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)))
> >                               mlock_vma_folio(folio, vma);
> >                       goto walk_done_err;
> >               }

