Return-Path: <linux-kernel+bounces-170767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5712C8BDBB7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFBC1F236F9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D26D7B3E1;
	Tue,  7 May 2024 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="zHOKBtmK"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE57479B9C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063951; cv=pass; b=swKoNzZEDrdXq0nXdX9+h5Jh9+wVX6sNFie5IcOGiZ16cEnS+4aJMh3wv0UUmhpHa59WXDgB0eA+k808Bkn3uiHC8JFds0MgpBM0rwTFdGs6I6mdA5ZbxcO/Pmr1stEm8tYw3rykkFSRA+D/xf2bf9PX/ILftCuZ/Dva2zUsOZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063951; c=relaxed/simple;
	bh=kpswRasr11wgK2lIC1LXyxZMJRCYs5MHWi9TJ8FuigE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fRPWXEatIRbA8ZTM2MfuFophnxMgbay40wyOXGY6P9oOkGwYid19Atqi01seEMoXdvlufmWPhNJ3ir1OjMAx0CUq7DbrGVwUmoHwmAcBg31rClpBU3ctD4Lrzly40p5MqbYKChgO/DSBzLV1c64GvZMbxldioPmqJViMpBpjmw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=zHOKBtmK; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from mail.home (82-181-196-180.bb.dnainternet.fi [82.181.196.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: timo.lindfors)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4VYTBp1v6rzyTX;
	Tue,  7 May 2024 09:38:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1715063940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ36/8Mm5I5lwI2+259ifmx6TmqC4LDHsWqAvvlI860=;
	b=zHOKBtmK8vcOrmI+FwIyRKe0+PoQxakNWE63k4bFGTFuhN22e9cSwDs0yyLEAsvvJVRjaC
	kaotyjovQI3YGIqZLsSSvEQrwWX8NBZ6p8dG9TwsWnkPmvk+Etz9IU9VWWy56noC33K0La
	kyMHONbhdQxaemEBFv56lf12Ltm6JQw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1715063940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ36/8Mm5I5lwI2+259ifmx6TmqC4LDHsWqAvvlI860=;
	b=mJ/T4CrGjLMp3KyDy8KMgg3NinQdSzP0oPGT3nXLwyn/yK9dtc0BEpT9aIKjir294/+0Mp
	A3BjmsMDWmO4OXfy9yaB54rDhrRRVVa+zr6eOt2WcEi5G3oCZcazK5Yo9HJCKSyrbNcQNz
	TEyV7BtCPbvYWzQLdUn2UvjMW2R1mE0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=timo.lindfors smtp.mailfrom=timo.lindfors@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1715063940; a=rsa-sha256; cv=none;
	b=TxStHaA9emZlfY8KFRTxAUQPbLF+k7MHXFaw4Veg0RhHLPf9V6plU/WB+EqJF1/SX80g7s
	uxNM7XaIuySJbIXlIPMAdhgWJjfE1OBUWSUNqFUkL4z5NHzmChaWKCSTRFyiJ2NwYowbRh
	8Qh9CQ9w9ghqELTodAUslPJUwdCNEqU=
Received: from localhost ([127.0.0.1])
	by mail.home with esmtp (Exim 4.89)
	(envelope-from <timo.lindfors@iki.fi>)
	id 1s4ETZ-0005Ft-0A; Tue, 07 May 2024 09:38:57 +0300
Date: Tue, 7 May 2024 09:38:56 +0300 (EEST)
From: Timo Lindfors <timo.lindfors@iki.fi>
To: David Airlie <airlied@redhat.com>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    Maxime Ripard <mripard@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Alex Constantino <dreaming.about.electric.sheep@gmail.com>, 
    Timo Lindfors <timo.lindfors@iki.fi>, Gerd Hoffmann <kraxel@redhat.com>, 
    Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
    Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [BUG][v6.9-rc6] Deadlock with: Revert "drm/qxl: simplify
 qxl_fence_wait"
In-Reply-To: <CAMwc25qMXOFOfKsa7BRi3dz125PDyvVtgTty0Q4bkAFftJDLqQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.2405070933070.20162@mail.home>
References: <20240502081641.457aa25f@gandalf.local.home> <20240504043957.417aa98c@rorschach.local.home> <20240506-cuddly-elated-agouti-be981d@houat> <CAHk-=wiS70D1sbhsvNfR0e5YjfG2NV0cVKWz9vp=_F_wkw3j9Q@mail.gmail.com>
 <CAMwc25qMXOFOfKsa7BRi3dz125PDyvVtgTty0Q4bkAFftJDLqQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 7 May 2024, David Airlie wrote:
> I expec this will reintroduce the other problems that caused this
> change in the first place, but I think this should at least bring us
> back to regression equilibrium. I can't recommend anyone use qxl hw
> over virtio-gpu hw in their VMs, since virtio-gpu is actually hw
> designed for virt.

I would love to switch to virtio. It works ok for local virtual machines 
but I have many users who are using Linux desktops hosted on a powerful 
server where it is more difficult. With spice and qxl scrolling in a web 
browser is smooth, with spice and virtio it seems like larger parts are 
getting fully redrawn (and resent over network?). Now that new gnome is 
going to come with RDP support I'm also considering switching to that. Any 
tips would be appreciated.

Here's a quick (1min42s) demo video that I recorded. spice+qxl on the 
left, spice+virtio on the right. The VMs were created from the exact same
disk image template.

https://lindi.iki.fi/lindi/qxl/spice_qxl_vs_virtio.webm

-Timo


