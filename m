Return-Path: <linux-kernel+bounces-169106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F38BC32E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 21:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860401F21466
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AD66D1A0;
	Sun,  5 May 2024 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="R4pNazCV"
Received: from forward206c.mail.yandex.net (forward206c.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2891A2D60A
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714936075; cv=none; b=oBVnzhOjrJP2LkhB2EXxy904zdWtDSQAGf+XJQ2G36heVAA/SX8/lKkqtwyKfIfX3ch1lpwqUWce0Dc5yYbHCza7il3X49rxDbB62J2dCYANBpwbdzwU0A97leSYOWsKp3wZCCxeHhD65jhbrbaLHyx4IoSUrXZwKoeQ7MEBlsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714936075; c=relaxed/simple;
	bh=S8PlWABCmLWnSmQqv1SuLK4MoT9GhFKeKAJ5XRb1CLw=;
	h=From:To:Subject:MIME-Version:Date:Message-Id:Content-Type; b=fM/QYGkGPim91LQ64RwztJ8W0ICamD76oEudpTRV4JBh8iDoix5lWswyza/XQqtoFaLYWVrlPtE6kOksPdBqLRbHmiOT8IJ+wSUKMAwyv0on+C1Cm9YyB+aOFzDcw7iZo3yLx5FMZUaaVbzTDFbSdp2yZDDAPW4c6AYymkoAWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=R4pNazCV; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward206c.mail.yandex.net (Yandex) with ESMTPS id 2517761E85
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 21:59:31 +0300 (MSK)
Received: from mail-nwsmtp-mxback-production-main-42.sas.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-42.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:7614:0:640:41cb:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 40245609CA
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 21:59:23 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c10:1f18:0:640:b5ca:0 [2a02:6b8:c10:1f18:0:640:b5ca:0])
	by mail-nwsmtp-mxback-production-main-42.sas.yp-c.yandex.net (mxback/Yandex) with HTTP id Ixb96I14fmI0-rTbSYLvc;
	Sun, 05 May 2024 21:59:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714935562; bh=5KGM6tuc0HgQlmm1JRTgnyOUav29t/QF3lgjx7ssiU4=;
	h=Message-Id:Date:Subject:To:From;
	b=R4pNazCVIjA9BOsNcDDnNqxn4URMyZ/PWW8XCAZOB/QFpSJYxg7T+uS4eIcbhcfbf
	 GpvAnWlvLrQ9T1aqNApQ8lDOTWB7X6y2a70FzCsiZxfnw4ZRGBl7YNxKyNMW+epeVt
	 YcNPQtK853Up6zNrOkL7K1QZ1mF7yMii25nbVsmU=
Authentication-Results: mail-nwsmtp-mxback-production-main-42.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by dmcmxrwo3x2o7y3i.sas.yp-c.yandex.net with HTTP;
	Sun, 05 May 2024 21:59:22 +0300
From: Tranton Baddy <t.baddy@yandex.ru>
Envelope-From: t-baddy@yandex.ru
To: linux-kernel@vger.kernel.org
Subject: Error in amd driver?
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sun, 05 May 2024 21:59:22 +0300
Message-Id: <1237381714935562@dmcmxrwo3x2o7y3i.sas.yp-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

I have this in my dmesg since version 6.8.6, not sure when it appeared. Is amdgpu driver has bug?
[   64.253144] ==================================================================
[   64.253162] BUG: KFENCE: use-after-free read in amdgpu_bo_move+0x51f/0x7a0

[   64.253183] Use-after-free read at 0x00000000671c48dd (in kfence-#111):
[   64.253192]  amdgpu_bo_move+0x51f/0x7a0
[   64.253202]  ttm_bo_handle_move_mem+0xcf/0x180
[   64.253211]  ttm_mem_evict_first+0x1c5/0x500
[   64.253218]  ttm_resource_manager_evict_all+0xa3/0x1e0
[   64.253228]  amdgpu_device_prepare+0x66/0x110
[   64.253237]  amdgpu_pmops_runtime_suspend+0xbe/0x1c0
[   64.253248]  pci_pm_runtime_suspend+0x74/0x200
[   64.253259]  vga_switcheroo_runtime_suspend+0x21/0xb0
[   64.253268]  __rpm_callback+0x5f/0x190
[   64.253277]  rpm_callback+0x7f/0x90
[   64.253283]  rpm_suspend+0x120/0x6a0
[   64.253290]  pm_runtime_work+0x9c/0xa0
[   64.253297]  process_one_work+0x164/0x330
[   64.253310]  worker_thread+0x302/0x430
[   64.253320]  kthread+0xe4/0x110
[   64.253329]  ret_from_fork+0x4c/0x60
[   64.253341]  ret_from_fork_asm+0x1b/0x30

[   64.253353] kfence-#111: 0x00000000d018cf03-0x0000000034e821d1, size=96, cache=kmalloc-96

[   64.253363] allocated by task 152 on cpu 3 at 64.248952s:
[   64.253418]  kmalloc_trace+0x283/0x340
[   64.253427]  amdgpu_vram_mgr_new+0x8f/0x3f0
[   64.253435]  ttm_resource_alloc+0x39/0x90
[   64.253444]  ttm_bo_mem_space+0xa4/0x260
[   64.253450]  ttm_mem_evict_first+0x18a/0x500
[   64.253456]  ttm_resource_manager_evict_all+0xa3/0x1e0
[   64.253465]  amdgpu_device_prepare+0x66/0x110
[   64.253472]  amdgpu_pmops_runtime_suspend+0xbe/0x1c0
[   64.253481]  pci_pm_runtime_suspend+0x74/0x200
[   64.253489]  vga_switcheroo_runtime_suspend+0x21/0xb0
[   64.253496]  __rpm_callback+0x5f/0x190
[   64.253503]  rpm_callback+0x7f/0x90
[   64.253509]  rpm_suspend+0x120/0x6a0
[   64.253516]  pm_runtime_work+0x9c/0xa0
[   64.253523]  process_one_work+0x164/0x330
[   64.253532]  worker_thread+0x302/0x430
[   64.253542]  kthread+0xe4/0x110
[   64.253550]  ret_from_fork+0x4c/0x60
[   64.253559]  ret_from_fork_asm+0x1b/0x30

[   64.253570] freed by task 152 on cpu 3 at 64.253117s:
[   64.253582]  ttm_resource_free+0x67/0x90
[   64.253591]  ttm_bo_move_accel_cleanup+0x247/0x2e0
[   64.253598]  amdgpu_bo_move+0x1bd/0x7a0
[   64.253605]  ttm_bo_handle_move_mem+0xcf/0x180
[   64.253612]  ttm_mem_evict_first+0x1c5/0x500
[   64.253618]  ttm_resource_manager_evict_all+0xa3/0x1e0
[   64.253626]  amdgpu_device_prepare+0x66/0x110
[   64.253634]  amdgpu_pmops_runtime_suspend+0xbe/0x1c0
[   64.253642]  pci_pm_runtime_suspend+0x74/0x200
[   64.253650]  vga_switcheroo_runtime_suspend+0x21/0xb0
[   64.253658]  __rpm_callback+0x5f/0x190
[   64.253664]  rpm_callback+0x7f/0x90
[   64.253671]  rpm_suspend+0x120/0x6a0
[   64.253677]  pm_runtime_work+0x9c/0xa0
[   64.253684]  process_one_work+0x164/0x330
[   64.253693]  worker_thread+0x302/0x430
[   64.253703]  kthread+0xe4/0x110
[   64.253711]  ret_from_fork+0x4c/0x60
[   64.253723]  ret_from_fork_asm+0x1b/0x30

[   64.253735] CPU: 3 PID: 152 Comm: kworker/3:2 Tainted: P           OE      6.8.9 #3 e7323d0d25f89e853881fc823e59523bdcc577c6
[   64.253756] Hardware name: Hewlett-Packard HP Pavilion Notebook /80B9, BIOS F.54 05/27/2019
[   64.253761] Workqueue: pm pm_runtime_work
[   64.253771] ==================================================================

