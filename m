Return-Path: <linux-kernel+bounces-198909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B628D7F00
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1B21F22DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D285920;
	Mon,  3 Jun 2024 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GJXHNQFy"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CC785659
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407196; cv=none; b=QXhZ5Is1TugcIXtTF0Wf8kY7AAanZozXUIp4YgdSZZloGzh4uigvE9I7BmF/l8wOWOmCSHEufMcItbachxjc7QZLdnKbxKEmLxc/sbY5atDShdq5BuEycqJbaEweaPsH8u5RNDV+nURvNwkhQ1GbuYgmEA7ulWsAya0wFGNvzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407196; c=relaxed/simple;
	bh=+bApHo/C7mVf5pvNhX4lVTb9hPhQcEeS2ESv644E/vQ=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=PD4XofYsx8poL3RTxXJF6CcPiGzWNgUAKuiJ4AHXeBXOmWxgTnzdyb0BuSm06XpvYt9k7dR+P6bOji3vowgMM9sf+r4x/u+qYEMNIDK4Yqq4FirdKe1ZruGKyMMW3bizXHkf52lCu+s5fZ1CRw7QqxLeOBNhWPP4Zu1U+13lzP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GJXHNQFy; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240603093311epoutp02cdffbd65f76d5d2a2732fa1c41df9c7e~VdL3kB5is0604306043epoutp02U
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:33:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240603093311epoutp02cdffbd65f76d5d2a2732fa1c41df9c7e~VdL3kB5is0604306043epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717407191;
	bh=nP+t4EIY6o5//ZwZPwCa4ZNSh3wzvVaaEWbfgsBy5qA=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=GJXHNQFyCHlZB5yy8LvE/wK2CJ53chHydlv4w+JEKuBkTURdcLbfWKWHMeGTvSBhq
	 ZujeHbVsr3zDmuXdeYjFFPcbdpCKdBrxXF+7StXJz4t/OfTqPrl1c/NGZLISAExrEh
	 wXSlIx4Ux9i89BJGqXQZH5F0TUt0YShPBJucHU+o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240603093311epcas1p1ac2d110fc8c801da19a85f31110fe080~VdL2zJhwM3008530085epcas1p1I;
	Mon,  3 Jun 2024 09:33:11 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.241]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Vt7nL48lSz4x9Q9; Mon,  3 Jun
	2024 09:33:10 +0000 (GMT)
X-AuditID: b6c32a38-ff1fa7000000287a-31-665d8dd6929a
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.2C.10362.6DD8D566; Mon,  3 Jun 2024 18:33:10 +0900 (KST)
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
In-Reply-To: <20240601014045.jkk3ydsu4zns2bfc@master>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240603093310epcms1p893f1ed36c0531917b69eb77e3ddfd794@epcms1p8>
Date: Mon, 03 Jun 2024 18:33:10 +0900
X-CMS-MailID: 20240603093310epcms1p893f1ed36c0531917b69eb77e3ddfd794
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmnu613tg0g7+75C3mrF/DZvHykKZF
	9+aZjBa9718xWVzeNYfN4t6a/6wW119OY7G40/eKxeLI+u1MFu8nF1vMbuxjdOD22DnrLrvH
	gk2lHptWdbJ5bPo0id3jxIzfLB59W1YxepxZcITd4/MmuQCOqGybjNTElNQihdS85PyUzLx0
	WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAzlRTKEnNKgUIBicXFSvp2NkX5pSWp
	Chn5xSW2SqkFKTkFZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGW/33WAteK9QcWq5cQPjX6ku
	Rk4OCQETiS0vJjJ1MXJxCAnsYJSYunoBkMPBwSsgKPF3hzBIjbBAvETf3FZGEFtIQEni7I8r
	7BBxXYmm7tUsIDabgLbE+wWTWEFsEYEUidZFh9lBZjILPGaSWLZ+LTPEMl6JGe1PWSBsaYnt
	y7eCDeUUMJWYMfcxE0RcVOLm6rfsMPb7Y/MZIWwRidZ7Z6HmCEo8+LkbKi4lsezrXKj6Yoll
	nQ+g5tRIrDi3ig3CNpdoeLsSzOYV8JWY92U6I8iPLAKqEj/mCEKUuEjcWPga7DRmAXmJ7W/n
	MIOUMAtoSqzfpQ8R5pN497WHFeaTho2/2bGxd8x7AnWBmkTLs69Q9TISf/89g7I9JO5e280y
	gVFxFiKgZyFZPAth8QJG5lWMYqkFxbnpqcWGBSbwqE3Oz93ECE6vWhY7GOe+/aB3iJGJg/EQ
	owQHs5IIb19ddJoQb0piZVVqUX58UWlOavEhRlOgjycyS4km5wMTfF5JvKGJpYGJmZGJhbGl
	sZmSOO+ZK2WpQgLpiSWp2ampBalFMH1MHJxSDUzMou1HNZ5H8Bv7Ll+WHcKkvlLx4HMlv3zm
	2RnP6u6f4pv4gP1kgA2L1bzdu8ON3RJi6g2WP+1oKmnJm/jgnt61u57Mtw+9UVQSCb96/P9t
	AWth/b6wzOOS9z/sYXEIdOpxFhC8NOnn3iVX50ysnKTzUPuhn/vmfU+r605K/dl3cNb65pOC
	T+P3pLG6sO0O5b69JjJOP7svbdKJ/lWSHw4sv2Zg8/R/xnRnzS/ajHoq55szZ62cf73x+skn
	ea03bv+VCzxzcFra/cvzT+Xd8In5qBqTWJ/ZwXW7+dvD21NmhOjOYG69PnHLm1XLz25lL2UI
	/ftX8IDos6U/Jt5jqTE8a/Tc2OHgicQfDz7d3Pk9S4mlOCPRUIu5qDgRAPgVaVE4BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76
References: <20240601014045.jkk3ydsu4zns2bfc@master>
	<20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
	<20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
	<20240524090715epcms1p274939a1d5954be3423f6ce14a3df6f92@epcms1p2>
	<20240527013504epcms1p22bec7b83f2a42e76877b97ed0d769009@epcms1p2>
	<20240529095119epcms1p73f0e9ff756bcb2ee6a14db459128a644@epcms1p7>
	<20240529113519.jupuazcf754zjxzy@master>
	<CAJrd-UuiDq-o=r7tK=CG6Q3yeARQBEAtaov2yqO6e6tBwJZoqQ@mail.gmail.com>
	<20240530104928epcms1p8108ece61c39c6e3d0361d445c15352d1@epcms1p8>
	<20240531082141epcms1p49d8d2048e04e90eca45644723614faa8@epcms1p4>
	<CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p8>

>On Fri, May 31, 2024 at 05:21:41PM +0900, Jaewon Kim wrote:
>>>On Thu, May 30, 2024 at 07:49:28PM +0900, Jaewon Kim wrote:
>>>>>On Wed, May 29, 2024 at 10:10:29PM +0900, Jaewon Kim wrote:
>>>>>>(Sorry I might forget to change to be plain text)
>>>>>>
>>>>>>Oh good thing, I did not know this patch. Thanks.
>>>>>>
>>>>>>By the way, I've tried to get memblock/memory and kernel log from a
>>>>>>device based on
>>>>>>v6.6.17 kernel device, to see upstream patches above.
>>>>>>memblok/memory does not show region for
>>>>>
>>>>>memblock/memory only shows ranges put in "memory".
>>>>>memblock/reserved shows ranges put in "reserved".
>>>>>
>>>>>If we just put them in "reserved", it will not displayed in "memory".
>>>>
>>>>Hi
>>>>Let me explain more.
>>>>
>>>>In this case, the intially passed memory starts from 0000000081960000 so memblock/memory shows as it is.
>>>>
>>>># xxd -g 8 /proc/device-tree/memory/reg
>>>>00000000: 0000000081960000 00000000000a0000  ................
>>>>00000010: 0000000081a40000 00000000001c0000  ................
>>>>
>>>># cat sys/kernel/debug/memblock/memory
>>>>   0: 0x0000000081960000..0x00000000819fffff    0 NONE
>>>>   1: 0x0000000081a40000..0x0000000081bfffff    0 NONE
>>>>
>>>># cat sys/kernel/debug/memblock/reserved
>>>>   0: 0x0000000082800000..0x00000000847fffff    0 NONE
>>>>
>>>>The memblock information in the kernel log may report like it allocated those memblock regions, as there was not overlapped even though it is already no-map.
>>>>
>>>>(I removed the name.)
>>>><6>[    0.000000][    T0] OF: reserved mem: 0x0000000080000000..0x0000000080dfffff (14336 KiB) nomap non-reusable AAA
>>>><6>[    0.000000][    T0] OF: reserved mem: 0x0000000080e00000..0x00000000811fffff (4096 KiB) nomap non-reusable BBB
>>>><6>[    0.000000][    T0] OF: reserved mem: 0x0000000081200000..0x00000000813fffff (2048 KiB) nomap non-reusable CCC
>>>><6>[    0.000000][    T0] OF: reserved mem: 0x0000000081a00000..0x0000000081a3ffff (256 KiB) nomap non-reusable DDD
>>>>
>>>
>>>This looks not printed by memblock_reserve(), right? It is printed by your own
>>>driver?
>>
>>AFAIK these log came from the commit below.
>>aeb9267eb6b1 of: reserved-mem: print out reserved-mem details during boot
>>
>>>
>>>>So a smart parser should combine the krenel log and the memblock/memory log.
>>>>
>>>>In my memsize feature shows it like this though.
>>>>
>>>>0x0000000081400000-0x0000000081960000 0x00560000 (    5504 KB ) nomap unusable unknown
>>>>
>>>>BR
>>>>
>>>
>>>I am sorry, I still not catch your point. Let me try to understand your message.
>>>
>>>You mentioned several regions, let me put them in order.
>>>
>>>(1)   0x0000000080000000..0x0000000080dfffff    printed by driver
>>>(2)   0x0000000080e00000..0x00000000811fffff    printed by driver
>>>(3)   0x0000000081200000..0x00000000813fffff    printed by driver
>>>(4)   0x0000000081400000..0x0000000081960000    expected to print in new debugfs
>>>(5)   0x0000000081960000..0x00000000819fffff    listed in reg/memory
>>>(6)   0x0000000081a00000..0x0000000081a3ffff    printed by driver
>>>(7)   0x0000000081a40000..0x0000000081bfffff    listed in reg/memory
>>>(8)   0x0000000082800000..0x00000000847fffff    listed in reserved
>>>
>>>If you just want information for region (4), sound we can do it in user-space?
>>>
>>>BTW, are region 1, 2, 3, 6, reserved in membock?
>>
>>Yes correct, I though (4) case could be shown to easily catch these hidden regions.
>>As I said, I think 1, 2, 3, 6 seem to be not passed to kernel, it was just tried as
>>they are defined in kernel device tree.
>>
>
>As you mentioned above, 1, 2, 3, 6, is printed by "of" driver. And those
>information is not shown in memblock/reserve.
>
>I am afraid the proper way is to let memblock know those ranges. Sounds "of"
>driver doesn't tell memblock about these.
>

Yes that is the reason why I added some code to 'of' driver, too. As I said,
if we don't change 'of' driver and memblck, we need a smart parser looking into
kernel log and memblock info, and understand these special cases.

BR

>>
>>>
>>>-- 
>>>Wei Yang
>>>Help you, Help me
>

