Return-Path: <linux-kernel+bounces-171719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F5E8BE7BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B61B250E5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FA31649CC;
	Tue,  7 May 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="G6pP4JHw"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0651635CF
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096810; cv=pass; b=gF0W0EJBLSEpk5cAXy0tzZOib5lY2G/rj1WiWxrmy6lLxj+OBb0StPoBkys+8VpndG9ujQzi+Lmf/yh6QA3s4zeDvm+bnA16cjql//BrEa5k0LqJuBeyByU8dF56UVuaVsnLDFtd4RYT8GtDl1w8iY0XiucG9M85vVWoLmpIM6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096810; c=relaxed/simple;
	bh=5KJcdFFNPo7Xz5KJ9wNhtqFPiCRb1O2wlvRY/A+22iQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BTnjWjH+9zCCwPAc9WyUc8S8iNkYKeEhuxqr+o5o5efnGbS975Ft+ZT4RlEHfckVw0DhtayZWvCsfmYY9wUW/2WQMdc+GoQr09Eb4NGVul8Td9gDB0ySUUlPKNpzx30D5gDM49aaSvIRdBc8YmzLWFXol3h7pDrRO/fFVIeSKdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=G6pP4JHw; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from mail.home (82-181-196-180.bb.dnainternet.fi [82.181.196.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: timo.lindfors)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VYjLp08KxzyYP;
	Tue,  7 May 2024 18:46:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1715096803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0blk/HJMbG1YRLdL/uOzQXbl8TjW5wKbD1aD2iGM4w4=;
	b=G6pP4JHwf9x8Ub2mDvIdjlOGZLegKBJrBHGO5Uwd06+UmCDAb6fsIEcZd7vGs2mXRJzcPG
	S+e6UjU+3aOM9NAR5FOWuDXfOoFBpgrvy7/Oo7q/hE19Gt3vvVGiwfuT6AVboLwnkBP+7L
	MBr1H1qeDdZTR/0bVrbkFVhhPhxD/L8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1715096803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0blk/HJMbG1YRLdL/uOzQXbl8TjW5wKbD1aD2iGM4w4=;
	b=D8MUWi3haejgIjSynxdUhNlixs5+zvsAsSW2jF2wtd8zxJDft1YrIMyeRer0fuKUuwMH+u
	hDrft436l6dzCsRbi4Tk7MxT9ixGJq8YEPRyOyOfPyUkfUt4DTBnicFKYEyGU3AH3bcs/D
	naj+EOjNDoXall/2+2+Eqo4kIGB0FAI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=timo.lindfors smtp.mailfrom=timo.lindfors@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1715096803; a=rsa-sha256; cv=none;
	b=J51sS74+MRNqBrnsDBLpcrw42iVYpeqTbOhYXU0vRXZ6wl+/1CfE76bsCc3nQRT8dzovmf
	hDveUlf+NV8MtHYr8l/5r0LDMLDV8/D3ebqAXAyT8P8cOnASaLe2jf6cwYjgLJ3UhyuSNs
	ZykUUazwnstLpbJ6LLgKNGibcQP+SmA=
Received: from localhost ([127.0.0.1])
	by mail.home with esmtp (Exim 4.89)
	(envelope-from <timo.lindfors@iki.fi>)
	id 1s4N1d-0005WA-HE; Tue, 07 May 2024 18:46:41 +0300
Date: Tue, 7 May 2024 18:46:41 +0300 (EEST)
From: Timo Lindfors <timo.lindfors@iki.fi>
To: Gerd Hoffmann <kraxel@redhat.com>
cc: Timo Lindfors <timo.lindfors@iki.fi>, David Airlie <airlied@redhat.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Maxime Ripard <mripard@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Alex Constantino <dreaming.about.electric.sheep@gmail.com>, 
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
    Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [BUG][v6.9-rc6] Deadlock with: Revert "drm/qxl: simplify
 qxl_fence_wait"
In-Reply-To: <obume4wdvgxc3zljnelhpwrg2rouae322nak5jy3s4hsruoddd@stoopms6fo2a>
Message-ID: <alpine.DEB.2.20.2405071833510.21166@mail.home>
References: <20240502081641.457aa25f@gandalf.local.home> <20240504043957.417aa98c@rorschach.local.home> <20240506-cuddly-elated-agouti-be981d@houat> <CAHk-=wiS70D1sbhsvNfR0e5YjfG2NV0cVKWz9vp=_F_wkw3j9Q@mail.gmail.com> <CAMwc25qMXOFOfKsa7BRi3dz125PDyvVtgTty0Q4bkAFftJDLqQ@mail.gmail.com>
 <alpine.DEB.2.20.2405070933070.20162@mail.home> <obume4wdvgxc3zljnelhpwrg2rouae322nak5jy3s4hsruoddd@stoopms6fo2a>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 7 May 2024, Gerd Hoffmann wrote:
> Worth trying: use vnc.  The qemu vnc server will skip updates when the
> network pipeline is full.  That throttles the frame rate, but also
> reduces the display update latency.

With Debian 12 it seems that the virtio + vnc + firefox combination 
results in a black firefox window. Adding MOZ_ENABLE_WAYLAND=1 makes
the browser visible but I still see the constant redraw behavior when scrolling.

The qxl + spice + firefox combination scrolls smoothly even if I force 
firefox to use wayland. I suppose I could write a more synthetic test if
it would be useful? With systemtap I can trace what happens during a single
scroll event.

> In general the trend seems to be to move to in-guest remote desktop
> solutions.  Do NOT make VMs a special case with a special solution,
> instead handle VMs like bare metal.  Commercial solutions exist for a
> while, some of them are doing hardware-assisted video encoding to send
> the display as video stream to the remote end.  gnome+rdp is a new
> player here, clearly worth a try.

Yes this makes sense. I'm definitely not trying to stick to a particular 
technology but instead try to find the best FOSS solution for the use case 
of hosting linux desktops on a server.

-Timo

