Return-Path: <linux-kernel+bounces-252099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7271930E69
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4AD1F2161B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E618309A;
	Mon, 15 Jul 2024 07:02:36 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1A94C9A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721026955; cv=none; b=UAjCkHnE1OLjAyrzh8cQT8LBj5SBVF1PCg9J2aHnPVHjCW+EHkywPrORSneS9GI117ywlwA2koVi68nZXYojfjod3NbmnJtJMsC/0qmc2r/KjNgQZY/FRWjODvfh2wWUTlYBpfOgPNN+uyJNj7ewCqQEkRv0GkSJhjIRr7q4zd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721026955; c=relaxed/simple;
	bh=tJy9xtAm63dF5nXD3QRH/UIwYufvHPdhRunAQqauj94=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=b0yzlACutkLdwgYV78AvY51toBwlV05ejWGvqmmf/sIgp0cyoUZ8B/s5YPuXUNeo5NbwlSjH4MDMJhqkrs7zyDyWRgm2czY4bvVfByVQOfxqNsWTwdkJNiU7VEsaGI81TQjBwhNsi+dcj5SIqs1ShrpsIKNMdnbI/Pq7bfu2psI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WMtMS1smCzQldV;
	Mon, 15 Jul 2024 14:58:28 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 657391800A1;
	Mon, 15 Jul 2024 15:02:29 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 15:02:28 +0800
Message-ID: <3e66f3b9-668e-06bd-6088-43de9667fce9@huawei.com>
Date: Mon, 15 Jul 2024 15:02:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
From: Yu Liao <liaoyu15@huawei.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<liwei391@huawei.com>
Subject: [bug report] drm/vblank: Hard lockup in __disable_vblank()
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)

Hi,

A hard lockup is happened when I do fuzz test with syzkaller.

Kernel panic - not syncing: Hard LOCKUP
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.6.0+ #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 hrtimer_cancel+0x52/0x70 kernel/time/hrtimer.c:1449
 __disable_vblank drivers/gpu/drm/drm_vblank.c:434 [inline]
 drm_vblank_disable_and_save+0x27f/0x3c0 drivers/gpu/drm/drm_vblank.c:478
 vblank_disable_fn+0x15d/0x1b0 drivers/gpu/drm/drm_vblank.c:495
 call_timer_fn+0x39/0x280 kernel/time/timer.c:1700
 expire_timers+0x22d/0x3c0 kernel/time/timer.c:1751
 __run_timers kernel/time/timer.c:2022 [inline]
 run_timer_softirq+0x315/0x8a0 kernel/time/timer.c:2035
 handle_softirqs+0x195/0x580 kernel/softirq.c:553
 __do_softirq kernel/softirq.c:587 [inline]
 </IRQ>

This is a deadlock issue as follows:

    CPU3				CPU 7

vblank_disable_fn()
  drm_vblank_disable_and_save()
  spin_lock(vblank_time_lock)
				hrtimer_interrupt()
				  vkms_vblank_simulate()
				    drm_handle_vblank()
				      //wait for CPU3 to release vblank_time_lock
				      spin_lock(vblank_time_lock)
    vkms_disable_vblank()
      //wait for vblank_hrtimer on CPU7 to finish
      hrtimer_cancel(vblank_hrtimer)

The call of hrtimer_cancel() should not hold locks which would prevent
completion of the hrtimer's callback function.

Best regards,
Yu

