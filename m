Return-Path: <linux-kernel+bounces-180576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04078C7063
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE28283E74
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB72184E;
	Thu, 16 May 2024 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW2hfUze"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD14436
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715827368; cv=none; b=Mhlnn3dB98M4BaUzQ38XTEHu+V+JQYxuxcKVwwYPJ/zoXPEVrG3GH8dbTKjyMu8PsJ9rROuJ6isUwOScQzcFfDKjww8kqjWVepjtwkA36yZMhtaDK5fmnZ487oSaFGxMnr8jH/qMXO5kDQtb6jgUY5PgyI8GnYB46aCy9FmOxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715827368; c=relaxed/simple;
	bh=o9AeWtsh+6IsmdkZ63Gwb+/SCRFi6vep6KisjPq/2sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JjPKcy2pyeTxXYARNDJpOeOJOI6OqdmSFCKEQJiNh/ufiufqhjC1rl29zhj3eQazSUuyfmeukgnhXXit9yqkEe3d4AdKUTUjlxjDMz8J5B6fYh15Us+0gogfj1xRqd4izZaoYA5hNk1hEzzIOARIF6Gzby6ghF/oFAIs5R6Rhh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW2hfUze; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5709cb80b03so2894895a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715827365; x=1716432165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ3Y2dMNZ0IL+qTVOhLosvaCn1uvPGB+B7vwvyRozAE=;
        b=eW2hfUze98RJobphBdTiiJqR7p2LPoMhLeU59SWXfCfnOaRtsfkSF3FNJE9FhFlnzK
         PwhCbv9wXfHO6ct6oSGRTRwpci4jlB6DbyQIYLYeETXk55noBBZTVa2C7X0KTKjN8CjA
         Tpua+pSlPMik3CcPSub6P4wi6SsDrA8C2LiPPVoe5XFCGXJOLSSmBB8zL8vWY62+1jrT
         s+fvalvHbtvfRzSGpTVCKfJqrYtPMvWfAXNCWmzWxIInA7MtaP063wTap3o+oXp39+KI
         RhaW84Pv1MdqSZcvUS31LiP+0tkIAjoOO7UOnr8yK0SaryKVHNKTqwc5rvJubYWzRvfO
         f6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715827365; x=1716432165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZ3Y2dMNZ0IL+qTVOhLosvaCn1uvPGB+B7vwvyRozAE=;
        b=PIrjkfrqHpubL4uhGQetqtIoVCJBlJoO7Vhpt9y/T/mdRsyzlgpaurRbxSszJCcS2o
         WWOOQ7V5IPg5ddkyWJB6apo3qarXF+MmL3PmW3VViHUXnpU2ENKhB0ciRkcFCcLPXmFw
         XC5w/+wd1O39vheg5wVNaQhqAjRLu7/zyPKziunwfjusRIKzBvyzzog+WN6su2VfEOXr
         Z8mGfCS0fpQhfmE+fDZIm5uCidZSCaqytH/oZU6ur8sO8YfooEq49GWJ7NUE0j+AIXUk
         yZOwrRTg3edJaL+XeJyOxeXHSbFbhVZB6AAwVgUVqYfPJmedBeeaONn4lO15/1zl547X
         DJew==
X-Forwarded-Encrypted: i=1; AJvYcCW8pN7izsB/rXAPXwCfanViIIlW4CeBeNOD6+64reO89VGA92sZ6RwqHqKcBU/Jo5uBwPyFap0GkfljvhPSerbtf3gZaPTi3/iBFh8C
X-Gm-Message-State: AOJu0Yxud4qXFAazwWK9J+ovb3o+cLatyQbqRyQFnVZSKTLdnuMGt58L
	AGPkok/pCNJHW+H718UQsc6HO8/cCw2/KIhOj7hUznxZBxXuhYvNrC3gIMfJEnf4V+wQvzJubWI
	gXzXTCmV0q/XfJdkxloozR61OEKw=
X-Google-Smtp-Source: AGHT+IFD6ir/bb13VxvN5IkaLBRcLudkcqEw8HEMnM4uUaH8EIenkQtK6P8XcYY5L+pJctSgHZVOsWL6kTwzEGtWnpc=
X-Received: by 2002:a17:906:fada:b0:a59:cb29:3fb5 with SMTP id
 a640c23a62f3a-a5a2d572af8mr1125153766b.20.1715827364636; Wed, 15 May 2024
 19:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=wge0et+3PP47OBnNx66Q=i_XgqfGfrSmDGHSyp=Jn-CgQ@mail.gmail.com>
 <CAHk-=whTqHgXZ4Aj8dNO3Peg9Rf0sh2F7zGWRUOmBwfMDxgvbQ@mail.gmail.com>
 <CAHk-=wgWJCcJRLBZ1xoAATFyvp6YKN+qzrePhxQbN1SFrno7pQ@mail.gmail.com>
 <CAHk-=wjm4BcsMrvgXocATBVvZ7N6LAjSvLTzTXWg9EFzyip_cA@mail.gmail.com>
 <CAPM=9twOiwquA7Zi_mr1vKFV4RQqhnbHv+c9Xz6BadF3tGEegw@mail.gmail.com> <CAPM=9tyHnK_ReDmFf0eUGGuvKpXJQ0VWuKKhDqJt89URjOTU_A@mail.gmail.com>
In-Reply-To: <CAPM=9tyHnK_ReDmFf0eUGGuvKpXJQ0VWuKKhDqJt89URjOTU_A@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 16 May 2024 12:42:31 +1000
Message-ID: <CAPM=9ty+FH0wW-vuw3H6jE_qg-PimR7pqSSJDNLgyYO1NC+-XA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 10:06, Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 16 May 2024 at 09:50, Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Thu, 16 May 2024 at 06:29, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Wed, 15 May 2024 at 13:24, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > I have to revert both
> > > >
> > > >   a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> > > >   e362b7c8f8c7 ("drm/amdgpu: Modify the contiguous flags behaviour")
> > > >
> > > > to make things build cleanly. Next step: see if it boots and fixes the
> > > > problem for me.
> > >
> > > Well, perhaps not surprisingly, the WARN_ON() no longer triggers with
> > > this, and everything looks fine.
> > >
> > > Let's see if the machine ends up being stable now. It took several
> > > hours for the "scary messages" state to turn into the "hung machine"
> > > state, so they *could* have been independent issues, but it seems a
> > > bit unlikely.
> >
> > I think that should be fine to do for now.
> >
> > I think it is also fine to do like I've attached, but I'm not sure if
> > I'd take that chance.
>
> Scrap that idea, doesn't die, but it makes my system unhappy, like
> fbdev missing,
>
> so for quickest path forward, just make the two reverts seems best.
>
> I've reproduced it here, so I'll track it down,

https://lore.kernel.org/amd-gfx/20240514145636.16253-1-Arunpravin.PaneerSelvam@amd.com/T/#t

This patch seems to fix it for me, I might just pull it into my tree
and send it to you.

Dave.

