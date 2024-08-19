Return-Path: <linux-kernel+bounces-291730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 404D89565FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74913B23153
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C37515B140;
	Mon, 19 Aug 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="ZUPsHP7x"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AFB14BF8A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057349; cv=none; b=J8bBGSeajxN6/m72aQJDT9flBaf34cW38Z4pez8DEnn/LbdSbAFMwaHRKDXFIAg3xRnCMarekZKwpLR0egT72sI5d0qHoJ9+MVpz7uIblLs28xzCtB46QlrBPy7G4GiHdDO0sitry39zQvv5quh/2HPSUR/KpDaizxxykN0wL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057349; c=relaxed/simple;
	bh=bhYkbt/NfI1H8kYRGifKW3wSQpR5N/5WLn+jI521hXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kISgzcJ3B57KM8eMwDDUza61SFEr3nFzL3PkG6gGGJn5T9f7KP5TeWx0nNG3AR2EzlVH/xkGXbfZe3DgRxfWyYGY6IW2bOjzvpq3+Ay2UH4avmzhpYe4pAKU//4XrH+SWG5pMSq4wF+XwE+hew2ytp9xj8jwy44Zehb2xtXuoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=ZUPsHP7x; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1724056421; x=1726648421;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bhYkbt/NfI1H8kYRGifKW3wSQpR5N/5WLn+jI521hXs=;
	b=ZUPsHP7xoa5bFiztIh5KPvKXnb7MExVMqMIxz4IgVimxMDYPBGPPRJyLHVwDRHAf
	fRbME7VBYPoeQAa5eGTuszO1hzqxPBbfC/cKVf8LAqYASpPGiRFMm7Ao82DQAlNv
	0dN8ayldlAaZM+oNg0RW6PnwBCoNs7WwiCmEyDQ1D2Q=;
X-AuditID: ac14000a-03251700000021bc-fd-66c30364c81f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A4.27.08636.46303C66; Mon, 19 Aug 2024 10:33:40 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 19 Aug
 2024 10:33:39 +0200
Message-ID: <04bba41d-7e7f-4c3f-9f92-1b4165968c12@phytec.de>
Date: Mon, 19 Aug 2024 10:33:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/9] TI K3 M4F support on AM62 and AM64 SoCs
To: Andrew Davis <afd@ti.com>, Bjorn Andersson <andersson@kernel.org>, Mathieu
 Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Hari
 Nagalla <hnagalla@ti.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240802152109.137243-1-afd@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240802152109.137243-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWyRpKBRzeF+XCawZI/FhbvT01kt9jWYWOx
	Zu85Jov5R86xWmw/0MlusfzzbHaLl7PusVlsenyN1eLyrjlsFs3nlSy27jnAZPHmx1kmi7v3
	TrBY/N+zg93i/9kP7A78HptWdbJ53Lm2h81j85J6j/6/Bh7Hb2xn8vi8SS6ALYrLJiU1J7Ms
	tUjfLoEr43fDN+aCRZIVD9/fYmxg3C3cxcjBISFgIjHlfVEXIxeHkMASJonmvVfYIZy7jBKz
	Dm1g6WLk5OAVsJHo/vKBCcRmEVCVOPv/EVRcUOLkzCdgtqiAvMT9WzPYQWxhAReJz5O7mUAG
	iQhMY5Y4O3MKG4jDLNDHKNE98QMrSJWQgIHEtq2bmUFsZgFxiVtP5oNtYBNQl7iz4RtYDaeA
	oUTL5o8sEDUWEovfHGSHsOUlmrfOZoaYIy/x4tJysBoJIHvaudfMEHaoxNYv25kmMArPQnLs
	LCTrZiEZOwvJ2AWMLKsYhXIzk7NTizKz9QoyKktSk/VSUjcxgqJShIFrB2PfHI9DjEwcjIcY
	JTiYlUR4u18eTBPiTUmsrEotyo8vKs1JLT7EKM3BoiTOu7ojOFVIID2xJDU7NbUgtQgmy8TB
	KdXAKDPFaDlDaLv9tdNdTX75pR+8dG6Wfn/q16b3ZK7FZKHbvsdZuYuPKHwt3NmyYfcy3ZVO
	JjIrnEK7/8/2zy31rnA9lBvIXhuhEK4ZL+d0zcP1+F23prtlLqufHjFrtVj5ipf3kLyhgnXK
	/1uzgi/0KrxlVzuwrfH1eacCrTUsp5/6P/t15+wtJZbijERDLeai4kQAk74BbLgCAAA=



Am 02.08.24 um 17:21 schrieb Andrew Davis:
> Hello all,
> 
> This is the continuation of the M4F RProc support series from here[0].
> I'm helping out with the upstream task for Hari and so versions (v8+)
> is a little different than the previous(v7-) postings[0]. Most notable
> change I've introduced being the patches factoring out common support
> from the current K3 R5 and DSP drivers have been dropped. I'd like
> to do that re-factor *after* getting this driver in shape, that way
> we have 3 similar drivers to factor out from vs trying to make those
> changes in parallel with the series adding M4 support.
> 
> Anyway, details on our M4F subsystem can be found the
> the AM62 TRM in the section on the same:
> 
> AM62x Technical Reference Manual (SPRUIV7A – MAY 2022)
> https://www.ti.com/lit/pdf/SPRUIV7A
> 
> Thanks,
> Andrew
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20240202175538.1705-5-hnagalla@ti.com/T/
> 
> Changes for v11:
>   - Added patch [2/9] factoring out a common function
>   - Addressed comments by Mathieu from v10
>   - Rebased on v6.11-rc1
>   - Small reworks in driver for readability

Tested on a AM62x & AM64x using phycore-am62x & phycore-am64x, so

Tested-by: Wadim Egorov <w.egorov@phytec.de>

> 
> Changes for v10:
>   - Rebased on v6.10-rc3
>   - Added AM64 M4 support in DT
>   - Addressed comments by Mathieu from v9
> 
> Changes for v9:
>   - Fixed reserved-memory.yaml text in [1/5]
>   - Split dts patch into one for SoC and one for board enable
>   - Corrected DT property order and formatting [4/5][5/5]
> 
> Andrew Davis (1):
>    remoteproc: k3: Factor out TI-SCI processor control OF get function
> 
> Hari Nagalla (7):
>    dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
>    arm64: dts: ti: k3-am62: Add M4F remoteproc node
>    arm64: dts: ti: k3-am625-sk: Add M4F remoteproc node
>    arm64: dts: ti: k3-am64: Add M4F remoteproc node
>    arm64: dts: ti: k3-am642-sk: Add M4F remoteproc node
>    arm64: dts: ti: k3-am642-evm: Add M4F remoteproc node
>    arm64: defconfig: Enable TI K3 M4 remoteproc driver
> 
> Martyn Welch (1):
>    remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem
> 
>   .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 125 ++++
>   arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       |  13 +
>   .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  19 +
>   arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi       |  13 +
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts       |  19 +
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts        |  19 +
>   arch/arm64/configs/defconfig                  |   1 +
>   drivers/remoteproc/Kconfig                    |  13 +
>   drivers/remoteproc/Makefile                   |   1 +
>   drivers/remoteproc/ti_k3_dsp_remoteproc.c     |  28 +-
>   drivers/remoteproc/ti_k3_m4_remoteproc.c      | 667 ++++++++++++++++++
>   drivers/remoteproc/ti_k3_r5_remoteproc.c      |  28 +-
>   drivers/remoteproc/ti_sci_proc.h              |  26 +
>   13 files changed, 918 insertions(+), 54 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
>   create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c
> 


