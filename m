Return-Path: <linux-kernel+bounces-182630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF08C8D86
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A031F22926
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF56360B9C;
	Fri, 17 May 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ainBj5Ga"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243EF2F30
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715979906; cv=none; b=DtI4t6/H9Sjf4TjEhWuw9Wds8n6D/ZBQL9oa+A+CHTSHc3yEXKiHrhesbg85EKXccsFtcR/snKIWl1gPFojOSWL2Txm86rSicW7j4fnMMcGpKKenWc1itVmn2rgmSoDUSjpULFXPaXRLfkEipbHOa5dQddyW8f1YOClDRkMSm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715979906; c=relaxed/simple;
	bh=jwm5d7c0FPHAQdtFzv2L3yxm+UOx5J8jba6GP6nf0Hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RAT/3F8+aqZuO2wPtDABYsWADPedqXvabNoX9pt2Pcqn3kP/bQHxFjqWxzK+KxG0/iArq9m+xBEjmWoomfJgevDOi7dKte764L4XK4vBm3yWg4Aelgzia6hQ4AuHWBqAxjB0w3vkALDLhChYhLFeyu8xAWxSsrkGh9AwjmgkMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ainBj5Ga; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715979904; x=1747515904;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=jwm5d7c0FPHAQdtFzv2L3yxm+UOx5J8jba6GP6nf0Hk=;
  b=ainBj5Ga5X2CioMQNO0gVLymc0HzGmF8NVZul/Sz/Er9cUS8ceIg4yoS
   NrpKqjf3rsxngPNojVxyXSnWp6ZRu5/9ZGihQX2FbL/7xsqL4RSojCtf1
   LRc+AzC83PnYTIK45s+QzfvLwC73jDuQr2KQrAH0ZRt1fixK49JztqNkE
   zoxc0O8cuaaDbHVP7QDpnNnc7Dfs5WKyBo35/36V3/ojTltTY3hR/NEnK
   AeIok6Mpok4uIMP3asyHSoiymcLeVPz0WwpW18LQX5hQCVK2cuA30hwEd
   7ioKQ1QTucp8Tws9uqVx1F0lh6zEItJlDvLyo8KtY6WbLvNos5g7RVkW7
   Q==;
X-CSE-ConnectionGUID: e2l/HvD8RGORXyCxhfxwIg==
X-CSE-MsgGUID: x6LEnA/oSd6Jtbov9L6eJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="34691831"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="34691831"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 14:05:03 -0700
X-CSE-ConnectionGUID: w5DNbwUZTKOokIxhdwKyew==
X-CSE-MsgGUID: Kpr25AmASlaKfZN+/BIhYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="36820155"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.241.229.15])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 14:05:03 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Linux List Kernel
 Mailing <linux-kernel@vger.kernel.org>, vinschen@redhat.com,
 hkelam@marvell.com, naamax.meir@linux.intel.com,
 anthony.l.nguyen@intel.com
Cc: intel-wired-lan@lists.osuosl.org
Subject: Re: 6.10;regression;bisected - commit 86167183a17e cause info msg
 "trying to register non-static key"
In-Reply-To: <CABXGCsOkiGxAfA9tPKjYX7wqjBZQxqK2PzTcW-RgLfgo8G74EQ@mail.gmail.com>
References: <CABXGCsOkiGxAfA9tPKjYX7wqjBZQxqK2PzTcW-RgLfgo8G74EQ@mail.gmail.com>
Date: Fri, 17 May 2024 14:05:03 -0700
Message-ID: <87zfso6tfk.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

+ intel-wired-lan

Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> writes:

> Hi,
> I am here to test unstable kernels.
> Yesterday at Fedora Rawhide arrived the new kernel
> 20240515git1b294a1f3561 and I spotter in kernel log new "red" message
> with follow stacktrace:
> [    8.471610] nvme nvme1: pci function 0000:0e:00.0
> [    8.471616] nvme nvme0: pci function 0000:04:00.0
> [    8.492638] nvme nvme1: 32/0/0 default/read/poll queues
> [    8.496190] nvme nvme0: 31/0/0 default/read/poll queues
> [    8.507051]  nvme0n1: p1 p2 p3
> [    8.522270] INFO: trying to register non-static key.
> [    8.522273] The code is fine but needs lockdep annotation, or maybe
> [    8.522274] you didn't initialize this object before use?
> [    8.522275] turning off the locking correctness validator.
> [    8.522276] CPU: 31 PID: 683 Comm: (udev-worker) Not tainted
> 6.10.0-0.rc0.20240515git1b294a1f3561.4.fc41.x86_64+debug #1
> [    8.522278] Hardware name: ASUS System Product Name/ROG STRIX
> B650E-I GAMING WIFI, BIOS 2611 04/07/2024
> [    8.522280] Call Trace:
> [    8.522281]  <TASK>
> [    8.522282]  dump_stack_lvl+0x84/0xd0
> [    8.522287]  register_lock_class+0xd84/0x1000
> [    8.522291]  ? __pfx_register_lock_class+0x10/0x10
> [    8.522293]  __lock_acquire+0x3d2/0x5c70
> [    8.522295]  ? debug_object_free+0x298/0x550
> [    8.522297]  ? __pfx_debug_object_free+0x10/0x10
> [    8.522299]  ? __pfx_lock_release+0x10/0x10
> [    8.522301]  ? __pfx___lock_acquire+0x10/0x10
> [    8.522302]  ? hrtimer_try_to_cancel+0x22/0x460
> [    8.522305]  lock_acquire+0x1ae/0x540
> [    8.522307]  ? igc_ptp_clear_tx_tstamp+0x38/0x1b0 [igc]
> [    8.522321]  ? __pfx_lock_acquire+0x10/0x10
> [    8.522323]  ? seqcount_lockdep_reader_access.constprop.0+0xa5/0xb0
> [    8.522325]  ? lockdep_hardirqs_on+0x7c/0x100
> [    8.522326]  ? seqcount_lockdep_reader_access.constprop.0+0xa5/0xb0
> [    8.522329]  _raw_spin_lock_irqsave+0x51/0xa0
> [    8.522330]  ? igc_ptp_clear_tx_tstamp+0x38/0x1b0 [igc]
> [    8.522337]  igc_ptp_clear_tx_tstamp+0x38/0x1b0 [igc]
> [    8.522344]  igc_ptp_set_timestamp_mode+0x3cc/0x700 [igc]
> [    8.522350]  ? igc_power_down_phy_copper+0xf1/0x140 [igc]
> [    8.522358]  igc_ptp_reset+0x3b/0x5e0 [igc]
> [    8.530693]  ? igc_set_eee_i225+0xfd/0x1e0 [igc]
> [    8.530706]  igc_reset+0x2d9/0x3d0 [igc]
> [    8.531707]  igc_probe+0x14ca/0x1e20 [igc]
> [    8.531715]  ? _raw_spin_unlock_irqrestore+0x4f/0x80
> [    8.531717]  ? __pfx_igc_probe+0x10/0x10 [igc]
> [    8.531723]  local_pci_probe+0xdc/0x180
> [    8.531727]  pci_device_probe+0x23c/0x810
> [    8.531729]  ? kernfs_add_one+0x3ab/0x4a0
> [    8.534068]  ? kernfs_new_node+0x13d/0x240
> [    8.534070]  ? __pfx_pci_device_probe+0x10/0x10
> [    8.534072]  ? kernfs_create_link+0x16e/0x240
> [    8.534074]  ? kernfs_put+0x1c/0x40
> [    8.534076]  ? sysfs_do_create_link_sd+0x8e/0x100
> [    8.534078]  really_probe+0x1e0/0x8a0
> [    8.536433]  __driver_probe_device+0x18c/0x370
> [    8.536436]  driver_probe_device+0x4a/0x120
> [    8.536438]  __driver_attach+0x194/0x4a0
> [    8.536439]  ? __pfx___driver_attach+0x10/0x10
> [    8.536441]  bus_for_each_dev+0x106/0x190
> [    8.536443]  ? __pfx_bus_for_each_dev+0x10/0x10
> [    8.536445]  bus_add_driver+0x2ff/0x530
> [    8.536448]  driver_register+0x1a5/0x360
> [    8.536449]  ? __pfx_igc_init_module+0x10/0x10 [igc]
> [    8.536456]  do_one_initcall+0xd6/0x460
> [    8.536459]  ? __pfx_do_one_initcall+0x10/0x10
> [    8.536461]  ? kasan_unpoison+0x44/0x70
> [    8.536464]  do_init_module+0x296/0x7c0
> [    8.536466]  load_module+0x567b/0x74f0
> [    8.536470]  ? __pfx_load_module+0x10/0x10
> [    8.536473]  ? __might_fault+0x9d/0x120
> [    8.536475]  ? local_clock_noinstr+0xd/0x100
> [    8.536478]  ? __pfx___might_resched+0x10/0x10
> [    8.536481]  ? __do_sys_init_module+0x1ef/0x220
> [    8.536482]  __do_sys_init_module+0x1ef/0x220
> [    8.536483]  ? __pfx___do_sys_init_module+0x10/0x10
> [    8.536487]  do_syscall_64+0x97/0x190
> [    8.536490]  ? lockdep_hardirqs_on_prepare+0x171/0x400
> [    8.536492]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    8.536494] RIP: 0033:0x7f29997265ae
> [    8.536499] Code: 48 8b 0d 85 a8 0c 00 f7 d8 64 89 01 48 83 c8 ff
> c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 52 a8 0c 00 f7 d8 64 89
> 01 48

It seems I have missed this following flow (in reverse):

+ igc_ptp_clear_tx_tstamp
  + igc_ptp_disable_tx_timestamp
    + igc_ptp_set_timestamp_mode
      + igc_ptp_reset
        + igc_reset
          + igc_probe

And that in igc_ptp_clear_tx_tstamp(), it uses ->ptp_tx_lock. So
igc_ptp_init() needs to be called before igc_reset().

I think that is what this splat is telling us.

Don't know what's the best way forward, reverting the commit in question
or trying to fix the initial problem some other way?

> [    8.536500] RSP: 002b:00007ffee505bff8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000af
> [    8.536502] RAX: ffffffffffffffda RBX: 000055eafe4a2ac0 RCX: 00007f29997265ae
> [    8.536503] RDX: 00007f2998e6007d RSI: 00000000001067d6 RDI: 00007f299828c010
> [    8.536504] RBP: 00007ffee505c0b0 R08: 000055eafe43a010 R09: 0000000000000007
> [    8.536505] R10: 0000000000000007 R11: 0000000000000246 R12: 00007f2998e6007d
> [    8.536506] R13: 0000000000020000 R14: 000055eafe476280 R15: 000055eafe4a25a0
> [    8.536508]  </TASK>
> [    8.542741] pps pps0: new PPS source ptp0
> [    8.550932] igc 0000:0a:00.0 eth0: PHC added
> [    8.550992] igc 0000:0a:00.0: 4.000 Gb/s available PCIe bandwidth
> (5.0 GT/s PCIe x1 link)
> [    8.550996] igc 0000:0a:00.0 eth0: MAC: e8:9c:25:6c:40:75
> [    8.558160] igc 0000:0a:00.0 eno1: renamed from eth0
>
> Of course, I immediately wanted to find the first bad commit.
> And now it has already been found:
> 86167183a17e03ec77198897975e9fdfbd53cb0b is the first bad commit
> commit 86167183a17e03ec77198897975e9fdfbd53cb0b (HEAD)
> Author: Corinna Vinschen <vinschen@redhat.com>
> Date:   Tue Apr 23 12:24:54 2024 +0200
>
>     igc: fix a log entry using uninitialized netdev
>
>     During successful probe, igc logs this:
>
>     [    5.133667] igc 0000:01:00.0 (unnamed net_device)
> (uninitialized): PHC added
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     The reason is that igc_ptp_init() is called very early, even before
>     register_netdev() has been called. So the netdev_info() call works
>     on a partially uninitialized netdev.
>
>     Fix this by calling igc_ptp_init() after register_netdev(), right
>     after the media autosense check, just as in igb.  Add a comment,
>     just as in igb.
>
>     Now the log message is fine:
>
>     [    5.200987] igc 0000:01:00.0 eth0: PHC added
>
>     Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
>     Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
>     Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>     Tested-by: Naama Meir <naamax.meir@linux.intel.com>
>     Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>
>  drivers/net/ethernet/intel/igc/igc_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> The next step I was convinced that reverting the commit 86167183a17e
> removed this info message.

Thank you for the effort.

>
> I also attach here a full kernel log and build config.
>
> My hardware specs: https://linux-hardware.org/?probe=98ecbf3636
>
> I hope it helps.
>
> -- 
> Best Regards,
> Mike Gavrilov.


Cheers,
-- 
Vinicius

