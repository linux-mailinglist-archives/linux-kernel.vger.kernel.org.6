Return-Path: <linux-kernel+bounces-277419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF2E94A11F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7451C22F87
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B4A50276;
	Wed,  7 Aug 2024 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LqM6RQEu"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E74A2C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013686; cv=none; b=sklc2+G9aBQRMRvCa2LVmZGP1X0JCjjpYR//1c09IFoo+4PntEjJJ30M2WEludy97STztWtnMOwE3NYSQTFVayL6whfCqvaDcsB7v1/3bbx0Mud8786wU56XLI0PoDxAt9BqFtAbdbgz6kG2MXTJvWDepSO2LBij5KGR/UGtBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013686; c=relaxed/simple;
	bh=as12zI+Vb1l0Pj55ILFIfLmjyxtOWgbytBoWn618izg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hz13T3X3s95LO9NoT6RpmmpIJDZHf/qzbUGDALyfoa6fM4NSnF4WBiepVTIm63S50bdqUCbz9BqORlvd2SrLjTj02s3SX6uWd1kHUtmWlfVgr/IVlPsMJi6dF4ehOPcWmuR/HbXo8icvsUQ1nBFVQjIf9R0+916xk0KIBzqaqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LqM6RQEu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cfdafdb914so1068417a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723013684; x=1723618484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=as12zI+Vb1l0Pj55ILFIfLmjyxtOWgbytBoWn618izg=;
        b=LqM6RQEua8dOzOqX1r7cZVRIy8d0CUfaWhMXDD4fj3rKZPhJ22/kFuyt54k7DrNS/8
         afAIvsr8K9j7lmgATLAjgPPPto8nixMRE43Xa65rV0F/4m3Q5ILaH790vPjRN/aeFLkn
         5eGQ4TkyGoQBbFE2nGmVIlqCveX01LI8l51HzfrIMI39IBNj9NtZwARWe1RauYnABZNL
         0fm6FuojRdpxW2kiBQ/eow2qlzzCaLO/R6lzG5Ct20wGlKSZoKSeTpDVcvAwRntYU+q8
         uMcUf0yEgvBde6Tiw+d0JC0AX28bjbuMN3XbdJioS8qOqe/fqGEqiPdnNop+BXXRSAhj
         GgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723013684; x=1723618484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=as12zI+Vb1l0Pj55ILFIfLmjyxtOWgbytBoWn618izg=;
        b=SXrxCmapxyQENKfotcO6Ie/ogLIWaoZr++k8UBhtkkCPm+e+rpB8zynS3peineLSWy
         P0HordFRY4gkoRWwgjZxnHjKw26bZA3vb88Ca82ou+XDSGpNX2G+3ewUniVQlizeA5Tc
         qN3ro3nSGBCS4mHRTogAC1ncw8i6LvTzR0kE+IfvnJyBfaZ0WhZbunc8C9Gqav9ezS8c
         uui0QYIZ/+9TiuFmYWb91SAGw8povU5tli6n0G7zqzKC/V/ci6hTeuN8UDGXo1ZPu3ZS
         BaWEj+GzunU7NPOJzBTwlmE90lQDDYM2ACXmVH2xpTXWW5h4Kx0UUSDa8F1LI3/+SunU
         91Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUPC9ETstEeoCDnIJUruJM6j8YMNfMSqQSAM+axKyKe2T8e4HT11QP5gm2V+Xf+Ef4kX3zalakEKr1X+f8CfB3TyevO4NUri3Segbc1
X-Gm-Message-State: AOJu0YzLq0M2gD4xtR8uwClt/01X5BCEzywPnC+FboQfRR5fl3cH7rb2
	tPmqykU2GB6s8hG8nkRRWjuh353rEX9O2BEHuLusKGvIfjK4WqPebsE+p2MFoJ161SkHVtIvawM
	WtyzQ5xb4Dy5dnQ8q2k8LnQ6WOqCWBMZ9KBNQ
X-Google-Smtp-Source: AGHT+IG1mNC6LICu7gLhhF26znVEVtku9oIc0f72ydZPb+2TckdQNgA/h+OuyryMx1hoSf1rsaUxrBA3VcdDE/SnwwI=
X-Received: by 2002:a17:90b:4b91:b0:2ca:7e87:15ea with SMTP id
 98e67ed59e1d1-2cff9513044mr16717674a91.34.1723013683684; Tue, 06 Aug 2024
 23:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805082106.65847-1-jasowang@redhat.com> <CACGkMEvNyB_+fHV5aAeCQhebA8aF8+9hnjkjeEzt5bgrVgqw5Q@mail.gmail.com>
 <CACycT3sz-OOKKcmH=FgD7gp_Bhi9=nwnkTn0VgRhQBxS2Dp4qw@mail.gmail.com>
 <CACGkMEs4YWr5zu0_nVCvqLSFBG9U_A_mw+7AdkMwrPo_6X-gOA@mail.gmail.com>
 <CACycT3vYF3nwZ3k5_8G=Zok9c4qRjCcGLVQ7+RfSpK=5PToMuA@mail.gmail.com>
 <CACGkMEue9RU+MMgOC0t4Yuk5wRHfTdnJeZZs38g2h+gyZv+3VQ@mail.gmail.com>
 <CACycT3sHT-izwAKzxAWPbqGFgyf82WxkHHOrp1SjWa+HE01mCg@mail.gmail.com> <CACGkMEvsMQS-5Oy7rTyA5a2u1xYRf0beBHbZ16geHJCZTE0jLw@mail.gmail.com>
In-Reply-To: <CACGkMEvsMQS-5Oy7rTyA5a2u1xYRf0beBHbZ16geHJCZTE0jLw@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 7 Aug 2024 14:54:32 +0800
Message-ID: <CACycT3sfUhz1PjK3Q=pA7GEm7=fsL0XT16ccwCQ2m2LF+TTD7Q@mail.gmail.com>
Subject: Re: [PATCH] vduse: avoid using __GFP_NOFAIL
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, 21cnbao@gmail.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 12:38=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Aug 7, 2024 at 11:13=E2=80=AFAM Yongji Xie <xieyongji@bytedance.c=
om> wrote:
> >
> > On Wed, Aug 7, 2024 at 10:39=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Tue, Aug 6, 2024 at 11:10=E2=80=AFAM Yongji Xie <xieyongji@bytedan=
ce.com> wrote:
> > > >
> > > > On Tue, Aug 6, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Mon, Aug 5, 2024 at 6:42=E2=80=AFPM Yongji Xie <xieyongji@byte=
dance.com> wrote:
> > > > > >
> > > > > > On Mon, Aug 5, 2024 at 4:24=E2=80=AFPM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Aug 5, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > > >
> > > > > > > > Barry said [1]:
> > > > > > > >
> > > > > > > > """
> > > > > > > > mm doesn't support non-blockable __GFP_NOFAIL allocation. B=
ecause
> > > > > > > > __GFP_NOFAIL without direct reclamation may just result in =
a busy
> > > > > > > > loop within non-sleepable contexts.
> > > > > > > > ""=E2=80=9C
> > > > > > > >
> > > > > > > > Unfortuantely, we do that under read lock. A possible way t=
o fix that
> > > > > > > > is to move the pages allocation out of the lock into the ca=
ller, but
> > > > > > > > having to allocate a huge number of pages and auxiliary pag=
e array
> > > > > > > > seems to be problematic as well per Tetsuon [2]:
> > > > > > > >
> > > > > > > > """
> > > > > > > > You should implement proper error handling instead of using
> > > > > > > > __GFP_NOFAIL if count can become large.
> > > > > > > > """
> > > > > > > >
> > > > > >
> > > > > > I think the problem is it's hard to do the error handling in
> > > > > > fops->release() currently.
> > > > >
> > > > > vduse_dev_dereg_umem() should be the same, it's very hard to allo=
w it to fail.
> > > > >
> > > > > >
> > > > > > So can we temporarily hold the user page refcount, and release =
it when
> > > > > > vduse_dev_open()/vduse_domain_release() is executed. The kernel=
 page
> > > > > > allocation and memcpy can be done in vduse_dev_open() which all=
ows
> > > > > > some error handling.
> > > > >
> > > > > Just to make sure I understand this, the free is probably not the=
 big
> > > > > issue but the allocation itself.
> > > > >
> > > >
> > > > Yes, so defer the allocation might be a solution.
> > >
> > > Would you mind posting a patch for this?
> > >
> > > >
> > > > > And if we do the memcpy() in open(), it seems to be a subtle user=
space
> > > > > noticeable change? (Or I don't get how copying in vduse_dev_open(=
) can
> > > > > help here).
> > > > >
> > > >
> > > > Maybe we don't need to do the copy in open(). We can hold the user
> > > > page refcount until the inflight I/O is completed. That means the
> > > > allocation of new kernel pages can be done in
> > > > vduse_domain_map_bounce_page() and the release of old user pages ca=
n
> > > > be done in vduse_domain_unmap_bounce_page().
> > >
> > > This seems to be a subtle userspace noticeable behaviour?
> > >
> >
> > Yes, userspace needs to ensure that it does not reuse the old user
> > pages for other purposes before vduse_dev_dereg_umem() returns
> > successfully. The vduse_dev_dereg_umem() will only return successfully
> > when there is no inflight I/O which means we don't need to allocate
> > extra kernel pages to store data. If we can't accept this, then your
> > current patch might be the most suitable.
>
> It might be better to not break.
>
> Actually during my testing, the read_lock in the do_bounce path slows
> down the performance. Remove read_lock or use rcu_read_lock() to give
> 20% improvement of PPS.
>

Looks like rcu_read_lock() should be OK here.

Thanks,
Yongji

