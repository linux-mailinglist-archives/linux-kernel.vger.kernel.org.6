Return-Path: <linux-kernel+bounces-341586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2210A988212
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670F9B22F44
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79771BB6A2;
	Fri, 27 Sep 2024 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bBp2E6OH"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A61BB686
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431153; cv=none; b=G3cEEgaZz3FI220thFmukliUvss0PTgyqdswIUqxdFCyl4GmVi4xT7GVu0ahP+4/6RzLgWO8WDAnagXG7C0SifTAHZAtFchfEtvFfPsSye1dE+lSCkNyJuo9kY0qv3pPYArvg/rDzIbZ/9fme/1b+C+h6nOpKDnBR9puEqurQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431153; c=relaxed/simple;
	bh=2flsGpB1c9ksM0YD7oL8sidu+g6UnIcj0j5F137b1LY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=icdnrT5HYs9rCaj6B7YeQ0qYlaBjYMXg2Ly2FvMQXQkAgywXve2/o2kwgv2quas0QZ8WkfMT7Sd31M9N3C8wpDUya/dVhu1of3VL5wvzjrl3bg+i++pg7yI3ewLwSKNvPuQr18AasVdQkDmtBqUkukDwkEhh2pR+S87v2FxOROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bBp2E6OH; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240927095908euoutp01d7195f062cbf860c76fb7e5d3f3eb49c~5EXobtn_B1911319113euoutp01F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:59:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240927095908euoutp01d7195f062cbf860c76fb7e5d3f3eb49c~5EXobtn_B1911319113euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727431148;
	bh=j7PzyRcbV//YpQacJQIeRez+0I/Vcd+wMl5eZe9x8S0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bBp2E6OHBKqz1mrq4nyWLARyKuYvBFgRiwIV9xKJJlF/M1ZOUcNMS5PQgJWB0Q+eK
	 3RP8CySIac5H2Sm1mpxWHI17Q+GfYiXYd9/fu5yPsK6leMFmvTzydyKDKho6JDxBmz
	 B4yrfXHzCpK2hF5ao6HPb+XZpbgGBQQCpVk3ujeQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240927095907eucas1p1f7eb7595a0e1cae436aa6474804bda4a~5EXn18_Jt2385023850eucas1p1U;
	Fri, 27 Sep 2024 09:59:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 83.23.09624.BE186F66; Fri, 27
	Sep 2024 10:59:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240927095907eucas1p1e2d5b2b17548f6998435fd5b02724439~5EXnVoCK32613326133eucas1p1F;
	Fri, 27 Sep 2024 09:59:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240927095907eusmtrp227bc16714369bc915d064a998234be5f~5EXnUzRwm0584705847eusmtrp2F;
	Fri, 27 Sep 2024 09:59:07 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-79-66f681eb4e8a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id DF.49.19096.AE186F66; Fri, 27
	Sep 2024 10:59:06 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240927095906eusmtip1d4f85eac2a19b366f79e8ef0c61978e6~5EXmlsglA1880218802eusmtip1e;
	Fri, 27 Sep 2024 09:59:06 +0000 (GMT)
Message-ID: <53a614cd-6dff-40fe-a715-690d37e50f68@samsung.com>
Date: Fri, 27 Sep 2024 11:59:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/3] Introduce support for T-head TH1520 Mailbox
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20240927094207.1650085-1-m.wilczynski@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djPc7qvG7+lGTyYomCx9fcsdos1e88x
	Wcw/co7V4t6lLUwWL/Y2slhcWzGX3eLlrHtsFpd3zWGz2Pa5hc1i7ZG7QLHLPcwWbbP4Lf7v
	2cFu0bJ/CosDn8ebly9ZPA53fGH32DnrLrvHplWdbB6bl9R7tKw9xuTxft9VNo++LasYPS41
	X2f3+LxJLoArissmJTUnsyy1SN8ugSvj8Wy/gt8CFc/3T2RpYFzK28XIySEhYCIx98xN5i5G
	Lg4hgRWMEo+ftrNDOF8YJa60HWCEcD4zSizqOc7SxcgB1jJ9JwdEfDmjxL3Xd1ghnLeMEu1H
	IYp4Bewk1l4zBFnBIqAqcfziUxYQm1dAUOLkzCdgtqiAvMT9WzPYQWxhAW+JT/232EDmiAi8
	Y5SYdO02E0iCWSBe4vGUC1C2uMStJ/PBbDYBI4kHy+ezgticAg4Sn5e+YYWokZfY/nYOM8Rv
	2zkl1nWlQNguEh/272aEsIUlXh3fwg5hy0j83wkxU0IgX+LB1k9QvTUSO3uOQ9nWEnfO/WID
	+YtZQFNi/S59SDg4Sty6YwFh8knceCsIcQCfxKRt05khwrwSHW1CEDPUJKb29MLtPLdiG9ME
	RqVZSGEyC8mLs5C8Mgth7QJGllWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiB6e70v+Of
	djDOffVR7xAjEwfjIUYJDmYlEV6rc1/ThHhTEiurUovy44tKc1KLDzFKc7AoifOqpsinCgmk
	J5akZqemFqQWwWSZODilGpgWdkfVNlSIst1g21z3rH+i7eUbIZuX7Lb9wXJ5R+65x8vEz9Tf
	d2yX91lSLfru0wr1ycwCvOt+O7pIlv32kjXcNefnxEVr7yunWyXdiVBzPrH30HIvzUluASsl
	BKcJsMYoOQY0ztUxruXPlFK589XJeJ/9iZSqx4lve3NuGS6669bFK558+60a75wII0v1zeLf
	QxwDfm0y3tEz+Wbnpo/JKU93mcnduZb5aROLXXKrilrzDT/VBY1xqhtl/y75XqRyc6q605n1
	cabVov62+9Qf7Ft2RjHETuLxydnxc2c5CkxWSettEPI8o9KnExXx2zzntp3SHI90b95NqhL7
	5rqYK6Yums/3MC+v7LKgrRJLcUaioRZzUXEiAIw3eB/mAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xu7qvGr+lGfzYbmmx9fcsdos1e88x
	Wcw/co7V4t6lLUwWL/Y2slhcWzGX3eLlrHtsFpd3zWGz2Pa5hc1i7ZG7QLHLPcwWbbP4Lf7v
	2cFu0bJ/CosDn8ebly9ZPA53fGH32DnrLrvHplWdbB6bl9R7tKw9xuTxft9VNo++LasYPS41
	X2f3+LxJLoArSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1
	SN8uQS/j8Wy/gt8CFc/3T2RpYFzK28XIwSEhYCIxfSdHFyMXh5DAUkaJRZuXMXYxcgLFZSSu
	db9kgbCFJf5c62KDKHrNKPHr53EmkGZeATuJtdcMQWpYBFQljl98ClbPKyAocXLmEzBbVEBe
	4v6tGewgtrCAt8Sn/ltgc0QE3jFKHFk+jxFkDrNAvMSGm8oQ8yczSvze2wZ2BLOAuMStJ/OZ
	QGw2ASOJB8vns4LYnAIOEp+XvmGF6FWXWD9PCKJcXmL72znMExiFZiE5YxaSSbMQOmYh6VjA
	yLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMMK3Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuG1
	Ovc1TYg3JbGyKrUoP76oNCe1+BCjKTAoJjJLiSbnA1NMXkm8oZmBqaGJmaWBqaWZsZI4L9uV
	82lCAumJJanZqakFqUUwfUwcnFINTHPMzFcU+/PZ6e2IFbslki3Y8ye2sOBB+1+tHZmsczXt
	bin4VTZ9U2t8zVlilfJeavW8/ob/74LM2LbGP+/fZXTMZXnVgYRNzV9PbVl0UHf7N9bfy7/b
	Lp1h/+GJ8qLlSU2VK2/pSr5ofX/yt6zZ2aUWjRcNCp+tChV7rXP08pQjUY37lnD+2fL/1M0T
	nZWpq4TaGmb1s/svdbA8PeWG3Hr/w3fr25f9f1H3WNCr7lbtx4Nv4p7tU918YuP9jyHfcv+s
	uCwatv5o8IszKde5Tqn9nTnvttUs15lvuCKcOxWeeum11t2f7j3DXs3C+tyeNpu0HcK7tO1r
	rD68MnjC7rht71vxez/Kljh4JxhW5pxXYinOSDTUYi4qTgQAfPhgLHkDAAA=
X-CMS-MailID: 20240927095907eucas1p1e2d5b2b17548f6998435fd5b02724439
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240927094213eucas1p22449c12701e67bc29371a6a6cb6f72a2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240927094213eucas1p22449c12701e67bc29371a6a6cb6f72a2
References: <CGME20240927094213eucas1p22449c12701e67bc29371a6a6cb6f72a2@eucas1p2.samsung.com>
	<20240927094207.1650085-1-m.wilczynski@samsung.com>



On 9/27/24 11:42, Michal Wilczynski wrote:
> The T-head TH1520 SoC supports a hardware mailbox that enables two cores
> within the SoC to communicate and coordinate [1]. One example of such
> coordination would be cooperation with the T-Head E902 core, which is
> responsible for power, clock, and resource management. For example, in
> the specific case of the BXM-4-64 GPU, it needs to be powered on by the
> E902 core, and the kernel running on the E910 needs to 'ask' the
> firmware running on the E902 core to enable power to the GPU island.
> Given recent advancements in work on the upstream GPU driver [2], there
> is an emerging need to get this code in the mainline kernel.
> 
> Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]
> Link: https://gitlab.freedesktop.org/imagination/linux-firmware/-/issues/1 [2]
> 
> Michal Wilczynski (3):
>   mailbox: Introduce support for T-head TH1520 Mailbox driver
>   dt-bindings: mailbox: Add thead,th1520-mailbox bindings
>   riscv: dts: thead: Add mailbox node

Just realized that I haven't included a summary of changes for v2.
Here it is:

v2:
 - fixed thead,th1520-mbox.yaml binding file by dropping redundant
   descriptions, renaming reg-names, removing unnecessary clocks,
   providing constraints and defining ICU's
 - fixed the mailbox driver code to work well with updated binding-file,
   removed clocks support, as it's not necessary for mailbox to work
 - adjusted the device tree node instance of mbox_910t so it will work
   with updated bindings file

> 
>  .../bindings/mailbox/thead,th1520-mbox.yaml   |  84 +++
>  MAINTAINERS                                   |   2 +
>  arch/riscv/boot/dts/thead/th1520.dtsi         |  13 +
>  drivers/mailbox/Kconfig                       |  10 +
>  drivers/mailbox/Makefile                      |   2 +
>  drivers/mailbox/mailbox-th1520.c              | 551 ++++++++++++++++++
>  6 files changed, 662 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
>  create mode 100644 drivers/mailbox/mailbox-th1520.c
> 

