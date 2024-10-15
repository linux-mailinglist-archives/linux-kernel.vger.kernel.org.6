Return-Path: <linux-kernel+bounces-366810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8752899FACE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BB4281825
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA921E3AC;
	Tue, 15 Oct 2024 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dimTcLVV"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B11B0F08
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029792; cv=none; b=YqL0RF4TsFCpcDBmW2vRsGyQFFFGJa+cxCx3D5r/hCkHwEwsrUeFA1BRu0aGQHr7e92NRACTkK3nYvq+DX6W81UCAF4ExUt2NEk+Ns3cANwTE5ub6z5x+5/HXIo77iMNuGkCoR3yekLI7QihvgWmB0zvnJ4xg0WQ+BocwklRYWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029792; c=relaxed/simple;
	bh=7SDH3dfOyMI+Ahi9QC6+jpSbsPgxMwmwu8gefKAaWiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=U6jNSN8SMTKZkf+UGcQluIRColItdHqwfvfkDU2u44D8LKneoXBKYcNuz3EhwS743dd5cOITpjDHPSviwduexLhT3vNkgc4DMzd7Gd6UJkcALBA2k08WrIaaAbJnxkXdA/U5z0GkCiNwX5CCt/hM+VBuK8eAnDVd//0SpdbY+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dimTcLVV; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241015220308euoutp027b37ff8d30e992a3adcd1cbd3a4ed890~_v26K1h3U0884508845euoutp02s
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:03:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241015220308euoutp027b37ff8d30e992a3adcd1cbd3a4ed890~_v26K1h3U0884508845euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729029788;
	bh=berGr2Vz+quvHhU94cieaPOMw7ZLSoJJPu/DfSCrFwA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dimTcLVVYiwf1sGwqydPSfD2/KvfDQsDrVzHmHrKO1YX9sPYEMpeQQji3MAT0I99M
	 rWEJRzblQDDdL5KPHWi9aeiO62CBFD9iCjVRXmBTUwZUl2q4FSXS1c65gW2PBGQ72j
	 CEEx7V4zdy8y2VktdJAWsa3y+DLZOEiV4tqtbFUc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241015220307eucas1p2a2ee3bd214c61cd1582c6d207f03c2c4~_v25mgj8n2506925069eucas1p2o;
	Tue, 15 Oct 2024 22:03:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 31.B2.20409.B96EE076; Tue, 15
	Oct 2024 23:03:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241015220306eucas1p11669db132104dae39c26c62c142666a4~_v24wWv6P1111111111eucas1p11;
	Tue, 15 Oct 2024 22:03:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241015220306eusmtrp2c3be41633a0c7190151f52768bab8825~_v24vtWFK2618226182eusmtrp2i;
	Tue, 15 Oct 2024 22:03:06 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-ce-670ee69b05b6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B0.31.19654.A96EE076; Tue, 15
	Oct 2024 23:03:06 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241015220306eusmtip1d7286bf674401982c74a13516a1b7a70~_v23-srmZ0557905579eusmtip1h;
	Tue, 15 Oct 2024 22:03:06 +0000 (GMT)
Message-ID: <431e98cd-6c53-4478-86a6-e532be4ed58e@samsung.com>
Date: Wed, 16 Oct 2024 00:03:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Introduce support for T-head TH1520 Mailbox
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <Zw1jdl64f5l8N+Km@x1>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djP87qzn/GlG2x/qG+x9fcsdos1e88x
	Wcw/co7V4sCeEot7l7YwWbzY28hicW3FXHaLl7PusVlc3jWHzWLb5xY2i7VH7gLFLvcwW7TN
	4rf4v2cHu0XL/iksDvweb16+ZPE43PGF3WPnrLvsHptWdbJ5bF5S79Gy9hiTx/t9V9k8+ras
	YvS41Hyd3WN6xzN2j8+b5AK4o7hsUlJzMstSi/TtErgyzi95wlwwT7hiQ9sP1gbG7/xdjJwc
	EgImEic3H2DsYuTiEBJYwShxY/N5dgjnC6PE1XnNTBDOZ0aJ5xfussO0bGk5wwKRWM4osX/1
	O6j+t4wSmxedYOti5ODgFbCTuPlCGKSBRUBVYurt3cwgNq+AoMTJmU9YQGxRAXmJ+7dmgA0V
	FnCX+HXyEVhcREBbYufpxWALmAXOMkmsnbANrIhZQFzi1pP5TCA2m4CRxIPl81lBbE4BJYmn
	i9+xQdTISzRvnc0M0iwhcJhT4tf0vUwQZ7tIzNq3lRnCFpZ4dXwL1DsyEv93zoeqyZd4sPUT
	VE2NxM6e41C2tcSdc7/AHmMW0JRYv0sfIuwosWTGbCaQsIQAn8SNt4IQJ/BJTNo2nRkizCvR
	0SYEUa0mMbWnF27puRXbmCYwKs1CCpVZSJ6cheSZWQh7FzCyrGIUTy0tzk1PLTbKSy3XK07M
	LS7NS9dLzs/dxAhMhKf/Hf+yg3H5q496hxiZOBgPMUpwMCuJ8E7q4k0X4k1JrKxKLcqPLyrN
	SS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYNr6ZkmTwFGpfXKnmMQudbL8fLN0
	8o5g7Zf3NDcd3dLLPFH99zHtN98rve/OPSXkGyHzV2VFjGXtwvUfAnKU0x/Lm4sYzPz/uy/x
	z7a5pyu1LrZ8KHy9erXh2t/pGUkz79ltmPJDPitwb/lW73nJT496vamf5LunLLEte+fz7kuV
	j3N/fPtSssOHW++xp0iFRv0EifW31HNFpry3LNWZHf9o17TeFM3Wr07Zl6IdN2md8Nycf/5V
	ySrHCRMW7FgcucDiiJ1K76vFZzusS52Uk44yT7zJqHp3p82V2efN5sls3a7ssmlV1DLWqp3T
	Q00eFrMfCfi8//7di9eqLvZ3zNqh/497ibGJ4cTaC5JbH9ukKbEUZyQaajEXFScCAPxU71Lz
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xu7qznvGlGyztNbTY+nsWu8WaveeY
	LOYfOcdqcWBPicW9S1uYLF7sbWSxuLZiLrvFy1n32Cwu75rDZrHtcwubxdojd4Fil3uYLdpm
	8Vv837OD3aJl/xQWB36PNy9fsngc7vjC7rFz1l12j02rOtk8Ni+p92hZe4zJ4/2+q2wefVtW
	MXpcar7O7jG94xm7x+dNcgHcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK
	+nY2Kak5mWWpRfp2CXoZ55c8YS6YJ1yxoe0HawPjd/4uRk4OCQETiS0tZ1i6GLk4hASWMkr0
	X7rOApGQkbjW/RLKFpb4c62LDaLoNaPEsilP2bsYOTh4Bewkbr4QBqlhEVCVmHp7NzOIzSsg
	KHFy5hOwXlEBeYn7t2awg9jCAu4Sv04+AouLCGhL7Dy9GGwxs8BZJoltm99CXbGSUeL9l6+s
	IFXMAuISt57MZwKx2QSMJB4snw8W5xRQkni6+B0byBHMAuoS6+cJQZTLSzRvnc08gVFoFpI7
	ZiGZNAuhYxaSjgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECI3/bsZ9bdjCufPVR7xAj
	EwfjIUYJDmYlEd5JXbzpQrwpiZVVqUX58UWlOanFhxhNgWExkVlKNDkfmHrySuINzQxMDU3M
	LA1MLc2MlcR52a6cTxMSSE8sSc1OTS1ILYLpY+LglGpgSgx2uvdshQ2f7Z0dqnnJ89/rXnde
	JTHTq7lP22x+k3nKlLtrUn8yNnNo9cgIe/5xvjA5fd7W1Q1H17qVCafsVtqzTaRGWFlGW7hp
	44R6XcVPZYvsOb7PvbQrqk/a2djOdOfTAKEgNoOfK7kaD5zIbO99cGCnWOTC1LYJzMHHnB9/
	NLSxttwi7Bv5a7XgfQbmlUrznTTvC+QWmO08JZiw4F74SbWnGsWV/Je+nvTZdNiqLTWEJT1F
	sC7a/PU/I2sGlRT1vZ6rGE2+v1j0Mf/nuZwJWnbRfsd/aHz8vyTYPaax9deBbe16sX/8b75m
	05ZTOyY5+eVr0zdPCqcr7n9gdnhai3PiZXUhZuWi3zpKLMUZiYZazEXFiQAut+0LhQMAAA==
X-CMS-MailID: 20241015220306eucas1p11669db132104dae39c26c62c142666a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241014123409eucas1p2a3a3f085c0630073326ca299a870f3ee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241014123409eucas1p2a3a3f085c0630073326ca299a870f3ee
References: <CGME20241014123409eucas1p2a3a3f085c0630073326ca299a870f3ee@eucas1p2.samsung.com>
	<20241014123314.1231517-1-m.wilczynski@samsung.com> <Zw1jdl64f5l8N+Km@x1>



On 10/14/24 20:31, Drew Fustini wrote:
> On Mon, Oct 14, 2024 at 02:33:11PM +0200, Michal Wilczynski wrote:
>> The T-head TH1520 SoC supports a hardware mailbox that enables two cores
>> within the SoC to communicate and coordinate [1]. One example of such
>> coordination would be cooperation with the T-Head E902 core, which is
>> responsible for power, clock, and resource management. For example, in
>> the specific case of the BXM-4-64 GPU, it needs to be powered on by the
>> E902 core, and the kernel running on the E910 needs to 'ask' the
>> firmware running on the E902 core to enable power to the GPU island.
>> Given recent advancements in work on the upstream GPU driver [2], there
>> is an emerging need to get this code in the mainline kernel.
>>
>> Link: https://protect2.fireeye.com/v1/url?k=2021d256-7fbdfb7c-20205919-000babe598f7-ca654d1a9bc866ac&q=1&e=11e97355-e6e9-4aac-a996-cc475156b3c8&u=https%3A%2F%2Fopenbeagle.org%2Fbeaglev-ahead%2Fbeaglev-ahead%2F-%2Fblob%2Fmain%2Fdocs%2FTH1520%2520System%2520User%2520Manual.pdf [1]
>> Link: https://gitlab.freedesktop.org/imagination/linux-firmware/-/issues/1 [2]
>>
>> Thanks, Krzysztof and Rob, for your review! Since this series is gaining
>> some interest, I've dropped the RFC prefix with the v3 update.
> 
> I've applied this series and booted okay. I see the driver loaded:
> 
>  /sys/devices/platform/soc/ffffc38000.mailbox/driver points to
>  /sys/bus/platform/drivers/th1520-mbox
> 
> How do you test that the communication with the E902 is working
> correctly?

Thank you for your interest. To test this, I've prepared a diff that
includes the missing drivers utilizing the mailbox and enabled the GPU
node in the device tree to use the drm/imagination driver.

I've observed that when the power was turned off through the E902 core
using the mailbox, the drm/imagination driver would hang in
pvr_load_gpu_id() while attempting to read its BVNC from the register.
However, when the GPU was turned on via the mailbox, the BVNC could be
read correctly. Still, the firmware fails to boot due to some missing
programming in the drm/imagination driver, which is currently being
worked on. I've briefly explained this in the first commit of this
series.

If you'd like to try this yourself, I'd be happy to push these setups to
a GitHub repository and provide you with a link, so you can see the
setup in action.

Michał

> 
> Thanks,
> Drew
> 

