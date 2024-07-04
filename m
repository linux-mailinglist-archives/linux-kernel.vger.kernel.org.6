Return-Path: <linux-kernel+bounces-241628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ED6927D47
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450ED28657C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E513C6EB7D;
	Thu,  4 Jul 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WPenTTn9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066B2F23
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720118785; cv=none; b=Bue7KNfuaoX+aKxrx9pUNz1d44+ddYLIpJ4leGH0o+GKYou+XtMgriDvoQB1uameGSOu4qYWSvBH5pIQR9VsTArxK74fKvRffm7Srt0fa7FA95l1GJrThaEfraJe9fqZceO2t2mk/MGS086XPi/gySPrk3NBEmrjIrRNjAvLXaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720118785; c=relaxed/simple;
	bh=8FtfN25VtIpqkmuAv1r85c76ifFO8quwE7NlLjM4ZrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0m03Tea6KGaNqn6nyGVy0Ty127cqxUcTuYB3WwNsPGw//f0GlmMINQdup9aDoBur384DHQbkH7aagDakjCs+Vh4kmJuLaRb3026V1EyoXA8bmTIIqNLjYjPC9vtQkDyfICGazNeSzjgVs3frfZLG92yHvCVcQO8RBFsuDyIC9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=WPenTTn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA5CC3277B;
	Thu,  4 Jul 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WPenTTn9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720118782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/Nv1KivCfwlZSCJl58egOqfaldzYBwvY47IH/Tz5tE=;
	b=WPenTTn9Nj394iIL8LMp8/Ul1ircQWqRCu8ONpUIW/1oHSxxFE+Yugh3JJNMjQyJ1xA45v
	3JGI5barUPlurkJR1bibBWu/rfZ9yjDfR1ADqDyymnNX/Rw/L3I7FsHGQ6fQJGb3wgUT5N
	DqzClvePeRoM1GOxsir4rmiiKQG+Bf0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 75959b70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jul 2024 18:46:22 +0000 (UTC)
Date: Thu, 4 Jul 2024 20:46:20 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com,
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: deconflicting new syscall numbers for 6.11
Message-ID: <Zobt_M91PEnVobML@zx2c4.com>
References: <ZobXdDCYBi8OM-Fo@zx2c4.com>
 <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com>
 <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
 <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
 <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>

Hi Linus,

On Thu, Jul 04, 2024 at 11:35:12AM -0700, Linus Torvalds wrote:
> On Thu, 4 Jul 2024 at 11:18, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > See what my argument is? I suspect _strongly_ that this is all
> > completely over-engineered based on theoretical grounds that aren't
> > actually practical grounds.
> 
> I also have a separate suggestion: I'm more than happy to do something
> *MUCH SIMPLER*.
> 
> If people want just generation counts, we can give them generation

I addressed this in the cover letter:

| How do we rectify this? By putting a safe implementation of getrandom()
| in the vDSO, which has access to whatever information a
| particular iteration of random.c is using to make its decisions. I use
| that careful language of "particular iteration of random.c", because the
| set of things that a vDSO getrandom() implementation might need for making
| decisions as good as the kernel's will likely change over time. This
| isn't just a matter of exporting certain *data* to userspace. We're not
| going to commit to a "data API" where the various heuristics used are
| exposed, locking in how the kernel works for decades to come, and then
| leave it to various userspaces to roll something on top and shoot
| themselves in the foot and have all sorts of complexity disasters.
| Rather, vDSO getrandom() is supposed to be the *same exact algorithm*
| that runs in the kernel, except it's been hoisted into userspace as
| much as possible. And so vDSO getrandom() and kernel getrandom() will
| always mirror each other hermetically.

random.c has a long history of exposing lots of particulars that we've
had to stub out. Enough of that. It's far better to have a function (not
a piece of data!) that uses the *exact same algorithm* and hence has the
exact same guarantees as random.c, and the kernel can keep those in
sync.

Jason

