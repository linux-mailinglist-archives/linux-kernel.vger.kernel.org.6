Return-Path: <linux-kernel+bounces-353392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E4E992D32
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBE51F23869
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D331D3596;
	Mon,  7 Oct 2024 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="UvBTY361"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A1614AD17;
	Mon,  7 Oct 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307566; cv=none; b=Pi3cT6BkBBPkgOBxdPvOB/iI6h34tKjeiWZjkVLKT7jietHSXEj7jU+/AHL8rVOre4i9Gs9tsfpvclWjgwSIh5DKV3Q+aH/qmu7v2qqClhKhsSr8CCwteLjou/BdtGR3DTmpdBdkmdt+8LfttGMiuJvxitoqh2QI6pSaONAuwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307566; c=relaxed/simple;
	bh=SWGia2W6otTjRDYJY/4ZhIgn9kTOF13TuoNCyPr53Is=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uTlkrtESGjgvm74ej/1vIG7N67XaFRJdCheEY10BZydNSepFyDlR1euFJv5JtweITKMj87JS4SJitzPs8ypiKGeelZYbfhK7gliGLKgOi06cNch4hP/Q2IGY5qkzLJ/Re4ihAFDCSvcysAEg2bblRTjVlR4v0wKicXr8mXIxcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=UvBTY361; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1DDA321E5E;
	Mon,  7 Oct 2024 15:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728307560;
	bh=yJxiIO6CxXoreOtLTDOkCzkK9VuyDNTnsMOel1WnYkw=; h=From:To:Subject;
	b=UvBTY3618qIkW3NC6jNLnkqniX9pKnlNXIQNRfWdkLYJ05OsJndeGJK/hm6D2BRCf
	 st2AQDMMK9u/4mDB4kwqI6iTrSdP6fsSAmbq9e0qrvMpjzk/n7WSJ4wknGs3mGEtvx
	 jxKq5F8Q7qefoZB3XM4MhnVxIgQaLIm0Z+7SaW08Red1DZiAPSAuIAtm9hKSG+v8a/
	 gWQ9hbj3TX0Yoz+KdG6Omx5sCKFNDIKUBwq4uqUiWNx9f0NgzUpf6+5DY3AiFKdDHd
	 Sx3SCtJ2t4gh7bpO/DvC1F8ZrrlIeHFbY3FKHpdpoD6sm4D2014rZ1A9OBC5QdE/WI
	 cl9n23mSXjMtQ==
Date: Mon, 7 Oct 2024 15:25:55 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, shengjiu.wang@gmail.com,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: regressions@lists.linux.dev, Adam Ford <aford173@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mark Brown <broonie@kernel.org>, ulf.hansson@linaro.org
Subject: clk_imx8mp_audiomix_runtime_resume Kernel panic regression on v6.12
Message-ID: <20241007132555.GA53279@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
it seems that an old regression is back on v6.12, reproduced on -rc2
(not sure about rc1).

The original report is from https://lore.kernel.org/all/20240424164725.GA18760@francesco-nb/
and it was fixed with https://lore.kernel.org/all/1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com/.

Is it now back?

[    4.012850] SError Interrupt on CPU2, code 0x00000000bf000002 -- SError
[    4.012862] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not tainted 6.12.0-rc2-0.0.0-devel-00004-g8b1b79e88956 #1
[    4.012869] Hardware name: Toradex Verdin iMX8M Plus WB on Dahlia Board (DT)
[    4.012872] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.012877] pc : clk_imx8mp_audiomix_runtime_resume+0x38/0x48
[    4.012891] lr : pm_generic_runtime_resume+0x2c/0x44
[    4.012897] sp : ffff8000821cb740
[    4.012899] x29: ffff8000821cb740 x28: ffff8000793c48d8 x27: ffff8000793c48c0
[    4.012908] x26: ffff0000c0ec90f4 x25: 0000000000000000 x24: 0000000000000000
[    4.012916] x23: 0000000000000000 x22: ffff0000c1bef180 x21: 0000000000000000
[    4.012923] x20: ffff0000c0a73000 x19: ffff0000c0ecbc10 x18: ffffffffffffffff
[    4.012930] x17: 3030303064623033 x16: 2f7375622e303030 x15: 756e285472656c6c
[    4.012937] x14: ffff800081267458 x13: 6d692c6c73664361 x12: 0000000000000000
[    4.012944] x11: 00353333333d4d55 x10: ffff8000818020ae x9 : 0000000000000008
[    4.012951] x8 : 0000000000000008 x7 : 0000000000000000 x6 : ffff0000c5bf2080
[    4.012958] x5 : ffff800081f10000 x4 : ffff800080c182e8 x3 : ffff0000c0ee7088
[    4.012965] x2 : 0000000000000000 x1 : 0000000000000004 x0 : ffff800081f10300
[    4.012973] Kernel panic - not syncing: Asynchronous SError Interrupt
[    4.012976] CPU: 2 UID: 0 PID: 186 Comm: (udev-worker) Not tainted 6.12.0-rc2-0.0.0-devel-00004-g8b1b79e88956 #1
[    4.012982] Hardware name: Toradex Verdin iMX8M Plus WB on Dahlia Board (DT)
[    4.012985] Call trace:
[    4.012988]  dump_backtrace+0xd0/0x120
[    4.012998]  show_stack+0x18/0x24
[    4.013005]  dump_stack_lvl+0x60/0x80
[    4.013013]  dump_stack+0x18/0x24
[    4.013019]  panic+0x168/0x350
[    4.013025]  add_taint+0x0/0xbc
[    4.013029]  arm64_serror_panic+0x64/0x70
[    4.013034]  do_serror+0x3c/0x70
[    4.013039]  el1h_64_error_handler+0x30/0x54
[    4.013046]  el1h_64_error+0x64/0x68
[    4.013050]  clk_imx8mp_audiomix_runtime_resume+0x38/0x48
[    4.013059]  __genpd_runtime_resume+0x30/0x80
[    4.013066]  genpd_runtime_resume+0x114/0x29c
[    4.013073]  __rpm_callback+0x48/0x1e0
[    4.013079]  rpm_callback+0x68/0x80
[    4.013084]  rpm_resume+0x3bc/0x6a0
[    4.013089]  __pm_runtime_resume+0x50/0x9c
[    4.013095]  pm_runtime_get_suppliers+0x60/0x8c
[    4.013101]  __driver_probe_device+0x4c/0x14c
[    4.013108]  driver_probe_device+0x3c/0x120
[    4.013114]  __driver_attach+0xc4/0x200
[    4.013119]  bus_for_each_dev+0x7c/0xe0
[    4.013125]  driver_attach+0x24/0x30
[    4.013130]  bus_add_driver+0x110/0x240
[    4.013135]  driver_register+0x68/0x124
[    4.013142]  __platform_driver_register+0x24/0x30
[    4.013149]  sdma_driver_init+0x20/0x1000 [imx_sdma]
[    4.013163]  do_one_initcall+0x60/0x1e0
[    4.013168]  do_init_module+0x5c/0x21c
[    4.013175]  load_module+0x1a98/0x205c
[    4.013181]  init_module_from_file+0x88/0xd4
[    4.013187]  __arm64_sys_finit_module+0x258/0x350
[    4.013194]  invoke_syscall.constprop.0+0x50/0xe0
[    4.013202]  do_el0_svc+0xa8/0xe0
[    4.013208]  el0_svc+0x3c/0x140
[    4.013215]  el0t_64_sync_handler+0x120/0x12c
[    4.013222]  el0t_64_sync+0x190/0x194
[    4.013228] SMP: stopping secondary CPUs
[    4.013237] Kernel Offset: disabled
[    4.013239] CPU features: 0x00,00000000,00200000,4200420b
[    4.013243] Memory Limit: none
[    4.316721] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---


Francesco


