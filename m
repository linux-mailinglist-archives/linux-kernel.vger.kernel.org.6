Return-Path: <linux-kernel+bounces-366483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71C599F5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A1328248B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545412036FA;
	Tue, 15 Oct 2024 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AevDnAo6"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6F82036F1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017853; cv=none; b=o6WXtmySS2aY6aKllfCk0lpMl9CxfPYJndUgqoO5bGgdgD4a5G6oF4K3Z5wGMz2zqRBTm3xnxZv6UOpfmrQZwCvwiAR4hZ5Rdhs0xdF3+1wnZNOGWwmXsgorDcddHLDPS/AyukM4EE9n8HZDbQCvz4YsrGrMDx6nz0T4SmhobdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017853; c=relaxed/simple;
	bh=w6OKnR0WlNxCnYdj8s6LQkJtAOoLnQJdnbXkyhcg9p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=WAOKocOdhe7QhQIP2h7GpT0296+kg/YMHZSO8iQjKYJ4+wIgqDETOaWidFrUq0WCscbQhyLP47OpyPawpdKgWp3TAtSins8FWZsBGzupf413n094yqXcu/9joZf/J0gHt3sfi9xkCQiB4A5iR/P23mFIsl45H0PiLBmV2Le20UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AevDnAo6; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241015184402euoutp01e01e304d0a450da577bedca086a5c206~_tJE7Ke781451714517euoutp01a
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:44:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241015184402euoutp01e01e304d0a450da577bedca086a5c206~_tJE7Ke781451714517euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729017842;
	bh=HuC5Q9IVnT9C9ZqpNbJeHd8wdpadVR4wwXRjo0qvcnM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=AevDnAo6B7wHZsA2xvIcI64Mm82mRWL2WInyQE0EPt1iZlGNSlwZj7Axw+sFD37a+
	 x5OE7uW4iQC2hBkQDu/15MbmVoJy+Rb8NoVrPHPGmUaEQjnsgTZKqZhYwqaspgSqwz
	 a+S4mbeHdhNcnnKaWcRvBPoRo1KerWN2fcWO8ubM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241015184402eucas1p25b7f6832596302aa419497c9e7c73915~_tJEkmmoB0374103741eucas1p2B;
	Tue, 15 Oct 2024 18:44:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 6A.1D.09875.2F7BE076; Tue, 15
	Oct 2024 19:44:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241015184401eucas1p2a9a19f6e99a7b47f20574fcef500313f~_tJD4YnTg1034210342eucas1p2R;
	Tue, 15 Oct 2024 18:44:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241015184401eusmtrp1ec0fd5726de5a734ef78a03bd4a68f38~_tJDpQbyS0484904849eusmtrp14;
	Tue, 15 Oct 2024 18:44:01 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-09-670eb7f276f2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 5F.54.14621.1F7BE076; Tue, 15
	Oct 2024 19:44:01 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241015184400eusmtip2cb3004d5575998c9688dbea89091a9ab~_tJC7Olvv0203102031eusmtip2i;
	Tue, 15 Oct 2024 18:44:00 +0000 (GMT)
Message-ID: <4825037e-08e6-4946-9aee-a19512fb2346@samsung.com>
Date: Tue, 15 Oct 2024 20:44:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] riscv: dts: thead: Add mailbox node
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	drew@pdp7.com, guoren@kernel.org, wefu@redhat.com, jassisinghbrar@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	m.szyprowski@samsung.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CAJM55Z-bzivMZWUsHiii+2tw2-kdRe7kqtVa+MvPEAVTmOvChg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djPc7qftvOlG0y8IWKx9fcsdos1e88x
	Wcw/co7V4t6lLUwWlzpXMFq82NvIYnFtxVx2i5ez7rFZXN41h81i2+cWNou1R+4CxS73MFu0
	zeK3+L9nB7tFy/4pLA78HrMaetk83rx8yeJxuOMLu8fOWXfZPTat6mTz2Lyk3qNl7TEmj/f7
	rrJ59G1Zxehxqfk6u8fnTXIB3FFcNimpOZllqUX6dglcGa+3XWcveClfsaWnla2BsV+qi5GT
	Q0LAROLegzvsXYxcHEICKxglDh64zgaSEBL4wiixbV0uROIzo0Tj2u9sMB03G3uhOpYzSsw4
	M40NwnnLKHHjUw8TSBWvgJ3El1N3wDpYBFQlLj16zQgRF5Q4OfMJC4gtKiAvcf/WDKBJHBzC
	AvYSG7sEQeaICKxmkth4tQlsDrNAvMTjKRegbHGJW0/mg9lsAkYSD5bPZwWxOQUCJWbO2wpV
	Iy/RvHU2M8ggCYH9nBKvp19ihjjbReLyzj+sELawxKvjW9ghbBmJ05N7WCDsfIkHWz9B1ddI
	7Ow5DmVbS9w594sN5FBmAU2J9bv0IcKOEtuXXgcLSwjwSdx4KwhxAp/EpG3TmSHCvBIdbUIQ
	1WoSU3t64ZaeW7GNaQKj0iykQJmF5MlZSJ6ZhbB3ASPLKkbx1NLi3PTUYqO81HK94sTc4tK8
	dL3k/NxNjMBEePrf8S87GJe/+qh3iJGJg/EQowQHs5II76Qu3nQh3pTEyqrUovz4otKc1OJD
	jNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkGJu78+xdd5LZrnbzDHfDux7IdXPNijz7I
	v7Z+od2Ep3y3F1/vT/zXU2mcKP5mlmD4pW3zpxvkbzQNrby6a9OcnGAr/r3rTR/Ui2wRmTFr
	qWpZ+Z+ks2vTXt5S8o165R/3pHh9R9Px/e6P5HkKbm+ZucJm5+a4u+1vW1L397rIf7uY/nPD
	tOQLH1etkLOVj+QNrrX/ZerqenLPEcucqye4JvyvdVHhkZR/+P3pD8Mnf7WPyLjy/mt4JdkZ
	+ZZX+sZjD8dLNr8Oum55xHhm6dJ4PdvjHzNYGlR+Guzy+RkUkvHUx6browp7a6Bp89ml6xvv
	FjP6+F54UvxJ8EiMZtm6nui4N13tmd38LcpnFk55eV2JpTgj0VCLuag4EQCpNp7n8wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xe7oft/OlG5w7KWax9fcsdos1e88x
	Wcw/co7V4t6lLUwWlzpXMFq82NvIYnFtxVx2i5ez7rFZXN41h81i2+cWNou1R+4CxS73MFu0
	zeK3+L9nB7tFy/4pLA78HrMaetk83rx8yeJxuOMLu8fOWXfZPTat6mTz2Lyk3qNl7TEmj/f7
	rrJ59G1Zxehxqfk6u8fnTXIB3FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkam
	Svp2NimpOZllqUX6dgl6Ga+3XWcveClfsaWnla2BsV+qi5GTQ0LAROJmYy97FyMXh5DAUkaJ
	pdc3M0MkZCSudb9kgbCFJf5c62KDKHrNKDG99xU7SIJXwE7iy6k7bCA2i4CqxKVHrxkh4oIS
	J2c+AWsWFZCXuH9rBlA9B4ewgL3Exi5BkLCIwGomiVOPIkHCzALxEhtuKkOMn8Akce3ZIlaQ
	GmYBcYlbT+YzgdhsAkYSD5bPB4tzCgRKzJy3lQmiV11i/TwhiHJ5ieats5knMArNQnLELCST
	ZiF0zELSsYCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg3G879nPzDsZ5rz7qHWJk4mA8
	xCjBwawkwjupizddiDclsbIqtSg/vqg0J7X4EKMpMCAmMkuJJucDE09eSbyhmYGpoYmZpYGp
	pZmxkjiv2+XzaUIC6YklqdmpqQWpRTB9TBycUg1MEk2Cm7m2OBT02pe+uHmI7bGCvVFI45KD
	taGWB/yCY6+6lv4wZ463nV4kXSHgclL/n+XL2dZ/H2X9+rterfC5qKedlydbvLnBfi6ezMpV
	TqdaZ5he/PfXer6x+jHfkusxG5+5/2t6sn8hdz8Tk9TOPUIzugva/3R/v9GzvvHRUtkPxfuf
	3sm+HXc2/AjffT/720z/j2xNFrr0+MKGedwthudsIhcZ/T825VMoU6dn0NFp3357t/zemuM4
	J/lt97wynS9pNpdPXfuuVf+l816UftPDy4kyx7y/3WOZcsJYQF5td3H7PU7ZvvUH0g7PrdLh
	X5ZhEHR9mliKWaxr61wWnSBHy2cyamcmCdXHqhopsRRnJBpqMRcVJwIAZ8em64QDAAA=
X-CMS-MailID: 20241015184401eucas1p2a9a19f6e99a7b47f20574fcef500313f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241014123412eucas1p2144768f373a2e2de7f6d00e7b67f9328
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241014123412eucas1p2144768f373a2e2de7f6d00e7b67f9328
References: <20241014123314.1231517-1-m.wilczynski@samsung.com>
	<CGME20241014123412eucas1p2144768f373a2e2de7f6d00e7b67f9328@eucas1p2.samsung.com>
	<20241014123314.1231517-4-m.wilczynski@samsung.com>
	<CAJM55Z-bzivMZWUsHiii+2tw2-kdRe7kqtVa+MvPEAVTmOvChg@mail.gmail.com>



On 10/14/24 16:57, Emil Renner Berthing wrote:
> Michal Wilczynski wrote:
>> Add mailbox device tree node. This work is based on the vendor kernel [1].
>>
>> Link: https://protect2.fireeye.com/v1/url?k=0bc95f25-545267d8-0bc8d46a-000babff317b-85a52eab21db9d22&q=1&e=63a49acd-e343-43d2-a57d-b4f6fcd23b61&u=https%3A%2F%2Fgithub.com%2Frevyos%2Fthead-kernel.git [1]
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  arch/riscv/boot/dts/thead/th1520.dtsi | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
>> index 6992060e6a54..435f0ab0174d 100644
>> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
>> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
>> @@ -555,5 +555,17 @@ portf: gpio-controller@0 {
>>  				interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
>>  			};
>>  		};
>> +
>> +		mbox_910t: mailbox@ffffc38000 {
> 
> Hi Michal,
> 
> Thanks for your patch! Please sort this by address similar to the other nodes.

Thank you for your review. Will do.

> 
>> +		       compatible = "thead,th1520-mbox";
>> +		       reg = <0xff 0xffc38000 0x0 0x4000>,
> 
> The documentation[1] calls this area MBOX0_T, but it says it's 24kB long.
> 
> [1]: https://protect2.fireeye.com/v1/url?k=182b68d6-47b0502b-182ae399-000babff317b-d2b05f97b85a09ff&q=1&e=63a49acd-e343-43d2-a57d-b4f6fcd23b61&u=https%3A%2F%2Fgit.beagleboard.org%2Fbeaglev-ahead%2Fbeaglev-ahead%2F-%2Fblob%2Fmain%2Fdocs%2FTH1520%2520System%2520User%2520Manual.pdf
> 
>> +			     <0xff 0xffc44000 0x0 0x1000>,
> 
> According to the documentation this is inside the 24kB MBOX1_T area.
> 
>> +			     <0xff 0xffc4c000 0x0 0x1000>,
> 
> This is callod MBOX2_T, but is 8kB long.
> 
>> +			     <0xff 0xffc54000 0x0 0x1000>;
> 
> This is callod MBOX3_T, but is 8kB long.
> 
>> +		       reg-names = "local", "remote-icu0", "remote-icu1", "remote-icu2";
> 
> Maybe these should match the MBOXn_T names in the documentation?

Indeed, those are excellent points. I wondered about this today, trying
to understand why the mapping was done this way.

For the MBOX0_T mapping, the mailbox driver needs to map the M0_*
registers, including the M0_Cn registers, where other cores write their
messages. This setup requires a total of 16KB, with an additional 8KB
that remains unused.

Regarding MBOX1_T, MBOX2_T, and MBOX3_T, only one set of registers is
necessary - specifically, Mn_C0 since the kernel always sends messages
from the 910t core with CPU_IDX=0.

The MBOX1_T mapping is particularly confusing, as the relevant
registers, M1_C0*, start with an offset of 0x4000 relative to the
beginning of the mapping.

For MBOX2_T and MBOX3_T, the necessary register sets, M2_C0 and M3_C0,
each occupy 4KB of address space, leaving extra 4kB unused.

I assume the hardware designers found these mappings more
straightforward to implement this way. I’m fairly confident that these
numbers are accurate, as I have tested them and confirmed they work.

> 
>> +		       interrupt-parent = <&plic>;
>> +		       interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
> 
> You should probably also add the clocks here:
> 
> 	clocks = <&clk CLK_MBOX0>,  .., <&clk CLK_MBOX3>;
> 
> ..and claim them in the driver. Otherwise the clock framework will consider
> them unused and turn them off without the clk_ignore_unesed kernel command
> line.

Thanks for the suggestion! I’ll re-test with the clocks added. I had
clk_ignore_unused enabled permanently in my U-Boot configuration, so I
might have overlooked this detail.

> 
> /Emil
> 
>> +		       #mbox-cells = <2>;
>> +		};
>>  	};
>>  };
>> --
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> https://protect2.fireeye.com/v1/url?k=cb1a1bba-94812347-cb1b90f5-000babff317b-3fe071fc8037390e&q=1&e=63a49acd-e343-43d2-a57d-b4f6fcd23b61&u=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-riscv
> 

