Return-Path: <linux-kernel+bounces-546268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739FA4F88E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6FD189152D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EFE1FAC56;
	Wed,  5 Mar 2025 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U4AZgIbJ"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA91F584D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162704; cv=none; b=QF+iqdHFW/L8w55AlMHeVY9wQPNurz5Fd/0KUxYsjVKPUTXqTn4rSKh2OhqXc21XbrVh0AXSwNEyaalmN84GL4v5z7eRkJKmc5V3WL5ogHJxZtM4Woj7Sq4NRzIiIcgIQeiUku6pJMZp287GUi4+Cq/8E5oqCitfKWD+wW5ALjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162704; c=relaxed/simple;
	bh=IfMSOKZTMOR/zUAsd33nCSnuKAx0Gro/YjVBG4QSDJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Zo4w4G0a2QDWSKwcx9RU30PwRGvxrw9/DNMOPv+0BSE3qtrB+kUFJ8yTxwiIrrFeNL4LEfTXu8z6ZJx0UI2yaqAMfS2DV+Aw72/sLvIU3QwIlSlCTFb1w1+GTlkpnkivlxSIQ+NDII5qvprpE+PqUjcfXeT76h0Ughal0kfNjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=U4AZgIbJ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250305081820euoutp02ef8dcc95af22c98403ef315306cab11d~p2kBQXO8h0507605076euoutp02b
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:18:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250305081820euoutp02ef8dcc95af22c98403ef315306cab11d~p2kBQXO8h0507605076euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741162700;
	bh=z4bDXZf0zsJpmZ4gA2EzfPRJzWcAnMN3iUbKKNxEAqw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=U4AZgIbJrV0ftB2eAPxu4/Q1MpiU7XHy4CJk37GMm6A3SKoWflD3QOk6rP9NBpXrD
	 MpOUWrNkmGXu8en1XNJuSblch/tleiU80mgmuBIjMvzQQ0jqBpOpEuRGH+Q9PweUPN
	 8eSZvmr2zf9XYgaxq9FKfhrPJ2ifKJ/5XZkMggU8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250305081820eucas1p18a6b69372f0a694f81bb00b333eef309~p2kA06VGb2579125791eucas1p1Z;
	Wed,  5 Mar 2025 08:18:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 6C.C7.20397.CC808C76; Wed,  5
	Mar 2025 08:18:20 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250305081819eucas1p1ad27dd6b7ef53e4ea95adfad46d9dca3~p2kAXXGKD2578725787eucas1p1b;
	Wed,  5 Mar 2025 08:18:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250305081819eusmtrp14276678062258e5a01766bbc121cbd9f~p2kAWl2PV0646206462eusmtrp1R;
	Wed,  5 Mar 2025 08:18:19 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-c5-67c808cc7540
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 2D.4B.19654.BC808C76; Wed,  5
	Mar 2025 08:18:19 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250305081818eusmtip26ea063d1e2190b225e572c1a657e70ab~p2j-XBYUu0942709427eusmtip2F;
	Wed,  5 Mar 2025 08:18:18 +0000 (GMT)
Message-ID: <8ffa6276-299c-4a95-8c7d-cbe39c1a1457@samsung.com>
Date: Wed, 5 Mar 2025 09:18:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Add T-Head TH1520 VO clock support for LicheePi
 4A GPU enablement
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250303143629.400583-1-m.wilczynski@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7djPc7pnOE6kG1x8ymXx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZfOy5x2pxedccNottn1vYLNYeuctu
	cfGUq8XdeydYLF5e7mG2aJvFb/F/zw52i3/XNrJYtOyfwuIg7PH+Riu7x5uXL1k8Dnd8Yfe4
	d2Iaq8emVZ1sHpuX1Hu0rD3G5NH/18Dj/b6rbB59W1Yxelxqvs7u8XmTXABPFJdNSmpOZllq
	kb5dAlfG875WloJzUhWH795jb2A8KtrFyMkhIWAi8f/YLMYuRi4OIYEVjBKv959jgnC+MErc
	atjJDOF8ZpT41P+eEabl9e7TYLaQwHJGicVHayCK3jJKbGh6zwKS4BWwk2jf/IoNxGYRUJGY
	tKeHCSIuKHFy5hOwGlEBeYn7t2awg9jCAvESq+6tZgcZJCKwh0ni+/efzCAJZoEqiR33b7BD
	2OISt57MBxvEJmAk8WD5fFYQm1PAXuLQ9QYWiBp5ieats8HOlhB4ximxbM5qoAYOIMdF4uZe
	dogPhCVeHd8CZctInJ7cwwJh50s82PqJGcKukdjZcxzKtpa4c+4XG8gYZgFNifW79CHCjhI/
	r89hg5jOJ3HjrSDEBXwSk7ZNZ4YI80p0tAlBVKtJTO3phVt6bsU2pgmMSrOQAmUWkh9nIfll
	FsLeBYwsqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQLT5ul/x7/uYFzx6qPeIUYmDsZD
	jBIczEoivK9PHU8X4k1JrKxKLcqPLyrNSS0+xCjNwaIkzrtof2u6kEB6YklqdmpqQWoRTJaJ
	g1OqgSnpG2foPjvGUyUTO033uRqu8zfoi5uusfvR7TsPTM+vtmsN5RKbIvf4tmD3j4sOITrH
	Lk0SiSksNfkhx35pqQjHm9jwx999lzzKE1PrP7O+2uqc1mEetd+Se0K1PjIeubgioWPT3e0X
	npuUJLryvn8086Wx3IMZvleePJOdMWnx3okdN068XKioslbIrJjjdtu2jQfVOrOnuxxRsar5
	tnpvLKPewl8xs+dmilztFf/Tn+H44XJNy/k3r5feP7A4dVnMsydn2oLePxDY9OAV8wnPP5pP
	J5Qe4xc8/OiJ89IUt79PTWZUvvqms+XPs/Z71e8XndUIP65yepXguuCsO00cLF+W8LQrfbb0
	/H1Vp7KmXomlOCPRUIu5qDgRACgaknMKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42I5/e/4Pd3THCfSDS63q1g8u/OV1WLr71ns
	Fmv2nmOymH/kHKvFvUtbmCxe7G1ksWg+tp7N4uWse2wWH3vusVpc3jWHzWLb5xY2i7VH7rJb
	XDzlanH33gkWi5eXe5gt2mbxW/zfs4Pd4t+1jSwWLfunsDgIe7y/0cru8eblSxaPwx1f2D3u
	nZjG6rFpVSebx+Yl9R4ta48xefT/NfB4v+8qm0ffllWMHpear7N7fN4kF8ATpWdTlF9akqqQ
	kV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxvK+VpeCcVMXhu/fY
	GxiPinYxcnJICJhIvN59mrGLkYtDSGApo8SOs5fZIRIyEte6X7JA2MISf651sUEUvWaUuP74
	GhtIglfATqJ98yswm0VARWLSnh4miLigxMmZT8CaRQXkJe7fmgE0lINDWCBeonGqNcgcEYE9
	TBJ/p8wD62UWqJI4v/cKK8SCSYwSLVeWMUMkxCVuPZkPNpRNwEjiwfL5rCA2p4C9xKHrDSwg
	Q5kF1CXWzxOCKJeXaN46m3kCo9AsJGfMQjJpFkLHLCQdCxhZVjGKpJYW56bnFhvpFSfmFpfm
	pesl5+duYgQmim3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeF+fOp4uxJuSWFmVWpQfX1Sak1p8
	iNEUGBQTmaVEk/OBqSqvJN7QzMDU0MTM0sDU0sxYSZyX7cr5NCGB9MSS1OzU1ILUIpg+Jg5O
	qQYm/8TgDc/Y+kVnKxw0/Ve37wN//vmDD9o/V+5+M637mbvJswmMy1eWlQi8Lbj0f3VR0imj
	61E5oV9mfJSN+FS0pOb37brWQ8mHGiveOomc/reu4WlZ69HKyGqTQ+t/7QxSi7804Wa3ypki
	qbash2ZnZ3qUPpHcE2txIuiEut+a5aVfPa6wNocuZOzmCI+KPFoV3vvBxZDleK1o878NCUmP
	D9lX9L57fvTPkiCp/3dfpMm8uzM3ReG08kurYyliTh4HJCZXljUu36914n//DHm/jf82BO1X
	4Hybd68muWdniCN7s+im/4p/gsJDKza2d5+bc+eUy7zJdw/xFRiHh55cfIs3QLFULKD2Wlu9
	sa6ZEktxRqKhFnNRcSIAeuKmp50DAAA=
X-CMS-MailID: 20250305081819eucas1p1ad27dd6b7ef53e4ea95adfad46d9dca3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303143634eucas1p269281f72bdc4d764edd54b9427f68787
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303143634eucas1p269281f72bdc4d764edd54b9427f68787
References: <CGME20250303143634eucas1p269281f72bdc4d764edd54b9427f68787@eucas1p2.samsung.com>
	<20250303143629.400583-1-m.wilczynski@samsung.com>



On 3/3/25 15:36, Michal Wilczynski wrote:
> This is a subset of a larger patch series enabling the Imagination BXM-4-64 GPU
> on the LicheePi 4A board, which is powered by the T-HEAD TH1520 SoC. While the
> full series includes power-domain, reset, and firmware changes, this part
> focuses solely on the clock subsystem needed for the GPU and other VO (video
> output) blocks. By merging these clock patches independently, we prepare the
> groundwork for future GPU integration via the `drm/imagination` driver.
> 
> The T-HEAD TH1520 SoC features multiple clock controllers. Initially, only the
> AP clock controller was supported upstream. The patches below add support for
> the VO (video output) clock controller, which manages GPU-related gates, HDMI,
> and other multimedia clocks. Additionally, they introduce a mechanism to
> provide no-op operations for the GPU's "mem" clock gate (documented as
> “Reserved” in the hardware manual) and coordinate the GPU CLKGEN reset in the
> clock driver.
> 
> Bigger series cover letter:
> 
> https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/

This series should be versioned as v6, to maintain continuity with the
bigger patchset it is a subseries of. Please find below a changelog for
the clock sub-series:

v6:
- squashed the "dt-bindings: clock: thead: Add GPU clkgen reset property"
  with the "dt-bindings: clock: thead: Add TH1520 VO clock controller". As
  a result, also removed the Reviewed-by from Krzysztof, since the new
  resets property has been introduced, which is mandatory in the VO
  case

v5:
- introduced a new macro CCU_GATE_CLK_OPS, which allows providing custom clk_ops.
  In the case of the 'MEM' clock, it provides empty clk_nops. Later, this clock
  is provided to the GPU node, thereby avoiding any ABI breakage
- used the CCU_GATE_CLK_OPS macro to implement a workaround for de-asserting
  the clkgen reset only after both core and sys clocks are enabled. This
  sequence is required to properly initialize the GPU

v4:
 - enhanced documentation for new Video Output (VO) clock inputs in device tree
   bindings

v3:
 - reworked driver to support multiple clock controllers through .compatible
   and .data instead of using multiple address spaces in dt-binding. This change
   allows to re-use the driver code for multiple clock controllers

v2:
 - removed AP_SUBSYS clock refactoring commits (1-6):
 - instead of refactoring, I opted to extend the current driver and its
   associated device tree node to include support for a second address space.
 - resolved all checkpatch issues using --strict, except for the call to
   devm_clk_hw_register_gate_parent_data().  The current implementation remains
   preferable in this context, and clang-format aligns with this choice

> 
> Michal Wilczynski (4):
>   dt-bindings: clock: thead: Add TH1520 VO clock controller
>   clk: thead: Add clock support for VO subsystem in T-Head TH1520 SoC
>   clk: thead: Add support for custom ops in CCU_GATE_CLK_OPS macro
>   clk: thead: Add GPU clock gate control with CLKGEN reset support
> 
>  .../bindings/clock/thead,th1520-clk-ap.yaml   |  33 +-
>  drivers/clk/thead/clk-th1520-ap.c             | 298 ++++++++++++++++--
>  .../dt-bindings/clock/thead,th1520-clk-ap.h   |  34 ++
>  3 files changed, 334 insertions(+), 31 deletions(-)
> 

