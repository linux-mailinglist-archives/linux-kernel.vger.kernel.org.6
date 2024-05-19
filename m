Return-Path: <linux-kernel+bounces-183213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFB98C95F5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 20:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964E11C208FB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EE15FEE5;
	Sun, 19 May 2024 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MoXRLGv4"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDB6D1B9
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716145038; cv=none; b=lHdSLHP65XKqprBAyfzyuhWTeBASs6zBnHztcWPlICLw7TPe45UlNulLYL9gKbbzdCWNTNFSvhsHr2d+nIXuDhCVAYRmK3vjYYmGev6cAQ0Ij6KHu8z64soV68n+8sUGNjq6Eu6jEDaxD7MGnnbUeo7uJiZMXPqjLSRJTl4JE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716145038; c=relaxed/simple;
	bh=HCDGXHWYGuug0vB2TJuSEuYHOYHvebMr845YY7RWV9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FarDUV0CAznRNneeneSvjG2yClhMfBp0mUxIyXi3+C9Wm1kNm1Oe1e15v/uw0OSjN+99kqar3Ho/rtAQ6tHbkbHK1aseKBUOa59R5pfH5qb+AvSOyviXzUXXMhtoxlNUUTVUkN7Ff7gxeG8N/k6qNyaA+4kEWLXfbb+t52mZO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MoXRLGv4; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e538a264e0so46113121fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 11:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716145035; x=1716749835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iY9tQ/lw2tptEzAdBZnuUzlK61qi/54gCaWIsbKgyvQ=;
        b=MoXRLGv4hJqacADGcZtfcr6gCI6yhhuxbHDgara8kHCA6xckYNCpbBTwhRl61nyuGs
         O5m6ynqRSQdJJbGphtbyNeX/oROXj+OZcDdKuoXekumSpwal3ftElaWej1H4akAAIEZF
         bXeUYO69YkZDtpenpNrj0ZfU5up/LKXFxaLFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716145035; x=1716749835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iY9tQ/lw2tptEzAdBZnuUzlK61qi/54gCaWIsbKgyvQ=;
        b=EO0xHJQTSyi9fQNTKahhn3NzZAVByBsAgSZFvkWCrP7aFP2biECq4kCxsyYVR6FZzt
         NcADDtwQrV/fJsr5pvKyKPk58OkA1YxAqimKVWIOiBVwyVHj4WYdFLm+B0OsZnqsj2G3
         JLxUVdGNIwE4hojZ2U4QLFKhJ4tGMnTNwPHGjh6JAzrIT5uagY2yz5nfSVunRwyAtS3w
         uAkNEqrKTn5MkCR8vceK/WB86PhTEjQjCD1fEXsOrPrP1K2gawcYL9nHMS2TpErFN3op
         gN3eVI8CqksCy/S62X+bhseBEK8xiTg8lolWcOs/Lcq9BG+lQ7ZQSaymtfvncmn9gthQ
         wU4w==
X-Forwarded-Encrypted: i=1; AJvYcCUiiTuPGWYX3OHyPTOnv3KmUDuSCLKJsvNoNCd2O0R68B2gy1EJCUKGTdUaE4nu6vmDhAKpwBTuHsiI2zlJVUyKaX9jOX6+MP6VXoW6
X-Gm-Message-State: AOJu0YzP4J66paQZqRFDmm7bXLgS/1SPEF/xbobS6+Y+xOyiK2HHO0xg
	Muz3i4Nj966dCAIdqujwkHLRDujnkRjlMXwtS3RKMw2eQwBJZlboOmipTe2NYufEgzVnScKkrXF
	rQhL0Zg==
X-Google-Smtp-Source: AGHT+IEoAZKQsW5TQ+Jz9pr7izo0vFNObjMhnLtb/AnzgMPQ8kCaNni1FhXknIaVtIfxNl71AeI6jQ==
X-Received: by 2002:a19:ca07:0:b0:518:eef0:45c0 with SMTP id 2adb3069b0e04-5221016b407mr22127094e87.48.1716145034251;
        Sun, 19 May 2024 11:57:14 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d881csm4091433e87.218.2024.05.19.11.57.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 11:57:13 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f71e4970bso4181379e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 11:57:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVo4sjE8TUl8EsBbo7JeXmUNOhW/sYrArGETEVbAflO7hckdCNeZxGzFzbwnOBchJzRqHkKyrU72yKMKREolZvBXvuGwGwdFeLjNwVH
X-Received: by 2002:a05:6512:3b0d:b0:521:5583:483c with SMTP id
 2adb3069b0e04-5221016b3e6mr28495387e87.54.1716145033039; Sun, 19 May 2024
 11:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517192239.9285edd85f8ef893bb508a61@linux-foundation.org>
 <CAHk-=whEAquncw0wb59-XVAHmVh4CWSfwuWh4bTJjJzvx0=PzQ@mail.gmail.com> <20240519113639.db3fe5f80d25be4e7666751e@linux-foundation.org>
In-Reply-To: <20240519113639.db3fe5f80d25be4e7666751e@linux-foundation.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 19 May 2024 11:56:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiy+25i1VZhDaV-b_m4aXGNELuVok9Prv4=oYqiun--rg@mail.gmail.com>
Message-ID: <CAHk-=wiy+25i1VZhDaV-b_m4aXGNELuVok9Prv4=oYqiun--rg@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.10-rc1
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 May 2024 at 11:36, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> This is me advancing the master branch once per week until we hit -rc4.

Yeah. You really shouldn't do that with a merge commit.

If what you want to do is just advance the master branch, you should
just rebase on top (if rebasing is what you want to do).

Instead you seem to merge _and_ then rebase. So you do the worst of both worlds.

You don't get the history cleanup of rebasing, and you don't get the
history preservation of merging. You do both, and it's wrong.

> I don't understand why these merges were visible to this pull.  I sent:
>
> : The following changes since commit 5d1bc760583f225032f91bd88853f4c26acaf4e0:

No. That is NOT how git works.

You claiming to send only the changes after a commit doesn't magically
make the history that precedes that commit go away.

With git, when you send a branch, you send the WHOLE HISTORY. That is
fundamentally how git works. You trying to change the "from this
commit forwards" doesn't actually change anything at all, it only
changes the wording in the pull request itself.

You can't just do a pull request and try to say "only send changes
since this commit".

Git is *not* the broken sh*t that you have used before that is just a
queue of patches. Every single commit carries the whole history that
leads up to it.

And that is fundamental (and is fundamentally why patch-queue based
stuff is broken garbage), because proper history is what makes merging
work and scale. It's pretty much what makes git not CVS, or the horror
that is darcs and "patch algebra".

So when you do a pull request, the whole history is always visible.
You can't make it not visible.

> This has worked OK before,

Your previous histories haven't had those broken merges in them, so
your previous pulls haven't had them either.

I don't know what you have changed in your setup, but your "advance
the master branch once per week" process is completely broken.

The problem isn't the pull request. The source of the problem is
something in your "advance" scripting.

               Linus

