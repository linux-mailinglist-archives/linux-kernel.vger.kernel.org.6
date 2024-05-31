Return-Path: <linux-kernel+bounces-196465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2208D5CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16201C22378
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C9877F2F;
	Fri, 31 May 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FxKtYmfX"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7B33993
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143708; cv=none; b=mK9szKIEdZoa84DYKlQ7oMeNSZ9tLNxC0agSTj5Am+BW5IqJ4CGpga2jJJ1qAMk9dxKgkWRQEuFFpE3Xm3bDzJqfDBFboZ2VAAHuRBIn9VgzW6YyS/zPEbrvHJKw/tJWWvG11/FwB1vyE7MIHf+Vw2Zz00z3BSvzcnnCQg96TBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143708; c=relaxed/simple;
	bh=bpqGeOddtdjhGO6r7EA7mdJzQe8YO1GbgCe5Z+mZDys=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=kI7+O6nP3RUnlvK5DNHzGmlfKmKkVGf7Qem4dhGrajsO9yInTmO3S+BSHJa/wPsQiU79qRl4QOXR7FlV99oQP7R5LPZWp5SgJ0Egd58AgZ/8XaS0gnfWrWumtxCsUFTlECJZWDdHPPuXcW/vUK/qdUuzYcFjB0hexy2NCRXYqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FxKtYmfX; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240531082142epoutp043d71865adcab05246ce22ee8b52a28ec~UhRmTC18w0718007180epoutp04j
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:21:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240531082142epoutp043d71865adcab05246ce22ee8b52a28ec~UhRmTC18w0718007180epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717143702;
	bh=47bo/92egWa4/j2Xm7QdIt7CeR6gaQYr+wJHwvffe08=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=FxKtYmfXlad6Y0PpIQSLfr0fYYqA43BRFQwa6RAwJ+L2Y4dC8ffXLOFHTipyqNVbG
	 0ubicqOStici2kttfzjqdABmXWkkhLab/6zNoTh2GvJklLQhX7IDRhDm9WdGZzPRp5
	 m30QE9DTSQ9TPooJzLBxnWxAhEop8ePTrmDNeBXw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240531082142epcas1p256cd9b57421a3dc4c6b70d73a975265b~UhRl0XYw-3266032660epcas1p2d;
	Fri, 31 May 2024 08:21:42 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.243]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VrGLF69Vdz4x9Q1; Fri, 31 May
	2024 08:21:41 +0000 (GMT)
X-AuditID: b6c32a36-86dfa70000002677-98-665988951f92
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FA.16.09847.59889566; Fri, 31 May 2024 17:21:41 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: (2) (2) [RESEND PATCH 00/10] memblock: introduce memsize
 showing reserved memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, Jaewon Kim
	<jaewon31.kim@samsung.com>
CC: Jaewon Kim <jaewon31.kim@gmail.com>, Mike Rapoport <rppt@kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tkjos@google.com" <tkjos@google.com>, Pintu Agarwal <pintu.ping@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240531010551.hs67amz34mljyifw@master>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240531082141epcms1p49d8d2048e04e90eca45644723614faa8@epcms1p4>
Date: Fri, 31 May 2024 17:21:41 +0900
X-CMS-MailID: 20240531082141epcms1p49d8d2048e04e90eca45644723614faa8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmge7Ujsg0g2/zjSzmrF/DZvHykKZF
	9+aZjBa9718xWVzeNYfN4t6a/6wW119OY7G40/eKxeLI+u1MFu8nF1vMbuxjdOD22DnrLrvH
	gk2lHptWdbJ5bPo0id3jxIzfLB59W1YxepxZcITd4/MmuQCOqGybjNTElNQihdS85PyUzLx0
	WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAzlRTKEnNKgUIBicXFSvp2NkX5pSWp
	Chn5xSW2SqkFKTkFZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGa/mzmcvmCtdcfv6XqYGxkVi
	XYycHBICJhLf1y1lArGFBHYwShzekt/FyMHBKyAo8XeHMEhYWCBeom9uKyNEiZLE2R9X2CHi
	uhJN3atZQGw2AW2J9wsmsYLYIgIpEq2LDgPVcHEwCzxmkli2fi0zxC5eiRntT1kgbGmJ7cu3
	gg3lFDCV2HXxBVSNqMTN1W/ZYez3x+YzQtgiEq33zkLVCEo8+LmbEWbOn+PP2SDsYollnQ+Y
	IOwaiRXnVkHFzSUa3q5kg/jLV2LSpnqQMIuAqsSNLV+hznGR+HB7D9haZgF5ie1v5zCDlDML
	aEqs36UPEeaTePe1hxXmk4aNv9mxsXfMewJ1gZpEy7OvUPUyEn//PYOyPSTuXtvNMoFRcRYi
	oGchWTwLYfECRuZVjGKpBcW56anFhgVG8KhNzs/dxAhOr1pmOxgnvf2gd4iRiYPxEKMEB7OS
	CO+v9Ig0Id6UxMqq1KL8+KLSnNTiQ4ymQC9PZJYSTc4HJvi8knhDE0sDEzMjEwtjS2MzJXHe
	M1fKUoUE0hNLUrNTUwtSi2D6mDg4pRqYWLUbp69ccCiW23WNcybbYTnLiPsHy2ZkzJh7vdR9
	3km5y18z+U6vWZ3gWHj6/ptnzy9aVcgzKnyeMGeN25Nsl/SFPCrJmgGmd0S1TjrmfpJcON9F
	O2dbPpcCo0S/sW7fm4mTd/FsftUY7G/HcM9zhf8EnW2bb21hZ+/V8tF++ynt8a+s0xcu+35c
	cOm7/pFXKtxLg9J8I3+4Sx6IEOF9XyTD3X/8Wv732/JPNnAqM3fNv9G8vUxMrq7+oeLjwzlr
	X+z5c+bJra5PRYwTplcaZGytnn9i436v3Ta/e4vNdN9Y79fY/qhhQoUQwxff4wH/w28WPZlV
	KNH5tb9CLljSJl4wcNE6w6z+lJ2HWy5NUmIpzkg01GIuKk4EAL8e/gc4BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76
References: <20240531010551.hs67amz34mljyifw@master>
	<20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
	<20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
	<20240524090715epcms1p274939a1d5954be3423f6ce14a3df6f92@epcms1p2>
	<20240527013504epcms1p22bec7b83f2a42e76877b97ed0d769009@epcms1p2>
	<20240529095119epcms1p73f0e9ff756bcb2ee6a14db459128a644@epcms1p7>
	<20240529113519.jupuazcf754zjxzy@master>
	<CAJrd-UuiDq-o=r7tK=CG6Q3yeARQBEAtaov2yqO6e6tBwJZoqQ@mail.gmail.com>
	<20240530104928epcms1p8108ece61c39c6e3d0361d445c15352d1@epcms1p8>
	<CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p4>

>On Thu, May 30, 2024 at 07:49:28PM +0900, Jaewon Kim wrote:
>>>On Wed, May 29, 2024 at 10:10:29PM +0900, Jaewon Kim wrote:
>>>>(Sorry I might forget to change to be plain text)
>>>>
>>>>Oh good thing, I did not know this patch. Thanks.
>>>>
>>>>By the way, I've tried to get memblock/memory and kernel log from a
>>>>device based on
>>>>v6.6.17 kernel device, to see upstream patches above.
>>>>memblok/memory does not show region for
>>>
>>>memblock/memory only shows ranges put in "memory".
>>>memblock/reserved shows ranges put in "reserved".
>>>
>>>If we just put them in "reserved", it will not displayed in "memory".
>>
>>Hi
>>Let me explain more.
>>
>>In this case, the intially passed memory starts from 0000000081960000 so memblock/memory shows as it is.
>>
>># xxd -g 8 /proc/device-tree/memory/reg
>>00000000: 0000000081960000 00000000000a0000  ................
>>00000010: 0000000081a40000 00000000001c0000  ................
>>
>># cat sys/kernel/debug/memblock/memory
>>   0: 0x0000000081960000..0x00000000819fffff    0 NONE
>>   1: 0x0000000081a40000..0x0000000081bfffff    0 NONE
>>
>># cat sys/kernel/debug/memblock/reserved
>>   0: 0x0000000082800000..0x00000000847fffff    0 NONE
>>
>>The memblock information in the kernel log may report like it allocated those memblock regions, as there was not overlapped even though it is already no-map.
>>
>>(I removed the name.)
>><6>[    0.000000][    T0] OF: reserved mem: 0x0000000080000000..0x0000000080dfffff (14336 KiB) nomap non-reusable AAA
>><6>[    0.000000][    T0] OF: reserved mem: 0x0000000080e00000..0x00000000811fffff (4096 KiB) nomap non-reusable BBB
>><6>[    0.000000][    T0] OF: reserved mem: 0x0000000081200000..0x00000000813fffff (2048 KiB) nomap non-reusable CCC
>><6>[    0.000000][    T0] OF: reserved mem: 0x0000000081a00000..0x0000000081a3ffff (256 KiB) nomap non-reusable DDD
>>
>
>This looks not printed by memblock_reserve(), right? It is printed by your own
>driver?

AFAIK these log came from the commit below.
aeb9267eb6b1 of: reserved-mem: print out reserved-mem details during boot

>
>>So a smart parser should combine the krenel log and the memblock/memory log.
>>
>>In my memsize feature shows it like this though.
>>
>>0x0000000081400000-0x0000000081960000 0x00560000 (    5504 KB ) nomap unusable unknown
>>
>>BR
>>
>
>I am sorry, I still not catch your point. Let me try to understand your message.
>
>You mentioned several regions, let me put them in order.
>
>(1)   0x0000000080000000..0x0000000080dfffff    printed by driver
>(2)   0x0000000080e00000..0x00000000811fffff    printed by driver
>(3)   0x0000000081200000..0x00000000813fffff    printed by driver
>(4)   0x0000000081400000..0x0000000081960000    expected to print in new debugfs
>(5)   0x0000000081960000..0x00000000819fffff    listed in reg/memory
>(6)   0x0000000081a00000..0x0000000081a3ffff    printed by driver
>(7)   0x0000000081a40000..0x0000000081bfffff    listed in reg/memory
>(8)   0x0000000082800000..0x00000000847fffff    listed in reserved
>
>If you just want information for region (4), sound we can do it in user-space?
>
>BTW, are region 1, 2, 3, 6, reserved in membock?

Yes correct, I though (4) case could be shown to easily catch these hidden regions.
As I said, I think 1, 2, 3, 6 seem to be not passed to kernel, it was just tried as
they are defined in kernel device tree.


>
>-- 
>Wei Yang
>Help you, Help me

