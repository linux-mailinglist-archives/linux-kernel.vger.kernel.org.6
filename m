Return-Path: <linux-kernel+bounces-377555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D689AC079
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4604AB212FB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B186155385;
	Wed, 23 Oct 2024 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4kL/S5T"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC46EAC5;
	Wed, 23 Oct 2024 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669176; cv=none; b=vBtBr58A9ITLLMR2FZU+rDxuejOGrbKz62ZLho6GkFptFP8zLHy8y9qRMimAcRRNXImDafZg67ylskf6AY3cM9DFle46R+tF/ja0/LCBTdyQGC892yjBe6GSTdB+LIAgty1ArdAHAW76bzfRErzAbJmdoBacmE++HxQRfcA2cZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669176; c=relaxed/simple;
	bh=d/K/oikKHdRYGNSRuNdQtZND2v5wk+xzH8NwdIk4RwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ci7Kl0jIjkPeeaQkfbU392Frs6Pj/JaiJgjYE6CId2dtVbpY676ARdvtFdx7WL4sksoU9mDuCXJfi5ywNSZVO5aoNEVJxZvnpNJSI8fHOALne5FklKP8W6FZ45LrFy5Oc4EcjZEnQZRNkJejJgDunx/OYX0b7hFBGnF5UyQJpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4kL/S5T; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729669175; x=1761205175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d/K/oikKHdRYGNSRuNdQtZND2v5wk+xzH8NwdIk4RwM=;
  b=A4kL/S5T7s9z2lgdEBDL5YtruZUTYTlscAcL4lR1TJFvk92VxIO0lssK
   IUO3IO+XMLYYhQjH9sj527SUuGU4lP9yf5b3vhTsLj51IgtFYz0uNipRr
   Bb6eLPcLKGrmxBeyeR4u2BkEmvPJa1pTJFqHk+xy9D+O20kFWp24L5ok4
   vnF77zj5p0HTvuoWJ/3Jk+x2u9l0+5HJwESgQTkGJNlRA8BUzxfBagPkH
   1MDmDlT9+uC9keg/yXUBcjh0F5qUswTgdTbnoJ1qge73CNWMc6ctD79Ul
   VEx0kK3EvuZS6yjdOfraOUJVf/0HCnB30eWR8eaouogKAJTBa7HnnUcOl
   Q==;
X-CSE-ConnectionGUID: 9kHkDUCzRGmjVOCz6CHVGQ==
X-CSE-MsgGUID: /OmWxgvLSbiSiPG2JvSkDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29022062"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29022062"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:39:34 -0700
X-CSE-ConnectionGUID: XikBXNJlRtqFBb43X+A4GQ==
X-CSE-MsgGUID: puU3MuQ3R7eyrNYE0MtkBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="103402252"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 23 Oct 2024 00:39:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 5E19E301; Wed, 23 Oct 2024 10:39:31 +0300 (EEST)
Date: Wed, 23 Oct 2024 10:39:31 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241023073931.GH275077@black.fi.intel.com>
References: <20241009220118.70bfedd0@kf-ir16>
 <20241010044919.GD275077@black.fi.intel.com>
 <20241010232656.7fc6359e@kf-ir16>
 <20241011163811.GU275077@black.fi.intel.com>
 <20241011183751.7d27c59c@kf-ir16>
 <20241023062737.GG275077@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023062737.GG275077@black.fi.intel.com>

On Wed, Oct 23, 2024 at 09:27:37AM +0300, Mika Westerberg wrote:
> So at this point we are not in "redrive" mode anymore and the domain is
> allowed to runtime suspend.
> 
> > [  353.611933] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
> > [  353.612076] thunderbolt 0000:06:00.0: 0:14: DP IN available
> > [  353.612258] thunderbolt 0000:06:00.0: 0:13: DP IN available
> > [  353.612264] thunderbolt 0000:06:00.0: no suitable DP OUT adapter available, not tunneling
> > [  372.362496] thunderbolt 0000:06:00.0: 0: suspending switch
> > [  372.362506] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
> > [  372.363480] thunderbolt 0000:06:00.0: stopping RX ring 0
> > [  372.363497] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
> > [  372.363523] thunderbolt 0000:06:00.0: stopping TX ring 0
> > [  372.363539] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
> > [  372.363558] thunderbolt 0000:06:00.0: control channel stopped
> 
> Which is what happens here.
> 
> I think the driver does the correct thing but why you don't see anything
> in the screen is beyond me. Can reproduce just this case with the patch
> and then run "xrandr" and see if the monitors are visible there?

The other option is that there is no wake when you plugged in the
monitors and it only wakes up when you did this:

> 8. Open a terminal and run 'lspci -k' 
>     - Both displays are activated and remain active.
>     - There is no timeout.
>     - This is desired behavior.

There is one such wake in the dmesg, this:

[   60.126328] thunderbolt 0000:06:00.0: control channel starting...
[   60.126332] thunderbolt 0000:06:00.0: starting TX ring 0
[   60.126337] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 -> 0x1)
[   60.126339] thunderbolt 0000:06:00.0: starting RX ring 0
[   60.126344] thunderbolt 0000:06:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 -> 0x1001)
[   60.126347] thunderbolt 0000:06:00.0: 0: resuming switch
[   60.126348] thunderbolt 0000:06:00.0: restoring Switch at 0x0 (depth: 0, up port: 15)
[   60.128535] thunderbolt 0000:06:00.0: 0: disabling wakeup
[   60.129481] thunderbolt 0000:06:00.0: acking hot plug event on 0:13
[   60.129601] thunderbolt 0000:06:00.0: acking hot plug event on 0:14
[   60.129730] thunderbolt 0000:06:00.0: acking hot plug event on 0:16

but here we get plug event for all the DP IN adapters (13, 14, 16) which
tells me that there is nothing connected to the Type-C ports. Otherwise
it would not send the plug event. This may be due the older firmware.

[   60.137467] thunderbolt 0000:06:00.0: 0: TMU: supports uni-directional mode
[   60.137478] thunderbolt 0000:06:00.0: 0: TMU: supports enhanced uni-directional mode
[   60.137589] thunderbolt 0000:06:00.0: 0: TMU: current mode: off
[   60.137591] thunderbolt 0000:06:00.0: 0: TMU: mode change off -> bi-directional, HiFi requested
[   60.138102] thunderbolt 0000:06:00.0: 0: TMU: mode set to: bi-directional, HiFi
[   60.139778] thunderbolt 0000:06:00.0: 0:13: DP IN resource available after hotplug
[   60.139783] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[   60.139895] thunderbolt 0000:06:00.0: 0:13: DP IN available
[   60.139896] thunderbolt 0000:06:00.0: no suitable DP OUT adapter available, not tunneling
[   60.140018] thunderbolt 0000:06:00.0: 0:14: DP IN resource available after hotplug
[   60.140021] thunderbolt 0000:06:00.0: looking for DP IN <-> DP OUT pairs:
[   60.140145] thunderbolt 0000:06:00.0: 0:13: DP IN available
[   60.140277] thunderbolt 0000:06:00.0: 0:14: DP IN available
[   60.140278] thunderbolt 0000:06:00.0: no suitable DP OUT adapter available, not tunneling
[   78.863111] thunderbolt 0000:06:00.0: 0: suspending switch
[   78.863125] thunderbolt 0000:06:00.0: 0: enabling wakeup: 0x3f
[   78.864812] thunderbolt 0000:06:00.0: stopping RX ring 0
[   78.864825] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001 -> 0x1)
[   78.864849] thunderbolt 0000:06:00.0: stopping TX ring 0
[   78.864857] thunderbolt 0000:06:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
[   78.864870] thunderbolt 0000:06:00.0: control channel stopped

There is no unplug at all here so the domain can go back to runtime
suspend.

