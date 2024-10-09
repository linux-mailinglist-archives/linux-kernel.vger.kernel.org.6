Return-Path: <linux-kernel+bounces-356394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D2B996068
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD302847CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35B717E019;
	Wed,  9 Oct 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMsgE3q2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691717CA1B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458056; cv=none; b=WHmbsnWudBpeg/iVmgM8LZDCGrQC3PY9ckTm7l0beH9nk2cdE7rTU34WjyURpcHhflwbKopvy4NnXzO6jT/Q0NDoHMeYhNm3Q9fSiDfBW5VGz+5bGtO8NqapKdgTjWiMMN/uJB/AsOORf6oNPhWds+4mnmRXuSzw6yVmsERCK/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458056; c=relaxed/simple;
	bh=aDoHE8RcSoe/qHvxgNZkD+fbkAoDyxaWrS/TkXut4mQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ol/Lb09C8WShsTbh/K0IrzLVESzA9nqCJKZF2gb6Bqb6HzhJprFZyzWnH/GFVodd7AZLLyyalLmy7y86uDShbweIiXmYyEGpXNqCtYm5cXL+KBtGzRU8CnEEixEA+UZ6HWJwNBEMn6PTv9CLCzhbrzPffDrZ9i8cUbmPkKV/yuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMsgE3q2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728458053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=25pktMz5RoTx7Pcnc0jL/M/WUgdYImU57xhGrqCGL5o=;
	b=PMsgE3q2KYJXzwN4gOXXtYEETwuH9ijc4nOSgaSHP6O6fMJAb37VR8gICrIwwG0sRBK4Ci
	zQ1vezM+DPRxj8lN6wU2HpfBbyrzWvwmj+a0FiJ2j/+Nz4i/zsE0T/H4ScP0E4+MPLv7nj
	2YQ1sQoECH6rwYf9k1obFg38gLbO56Q=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-gE4_UdBJNmqbRqk3kFy7rA-1; Wed, 09 Oct 2024 03:13:42 -0400
X-MC-Unique: gE4_UdBJNmqbRqk3kFy7rA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-204e310e050so79805155ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728458019; x=1729062819;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25pktMz5RoTx7Pcnc0jL/M/WUgdYImU57xhGrqCGL5o=;
        b=q7Jg2Y2+vgxdeBT+m0SjF/18Mh/rxsSme0PlnIo6A60MWjs7+4UAPoOLkNleicls3v
         BEqebBP7bUiZt5hycV0RPj8VjyA0sUE8YCSMRiM32PvDYDh3QaaBw1xo59vUoX+tJkSK
         x8u1roldjp6yJwQ+kDef9S7xLQfi6/iXH9NCNweqK2eZAA35+SzGqevq2wxGI3L3rRz5
         luXMWj6KT1iW1Ejb46dPwwAJw35Soe3ByPrAevA7tTipo5Y+Q08kVMDLicARuh88V/HA
         u7jPc2UIAxu8wE8VkPmnQaOXtAJXDJNvAklA8FGKmMfF3aQ7QpmteIVQpWhsWDcWPfRL
         3iBw==
X-Gm-Message-State: AOJu0Ywz5882J3ageYgByPfX6+LIG6gnaus0bZN0Jzaq7dOpqDCNdrUS
	62Qw+JrLm2sYe9Q+JvOij5iH+H3nPc4JBTneTjqFSmqAT4KKFNGIPjCUi+vn0FjqszKv9zZ1An+
	i51bq0s7eH5PP1K8K5VzQ4H8vkggYG4ir0SRKbmEzTJG9OZKvSmG4CADgiMEEnl09Kxhwic0nWL
	Xlad6YaBC36igDzOBnjWQISOVz0znh6YJiAXaFWjsXryNtn76uZA==
X-Received: by 2002:a17:903:4113:b0:20b:93be:a2a6 with SMTP id d9443c01a7336-20c6377f86cmr19309665ad.44.1728458019575;
        Wed, 09 Oct 2024 00:13:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1iefx5f/jcXsrsqgyPGHtcnETilbnJuUmSSgwgVKJBRArRvZ+b4zC+K2rAjfKmtN0rSB+UDWzi5xDMoPHUXI=
X-Received: by 2002:a17:903:4113:b0:20b:93be:a2a6 with SMTP id
 d9443c01a7336-20c6377f86cmr19309505ad.44.1728458019284; Wed, 09 Oct 2024
 00:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 9 Oct 2024 15:13:27 +0800
Message-ID: <CAHj4cs8G21-RKCdTzSu1OThj9DOPuoE4CiPmCVk7GfsXY-JTaw@mail.gmail.com>
Subject: [bug report] WARNING: CPU: 3 PID: 26597 at kernel/sched/fair.c:5629 pick_next_entity+0xf0/0x138
To: open list <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"

Hi
I found this warning with blktests nvme/tcp on 6.12-rc2, please help
check it and let me know if you need any info/test for it, thanks.

Reproducer:
NVMET_BLKDEV_TYPES=device  nvme_trtype=tcp ./check nvme/012

dmesg:
[ 2910.995416] run blktests nvme/012 at 2024-10-09 06:48:52
[ 2911.043544] loop0: detected capacity change from 0 to 2097152
[ 2911.055838] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2911.071645] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 2911.102768] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 2911.114744] nvme nvme1: creating 6 I/O queues.
[ 2911.118201] nvme nvme1: mapped 6/0/0 default/read/poll queues.
[ 2911.122261] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420, hostnqn:
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 2911.738555] XFS (nvme1n1): Mounting V5 Filesystem
4afac222-f0aa-45fb-85a9-395c728796a8
[ 2911.750772] XFS (nvme1n1): Ending clean mount
[ 2954.681335] ------------[ cut here ]------------
[ 2954.682833] se->on_rq
[ 2954.682852] WARNING: CPU: 3 PID: 26597 at kernel/sched/fair.c:5629
pick_next_entity+0xf0/0x138
[ 2954.685560] Modules linked in: nvmet_tcp nvmet nvme_tcp
nvme_fabrics nvme_keyring rpcsec_gss_krb5 auth_rpcgss nfsv4
dns_resolver nfs lockd grace netfs sunrpc btusb btrtl btintel
rtw88_8822ce rtw88_8822c btbcm rtw88_pci rtw88_core vfat mac80211
bluetooth fat realtek libarc4 cfg80211 tegra194_cpufreq at24
dwmac_dwc_qos_eth stmmac_platform stmmac rfkill pcs_xpcs
tegra_bpmp_thermal fuse loop nfnetlink xfs nvme nvme_core mmc_block
tegra_drm crct10dif_ce nvme_auth cec drm_dp_aux_bus rtc_max77686
ghash_ce drm_display_helper sdhci_tegra sdhci_pltfm sha2_ce
sha256_arm64 sha1_ce gpio_keys pwm_fan rtc_tegra sdhci cqhci mmc_core
xhci_tegra i2c_tegra host1x phy_tegra_xusb i2c_tegra_bpmp dm_mirror
dm_region_hash dm_log dm_mod [last unloaded: nvmet]
[ 2954.693944] CPU: 3 UID: 0 PID: 26597 Comm: kworker/3:1H Kdump:
loaded Not tainted 6.12.0-0.rc2.24.eln143.aarch64+64k #1
[ 2954.696725] Workqueue:  0x0 (kblockd)
[ 2954.698045] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2954.700731] pc : pick_next_entity+0xf0/0x138
[ 2954.705476] lr : pick_next_entity+0xf0/0x138
[ 2954.709650] sp : ffff80008a9afbe0
[ 2954.713017] x29: ffff80008a9afbe0 x28: 0000000000000000 x27: 0000000000000000
[ 2954.720385] x26: 0000000000000000 x25: ffff70a046bbad08 x24: 0000000000000000
[ 2954.727743] x23: ffff70a046bba400 x22: ffff70a046bba400 x21: ffff70a15d4ef7c0
[ 2954.735090] x20: ffff70a15d4ef8c0 x19: ffff709feebc0080 x18: 0000000000000006
[ 2954.742627] x17: 843609006d9d0400 x16: 0000000000000020 x15: 0000000000000004
[ 2954.749792] x14: 0000000000000002 x13: 0000000000000001 x12: ffffcaa363537e00
[ 2954.757167] x11: ffffcaa363277e58 x10: ffffcaa363537e58 x9 : ffffcaa360d132b0
[ 2954.764505] x8 : 0000000000000001 x7 : 00000000000bffe8 x6 : c0000000ffff7fff
[ 2954.771770] x5 : ffff70a15d463408 x4 : 0000000000000000 x3 : ffffa5fdfa8d0000
[ 2954.778779] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff70a046bba400
[ 2954.786023] Call trace:
[ 2954.789094]  pick_next_entity+0xf0/0x138
[ 2954.792446]  pick_task_fair+0x54/0xe0
[ 2954.795649]  pick_next_task_fair+0x30/0x3e8
[ 2954.799812]  __pick_next_task+0x4c/0x228
[ 2954.803810]  pick_next_task+0x3c/0x9c0
[ 2954.807757]  __schedule+0x404/0x728
[ 2954.810973]  schedule+0x3c/0xe0
[ 2954.814376]  worker_thread+0x1b0/0x380
[ 2954.818128]  kthread+0xf4/0x108
[ 2954.821019]  ret_from_fork+0x10/0x20
[ 2954.824755] ---[ end trace 0000000000000000 ]---
[ 2972.284041] XFS (nvme1n1): Unmounting Filesystem
4afac222-f0aa-45fb-85a9-395c728796a8
[ 2972.316858] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"



--
Best Regards,
  Yi Zhang


