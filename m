Return-Path: <linux-kernel+bounces-170911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B508BDDB9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271E01F216BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE6714D711;
	Tue,  7 May 2024 09:03:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704914D447
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072638; cv=none; b=l59cUIr5wwG6gkTKNbUBvP3bg/rKiOvjzs6+1KhqgvGQaA9nbWScyotDX92UytcClcjVMOQZxT0gaSlP2WI1MP5zxeHfJafQ+m2cT3+8xRH/EW7sxK16aD/Ruf+u1nUpgC0QnqEjOr0+z8hzgd9/DYhY2ik3HV9psvBtTmJaqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072638; c=relaxed/simple;
	bh=EwP9UbP45VBabyiXsN7jbi0PjJFOX2oFR+I/u/CqESU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvdIG5TbdXyY2rPg2NnEZ0813V/0LFAXY4pbQGH0Lw5WRK8An2Y8eQW1y9tjIKecsl1gtAXfHQT/WNxIz37VX5YI4wR9PbmPqK/v4ExgzvFgbv+WKrVuaSO44gJjwfAOolghPgGFtg3dGdKdIRVIn9xUTqDILsvmbQlqtJj+bB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF93BC3277B;
	Tue,  7 May 2024 09:03:56 +0000 (UTC)
Date: Tue, 7 May 2024 05:03:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Airlie <airlied@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Maxime Ripard
 <mripard@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alex Constantino
 <dreaming.about.electric.sheep@gmail.com>, Timo Lindfors
 <timo.lindfors@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [BUG][v6.9-rc6] Deadlock with: Revert "drm/qxl: simplify
 qxl_fence_wait"
Message-ID: <20240507050354.66bd88a0@rorschach.local.home>
In-Reply-To: <CAMwc25qMXOFOfKsa7BRi3dz125PDyvVtgTty0Q4bkAFftJDLqQ@mail.gmail.com>
References: <20240502081641.457aa25f@gandalf.local.home>
	<20240504043957.417aa98c@rorschach.local.home>
	<20240506-cuddly-elated-agouti-be981d@houat>
	<CAHk-=wiS70D1sbhsvNfR0e5YjfG2NV0cVKWz9vp=_F_wkw3j9Q@mail.gmail.com>
	<CAMwc25qMXOFOfKsa7BRi3dz125PDyvVtgTty0Q4bkAFftJDLqQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 15:54:21 +1000
David Airlie <airlied@redhat.com> wrote:

> I expec this will reintroduce the other problems that caused this
> change in the first place, but I think this should at least bring us
> back to regression equilibrium. I can't recommend anyone use qxl hw
> over virtio-gpu hw in their VMs, since virtio-gpu is actually hw
> designed for virt.

I agree that it will likely cause the issues that this was addressing
to come back, but you can't have a fix that introduces a deadlock.

Perhaps the deadlock didn't exist before, and the printk updates
changed the way it works to introduce it now?

-- Steve

