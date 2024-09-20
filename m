Return-Path: <linux-kernel+bounces-334687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC0897DAAC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 01:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBACA28369C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C239187322;
	Fri, 20 Sep 2024 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="dE1/hys/"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFC127E18;
	Fri, 20 Sep 2024 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726873251; cv=none; b=lUotADfkpM9Lb80/kpVMr4CSd704CB/cPrF2FgzvUi03Zhf8USa10rdRbHiQnFxvseZkKspAknFtYdxBdnm0uohKy7zncvdrmHMOvGf9lVCIRfNksn3/licUK2TuIi3TPgo9LOUtWSePdfIN3J+92Alfg2e8oxjnS7FdpUOi/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726873251; c=relaxed/simple;
	bh=oDTw/TNvmzyXhz2m43ox+4sT9Vh1e5aS1Cvj9VKWnfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3r5ckKYhO2LSeu/QuXmuE4306ebFrh5aqBEcg08bguKELcS/LKpKrGThKLzQ9RR1TkKTmLjpQC0OVY0xrELyeqBldqsZK4/3iUaPIm5S/wbFuekQhmeA/A3V8ShFouOyv9Lrb0qoABy2I2V40s1H4CNDzOEfp0bKbZOJeO3Lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=dE1/hys/; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=U+HYAQI0h93LLArZJ8CSYK2FsKFPLrHEU7IRp1uP1/k=; b=dE1/hys/c0TQC1xc
	NeZCPrkVLasnvNQRg1FRDbsVjbGzhiLa2kqWkmebMZglGar1myRF7t+675l1A5hXHhWXnjHh5abCe
	OCV0tfdwxuxR5nzxUA3aU+XpfMheHqYgIejIAOcAWW4Hs+diygm1D8TW5U3tP3kfQ8zA4iZFIAaJw
	sYnVW13tkgrf00nCXD1OZ1hsKYpZ22NDZtDhRtF4TfMZFmLRFuFdi6C9ivOFJ80oY44e1abvRN8xj
	DSaoVmvep4mjjxhUqmpbUoO0cG7VNieOYejHJ2NGjjAmEfsLapp1xIHdvPiu+jn7wFcb9f0iAX72D
	dfnGQq840cMpVCh8rg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1srmcG-006bfD-1V;
	Fri, 20 Sep 2024 23:00:44 +0000
Date: Fri, 20 Sep 2024 23:00:44 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Bob Gill <gillb5@telus.net>, alex.hung@amd.com,
	alexander.deucher@amd.com
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: [REGRESSION] Re: AMDGPU 6.11.0 crash, 6.10.0 git bisect log
Message-ID: <Zu3-nJ7LpVzoN5Bj@gallifrey>
References: <c21b734a-1d3d-4286-a3c5-a6ae9b69d847@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c21b734a-1d3d-4286-a3c5-a6ae9b69d847@telus.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 22:53:34 up 135 days, 10:07,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Bob Gill (gillb5@telus.net) wrote:
> Hello.  Kernel 6.11.0 crashes.  6.10.0 builds.  Al Viro and Dr. David Alan
> Gilbert have been helpful, and asked that I
> 
> post a git bisect log.  The last log step seems odd, but the second last
> step "Remove useless function call" might be what broke.

Thank you for doing this!

My reading is that's fine, I think the next one:

tree: git bisect bad
[a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check and log for
function error codes

or the one after it is the culprit?

Adding the two Alex's from AMD back onto the thread.
(Also added the [REGRESSION] marker the notes tell us to add)

> My hardware is old corei7 quad core/8 thread Tylersberg/Nehalem with an AMD
> RX 6500XT.  That's the odd combination.
> 
> Thanks in advance,

Thanks again for the bisect.

Dave

> Bob
> 
> Config:  (.config)
> /data/kernel/bobtest6.10-64
> 
> Build line: (last command tells me the job is finished)
> make menuconfig && make -j $(nproc) && make modules && make modules_install
> && make install && /data/music/pl.sh
> 
> Rule 1: Do not modify ANYTHING in the source tree
> 
> git bisect start
> git bisect bad
> git bisect good v6.10
> 
> Bisecting: 11273 revisions left to test after this (roughly 14 steps)
> [2c9b3512402ed192d1f43f4531fb5da947e72bd0] Merge tag 'for-linus' of
> git://git.kernel.org/pub/scm/virt/kvm/kvm
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0+
> 
> RESULT:  boot 6.10.0+ fails
>          screen black for more than 2 minutes,
>          (caps lock key unresponsive, reset, power
>          buttons on computer case do nothing).  Reset with power bar.
> 
> tree: git bisect bad
> Bisecting: 5677 revisions left to test after this (roughly 13 steps)
> [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0+
> 
> RESULT: boot 6.10.0+ successful
> tree: git bisect good
> Bisecting: 2855 revisions left to test after this (roughly 12 steps)
> [dde1a0e1625c08cf4f958348a83434b2ddecf449] Merge tag 'x86-percpu-2024-07-17'
> of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0+
> 
> RESULT: boot 6.10.0+ fails
>         screen black for more than 2 minutes,
>         (caps lock key unresponsive, reset, power
>         buttons on computer case do nothing).  Reset with power bar.
> 
> tree: git bisect bad
> Bisecting: 1478 revisions left to test after this (roughly 11 steps)
> [32a120f52a4c0121bca8f2328d4680d283693d60] drm/i915/mtl: Skip PLL state
> verification in TBT mode
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0-rc3+
> 
> RESULT: boot 6.10.0-rc3+ successful
> tree: git bisect good
> Bisecting: 739 revisions left to test after this (roughly 10 steps)
> [b6a343df46d69070a7073405e470e6348180ea34] drm/amdgpu: initialize GC IP
> v11.5.2
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0-rc3+
> 
> RESULT: boot 6.10.0-rc3+ fails
>         screen black for more than 2 minutes,
>         (caps lock key unresponsive, reset, power
>         buttons on computer case do nothing).  Reset with power bar.
> 
> tree: git bisect bad
> Bisecting: 369 revisions left to test after this (roughly 9 steps)
> [cf1d06ac53a15b83c0a63225606cfe175e33a8a0] accel/ivpu: Increase autosuspend
> delay to 100ms on 40xx
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0-rc1+
> 
> RESULT: boot 6.10.0-rc1+ successful
> tree: git bisect good
> Bisecting: 184 revisions left to test after this (roughly 8 steps)
> [0ca9f757a0e27a076395ec1b2002661bcf5c25e8] drm/amd/pm: powerplay: Add
> `__counted_by` attribute for flexible arrays
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.9.0-rc5+
> 
> RESULT: boot 6.9.0-rc5+ successful
> tree: git bisect good
> Bisecting: 92 revisions left to test after this (roughly 7 steps)
> [9862ef7bae47b9292a38a0a1b30bff7f56d7815b] drm/amd/display: Use periodic
> detection for ipx/headless
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0-rc3+
> 
> RESULT: boot 6.10.0-rc3+ fails
>         screen black for more than 2 minutes,
>         (caps lock key unresponsive, reset, power
>         buttons on computer case do nothing).  Reset with power bar.
> 
> tree: git bisect bad
> Bisecting: 44 revisions left to test after this (roughly 6 steps)
> [a78313bb206e0c456a989f380c4cbd8af8af7c76] Merge tag
> 'drm-intel-gt-next-2024-06-12' of
> https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0-rc3+
> 
> RESULT: boot 6.10.0-rc3+ successful
> tree: git bisect good
> Bisecting: 22 revisions left to test after this (roughly 5 steps)
> [51dbe0239b1fc7c435867ce28e5eb4394b6641e1] drm/amd/display: Fix cursor size
> issues
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0-rc3+
> 
> RESULT: boot 6.10.0-rc3+ successful
> tree: git bisect good
> Bisecting: 11 revisions left to test after this (roughly 4 steps)
> [871512e36f9c1c2cb4e62eb860ca0438800e4d63] drm/amd/display: Add workaround
> to restrict max frac urgent for DPM0
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0-rc3+
> 
> RESULT: boot 6.10.0-rc3+ fails
>         screen black for more than 2 minutes,
>         (caps lock key unresponsive, reset, power
>         buttons on computer case do nothing).  Reset with power bar.
> 
> tree: git bisect bad
> Bisecting: 5 revisions left to test after this (roughly 3 steps)
> [5d93060d430b359e16e7c555c8f151ead1ac614b] drm/amd/display: Check HDCP
> returned status
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0-rc3+
> 
> RESULT: boot 6.10.0-rc3+ fails
>         screen black for more than 2 minutes,
>         (caps lock key unresponsive, reset, power
>         buttons on computer case do nothing).  Reset with power bar.
> 
> tree: git bisect bad
> Bisecting: 2 revisions left to test after this (roughly 1 step)
> [e094992bd1caa1fbd42221c7c305fc3b54172b5c] drm/amd/display: Remove useless
> function call
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0-rc3+
> 
> RESULT: boot 6.10.0-rc3+ successful
> 
> tree: git bisect good
> [2c2ee1d1329881d8e6bb23c3b9f3b41df8a8055c] drm/amd/display: Check and log
> for function error codes
> 
> latest kernel:
> ls -alt /lib/modules | head -2 | tail -1 | tr -s " " | cut -d' ' -f9
> 6.10.0-rc3+
> 
> RESULT: boot 6.10.0-rc3+ fails
>         screen black for more than 2 minutes,
>         (caps lock key unresponsive, reset, power
>         buttons on computer case do nothing).  Reset with power bar.
> 
> tree: git bisect bad
> [a171cce57792b0a6206d532050179a381ad74f8f] drm/amd/display: Check and log
> for function error codes
> 
> 
> 
> 
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

