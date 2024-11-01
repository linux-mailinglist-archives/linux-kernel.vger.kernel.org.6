Return-Path: <linux-kernel+bounces-391657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217DB9B89F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 04:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A44B1F21E58
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74FA13FD83;
	Fri,  1 Nov 2024 03:25:06 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61248142903;
	Fri,  1 Nov 2024 03:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730431506; cv=none; b=Lig/I67U3lEUjGiIP96KkmuCMZM/hkp39fxorBuU5QAKC+j39bN8H/kVon+t9nQYMsJlKKtR3Jw7Dba9CBizttPQAKC3BGVOQdQ3cYn98wdhIiaJrS8tqLlvLGWwJWy2Bw0w7YgFUVizOAhc0YJscw5qEIZoCYJ0g2lvaS2QXj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730431506; c=relaxed/simple;
	bh=/ANmtZ4s5cHIgK7wCBji4ERddq1+PVkKaQynfsvuXCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNNjH/4A1V26uU/8zYzck5jAhXS4OIUssM23ciz2gF0hx6Hqf0m7j5naiF+8E4oMHzCuOfT+9YR6rglSHwNclUAIU8PuiGpgrW0i41o9X+98//voujF/3R/7jeoIOr6SsAGwpk381pOeUNR7rOYOtteH9Zo26kGqWvPsGb5tT8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=none smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: bizesmtp85t1730431451t143ezlp
X-QQ-Originating-IP: u2q/N02JrKolLbYZeg8l6j4E/dSf19l466MZ+2aUrHQ=
Received: from localhost.localdomain ( [175.10.24.49])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 01 Nov 2024 11:24:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8651842919039975791
From: Luo Qiu <luoqiu@kylinsec.com.cn>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scpi: Add check for dvfs_info.opp_count
Date: Fri,  1 Nov 2024 11:21:15 +0800
Message-ID: <55A2F7A784391686+20241101032115.275977-1-luoqiu@kylinsec.com.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: OIJNl3GIzK3mDngjrLnwAWIYHbAWpYO0UIgbBOK6h9XMJWE7qjc5Iz/3
	V5gL1r8ZerzDQhQm1V4ELFjkbRsb4oPcbWTRrZJlk0ZEZXmh2FuL4+uNYWDLSfPZmdw1AbV
	9j4NZRfD2LOLc7WLZwvHyoUcr4ApDt4W8Fc4hSDz7G0+5GsVtE8Tdeulmcqma/mS57cJyXs
	LErWAX7NTf+BisBKi+95ScL2MfUBfm8t7qyjuNkVXzPiypdUFe/8T+7c8bwi6BDqoBFYl5F
	dKesuv/2oyn16BA8K5viq9tWFs9Q+/5cycvpu11sLgDtFZD3YQJYbzl1KZ45f1DR/AePze4
	5XLhIxdi45Ka3k5hNIt/yBHMmSBXHFJpWds5pX4USs7vJci8E9PQFvTObxS50md2Vxe8dfT
	dCHKb7ZNvGZ8hYw5gPPoucHHWn2UsSFhJwBlWe4KKIE38s6ABYvXg9HZQKD4+saQZX3ePXI
	6r/o/3BVevM406KvWy71H32oaGxq8O1yHx0klR+i1KAFWHcprlvXpTDlATGVcGRuo8CZWtU
	icZnP+EqvOkBWlfzOCgEasknaIZe+hZ1rWbv4rR67Y3Exs2s6oD6vsb9ZK4w7RBm2soiTnp
	nVHBDhPQz4goJZkDksKIslVyXWJAW3XBHbrdZ7CyjUZYHhGVa89Rd5AeJDYH/LL6MCoHFYS
	F38ncCGMAihvo2WgwGTTVmG01Pore+a5PrN36XuGrepUhRFrMklHDHYf4w/mafqD7EJFXDr
	YlYAkRbC5qaDms/6u5NsqBrvQU8MjjUKI9aEjRnbaupmzmRqsv2re56Tp6BeWpfUnX0yS/h
	vR/1rwNU1CbLhr8QTfTGyKHq+v9f0K6Oqc4C4e9Lo/q9Y8PWShE1t6Beo7d+tq3rG4HTeVE
	9o6JO5F+9unJsB6xMkDh+uiXq9cxdyzfzEg+Csm/C3Y+fOSeySXTH9MQTJSsMwJ8Bl7uNjW
	kK3KIAqCf+c+kzSFmx1LDp3GGNKckIq6qr1UJiUH7NSCbqwCo8H22FCs18+ApoaHMFfHzG3
	86qipde8NkffjPCpK2
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Fix a kernel crash when dvfs_info.opp_count is zero.

dvfs_info.opp_count may be zero on some platforms during the reboot
test, and the kernel will crash after dereferencing the pointer to
kcalloc(info->count, sizeof(*opp), GFP_KERNEL).

```console
[    9.724138] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
[    9.738420] Mem abort info:
[    9.741223]   ESR = 0x96000004
[    9.744264]   Exception class = DABT (current EL), IL = 32 bits
[    9.750172]   SET = 0, FnV = 0
[    9.753214]   EA = 0, S1PTW = 0
[    9.756342] Data abort info:
[    9.759209]   ISV = 0, ISS = 0x00000004
[    9.763037]   CM = 0, WnR = 0
[    9.765992] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000faefa08c
[    9.772596] [0000000000000028] pgd=0000000000000000
[    9.777465] Internal error: Oops: 96000004 [#1] SMP
[    9.779210] scpi-hwmon: probe of PHYT000D:00 failed with error -110
[    9.782329] Modules linked in: snd_hda_codec phytium_power snd_hda_core snd_pcm clk_scpi(+) optee tee scpi_cpufreq phytium_ec phytium_mailbox scpi_hwmon arm_scpi snd_timer snd soundcore gpio_phytium_platform gpio_phytium_core ip_tables ext4 mbcache jbd2 sd_mod ahci libahci libata phytium_sdci mmc_core rtc_ds1307 i2c_designware_platform i2c_designware_core
[    9.820002] Process systemd-udevd (pid: 1701, stack limit = 0x00000000aaede86c)
[    9.827295] CPU: 2 PID: 1701 Comm: systemd-udevd Not tainted 4.19.90+ #1
[    9.836930] Hardware name: PHYTIUM LTD Phytium FT2000/4/Phytium FT2000/4, BIOS
[    9.844309] pstate: 60000005 (nZCv daif -PAN -UAO)
[    9.849090] pc : scpi_dvfs_recalc_rate+0x40/0x58 [clk_scpi]
[    9.854650] lr : clk_register+0x438/0x720
[    9.858644] sp : ffff00000e7eb7e0
[    9.861944] x29: ffff00000e7eb7e0 x28: ffff801f8ab2e580
[    9.867241] x27: ffff801f82198698 x26: ffff801f821eb810
[    9.872537] x25: 0000000000000000 x24: 00000000006080c0
[    9.877833] x23: ffff801f8ab2e588 x22: 0000000000000000
[    9.883129] x21: 0000000000000000 x20: ffff00000987e000
[    9.888426] x19: ffff801f8ab2e600 x18: 0000ffffe4d3e9b0
[    9.893722] x17: 0000000000000000 x16: ffff801f8b011f00
[    9.899018] x15: 00000000000059a4 x14: 0000ffffb89a6a94
[    9.904317] x13: 0000000000000000 x12: ffffffffffffffd0
[    9.904318] x11: 0000000000000000 x10: 0000000000000b80
[    9.904320] x9 : ffff00000e7eb490 x8 : ffff801f8b012ae0
[    9.904321] x7 : 0000000aaab119bb x6 : 0000000000000000
[    9.904322] x5 : 0000000000000000 x4 : ffff801f8a428ce0
[    9.904324] x3 : d855a1d4f736cb00 x2 : 0000000000000003
[    9.904325] x1 : 0000000000000010 x0 : 0000000000000018
[    9.904326] Call trace:
[    9.904330]  scpi_dvfs_recalc_rate+0x40/0x58 [clk_scpi]
[    9.904332]  devm_clk_hw_register+0x50/0xa0
[    9.904334]  scpi_clk_ops_init.isra.2+0xa0/0x138 [clk_scpi]
[    9.904336]  scpi_clocks_probe+0x528/0x70c [clk_scpi]
[    9.904339]  platform_drv_probe+0x58/0xa8
[    9.904342]  really_probe+0x260/0x3d0
[    9.904344]  driver_probe_device+0x12c/0x148
[    9.904346]  device_driver_attach+0x74/0x98
[    9.904348]  __driver_attach+0xb4/0xe8
[    9.904350]  bus_for_each_dev+0x88/0xe0
[    9.904351]  driver_attach+0x30/0x40
[    9.904353]  bus_add_driver+0x178/0x2b0
[    9.904354]  driver_register+0x64/0x118
[    9.904355]  __platform_driver_register+0x54/0x60
[    9.904357]  scpi_clocks_driver_init+0x24/0x1000 [clk_scpi]
[    9.904360]  do_one_initcall+0x54/0x220
[    9.904363]  do_init_module+0x54/0x1c8
[    9.904364]  load_module+0x14a4/0x1668
[    9.904366]  __se_sys_finit_module+0xf8/0x110
[    9.904367]  __arm64_sys_finit_module+0x24/0x30
[    9.904370]  el0_svc_common+0x78/0x170
[    9.904371]  el0_svc_handler+0x38/0x78
[    9.904373]  el0_svc+0x8/0x340
[    9.904375] Code: 937d7c00 a94153f3 a8c27bfd f9400421 (b8606820)
[    9.904380] ---[ end trace 06feb22469d89fa8 ]---
[    9.904381] Kernel panic - not syncing: Fatal exception
[    9.904383] SMP: stopping secondary CPUs
[    9.904387] Kernel Offset: disabled
[    9.904389] CPU features: 0x10,a0002008
[    9.904389] Memory Limit: none
[   10.069666] ---[ end Kernel panic - not syncing: Fatal exception ]---
```

Fixes: 8cb7cf56c9fe ("firmware: add support for ARM System Control and Power Interface(SCPI) protocol")

Signed-off-by: Luo Qiu <luoqiu@kylinsec.com.cn>
---
 drivers/firmware/arm_scpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 94a6b4e667de1..8e3f4cea6a919 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -630,6 +630,9 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 	if (ret)
 		return ERR_PTR(ret);
 
+	if (unlikely(buf.opp_count == 0))
+		return ERR_PTR(-ENOENT);
+
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return ERR_PTR(-ENOMEM);
-- 
2.45.2


