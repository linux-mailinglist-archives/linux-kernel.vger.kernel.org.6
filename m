Return-Path: <linux-kernel+bounces-436111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608CD9E813E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45901166722
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49E11494AD;
	Sat,  7 Dec 2024 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1EbPgKt2"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9BE1E885
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733592850; cv=none; b=q8PsWWh15kitWXIgPO3vL1aAhhteVHpQA/e23RXWC4BZiP4rHEWlfJXsiwAgqMu0b1rZ3Zg7XjlmwlGAY4MiWs3jEgAT1mr3okuepLUF/NyZ8sDBVJf0qtltbKIAsSciyxsyNbJKzX25rC5QSj8O+zfpINbeL2mCoPU1DQV64ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733592850; c=relaxed/simple;
	bh=Rpf8E5FXJkeGiG6tZpqF9Ks5ZX9sIxkc3b0iY5CmVKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQVJZfzfWqBP8qV1YSKyrBGFuvaoRtPwzcIfphQnarvAwBh3t4r2oMbZKBt/subulsEcfb4L5lsECQlDol1EeXL1ke9tDiGw17OUu6kXUC6CH+fksU76nGJlOOTIlCS9lFZR9fY973w4+/Aom3AHPbxy7QQZ6N7QLSkNPXeMLm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1EbPgKt2; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4674a47b7e4so149271cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 09:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733592847; x=1734197647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UU3FQ4ZkY7U9wnJO4OcRHOUU8vnahLn5gnv1cleLmoM=;
        b=1EbPgKt2j7b84X7tFFN7DV1k0ieRj6DchRYFGNLtDgT6ZbTLyUJwXQJMFaid6Dtynu
         MuSh9ttd4EFyyYfnUtcimV1SoB3hmi5cKtziNUhONT16lFx8b9mf/9E4uEXWCLxMrS6p
         5QFsVp8Ys1HFVI+Umic0a64ib5EzZ9Esxiom7w4tibBPCtYICZUbsYIHJPvpNmReXX9v
         b3SKeccTbOsIcOCGyFBLlvpuzJ7y8FapX7iHldGG6e5snlY7N3wPrKMlBUBoOQPI4GZT
         aSSjr6F4Vg7ohBV1P8AcoliG+8vK/o0UKSdEI7RfcVT+Iml0G7Cnwejnw/gg0oKBnwXp
         zarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733592847; x=1734197647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UU3FQ4ZkY7U9wnJO4OcRHOUU8vnahLn5gnv1cleLmoM=;
        b=mDky2D5adJrnEoU2IaYS93quzeyv0vmvHHRR2ymTTETMYR/aeMZoMAPRYm/62j6Tbz
         0StDD9DQS2dabKk63kZZsCnXydQ3daEDuN4knMs0jgA6YTLMHIjOEVWw7ijPGlVHqcBg
         c5oEXWnVL75MgKWR+nr6lOhpzDM0Sfs6aVBO3nEkCL7G+4hSvsDrBeaAMI14v0MiGV/7
         pcnFmZ68qdgao2EOEyLtG0PZYPbHfZlJr0DDSEaEJPd1Jq9TSa9dBdFTmQlqS99wr6fq
         DtpqGIjZrIwxSIMyD7E+EnkICjQRyUvBu/yb0zL7gXyMShQo2AlMTVjrPeVJsWG4ZHcP
         N4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAk8+IesE9z0f/IzyLRiTBLCHYyed+KOROzM5Ey7a6XX1Jvg6J2EHgbTXzfoYOwZufCWv6CDBIzdpmdoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxwdSaqstpJXHJlsJgHoi4vnjoqenDjYrCUfo+LS5i+/aVDmJ
	MvieDrfCu4n8zUSN5SlQuouHU11EOQ6Bd0diqdDGDHbaolzE0cIej3EBB46VMOW5pareGbzUQ4h
	fFpaUJaJYQm3hr1kx2zDLE+XT6seIRdp7a0gb
X-Gm-Gg: ASbGncu2JV/JuBt+EmBOJfoOcz5OaNwIbOoemRLTpDNR08CrMaNbEckGXsuW+hEXYiD
	oaAEoq175isxyu6QOLvqNGQ+iqfkgDts=
X-Google-Smtp-Source: AGHT+IF3WJ8kN8Ix9U0Qnr/PX5i4gdPvUR5eenqNxqgXSzETlC2SUkrWRpzKenUtPrjZAw3s3C92n+OXtqfTezUq44Y=
X-Received: by 2002:a05:622a:909:b0:466:91fd:74c4 with SMTP id
 d75a77b69052e-46746d6677emr3351631cf.0.1733592847299; Sat, 07 Dec 2024
 09:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9baeaab7-61d8-4121-8aa5-cf1c129daa40@infradead.org> <c7cee2d4-5bbd-4867-ac12-a0a2f73f6c44@gmail.com>
In-Reply-To: <c7cee2d4-5bbd-4867-ac12-a0a2f73f6c44@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 7 Dec 2024 09:33:56 -0800
Message-ID: <CAJuCfpFgZUG28md9K=WZjUFoihOUSd4aBSuW-4V6JNdQS_8c9w@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] docs/mm: document latest changes to vm_lock
To: Akira Yokosawa <akiyks@gmail.com>, lorenzo.stoakes@oracle.com
Cc: rdunlap@infradead.org, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, dave@stgolabs.net, david@redhat.com, dhowells@redhat.com, 
	hannes@cmpxchg.org, hdanton@sina.com, hughd@google.com, jannh@google.com, 
	kernel-team@android.com, liam.howlett@oracle.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@techsingularity.net, 
	mhocko@suse.com, minchan@google.com, mjguzik@gmail.com, oleg@redhat.com, 
	oliver.sang@intel.com, pasha.tatashin@soleen.com, paulmck@kernel.org, 
	peterx@redhat.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	vbabka@suse.cz, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:24=E2=80=AFPM Akira Yokosawa <akiyks@gmail.com> wr=
ote:
>
> On Fri, 6 Dec 2024 19:23:59 -0800, Randy Dunlap wrote:
> > Hi,
> >
> > Can someone explain what the (consistent) usage of '!' does in this fil=
e?
> > This is the only file in Documentation/ that uses this syntax.
> >
> >
> > E.g.:
> >
> >> diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/pro=
cess_addrs.rst
> >> index 81417fa2ed20..92cf497a9e3c 100644
> >> --- a/Documentation/mm/process_addrs.rst
> >> +++ b/Documentation/mm/process_addrs.rst
> >> @@ -716,7 +716,11 @@ calls :c:func:`!rcu_read_lock` to ensure that the=
 VMA is looked up in an RCU
> >>  critical section, then attempts to VMA lock it via :c:func:`!vma_star=
t_read`,
> >>  before releasing the RCU lock via :c:func:`!rcu_read_unlock`.
> >>
> >> -VMA read locks hold the read lock on the :c:member:`!vma->vm_lock` se=
maphore for
> >> +In cases when the user already holds mmap read lock, :c:func:`!vma_st=
art_read_locked`
> >> +and :c:func:`!vma_start_read_locked_nested` can be used. These functi=
ons always
> >> +succeed in acquiring VMA read lock.
> >
>
> Quoting from https://www.sphinx-doc.org/en/master/usage/referencing.html#=
syntax
>
>   * Suppressed link: Prefixing with an exclamation mark (!) prevents the
>     creation of a link but otherwise keeps the visual output of the role.
>
>     For example, writing :py:func:`!target` displays target(), with no li=
nk
>     generated.
>
>     This is helpful for cases in which the link target does not exist; e.=
g.
>     changelog entries that describe removed functionality, or third-party
>     libraries that don=E2=80=99t support intersphinx. Suppressing the lin=
k prevents
>     warnings in nitpicky mode.
>
> But in kernel documentation, there is a preferred alternative.
> Referencing by function names is the way to go.  For example:
>
>   calls rcu_read_lock() to ensure that the VMA is looked up in an RCU
>   critical section, then attempts to VMA lock it via vma_start_read(),
>   before releasing the RCU lock via rcu_read_unlock().
>
>   In cases when the user already holds mmap read lock, vma_start_read_loc=
ked()
>   and vma_start_read_locked_nested() can be used. These functions always
>   succeed in acquiring VMA read lock.
>
> They work regardless of link target's existence.
> Kernel-specific Sphinx extension named "automarkup" does conversions
> for you.

Thanks for the information. I was simply following the same style the
document was written in. Sounds like converting it to the preferred
alternative in a separate patch would be best. Lorenzo, WDYT?

>
> HTH, Akira
>
> > thanks.
> > --
> > ~Randy
>

