Return-Path: <linux-kernel+bounces-391268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92019B849B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1BE1C21482
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753A21B3B2E;
	Thu, 31 Oct 2024 20:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PCSAuJNZ"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D471CC16B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407668; cv=none; b=uIm3gkKDl5RSe3LAysYg3MwnFdeI3JiqOIcwHMLzxpNdaJsDvfLiBtoEBaC6VS55qfbB351uNtFcdogTgx2/f1y2i3Iw741nQnIK7lISDtWLvKVg8QhR08Y1UFy8aL+KLpc4NB+cV+GA3dsJliO/bntNXMp/3OetWqZYdeOXbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407668; c=relaxed/simple;
	bh=CGtXJKxBgqoj2ZhJWq95lN3GeEMod1hgLrFk3VLQLnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=mUn5C5Efk2v2iX28fHcVK2Eq+fEXEVuYdYfDNEcle9uPSfDysV/csPpUhMVOfNZS0LoukemxTCmudvWFihhbKhCwVcTDIoDv48BrHRbVx3VCn8gYby5rjb55fxkmO7yrrFqpq1rlca1p1rz6lfBRqQB3my2pCB4qbXekGHNL3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PCSAuJNZ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241031204735euoutp019c03353381b2abc1760732c9d39ba668~DpJgxl8fO1761317613euoutp01m
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:47:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241031204735euoutp019c03353381b2abc1760732c9d39ba668~DpJgxl8fO1761317613euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730407655;
	bh=s6DGAxUHb2q0xPQ2y2B8ZAw2ghixwQVQZDTwr523jNs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=PCSAuJNZ+NAbFTqo63200lRTk6h5pTUnNfFw5E4xHK2/zOQD8C/ntOg6ihR2MGRwM
	 pt2QWAS8tRBJjNMhOZSYzTu0kDnz3QdmpI3l783szv6IsA2g/tKVZfKsC2g/DIWZSO
	 507G8Q6HDBFmb1Mn058RV57ZQu3np/moa1G+Mavc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241031204734eucas1p2bbdcbc237d9116eefa8aa796fceed66d~DpJfpT9gU1026810268eucas1p2O;
	Thu, 31 Oct 2024 20:47:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 52.15.20821.5ECE3276; Thu, 31
	Oct 2024 20:47:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241031204733eucas1p223f2ad621130055e20e81b7633054f26~DpJfMXC1B0030200302eucas1p2T;
	Thu, 31 Oct 2024 20:47:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241031204733eusmtrp1b33538262d60038dd58e7d1cd60e4d1b~DpJfLqsOF2727327273eusmtrp1z;
	Thu, 31 Oct 2024 20:47:33 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-ee-6723ece5f573
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 0D.20.19654.5ECE3276; Thu, 31
	Oct 2024 20:47:33 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241031204732eusmtip140e0fa6c8476517761ca8e5e11e13e5d~DpJeEmhKz1679316793eusmtip1J;
	Thu, 31 Oct 2024 20:47:32 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com, samuel.holland@sifive.com,
	emil.renner.berthing@canonical.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v5 0/3] Introduce support for T-head TH1520 Mailbox
Date: Thu, 31 Oct 2024 21:47:20 +0100
Message-Id: <20241031204723.1149912-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djPc7rP3iinG9y5yGSx9fcsdos1e88x
	Wcw/co7V4t6lLUwWlzpXMFq82NvIYnFtxVx2i5ez7rFZXN41h81i2+cWNou1R+6yW6z/Op/J
	4uXlHmaLtln8Fv/37GC3WH3uCotFy/4pLA6CHrMaetk83rx8yeJxuOMLu8fOWXfZPTat6mTz
	2Lyk3qNl7TEmj/f7rrJ59G1Zxehxqfk6u8fnTXIB3FFcNimpOZllqUX6dglcGZN2TGMr+K9d
	ca5vMUsD4ynlLkZODgkBE4nfC16wdjFycQgJrGCUaL2yiBnC+cIoMeHERijnM6NE7901zDAt
	815+YIRILAdq6XjMDpIQEnjDKNFxwBTEZhMwkniwfD7YXBGB9UwSz3YvYwdxmAV6GSWm7p3J
	1MXIwSEs4Czx/a8LSAOLgKrEmd47TCA2r4C9xN8ZT9kgtslL7D94lhkiLihxcuYTFhCbGSje
	vHU22HkSAqs5JW7f/A11novEnFP3oWxhiVfHt7BD2DISpyf3sEDY+RIPtn6CqqmR2NlzHMq2
	lrhz7hcbyG3MApoS63fpQ4QdJe7eegF2soQAn8SNt4IQJ/BJTNo2nRkizCvR0SYEUa0mMbWn
	F27puRXbmCBsD4k5O7+xQYIqVqJj+UamCYwKs5A8NgvJY7MQbljAyLyKUTy1tDg3PbXYMC+1
	XK84Mbe4NC9dLzk/dxMjMA2e/nf80w7Gua8+6h1iZOJgPMQowcGsJML7oUA5XYg3JbGyKrUo
	P76oNCe1+BCjNAeLkjivaop8qpBAemJJanZqakFqEUyWiYNTqoFJ1ovrvejHNT/rlWMsl/fF
	t/tu0vO4HLfEPW57FLe8kuv64lTu7tO/F4g53Fhtx6owqz9B86u56GXLI186vzu2cLybl5Gg
	uPCOtfOXq6uXFrgrOHX0m0+pf8t2Nt06oqTuvd6P6bcmXBLaXq1yW/lEvcu7ivz/bds7s9Y9
	LytYdO16HzP7sWAmdeE/f4qfrv6+6qBATsdMJ5kGgUlrGhY53hT9aBletPHmu0PLvlc09rvc
	Pp++sT1oVvjnY6sSb81eYNkkfnd14TO5BJ5nn7ccumw4v2DvW5cyqx/PD37R3/1tOvtkS02r
	g2xdT0Jdb/tezfNJ/rNwIfeNXT31GeLa9ik9ZrdnZTD/6OIqKrirxFKckWioxVxUnAgAXllw
	z/IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xu7pP3yinG2w8r2ix9fcsdos1e88x
	Wcw/co7V4t6lLUwWlzpXMFq82NvIYnFtxVx2i5ez7rFZXN41h81i2+cWNou1R+6yW6z/Op/J
	4uXlHmaLtln8Fv/37GC3WH3uCotFy/4pLA6CHrMaetk83rx8yeJxuOMLu8fOWXfZPTat6mTz
	2Lyk3qNl7TEmj/f7rrJ59G1Zxehxqfk6u8fnTXIB3FF6NkX5pSWpChn5xSW2StGGFkZ6hpYW
	ekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GZN2TGMr+K9dca5vMUsD4ynlLkZODgkBE4l5
	Lz8wdjFycQgJLGWUaL/1kBEiISNxrfslC4QtLPHnWhcbRNErRok3L06wgiTYBIwkHiyfD2aL
	COxnknh9tgikiFlgIqPEzbn3gSZxcAgLOEt8/+sCUsMioCpxpvcOE4jNK2Av8XfGUzaIBfIS
	+w+eZYaIC0qcnPmEBaSVWUBdYv08IZAwM1BJ89bZzBMY+WchqZqFUDULSdUCRuZVjCKppcW5
	6bnFRnrFibnFpXnpesn5uZsYgdG67djPLTsYV776qHeIkYmD8RCjBAezkgjvhwLldCHelMTK
	qtSi/Pii0pzU4kOMpkBXT2SWEk3OB6aLvJJ4QzMDU0MTM0sDU0szYyVxXrYr59OEBNITS1Kz
	U1MLUotg+pg4OKUamFYUu4r1zT3SW1b+Zs+CRXc81l6J3vK03s3daH5Lv3rM2ykcan57t/zN
	UjjX+8nHZoGqSqbYlff+avMnrS/+pbvipG/6As2Etw9zjoRn+R4Tm7qmNsr2xMXfrB1ffFKm
	q+SZfy+YqrLCLmPBjqnSL9QPCD3YeHqZh9TWt0/5L17xE+Pf6pK999TmsmaWRU9SzDkmllXN
	S5H/tPfJsYkXI1mmNwlmXHNW+xAmUNWw8WvZv9XytxiWF3tx6AlMfxOYtOba3J+93G29DhGL
	J9bI26dVz897yLNqy5fFWUVZf59vM+ReIfRsybPdq206uhmSbrZ6mr2/ueOzn8uhN3obtz8v
	OL2iY8meE+UpRcrquRxKLMUZiYZazEXFiQDyuy5VXwMAAA==
X-CMS-MailID: 20241031204733eucas1p223f2ad621130055e20e81b7633054f26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241031204733eucas1p223f2ad621130055e20e81b7633054f26
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241031204733eucas1p223f2ad621130055e20e81b7633054f26
References: <CGME20241031204733eucas1p223f2ad621130055e20e81b7633054f26@eucas1p2.samsung.com>

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
 drivers/mailbox/mailbox-th1520.c              | 592 ++++++++++++++++++
 6 files changed, 711 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 create mode 100644 drivers/mailbox/mailbox-th1520.c

-- 
2.34.1


