Return-Path: <linux-kernel+bounces-440065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085429EB832
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B031283710
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC40323ED5C;
	Tue, 10 Dec 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfXmFD4L"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003223ED4F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851583; cv=none; b=gBUm2AaY3WGmy2A1+PcyvXl/b2VXvOez1I6U3+BN2GyfH5VdYKwPxehSU+0V00h/cG/sb1MIl/zp7llHopV/pnU9pJRNQR7i2L8t4RazIujYb7hxp9yr8t0G9CrPuHsd+/+rVQ/3lRLLMci7NK/K0AypGXrxrygZxRzOEJryW7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851583; c=relaxed/simple;
	bh=DpA6KFRqb9+oRRHkWTmXF3+HEm96UVlSKT5sAkSuQFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpz7u8LkAGv4pcV50mh+uaagVpP1JRyQllUitz+PkKchj/xN2eqLmoDayfCYkL6kAqRI4LRyQvAr623eW6wEzjfNxU30N2H4mCiKmj8sHJT/zUGUecQlp/3vrfWImkqX/4jqMm1GKQj557vVF3tJkwIxrTWXaB+DfsQQle7MbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfXmFD4L; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4674c22c4afso331331cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733851580; x=1734456380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDFd+SKOEEjFBffUPwnvhVNjk6zGPKgKf4WnAc+z5zQ=;
        b=FfXmFD4LVf2daIcS93do9Fqff8LTVHHKoTq8Q4rcfJTuSywpJBcRdvfGD7dhr0WlgG
         9thQVZe1ksw1h/3cf1yuprn4R/PRsiiBHMWM6X71nZT9ic+Y2L3J19oCZRK6O9zaSTyD
         KZOAEHNiLgSc7qSRCRikCnVOjbOqOR8y5UABtX9l9O2dnWS9z130rIByU415rvwQEBGR
         zHox6Nl2mAaLGXmG/8bjk5F0Hf9B4btG/+sgS2sO6WEOOHtQQKAmXsoXOiHUAVzmzb/b
         mbN7O15tdzc0cTtU7OwQOL8N1Llf3OkQYumVgFLrOgeV5YQ5c/i0viGJIHWKpY+w0Mp0
         ++mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733851580; x=1734456380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDFd+SKOEEjFBffUPwnvhVNjk6zGPKgKf4WnAc+z5zQ=;
        b=ufLtlkMGDFKEL6cKJ2PGWSxls8a6WHDYDI0noiWmTJBLh+uipIARMR50qADOLIUiwK
         j8h18mInmJotRTKz6rnO7QUgBrXxJOTfhLl6hWiVbIAwKkNadp3OBLRLayRZL3pZcZeO
         nOSrADITnwR3bf4QTMABTa854Mu3vHcsbzBF7CxIMpfPxVMPdu1r5uYz/ydGmTyv1UBr
         TMalZSR+cMz794evgglo+63V1uYF1xTk4+Grdc8Tpfc6XEXGi0U41fyLSsMEq1sUKSW6
         7O8piG6BKC2WfwJl2vnBFjiwDuun1M5O83XlU1cuVAIKjOBuIzq+xm0Mho0P5tFjVaCG
         z1dA==
X-Forwarded-Encrypted: i=1; AJvYcCWfmfbJVAOPHg8cPpeg9sqVkJG7S6TZKNRBnKDN+3GY2t9jF0GtqV3lydGlkR383AXCZuzdKLAPgg+iodM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUF+Lj910iUb6X44gnA6bojPn0kkg41GFCbR8G9akp8vNPA1/
	khFt1DBsHNsvTQmzDqOwVdfkOXDh3npUuOfe8fPt0w3r4txq06OP19NGGFohZ2xZnclhyHuPupP
	TWGgq2ADIlls1hYNDamm42dGncwK/Mwo3c0CM
X-Gm-Gg: ASbGncsFTTJBg1weAiCIyrldmJq8dsV6DNpXZMa6sC0QdSWeOBrhVLqoh5R2sETkqq6
	yQ6YJx6Xdkh6cND4VPxiUjZnsFzacsAiRWYcW2U0PZEhQIEbY6cOK/z56jeknMlXGGQ==
X-Google-Smtp-Source: AGHT+IGSq/oebMbcl+OhSt16mXBd8VuLF56kIMX/0n4mh7bazuq1+sPTKqIR5Brp1d62OU0GLLIaYhi17cupGVph2Vg=
X-Received: by 2002:a05:622a:5186:b0:466:8a29:9de7 with SMTP id
 d75a77b69052e-46776158637mr5558991cf.12.1733851578862; Tue, 10 Dec 2024
 09:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202412082208.db1fb2c9-lkp@intel.com> <CAJuCfpGeKgOgqq69OD-TMoQLhyy+HuTKK=cQPHMY2DgNcJf5Xg@mail.gmail.com>
 <Z1Z5FbBHojF6ywfA@xsang-OptiPlex-9020> <CAJuCfpGqauvtrVVqrf8ge7ba=AB3Jk7daRDdqYzOSxpB462i0w@mail.gmail.com>
 <Z1fwMatrJCZdoEDu@xsang-OptiPlex-9020>
In-Reply-To: <Z1fwMatrJCZdoEDu@xsang-OptiPlex-9020>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 10 Dec 2024 09:26:07 -0800
Message-ID: <CAJuCfpHsPNXFww9jNTHHKFHk_0Fq3UfmDqSEB+1-N-BmrJvo-g@mail.gmail.com>
Subject: Re: [akpm-mm:mm-unstable] [mm] 85ad413389: BUG:kernel_NULL_pointer_dereference,address
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@redhat.com>, David Howells <dhowells@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Hillf Danton <hdanton@sina.com>, Hugh Dickins <hughd@google.com>, 
	Jann Horn <jannh@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, 
	Minchan Kim <minchan@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Xu <peterx@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Sourav Panda <souravpanda@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:39=E2=80=AFPM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
> hi, Suren,
>
> On Mon, Dec 09, 2024 at 02:20:07PM -0800, Suren Baghdasaryan wrote:
> > On Sun, Dec 8, 2024 at 8:59=E2=80=AFPM Oliver Sang <oliver.sang@intel.c=
om> wrote:
> > >
> > > hi, Suren Baghdasaryan,
> > >
> > > On Sun, Dec 08, 2024 at 06:09:05PM -0800, Suren Baghdasaryan wrote:
> > > > On Sun, Dec 8, 2024 at 7:26=E2=80=AFAM kernel test robot <oliver.sa=
ng@intel.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > Hello,
> > > > >
> > > > > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,ad=
dress" on:
> > > > >
> > > > > commit: 85ad413389aec04cfaaba043caa8128b76c6e491 ("mm: make vma c=
ache SLAB_TYPESAFE_BY_RCU")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-unsta=
ble
> > > > >
> > > > > in testcase: boot
> > > > >
> > > > > config: i386-randconfig-141-20241208
> > > > > compiler: gcc-11
> > > > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -sm=
p 2 -m 16G
> > > > >
> > > > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > > >
> > > > >
> > > > > +------------------------------------------------+------------+--=
----------+
> > > > > |                                                | 98d5eefb97 | 8=
5ad413389 |
> > > > > +------------------------------------------------+------------+--=
----------+
> > > > > | BUG:kernel_NULL_pointer_dereference,address    | 0          | 1=
2         |
> > > > > | Oops                                           | 0          | 1=
2         |
> > > > > | EIP:lock_anon_vma_root                         | 0          | 1=
2         |
> > > > > | Kernel_panic-not_syncing:Fatal_exception       | 0          | 1=
2         |
> > > > > +------------------------------------------------+------------+--=
----------+
> > > > >
> > > > >
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a =
new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-lkp/202412082208.db1fb2c9-lk=
p@intel.com
> > > >
> > > > Thanks for the report!
> > > > It looks like anon_vma passed to lock_anon_vma_root() is NULL but i=
t's
> > > > not obvious to me why my patch would cause that.
> > > >
> > > > Oliver, how can I reproduce this locally?
> > > >
> > >
> > > To reproduce:
> > >
> > >         # build kernel
> > >         cd linux
> > >         cp config-6.13.0-rc1-00162-g85ad413389ae .config
> > >         make -j$(nproc) HOSTCC=3Dgcc-11 CC=3Dgcc-11 ARCH=3Di386 oldde=
fconfig prepare modules_prepare bzImage modules
> > >         make -j$(nproc) HOSTCC=3Dgcc-11 CC=3Dgcc-11 ARCH=3Di386 INSTA=
LL_MOD_PATH=3D<mod-install-dir> modules_install
> > >         cd <mod-install-dir>
> > >         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> > >
> > >
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-scr=
ipt is attached in this email
> > >
> > >         # if come across any failure that blocks the test,
> > >         # please remove ~/.lkp and /lkp dir to run from a clean state=
.
> > >
> > >
> > > config and job-script files are attached in original report.
> > >
> > > one thing we want to mention is this seems only reproducible with i38=
6 config in
> > > our tests.
> >
> > Thanks Oliver!
> > I think I found the issue and
> > https://lore.kernel.org/all/20241209221028.1644210-1-surenb@google.com/
> > should fix it. Could you please try it out?
>
> we confirmed the patch fixed the issue we reported. thanks!
>
> Tested-by: kernel test robot <oliver.sang@intel.com>

Thanks!

