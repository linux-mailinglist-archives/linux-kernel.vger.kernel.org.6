Return-Path: <linux-kernel+bounces-171081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF018BDF94
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452C31C209D5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9C14EC57;
	Tue,  7 May 2024 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kt9ovaVZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6763913C69A
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077319; cv=none; b=YYq1J8Q9i1Qw9Ti9BzW1kdAj8kNM0rD2t8pGcp5HpLCnPr3cE2oP3Kj0hEaa1bGCTGTmRRRDbGn/6DUJHyt/MJ94Nb6y3YZf+vEP4IPZExyuqMFK8BFPAn4g2vhEb0af7gyaygY9gzjIZA/aXFIlK6D5rQ2z1buVkwrgwrHAnKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077319; c=relaxed/simple;
	bh=E73NeLMvHy12cIHPkQLQRHKvzYkound68hYaph9BTKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/ST3hDfeXPecid40HhMG3jMDoIpKjLNaS9IL0EgDuG403qaRSmIHsaRe0a7bTzQeHpsG3MRQ7z+1EL36uQnlx8ezviDDCDHHTus54qLK1RaBs9DbHkuh87ojlF7fTFxN2H678reWiXldwpPomhTEc9S/B4cAK19ocC4MyWpub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kt9ovaVZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715077316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfwQsXSqZlGBsnHNFOqSut056iII+HxTkb4DDzk0sWI=;
	b=Kt9ovaVZhd2uSafJPNVhFxbTHFN6jACDjCp0ohFR5FrX2b9uifEE+vsLP7iig7fWZ2KJih
	8DSVqIki2QeRIzCtGfoucbf0D0NBG0v1wL86eGOOb1KlbGuIoooPLDxKveHF2hpxaNW5X+
	8wuLmOkTkObqOOkU+tQb/SqgE+RvUX8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-K5BFCThuPouJLSjvADpySA-1; Tue, 07 May 2024 06:21:53 -0400
X-MC-Unique: K5BFCThuPouJLSjvADpySA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96E1285A58C;
	Tue,  7 May 2024 10:21:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.234])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F6DF3C27;
	Tue,  7 May 2024 10:21:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id D822D1800D4F; Tue,  7 May 2024 12:21:50 +0200 (CEST)
Date: Tue, 7 May 2024 12:21:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Timo Lindfors <timo.lindfors@iki.fi>
Cc: David Airlie <airlied@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alex Constantino <dreaming.about.electric.sheep@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [BUG][v6.9-rc6] Deadlock with: Revert "drm/qxl: simplify
 qxl_fence_wait"
Message-ID: <obume4wdvgxc3zljnelhpwrg2rouae322nak5jy3s4hsruoddd@stoopms6fo2a>
References: <20240502081641.457aa25f@gandalf.local.home>
 <20240504043957.417aa98c@rorschach.local.home>
 <20240506-cuddly-elated-agouti-be981d@houat>
 <CAHk-=wiS70D1sbhsvNfR0e5YjfG2NV0cVKWz9vp=_F_wkw3j9Q@mail.gmail.com>
 <CAMwc25qMXOFOfKsa7BRi3dz125PDyvVtgTty0Q4bkAFftJDLqQ@mail.gmail.com>
 <alpine.DEB.2.20.2405070933070.20162@mail.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.2405070933070.20162@mail.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Tue, May 07, 2024 at 09:38:56AM GMT, Timo Lindfors wrote:
> On Tue, 7 May 2024, David Airlie wrote:
> > I expec this will reintroduce the other problems that caused this
> > change in the first place, but I think this should at least bring us
> > back to regression equilibrium. I can't recommend anyone use qxl hw
> > over virtio-gpu hw in their VMs, since virtio-gpu is actually hw
> > designed for virt.

Well, qxl was designed for virt too, but almost two decades ago with 2d
acceleration.  And alot of complexity, trying to move 2d-accel rendering
from the VM guest to the spice client.  That complexity still bites us
today as this issue shows.

With desktop rendering moving to 3d acceleration all that 2d accel stuff
became mostly useless though, so you have the downsides of the
complexity without any upsides.

There have been plans to add 3d-acceleration support to qxl, but they
never took off and with virtio-gpu having taken that role meanwhile the
idea is dead now.

I second the recommendation to avoid qxl.

> I would love to switch to virtio. It works ok for local virtual machines but
> I have many users who are using Linux desktops hosted on a powerful server
> where it is more difficult. With spice and qxl scrolling in a web browser is
> smooth, with spice and virtio it seems like larger parts are getting fully
> redrawn (and resent over network?).

Hmm, I'd expect behavior being quite simliar for stdvga, qxl and
virtio-gpu when running a wayland desktop remotely.

When running on X11 without 3d acceleration it could be that scroll
ops are actually sent as 2d accel blits on qxl, explaining the
difference you are seeing.

> Now that new gnome is going to come with RDP support I'm also
> considering switching to that. Any tips would be appreciated.

Worth trying: use vnc.  The qemu vnc server will skip updates when the
network pipeline is full.  That throttles the frame rate, but also
reduces the display update latency.

In general the trend seems to be to move to in-guest remote desktop
solutions.  Do NOT make VMs a special case with a special solution,
instead handle VMs like bare metal.  Commercial solutions exist for a
while, some of them are doing hardware-assisted video encoding to send
the display as video stream to the remote end.  gnome+rdp is a new
player here, clearly worth a try.

take care,
  Gerd


