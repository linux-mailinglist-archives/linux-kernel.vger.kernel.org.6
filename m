Return-Path: <linux-kernel+bounces-173005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061B88BF9EA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A8AB248BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A7E7D405;
	Wed,  8 May 2024 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SO8auOHz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B8BA27
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162217; cv=none; b=KSmYtrV011O1Gymy3v4JwTrcWXFl7fDe4ylvF6vuVLvvEvucvF03o/JzYC2K99KviKMZer5WvWfp3/HNz7JOWEY5msp2uT+d3QwKy7SSQdbj0qjoNAe0v31PQ+vu7ea3XwsWjKcYOMBsVpCrJvtAN4cgZLl6uxYLyD8y3BkSiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162217; c=relaxed/simple;
	bh=gWOGj0Cw+EPeFvCPM84I9RZ1xnLNBOxo/kWhfYtd4Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB4C/OLDRIWTSO4d698pbNe1xhAVjo6D5c/OD2iqYt7oSr9AFszmmPg1ily7nh9vF5fONUZovPPNQTxpw/xZq6x/I6xDnOQN2rcBE7JjRHbkoMrbJbW1xrZGxwzkpoY3v8+X+mO4yi6sQHsHI89gnCw0Gf7aJ72c5KHYaeBQ9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SO8auOHz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715162214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HilCpQqF5nWfQLfesSgvF2CEj1QWp3oMiTsmW5AIS0=;
	b=SO8auOHzoolTspb+kJCR78zi51MNyfksn+muzetM9zXWr5ht9e3RGcTUigMPjI34CNxykM
	OW4Fb7H1pUbCw8k/kc0dCuz99EyJRmziff2YKervM5NIxTrfy0QldaiFet9ZhpdS+qcDhY
	C/dhEQlRa0F0i4uyL0cQgq+jVevPqBs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-Jder783tP7mfKG3-i3lIuw-1; Wed,
 08 May 2024 05:56:49 -0400
X-MC-Unique: Jder783tP7mfKG3-i3lIuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD26E29AB410;
	Wed,  8 May 2024 09:56:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 399463C25;
	Wed,  8 May 2024 09:56:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id E8ACB1800D69; Wed,  8 May 2024 11:56:46 +0200 (CEST)
Date: Wed, 8 May 2024 11:56:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Timo Lindfors <timo.lindfors@iki.fi>
Cc: David Airlie <airlied@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alex Constantino <dreaming.about.electric.sheep@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [BUG][v6.9-rc6] Deadlock with: Revert "drm/qxl: simplify
 qxl_fence_wait"
Message-ID: <ibl7jsqhbdga64nasmrruh3t2oa7rxqmwxywe6wtdfsqrliyue@tbgmm6uvxsqi>
References: <20240502081641.457aa25f@gandalf.local.home>
 <20240504043957.417aa98c@rorschach.local.home>
 <20240506-cuddly-elated-agouti-be981d@houat>
 <CAHk-=wiS70D1sbhsvNfR0e5YjfG2NV0cVKWz9vp=_F_wkw3j9Q@mail.gmail.com>
 <CAMwc25qMXOFOfKsa7BRi3dz125PDyvVtgTty0Q4bkAFftJDLqQ@mail.gmail.com>
 <alpine.DEB.2.20.2405070933070.20162@mail.home>
 <obume4wdvgxc3zljnelhpwrg2rouae322nak5jy3s4hsruoddd@stoopms6fo2a>
 <alpine.DEB.2.20.2405071833510.21166@mail.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.2405071833510.21166@mail.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Tue, May 07, 2024 at 06:46:41PM GMT, Timo Lindfors wrote:
> The qxl + spice + firefox combination scrolls smoothly even if I force
> firefox to use wayland.

scrolling sending 2d accel bitblits works only when running the xorg
xserver with the qxl driver.  xwayland wouldn't do that.  So that
doesn't explain the performance difference.

> I suppose I could write a more synthetic test if it would be useful?

Well, don't work on qemu graphics any more.  So I can't sink much time
into this, and my memories on details are starting to fade ...

> With systemtap I can trace what happens during a single scroll event.

Had a brief look at the driver source code.  One possibly important
difference is damage tracking.

qxl seems to send updates for the list of damaged rectangle to the host
(see qxl_draw_dirty_fb).

virtio-gpu goes call drm_atomic_helper_damage_merged() to get a single
rectangle covering all regions which need updating and works with that.

Which could very well explain the performance difference.  If you want
dig deeper I'd suggest to start there.

HTH & take care,
  Gerd


