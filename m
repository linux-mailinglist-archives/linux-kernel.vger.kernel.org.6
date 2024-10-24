Return-Path: <linux-kernel+bounces-379164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C19459ADAE8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C923B21FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512B016DC15;
	Thu, 24 Oct 2024 04:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mCKAxFZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8245622EED
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744099; cv=none; b=O+24QyvzbryICrvv81Cw018ChB2c1Kij6cA+hUvae3nSSxUbJL51v+rm4HL9dQG6yVG/XX3r1o0QxVvN01Afwy/6LEeCocEYERpQg0Qr4CHuv7ztZZSEe3fKwW5Rtw/5+uSQTlYRj0Z1dR358MooSsl5lnKjYq/Z6GnJ2JjOElE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744099; c=relaxed/simple;
	bh=9Y8fehWYSHeffdmkxHbgl4Yj9Og3vVXUiE8wnyBHuvI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QRCN3dqJx3d9+VZUawZ9DFnU1d6qh6QeY9uqllF+dyPuEtG7r6+YqcfdE91UrDnM9pDJLTiyIavj3+q0hXacWN3/T4ai1UTmYWhYeRmT9kogl6b008pgAlLAdYcG+FPwwWd5a5iaPASuYZVBpAH7WzL/1aA3UToCtl0HaFGJQg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mCKAxFZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D20C4CEC7;
	Thu, 24 Oct 2024 04:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729744097;
	bh=9Y8fehWYSHeffdmkxHbgl4Yj9Og3vVXUiE8wnyBHuvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mCKAxFZX/vcnmvtUX32MZ+ArfbWhLMv12FL1o3XJPD5dIy3IKIfysZqCYZOYrfoh7
	 n31qQywn5JhHER69+D+WlMqIRh8BXXnP5KQ57ld7iTtyCTL8oP4U6mciFdj6sfGCbN
	 kD8WCKav+mwpBmEtMaje8ZfNh+PtP/QXMrzpCMIw=
Date: Wed, 23 Oct 2024 21:28:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: cunhuang@tencent.com, leonylgao@tencent.com, j.granados@samsung.com,
 jsiddle@redhat.com, kent.overstreet@linux.dev, 21cnbao@gmail.com,
 ryan.roberts@arm.com, david@redhat.com, ziy@nvidia.com,
 libang.li@antgroup.com, baolin.wang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] hung_task: add detect count for hung tasks
Message-Id: <20241023212815.240844bdf83e4dc17b66b88c@linux-foundation.org>
In-Reply-To: <CAK1f24mGk4pCqf37zXaZbqbTOzLVBqRNnGmf4wEUA9MGYFGoig@mail.gmail.com>
References: <20241022114736.83285-1-ioworker0@gmail.com>
	<20241023190515.a80c77fe3fa895910d554888@linux-foundation.org>
	<CAK1f24mGk4pCqf37zXaZbqbTOzLVBqRNnGmf4wEUA9MGYFGoig@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 24 Oct 2024 11:28:01 +0800 Lance Yang <ioworker0@gmail.com> wrote:

> Hi Andrew,
> 
> Thanks a lot for paying attention!
> 
> On Thu, Oct 24, 2024 at 10:05 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 22 Oct 2024 19:47:34 +0800 Lance Yang <ioworker0@gmail.com> wrote:
> >
> > > Hi all,
> > >
> > > This patchset adds a counter, hung_task_detect_count, to track the number of
> > > times hung tasks are detected. This counter provides a straightforward way
> > > to monitor hung task events without manually checking dmesg logs.
> > >
> > > With this counter in place, system issues can be spotted quickly, allowing
> > > admins to step in promptly before system load spikes occur, even if the
> > > hung_task_warnings value has been decreased to 0 well before.
> > >
> > > Recently, we encountered a situation where warnings about hung tasks were
> > > buried in dmesg logs during load spikes. Introducing this counter could
> > > have helped us detect such issues earlier and improve our analysis efficiency.
> > >
> >
> > Isn't the answer to this problem "write a better parser"?  I mean,
> 
> Yeah, I certainly agree that having a good parser is important, and I'm
> working on that as well ;)
> 
> > we're providing userspace with information which is already available.
> 
> IHMO, there are two reasons why this counter remains valuable:
> 
> 1) It allows us to easily detect hung tasks in time before load spikes occur,
> using simple and common monitoring tools like Prometheus.

But the new sysctl_hung_task_detect_count counter gets incremented a
microsecond before the printk comes out.  I don't understand the
difference.

> 2) It ensures that we remain aware of hung tasks even when the
> hung_task_warnings value has already been decreased to 0 well before.

That makes sense, I guess.  But fleshing this out with a real
operational scenario would help persuade reviewers of the benefit of
this change.

So please describe the utility with full details - sell it to us!

