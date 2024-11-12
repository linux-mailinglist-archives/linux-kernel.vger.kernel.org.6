Return-Path: <linux-kernel+bounces-404994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8BC9C4B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A264BB2596C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19D2038C3;
	Tue, 12 Nov 2024 01:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNFPx+xQ"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC02AF06
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373509; cv=none; b=arW++sG1nybuw1DmOSnK9SkI35ZUP5M/PCYwduVXy6Bz49I/9OJnVQ60lAkWZCN9QyfqIxtCXC2pe4EpefXg1pBsWLGIlF4AdPQm3FHoFXrbbFsiqczfQiJ98hifxkKurk9GpE6cN9K2QH4hJW5GjVLeMsKTubNcitlf9bFIf8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373509; c=relaxed/simple;
	bh=tMZN9E2RFqdMlFIH69pyDtKNP+t+H6ghc5KgCb9xAWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gy0X48DaxOdGcPXi0B0YJEHhGCeIVK51CNLKZP/sQLYyS5khUKJHJMN3MSackG3a5foy2ypTVOarVYP4b05QMaCXgRIlYYsGFf4QBTnwzk4qlF6UrakEmSpS9OB0Uic7UQofIepKdc2EJgEkyCGhS8nGHTIEtQgUNI4VlM36UK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNFPx+xQ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460969c49f2so119551cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731373505; x=1731978305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkdTVDim1ZzBmzlpVVSDkcbtyV/TYvAbmr4nsEJFTmI=;
        b=dNFPx+xQLlISflt5D8kYEN+irJF5TvihyOXgsLYIpECeZCKWuOg1TW4tZbjRUWEm5V
         ilUV+Wmko6YYI5l5htu16d9JJBewSMUP94WOeTzIBB5yJemzVeqZGbP8tul7sqMj+xDq
         pqN7BfL6tYBD64EKs7H1lUGi7uj8MAdUZFx7b+EaBupmEz2S3KbAzdDZuT8ZeKKPlQM2
         2ZNCBcJoHgnUZsJfcOA0VJLsb6CuUyEVgmz4B+rIYwKQMPn8zBoGeH32T4lLJ/dz0RFQ
         ZX5ccl00mInaS6x6XABECH4XOESyxepBUXT+lFYPTlTMYSbhg7VW3w3NVRWo2wg/roJz
         c98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731373505; x=1731978305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkdTVDim1ZzBmzlpVVSDkcbtyV/TYvAbmr4nsEJFTmI=;
        b=hBOHEqTuraxV94Z3tmPeAHQornCm7GNWUOB3wBkmMO8d/kDZEVmtbvaM7Fvsak9lBD
         RdY47G7npHyzxT7UMPza2/ZrtDgTe6BWP8txwDQx3XCQEtNN9vE7VRvFvvuVo+a/09Ji
         zSEuIE0rPQfM9opN2rAKbdmUri7Ir9O8X0nc3Vt5D+qtLyopr8SOgsdGEPOihU8nQfO5
         Qux8g1vbuuFCd587FDXrtPysk5b7d6iFy8nU6JdS0mP4zcTCHPOrh7vjXEuhPiikPECQ
         o4Jf6m4aGj/ekk5ZAniI85NIvuUX3VXCQsjxLrjVmyAxBJH9GKr3M278dMiFs3U3hVOm
         h/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXrAO1oO5HNWEINMHgqXnHaKeW+leuuEbn3WFCIEp56WCheDldGRqlCfnIpIg79+WUk3lfcHlMNtViIGXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhh5vBs5M0GcWE1r8Z48e6sbsjXFr6/HOpqHQayJLkS3wKHkIG
	UXV9Hoefq/Eyb3DVdqsjRcbAtmabT7bipPBLZfKEPhtnz5FlUZSJoMWuqHvM9D5JVCiDLYtEEx5
	jD3vEomhrZ/fJxfdM3j8LxlSwQ2eGlwcQmUVN
X-Gm-Gg: ASbGncscakktOiuwK8rDSPqiTV5gu0/ThyCda/yTBdWK5cHBvFXY5UOBXEWxGssS1M3
	KbMj/hp+zPV8k/A3IQyxHl1hv4oFqjpg=
X-Google-Smtp-Source: AGHT+IFa81CijRE1MeCWud//eJQAC53OwMrr0PPUNOh3z+iinXXS0t7yiFi2lRvjks5Sh8V99+c/YY6jyEmTZnx2kQE=
X-Received: by 2002:a05:622a:2c3:b0:461:67d8:1f50 with SMTP id
 d75a77b69052e-4633ef60960mr1574411cf.4.1731373505181; Mon, 11 Nov 2024
 17:05:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <20241028010818.2487581-5-andrii@kernel.org>
 <20241112092816.cf5b0aa1ef10f50ce872892f@kernel.org>
In-Reply-To: <20241112092816.cf5b0aa1ef10f50ce872892f@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 11 Nov 2024 17:04:54 -0800
Message-ID: <CAJuCfpFPFRWrrMOQL2wbeTS0Y7eTc81TV3MX0cHaCuQ85foiag@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 4/4] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, peterz@infradead.org, 
	oleg@redhat.com, rostedt@goodmis.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:28=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Sun, 27 Oct 2024 18:08:18 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > Given filp_cachep is marked SLAB_TYPESAFE_BY_RCU (and FMODE_BACKING
> > files, a special case, now goes through RCU-delated freeing), we can
> > safely access vma->vm_file->f_inode field locklessly under just
> > rcu_read_lock() protection, which enables looking up uprobe from
> > uprobes_tree completely locklessly and speculatively without the need t=
o
> > acquire mmap_lock for reads. In most cases, anyway, assuming that there
> > are no parallel mm and/or VMA modifications. The underlying struct
> > file's memory won't go away from under us (even if struct file can be
> > reused in the meantime).
> >
> > We rely on newly added mmap_lock_speculation_{begin,end}() helpers to
> > validate that mm_struct stays intact for entire duration of this
> > speculation. If not, we fall back to mmap_lock-protected lookup.
> > The speculative logic is written in such a way that it will safely
> > handle any garbage values that might be read from vma or file structs.
> >
> > Benchmarking results speak for themselves.
> >
> > BEFORE (latest tip/perf/core)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > uprobe-nop            ( 1 cpus):    3.384 =C2=B1 0.004M/s  (  3.384M/s/=
cpu)
> > uprobe-nop            ( 2 cpus):    5.456 =C2=B1 0.005M/s  (  2.728M/s/=
cpu)
> > uprobe-nop            ( 3 cpus):    7.863 =C2=B1 0.015M/s  (  2.621M/s/=
cpu)
> > uprobe-nop            ( 4 cpus):    9.442 =C2=B1 0.008M/s  (  2.360M/s/=
cpu)
> > uprobe-nop            ( 5 cpus):   11.036 =C2=B1 0.013M/s  (  2.207M/s/=
cpu)
> > uprobe-nop            ( 6 cpus):   10.884 =C2=B1 0.019M/s  (  1.814M/s/=
cpu)
> > uprobe-nop            ( 7 cpus):    7.897 =C2=B1 0.145M/s  (  1.128M/s/=
cpu)
> > uprobe-nop            ( 8 cpus):   10.021 =C2=B1 0.128M/s  (  1.253M/s/=
cpu)
> > uprobe-nop            (10 cpus):    9.932 =C2=B1 0.170M/s  (  0.993M/s/=
cpu)
> > uprobe-nop            (12 cpus):    8.369 =C2=B1 0.056M/s  (  0.697M/s/=
cpu)
> > uprobe-nop            (14 cpus):    8.678 =C2=B1 0.017M/s  (  0.620M/s/=
cpu)
> > uprobe-nop            (16 cpus):    7.392 =C2=B1 0.003M/s  (  0.462M/s/=
cpu)
> > uprobe-nop            (24 cpus):    5.326 =C2=B1 0.178M/s  (  0.222M/s/=
cpu)
> > uprobe-nop            (32 cpus):    5.426 =C2=B1 0.059M/s  (  0.170M/s/=
cpu)
> > uprobe-nop            (40 cpus):    5.262 =C2=B1 0.070M/s  (  0.132M/s/=
cpu)
> > uprobe-nop            (48 cpus):    6.121 =C2=B1 0.010M/s  (  0.128M/s/=
cpu)
> > uprobe-nop            (56 cpus):    6.252 =C2=B1 0.035M/s  (  0.112M/s/=
cpu)
> > uprobe-nop            (64 cpus):    7.644 =C2=B1 0.023M/s  (  0.119M/s/=
cpu)
> > uprobe-nop            (72 cpus):    7.781 =C2=B1 0.001M/s  (  0.108M/s/=
cpu)
> > uprobe-nop            (80 cpus):    8.992 =C2=B1 0.048M/s  (  0.112M/s/=
cpu)
> >
> > AFTER
> > =3D=3D=3D=3D=3D
> > uprobe-nop            ( 1 cpus):    3.534 =C2=B1 0.033M/s  (  3.534M/s/=
cpu)
> > uprobe-nop            ( 2 cpus):    6.701 =C2=B1 0.007M/s  (  3.351M/s/=
cpu)
> > uprobe-nop            ( 3 cpus):   10.031 =C2=B1 0.007M/s  (  3.344M/s/=
cpu)
> > uprobe-nop            ( 4 cpus):   13.003 =C2=B1 0.012M/s  (  3.251M/s/=
cpu)
> > uprobe-nop            ( 5 cpus):   16.274 =C2=B1 0.006M/s  (  3.255M/s/=
cpu)
> > uprobe-nop            ( 6 cpus):   19.563 =C2=B1 0.024M/s  (  3.261M/s/=
cpu)
> > uprobe-nop            ( 7 cpus):   22.696 =C2=B1 0.054M/s  (  3.242M/s/=
cpu)
> > uprobe-nop            ( 8 cpus):   24.534 =C2=B1 0.010M/s  (  3.067M/s/=
cpu)
> > uprobe-nop            (10 cpus):   30.475 =C2=B1 0.117M/s  (  3.047M/s/=
cpu)
> > uprobe-nop            (12 cpus):   33.371 =C2=B1 0.017M/s  (  2.781M/s/=
cpu)
> > uprobe-nop            (14 cpus):   38.864 =C2=B1 0.004M/s  (  2.776M/s/=
cpu)
> > uprobe-nop            (16 cpus):   41.476 =C2=B1 0.020M/s  (  2.592M/s/=
cpu)
> > uprobe-nop            (24 cpus):   64.696 =C2=B1 0.021M/s  (  2.696M/s/=
cpu)
> > uprobe-nop            (32 cpus):   85.054 =C2=B1 0.027M/s  (  2.658M/s/=
cpu)
> > uprobe-nop            (40 cpus):  101.979 =C2=B1 0.032M/s  (  2.549M/s/=
cpu)
> > uprobe-nop            (48 cpus):  110.518 =C2=B1 0.056M/s  (  2.302M/s/=
cpu)
> > uprobe-nop            (56 cpus):  117.737 =C2=B1 0.020M/s  (  2.102M/s/=
cpu)
> > uprobe-nop            (64 cpus):  124.613 =C2=B1 0.079M/s  (  1.947M/s/=
cpu)
> > uprobe-nop            (72 cpus):  133.239 =C2=B1 0.032M/s  (  1.851M/s/=
cpu)
> > uprobe-nop            (80 cpus):  142.037 =C2=B1 0.138M/s  (  1.775M/s/=
cpu)
> >
> > Previously total throughput was maxing out at 11mln/s, and gradually
> > declining past 8 cores. With this change, it now keeps growing with eac=
h
> > added CPU, reaching 142mln/s at 80 CPUs (this was measured on a 80-core
> > Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz).
> >
>
> Looks good to me, except one question below.
>
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 45 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 290c445768fa..efcd62f7051d 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2074,6 +2074,47 @@ static int is_trap_at_addr(struct mm_struct *mm,=
 unsigned long vaddr)
> >       return is_trap_insn(&opcode);
> >  }
> >
> > +static struct uprobe *find_active_uprobe_speculative(unsigned long bp_=
vaddr)
> > +{
> > +     struct mm_struct *mm =3D current->mm;
> > +     struct uprobe *uprobe =3D NULL;
> > +     struct vm_area_struct *vma;
> > +     struct file *vm_file;
> > +     loff_t offset;
> > +     unsigned int seq;
> > +
> > +     guard(rcu)();
> > +
> > +     if (!mmap_lock_speculation_begin(mm, &seq))
> > +             return NULL;
> > +
> > +     vma =3D vma_lookup(mm, bp_vaddr);
> > +     if (!vma)
> > +             return NULL;
> > +
> > +     /*
> > +      * vm_file memory can be reused for another instance of struct fi=
le,
> > +      * but can't be freed from under us, so it's safe to read fields =
from
> > +      * it, even if the values are some garbage values; ultimately
> > +      * find_uprobe_rcu() + mmap_lock_speculation_end() check will ens=
ure
> > +      * that whatever we speculatively found is correct
>
> If vm_file is a garbage value, may `vm_file->f_inode` access be dangerous=
?
>
> > +      */
> > +     vm_file =3D READ_ONCE(vma->vm_file);
> > +     if (!vm_file)
> > +             return NULL;
> > +
> > +     offset =3D (loff_t)(vma->vm_pgoff << PAGE_SHIFT) + (bp_vaddr - vm=
a->vm_start);
> > +     uprobe =3D find_uprobe_rcu(vm_file->f_inode, offset);
>                                        ^^^^ Here
>
> if it only stores vm_file or NULL, there's no problem.

IIRC correctly, vma->vm_file is RCU-safe and we are in the read RCU
section, so it should not contain a garbage value.

>
> Thank you,
>
> > +     if (!uprobe)
> > +             return NULL;
> > +
> > +     /* now double check that nothing about MM changed */
> > +     if (!mmap_lock_speculation_end(mm, seq))
> > +             return NULL;
> > +
> > +     return uprobe;
> > +}
> > +
> >  /* assumes being inside RCU protected region */
> >  static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, i=
nt *is_swbp)
> >  {
> > @@ -2081,6 +2122,10 @@ static struct uprobe *find_active_uprobe_rcu(uns=
igned long bp_vaddr, int *is_swb
> >       struct uprobe *uprobe =3D NULL;
> >       struct vm_area_struct *vma;
> >
> > +     uprobe =3D find_active_uprobe_speculative(bp_vaddr);
> > +     if (uprobe)
> > +             return uprobe;
> > +
> >       mmap_read_lock(mm);
> >       vma =3D vma_lookup(mm, bp_vaddr);
> >       if (vma) {
> > --
> > 2.43.5
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

