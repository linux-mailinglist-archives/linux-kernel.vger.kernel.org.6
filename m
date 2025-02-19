Return-Path: <linux-kernel+bounces-521862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79050A3C34C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0327C175401
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74E91F63E4;
	Wed, 19 Feb 2025 15:13:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9441F462B;
	Wed, 19 Feb 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978012; cv=none; b=UJdIX9yhbLxVYQiO5GjKr6xEetI27U+2CF9cLTjtw63TpxW8SRIl/oBCa7kE2kxN3flwodfZw8ghvJlHgWF6v6boNxsAS/L2TXq3y1Ecxg82YTQMkp640Y6Q1jc2HecA3h2hYs84+9fzz1cdqg57d9fD9VS4uzaIJSxbL7vcT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978012; c=relaxed/simple;
	bh=f3utMKar8wWZicCDrmR+Q7OczOccOOJkFA/H5zQyvrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKDk+6zx2Gromu/csa2aVD9B+9WafHHmYxv4MNn/s5jbJ5H6oN5sZeGWn/p19+ZFcy+qpI82i2FUV4JbSmKOQac8+kT7S351qgbhgPpkwNsanQXljkvMMqpuHib3zyvRmnU6GT7XGUXDBvGPMXlqY8mIEDjZX8cHGm4vFTWxnIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DD2C4CED1;
	Wed, 19 Feb 2025 15:13:29 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:13:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Christoph Hellwig 
 <hch@infradead.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250219101353.32bed6c9@gandalf.local.home>
In-Reply-To: <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	<Z7SwcnUzjZYfuJ4-@infradead.org>
	<b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
	<2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 09:14:17 -0500
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> I look at most of the bugfixes flowing through subsystems I watch and a
> lot of them are in error legs.  Usually around kfree cockups (either
> forgetting or freeing to early).  Could we possibly fix a lot of this
> by adopting the _cleanup_ annotations[1]?  I've been working in systemd
> code recently and they seem to make great use of this for error leg
> simplification.

And the tracing subsystem has already been moving in that direction.

  https://lore.kernel.org/all/20241219201158.193821672@goodmis.org/
  https://lore.kernel.org/all/173630223453.1453474.6442447279377996686.stgit@devnote2/

I need to add this logic to my tracing libraries too. That's on my TODO list.

-- Steve

