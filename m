Return-Path: <linux-kernel+bounces-277207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB16949DDD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0F3B245BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3CE18FDC0;
	Wed,  7 Aug 2024 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXba6Bo4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190DF2E859
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 02:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722998338; cv=none; b=R8TZJzPwhGVVFoVn92bR9KSAbsU2/i/wFvZNBmyIPLUSct6BxM6qi0XwDE1RtxnLoRO7qiP8OdxycUc4LbrCNiMgZLfmCUyBHQvOeKsMP1iI1m7Ujz87lFdqgTj2WUSUX9TYwXqr8rZN1fvfFWLi/rLAZVwvgvaDcenJeOCnrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722998338; c=relaxed/simple;
	bh=j7DELF6Ao0UKpO6uVhlXClIeUSt1Tugi/IGtg7SeFX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTgcoNVIuUUIU4fyVbLF1+DL6lcABOQEpvoKPamMcBcza3v2jAPPs3PtnbTfyRcLRG+6NCnLNlDzqbkIEWyJoI7VLTpINQhfZqbzCdGJji8pQXZ1dsO9eU9uUAAHxDr9J4PNA7CzNwNbfXH9t00eiu7SsnK/hHKUz4YPVzV2RLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXba6Bo4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722998335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7DELF6Ao0UKpO6uVhlXClIeUSt1Tugi/IGtg7SeFX4=;
	b=hXba6Bo4Aue2GGYk6GYFdZJ3yA/FIxJZZuvuiplPQ+B84mXOwBbe51W50TXbXaw6qsGKm9
	/y4ZDvBGa39DEgio65GY5w5bPJOU37AAVQuU5SQmMcjOl1DF2nPfmewVp4A9RRooSNt0cb
	9GjPjJbLKIFAlAKTUHVBdw1BMa6qXR0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-baOM9kprNeagCBVf2cf_Gw-1; Tue, 06 Aug 2024 22:38:54 -0400
X-MC-Unique: baOM9kprNeagCBVf2cf_Gw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb6b642c49so419069a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 19:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722998333; x=1723603133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7DELF6Ao0UKpO6uVhlXClIeUSt1Tugi/IGtg7SeFX4=;
        b=BrS89SrOHWRv2i7bSKvVY/zuGKoL5jNM2eZGLHtSnMrG3zABsHBhNk0r10Twkz66gw
         fbwZLEjllK76a9WeNwOg2eQh+qjEn6bTgejAzvro/Jhg0P+tYAw1UqAlxv+E+2bGdFKj
         n65nnyQQ4I6DN1a48j2CcdL34T8luefzCqt3Helm13+dD1Ea8LJvYVc8luvQNazAhBjF
         P9HhmUytZmmHqz3M5YOL52qKo0AB0w4EKIBBvFGYHgrXegzUqeSpbJJ4YP6Bd4kqEbCr
         W3nSyITF32btZ6qt9YaRgm4oFT5j/7xPE4qwTcxABhtW2Zc9t/bXlO/568HByY7+e45N
         E0Og==
X-Forwarded-Encrypted: i=1; AJvYcCVPcajBp/Aim6ZH8gMecZr1CZodGLiq/gRgdXV9fXec9PU5CVWbXj05K57rRntkbiFqZYL/3ZppFSUT4/0smiXX41Pmwk4mJPOY4PK5
X-Gm-Message-State: AOJu0Yx6QCzi+y+2qa3LvGUQ5sBmRCeZ4WqaFUMdH1zdkoRpjh2cjRmq
	8MrsS4f6BGzHLvS2IYrJtBrPKNuqx3ccHtoWLupAkIlkfPLLoQjkGSYfczDNcNRy51nwqatg8hK
	otWFEsRd76bp5weNFY7TllWobgZTGK3Jg4qJ0XXtAVHD/rBO2NdeekVm6j8cQIXooasKL3Y7jvH
	/6eZ03vAG6XIL0gc2pAmzyJbny6YcnzIwMTc1M
X-Received: by 2002:a17:90b:1dca:b0:2cb:5d90:2b9 with SMTP id 98e67ed59e1d1-2d1b2d66ee5mr1213075a91.11.1722998332988;
        Tue, 06 Aug 2024 19:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXhzqKMjR4CUA+ig12Q1cVFNkUlvYHC13DYz9oSS0II3mJkGVS+YLXGG1k/cvTUOboyvLitgHuy70DXVaSIas=
X-Received: by 2002:a17:90b:1dca:b0:2cb:5d90:2b9 with SMTP id
 98e67ed59e1d1-2d1b2d66ee5mr1213046a91.11.1722998332437; Tue, 06 Aug 2024
 19:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
 <CACycT3sz-OOKKcmH=FgD7gp_Bhi9=nwnkTn0VgRhQBxS2Dp4qw@mail.gmail.com>
 <CACGkMEs4YWr5zu0_nVCvqLSFBG9U_A_mw+7AdkMwrPo_6X-gOA@mail.gmail.com> <CACycT3vYF3nwZ3k5_8G=Zok9c4qRjCcGLVQ7+RfSpK=5PToMuA@mail.gmail.com>
In-Reply-To: <CACycT3vYF3nwZ3k5_8G=Zok9c4qRjCcGLVQ7+RfSpK=5PToMuA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Aug 2024 10:38:41 +0800
Message-ID: <CACGkMEue9RU+MMgOC0t4Yuk5wRHfTdnJeZZs38g2h+gyZv+3VQ@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Yongji Xie <xieyongji@bytedance.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 11:10=E2=80=AFAM Yongji Xie <xieyongji@bytedance.com=
> wrote:
>
> On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@bytedance.=
com> wrote:
> > >
> > > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > Barry said [1]:
> > > > >
> > > > > """
> > > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > > > > __GFP_NOFAIL without direct reclamation may just result in a busy
> > > > > loop within non-sleepable contexts.
> > > > > ""=E2=80=9C
> > > > >
> > > > > Unfortuantely, we do that under read lock. A possible way to fix =
that
> > > > > is to move the pages allocation out of the lock into the caller, =
but
> > > > > having to allocate a huge number of pages and auxiliary page arra=
y
> > > > > seems to be problematic as well per Tetsuon [2]:
> > > > >
> > > > > """
> > > > > You should implement proper error handling instead of using
> > > > > __GFP_NOFAIL if count can become large.
> > > > > """
> > > > >
> > >
> > > I think the problem is it's hard to do the error handling in
> > > fops->release() currently.
> >
> > vduse_dev_dereg_umem() should be the same, it's very hard to allow it t=
o fail.
> >
> > >
> > > So can we temporarily hold the user page refcount, and release it whe=
n
> > > vduse_dev_open()/vduse_domain_release() is executed. The kernel page
> > > allocation and memcpy can be done in vduse_dev_open() which allows
> > > some error handling.
> >
> > Just to make sure I understand this, the free is probably not the big
> > issue but the allocation itself.
> >
>
> Yes, so defer the allocation might be a solution.

Would you mind posting a patch for this?

>
> > And if we do the memcpy() in open(), it seems to be a subtle userspace
> > noticeable change? (Or I don't get how copying in vduse_dev_open() can
> > help here).
> >
>
> Maybe we don't need to do the copy in open(). We can hold the user
> page refcount until the inflight I/O is completed. That means the
> allocation of new kernel pages can be done in
> vduse_domain_map_bounce_page() and the release of old user pages can
> be done in vduse_domain_unmap_bounce_page().

This seems to be a subtle userspace noticeable behaviour?

> Of course, we still have
> a copy (old user page -> new user spage) if the daemon calls
> vduse_dev_reg_umem() again.
>
> Thanks,
> Yongji
>

Thanks


