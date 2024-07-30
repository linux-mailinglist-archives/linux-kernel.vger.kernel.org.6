Return-Path: <linux-kernel+bounces-268003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BBB941F40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98530284B70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A5F18B46D;
	Tue, 30 Jul 2024 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NexlgKzE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28989189902
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363053; cv=none; b=UY37+0sfBAW/S+HDlq4zHbhYUhguYt5nKLmQAeGyFfjGuVr674E3p3j+2TadyCBgeZOy/ka4B0GUwYdn6jr8StGLTgm1NfW4R1VQv9sGOQn5Wk0JKpmObR7UZNmGnxyxWTAqqB2QEJOtwgB/tRgpRnji8vnEkJNAeNpKj63sDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363053; c=relaxed/simple;
	bh=0lQBP4rNXainoXcVHBwi0kr7juVCuFLU2P22XfYpVXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2wiQFRsyDCEAtqiy5pp4Q0mKkcSM6WxWTaUoAM60mY+vliSVf6PDLjPTTXx0ymxisb6p5Hlzuix4a8zxtaHjA+dGJU6p9TUuonq4CZNUikhFqUruL/hnOR76O2jqk/fCs0bbtO61AHcSMtOgnWzBJsT5eiBfY3iArmL3f45ZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NexlgKzE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso30350305e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722363050; x=1722967850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGhH0uDu93FhhsJCvkGO3qe3hVA/MLfA5YSAYjGjOxo=;
        b=NexlgKzEeaB1GfnYP99TTke1OA2/qt89esPeNPwYqAOV8MaYFO7U9yaXrqRlbBRhJl
         +ruaaVpwRWEZfJZwGYZ85sTaSHS8mQDkTmEKSqhFpAPFBs5ra5jqk2rOx2+4f2LfJ/du
         8VQuBpysPpjJ1Ssw0SU3yeDw1kPqpaPWHYX4jJ2Nch1JbSjjpEzMnouk/uC69gT5M93P
         I85CHMDWpllu98UWe4KLBxDeA6XBtsHvcOyh975AaWzmbVfwN174HeD3vfTDTpuy/0ab
         cj7vvQOeazh7j771ckSDlyRCB3LvDsYpISSNiK6qiMu0y0lYJUobrkAt7Wrowda0fbOE
         cceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722363050; x=1722967850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGhH0uDu93FhhsJCvkGO3qe3hVA/MLfA5YSAYjGjOxo=;
        b=sUCj5jvJlI4eUSQOUdmBPsDp/Y3OFbpFNGXoavAR14qOl2cw8Is3bz6mE6mke7Ds1T
         GF0e7IMGbbxl6V3nWhIEao1ydZnS0uwbXBxjLjHDb7WMzulE3ktE+RFYv72X6v/s7p2i
         KOV5m1qcJNugrCdytb0RMVTar67mzJQZrvIylQDbnS7VxTetZu+duXWAtBIZPEeBWLkf
         Jgw3rZ4/IeL8T1HN4i3eyulMTERYOuexVzEwcGChedNsFI9q/WuNeEHX3W25+6d2hZgc
         ui1zEdkd/3+eKrA/BqXPxE4Bppi1jmg4r/BfyFmDX2E1oCXcL1rwM9y65BxyHGNkiAuq
         2o4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7faSI0oBwcVUwc4c5SRZOb8TMQRsSnU/p7xUNTkc1Kk3Is+mwJlP3ZIJ9bEYHyn5TQzmKnVh2rNuSqUT+R1Pl2lrrgwDzIUwkSYbr
X-Gm-Message-State: AOJu0Yzm7wQzliJu9Tdml+VJlvKNoygukfCMOoXVxC8wcBVYQ3cVcfbb
	13YXgruhYzz/vCqznq0iZy+u5x93+4l7uCS8XtV8HxzcA59rsbPH3pkErMbEzxzYva8ZO45+P6F
	Fk12XQI5RlAmfLTaXteCTfUjyRufz1IvzKiUt
X-Google-Smtp-Source: AGHT+IG+L+Znba43C1ffV6KA4A7+WOi+BlM2lo3Auff1W58sTDTBioUK+SAO84Ba+RWhR3G1Sa+lkO/IbAs3/uCgDps=
X-Received: by 2002:a5d:670f:0:b0:367:f104:d9e8 with SMTP id
 ffacd0b85a97d-36b5d08b9c4mr6609846f8f.47.1722363050078; Tue, 30 Jul 2024
 11:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709090153.GF27299@noisy.programming.kicks-ass.net>
 <91d37ad3-137b-4feb-8154-4deaa4b11dc3@paulmck-laptop> <20240709142943.GL27299@noisy.programming.kicks-ass.net>
 <Zo1hBFS7c_J-Yx-7@casper.infradead.org> <20240710091631.GT27299@noisy.programming.kicks-ass.net>
 <20240710094013.GF28838@noisy.programming.kicks-ass.net> <CAJuCfpF3eSwW_Z48e0bykCh=8eohAuACxjXBbUV_sjrVwezxdw@mail.gmail.com>
 <CAEf4BzZPGG9_P9EWosREOw8owT6+qawmzYr0EJhOZn8khNn9NQ@mail.gmail.com>
 <CAJuCfpELNoDrVyyNV+fuB7ju77pqyj0rD0gOkLVX+RHKTxXGCA@mail.gmail.com>
 <ZqRtcZHWFfUf6dfi@casper.infradead.org> <20240730131058.GN33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240730131058.GN33588@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 30 Jul 2024 11:10:33 -0700
Message-ID: <CAJuCfpFUQFfgx0BWdkNTAiOhBpqmd02zarC0y38gyB5OPc0wRA@mail.gmail.com>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org, 
	andrii@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	oleg@redhat.com, jolsa@kernel.org, clm@meta.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 6:11=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sat, Jul 27, 2024 at 04:45:53AM +0100, Matthew Wilcox wrote:
>
> > Hum.  What if we added SLAB_TYPESAFE_BY_RCU to files_cachep?  That way
> > we could do:
> >
> >       inode =3D NULL;
> >       rcu_read_lock();
> >       vma =3D find_vma(mm, address);
> >       if (!vma)
> >               goto unlock;
> >       file =3D READ_ONCE(vma->vm_file);
> >       if (!file)
> >               goto unlock;
> >       inode =3D file->f_inode;
> >       if (file !=3D READ_ONCE(vma->vm_file))
> >               inode =3D NULL;
>
> remove_vma() does not clear vm_file, nor do I think we ever re-assign
> this field after it is set on creation.

Quite correct and even if we clear vm_file in remove_vma() and/or
reset it on creation I don't think that would be enough. IIUC the
warning about SLAB_TYPESAFE_BY_RCU here:
https://elixir.bootlin.com/linux/v6.10.2/source/include/linux/slab.h#L98
means that the vma object can be reused in the same RCU grace period.

>
> That is, I'm struggling to see what this would do. AFAICT this can still
> happen:
>
>         rcu_read_lock();
>         vma =3D find_vma();
>                                         remove_vma()
>                                           fput(vma->vm_file);
>                                                                 dup_fd)
>                                                                   newf =
=3D kmem_cache_alloc(...)
>                                                                   newf->f=
_inode =3D blah
>

Imagine that the vma got freed and reused at this point. Then
vma->vm_file might be pointing to a valid but a completely different
file.

>         file =3D READ_ONCE(vma->vm_file);
>         inode =3D file->f_inode; // blah
>         if (file !=3D READ_ONCE(vma->vm_file)) // still match

I think we should also check that the VMA represents the same area
after we obtained the inode.

>
>
> > unlock:
> >       rcu_read_unlock();
> >
> >       if (inode)
> >               return inode;
> >       mmap_read_lock();
> >       vma =3D find_vma(mm, address);
> >       ...
> >
> > I think this would be safe because 'vma' will not be reused while we
> > hold the read lock, and while 'file' might be reused, whatever f_inode
> > points to won't be used if vm_file is no longer what it once was.
>
>
> Also, we need vaddr_to_offset() which needs additional serialization
> against vma_lock.

