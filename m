Return-Path: <linux-kernel+bounces-414536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0449D2A02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CB13B2819F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795141CEAB8;
	Tue, 19 Nov 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="cpDYj5/m"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541701B6D08
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030101; cv=none; b=XaPM0wcXIAOyb0rJ2EOyP0TgM+Iv6XBqyo97iMDIPt++JSrkAuJMcYqHRmBmeKEdOK4DPuqJv0p8Je9XK5H5/g7sj+SDIxBM4NNPNTynL6kQt4yHo1Xsu8JQ7x/fskRso8OtZNRCpGn7/r4LSDl7SVCNwc519FvNMEagumUv+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030101; c=relaxed/simple;
	bh=OZp9Tw6yL8Re7D0eWBNxYCp4KrM8y/p9GhrShurIuSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGtmqj3GkvO3Nc8zrVqQkly+Bqg/Qp9ewpI8eTS1HOAGmdb47XYed9tsjlRmyqCwe70DJCK85kMfVTFbtYaKXZwfWPkvptujdQXxE8Hrpj3FddqgQ5qMSGqxxz1vOJECdbjKFjfDA47W+eYOGjvqUsErYR/cNg3jUt8kl5c02u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=cpDYj5/m; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4609e784352so40359991cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1732030099; x=1732634899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QeEhrDw4c0Kz4tqkiPNGCc/5hs75/QoQULwwP0t36w=;
        b=cpDYj5/mcrFZby9D6jnEIf9jjWUGqX4EQRNRu4CtBLhCyjXTGRT0bZKVa5T1B9lGbE
         HrLGn2mAATZtpB5rdovzVTfA+PHxvs5VrdRpTlS4880f4obi2SKQny0vr2PbZSslytq1
         pseChJ3cAdQ72VC8xjvABrEHuSPGrXSVqAqaLVGuvBS/Y5f2Gcol80d7i58RSKVC3mFr
         2Ncb/7UbhAev2nFMocRbu+RsarWnne9LabARHK68cSzp/pm5jPoRtX6yAiKpDYEGGaj2
         d9/sqaUszmA+aSoD0ci9F0fkWMZADM7cQWNVI6rjXuzNTeZhBLWxktUm+hA2bhV330pS
         k/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030099; x=1732634899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QeEhrDw4c0Kz4tqkiPNGCc/5hs75/QoQULwwP0t36w=;
        b=WXv2941zcJ/MNDXT3YvS/0Yuw6GzyPkKWiHgSxpRLamYlXCqDmyBp2zLWOpBwLmu0L
         KjangOstaLnRL5dYR8x4eP8VHSAo+po7PWPJQFNSSbxZZUgzk5e9K4aTn87KpyFiCx1Z
         iHjrG3wRsHCnO41W323JILtqaBAzxBvXjwwm2LCXaPeCGHuzR8rNq7IrqKRrGvIXaine
         MY0HvUMx/qAN05uZrAtD4QgbcbzbhIIE1k5CHswTKB9l6XCkFO+y9X5mOtX7asumm+oI
         Czph94IvnqUy6Z5nhdQwYlc7nsuo1dYgygA/VBWNe66SHoDCaR7fuFqBWrkrOlzSxyMx
         geSA==
X-Forwarded-Encrypted: i=1; AJvYcCWKH9wCOPlOu6T8YDyNAt2jYKOLHcRMGuSNf46vXBco0icVmr09w9Gv3jAaN2o2YFWkoL1/oZ24DVHzkFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz96+8G6i+PP80Ax83z2o9abt6YsbtUu/Yufs9T5mltcsdkDSrd
	0HXSjkRp7lrEx8p1mp6bCEXEqBdmpVLrKfGsUqfnEwHJ6n7m8jUjBEM/AZUJ2nm/qBFUfcBFnlo
	UfhFCAV8u2x677qvj2CRj1H0r4V7VwNux+WnLIQ==
X-Google-Smtp-Source: AGHT+IGjLxkk4QkkwK1ciHnchEj5dZmSOY2sOg7ByrWwnCFxlGfZCDeqpXCjhZd11+NESOAZlS8fRqJSchVVDKJHbWo=
X-Received: by 2002:a05:622a:17c6:b0:463:5c35:522e with SMTP id
 d75a77b69052e-46363ea1118mr257015011cf.34.1732030099085; Tue, 19 Nov 2024
 07:28:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119090740.65768-1-zhengqi.arch@bytedance.com>
In-Reply-To: <20241119090740.65768-1-zhengqi.arch@bytedance.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 19 Nov 2024 10:27:41 -0500
Message-ID: <CA+CK2bArva7tUWhmiTSEeNRHTFXx6zU7z0f1kN-2+ZZoTihfBA@mail.gmail.com>
Subject: Re: [PATCH] mm: pgtable: make ptep_clear() non-atomic
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: tongtiangen@huawei.com, jannh@google.com, lorenzo.stoakes@oracle.com, 
	david@redhat.com, ryan.roberts@arm.com, peterx@redhat.com, jgg@ziepe.ca, 
	muchun.song@linux.dev, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 4:10=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
>
> In the generic ptep_get_and_clear() implementation, it is just a simple
> combination of ptep_get() and pte_clear(). But for some architectures
> (such as x86 and arm64, etc), the hardware will modify the A/D bits of th=
e
> page table entry, so the ptep_get_and_clear() needs to be overwritten
> and implemented as an atomic operation to avoid contention, which has a
> performance cost.
>
> The commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
> check") adds the ptep_clear() on the x86, and makes it call
> ptep_get_and_clear() when CONFIG_PAGE_TABLE_CHECK is enabled. The page
> table check feature does not actually care about the A/D bits, so only
> ptep_get() + pte_clear() should be called. But considering that the page
> table check is a debug option, this should not have much of an impact.
>
> But then the commit de8c8e52836d ("mm: page_table_check: add hooks to
> public helpers") changed ptep_clear() to unconditionally call
> ptep_get_and_clear(), so that the CONFIG_PAGE_TABLE_CHECK check can be
> put into the page table check stubs (in include/linux/page_table_check.h)=
.
> This also cause performance loss to the kernel without
> CONFIG_PAGE_TABLE_CHECK enabled, which doesn't make sense.
>
> Currently ptep_clear() is only used in debug code and in khugepaged
> collapse paths, which are fairly expensive. So the cost of an extra atomi=
c
> RMW operation does not matter. But this may be used for other paths in th=
e
> future. After all, for the present pte entry, we need to call ptep_clear(=
)
> instead of pte_clear() to ensure that PAGE_TABLE_CHECK works properly.
>
> So to be more precise, just calling ptep_get() and pte_clear() in the
> ptep_clear().
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/pgtable.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index adef9d6e9b1ba..e59decd22e1cb 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -533,7 +533,10 @@ static inline void clear_young_dirty_ptes(struct vm_=
area_struct *vma,
>  static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>                               pte_t *ptep)
>  {
> -       ptep_get_and_clear(mm, addr, ptep);
> +       pte_t pte =3D ptep_get(ptep);
> +
> +       pte_clear(mm, addr, ptep);
> +       page_table_check_pte_clear(mm, pte);
>  }

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha

