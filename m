Return-Path: <linux-kernel+bounces-377430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F459ABEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7501C21055
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66C149011;
	Wed, 23 Oct 2024 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnxuPjJS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1917741;
	Wed, 23 Oct 2024 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729664863; cv=none; b=uImwd8m1znCzEMjFog1zTRdro1SflhNKmpjzb1PuOjLfFxWbxSZ93WMkYrcAlbe/Bzcy34L7LHYPZToSWArYYE94Y+tKyOqvSIX8Y24RNfLKhePzra63bqU6rXoKnfPfoj8r49EOXt85/AGAG2/AE0jwVZl8Sw/CP32QS+3DyF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729664863; c=relaxed/simple;
	bh=joW10M2QjI7uyweMZr3V/PHNfQK8wllAPyFXTQSyR1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaO27xTCSXmBDMrCwc3tDVodttAaMuELPLRt8tDOuM/fBQX2srtXB9SRdCUc9Kg9s92PwVZsnet7am+gW8YCfuwIEp0Baymj5zELyxbDUoII2tKV8dWXZKpikesR64ld+lSiA6seGyF2XQuVQsTtnG+Ps2jFDrlPG4K5ZAk44uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnxuPjJS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729664861; x=1761200861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=joW10M2QjI7uyweMZr3V/PHNfQK8wllAPyFXTQSyR1A=;
  b=WnxuPjJS0KAJsm38TQ+6bxdJ4ge2Nmxyn4tjs65UGs5ZgcRir6oS5Hj+
   yJHjsWZYJdfWaVI20M9f2tmvNAdYEvde/BPWdvG3HxORVdk9fFHHYuMkP
   ZNUhHOxpsO9Cg9oNTRRhMonwkefGW0MRJrbK+xrSR4Wq+qlwHz976h+/1
   F/Ps4/3lW2DXkN4xI5kTVn1DUxZUfCdzBECUD4zjK8kdBwdEu7sMmE+Qn
   iVYeSNf6fO2IOEDX9sG1q2USFoQzLf61xEXcVF/Ku0wOosmmd/K0sxmA8
   VqOVsXo5xxaP6tCb8WTGbDbzy0JmifRlkK+XpHJIqk9LX5bQ6t5VweVuT
   g==;
X-CSE-ConnectionGUID: SdWLWQLGSEy/nEUbdDtJJw==
X-CSE-MsgGUID: /Vj30g5yTjmgX3PwUJqUww==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29110191"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29110191"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 23:27:41 -0700
X-CSE-ConnectionGUID: YVnYoYpkS+OS/5ll0E5pWA==
X-CSE-MsgGUID: cg6LY4jzSqiNg6J7uYkQ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80168027"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 22 Oct 2024 23:27:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id BB16C301; Wed, 23 Oct 2024 09:27:37 +0300 (EEST)
Date: Wed, 23 Oct 2024 09:27:37 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241023062737.GG275077@black.fi.intel.com>
References: <20241009220118.70bfedd0@kf-ir16>
 <20241010044919.GD275077@black.fi.intel.com>
 <20241010232656.7fc6359e@kf-ir16>
 <20241011163811.GU275077@black.fi.intel.com>
 <20241011183751.7d27c59c@kf-ir16>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011183751.7d27c59c@kf-ir16>

Hi Aaron,

On Fri, Oct 11, 2024 at 06:37:51PM -0500, Aaron Rainbolt wrote:
> Attached are the test results (including dmesg log) after testing with
> our version of the 6.8 kernel with this patch applied. Sadly we didn't
> have time to test with 6.11.2 as the machines we were testing on had to
> be shipped to customers and we found a working stop-gap solution in the
> mean time. The test that we did, along with it's results, are as
> follows:

Thanks for testing!

> 1. Start with Laptop powered-off
> 2. Unplug all USB-C connectors.
> 3. Attempt to update firmware using Windows.
>    Version remains 'thunderbolt 0000:06:00.0: 0: NVM version 14.86'
> 4. Boot Kubuntu 24.04 with patched kernel, add cmdline parameter
> thunderbolt.dyndbg=+p Note that a "thunderbolt.kf_force_redrive=1"
> kernel parameter was also included by mistake, but it is ignored in
> this kernel. (That was a leftover of a testing kernel we made.)
> 5. Log in to normal SDDM to KDE 5.27.11.
> 6. Open 'Display Settings KCM' to view display
>    detection.
> 7. Plug in 2 x UBC-C connectors attached to 4k displays.
>     - Note these work with Kernel 6.1 and non-Barlow Ridge systems (TB
>       4). 
>     - Displays wake up, but never show graphics signal. They timeout
>       and resume powersave mode.
>     - Displays never appear in 'Display Settings KCM.'
>     - This is NOT desired behavior; displays should show.

Let's stop here so that we deal with one issue at the time. The
corresponding entries in you dmesg are below with my comments. Please
correct me if my analysis does not match your steps.

So here you plug in the first Type-C cable:

> [  182.118304] thunderbolt 0000:06:00.0: control channel starting...
> [  182.118314] thunderbolt 0000:06:00.0: starting TX ring 0
> [  182.118325] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
> [  182.118329] thunderbolt 0000:06:00.0: starting RX ring 0
> [  182.118338] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
> [  182.118348] thunderbolt 0000:06:00.0: 0: resuming switch
> [  182.118351] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
> [  182.118608] thunderbolt 0000:06:00.0: 0: disabling wakeup
> [  182.127404] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
> [  182.127416] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
> [  182.127524] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
> [  182.127527] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
> [  182.128042] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
> [  182.128938] thunderbolt 0000:06:00.0: 0:13: enter redrive mode, keeping powered

We notice this as "redrive" and keep the domain powered.

> [  182.129059] thunderbolt 0000:06:00.0: acking hot plug event on 0:16
> [  182.129759] thunderbolt 0000:06:00.0: 0:14: enter redrive mode, keeping powered

We notice the second Type-C connection too.

So at this point the domain keeps powered and if you wait here it should
never runtime suspend because there are two Type-C ports in "redrive"
mode.

> [  315.601384] thunderbolt 0000:06:00.0: acking hot plug event on 0:14

You unplugged the second monitor.

> [  315.601762] thunderbolt 0000:06:00.0: 0:14: DP IN resource available after hotplug
> [  315.602370] thunderbolt 0000:06:00.0: 0:14: exit redrive mode
> [  315.602375] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
> [  315.602549] thunderbolt 0000:06:00.0: 0:14: DP IN available
> [  315.602553] thunderbolt 0000:06:00.0: no suitable DP OUT adapter available, not tunneling
> [  353.610947] thunderbolt 0000:06:00.0: acking hot plug event on 0:13

And then the first monitor.

> [  353.611260] thunderbolt 0000:06:00.0: 0:13: DP IN resource available after hotplug
> [  353.611921] thunderbolt 0000:06:00.0: 0:13: exit redrive mode

So at this point we are not in "redrive" mode anymore and the domain is
allowed to runtime suspend.

> [  353.611933] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
> [  353.612076] thunderbolt 0000:06:00.0: 0:14: DP IN available
> [  353.612258] thunderbolt 0000:06:00.0: 0:13: DP IN available
> [  353.612264] thunderbolt 0000:06:00.0: no suitable DP OUT adapter available, not tunneling
> [  372.362496] thunderbolt 0000:06:00.0: 0: suspending switch
> [  372.362506] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
> [  372.363480] thunderbolt 0000:06:00.0: stopping RX ring 0
> [  372.363497] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
> [  372.363523] thunderbolt 0000:06:00.0: stopping TX ring 0
> [  372.363539] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
> [  372.363558] thunderbolt 0000:06:00.0: control channel stopped

Which is what happens here.

I think the driver does the correct thing but why you don't see anything
in the screen is beyond me. Can reproduce just this case with the patch
and then run "xrandr" and see if the monitors are visible there?

