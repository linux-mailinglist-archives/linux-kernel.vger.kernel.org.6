Return-Path: <linux-kernel+bounces-364035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8622899CA44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E3286FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843BB1A724E;
	Mon, 14 Oct 2024 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="akTXcsLG"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA771A4F3E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909254; cv=none; b=EIOTii8LY5O9Gwl4qyQ4fFd6ey1cPFjhQNvrus6MRGDkKZmprDRjVVDBkFPto+N/IquOW8zBZhDM07CnSV3wmfj83ClQYzK61i2j+/0vcQk92YjUi2kud30xpKi+qqLImqH06zL4sUarcxkAJpS8k02Tr2oo31WW+TOsRT/HGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909254; c=relaxed/simple;
	bh=s5QdeOY0Tqmej/WQlh4JB/3DglV3xo+ZaWbd0MXTuNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ZXeebZpSolTk4gAaJU+OlnKfa6so67RTbS/HFbCkka7YzUFq1bKGZ0gzDvKGvktnS9Cbl8dOpzRugo5fNPdcRp7lA/FRdJ8YMxMeE24hFU1BzuJRP3rENfCG2j7xKRimsNgFOFFkOIsDV6qXke58iIJ+D8cpYDWiFOapC+mB+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=akTXcsLG; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241014123410euoutp02ab9aa57da1dfea6d0172693cf64e0c22~_Uc23JRrH1581815818euoutp02P
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:34:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241014123410euoutp02ab9aa57da1dfea6d0172693cf64e0c22~_Uc23JRrH1581815818euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728909250;
	bh=RxjT3EdAm9IfbZlO07dZ0QJ2+iDgnYJWJxUqUfU4SVU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=akTXcsLGvlkkSMERyla3/kpB9BV9AEKHMBnUVqXK2a4CsKd7UJigLCYlDrfLOdis2
	 LyW+upmkX6GKpjAOt6QpQFxhqDGV0NWBU7vbgideljUlESrz6qKnhnfhMUb6dxi/pF
	 zRN8w3mht2i/EqdT4AtrcuS6q3lpH7JlfBlIP76I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241014123410eucas1p2de2e962ef1a6bacd3bed1bd0b5a8db31~_Uc2eRl5d1540015400eucas1p2Q;
	Mon, 14 Oct 2024 12:34:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id DC.01.09875.2CF0D076; Mon, 14
	Oct 2024 13:34:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241014123409eucas1p2a3a3f085c0630073326ca299a870f3ee~_Uc1utgiM0434804348eucas1p2F;
	Mon, 14 Oct 2024 12:34:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241014123409eusmtrp2f130e8599db8cffdbbe1d08ac3473b85~_Uc1t8iOV2056020560eusmtrp2w;
	Mon, 14 Oct 2024 12:34:09 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-76-670d0fc264f1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id CE.21.14621.1CF0D076; Mon, 14
	Oct 2024 13:34:09 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241014123408eusmtip13736174d0628a4ab24e6670b41ca98af~_Uc07rt2M1142111421eusmtip1c;
	Mon, 14 Oct 2024 12:34:08 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v4 0/3] Introduce support for T-head TH1520 Mailbox
Date: Mon, 14 Oct 2024 14:33:11 +0200
Message-Id: <20241014123314.1231517-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djPc7qH+HnTDfatEbfY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shddov1X+czWby83MNs
	0TaL3+L/nh3sFi37p7A48Hu8efmSxeNwxxd2j52z7rJ7bFrVyeaxeUm9R8vaY0we7/ddZfPo
	27KK0eNS83V2j8+b5AK4orhsUlJzMstSi/TtErgyjl/8z1ZwWbxiyem/rA2ML4S6GDk4JARM
	JPbu9Oti5OIQEljBKNH3fDojhPOFUeLD7qfsEM5nRokFS+6xdTFygnXMunEGKrGcUeLY/SVs
	EM4bRokTbR9ZQKrYBIwkHiyfzwqSEBF4xygx6dptJhCHWaCXUWLq3plMIFXCAs4Snyc/YQax
	WQRUJX5//A3WzStgL7Gn5yA7xD55if0HzzJDxAUlTs58AlbDDBRv3jqbGWSohMB0Tonlt9aw
	QjS4SPw42At1rLDEq+NboAbJSPzfOZ8Jws6XeLD1EzOEXSOxs+c4lG0tcefcLzZQ0DALaEqs
	36UPEXaUWDJjNhMkxPgkbrwVhDiBT2LStunMEGFeiY42IYhqNYmpPb1wS8+t2Aa11EPi5dmf
	YIcJCcRKvP8ylXECo8IsJI/NQvLYLIQbFjAyr2IUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/d
	xAhMdaf/Hf+yg3H5q496hxiZOBgPMUpwMCuJ8L6fypkuxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nFc1RT5VSCA9sSQ1OzW1ILUIJsvEwSnVwDT797QbD61Uvge3rS/Zfyx1b/XsVaKXrCYbKi7h
	jRaYMTtn2V7H1btk/igkhvJqBJ9dq3BywayWCwprrJMKvVmyyiJu8vqwGunKf9NKWxv3qnGy
	5VT/pq/eFlP/rLl7kXXJh/Cm6su75L5nyM/h67d3D10qK+sTEfr16HY3loULlv6/1/L51ty/
	sTsSfRcV6uj+vTplSVfbnJXtezWvp8hzxhR/vfC2R/rj5hnTuW0LL+ZFLnp2quvJHA22fI5I
	LbOmrEm5cg+WSl9xTXze8EtH8dOS96r+V2+m/jpi4nz1GMOZbSs+telLOOWaFU6yYXimxmxu
	b3xiesBv0a//X/btfN+mvejn2rVHdgVv//1FiaU4I9FQi7moOBEAFrupUOQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xu7oH+XnTDT4uVrXY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shddov1X+czWby83MNs
	0TaL3+L/nh3sFi37p7A48Hu8efmSxeNwxxd2j52z7rJ7bFrVyeaxeUm9R8vaY0we7/ddZfPo
	27KK0eNS83V2j8+b5AK4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1s
	UlJzMstSi/TtEvQyjl/8z1ZwWbxiyem/rA2ML4S6GDk5JARMJGbdOMPexcjFISSwlFHiW+8f
	VoiEjMS17pcsELawxJ9rXWwQRa8YJSbOn8EEkmATMJJ4sHw+K0hCROAPo8T1Z28YQRxmgYmM
	Ejfn3mcEqRIWcJb4PPkJM4jNIqAq8fvjb7CxvAL2Ent6DrJDrJCX2H/wLDNEXFDi5MwnQDUc
	QIPUJdbPAzuVGaikeets5gmM/LOQVM1CqJqFpGoBI/MqRpHU0uLc9NxiQ73ixNzi0rx0veT8
	3E2MwJjcduzn5h2M81591DvEyMTBeIhRgoNZSYT3/VTOdCHelMTKqtSi/Pii0pzU4kOMpkBX
	T2SWEk3OByaFvJJ4QzMDU0MTM0sDU0szYyVxXrfL59OEBNITS1KzU1MLUotg+pg4OKUamISf
	c0oY+pVp92XPcze8un/CM+32zO7rP/WX/t1n/mj153gLOy3upT/K55wWe3Xyy7dD7yMnJH3a
	ftfx2BWhzmP7Fjjv8VPwPO38dyqXmDavId/PG8mcO59eqHr7f1XzohNvVM0f/MpniDLh38dS
	dvH/R8Xvr93lVj9qattgFyWlZjl7jVKOkM9U99kVyjdvHS6w//90YpLu7srn616dvhLSOW/i
	G3vO+2GVNaLp+TWsE2d4SFpr3ihQYHj6uThFQf7PbxPRHy+MnGMPXUluzmgqmXXz6mFWq8I5
	JW17Jiz/Kt1608SxfJ64yJ0Nm71t5OcemWM0WTY9qkWPJUXXXb7o4os5LM3vFwok6Au3TVVi
	Kc5INNRiLipOBACmqlypUgMAAA==
X-CMS-MailID: 20241014123409eucas1p2a3a3f085c0630073326ca299a870f3ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241014123409eucas1p2a3a3f085c0630073326ca299a870f3ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241014123409eucas1p2a3a3f085c0630073326ca299a870f3ee
References: <CGME20241014123409eucas1p2a3a3f085c0630073326ca299a870f3ee@eucas1p2.samsung.com>

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

Thanks, Krzysztof and Rob, for your review! Since this series is gaining
some interest, I've dropped the RFC prefix with the v3 update.

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

 .../bindings/mailbox/thead,th1520-mbox.yaml   |  80 +++
 MAINTAINERS                                   |   2 +
 arch/riscv/boot/dts/thead/th1520.dtsi         |  12 +
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mailbox-th1520.c              | 572 ++++++++++++++++++
 6 files changed, 678 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 create mode 100644 drivers/mailbox/mailbox-th1520.c

-- 
2.34.1


