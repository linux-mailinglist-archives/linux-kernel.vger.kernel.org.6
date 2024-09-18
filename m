Return-Path: <linux-kernel+bounces-332696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1424797BD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C556B247AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C3418B471;
	Wed, 18 Sep 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S8cw2y4E"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C200189B94
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667369; cv=none; b=o++uhqUp05LW+dL+c5+UVT+yt/v4LDqxDxNXo7ZqXJQJZkU7AlD3SX1j9QuxR7r+el0EFpnlY1upIT/f4PK7bvR4xK7brWF2xDP1cppIpq8qfR6NFD7jAW5gCrlDcwjvOSvZHb5We+zt1XWLTLvpDnxFIOYyXs9rysWA7gyumkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667369; c=relaxed/simple;
	bh=CXmJWO69iLBSJKhFpA7+xgBgfokjgMLyc1CMobFnnDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=AEoqagn+zhjDSOWU8KOzg8M5jbbrMK73D/+tCV44UnHAU5VLsuHIEoSDVRM8s1YdRJSggzDapq0f5YNaNDf7sAJ0kULMDv+ASG75ZnpgxH4hhvrPtclgAc8BcFormxAXNgNj9cUbprM7rReYl9a9wg69kfVPVAj+DehFyTO/92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=S8cw2y4E; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240918134924euoutp01b2f6d0cd9050cc064d75332374502bb0~2WtHUzfbK0180301803euoutp01h
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:49:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240918134924euoutp01b2f6d0cd9050cc064d75332374502bb0~2WtHUzfbK0180301803euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726667364;
	bh=2YxPZTOLkZcwxc0qTQPDuVgkqkGwM1oM6InXtFiVWOo=;
	h=From:To:Cc:Subject:Date:References:From;
	b=S8cw2y4EmlaOWdxBAcagy2+Ueu5nHQRAjfT6oZaUpv4b7vnPpFCazjl6kOr3DVmGQ
	 Y7OyQBK0zmAKPK2eFrnihqGo8UmvN4SlwIQ0Ul88jZCCb6E5BECGpeQeZTpi9zv5wq
	 P8r/5Phw7esBxYtm6M5tSpuSQo6aJVlJUgbXS5zA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240918134923eucas1p1e21cfc030d74b075202b7e0d9c330584~2WtG49sZW2402424024eucas1p1I;
	Wed, 18 Sep 2024 13:49:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 5E.CE.09620.36ADAE66; Wed, 18
	Sep 2024 14:49:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240918134923eucas1p1a9233b712f86b97ba8d4b9f4d7a7adbb~2WtGcTN_70702307023eucas1p1m;
	Wed, 18 Sep 2024 13:49:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240918134923eusmtrp2e79e75d2f29c6874a69fcf8cbcff2012~2WtGbRxpV0382403824eusmtrp2c;
	Wed, 18 Sep 2024 13:49:23 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-d8-66eada63b216
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 38.48.14621.36ADAE66; Wed, 18
	Sep 2024 14:49:23 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240918134922eusmtip19bd2ba369138b05771980d2eecf3a03c~2WtFtcor91778117781eusmtip1D;
	Wed, 18 Sep 2024 13:49:22 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH RFC v1 0/3] Introduce support for T-head TH1520 Mailbox
Date: Wed, 18 Sep 2024 15:48:58 +0200
Message-Id: <20240918134901.193033-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djP87rJt16lGXRtMLXY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shddov1X+czWby83MNs
	0TaL3+L/nh3sFi37p7A48Hu8efmSxeNwxxd2j52z7rJ7bFrVyeaxeUm9R8vaY0we7/ddZfPo
	27KK0eNS83V2j8+b5AK4orhsUlJzMstSi/TtErgyPlz9ylIwn6eir2ktSwPjec4uRk4OCQET
	iV/tu9m6GLk4hARWMEo0X77MCOF8YZTYufY1K4TzmVHiYuslRpiWtX+OQVUtZ5R40HEDynnD
	KPF64yx2kCo2ASOJB8vng7WLCLxjlJh07TYTiMMs0MsoMXXvTCCHg0NYwF1iyTMbkAYWAVWJ
	Ixf3gTXzCthJnFk+kwVinbzE/oNnmSHighInZz4BizMDxZu3zmYGmSkh8J9Dou/9Yqj7XCQW
	N+2DsoUlXh3fwg5hy0j83zmfCcLOl3iw9RMzhF0jsbPnOJRtLXHn3C82kNuYBTQl1u/Shwg7
	Sjxa3csIEpYQ4JO48VYQ4gQ+iUnbpjNDhHklOtqEIKrVJKb29MItPbdiG9RSD4l5vyeALRIS
	iJXYfnAH0wRGhVlIHpuF5LFZCDcsYGRexSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZjq
	Tv87/nUH44pXH/UOMTJxMB5ilOBgVhLhFf/wMk2INyWxsiq1KD++qDQntfgQozQHi5I4r2qK
	fKqQQHpiSWp2ampBahFMlomDU6qBqf7W5xUbH/EpfRfS2HO1dOW1y5IGEreKv7+Ss5z5f1rm
	fdPABfEXPnD29S0u1Q37x2sjdUe1OFux3MyisSNCvK+RWfSuyvovrmJx2y8vXn9dfz+rvPa8
	HqlLhRG3zWvP/b6x46ayyAWDhtfLd6psaAr5+/X8mz8iIluEF75Ts12ie6YtokFvypcNdxf5
	Gx+X//jRbbGnZKqL2Ocyo5XeJU/Dj0x6YnFlv+vrg0ttHVzesSsxVqc/YdjPsDK2/u6Vx61W
	Tv8cf1W/DxdLqUiU7Tu9JGmj/IkVLpW2fy/k5DS/e6g6V1BiSp/+i7pb+gdCNmwtZq/Y81ud
	+dpsk2c74/58mWrO+rX93/MHrXpiS5RYijMSDbWYi4oTAS2KGbzkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7rJt16lGaw9Lm6x9fcsdos1e88x
	Wcw/co7V4t6lLUwWL/Y2slhcWzGX3eLlrHtsFpd3zWGz2Pa5hc1i7ZG77Bbrv85nsnh5uYfZ
	om0Wv8X/PTvYLVr2T2Fx4Pd48/Ili8fhji/sHjtn3WX32LSqk81j85J6j5a1x5g83u+7yubR
	t2UVo8el5uvsHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZ
	pKTmZJalFunbJehlfLj6laVgPk9FX9NalgbG85xdjJwcEgImEmv/HGPsYuTiEBJYyihxv+My
	G0RCRuJa90sWCFtY4s+1LrC4kMArRonjmwJBbDYBI4kHy+ezgjSLCPxhlLj+7A3YJGaBiYwS
	N+feB3I4OIQF3CWWPLMBaWARUJU4cnEfO4jNK2AncWb5TKgF8hL7D55lhogLSpyc+QQszgwU
	b946m3kCI98sJKlZSFILGJlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbYtmM/N+9gnPfq
	o94hRiYOxkOMEhzMSiK84h9epgnxpiRWVqUW5ccXleakFh9iNAW6byKzlGhyPjDK80riDc0M
	TA1NzCwNTC3NjJXEed0un08TEkhPLEnNTk0tSC2C6WPi4JRqYJKf5LB1v4rT/yWysmeCjWW4
	q7h0XVbNX3yq4TJfYqb/kTPuJ3o9ZFa6vXDN73q68Zvv6UPTljBKZ2x0iRQ5OkNn3/8rv7W9
	NVPnhjH2H8xZ6Lpm84k7ZQbJtwM/lM/OsjOV6fgaUS0/m0FOIF1idZhrmT2DVNr8x4uv6rr8
	uzShNLik2m7Rkb58zYuaphvynjMd8Wk75mN18uj0b9tfG37lav2sVmVQXW10+ufx07XzFnnO
	6d7o/3ZZktsXkVVXz86J9m7bv7/p/r9Liptalr0OPVERq+Soll4eaFkfmGy3p+p0v9js46ed
	/jHMEFl+OC8n8rnqvXB+OxYvN49pFnNVvv3KlrPQYeAtOGzrp8RSnJFoqMVcVJwIAF9drWw6
	AwAA
X-CMS-MailID: 20240918134923eucas1p1a9233b712f86b97ba8d4b9f4d7a7adbb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240918134923eucas1p1a9233b712f86b97ba8d4b9f4d7a7adbb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240918134923eucas1p1a9233b712f86b97ba8d4b9f4d7a7adbb
References: <CGME20240918134923eucas1p1a9233b712f86b97ba8d4b9f4d7a7adbb@eucas1p1.samsung.com>

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

Michal Wilczynski (3):
  mailbox: Introduce support for T-head TH1520 Mailbox driver
  dt-bindings: mailbox: Add thead,th1520-mailbox bindings
  riscv: dts: thead: Add mailbox node

 .../bindings/mailbox/thead,th1520-mbox.yaml   |  83 +++
 MAINTAINERS                                   |   2 +
 arch/riscv/boot/dts/thead/th1520.dtsi         |  15 +
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mailbox-th1520.c              | 598 ++++++++++++++++++
 6 files changed, 710 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 create mode 100644 drivers/mailbox/mailbox-th1520.c

-- 
2.34.1


