Return-Path: <linux-kernel+bounces-551179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEF4A56909
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E261892DC4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13FA156F5D;
	Fri,  7 Mar 2025 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5xzDU9w"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72A219A7C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354514; cv=none; b=WN58EwvB+5dMqMfw3QLORO6W87QpCaFUUiZfqGi6YUgcPgmd7vVJI00ec29U8aJpucbZiydkuteVhEfrsWialgNobE6tj7kuNnS4c8DPiJpnZ52LKgL+ATxbQjsHTSqcXfe69G2SGo/cBoQ8Ol3VGYKL8vbdSPtjAv1FXksXsX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354514; c=relaxed/simple;
	bh=SVUvp1VUhO0T7cnKhzmgGHpCA5GeboYehs9qeUr7jtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDHEo2jy/t671TNmYFPgN5VUN406Pmd3MO1DuqetZqGrduBmZTQIUeOtoND1TO6Yziy8ng+Ezw76CRl71RJn2AcD8cgykmP6MoJwUO2/ELAJITHULlZQ4vTOgP9PPyfCdSNZE2PBm1ex2tt1wXdSXMb0YNIOWq0WiSQx18vCgiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5xzDU9w; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86b0899ad8bso717770241.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741354511; x=1741959311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d+R6+9QRbHOe69NMdbDCrWyNRLbx9LvgB+dGXyclrw=;
        b=L5xzDU9wbzxsNB+X/Fvh0tHVj4SHN1Uix1nwPWpP3VXllzy1EugPFW8/CTNpX5Oje6
         DgLLOhPN2qa92qgV7a7bvNkMSZrqP1HzfLC3e6kPv/C40V0FT40bY+ECaM6DSvZA+JRa
         WrHPakm3SXlDpAU33LfaHgGt7m6sIf1UCZkqQS82LIVdliNjMvkvx+GCsJWcCthaAtQj
         qBqWmoFCS+rDXWXMGO39nW1qr7rrUVkaAc/2pbLYTzu0UYrM6fT9CokA19rPhBg9bT8q
         3Vp/idrPkey1wWcCO0RU7mwOw7A69cbLbJHfJs3x3OY/PQQOePD3+Unf17xkuuRe6XSP
         UWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354511; x=1741959311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7d+R6+9QRbHOe69NMdbDCrWyNRLbx9LvgB+dGXyclrw=;
        b=rdVuErXtnbCGdwgqvgq/Uq52nTlXSIoataAhI2p5ZZFX0nMjZFooXhq0LKTuk28ePT
         HkTgDzYZzuPHMaaIWgeHBHK2KKtixuBwYEWqtPB3D2etMtasmHihVJpfhXcg3cDQcs3W
         3smmnVarX8jR1Bj/IGyS/tKOtqxdJRZFjrO6NVAx2lIWQmFmn4sTTlscq5Fsw+4IS1vF
         chKXe85CIQpTJhpUSBTPMQZl5yOipN1XTzW0rFA/8Dvx6BjLG+cDnSy9FA6WztPge8S0
         MW+wIR2LykenvqwAdRJ6SESIS67bScOJlBfM8rRDE8PN7OmOXgsEkc0gzYW8O26Jw1Go
         5Fng==
X-Forwarded-Encrypted: i=1; AJvYcCX5N18zBJpnpxk7PjtorgB7SvD4kyqChgTBuw1QC7lPT3/1gXIUDsEq/TEIFr3wR01QZU3rBRHf8uIF0lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzawKqaP5hkawX3l2VLp40Zvrs9oKK9YIyUDwR1esQswRv5QK5X
	lwR7az7muhLxdBO8brUAd2m1CVMxwFgoRkPZaaIQDqb1m8kr0XXTevh9Bg3guP8zopce7n1lqz7
	b3S1/LPnuW1WYETY6DnMkDQTltKY=
X-Gm-Gg: ASbGncujwAizHjEvYuvDucjwaJDDGUL4X319WZLkyf3jrOAQgb4lR3N2o/D/2rGKIEa
	RIk7MlRxgHMf7a0C1++94qSOsLM10Sl9w9e1LrNw3pCSZrOKPmKzzdRaUlm8kXHTibogrEAKwMq
	b9TS+Hf1yShdDYyX4JyprxZixCKAZhVGC0UDxky8PDbIAZpKkWZeZpgqfpRA==
X-Google-Smtp-Source: AGHT+IEkZO8dAQmykN6hNMMyQP1GXA46jfVdXAgpT6xAUKZnPvfks06dX+OWRJ7CBhP0PhWT+OLQRoeCII1pXtLbc1g=
X-Received: by 2002:a05:6102:cd3:b0:4c1:9780:3830 with SMTP id
 ada2fe7eead31-4c30a733b18mr1768213137.23.1741354511217; Fri, 07 Mar 2025
 05:35:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306214948.2939043-1-yang@os.amperecomputing.com> <6f3cece7-4dc6-471c-978c-efcf4bbe64ce@lucifer.local>
In-Reply-To: <6f3cece7-4dc6-471c-978c-efcf4bbe64ce@lucifer.local>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 7 Mar 2025 13:35:00 +0000
X-Gm-Features: AQ5f1JrW5M0MlO1Hs8HBHVa-tCdbr7o0box7gQiKi-i5Rvl74Y-7M6jz0SmBrCY
Message-ID: <CAKbZUD3Gk8Qb4zznpCszXHzfAO82=rkTOb0_z6yVU0CXWAMoSA@mail.gmail.com>
Subject: Re: [PATCH] mm: vma: skip anonymous vma when inserting vma to file
 rmap tree
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	jannh@google.com, oliver.sang@intel.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 1:12=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Mar 06, 2025 at 01:49:48PM -0800, Yang Shi wrote:
> > LKP reported 800% performance improvement for small-allocs benchmark
> > from vm-scalability [1] with patch ("/dev/zero: make private mapping
> > full anonymous mapping") [2], but the patch was nack'ed since it change=
s
> > the output of smaps somewhat.
>
> Yeah sorry about that, but unfortunately something we really do have to
> think about (among other things, the VMA edge cases are always the source
> of weirdness...)
>
> >
> > The profiling shows one of the major sources of the performance
> > improvement is the less contention to i_mmap_rwsem.
>
> Great work tracking that down! Sorry I lost track of the other thread.
>
> >
> > The small-allocs benchmark creates a lot of 40K size memory maps by
> > mmap'ing private /dev/zero then triggers page fault on the mappings.
> > When creating private mapping for /dev/zero, the anonymous VMA is
> > created, but it has valid vm_file.  Kernel basically assumes anonymous
> > VMAs should have NULL vm_file, for example, mmap inserts VMA to the fil=
e
> > rmap tree if vm_file is not NULL.  So the private /dev/zero mapping
> > will be inserted to the file rmap tree, this resulted in the contention
> > to i_mmap_rwsem.  But it is actually anonymous VMA, so it is pointless
> > to insert it to file rmap tree.
>
> Ughhhh god haha.
>
> >
> > Skip anonymous VMA for this case.  Over 400% performance improvement wa=
s
> > reported [3].
>
> That's insane. Amazing work.
>

Ok, so the real question (to Yang) is: who are these /dev/zero users
that require an insane degree of scalability, and why didn't they
switch to regular MAP_ANONYMOUS? Are they in the room with us?

> >
> > It is not on par with the 800% improvement from the original patch.  It=
 is
> > because page fault handler needs to access some members of struct file
> > if vm_file is not NULL, for example, f_mode and f_mapping.  They are in
> > the same cacheline with file refcount.  When mmap'ing a file the file
> > refcount is inc'ed and dec'ed, this caused bad cache false sharing
> > problem.  The further debug showed checking whether the VMA is anonymou=
s
> > or not can alleviate the problem.  But I'm not sure whether it is the
> > best way to handle it, maybe we should consider shuffle the layout of
> > struct file.
>
> Interesting, I guess you'll take a look at this also?

... And this is probably a non-issue in 99% of !/dev/zero mmaps unless
it's something like libc.so.6 at an insane rate of execs/second.

This seems like a patch in search of a problem and I really don't see
why we should wart up the mmap code otherwise. Not that I have a huge
problem with this patch, which is somewhat simple and obvious.
It'd be great if there was a real workload driving this rather than
useless synthetic benchmarks.

--=20
Pedro

