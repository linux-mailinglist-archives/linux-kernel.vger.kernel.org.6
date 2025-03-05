Return-Path: <linux-kernel+bounces-547994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8BBA53E9D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3351891BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8B4207A0A;
	Wed,  5 Mar 2025 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2u2jxdq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E251EF0BC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218140; cv=none; b=nwwa5AxzwBp+XYE6LCJcpoVdgSDV52vfKrGotpbzlMaEZo63It6aSjz3ucbsDcXnOjipJqax29F3otpe8FBjr02TLQNGPrnPO5CIG5pYcw/DKXsTaniyVFerI1GVVF1olUNZu78y4JAQqh4HUty6/Cwwh1VU16bQkL0+Yaa+R/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218140; c=relaxed/simple;
	bh=gHBiQTwQLmIhSXn9apA53QiF78YO3bY0hmrA3pxSyxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=madlQQcjxF5a2bqYWiKpZpC8IuDzvOcdXZSaUbdnjL8GOfdqGKJVjxKbqD6HJnWXUxvtU8P1o7oI9lDgslIDE+o4ldSxNySshUT7+T3XurQcHsRSK21NO6pg2aEn4L4EQYqCEvY2gsenTJ/WjfCeJaxylfs3ks3S2D7/dicnyM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2u2jxdq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741218139; x=1772754139;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gHBiQTwQLmIhSXn9apA53QiF78YO3bY0hmrA3pxSyxM=;
  b=Y2u2jxdqL+DSGM+0iP4wnasNwFQAC4fPqdYtaotwcyqE9U0kiNa1sV7O
   A7JTHgdVBl7vaRkF6Lt3MpiaRwJRUua389fl+ZtNoZn1wkV4dTAsN/fuI
   W+VZscSfdA2Be4n8park+UPNAH/RY4Su4fhLYrSHwCr/Awm7i8dTgT1Xi
   7ISpJlxR81YsQd4Brjbn7nWHknoGRKLtPgRrWUSR8I+tSMJrfuaTR/7eC
   cQZQYZRQ0TdrHN9m5OT4BXfkkyD6QL66q/Gdmtq54Y3HoGlmrXv+JRzec
   vatt9femBM7B7e9FS1P1dI3V7ql+DeXnPEGf2HsYl1KKSI1xunTPb1Nst
   A==;
X-CSE-ConnectionGUID: uyKR+0ZcTPqMYAEMow+57g==
X-CSE-MsgGUID: w2yciMt1SsmfQmNreHYgkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45979246"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="45979246"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:42:18 -0800
X-CSE-ConnectionGUID: kw83umn4TL6DgRwjrq52wQ==
X-CSE-MsgGUID: x2WseLZaTKqMXbgmSOVTfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124041827"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.196]) ([10.125.109.196])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:42:17 -0800
Message-ID: <7a212431-5320-464b-a357-507fa6511586@intel.com>
Date: Wed, 5 Mar 2025 15:42:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Some applications under Windows 11 libvirt
 VM crash since commit 408eb7417a92c5354c7be34f7425b305dfe30ad9
To: Miguel Ruiz <miguelies.ruiz@gmail.com>, ravi.bangoria@amd.com,
 tglx@linutronix.de, thomas.lendacky@amd.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, xin@zytor.com, tony.luck@intel.com,
 pawan.kumar.gupta@linux.intel.com, andriy.shevchenko@linux.intel.com,
 jgross@suse.com, linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 christian@heusel.eu, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
References: <CAMEKE0Hd3S0-25afhWQhNNitbc7njp0ftO+Y3QmgS6CyFQh4ww@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAMEKE0Hd3S0-25afhWQhNNitbc7njp0ftO+Y3QmgS6CyFQh4ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/5/25 15:30, Miguel Ruiz wrote:
> Hello everyone,
> 
> I have encountered a regression in the kernel where certain applications
> under Windows 11 in libvirt completely crash. I've reported this on the
> arch linux forums <https://bbs.archlinux.org/viewtopic.php?pid=2229827>
> and we've narrowed down the cause as this diff <https://lore.kernel.org/
> all/20240808062937.1149-3-ravi.bangoria@amd.com/> enabling bus lock
> support. Huge thanks to Christian Heusel <mailto:christian@heusel.eu>
> who went through the painstaking process to bisect and build various
> kernel images for me to test.
> 
> I'd like to list my desktop PC specifications for some context:
> 
>   * Motherboard - Asrock B650m Pro RS
>   * Processor - AMD Ryzen 7 9800x3d
>   * Graphics Card - Nvidia Geforce RTX 3060 12GB
>   * Memory - Silicon Power Zenith 64GB DDR5-6000 CL30
>   * Storage - 
>       o Western Digital SN580 1TB nvme SSD (Arch Linux is here)
>       o Crucial MX300 750GB sata SSD
>       o Seagate BarraCuda ST8000DM004 8TB sata HD
> 
> My Windows 11 qcow image is on the nvme and I'm passing through the
> other 2 sata drives. I've pinned and isolated 7 cores from the host to
> use on the VM. My RTX 3060 is also passed through into the VM (thus
> isolated from being used on the host via the vfio-pci.ids flag). I share
> the mice & keyboard via evdev.
> 
> The issue does not manifest itself across all applications. E.G. Firefox
> & the Epic Games client are unaffected, but the Steam client immediately
> exits (crashes?) as soon as you attempt to download, update, or
> uninstall a game. Certain games such as Yooka Laylee also refuse to
> launch properly & exit immediately as well. On kernel versions prior to
> this, no such issue occurs and all applications work normally as
> expected. Furthermore, when booting the host system with the kernel
> argument: "split_lock_detect=off", on modern kernel versions, the issue
> goes away providing more evidence that the commit mentioned above is the
> cause. This issue is also consistent across a standard Windows 10 VM
> with no GPU passthrough or other special customization.
> 
> Please let me know if there is more information I can provide. I'll be
> happy to help with any logs/reports or any other debug info and test any
> potential fixes. If the fix is found, please make sure to credit
> Christian Heusel <mailto:christian@heusel.eu> like so!
> 
> Bisected-by: Christian Heusel <christian@heusel.eu
> <mailto:christian@heusel.eu>>

I'm leaving all the context in because the HTML from the original will
make sure it won't make it to the lists.

I'm also cc'ing the KVM folks. I don't actually know how the #GP from
the split lock detection will manifest to KVM guests. I'm kinda
surprised it crashes the guest app and doesn't do anything more noisy.

Is there anything in the Linux logs (dmesg) of interest?

We've had a few other reports of split lock detection triggering in
Linux applications. But, we've either just tuned down the aggressiveness
of the detection or told people to turn it off. We haven't treated split
lock detection activation as a regression up to this point, just a
feature working as intended.


