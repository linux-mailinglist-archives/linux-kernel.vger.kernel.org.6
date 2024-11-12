Return-Path: <linux-kernel+bounces-404985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886109C4B62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA965281D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B29F204014;
	Tue, 12 Nov 2024 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8pT54M/"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D7204001
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373184; cv=none; b=QJhBrUf2qnvCV7bLYAdb+mJG6GeII0mtyxMB07/JDMWmKdJ6J6eH7IcM53JXL+pAh2jCovL5wy8BkAoaA6Ltf4Lc19xGFPrpcfSvoJl783oaIkFPyuhG8nAtxjyaAYt7+y3NYtpefTcgJGXazDQNsbTYrWrmdPsh9HneFHtLjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373184; c=relaxed/simple;
	bh=y1/ND4heqsVX/YABFxnL/lnL07J2BlMnjEGg/bN38z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Qu51JOIAt/ucE3Oe8YBl4rWWt5OM1JZ9bNtJB/YWLymfXL8uviw2/HxBR97bxARYvLJfFSuNrRBVV2jGrhfp8UuUUApc2ZV4fL7tCrdF8xPmVHzwlxA8ZWDOie8Uv0WhRU+a0JeRaxIZKhkzR3aMxwuYoWD2Y6ZABMAaJnQHZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8pT54M/; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460969c49f2so118561cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731373182; x=1731977982; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LecjDJoTOnaJoml7h+dyn1NllN9mcIC7cbAU8yO5fVI=;
        b=u8pT54M/njNiKN3m0f76UO3oQrP0HNuQGfsoWX9C1w1bjiUbLwGZtsCn71CrEDQ944
         33cdXunY57Ryt0gjun/HlnqQD9qcMlsFVJ7Hx88dWRcdj7WcRFMD3II0M0IV1CRNmEuW
         yiV1+EIxziDPAJ2sGKnI2RsjmStmi2mZIfsdSNb8YY89GWLpOaviv2zAQgLvkui9lFXe
         4Fhb6dGerMJ/MzTYtbbakDdxNEwOX2jwnnTGiIQMCU445XcWffZ1zVmTaW/evngcLjtF
         TRLK6WCkkYRtW5ALemBGsdpygo3ABpONB7/tLo98nvqP+Te38dR6QBnm5iQ3zc2iLTlG
         dhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731373182; x=1731977982;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LecjDJoTOnaJoml7h+dyn1NllN9mcIC7cbAU8yO5fVI=;
        b=hepzee6Ek5KkY9A40npekEyFZvBE9kBvsp8Ae2L3qLtf0vLMxuhI7sQZGjwbDEBhbv
         o3auIk7gsbJ/aEqlRvl3F4Urki2AHzqrz6qgMarx8DlrnYB7/rb6yDWyaCjO9taa685k
         jXrkqeiA5xKtyj2Feo1LD6GKsuu8xTiDbBIFudW0qRESk7I2T/kOtbJd/oOLhIMVsIWH
         MSNOyZtYkBHysd/xLUJRGU7G0+lcqdCAeqR7Rik7g2bGglzqGmL6GFbUOGPG8F9AX5vo
         OJitkuXMOf/zPsZKpmFBuhG0e2yPtQwY3JGJn+hPBgHgGyBlChAMWfGL+85g5/EDhs01
         qOVA==
X-Forwarded-Encrypted: i=1; AJvYcCUyLJMQYSDlPbNtyiwQyuAyuaqCmoK1Ctl9qoi1CiMY17OK7aIXFhxkIJBmiT9KMTqxvkyJ5+IJMOThYiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjSPYZCSznLi9mLt0Jjsb7nm7yYD/DhHjJMg0zk9RlogBqFo6
	mw/3kPL/luGQVgvywhufXWaHP0agwZvh8+/liGNRirNy47wz3buWgWVWE78j+XovF+qX4YZ+ci6
	MjnSnisTJiTivXW4KlAe/DiojvaIDT97rVL8z
X-Gm-Gg: ASbGncsKF9i/hvLBRDhv+/5JDiQ3A+r2VuNe4Qy32Hy9yKGhfL4BL6zDISD8oAhl0Yx
	/X5V5TK0ImznpW21SzvBp5giAcG9BpCQ=
X-Google-Smtp-Source: AGHT+IEKsIFJbzCEUMdsDAPcE+87L+ORDqqQpmYus1Wg3+7ujB5DDEVe1FkWX+KWOSMItCnNYwksNyNROIU4xmGwdqQ=
X-Received: by 2002:a05:622a:47ca:b0:461:31b8:d203 with SMTP id
 d75a77b69052e-463427ddf44mr218161cf.3.1731373181873; Mon, 11 Nov 2024
 16:59:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111205506.3404479-4-surenb@google.com>
 <20241112003527.ogtrnknjwvtqfewm@offworld>
In-Reply-To: <20241112003527.ogtrnknjwvtqfewm@offworld>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 11 Nov 2024 16:59:30 -0800
Message-ID: <CAJuCfpGRdYkbJ3DkyNZPwsZqu29rnqGdOY9B+M1dL14Cu79XDg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, willy@infradead.org, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:35=E2=80=AFPM Davidlohr Bueso <dave@stgolabs.net>=
 wrote:
>
> On Mon, 11 Nov 2024, Suren Baghdasaryan wrote:
>
> >@@ -787,7 +893,10 @@ static inline void vma_start_write(struct vm_area_s=
truct *vma)
> >        * we should use WRITE_ONCE() for cleanliness and to keep KCSAN h=
appy.
> >        */
> >       WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> >-      up_write(&vma->vm_lock.lock);
> >+      /* Write barrier to ensure vm_lock_seq change is visible before c=
ount */
> >+      smp_wmb();
> >+      rwsem_release(&vma->vm_lock.dep_map, _RET_IP_);
> >+      atomic_set(&vma->vm_lock.count, VMA_LOCK_UNLOCKED);
>
> Too many barriers here. Just do atomic_set_release and remove that
> smp_wmb(). And what you are doing is really ensuring nothing leaks out
> of the critical region, so that comment should also be more generic.

Uh, yes. I missed that.

>
> I would expect regression testing to catch this sort of thing.

Well, it's in vma_start_write(), which is in the write-locking path.
Maybe that's why it's not very visible.

>
> ...
>
> > #ifdef CONFIG_PER_VMA_LOCK
> >+              struct wait_queue_head vma_writer_wait;
>
> You might want to use rcuwait here instead, which is much more
> optimized for the single waiter requirement vmas have.

Thanks for the suggestion! I'll give it a try.

>
> Thanks,
> Davidlohr

