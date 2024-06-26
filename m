Return-Path: <linux-kernel+bounces-231650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63736919B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDDA2832F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114EC19415F;
	Wed, 26 Jun 2024 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5N5gC0F"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4304194157
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445398; cv=none; b=uZO0esRyZHfpHliqL2QZnImCPT/83Bl9NGgly+Q7tv2R69kysYYX/xoTyqDasvLD+72AwXFHBSkLYogzk0y1H4T1mSk6iuPDyiN8jxlgOzz4LYkr375ASUbLQLWLaz+KypH51CtduqS9Tdcc8/FYzqcdivFsPjHAlgdTFjQK59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445398; c=relaxed/simple;
	bh=EJncupxkDfd3V2ZqfDIuXZEUEeOLbbv1Nuhfap9zGWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWqlgU/+v/KGc7AuX0cakyzB+GvvjNNhhPf42a+eZaJ/oKS/+cJD92u2BrsilokT/LL1bmLswvJ23zdOlqnSxphbjBs+1fGgTuITri7mFapIhfNQkm92dSBaP5KNCfinPEhmPnQr4DvNnHikjV3S+YfvbZqv5oB8QZ4+YcC/K0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5N5gC0F; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d203d4682so1141597a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719445395; x=1720050195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrLP38uOvZfrbnJR7lsc4EL5zjKiJ8Snmz7L5lGjvE4=;
        b=H5N5gC0FBeEm2EzX1uxw4My3nUGisKYBX7y63J8jjUWq+cSRWc9VvaEnwTEkJyLtQt
         7b6nPbe2B0mjp1yDT7t5Fx25kPAeahn+S2DRl1eO5VQkvKPL/cWqRSNwtLiNAqYY+t4i
         pL6jjDdrx30nPlWQbBErw1m2V+8xhqTyJrZq3zam8fsSv6QRTF3j9F2aX4JFH6zrPEpK
         oLceYTlLjQxGlDTB0ynNxf50aUsdZO6YkVP/LVj5tTzFRi1hDmWT/OIOlIALuS9JMZS5
         cBzh7h/my9B8Su8PT7SFq3jR+fef9JILB7yhhkTt1yMndg4ixZx3hJAtQ20wkGynIog7
         3ZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719445395; x=1720050195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrLP38uOvZfrbnJR7lsc4EL5zjKiJ8Snmz7L5lGjvE4=;
        b=YHSM18nqhQkszj4xA/702JEvK2WuVGB3kFkrjoAhdqbnIrz/iG3mL8o+FK2yOiIQVE
         Xq7SpkclQhrJHitDjp0DD5P/odwqO6q9dKSNuUMlN9CbuPlGKp1IOqYyv/cha2aMJzEh
         kVm8wMCq4WhxoszPTw0Wv6zZTKtvbiFJEAYYaJxO75CLPdbJTWiPtzw7LeEjSthFaySL
         1yHSMMLRNEc8zvevAQS76YzL800AwjbI8iCF+GDNN2TkgEYpOOgz5MsdB7GPFAXO+qKx
         bxAoDI79nAPwcBAp+fJIwDR+O98kaxOMwQcgjHSyaVC4LBcrOkPaXljkjZ5nmRl1MD/B
         SlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWURL4FI0IfTuXDBJ4GbTEjo+ASAzcEXeZq25wWtzOC3AOsroSfXC0A1ua3j8HOiuIyvJxMJRqcl+4XpOqkLYUsQNLPNf1VNEzHAoYq
X-Gm-Message-State: AOJu0Yy9LEcsLzwFcjZ3eaU/g7tpk4jR+dzDeA+zx3wGbKISSoGXKbLx
	BMaFLNkLRWbKxDizNgqWCwpYxfxGGyVv8dOFL72dJb1aseXIRhcIAICqa16CxhOIPjNIgYb5pbQ
	TOTsHYSUGfO+vP8e+c3txwgxxJ98=
X-Google-Smtp-Source: AGHT+IEoO7WqInlry20Zl6ArEMNympSdQMtbH9/JkZYyI2m2W8eeey8fYyMjHy8AqYzrWxdunxJmmGE96/pwffNA/Jc=
X-Received: by 2002:a50:ab5c:0:b0:57d:12c3:eca6 with SMTP id
 4fb4d7f45d1cf-57d457943bcmr8363110a12.18.1719445394886; Wed, 26 Jun 2024
 16:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
 <20240626134040.63fe621bff6a5fe1c0503999@linux-foundation.org> <CAHbLzkqLnYEXb5D=PZy8wN4YeVTmq8u94YP7Lc=rPPc+p0Nc7g@mail.gmail.com>
In-Reply-To: <CAHbLzkqLnYEXb5D=PZy8wN4YeVTmq8u94YP7Lc=rPPc+p0Nc7g@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 26 Jun 2024 16:43:02 -0700
Message-ID: <CAHbLzkoDsORjxjO8FNMd+MYWL+vwU+9Y2Ood3eEMNM9uTCAeRQ@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: add MTE support
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, muchun.song@linux.dev, 
	catalin.marinas@arm.com, will@kernel.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 1:45=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Wed, Jun 26, 2024 at 1:40=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Tue, 25 Jun 2024 16:37:17 -0700 Yang Shi <yang@os.amperecomputing.co=
m> wrote:
> >
> > > MTE can be supported on ram based filesystem. It is supported on tmpf=
s.
> > > There is use case to use MTE on hugetlbfs as well, adding MTE support=
.
> > >
> > > --- a/fs/hugetlbfs/inode.c
> > > +++ b/fs/hugetlbfs/inode.c
> > > @@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file *file,=
 struct vm_area_struct *vma)
> > >        * way when do_mmap unwinds (may be important on powerpc
> > >        * and ia64).
> > >        */
> > > -     vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
> > > +     vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
> > >       vma->vm_ops =3D &hugetlb_vm_ops;
> > >
> > >       ret =3D seal_check_write(info->seals, vma);
> >
> > How thoroughly has this been tested?
> >
> > Can we expect normal linux-next testing to exercise this, or must
> > testers make special arangements to get the coverage?
>
> It requires special arrangements. This needs hardware support and
> custom-patched QEMU. We did in-house test on AmpereOne platform with
> patched QEMU 8.1.

To correct, custom-patched QEMU is not required for a minimum test.
But a special test program is definitely needed. We used
custom-patched QEMU to test VM backed by hugetlbfs with MTE enabled.

>
> >

