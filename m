Return-Path: <linux-kernel+bounces-438473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D6C9EA1C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEC3166625
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711B019DF4F;
	Mon,  9 Dec 2024 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nn3s0kYI"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400CD19DF4D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782821; cv=none; b=OVypkxMFpLMvLachFsrXCMDTSDCdB+mrc4FcKWWO2iY4viM4oHgBn69w4jJXJcVxcAWSl8qGhoM/2UmCLmAkZwt2Q0rxFZwem+LUEBCovxeUDvZLXgMEnN8yqnSKtHouB1cYuZUg7d0iHF165MbeBhXP9x6GmKlfVRzOi2K5m6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782821; c=relaxed/simple;
	bh=1CyMiD1T7cKwXyRcB9MbtDMbGuOgfuGFBLkRucfdvnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEPtgoAxxjXk399ip0ah8GanXxyxRkTwREIMQM809cbXusK6oZG/vp9AXjPJHIfl1odTmMRJNa7JYFIPm/G4tCHiPwA7iTA06T2/S6ruYKxGFPOIu4djnkscXy0LnwBUr2ZZSbQ5k3+zTiL2tBBIGzijcgwtP204PsPYtGrSROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nn3s0kYI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4674c22c4afso50041cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 14:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733782819; x=1734387619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5ww+FYyUuj9YZJs8l84tdzGI5HsRlAlNX8jCX6t2Ww=;
        b=Nn3s0kYIkL7OsHwOYb30XSqGGSgLbPn8vS45ip7ZfC1QAErVLL0YGF1USBdaxW5vLE
         vytIp6446smSIXj4o4Xlcq1qWNIbuDHVvvez+Q4CRZX9/1K5fBYxrCpsjoXtqz8T1wlD
         VJo/4Y1uZgBb7PrpPWSscboik//OAurjQCq8xtvwRbStugF1yHN8FUg4i0FTASNhUBz+
         pwilsaNBFindXM+W21x5tzq/Fs1WfG8ZuxCOSpeTYaOKmsHGWkHewYEXwnmsCq7cRi8Y
         n64dV8jAnuiEGunKDypKiIZG1ay+i/mgXutRSgiDVTsEMuPPFmhSHKUje+ObnrvrgJmg
         zZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733782819; x=1734387619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5ww+FYyUuj9YZJs8l84tdzGI5HsRlAlNX8jCX6t2Ww=;
        b=vBOXEO0Wh6/z8qqNplN0b2w2TCPLyAYpk41d1eU2xOjH3uyyhSa9zj8oVTA1rJcX6E
         p7FZ9BgspnFYt80eczLOvhluFeq0E4LFDhrAM44yoEy0b4of2uH8BrckyATwgaFzWn3d
         AhrGBfWcekZ4yRb5t5nPj9kl3ufKZsMeTGr32+Jh5if9LszhQpASQX/mOQejJFJ4Oeq6
         FTlYxj5/Zfo7s/bRLk8O4Q5EZ49jTgMzBncADVgYBP89ZzxUIh9blvHvwdHcl/HzkqMQ
         LaOi04OfhuFUikQcFyGEIk+QKJNmEquv6f35xqtU2yA0NI6M+m5kuYc0zSNi4WVWVzOa
         tYgA==
X-Forwarded-Encrypted: i=1; AJvYcCVSIUZFr4LA7os2C3EERqcq6NkuO1teSBfXzVycqdxew7TFS8aYQipa+mvWFWwWaZiiTv8qnjn2Sa0n1pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSO5/fGBO0n/eZ2Baun628dOcColx9ANTlDWJPit8oUe+OKqTM
	vXHRaXRIM16ko3TKPJyXo1xax55z1Ns7s4FDC5xjvllpkVYkbjBtpQU8Mj6U5aiZm0Q/8twYhBm
	LevQzujRE2Tik6o+PtU+XFSRpY2Onoh/H9/eK
X-Gm-Gg: ASbGncubqp+em2sEnx7Ws2pPdHZlJIP1gLbmqXj7N1K01lSw6OLTvtHHe2snK3CqOFg
	OVsZ1DK3ZLtOBnMo6/A6tbLeqaBXGkW9Onuc=
X-Google-Smtp-Source: AGHT+IH78nTZ9DcmfapbaIU0Acq1Wlfjtc8axM0AHL8eeXBJQHPQKkL1IIhm/4+T2pbRn6gYSgwQZH6j6Df8/mVUYBA=
X-Received: by 2002:a05:622a:550a:b0:466:861a:f633 with SMTP id
 d75a77b69052e-4677757cac6mr198391cf.5.1733782817959; Mon, 09 Dec 2024
 14:20:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202412082208.db1fb2c9-lkp@intel.com> <CAJuCfpGeKgOgqq69OD-TMoQLhyy+HuTKK=cQPHMY2DgNcJf5Xg@mail.gmail.com>
 <Z1Z5FbBHojF6ywfA@xsang-OptiPlex-9020>
In-Reply-To: <Z1Z5FbBHojF6ywfA@xsang-OptiPlex-9020>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 9 Dec 2024 14:20:07 -0800
Message-ID: <CAJuCfpGqauvtrVVqrf8ge7ba=AB3Jk7daRDdqYzOSxpB462i0w@mail.gmail.com>
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

On Sun, Dec 8, 2024 at 8:59=E2=80=AFPM Oliver Sang <oliver.sang@intel.com> =
wrote:
>
> hi, Suren Baghdasaryan,
>
> On Sun, Dec 08, 2024 at 06:09:05PM -0800, Suren Baghdasaryan wrote:
> > On Sun, Dec 8, 2024 at 7:26=E2=80=AFAM kernel test robot <oliver.sang@i=
ntel.com> wrote:
> > >
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,addres=
s" on:
> > >
> > > commit: 85ad413389aec04cfaaba043caa8128b76c6e491 ("mm: make vma cache=
 SLAB_TYPESAFE_BY_RCU")
> > > https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-unstable
> > >
> > > in testcase: boot
> > >
> > > config: i386-randconfig-141-20241208
> > > compiler: gcc-11
> > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 =
-m 16G
> > >
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > >
> > >
> > > +------------------------------------------------+------------+------=
------+
> > > |                                                | 98d5eefb97 | 85ad4=
13389 |
> > > +------------------------------------------------+------------+------=
------+
> > > | BUG:kernel_NULL_pointer_dereference,address    | 0          | 12   =
      |
> > > | Oops                                           | 0          | 12   =
      |
> > > | EIP:lock_anon_vma_root                         | 0          | 12   =
      |
> > > | Kernel_panic-not_syncing:Fatal_exception       | 0          | 12   =
      |
> > > +------------------------------------------------+------------+------=
------+
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202412082208.db1fb2c9-lkp@in=
tel.com
> >
> > Thanks for the report!
> > It looks like anon_vma passed to lock_anon_vma_root() is NULL but it's
> > not obvious to me why my patch would cause that.
> >
> > Oliver, how can I reproduce this locally?
> >
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-6.13.0-rc1-00162-g85ad413389ae .config
>         make -j$(nproc) HOSTCC=3Dgcc-11 CC=3Dgcc-11 ARCH=3Di386 olddefcon=
fig prepare modules_prepare bzImage modules
>         make -j$(nproc) HOSTCC=3Dgcc-11 CC=3Dgcc-11 ARCH=3Di386 INSTALL_M=
OD_PATH=3D<mod-install-dir> modules_install
>         cd <mod-install-dir>
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script =
is attached in this email
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
> config and job-script files are attached in original report.
>
> one thing we want to mention is this seems only reproducible with i386 co=
nfig in
> our tests.

Thanks Oliver!
I think I found the issue and
https://lore.kernel.org/all/20241209221028.1644210-1-surenb@google.com/
should fix it. Could you please try it out?

