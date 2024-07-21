Return-Path: <linux-kernel+bounces-258356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974139386BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 01:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51E21C20BA2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 23:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732CA17580;
	Sun, 21 Jul 2024 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IFHHVyrB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A510A3E;
	Sun, 21 Jul 2024 23:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721605946; cv=none; b=eQ9lXWitszxjUj90lwIqcoeBC7pk9BzNqAJzXjpaJFzJXay2CTkDgj/+fF3/y3601LydpuAl/AHG5fVcLOyLqxtetL8Z8yEEkpJPSEAOOEOS1Oi1IkK7i3RCfBAQ2Y+IqrhSkiRXU6cWx8k+PaGkOLaFLyFxQgJ1d7Wpv2A0Qzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721605946; c=relaxed/simple;
	bh=KxMTnc8TNTJfNow8Y7mDS2xZRZW1V+IfdhJLio4bu5o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TmB5MMO8ndu/LU4YFirio5o0BTgRw59bUzSkTJgOP2DusO353RBRnVPdCcTLmWYiQT1lZq06ZC2RO3fMOLuOIuIqyYr2bMU71I6g4StKZmRELX8MZhgthkzAiNjlucLFEpIOiiT3v9qRLjChg4Vxa3kT2bRfI9Z2VvMwSDawahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IFHHVyrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082C3C116B1;
	Sun, 21 Jul 2024 23:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721605946;
	bh=KxMTnc8TNTJfNow8Y7mDS2xZRZW1V+IfdhJLio4bu5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IFHHVyrBZVgf/p621BVefeLQrnQ64RotmK0Nhxzner6OkIaLDr0yQFQu82Fnjr4N+
	 s7zo5wmscV8l9nU2Fnf8zgNzWUhX5k1ciaC7LHt6iwBacgB1CDaYL5qzHrQxKsLslN
	 scqGayGbbxI6LSnclAm1Yh1GbCvToDD3Jruzolho=
Date: Sun, 21 Jul 2024 16:52:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] MM updates for 6.11-rc1
Message-Id: <20240721165225.0c96cdf1a51bcd7630b0afdc@linux-foundation.org>
In-Reply-To: <CAHk-=wjpx6uTAvjNnD5eipGjNYcwTgG9G6Dct=eLTfyzaaTy_g@mail.gmail.com>
References: <20240721145415.fbeb01a853962ef91334f3d1@linux-foundation.org>
	<CAHk-=wjpx6uTAvjNnD5eipGjNYcwTgG9G6Dct=eLTfyzaaTy_g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jul 2024 16:19:42 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 21 Jul 2024 at 14:54, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > - 875fa64577da ("mm/hugetlb_vmemmap: fix race with speculative PFN
> >   walkers") is known to cause a performance regression
> >   (https://lore.kernel.org/all/3acefad9-96e5-4681-8014-827d6be71c7a@linux.ibm.com/T/#mfa809800a7862fb5bdf834c6f71a3a5113eb83ff).
> >   Yu has a fix which I'll send along later via the hotfixes branch.
> 
> That commit "875fa64577da" does not exist. I think you are talking
> about commit bd225530a4c7, which is in 6.10 and came in from your last
> hotfixes pull.
> 
> I'm assuming 875fa64577da was some commit ID it had before getting
> rebased or something?
> 
> I'm also a bit confused about why you mention this, since neither the
> cause _nor_ the fix are in this pull request and you have the wrong
> commit ID.
> 

Yes, right, sorry.  "mm/hugetlb_vmemmap: fix race with speculative PFN
walkers" was promoted into mm-hotfixes after I make this note.

Anyway.  We broke a thing and it's being fixed.

