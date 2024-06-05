Return-Path: <linux-kernel+bounces-202573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A602A8FCE26
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC9E1F2AE27
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A391F1B3730;
	Wed,  5 Jun 2024 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AuH2yI1E";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AuH2yI1E"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79724198829;
	Wed,  5 Jun 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589802; cv=none; b=aj4V4ojmqOA987BM4mCuMG0B3ORMdXcobFxbs9+wW01g6rjfl9WiLlfqNmjVFYbkD+9TVLbZxfHtK3ml0ZdPT3YXkfPPCk5b3cpr/BtVZEtvo//tcl4yOUjkkOXK4eGtEuJ3/3MkW3MbwfJEm4HjCe0ZuzC3WMZ+Pv/M/Pru8b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589802; c=relaxed/simple;
	bh=ttznAQj8OtahjFdIB6SxiYmBotlMxNyBkBZbV6mbd8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEHzYEbHjX3dyFb1zHBdYkl/4WcT0ZeM87LFdJhmbnUiOfViWXlajOG+siUuS9kEojIKhAsaVh5CAJVFKOvRzwoGftssB+qe9lpc7yQOVD1+Qvg39Nl1G9zCAH/ldjHJjvhL3han12FhVIGSy9NL8AZz+hit5CRX79uyUSIey38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AuH2yI1E; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AuH2yI1E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 432B61F804;
	Wed,  5 Jun 2024 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717589798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cfu1hMMcSot+uvyktv0Hg4ZL4BpgrZy6tqK6D6Rcll4=;
	b=AuH2yI1EiKMnRA2BAVlxnFK375fffl6elpqUKxECS2Xv9ECbYZwAScSImJi1rRLIHLmM2f
	TlGy8avxHnGzWakIl0OFdUNjeg3Zb5QrIC7s5CS2/2Hykyk7BeKwRPVkC863678SFSRK1a
	MtlPcU5g7xtNvShgD4rUVRSsyDFJe4k=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717589798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cfu1hMMcSot+uvyktv0Hg4ZL4BpgrZy6tqK6D6Rcll4=;
	b=AuH2yI1EiKMnRA2BAVlxnFK375fffl6elpqUKxECS2Xv9ECbYZwAScSImJi1rRLIHLmM2f
	TlGy8avxHnGzWakIl0OFdUNjeg3Zb5QrIC7s5CS2/2Hykyk7BeKwRPVkC863678SFSRK1a
	MtlPcU5g7xtNvShgD4rUVRSsyDFJe4k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28D4D13A24;
	Wed,  5 Jun 2024 12:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MIjnBiZXYGYMBgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 05 Jun 2024 12:16:38 +0000
Date: Wed, 5 Jun 2024 14:16:37 +0200
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org,
	Yanfei Xu <yanfei.xu@windriver.com>,
	Pavel Skripkin <paskripkin@gmail.com>
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2021-47472: net: mdiobus: Fix memory leak in
 __mdiobus_register
Message-ID: <ZmBXJWZyOhI5614_@tiehlicka>
References: <2024052228-CVE-2021-47472-bd55@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052228-CVE-2021-47472-bd55@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,windriver.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Fix for this CVE ab609f25d198 ("net: mdiobus: Fix memory leak in
__mdiobus_register") has been later reverted by 10eff1f5788b ("Revert
"net: mdiobus: Fix memory leak in __mdiobus_register"") which itself is
not recognized as a CVE fix.

Reading through the revert I am quite confused TBH. It claims there
is some problem but also that this is not the right fix. That would
suggest that there is a CVE but it should be addressed by a different
fix. Can anybody clarify please?

On Wed 22-05-24 08:23:38, Greg KH wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> net: mdiobus: Fix memory leak in __mdiobus_register
> 
> Once device_register() failed, we should call put_device() to
> decrement reference count for cleanup. Or it will cause memory
> leak.
> 
> BUG: memory leak
> unreferenced object 0xffff888114032e00 (size 256):
>   comm "kworker/1:3", pid 2960, jiffies 4294943572 (age 15.920s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 08 2e 03 14 81 88 ff ff  ................
>     08 2e 03 14 81 88 ff ff 90 76 65 82 ff ff ff ff  .........ve.....
>   backtrace:
>     [<ffffffff8265cfab>] kmalloc include/linux/slab.h:591 [inline]
>     [<ffffffff8265cfab>] kzalloc include/linux/slab.h:721 [inline]
>     [<ffffffff8265cfab>] device_private_init drivers/base/core.c:3203 [inline]
>     [<ffffffff8265cfab>] device_add+0x89b/0xdf0 drivers/base/core.c:3253
>     [<ffffffff828dd643>] __mdiobus_register+0xc3/0x450 drivers/net/phy/mdio_bus.c:537
>     [<ffffffff828cb835>] __devm_mdiobus_register+0x75/0xf0 drivers/net/phy/mdio_devres.c:87
>     [<ffffffff82b92a00>] ax88772_init_mdio drivers/net/usb/asix_devices.c:676 [inline]
>     [<ffffffff82b92a00>] ax88772_bind+0x330/0x480 drivers/net/usb/asix_devices.c:786
>     [<ffffffff82baa33f>] usbnet_probe+0x3ff/0xdf0 drivers/net/usb/usbnet.c:1745
>     [<ffffffff82c36e17>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
>     [<ffffffff82661d17>] call_driver_probe drivers/base/dd.c:517 [inline]
>     [<ffffffff82661d17>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
>     [<ffffffff826620bc>] really_probe drivers/base/dd.c:558 [inline]
>     [<ffffffff826620bc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
>     [<ffffffff826621ba>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
>     [<ffffffff82662a26>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
>     [<ffffffff8265eca7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
>     [<ffffffff826625a2>] __device_attach+0x122/0x260 drivers/base/dd.c:969
>     [<ffffffff82660916>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
>     [<ffffffff8265cd0b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3359
>     [<ffffffff82c343b9>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2170
>     [<ffffffff82c4473c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
> 
> BUG: memory leak
> unreferenced object 0xffff888116f06900 (size 32):
>   comm "kworker/0:2", pid 2670, jiffies 4294944448 (age 7.160s)
>   hex dump (first 32 bytes):
>     75 73 62 2d 30 30 31 3a 30 30 33 00 00 00 00 00  usb-001:003.....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81484516>] kstrdup+0x36/0x70 mm/util.c:60
>     [<ffffffff814845a3>] kstrdup_const+0x53/0x80 mm/util.c:83
>     [<ffffffff82296ba2>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
>     [<ffffffff82358d4b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
>     [<ffffffff826575f3>] dev_set_name+0x63/0x90 drivers/base/core.c:3147
>     [<ffffffff828dd63b>] __mdiobus_register+0xbb/0x450 drivers/net/phy/mdio_bus.c:535
>     [<ffffffff828cb835>] __devm_mdiobus_register+0x75/0xf0 drivers/net/phy/mdio_devres.c:87
>     [<ffffffff82b92a00>] ax88772_init_mdio drivers/net/usb/asix_devices.c:676 [inline]
>     [<ffffffff82b92a00>] ax88772_bind+0x330/0x480 drivers/net/usb/asix_devices.c:786
>     [<ffffffff82baa33f>] usbnet_probe+0x3ff/0xdf0 drivers/net/usb/usbnet.c:1745
>     [<ffffffff82c36e17>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
>     [<ffffffff82661d17>] call_driver_probe drivers/base/dd.c:517 [inline]
>     [<ffffffff82661d17>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
>     [<ffffffff826620bc>] really_probe drivers/base/dd.c:558 [inline]
>     [<ffffffff826620bc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
>     [<ffffffff826621ba>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
>     [<ffffffff82662a26>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
>     [<ffffffff8265eca7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
>     [<ffffffff826625a2>] __device_attach+0x122/0x260 drivers/base/dd.c:969
> 
> The Linux kernel CVE team has assigned CVE-2021-47472 to this issue.
> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 4.4.290 with commit fd2400dd4f1b
> 	Fixed in 4.4.291 with commit b89f4537d7fd
> 	Fixed in 4.9.288 with commit bc5f2f3431ce
> 	Fixed in 4.9.289 with commit 2bc10dca9432
> 	Fixed in 4.14.253 with commit 4ec0f9abc512
> 	Fixed in 4.14.254 with commit fdbffd95c4ce
> 	Fixed in 4.19.214 with commit a9831afa2dc8
> 	Fixed in 4.19.215 with commit 8121d0d4fd10
> 	Fixed in 5.4.156 with commit b0feaa8376f5
> 	Fixed in 5.4.157 with commit 6a18d155d5b3
> 	Fixed in 5.10.76 with commit 3a0dc2e35a5d
> 	Fixed in 5.10.77 with commit c828115a14ea
> 	Fixed in 5.14.15 with commit 0c4e87ba11eb
> 	Fixed in 5.14.16 with commit 8ba94a7f7b9f
> 	Fixed in 5.15 with commit ab609f25d198
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2021-47472
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	drivers/net/phy/mdio_bus.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/fd2400dd4f1b8bd7a309b1b424d9e0d188151b01
> 	https://git.kernel.org/stable/c/b89f4537d7fdbd0bafb6d8a66a484e0bc99871a4
> 	https://git.kernel.org/stable/c/bc5f2f3431ced08300e4cb3aff35f1da14c26433
> 	https://git.kernel.org/stable/c/2bc10dca9432fadb09e45127e258fc7127fd346d
> 	https://git.kernel.org/stable/c/4ec0f9abc512cc02fb04daa89ccf6697e80ab417
> 	https://git.kernel.org/stable/c/fdbffd95c4ce94d2197c504008eaac46b16bc5a4
> 	https://git.kernel.org/stable/c/a9831afa2dc8a18205403907c41aa4e0950ac611
> 	https://git.kernel.org/stable/c/8121d0d4fd108280f5cd7b7fe8c6592adaa37be9
> 	https://git.kernel.org/stable/c/b0feaa8376f52357bf2fd020d0c471713a859728
> 	https://git.kernel.org/stable/c/6a18d155d5b35ad50c8fac2be091212487ae58ec
> 	https://git.kernel.org/stable/c/3a0dc2e35a5d6546b1db87fe985582dadc64fe7b
> 	https://git.kernel.org/stable/c/c828115a14eacbf42042770fd68543f134e89efa
> 	https://git.kernel.org/stable/c/0c4e87ba11eb331dca2315d484d08441b8c13193
> 	https://git.kernel.org/stable/c/8ba94a7f7b9fc2a2b808ccceb99b77135deae21a
> 	https://git.kernel.org/stable/c/ab609f25d19858513919369ff3d9a63c02cd9e2e

-- 
Michal Hocko
SUSE Labs

