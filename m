Return-Path: <linux-kernel+bounces-199009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D9E8D807C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF1C2B220E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8514783CCB;
	Mon,  3 Jun 2024 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aTBfsG3m"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E502778C80
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412579; cv=none; b=HAtSmOe1X8S7ysleSzrgpHcru/SyUWXOOMwAKYqQR4LYdz92sjqAQvykKlh0AI0iUfoH46nv56CTHhVst9BC7akrJf+AqMpwgLVEyfY2asRCNAKKqTj7Qu0MH3GLBzdafolCb2C5kSQ3wodJ5A/XwzUg9LYXRdY5h4PEIJ/cxHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412579; c=relaxed/simple;
	bh=Hz+QOiNXfdRocqqvM1P1Cz8l1xb0oLt1qoEdbTHesI4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=P3RpOKAnoJTtW+fvHkgDmRaLx7nTPzYeecjyKvxPfEmbOFy3ZSLbVdb5+1f0jl31hBV8G3vd7xLsKU2S8ioj51XEyHEQHB4sunjldVCbPzfp0HoTcrpWrwLWUvqmOEDygXyKJqMNmkZzFd/NRy4cA10e2iQbA/i5J/nyxd2in30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aTBfsG3m; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240603110253epoutp04ba1e2599c0251194a6b905c384254790~VeaL5k9hL0745507455epoutp04m
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 11:02:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240603110253epoutp04ba1e2599c0251194a6b905c384254790~VeaL5k9hL0745507455epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717412573;
	bh=4Q+U5KnyvuMp+bndOsiFnEHmV6Drv1tUz1F+LkhtJEI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=aTBfsG3mj6DSuVWwkjWTfVVQr30SQJiugPYf1syuEjE9lWZkhIFvIMwoc5h1iWPrI
	 K6IGDoCNnucv8H6XEvXY0vxJNqw53rzJgJFtj3H0HsdjILmMv1gGU3SsV9m6MoJDIS
	 0Xb2QrqYpVLV9U21eu1PR4ZhXYdDi2dk7EhuOBSM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240603110253epcas1p26050d248242c79711160803bb6c7b547~VeaLXprjV1917919179epcas1p2j;
	Mon,  3 Jun 2024 11:02:53 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.250]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Vt9ms0swBz4x9Pq; Mon,  3 Jun
	2024 11:02:53 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	6E.96.09622.CD2AD566; Mon,  3 Jun 2024 20:02:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240603110252epcas1p4e0ead148f7e8c85728db2b6dc8d79dbf~VeaK1QOQr0343203432epcas1p4t;
	Mon,  3 Jun 2024 11:02:52 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240603110252epsmtrp17cf406aa04674fc07c10c370c200cd76~VeaK0ltMN3072030720epsmtrp1K;
	Mon,  3 Jun 2024 11:02:52 +0000 (GMT)
X-AuditID: b6c32a37-075fa70000002596-23-665da2dcc06f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	8D.ED.18846.CD2AD566; Mon,  3 Jun 2024 20:02:52 +0900 (KST)
Received: from sgsupark03 (unknown [10.252.69.53]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240603110252epsmtip22f645a091fc0655b79b8045c8e7f07c6~VeaKohqhZ0468104681epsmtip2e;
	Mon,  3 Jun 2024 11:02:52 +0000 (GMT)
From: "Seongsu Park" <sgsu.park@samsung.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
	<mark.rutland@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<infinite.run@gmail.com>, <sgsu.park@samsung.com>
In-Reply-To: <20240523122146.144483-1-sgsu.park@samsung.com>
Subject: RE: [PATCH] arm64: Cleanup __cpu_set_tcr_t0sz()
Date: Mon, 3 Jun 2024 20:02:52 +0900
Message-ID: <000001dab5a5$94580a40$bd081ec0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH8m0kGjlO3sBEuOPUVgIk9EwDJ9wFU9gUNsWdr81A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmnu6dRbFpBq9n21j8/PKe0eL9sh5G
	iz8bdzNZbHp8jdXi8q45bBZLr19ksnjf0MVq0XLH1IHDY828NYweO2fdZffYtKqTzWPzknqP
	vi2rGD0+b5ILYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLx
	CdB1y8wBOkdJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeul5da
	YmVoYGBkClSYkJ3xYFlBwX/eip45K9kaGM9xdzFycEgImEjsPGfXxcjFISSwg1Fi84MrjBDO
	J0aJrft/sXUxckI4i9ujQGyQhkWLl7FDFO1klHi8ZgcrhPOcUeLi3KnMIFVsAjoS375NYQGx
	RQRiJa6enQI2iVmgXmLF4mesIDangI3E3Z3fwOLCAhYSx+b9AbNZBFQknj9ZyQRi8wpYSrz5
	9wPKFpQ4OfMJC8QceYntb+cwQ1ykIPHz6TJWkHdEBKwkTl3RgSgRkZjd2cYMcpuEwFwOif7d
	Oxgh6l0kjl+ezQRhC0u8Or6FHcKWknjZ3wZlF0vs+7IGan6NxIN5e6Bse4mOZ20sILuYBTQl
	1u/Sh9jFJ/Huaw8rJER5JTrahCBMZYlzWx0hTEmJPwv0IGZ4SGz5f5J1AqPiLCRvzULy1iwk
	989CWLWAkWUVo1hqQXFuemqxYYExPJ6T83M3MYITqZb5DsZpbz/oHWJk4mA8xCjBwawkwttX
	F50mxJuSWFmVWpQfX1Sak1p8iNEUGNATmaVEk/OBqTyvJN7QxNLAxMzIxMLY0thMSZz3zJWy
	VCGB9MSS1OzU1ILUIpg+Jg5OqQam+e1O105Gfy31tPIsqvzBdE4r5k5CZMP9uK1VcXaqP+0W
	t/UWuO3z/jjPYdtxN6ltD7coBMwImdp3/sINvtf93YdvPzpkHBC8iK974sXDPa+fX/8q66aw
	R+ZuuNGu5MnXH369PLP6ucyyA3/KPdyW+klE2mx44mMj0/rn8UnZi+7tMx8Y8bA0scR9/HHA
	bPnjfp0XbqVzTmpmTMqyeeVeumV5gtydlUtmzPPh1qx8Vlcs86Ti2q1XJ64EruTRU7zAcG3a
	bB+vyQ+3BB6My1p3YP3Mib4thbWT2S4n7WGRDDr2ICjcNeGJbUMewxQRuVpZq85HXtbsHuV7
	JmpOfs19rOfEkVXO8crn1m1qTOXRUmIpzkg01GIuKk4EAPWlatwtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXvfOotg0gxMbFSx+fnnPaPF+WQ+j
	xZ+Nu5ksNj2+xmpxedccNoul1y8yWbxv6GK1aLlj6sDhsWbeGkaPnbPusntsWtXJ5rF5Sb1H
	35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZTxYVlDwn7eiZ85KtgbGc9xdjJwcEgImEosWL2Pv
	YuTiEBLYziix+MR/JoiEpET7u8ssXYwcQLawxOHDxRA1Txkl+rZMZQOpYRPQkfj2bQoLiC0i
	kChx4upeZpAiZoFmRon/l48wQXT0Mkps+bgIrINTwEbi7s5vYLawgIXEsXl/wGwWARWJ509W
	gm3mFbCUePPvB5QtKHFy5hOwDcwC2hJPbz6FsuUltr+dwwxxqYLEz6fLWEEuFRGwkjh1RQei
	RERidmcb8wRG4VlIJs1CMmkWkkmzkLQsYGRZxSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iREc
	VVpBOxiXrf+rd4iRiYPxEKMEB7OSCG9fXXSaEG9KYmVValF+fFFpTmrxIUZpDhYlcV7lnM4U
	IYH0xJLU7NTUgtQimCwTB6dUA5OA8/EDfGplex4fe+m6KqJA0/rrrwc3Hk3qvJ56X2OFE+vM
	/dHPxZ3jF6l5xnscnmSyqC74zUfhGbEli68ceXYvK7y6LzGDL4JpwpOXSaovIo+q2jXsPrtM
	9xlbWsT+7iM2DhdKM7w+eql8W1LzL/3HamaL2qOXmlxNH72IaDjkl7O1VMUgYuf1LIcZVY+4
	Tx1fVP32ZV+TdMi6aJV9hy7qSE9Qs19hqvBvH6vxxYPsnRH6cVfn8vznMi5/ZiDz1eZRaSK3
	R/Q59/zuM1rKv/lX9hW5Cj7fwR3rWTRpl0DFkcsML13776clmClNnhZ/bPrqbaoPZ0mdCxS9
	rXin2LA31F4i+sKPs36/b4duna7EUpyRaKjFXFScCAB/2e1CGQMAAA==
X-CMS-MailID: 20240603110252epcas1p4e0ead148f7e8c85728db2b6dc8d79dbf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240523122152epcas1p49d579e40d4ef0c442820cc01f79ab38b
References: <CGME20240523122152epcas1p49d579e40d4ef0c442820cc01f79ab38b@epcas1p4.samsung.com>
	<20240523122146.144483-1-sgsu.park@samsung.com>

Dear All,

Please check this patch.
I think this patch is appropriate.

Thanks.
Seongsu Park.

> -----Original Message-----
> From: Seongsu Park <sgsu.park@samsung.com>
> Sent: Thursday, May 23, 2024 9:22 PM
> To: catalin.marinas@arm.com; will@kernel.org; ardb@kernel.org;
> mark.rutland@arm.com
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> infinite.run@gmail.com; sgsu.park@samsung.com
> Subject: [PATCH] arm64: Cleanup __cpu_set_tcr_t0sz()
> 
> The T0SZ field of TCR_EL1 occupies bits 0-5 of the register and encode the
> virtual address space translated by TTBR0_EL1. When updating the field,
> for example because we are switching to/from the idmap page-table,
> __cpu_set_tcr_t0sz() erroneously treats its 't0sz' argument as unshifted,
> resulting in harmless but confusing double shifts by 0 in the code.
> 
> Co-developed-by: Leem ChaeHoon <infinite.run@gmail.com>
> Signed-off-by: Leem ChaeHoon <infinite.run@gmail.com>
> Signed-off-by: Seongsu Park <sgsu.park@samsung.com>
> ---
>  arch/arm64/include/asm/mmu_context.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h
> b/arch/arm64/include/asm/mmu_context.h
> index c768d16b81a4..bd19f4c758b7 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -72,11 +72,11 @@ static inline void __cpu_set_tcr_t0sz(unsigned long
> t0sz)  {
>  	unsigned long tcr = read_sysreg(tcr_el1);
> 
> -	if ((tcr & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET == t0sz)
> +	if ((tcr & TCR_T0SZ_MASK) == t0sz)
>  		return;
> 
>  	tcr &= ~TCR_T0SZ_MASK;
> -	tcr |= t0sz << TCR_T0SZ_OFFSET;
> +	tcr |= t0sz;
>  	write_sysreg(tcr, tcr_el1);
>  	isb();
>  }
> --
> 2.34.1



