Return-Path: <linux-kernel+bounces-260170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3875093A410
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFEDD283F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36BF157485;
	Tue, 23 Jul 2024 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTISJtjp"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B85156F5D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750230; cv=none; b=mDw/mYkGu0U4k/yy6vA1QJUbc/ZsB9sdEJl1vZoqMDAH4/AJPXcYJdpYmo+xTnlhLk8LeKxc8vF191OPpV3NI11u3lBIi39f1muAIPCwg6n7hqvgOhZNiZxzT+qx1d34ohcIx4zHHoh63NVlBOSJ2r3WskxiIRxiRe/2qKmGiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750230; c=relaxed/simple;
	bh=XKovT7iXHAaJZTOYpa7EZH7Y/uRCdYa1p37E8B9LNKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSq0i0x2HhIWdO6/27JQr/Nr1pt8nFyJxgeu/qSeuPSnZR5l/Tk1xGO5bXH90K2pI8Oe4YlSvU84iSMTW1MlvYz2l12MXQIx8ZPxr1fFr3h+fGUnqWU8AkvxHtrN2xFEXEV26Z669Oni72n14f/hSu5nXrSZ43wYYHMrNwckFck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTISJtjp; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e026a2238d8so5402083276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721750227; x=1722355027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsozLdOKEc1rJbozqYDJV6yGo9TFrqFfGRl3ajV39QQ=;
        b=NTISJtjpRTwuweuDtY3dTNNLQOFNp7i8mkRkbkDR/qRGcnRS0k3kPDXGWwf9ngZiiK
         U2KVA+vVSyvEeVsx8JBpce7ffsXuU/m+3w5khux9iphc1GrOzj5p93+lLjjjImniuzZb
         fHzDLDxd1n5+oJIUDnYwO4oPXdFyNbUsoZV6JoHeDk/zO9x1oR4dKhWh1iIsEIhyGTMd
         U36CcEU79549jnOW7e3GTjrRAII8GgBozg0FuIeE5VL6kLzv6KM0gWsrbgrnuT2TAVEr
         kO0+Wad8be7N60gSsfcAkk3HAq95fe7L0V+tTevuTwwFBr1Cj1cerG4dEp/NB+YPx30v
         pytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721750227; x=1722355027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsozLdOKEc1rJbozqYDJV6yGo9TFrqFfGRl3ajV39QQ=;
        b=sQPwupK2HFmCc3mEu2NbiAYM6xAqAItQLDu+59zyBP4+QvgRwN3Wg+Q0CVi7UEK9Mb
         dOZTIVxNHXxjyjMBRF+4ANwqeEyjrhjSEbIQJUYwjGfa/14J/ZSXlWh4PtObYTx7bBim
         9f+xU9GBbdBUp3esKSOLm4jGqGhlK4wGNJBJMpX3l7hidT/VWi0EC8LISFq+YcG3NPFb
         Wo2pOsYIw2PsUxyQsGEuiZnJCAVJSxiyBSpI4E7rHGtnIHCnAdOsekUs63NHLAdMKHf9
         Kt1afdcMJCPGFpPbGeLxOmb6XbcAYMddQIfk2z2YQYMv5NfuO3s0E8o1QhjTss3u6ksf
         xHjw==
X-Forwarded-Encrypted: i=1; AJvYcCVL2WErLaLbFRs5UL2rUTAZ1QSWwjBbvILNltCcHSN+0zChr+hurc7t3b7TqHgK4tqn53/8fbCGOPg7Eg3MsisLZU1lqX/Qk9P7GAaD
X-Gm-Message-State: AOJu0YwIDMVlfyEE/1Xwhdksrt/EmXWpFgeAkrLMs6i71FYFPCweTGAA
	AItr2rQ7Z+eXP69im8Gt3VmZLJotneufaddUKSPOvsICxEpLck/gVoH+Fj2T8DSppjgWOYNNnoT
	hoAjc7ZudbqO6FYf+gh8Ce0mFJoQ=
X-Google-Smtp-Source: AGHT+IEldix2rEiojme8rV7Ae+HFJbZ+tCueg7NNkQRBj8Evx8Jy7newor7fLsSdkdGM3x1Jfl4XbsJvTQSodJhkD1M=
X-Received: by 2002:a05:6902:2b8d:b0:e02:b720:3b2b with SMTP id
 3f1490d57ef6-e0b09719a11mr275127276.14.1721750227410; Tue, 23 Jul 2024
 08:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720044127.508042-1-flintglass@gmail.com> <20240720044127.508042-2-flintglass@gmail.com>
 <CAJD7tkbf0Sc6Q3KyFzG8jRB3Z0D3iiBYiXkjkCix3gy=PctZyQ@mail.gmail.com>
In-Reply-To: <CAJD7tkbf0Sc6Q3KyFzG8jRB3Z0D3iiBYiXkjkCix3gy=PctZyQ@mail.gmail.com>
From: Takero Funaki <flintglass@gmail.com>
Date: Wed, 24 Jul 2024 00:56:56 +0900
Message-ID: <CAPpodddhvAzyAgwW4ZE+-OTx=mLL4Z0iD=Jf=ZTCFZbRM1b3rQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: zswap: fix global shrinker memcg iteration
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8823=E6=97=A5(=E7=81=AB) 15:37 Yosry Ahmed <yosryahmed=
@google.com>:
>
> On Fri, Jul 19, 2024 at 9:41=E2=80=AFPM Takero Funaki <flintglass@gmail.c=
om> wrote:
> >
> > This patch fixes an issue where the zswap global shrinker stopped
> > iterating through the memcg tree.
> >
> > The problem was that shrink_worker() would stop iterating when a memcg
> > was being offlined and restart from the tree root.  Now, it properly
> > handles the offline memcg and continues shrinking with the next memcg.
>
> It is probably worth explicitly calling out that before this change,
> the shrinker would stop considering an offline memcg as a failure and
> stop after hitting 16 failures, but after this change, a failure is
> hitting the end of the tree. This means that cgroup trees with a lot
> of offline cgroups will now observe significantly higher zswap
> writeback activity.
>
> Similarly, in the next patch commit log, please explicitly call out
> the expected behavioral change, that hitting an empty memcg or
> reaching the end of a tree is no longer considered a failure if there
> is progress, which means that trees with a few cgroups using zswap
> will now observe significantly higher zswap writeback activity.
>

Thanks for the comments.  Dropping the comments and changing the
commit message to:
    The problem was that shrink_worker() would restart iterating memcg tree
    from the tree root, considering an offline memcg as a failure, and abor=
t
    shrinking after encountering the offline memcg 16 times even if there i=
s
    only one offline memcg. After this change, an offline memcg in the tree
    is no longer considered a failure. This allows the shrinker to continue
    shrinking the other online memcgs regardless of whether an offline memc=
g
    exists, gives higher zswap writeback activity.

These issues do not require many offline memcgs or empty memcgs.
Without these patches, the shrinker would abort shrinking too early
even if there is only one offline memcg or only one empty memcg. The
shrinker counted the same memcg as another failure in every tree walks
and the failures limited writeback upto 16 pages * memcgs.

