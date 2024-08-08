Return-Path: <linux-kernel+bounces-279313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E565394BBAC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39DC9B21789
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D918A925;
	Thu,  8 Aug 2024 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gjDr0gbZ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620B918A6AB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114357; cv=none; b=VeoF87ZpCSkmaNDQd8L5ys09atppkB2e2JBlKg6dOqyAix08bfert7sUI7+kXqI22+NK3vkkkz5jqDC6ckEzTKAXusCh255F/1KZ/nw844gK3SFDNaVfu7gn8Y+fy7CkkCJ1mE+HfRaWcs0GOLCycgcty+TzFcTGZ4cMaggYrTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114357; c=relaxed/simple;
	bh=32a7io2SChK8ZRpVpwvY+OWrnTIu/XJXf81hGGeOTAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxnVOOiEMnAn9rSlevU2SisXkGI3pp8hOehvuZkeUeOX6ZDhzs32c5PrAQtINjdV1Cpv1s0DwoeTYJi1bqlE96/RZdezX6VsoVqmHAgTdYpFJieb4MBVWKSLmfU4bl3VqXgHYwbII/5yWqlrNuRUcdC0y3B39wf2x4qrv+qoH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gjDr0gbZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso670160a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 03:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723114355; x=1723719155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZLYjyqauE0XTZU17OzHb00VCoqMdI4Lj7iAwvx9OiM=;
        b=gjDr0gbZ+9eBdXZfGTUHZPOdah6oNu62Qc0ulLO7krPUaVu+uMfFn5TULiyAM1k8O8
         +kKcwyHA/IXRVoZ9VedUugqY3zyaxpCRv2KdwNlCq+Q1SN9hmWaFW7Fzjo1KMvUR7AjM
         uJmHeW86Wnr+VDewASXPReuYl4KEPkfPbJCmDYhWMgJ7SDKnkTHrNYZxerGyDXYpv6F5
         ubkmBFXPjGjjZOu09yEXCPhBcZNY0s8kIzZYougqXUHeXOGeNCHvjq0TMqNA6csYwnVK
         GDUueAlUHv9uf+F6A16U4glQNE05SqXBk1N8mQ0wnyRM9/zTkqnCgAgH2vlpwO1VQUch
         Cmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723114355; x=1723719155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZLYjyqauE0XTZU17OzHb00VCoqMdI4Lj7iAwvx9OiM=;
        b=st82osNXdrzfoAG+n2Z7fJa8gbTItiB6YRG9tZ38rvLCufjPeHSvSvYDYe9EDxxQyS
         e55j24hG1NaX52EBFCCdkD6x/SvizmttQk/0tQpziGygNPSqqH61cUa1ZLASc/PoTBp9
         2tXhc+BftUyPo2QoSH4UBieIYtTlUZTDtBbDepDH5cMXTuFWUW5+2L46pKTun4lBaBeB
         E8nK+jhgx3D9DXiDSJaWaPLBsnGGspGYJxL3dpNt1eg6Kq6AyotbOAPv5AdHdfrOBypS
         7iIRyZvM4TLLM0Z4k8if6IZt1mfT0cuEkSHpiQAySH5ORiZHLc/HoTSf516oWEDU47Vn
         Sotw==
X-Forwarded-Encrypted: i=1; AJvYcCXo0ghVwjPpQoSl+O9I06/Ozqj+ADpRAmmyCXSfE5AaSLrLPDFPVZ6c9J6A7XgEL0bYoFvnoL5jYqTt4Sz2ZbCoKbkLs/SZxjtOFly+
X-Gm-Message-State: AOJu0YxDoCNNMKgVt9EbMUtHHob9u4AQajqbBVW2PgLsRiaThprfz4NL
	JdZtEMYrgVXLg7N4mOEb/KzdeJCMhpHisi2N83EdDCKyphFKeGtuPEjJ/2j6IuAI+WITY79F+TA
	rRNFhTfK5ZwWZIZ57VCUJ4oU2qYhGbYjidMkD
X-Google-Smtp-Source: AGHT+IFcr7xL28cGBaoGPz4X18wYJjgXp6byzUZO/GroOKeF0RdMycw/CywkZwmJsg+D4t4pUbw8contMlYR7PysfzU=
X-Received: by 2002:a05:6a21:6d92:b0:1c4:dfa7:d3ce with SMTP id
 adf61e73a8af0-1c6fcebedfemr1441920637.17.1723114354688; Thu, 08 Aug 2024
 03:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACycT3uM1jSdqFT0LGqy1zXZkWF8BNQN=8EMKYMoyP_wjRtsng@mail.gmail.com>
 <CACGkMEtYE1OY+okxHAj=cVfW-Qz45an28oO=Wv15yOtpD6UqdQ@mail.gmail.com>
In-Reply-To: <CACGkMEtYE1OY+okxHAj=cVfW-Qz45an28oO=Wv15yOtpD6UqdQ@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 8 Aug 2024 18:52:23 +0800
Message-ID: <CACycT3vAv1K0yBKgc_8GBLpEPwASTCCPZYAxMyUROQsyntQdOw@mail.gmail.com>
Subject: Re: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel <linux-kernel@vger.kernel.org>, 
	21cnbao@gmail.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 10:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Aug 7, 2024 at 2:52=E2=80=AFPM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
> >
> > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > Barry said [1]:
> > >
> > > """
> > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Because
> > > __GFP_NOFAIL without direct reclamation may just result in a busy
> > > loop within non-sleepable contexts.
> > > ""=E2=80=9C
> > >
> > > Unfortuantely, we do that under read lock. A possible way to fix that
> > > is to move the pages allocation out of the lock into the caller, but
> > > having to allocate a huge number of pages and auxiliary page array
> > > seems to be problematic as well per Tetsuon [2]:
> > >
> > > """
> > > You should implement proper error handling instead of using
> > > __GFP_NOFAIL if count can become large.
> > > """
> > >
> > > So I choose another way, which does not release kernel bounce pages
> > > when user tries to register usersapce bounce pages. Then we don't nee=
d
> > > to do allocation in the path which is not expected to be fail (e.g in
> > > the release). We pay this for more memory usage but further
> > > optimizations could be done on top.
> > >
> > > [1] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8Z=
Q2saLnUdfOGOLg@mail.gmail.com/T/#m3caef86a66ea6318ef94f9976ddb3a0ccfe6fcf8
> > > [2] https://lore.kernel.org/all/CACGkMEtcOJAA96SF9B8m-nZ1X04-XZr+nq8Z=
Q2saLnUdfOGOLg@mail.gmail.com/T/#m7ad10eaba48ade5abf2d572f24e185d9fb146480
> > >
> > > Fixes: 6c77ed22880d ("vduse: Support using userspace pages as bounce =
buffer")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> >
> > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > Tested-by: Xie Yongji <xieyongji@bytedance.com>
>
> Thanks.
>
> >
> > Have tested it with qemu-storage-daemon [1]:
> >
> > $ qemu-storage-daemon \
> >     --chardev socket,id=3Dcharmonitor,path=3D/tmp/qmp.sock,server=3Don,=
wait=3Doff \
> >     --monitor chardev=3Dcharmonitor \
> >     --blockdev driver=3Dhost_device,cache.direct=3Don,aio=3Dnative,file=
name=3D/dev/nullb0,node-name=3Ddisk0
> > \
> >     --export type=3Dvduse-blk,id=3Dvduse-test,name=3Dvduse-test,node-na=
me=3Ddisk0,writable=3Don
> >
> > [1] https://github.com/bytedance/qemu/tree/vduse-umem
>
> Great, would you want to post them to the Qemu?
>

Looks like qemu-storage-daemon would not benefit from this feature
which is designed for some hugepage users such as SPDK/DPDK.

Thanks,
Yongji

