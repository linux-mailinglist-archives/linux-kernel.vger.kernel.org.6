Return-Path: <linux-kernel+bounces-282702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2CA94E7A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287131F22644
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCFE154C02;
	Mon, 12 Aug 2024 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gTWcNalg"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2CA2905
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447303; cv=none; b=OM6n82MoR2/9qhr/21NNSrGUrdbxlIUaiWjHG2Y7OjaqdKhN59KqlCQWRziFzmV3joL53d8nGI/yCLzo2sjwTV3rOIgRaJN+KGXHrZT0hkeyyWlu7IFIwA29PI0rilc6lvG4slqnHlac/8hKiYTohdPqnU5C0HfwQMG6EKMINzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447303; c=relaxed/simple;
	bh=OT9Aw1LBu6ZBlsDRwoCPvZdTNUEIPR2Efs1VpLrgUCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjME+QkCOAqoPifOU1mCwX0W4fPPev9jBrHlLUuFEVwFMAbonD+h0YQlaWRTiMfefA5FqW7DxUtES6bRuY4w4cHnuGzobSWG269BDGYmXmXCfXGdgsgpueCLIuG0yM4WwbVTe0tKtZVC6awzok5FCEdvB1Um2eP3aYHIzzaAiOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gTWcNalg; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d37e5b7b02so225241a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 00:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723447300; x=1724052100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc9rFMB/nIG43R05ENPWmh8znCe093RvwxOUzoaD3nc=;
        b=gTWcNalghDJtq3BCX8w4X7VI2svgOX2HvjOBKX79AOWCRgHX3tQJQmbj0I799hkn8J
         SyCgRbIYPSk006AvIUs+gzSo5IrPXOQ4v7HiwpqDF5fVmT7Omw0F8kclXA2raqwbjWEF
         NNP+Z3mbS+PCPa7ljeLcnG6AOYb01SmsXnViSQZVp2VH79Oo7HKLX0fgDyrpXf6Fssat
         EUYK/PMfhzBXVyXpEygAG/ek1hJ7EbJFvGY0w/hjH6fFo5kC5xcpoRLHVsYbrlLxMCc7
         8JFLs/SxLbYJIH0e98/QP9zQZwTAGJLPmk+EYFGGrHRCZvu+zTPrRdp3XhFD2l0Ufrhs
         j2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723447300; x=1724052100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gc9rFMB/nIG43R05ENPWmh8znCe093RvwxOUzoaD3nc=;
        b=o1M/iruVOXF3tngVRJlSvuUF9I16VjHSnyHe8ezdRiOHnu5lei9i7d1IfyNm9d4O7N
         T48t9o4tAn2FMzOjEjpOvuX3e4lhxk+qI33lY+h8j8ASnefXSUTSaif4iGdATYzgiqPN
         5OiHkCUq32W+jSJ9RFaa5Wc5I2kMaDYXdLtzQXshRAG9z+Y/4Uo5U1d5Xso4dsK4bPE4
         NvymugmsHc0OnPo7V646bOqwKE1GR04tqoCR+JOrqs7qfGOakuRFhh5MrH/Zu9EqaZsr
         6+cXBz167bkq9EG9on+nn/C6MtPmuB7/tG6baT81pIjBFWZ1rpag6r95nz9kUhglIxTU
         zpXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7BgZr08az7rNXx/l+4tEnUYg5jojyGP+3GYslQ7sbxDxAl5i9l49JgS0mn6axFww4lqw/uluQST4hfspgqXg6wPvwoxLvVNXbylyz
X-Gm-Message-State: AOJu0Ywo/3/60+BYrk+HjwvbUH35NS98rJ8WOwsVCk4YqpcfARDSBRJN
	cAiV2p3BoE7DTFgxF/YeNdDChb4KHoUEjcTSzWispHhgOxvkpJkm3yxyYZMjFbnuwSntGxQ3R7Y
	MeAcj2NTlK7KproDynwNGiNPrMDXMfx7C3n2G
X-Google-Smtp-Source: AGHT+IGQ2qzReh2+VWgM62ZqUt67uGinfqCdpOyHAtZrbUjyZcrygoPn4dl3XzhRPpe+f4DRP+pSYmvPd3hj1Y2rOZA=
X-Received: by 2002:a17:90b:183:b0:2c8:f3b4:a3df with SMTP id
 98e67ed59e1d1-2d1e806a38cmr6050040a91.42.1723447300157; Mon, 12 Aug 2024
 00:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACycT3uM1jSdqFT0LGqy1zXZkWF8BNQN=8EMKYMoyP_wjRtsng@mail.gmail.com>
 <CACGkMEtYE1OY+okxHAj=cVfW-Qz45an28oO=Wv15yOtpD6UqdQ@mail.gmail.com>
 <CACycT3vAv1K0yBKgc_8GBLpEPwASTCCPZYAxMyUROQsyntQdOw@mail.gmail.com> <CACGkMEsYRrzSzNHgN490TDCWFm3EG1ic_-f4F+mu9CNz4uY=iw@mail.gmail.com>
In-Reply-To: <CACGkMEsYRrzSzNHgN490TDCWFm3EG1ic_-f4F+mu9CNz4uY=iw@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 12 Aug 2024 15:21:29 +0800
Message-ID: <CACycT3tE8qb0+X6O27e0KAevA230f8bzqeXh45fHNQOB6a5agA@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 3:00=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Aug 8, 2024 at 6:52=E2=80=AFPM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
> >
> > On Thu, Aug 8, 2024 at 10:58=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Aug 7, 2024 at 2:52=E2=80=AFPM Yongji Xie <xieyongji@bytedanc=
e.com> wrote:
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
> > > > > So I choose another way, which does not release kernel bounce pag=
es
> > > > > when user tries to register usersapce bounce pages. Then we don't=
 need
> > > > > to do allocation in the path which is not expected to be fail (e.=
g in
> > > > > the release). We pay this for more memory usage but further
> > > > > optimizations could be done on top.
> > > > >
> > > > > [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+=
nq8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6f=
cf8
> > > > > [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+=
nq8ZQ2saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146=
480
> > > > >
> > > > > Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bou=
nce buffer")
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > >
> > > > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > > > Tested-by: Xie Yongji <xieyongji@bytedance.com>
> > >
> > > Thanks.
> > >
> > > >
> > > > Have tested it with qemu-storage-daemon [1]:
> > > >
> > > > $ qemu-storage-daemon \
> > > >     --chardev socket,id=3Dcharmonitor,path=3D/tmp/qmp.sock,server=
=3Don,wait=3Doff \
> > > >     --monitor chardev=3Dcharmonitor \
> > > >     --blockdev driver=3Dhost_device,cache.direct=3Don,aio=3Dnative,=
filename=3D/dev/nullb0,node-name=3Ddisk0
> > > > \
> > > >     --export type=3Dvduse-blk,id=3Dvduse-test,name=3Dvduse-test,nod=
e-name=3Ddisk0,writable=3Don
> > > >
> > > > [1] https://github.com/bytedance/qemu/tree/vduse-umem
> > >
> > > Great, would you want to post them to the Qemu?
> > >
> >
> > Looks like qemu-storage-daemon would not benefit from this feature
> > which is designed for some hugepage users such as SPDK/DPDK.
>
> Yes, but maybe for testing purposes like here?
>

OK for me.

Thanks,
Yongji

