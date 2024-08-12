Return-Path: <linux-kernel+bounces-282681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B892494E752
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7532B283031
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BEE15351C;
	Mon, 12 Aug 2024 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5wiESlb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0815413E40F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723446026; cv=none; b=n1vOGC6aOxg/oyshookoiOHhHU9WNB8usHBVsu/w2nVH54INzvExPRmcnGmAxfNcvtplR1dPgGoapYFq/8bWGfx3ZiNkfLqM1gpZS+d1rxisNztaD1SDSVCRBSfvrGfwAQoikR4Z4e6QahBk9nvUDn8r/e1mMB/LmF3blUgvmTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723446026; c=relaxed/simple;
	bh=S0zPhso4B/BX7cFCElhUVcufYJsv494XwmqIF2Y/yxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1myukfwVf3OOBbNCM4HksXERgZbBqEs5Z9Bf/RQTUqelHvNDqSIk+TkzyCF63L5qGLni0UY4McCmeGJT8eI8FxI0M62N8FDxaGBanL7+AuaIWjy/D8abGOoBpXcxoxjloylJtjevQavvVZpoNSSkUZ3QSbbmFsZgtHv+otwsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5wiESlb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723446022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSsSzksoUZv3/VShmqUKFIu+S4eeg5+mXA9YiUlfHtE=;
	b=F5wiESlbC6hDQO26Ko2MEfjt6bJTZW9p4DCsMBlo/JCOf3COqYyHxkGRMXT1PFg4F/FkfS
	6JnB2aFAPEeQAHrR9fV9+UINVTBrZNsJLZ5qHJeHIav3t6BuExol4oWz8QM8/F+uHcj3Jm
	Qkkc4PBbObOVzJSIqQBDP5UXBQ81eLA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-V-lNkq_nPkqXfq5v7Zs1VQ-1; Mon, 12 Aug 2024 03:00:21 -0400
X-MC-Unique: V-lNkq_nPkqXfq5v7Zs1VQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb6f2b965dso5520623a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 00:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723446020; x=1724050820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSsSzksoUZv3/VShmqUKFIu+S4eeg5+mXA9YiUlfHtE=;
        b=r3D59SKh1KsMcjSG+WXODZwCUnnfuU/gECtzHwAB7lJXqk02BTEGt9gBP6yumIZY0T
         p1iHzCAxb5KQrzgP7KMxabNgGV0gHBy1IjThoEz4wftWwgXp5IgXK9IgW1evoENYHbX9
         cF6rnDDFdiUG+wo8HFDVusl0fwyjfPmbglGDLM4B6gOXmAesq7SXdqv432fT2ZqlhNWB
         /wDQoXFszRlJ7B724Zpbqa5dM5apKwIlxdUZWsgHDyIZcPkA3dE5ax3u3fW4CGYB/WOr
         HGs6xD7Je35d5ytcmWzGTPhgcABPjHI4T91/NMYyc3+hMyQEM7mAJ2TfGLZq+n+z1Y6q
         s8eA==
X-Forwarded-Encrypted: i=1; AJvYcCXTDp222EyCFYHb49Lu5N3tKb2oyKwGf2BmHbGAvll7xFESauWqvyofuHrpHuHU3zA/KOCb+A0bx8XYZpkrI0VgOZP1f697MvGtIpfZ
X-Gm-Message-State: AOJu0Ywfca5kLWbJp5aMWNl53iMy9g5g/+ef1+ICSJgPvfGeMnB0bPLs
	jl409YSb8iw5b0b5N9W7PDqG15mBHM7hMIzOqZ4QVKaZm96bba0IKIggi6jyoRXMmNN+dzAgS1n
	WA3U9Jf05dJJbevcwFyjYb2V6ylIyk5O+VcA4zP/oWKw0AwMXEhdKXVOuRjtOat/mr9vw1APGHq
	VsmtbbvGc78SnX30cw+BGszvVNmspz5nczjlp+
X-Received: by 2002:a17:90b:4f8a:b0:2c9:e0e3:e507 with SMTP id 98e67ed59e1d1-2d1e7c5e412mr9009106a91.0.1723446020284;
        Mon, 12 Aug 2024 00:00:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpbWsbXYgU8ce3mzCHOLbVvxlpYnUfy/J6VF+x38GwFCbri9IY+Rpchg44Neo2WJoxq/aQmGduo7dzNVi0jm4=
X-Received: by 2002:a17:90b:4f8a:b0:2c9:e0e3:e507 with SMTP id
 98e67ed59e1d1-2d1e7c5e412mr9009053a91.0.1723446019049; Mon, 12 Aug 2024
 00:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACycT3uM1jSdqFT0LGqy1zXZkWF8BNQN=8EMKYMoyP_wjRtsng@mail.gmail.com>
 <CACGkMEtYE1OY+okxHAj=cVfW-Qz45an28oO=Wv15yOtpD6UqdQ@mail.gmail.com> <CACycT3vAv1K0yBKgc_8GBLpEPwASTCCPZYAxMyUROQsyntQdOw@mail.gmail.com>
In-Reply-To: <CACycT3vAv1K0yBKgc_8GBLpEPwASTCCPZYAxMyUROQsyntQdOw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 12 Aug 2024 15:00:08 +0800
Message-ID: <CACGkMEsYRrzSzNHgN490TDCWFm3EG1ic_-f4F+mu9CNz4uY=iw@mail.gmail.com>
Subject: Re: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Yongji Xie <xieyongji@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:52=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com>=
 wrote:
>
> On Thu, Aug 8, 2024 at 10:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Aug 7, 2024 at 2:52=E2=80=AFPM Yongji Xie <xieyongji@bytedance.=
com> wrote:
> > >
> > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > Barry said [1]:
> > > >
> > > > """
> > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > > > __GFP_NOFAIL without direct reclamation may just result in a busy
> > > > loop within non-sleepable contexts.
> > > > ""=E2=80=9C
> > > >
> > > > Unfortuantely, we do that under read lock. A possible way to fix th=
at
> > > > is to move the pages allocation out of the lock into the caller, bu=
t
> > > > having to allocate a huge number of pages and auxiliary page array
> > > > seems to be problematic as well per Tetsuon [2]:
> > > >
> > > > """
> > > > You should implement proper error handling instead of using
> > > > __GFP_NOFAIL if count can become large.
> > > > """
> > > >
> > > > So I choose another way, which does not release kernel bounce pages
> > > > when user tries to register usersapce bounce pages. Then we don't n=
eed
> > > > to do allocation in the path which is not expected to be fail (e.g =
in
> > > > the release). We pay this for more memory usage but further
> > > > optimizations could be done on top.
> > > >
> > > > [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq=
8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf=
8
> > > > [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq=
8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb14648=
0
> > > >
> > > > Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounc=
e buffer")
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > >
> > > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > > Tested-by: Xie Yongji <xieyongji@bytedance.com>
> >
> > Thanks.
> >
> > >
> > > Have tested it with qemu-storage-daemon [1]:
> > >
> > > $ qemu-storage-daemon \
> > >     --chardev socket,id=3Dcharmonitor,path=3D/tmp/qmp.sock,server=3Do=
n,wait=3Doff \
> > >     --monitor chardev=3Dcharmonitor \
> > >     --blockdev driver=3Dhost_device,cache.direct=3Don,aio=3Dnative,fi=
lename=3D/dev/nullb0,node-name=3Ddisk0
> > > \
> > >     --export type=3Dvduse-blk,id=3Dvduse-test,name=3Dvduse-test,node-=
name=3Ddisk0,writable=3Don
> > >
> > > [1] https://github.com/bytedance/qemu/tree/vduse-umem
> >
> > Great, would you want to post them to the Qemu?
> >
>
> Looks like qemu-storage-daemon would not benefit from this feature
> which is designed for some hugepage users such as SPDK/DPDK.

Yes, but maybe for testing purposes like here?

Thanks

>
> Thanks,
> Yongji
>


