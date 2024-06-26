Return-Path: <linux-kernel+bounces-231514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B983919962
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7231C21409
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE38D192B9C;
	Wed, 26 Jun 2024 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+JEHZX/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14F1E886
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434736; cv=none; b=VwY6PsQs6SYU0ICSZOavf9QyI1c+XGQKCkjZCGKGSTH/W4doFza2nU6bpNtjxqe2rv4f3TmiRAREYejkqduYHXHA3WxAF2+oIwwLTYOp5yNBndhhLlAFiyVNo+RlwIPdWX16ZeI1+AOHtny+G3u6IxfeIzA+weOFQP/YmfrkXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434736; c=relaxed/simple;
	bh=vpvkcugCFPhcHdxAnkd9+SNSFV+rYYF+lxiGZOYrXZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkz/Xs2L1R55IlOH4oCo1dUIVnlGX+CoXYYwgi0XXMO1u4GGYRZu85YuS4rCWn3qyIxSpAviRu9DRZuvobEg2hn2G187KF6L/gA1Cj91/DDDgj6abpYErj0/lVgsE4BMdA/whMmuB51yrZkc+Y4GQqiLq1uoWsot1aCKy8+Ces0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+JEHZX/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6fdd947967so539931466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719434733; x=1720039533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PM40bjTPz1dqcC17Wbu3ggrPNq45RxrBUEE+94YRk58=;
        b=B+JEHZX/4w0ps9BlMxwstcuK1l2w14DgnOEyRsbWl38U37WT5fb+zt+E4f492zyFP5
         UISskJFrFsZAXzrbfMBcZp8ys6YDiRnFM6q6p9T85zqYTjRs6ckltTC+J+xmwY0VJKQT
         rNMtIMEzhOqK3MiQOOqF312srxqSN9piDTVs5SExPk+O4wR/OSXf/LCv8/WRHifdA0n3
         MXcvE+4XYu0lLdC2HffUOqIdBqQVgLnWLG7WK/jCS4l6uvT/AS0QuNBakvSZN0uOz+Kc
         xYSxlEywcISa3Z8Sr8cF4E5xV0iW0kOeZ2mvxxdazaiU86ijVktaFaqAP/atxNPDykxc
         4Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434733; x=1720039533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PM40bjTPz1dqcC17Wbu3ggrPNq45RxrBUEE+94YRk58=;
        b=wpBBi3Rbxqp9f8oTnJIDk6l4ql0SI/X707XKO/stkVqu9TMaxIKubne/b9o9ZiicNK
         Q21LjTvqZPPhTTp1JCkOpNSTy8qjsOofGifUiQ+HMQC7x3ITBfLVXDQQdXUP/LSucG/I
         rT71bNpGVJpgDCe5406xewJwbrsU9PW9qIDXOSG4OJDauF7p27246LW+vpU+EPeQ+/F3
         SNjNY04phGSxkXEeIUYnWZ1hFpZlIntMc9PaZGpYXxYulyApfvM8o4bm3HmPpYeA8LzN
         laWU6tnl5n65PjGNxcXb5gRQwRsvHJys9yvo4W3Qg5F8TMBVTZiSByTdXesOz2R/C8Kb
         6JGg==
X-Forwarded-Encrypted: i=1; AJvYcCUWis9M93VvDU7pU3EYbs4LFpSDgDa5OxO+2Kcj0wXfuEkgU8E727y++ScFoRXBYp6anHiDkrEt3xiiLMEUTWg/YI4AyW7BlZx1qFE4
X-Gm-Message-State: AOJu0Yz18tfwkugfZkLbwy7OYGzoGMIrWtCjd9k+MMQ/+KvnPNDHkMSE
	MWSFXmN1X9RFPoHz1rSynSKMAbiyzaB6MvyeZobVvvhU7CZl7PDonPwcFBYnmuz/BiH42jynn9s
	o9e/npKXdC8XvQt9F+4KZ03jpyf4=
X-Google-Smtp-Source: AGHT+IFIRD6vR6RZbUSKa+Iu6mFYmGbrivykjIXvuUN7o+SZbuCk++mtJV0gWcJhINPw5bth5v4hzGNitCpERXZOcuc=
X-Received: by 2002:a17:907:6d25:b0:a6f:ab9c:7779 with SMTP id
 a640c23a62f3a-a7245b8507fmr1256206766b.9.1719434732571; Wed, 26 Jun 2024
 13:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625233717.2769975-1-yang@os.amperecomputing.com> <20240626134040.63fe621bff6a5fe1c0503999@linux-foundation.org>
In-Reply-To: <20240626134040.63fe621bff6a5fe1c0503999@linux-foundation.org>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 26 Jun 2024 13:45:20 -0700
Message-ID: <CAHbLzkqLnYEXb5D=PZy8wN4YeVTmq8u94YP7Lc=rPPc+p0Nc7g@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: add MTE support
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, muchun.song@linux.dev, 
	catalin.marinas@arm.com, will@kernel.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 1:40=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 25 Jun 2024 16:37:17 -0700 Yang Shi <yang@os.amperecomputing.com>=
 wrote:
>
> > MTE can be supported on ram based filesystem. It is supported on tmpfs.
> > There is use case to use MTE on hugetlbfs as well, adding MTE support.
> >
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file *file, s=
truct vm_area_struct *vma)
> >        * way when do_mmap unwinds (may be important on powerpc
> >        * and ia64).
> >        */
> > -     vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
> > +     vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
> >       vma->vm_ops =3D &hugetlb_vm_ops;
> >
> >       ret =3D seal_check_write(info->seals, vma);
>
> How thoroughly has this been tested?
>
> Can we expect normal linux-next testing to exercise this, or must
> testers make special arangements to get the coverage?

It requires special arrangements. This needs hardware support and
custom-patched QEMU. We did in-house test on AmpereOne platform with
patched QEMU 8.1.

>

