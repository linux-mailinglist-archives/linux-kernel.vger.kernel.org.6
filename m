Return-Path: <linux-kernel+bounces-277225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58199949E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EA91F23546
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B7D18FDAA;
	Wed,  7 Aug 2024 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ICOhlAw2"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF7B667
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000388; cv=none; b=CGvyqE4uvqxc/CaYxQF7jGxdXb3mCpDpjGzIcsKVI7BPy4oHIHveM/6OUKYnaa51PyTQ0K8QdkBV72s4zTFEj1sEUY2bVdJpk0rkOEqgNnKQVzPxB+wx/Wv1kP8HA6xVPHm5el/UT1/E4UKuvHCmB/yZI2ePGeF0ZZMdCLYl+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000388; c=relaxed/simple;
	bh=xaQ1xx804zmmT6k8P4w2SxhLejss7sGRBDEAdumyleo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPK1CFhAy4xcqYeZHFTqwfBbDQAOoOA8r7981BzVs4QdNFzJIgMFEfDQ+DZdRgmL8nBLZ17rIH6PqjyQTn2y0grZSkpnQvUJbrzpA9OvkZSAvWvYF5RA76nzWDc5kufpEbLZnOZmFW5+MUNk+W+cjDhQycySx/S6UITBJJXf88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ICOhlAw2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cb56c2c30eso341105a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 20:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000387; x=1723605187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaQ1xx804zmmT6k8P4w2SxhLejss7sGRBDEAdumyleo=;
        b=ICOhlAw2VZER5PTQiJA386sJnVdj2LNER8dm1/gduL7fAVZsycIoBJ5ghlNqRmHWk/
         LopUi73wehK9EK3XSdpvJPNwTLUfKR/lm1REVbvm47ua00fdhq0ifNUzYTrXelaGuvQK
         lP8BwJnxuGbLoyXwDAcyjglCpLFNGvzIj9ezoIfrnSrZysaSNpEMOLg+q8avNG0GZ+9Q
         8T9uYKDAF+nHfQ+Dc7IDk/9T+Gu6k9FdfUA1exJN9mP0c/3N8x2a+MgoTgESBnQbey9p
         S7bR3P0thmSZCJZLVgtdDIV+19TMhlcYuHTDL4oQLzN3sobL4lJVPX6hsSJrnFyNJ3YN
         NN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000387; x=1723605187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaQ1xx804zmmT6k8P4w2SxhLejss7sGRBDEAdumyleo=;
        b=km8Gek42ECu2L/e0u4YfuI/7IaIFyP9p2LF3K6GUXN1F9vyyvVYrS/WTAnuG0rjOIT
         haHf+eMbYv1WyXM7756hUveW9ni67mxZsjnMUjSbq9o7A+5h3Uopg+kDQ31j41W0dt82
         v1uETHYPQOV4DAoYxzu6z1QwrcXHxFC1Zby2UfGTihWyWqxSXK1u/n9HNKlLRw/SlALY
         1ibOGpdO8RDvXp50771v2hvdBlMAjjZ3YJYfftIqIag+L6z4psGFmDRigfNlfU13pP1v
         gGgFWFTSA6HajQ1WqmnWf7fhG8tbFATfW+3t60k5wfy2mb2sI6AoHZzpU+EP3BEnPXfb
         KhPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiAyjJE5zmoZVb2w7mc5DpvMskUoSsmrtp5h/sGR3csWARyRjVkNOaERFOLH1hdJhcE9LuWoLDFkk8IIXr6IC5drKJlbLbBL+1/k+P
X-Gm-Message-State: AOJu0Yx0G06/m7G3+gTbcaySe6WZ1yU3r+0rOwnFMBlbpLEjsC1vJP/2
	DJ1SR1zas5LMl2OeZjEtymwzjAVMaAzVa7cLhSbB5pe8VybxtNacTgVGW1KA5mgS1AUP9ulz+Mw
	hPANuA5vZyqIlRzHCXrRwbA93ibSYqEr2VrNC
X-Google-Smtp-Source: AGHT+IH6TlONK/WU93+n550n6Q8wcSxTGK3Y8m7QMq+WwFosN5Gr5xEQ/ZLnf1CtFKEDOXWoK+IwxNE+go/HAnDIadk=
X-Received: by 2002:a17:90b:228a:b0:2c8:4250:66a7 with SMTP id
 98e67ed59e1d1-2d1b2d06658mr1306455a91.1.1723000386713; Tue, 06 Aug 2024
 20:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
 <CACycT3sz-OOKKcmH=FgD7gp_Bhi9=nwnkTn0VgRhQBxS2Dp4qw@mail.gmail.com>
 <CACGkMEs4YWr5zu0_nVCvqLSFBG9U_A_mw+7AdkMwrPo_6X-gOA@mail.gmail.com>
 <CACycT3vYF3nwZ3k5_8G=Zok9c4qRjCcGLVQ7+RfSpK=5PToMuA@mail.gmail.com> <CACGkMEue9RU+MMgOC0t4Yuk5wRHfTdnJeZZs38g2h+gyZv+3VQ@mail.gmail.com>
In-Reply-To: <CACGkMEue9RU+MMgOC0t4Yuk5wRHfTdnJeZZs38g2h+gyZv+3VQ@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 7 Aug 2024 11:12:55 +0800
Message-ID: <CACycT3sHT-izwAKzxAWPbqGFgyf82WxkHHOrp1SjWa+HE01mCg@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 10:39=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Aug 6, 2024 at 11:10=E2=80=AFAM Yongji Xie <xieyongji@bytedance.c=
om> wrote:
> >
> > On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@bytedanc=
e.com> wrote:
> > > >
> > > > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > > >
> > > > > > Barry said [1]:
> > > > > >
> > > > > > """
> > > > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. Becau=
se
> > > > > > __GFP_NOFAIL without direct reclamation may just result in a bu=
sy
> > > > > > loop within non-sleepable contexts.
> > > > > > ""=E2=80=9C
> > > > > >
> > > > > > Unfortuantely, we do that under read lock. A possible way to fi=
x that
> > > > > > is to move the pages allocation out of the lock into the caller=
, but
> > > > > > having to allocate a huge number of pages and auxiliary page ar=
ray
> > > > > > seems to be problematic as well per Tetsuon [2]:
> > > > > >
> > > > > > """
> > > > > > You should implement proper error handling instead of using
> > > > > > __GFP_NOFAIL if count can become large.
> > > > > > """
> > > > > >
> > > >
> > > > I think the problem is it's hard to do the error handling in
> > > > fops->release() currently.
> > >
> > > vduse_dev_dereg_umem() should be the same, it's very hard to allow it=
 to fail.
> > >
> > > >
> > > > So can we temporarily hold the user page refcount, and release it w=
hen
> > > > vduse_dev_open()/vduse_domain_release() is executed. The kernel pag=
e
> > > > allocation and memcpy can be done in vduse_dev_open() which allows
> > > > some error handling.
> > >
> > > Just to make sure I understand this, the free is probably not the big
> > > issue but the allocation itself.
> > >
> >
> > Yes, so defer the allocation might be a solution.
>
> Would you mind posting a patch for this?
>
> >
> > > And if we do the memcpy() in open(), it seems to be a subtle userspac=
e
> > > noticeable change? (Or I don't get how copying in vduse_dev_open() ca=
n
> > > help here).
> > >
> >
> > Maybe we don't need to do the copy in open(). We can hold the user
> > page refcount until the inflight I/O is completed. That means the
> > allocation of new kernel pages can be done in
> > vduse_domain_map_bounce_page() and the release of old user pages can
> > be done in vduse_domain_unmap_bounce_page().
>
> This seems to be a subtle userspace noticeable behaviour?
>

Yes, userspace needs to ensure that it does not reuse the old user
pages for other purposes before vduse_dev_dereg_umem() returns
successfully. The vduse_dev_dereg_umem() will only return successfully
when there is no inflight I/O which means we don't need to allocate
extra kernel pages to store data. If we can't accept this, then your
current patch might be the most suitable. I will test this patch
first.

Thanks,
Yongji

