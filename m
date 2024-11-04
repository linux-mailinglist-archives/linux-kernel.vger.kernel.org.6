Return-Path: <linux-kernel+bounces-394526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB559BB098
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADC3B218ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921F81B0F03;
	Mon,  4 Nov 2024 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fGwwByEe"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2BB1AF0D9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714888; cv=none; b=PR+4kEPTh84x6St8LhMN4YoaeqeaWaR/2Ftf40nyXeNa2jW/QX5WGW8lXRjImJpkkSX9ulsE0ORJubadYOwlGgZepWcnEg43cZbSflHZTKpPwo5FmeIDPKb3dOoUq0BRPfEQJ+zSx2ySsdwn6vOZG6NQXTV9ZjIYtxU5u6osDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714888; c=relaxed/simple;
	bh=w8uDUhL+0RVy703GunghhdLMyl8W7zQAjigiX1nb2kw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=WBmt+bcNNIHzPqeDw2yanN8yOeG1IOYKxi4xARUtYEDFeZHCmUhjE61ZQXyn0HWhJZeWORLfI7KH90/wA7Iw/RkQwk0dWXPNvFO0YZDruRHaOR9gwwJsE+8z+lExAGKoog1IJmd9YFvXVPu6tMtNjBB9KFzfmFMqRCI0YhKnlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fGwwByEe; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241104100758euoutp023f1dcb132e765f5dec27d795e1f67178~EvAMP1DRR0773107731euoutp02K
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:07:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241104100758euoutp023f1dcb132e765f5dec27d795e1f67178~EvAMP1DRR0773107731euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730714878;
	bh=nda/NO/chPzTHaeqpg1t4XLXCD8XsnwMHQXDCOSvolY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=fGwwByEemCWZBl2e7iOX/OXNTup+jUFkTshbWOuP6hkKCoG+eXl6WLKcJWSmUVwiB
	 nbwBFG3bNKKLiEuHZnteevK+pwxr6geXk+BZimdlpAanbsvWTeDP+SHKLKc9Rgc5w/
	 KN40ISow9y+z8ZnuKX/Pf4lpljAUQjtqjX5qabhc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241104100757eucas1p1bb76e56b3efa108a185916a4c94bccb7~EvAL4lz2u2023520235eucas1p1o;
	Mon,  4 Nov 2024 10:07:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B2.82.20821.DFC98276; Mon,  4
	Nov 2024 10:07:57 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241104100757eucas1p15156cbe4466b785095cfb788192a7077~EvALfihbp2023520235eucas1p1n;
	Mon,  4 Nov 2024 10:07:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241104100757eusmtrp1cb6a88a1eb9ee50b128a4213c3c69c54~EvALeI2UJ1011310113eusmtrp1R;
	Mon,  4 Nov 2024 10:07:57 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-87-67289cfdd927
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id DF.CB.19920.DFC98276; Mon,  4
	Nov 2024 10:07:57 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241104100756eusmtip1146361b5cd070b817f137b1924b6379b~EvAKXnpv22858228582eusmtip1O;
	Mon,  4 Nov 2024 10:07:56 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com, samuel.holland@sifive.com,
	emil.renner.berthing@canonical.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, christophe.jaillet@wanadoo.fr, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [PATCH v6 0/3] Introduce support for T-head TH1520 Mailbox
Date: Mon,  4 Nov 2024 11:07:31 +0100
Message-Id: <20241104100734.1276116-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7djP87p/52ikG5yfo2Wx9fcsdoutB+ey
	WqzZe47JYv6Rc6wW9y5tYbK41LmC0eLF3kYWi2sr5rJbvJx1j83i8q45bBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF6nNXWCxa9k9hcRDymNXQy+bx5uVLFo/DHV/YPXbOusvu
	sWlVJ5vH5iX1Hi1rjzF5vN93lc2jb8sqRo9LzdfZPT5vkvP4fHc9awBPFJdNSmpOZllqkb5d
	AlfG5QnrWQou6lS83P2HpYGxQ6WLkYNDQsBEYtN8pi5GLg4hgRWMEmv3vGaHcL4wSqw59JsV
	wvnMKLHw9hmgMk6wjrVHzkBVLWeU2LZ5P1TVG0aJf/O+s4BUsQkYSTxYPh8sISKwnkni2e5l
	7CAJZoF1jBKfrtiD2MICzhKvv/WCxVkEVCX+HP7NDGLzCthLnHkzhRFinbzE/oNnoeKCEidn
	PmGBmCMv0bx1NjPIAgmBzZwSS/d0MUM0uEg0PNsLZQtLvDq+hR3ClpE4PbmHBcLOl3iw9RNU
	TY3Ezp7jULa1xJ1zv9hAIcMsoCmxfpc+RNhRYuH/hWyQAOOTuPFWEOIEPolJ26YzQ4R5JTra
	hCCq1SSm9vTCLT23Yhs04Dwk7hzfzQJSLiQQKzGvSXICo8IsJH/NQvLXLIQTFjAyr2IUTy0t
	zk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMjKf/Hf+0g3Huq496hxiZOBgPMUpwMCuJ8M5LVU8X
	4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYHJbuLbmR0xM
	XavDiTVnpMWEvV7emrm4gPep1WfG/FrlR38CXKe4xQVJCWRz7+Lcf2rrqxVst9IX2rxgT/Te
	5aL+v9yxjk31Sqiq7DyPXVvm1r3U/9D8xjm+knna441bX8UdF50yQ9ig32ZHu8vlRzcXHjm1
	nVMvQyXDudnsWWfXz2fljlI/X8Z8nsTqxDLdkyd2R+M+jxPp0hP1e55tXDY7mCPqmdzT30W7
	HfSW3HEvKr9gevhzU3vUvkMvJpwSCfYtXSyixlyXHi8wIfrlVQVuUUPt2TM1Z9hOPy3646XQ
	vxnr3ogd7Pri3duxWd7ydFmc3DQZT40NC94ulNmc9EQ3ZfmTdtv0i/wVR5+umabEUpyRaKjF
	XFScCABvrPZV+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7p/52ikG3xbxG+x9fcsdoutB+ey
	WqzZe47JYv6Rc6wW9y5tYbK41LmC0eLF3kYWi2sr5rJbvJx1j83i8q45bBbbPrewWaw9cpfd
	Yv3X+UwWLy/3MFu0zeK3+L9nB7vF6nNXWCxa9k9hcRDymNXQy+bx5uVLFo/DHV/YPXbOusvu
	sWlVJ5vH5iX1Hi1rjzF5vN93lc2jb8sqRo9LzdfZPT5vkvP4fHc9awBPlJ5NUX5pSapCRn5x
	ia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G5QnrWQou6lS83P2HpYGx
	Q6WLkZNDQsBEYu2RM+xdjFwcQgJLGSW2PVvODJGQkbjW/ZIFwhaW+HOtiw2i6BWjxMMfU8ES
	bAJGEg+Wz2cFsUUE9jNJvD5bBFLELLCJUeLSyn52kISwgLPE62+9YDaLgKrEn8O/wTbwCthL
	nHkzhRFig7zE/oNnoeKCEidnPgFawAE0SF1i/TwhkDAzUEnz1tnMExj5ZyGpmoVQNQtJ1QJG
	5lWMIqmlxbnpucWGesWJucWleel6yfm5mxiBMbzt2M/NOxjnvfqod4iRiYPxEKMEB7OSCO+8
	VPV0Id6UxMqq1KL8+KLSnNTiQ4ymQFdPZJYSTc4HJpG8knhDMwNTQxMzSwNTSzNjJXFet8vn
	04QE0hNLUrNTUwtSi2D6mDg4pRqYUj+avnSJP78osCc4divzY+1pYuG1x99LcCy/yVHit5+h
	mcXQ/+61XacuLYp6PW3X/uzf39kequqfv6aacEhl+YEOxrcOq5xNrzs95pyi/VtzV+XHgKs1
	c2bKXT3K9ntRrsSOrcKq7S9j1mmej9Vi8OU+2hpZ/PThTJX/ebfjlrZKJm9e9Yp7/fl1XcsU
	tgqnmN+Y8eJ3glaBnIt8qrAeS0mDzdPsJSevuK6Y/fXD7Kb9Epm6YfaKz5dxMSqyds9evkgy
	/6N9s0Tg4jfPtHZozFC4nRB/4rwnx5HNSovfMGyzb2Lvvtk/LTnm4sWVS447ySjyTPW8mroi
	KP5CepfwjYn8J689/LXooSKHXbWnnRJLcUaioRZzUXEiABpgHcBqAwAA
X-CMS-MailID: 20241104100757eucas1p15156cbe4466b785095cfb788192a7077
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241104100757eucas1p15156cbe4466b785095cfb788192a7077
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241104100757eucas1p15156cbe4466b785095cfb788192a7077
References: <CGME20241104100757eucas1p15156cbe4466b785095cfb788192a7077@eucas1p1.samsung.com>

The T-head TH1520 SoC supports a hardware mailbox that enables two cores
within the SoC to communicate and coordinate [1]. One example of such
coordination would be cooperation with the T-Head E902 core, which is
responsible for power, clock, and resource management. For example, in
the specific case of the BXM-4-64 GPU, it needs to be powered on by the
E902 core, and the kernel running on the E910 needs to 'ask' the
firmware running on the E902 core to enable power to the GPU island.
Given recent advancements in work on the upstream GPU driver [2], there
is an emerging need to get this code in the mainline kernel.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]
Link: https://gitlab.freedesktop.org/imagination/linux-firmware/-/issues/1 [2]

Thanks everyone for taking the time to review this series !

To test this, I've prepared a diff that includes the missing drivers
utilizing the mailbox and enabled the GPU node in the device tree to use
the drm/imagination driver.

I’ve created two branches. Both contain the same code, including this
patch series and some extra commits with mailbox consumers. The only
difference is that one branch has an additional commit that switches ON
calls to OFF calls (and vice versa) to observe the behavior when the GPU
is turned off via the mailbox.

To reproduce, simply clone the repository, add the following extra options
in the config:

CONFIG_THEAD_TH1520_MBOX=y #(this series)
CONFIG_DRM_POWERVR=y
CONFIG_LIGHT_AON=y
CONFIG_LIGHT_AON_PD=y

Then build and deploy on the target.

In case [1], the output should be:
[    2.478394] light_aon_probe: virtual_log_mem=0x000000005faf564a, phy base=0x33600000, size:2097152
[    2.488589] succeed to create power domain debugfs direntry
[    2.494987] powervr ffef400000.gpu: Before reading BVNC
At this point, the system will hang because the driver is trying to read
memory-mapped registers while the GPU isn’t powered on.

In case [2], the GPU powers on correctly, and the BVNC can be read
without issues. If the specific firmware file isn’t available, the
output would look like this:
root@revyos-lpi4a:~# dmesg | grep gpu
[    2.408207] powervr ffef400000.gpu: Before reading BVNC
[    2.413533] powervr ffef400000.gpu: After reading BVNC
[    2.418930] powervr ffef400000.gpu: Direct firmware load for powervr/rogue_36.52.104.182_v1.fw failed with error -2
[    2.429568] powervr ffef400000.gpu: [drm] *ERROR* failed to load firmware powervr/rogue_36.52.104.182_v1.fw (err=-2)
[    2.440403] powervr ffef400000.gpu: probe with driver powervr failed with error -2

Here are the links:
[1] - https://github.com/mwilczy/linux/tree/31_october_demonstrate_mailbox_not_working
[2] - https://github.com/mwilczy/linux/tree/31_october_demonstrate_mailbox_working

Note: U-Boot must load the AON firmware at startup to the address mapped
for AON for this to work properly.

v6:
 - added a devm_ action callback to disable the clocks if the probe fails

v5:
 - removed 'type' mbox-cell, which isn't really necessary for the use-cases of
   the series, but desribes SW protocol instead of the HW, adjust driver code
   logic to account for this, simplifying it
 - change the register mappings in the device tree node to reflect the manual
 - adjust the driver code to compensate for irregularities in the mappings, do
   this by modifying th1520_map_mmio() with extra argument 'offset'
 - add support for enabling/disabling MBOX clocks in the driver
 - add clocks in the dt-binding/device tree node
 - rebase and retest

v4:
- fixed warning of unused variable
- added Reviewed-by from Krzysztof
- fixed minor cosmetic issues in dt-binding

v3:
- added a comment about mixing devm_ and non-devm resources in the context
  of shared interrupts and explained why it's safe to do so in this
  particular case
- changed the order of resource freeing in the .shutdown callback
- used a wrapper function for register mapping
- since the only conceivable use case for this mailbox driver is
  communication with cores not managed by the kernel, I’ve hard-coded
  this by removing the thead,icu-cpu-id property and adjusted the mailbox
  driver code accordingly.
- added a more detailed description for mbox-cells.
- made some cosmetic changes.
- retested by applying the patch with non-yet-upstreamed patches,
  confirming that the drm/imagination driver can read the registers
  correctly.

v2:
 - fixed thead,th1520-mbox.yaml binding file by dropping redundant
   descriptions, renaming reg-names, removing unnecessary clocks,
   providing constraints and defining ICU's
 - fixed the mailbox driver code to work well with updated binding-file,
   removed clocks support, as it's not necessary for mailbox to work
 - adjusted the device tree node instance of mbox_910t so it will work
   with updated bindings file

Michal Wilczynski (3):
  mailbox: Introduce support for T-head TH1520 Mailbox driver
  dt-bindings: mailbox: Add thead,th1520-mailbox bindings
  riscv: dts: thead: Add mailbox node

 .../bindings/mailbox/thead,th1520-mbox.yaml   |  89 +++
 MAINTAINERS                                   |   2 +
 arch/riscv/boot/dts/thead/th1520.dtsi         |  16 +
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mailbox-th1520.c              | 597 ++++++++++++++++++
 6 files changed, 716 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 create mode 100644 drivers/mailbox/mailbox-th1520.c

-- 
2.34.1


