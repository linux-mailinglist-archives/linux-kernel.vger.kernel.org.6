Return-Path: <linux-kernel+bounces-449314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D83B9F4D13
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEB6188C2AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225E41F63C5;
	Tue, 17 Dec 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Mm6dmctm"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B81F4E55
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444281; cv=none; b=ZKmIQMs2hiKROFnHZXuiNn1YnMcWUXDklwwiPrNL5YiLjdhlLMo4oSVHwWWZ+RyEloP9scEcyh6Y0nrBZKIds3QqeLjIya4CVbQ9elOLbJbi6A3d5c71a+gDqWpkk7/AdzMN0yJjzOg3kslP2cn9OKFD9kFG/Cjllhnb/3TxQag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444281; c=relaxed/simple;
	bh=772NXZ5rFnxrXIgrpPElMq1FwGcldyl9jwxeTapTDZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=g7ZD4dPNaKwwbIvrJP2tfNNd7IumhsfXSRKXBAB7ipfZnYed25fVBaRvgATRrZgVbMD1h5mRpnKyCG5opNJTGsrWzuncDveKhTtHmcv8fNIFOu44tfxoaScuvY2x3u7iVSjn2Si9DhlScE9E31teZrl4ZZl8evZkME1HpwL9Wic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Mm6dmctm; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241217140430euoutp01ad13da3d74d249783aec7365a1be2904~R_9-sxggB0360103601euoutp01y
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:04:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241217140430euoutp01ad13da3d74d249783aec7365a1be2904~R_9-sxggB0360103601euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734444270;
	bh=KMyUAlqwEJYNzikgeT8+zVNkBY5F3mcA6IWbOkzduSo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Mm6dmctmiSHsvvWOwOMtVUxEWBCc/HEPyuD7bBNoszc5KMaJQMCwwHtLI1eKxilfN
	 7S597k9YSjJ1y/hUbeAXVyrW38aFs1yQ1sq8O3AE52eJ/QR/6m4rBWPOe6h5OnxCUQ
	 qsTkhf6twoPaVpqe6QHyroZHliwolmWM2Bxko2wA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241217140429eucas1p12ab179254fb34f6063f244e730341e16~R_9-AstK70900109001eucas1p18;
	Tue, 17 Dec 2024 14:04:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id FE.75.20409.DE481676; Tue, 17
	Dec 2024 14:04:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241217140429eucas1p2259f8da7425cf9d617bced29ae29c828~R_9_hDffx0264202642eucas1p2U;
	Tue, 17 Dec 2024 14:04:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241217140429eusmtrp2417a905469b3246cf3c07377c5ad0bc3~R_9_gR2OC0649406494eusmtrp2Q;
	Tue, 17 Dec 2024 14:04:29 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-2e-676184edb559
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 7A.79.19654.DE481676; Tue, 17
	Dec 2024 14:04:29 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241217140428eusmtip210e3637c3bf3e5e0c3ab5759dfe71186~R_99o_wE91910219102eusmtip2m;
	Tue, 17 Dec 2024 14:04:28 +0000 (GMT)
Message-ID: <f15de5f4-10ab-4ebc-9b71-d81f0ca965c3@samsung.com>
Date: Tue, 17 Dec 2024 15:04:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] riscv: dts: thead: Add mailbox node
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com, samuel.holland@sifive.com,
	emil.renner.berthing@canonical.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <Z1u2vsoCmmcNm82V@x1>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwTdxjH87u73l27FY8C8qybI+mCiaKgqOESCS/LNg4NDpVlyeiijdzK
	O9qCOkNcnRVbBUec6HabsEQnhULIalvANxw4G4KrrECBZiAzxgiDNaywDTE4yunGf5/n+7w/
	eWhc8Y9ESecVl/K6Yk2hipQRzrtz7vVTRo12wy8/bGEd8wLFOn68KGGbbroxtu6OW8LevlHK
	jnrsGOsxWxD75OYxgvVaLlLsuDBKsn3XviVZZ8BIss13Rha1vkqcrRBWsM9vtFGs1d1PsMaO
	c0SKghMMVSQ3OT5OcF2mGYprF0YoztZoJrmrlz/jjM13Mc5/a4DkztgbEec5PkhxF0yPKS5g
	e5MLjLRIMuUfyRJz+MK8g7wuLmmvLNfYN03tv6I8bDnWghtQ9cpTiKaB2QwtJ+EUktEKxoLA
	UTuCicYMgrHeBkI0AggM96fQywyjnRX1egQ2s1MiGlMIhusXFjOktJxJAp9pHg8ywUSD67aZ
	EvVQ6P760VJMBBMFD3xfLelhTDJ875sngxzOxEB7z6WlzjjTjEOPx4yCDpyJBN+jOizIJBMP
	Y/V1kiBLGRV0ecRC+GLR445v8GAyMBNSOOG7tzQFMO+A3VshETkMJlx2SuQ34Hm7WBSYEhhz
	/PkivhzaK10veCv86n5KBtfHmTXQci1OlFNhYW5IIl4lBIamQsURQuCs8wIuynIwVSjE6NVQ
	U1n1X1O3xYlVI5Ww7CrCsiWFZcsI//f9DhGNKJIv0xdpeX18MX8oVq8p0pcVa2P3lRTZ0OJz
	9iy4ZtpQ/cR0bCfCaNSJgMZV4fL31mi0CnmO5tMjvK5kj66skNd3otdpQhUpj86J4hWMVlPK
	F/D8fl730ovRUqUBi4+JUOMPX3GPf2FLT9xZ/tR6eO1wYF0DTH6+EXG7t5Fdvaezeoc3S6m4
	5LZbVsqXcNa7pXfWZM2YjDxyfc6Rr9yx6ServCMqJXzT1fi/39oh7dhXUKNWdx5yZdVuJ1qz
	Vnlf+yulwK+uEcwauyLvevSgoTE73Ny0Tm3oTl/5bkxTxvn8rYrk4YShxBMKot8Z4lqV1BrT
	kPr2fFrr0fJ7sldXPPtk17kPTv9hmU6bLd1OZf/8+3myJjNj8NLOZx2rz8CVhYO/lYfWbvs4
	t9J/YCL7/sMD7/szS9K9o+tTH/fnmzaEjoVVK5PSPkyw755+MDvgrhodMBzt8ucETj6p6o74
	Uqci9LmajWtxnV7zL5yEjPcLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42I5/e/4Pd23LYnpBrfOCFls/T2L3WLrwbms
	Fmv2nmOymH/kHKvFgT0lFvcubWGyuNS5gtHixd5GFotrK+ayW7ycdY/N4vKuOWwW2z63sFms
	PXIXKHa5h9mibRa/xf89O9gtVp+7wmLRsn8Ki4OQx6yGXjaPNy9fsngc7vjC7rFz1l12j02r
	Otk8Ni+p92hZe4zJ4/2+q2wefVtWMXpcar7O7jG94xm7x+dNch6f765nDeCN0rMpyi8tSVXI
	yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MtoufyRvWCZVMWKxvXM
	DYwTxLoYOTgkBEwkWrZYdDFycQgJLGWUaHp3gbmLkRMoLiNxrfslC4QtLPHnWhcbRNFrRok5
	37sZQRK8AnYStzp+gzWwCKhKHD/QyQ4RF5Q4OfMJWLOogLzE/VszwOLCAvYSS2/9ZgOxRQS0
	JXaeXswCMpRZYC2zxLu2l4wQG3qZJLpubQLrYBYQl7j1ZD4TiM0mYCTxYPl8VhCbU0BJ4vAl
	kKkcQDXqEuvnCUGUy0s0b53NPIFRaBaSO2YhmTQLoWMWko4FjCyrGEVSS4tz03OLjfSKE3OL
	S/PS9ZLzczcxAlPFtmM/t+xgXPnqo94hRiYOxkOMEhzMSiK8bpqJ6UK8KYmVValF+fFFpTmp
	xYcYTYFhMZFZSjQ5H5is8kriDc0MTA1NzCwNTC3NjJXEedmunE8TEkhPLEnNTk0tSC2C6WPi
	4JRqYLLt+NevvGLanCJHuWgfrVkMZ48zR996PsU+s8Izj/Xh39A55qL2jsceT/L5fvxi9Rrl
	hUKTOL6LLj7McSP6/BFD7saTl45Ob+SeJDVjs9eu2f+rvi+Y4FJpd/JtsRVbmH44Z6OJ5c1J
	ZsW7BMV8gpYtXDMpOFZqq9bCB4rrd7Fs/3+yUWO15MJDBm4ZaqqW///s/Wi5+mtpd4h9mmn0
	7S0sj8+vaJ5SOvf39+3GvFwbFBb23LNlaOk9NsH/3cKNXizFWzqDYxZcz1r6PEhguZ3x24bT
	CYX5n/zyd7e9qpPQLtQXWiQvJX1v2fflb6REVbKUHvDuTliUtEh4jurki/VLr9ctzkm9NDP3
	NfNcpcdKLMUZiYZazEXFiQCCdfdRngMAAA==
X-CMS-MailID: 20241217140429eucas1p2259f8da7425cf9d617bced29ae29c828
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241104100801eucas1p27cd0d7b9b5b4500604470664884c42fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241104100801eucas1p27cd0d7b9b5b4500604470664884c42fb
References: <20241104100734.1276116-1-m.wilczynski@samsung.com>
	<CGME20241104100801eucas1p27cd0d7b9b5b4500604470664884c42fb@eucas1p2.samsung.com>
	<20241104100734.1276116-4-m.wilczynski@samsung.com> <Z1oO5ewIOMFco4KI@x1>
	<Z1uiWXWo9szbgfx9@x1> <Z1u2vsoCmmcNm82V@x1>



On 12/13/24 05:23, Drew Fustini wrote:
> On Thu, Dec 12, 2024 at 06:56:25PM -0800, Drew Fustini wrote:
>> On Wed, Dec 11, 2024 at 02:15:01PM -0800, Drew Fustini wrote:
>>> On Mon, Nov 04, 2024 at 11:07:34AM +0100, Michal Wilczynski wrote:
>>>> Add mailbox device tree node. This work is based on the vendor kernel [1].
>>>>
>>>> Link: https://protect2.fireeye.com/v1/url?k=da478eb3-bbcc9b8a-da4605fc-000babffae10-a5d9fc4237b185e3&q=1&e=465c5302-3d9e-4713-b219-30181e5944c2&u=https%3A%2F%2Fgithub.com%2Frevyos%2Fthead-kernel.git [1]
>>>>
>>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>>> ---
>>>>  arch/riscv/boot/dts/thead/th1520.dtsi | 16 ++++++++++++++++
>>>>  1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
>>>> index 6992060e6a54..89de5634d3d3 100644
>>>> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
>>>> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
>>>> @@ -520,6 +520,22 @@ timer7: timer@ffffc3303c {
>>>>  			status = "disabled";
>>>>  		};
>>>>  
>>>> +		mbox_910t: mailbox@ffffc38000 {
>>>> +			compatible = "thead,th1520-mbox";
>>>> +			reg = <0xff 0xffc38000 0x0 0x6000>,
>>>> +			      <0xff 0xffc40000 0x0 0x6000>,
>>>> +			      <0xff 0xffc4c000 0x0 0x2000>,
>>>> +			      <0xff 0xffc54000 0x0 0x2000>;
>>>> +			reg-names = "local", "remote-icu0", "remote-icu1", "remote-icu2";
>>>> +			clocks = <&clk CLK_MBOX0>, <&clk CLK_MBOX1>, <&clk CLK_MBOX2>,
>>>> +				 <&clk CLK_MBOX3>;
>>>> +			clock-names = "clk-local", "clk-remote-icu0", "clk-remote-icu1",
>>>> +				      "clk-remote-icu2";
>>>> +			interrupt-parent = <&plic>;
>>>> +			interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
>>>> +			#mbox-cells = <1>;
>>>> +		};
>>>> +
>>>>  		ao_gpio0: gpio@fffff41000 {
>>>>  			compatible = "snps,dw-apb-gpio";
>>>>  			reg = <0xff 0xfff41000 0x0 0x1000>;
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>> Reviewed-by: Drew Fustini <dfustini@tenstorrent.com>
>>>
>>> dt_binding_check and dtbs_check are clean when I apply this patch to
>>> v6.13-rc1. There is trivial conflict due to the gpio node label having
>>> changed. I'll resolve it when I apply the patch to thead-dt-for-next.
>>
>> I've applied this patch to thead-dt-for-next [1].

Thanks for confirming. I’m currently preparing v2 of the series [2]. In
addition to the changes already discussed, I plan to broaden the scope
to include the power-domain user of the mailbox for completeness, so
I'll include this commit in my series as well. I’ll also ensure that
your Reviewed-by tag is included in the updated commit. Thanks again for
the review and your ongoing support.

[2] - https://lore.kernel.org/all/20241203134137.2114847-1-m.wilczynski@samsung.com/

Michał
>>
>> Thanks,
>> Drew
>>
>> [1] https://protect2.fireeye.com/v1/url?k=ded1044e-bf5a1177-ded08f01-000babffae10-a43021e0091864fc&q=1&e=465c5302-3d9e-4713-b219-30181e5944c2&u=https%3A%2F%2Fgithub.com%2Fpdp7%2Flinux%2Fcommit%2F98064af36cbc0c216d0a2d11da5e3746a57ccce7
> 
> I forgot my SoB so it is now a new hash [1].
> 
> -Drew
> 
> [1] https://protect2.fireeye.com/v1/url?k=21bcf54a-4037e073-21bd7e05-000babffae10-2408d35c4723ee6d&q=1&e=465c5302-3d9e-4713-b219-30181e5944c2&u=https%3A%2F%2Fgithub.com%2Fpdp7%2Flinux%2Fcommit%2Fc95c1362e5bcd90c45987828bbef02236d181ffd
> 

