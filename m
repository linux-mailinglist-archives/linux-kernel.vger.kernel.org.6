Return-Path: <linux-kernel+bounces-284294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E984394FF73
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285C21C22912
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EA013A240;
	Tue, 13 Aug 2024 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u9OMBMeb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E915A8;
	Tue, 13 Aug 2024 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723536952; cv=none; b=NAotf6pAdIeoKzj6cqT4LEHf5HvKFG4tibP61CcNzRP3gm/J8VvNXSMalZT1ltX6/Kx8/ZfTZcM2vsCsWFEf5/tKLETp+SOIUgMs5/0F7lZx4GZGjxy0NHrfV+nKnMm6Xe957vPlJXf8VBZ+bPCBAzqOlLbccr1gOjHFU1vWT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723536952; c=relaxed/simple;
	bh=SP1JOwQQNV0B9mSzC4pNkikVseIdiCFzSCBHC0Vt9ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/UjerW1l5SXLqxutIkWvFkISDY8LQjMWNN9wNgN0LeiFX06AP3JwaXCE3CqqPEuyWIlACj2nrARiaRl9qIRdcJLQNlY3N8WqSEjB2N2+YuQEryR9NXLh7EekHdZpohtmW8t1PKIawhUfLtvhDWfmaIRSdFGaUeCyslKkFBYftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u9OMBMeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57D4C4AF09;
	Tue, 13 Aug 2024 08:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723536952;
	bh=SP1JOwQQNV0B9mSzC4pNkikVseIdiCFzSCBHC0Vt9ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9OMBMebmCOYzHxz13pbUxAhjBkE8hXa4NxZedKGT9/aM2tn0eIdOB4eOotYNza4i
	 Bh8RPEaBVNtLoqvWC+UGH4D19ZLwtvu57wXA3jU4arroXbNmrEyIqt7J0FLmgy4im8
	 gGp5tYY9HoQHUw00eCKD2MLwmrO+mgsZzB59Z4fY=
Date: Tue, 13 Aug 2024 10:15:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, giometti@enneenne.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
	christopher.s.hall@intel.com, pandith.n@intel.com,
	subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com
Subject: Re: [PATCH v10 0/3] Add support for Intel PPS Generator
Message-ID: <2024081330-retouch-platter-f21d@gregkh>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>

On Wed, Jun 12, 2024 at 09:23:56AM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> The goal of the PPS (Pulse Per Second) hardware/software is to generate a
> signal from the system on a wire so that some third-party hardware can
> observe that signal and judge how close the system's time is to another
> system or piece of hardware.
> 
> Existing methods (like parallel ports) require software to flip a bit at
> just the right time to create a PPS signal. Many things can prevent
> software from doing this precisely. This (Timed I/O) method is better
> because software only "arms" the hardware in advance and then depends on
> the hardware to "fire" and flip the signal at just the right time.
> 
> To generate a PPS signal with this new hardware, the kernel wakes up
> twice a second, once for 1->0 edge and other for the 0->1 edge. It does
> this shortly (~10ms) before the actual change in the signal needs to be
> made. It computes the TSC value at which edge will happen, convert to a
> value hardware understands and program this value to Timed I/O hardware.
> The actual edge transition happens without any further action from the
> kernel.
> 
> The result here is a signal coming out of the system that is roughly
> 1,000 times more accurate than the old methods. If the system is heavily
> loaded, the difference in accuracy is larger in old methods.
> 
> Application Interface:
> The API to use Timed I/O is very simple. It is enabled and disabled by
> writing a '1' or '0' value to the sysfs enable attribute associated with
> the Timed I/O PPS device. Each Timed I/O pin is represented by a PPS
> device. When enabled, a pulse-per-second (PPS) synchronized with the
> system clock is continuously produced on the Timed I/O pin, otherwise it
> is pulled low.
> 
> The Timed I/O signal on the motherboard is enabled in the BIOS setup.
> Intel Advanced Menu -> PCH IO Configuration -> Timed I/O <Enable>
> 
> References:
> https://en.wikipedia.org/wiki/Pulse-per-second_signal
> https://drive.google.com/file/d/1vkBRRDuELmY8I3FlfOZaEBp-DxLW6t_V/view
> https://youtu.be/JLUTT-lrDqw
>  
> Patch 1 adds the pps(pulse per second) generator tio driver to the pps
> subsystem.
> Patch 2 documentation and usage of the pps tio generator module.
> Patch 3 includes documentation for sysfs interface.
> 
> These patches are based on the timers/core branch:
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/?h=timers/core
> These changes are dependent on patches that are merged in [1].

This series now breaks the build due to api changes in 6.11-rc1.  Please
fix up and resend.

thanks,

greg k-h

