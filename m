Return-Path: <linux-kernel+bounces-431325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169299E3BFA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA583285450
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED0E1CEADF;
	Wed,  4 Dec 2024 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY0ZHjh3"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DA21F7084
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320936; cv=none; b=JnsIQYho9jpDV+RwgSrsVKuaCQgsO2aWRF4MQajHD6/5g8r7hqMPZSn2hRlqDFHDuakhv+NDGLgk0BsWyPQ1HxgaO9Dhq1xLWfddSaA6z9mUjZki72Yfh7ypT9faLGS6CDaUOB74v1UzLHZD9fr6pOHbyeKW//DHuRf+0ltPjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320936; c=relaxed/simple;
	bh=rzqLa6jGCD8QycjIJPd2Pg08jy/GBFipnIUKcz2Soy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ls6IC2Eq3rUP547PpI60yWUra8OnmbYMI9J5984iRjUsSx1gMMNN5VF+kUcrjNudHWDhgYVP+0v+XTsS3SLQNbsGoJFRjs2M/f90krn/liy3VOyYjtVCQrngYvm1ldiZJNa05QV0D32k8qNS4ONDLz5ExHRXTsDz23Az8L2+WgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY0ZHjh3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53df67d6659so10814719e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733320933; x=1733925733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzqLa6jGCD8QycjIJPd2Pg08jy/GBFipnIUKcz2Soy8=;
        b=XY0ZHjh3ieUNSti5KFaTnM+8AD7tTJS3wyULhNd81JmoA0oQeSxCsCMKNEjnDZVA+E
         FG/gPDEuMUYHmHOqK8KYOxX80aY0Dd+rnQK5sjfawPxR0g4hDMJD2b8f6UXtv+jL0oP8
         dQVC9e5fxgIWON0FiEhZt493j3n+6ZyBNtfb4DaSlM4IOmWOaf1FhfAgrPJ30Qa6gKmN
         dwBWYBMGsj4U8FvMCyqUOcpA8EhoNAq6wVv6lv8D8cOMS3BLxj27kwHL/O9gmszuKyJJ
         453bcDUU/Jsjqlddn0WETMQu6ESk86ikEY+pxoWaOC4vJk6YHb5pLV6lZdyv4d9rgZ7D
         M/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320933; x=1733925733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzqLa6jGCD8QycjIJPd2Pg08jy/GBFipnIUKcz2Soy8=;
        b=fbw08RtHdnCH4KWdaWLluxOzdX6xjl+l21zPI/aUy7Q16Gt3P64TvlwHQptRrquiV1
         Zk+Qjr/2UjcnuZpxJaHOKX6siyhpDOKb0PMaKnDC3fseYLWXqGvuelu1NdQnKbv9J4XC
         oQBhLE3us9EEg51HSncuBvtyw4BkmyPQCJHEp4dMdl6fFEVHzqpSxAAJ0VqDUDXDl2Bp
         c/FBVF3ZZ4w43mhsafsZOn7DvmWZClWMi+mdXEZVidv1tNvNFpKQhRt7DmL09xOvDQ0b
         1aV/ByYHB9t+3U/7Ol0+uW8ujxIc+Taa+AawqBrGFYzwh5OHQdVvCftjq6e29bEx6hVM
         dfwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKDro1bhoCo9OX+zIV+UPnHIvr3puAhdV2W3mDkEFUO+ESN9TqO9y/s6SNliR01YshUT+kGV6jWkCj6n0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Qhz0sNb0e4L0cp3S5s0ELAIlgZHIPls9r5fGVbn3/c0ivmjo
	gQNdVmoqCrvg6lmGtbYbPmQj0Jk1x4WIEfO7njjpyHTaggsoJFv+wCF/Fk+veySYKSZq59mYz4J
	iEqIi5JbWVo2puTv5jxm2bN3R8Tg=
X-Gm-Gg: ASbGnctbwAavEtZnMbI/o415W52j52tMP2RVMj3RZZyUexEgxvDgmN3gUaYxZtEuo1f
	kEtOrhArYhw5CJ5BnmJ7BlyA4EWW8N4rP/CkLWbPwmWfbvA9Ai7fo3mOz6fcdDSmO
X-Google-Smtp-Source: AGHT+IG5T5Cs8JlNQpX9NGevIU0NaW5AfdtFmwSwovLMNYsQSOMeXR+EDuBUprx2oFfcxsjk0scugsoVpHS5QKOxq5M=
X-Received: by 2002:a05:6512:138a:b0:53d:e5c0:b9bf with SMTP id
 2adb3069b0e04-53e12a3935cmr5453848e87.52.1733320932363; Wed, 04 Dec 2024
 06:02:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902072136.578720-1-alexs@kernel.org> <0a10e61b-f0e6-4423-996c-7884c93af65f@gmail.com>
 <66d8bd3e.170a0220.18832.0206@mx.google.com> <674e1324.170a0220.377d6f.b6ed@mx.google.com>
 <8f87ec15-9aaf-47bc-9255-5a6ee721552e@gmail.com>
In-Reply-To: <8f87ec15-9aaf-47bc-9255-5a6ee721552e@gmail.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Wed, 4 Dec 2024 23:01:59 +0900
Message-ID: <CAB=+i9TitqVxLBy2PP7sKSx6WQ5F9nOaGhKqXPAk4PLUK49VLA@mail.gmail.com>
Subject: Re: [PATCH v7 00/21] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
To: Alex Shi <seakeel@gmail.com>
Cc: Vishal Moola <vishal.moola@gmail.com>, alexs@kernel.org, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org, 
	senozhatsky@chromium.org, david@redhat.com, 
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:58=E2=80=AFPM Alex Shi <seakeel@gmail.com> wrote:
>
>
>
> On 12/3/24 04:05, Vishal Moola wrote:
> > On Wed, Sep 04, 2024 at 01:04:11PM -0700, Vishal Moola wrote:
> >> On Wed, Sep 04, 2024 at 02:54:14PM +0800, Alex Shi wrote:
> >>>
> >>>
> >>> On 9/2/24 3:21 PM, alexs@kernel.org wrote:
> >>>> From: Alex Shi <alexs@kernel.org>
> >>>>
> >>> ...
> >>>
> >>>>
> >>>> This patchset abstracts the memory descriptor used in zsmalloc by zs=
wap/zram.
> >>>> The descriptor still overlays the struct page; nothing has changed
> >>>> in that regard. What this patchset accomplishes is the use of folios=
 in
> >>>> to save some code size, and the introduction of a new concept, zpdes=
c.
> >>>> This patchset is just an initial step; it does not bias the potentia=
l
> >>>> changes to kmem_alloc or larger zspage modifications.
> >>>>
> >>> ...
> >>>>
> >>>> Thanks a lot for comments and suggestion from Yosry, Yoo, Sergey, Wi=
lly
> >>>> and Vishal!
> >>>>
> >>>
> >>> This patchset could save 6.3% code size, and it's a nice abstract of =
zsmalloc
> >>> memory usage.
> >>> Is there any more comments, or mind to give a reviewed-by?
> >>
> >> Please CC me on future versions. Most of the zsmalloc conversions seem
> >> ok, but I'd hold off on further iterations of the descriptor patches u=
ntil
> >> the maintainers decide on what/how this descriptor will be used
> >> (i.e. our end goals).
> >
> > I apologize for leaving this in limbo for this long. This patchset is a
> > prerequisite to shrinking struct page, so we should get this memdesc in=
.
> >
> > I think it's safe to assume (since we've heard no definitive goal from
> > the maintainers) that in our memdesc world we want zsmalloc + zspage to=
 be
> > similar to how it currently looks today.
> >
> > Would you like to rebase this on the current mm-unstable? I'll re-revie=
w
> > it in case anything changed (and can then give you my reviewed-by).
> Hi, Vishal,
>
> Thanks a lot for the review and kindness, I will try to do the rebase in =
this weekend.

For your information, there is a patch series (not merged yet)
invalidating the assumption
that zsmalloc always allocates order-0 pages [1].

I'm sorry I wasn't able to dedicate more time to this project this year.
Thank you for pushing this forward, Alex!

[1] https://lore.kernel.org/linux-mm/20241121222521.83458-1-21cnbao@gmail.c=
om/

Best,
Hyeonggon

