Return-Path: <linux-kernel+bounces-195273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807118D49E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8EF0B22C84
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862317C7CB;
	Thu, 30 May 2024 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fzZpxCw8"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F26F2F8
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717066175; cv=none; b=ZebLCfDNhJPDXdqxlRfgjHWybDPsLUnd32qAXli1PD68J2552uV1vHEFvm4uyzydvKRH5lRKqyBGxtVogl1JVSS9NE69A6BiiHfe3YpXTu3oSF+VPLX3Bs+7KokR46lgBK61wB6IvrZdGD+QvzTHFM7mUFFTKfx6ANJVfbHvd7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717066175; c=relaxed/simple;
	bh=TJ2qCM+mvdP0g9i+4Q2nIXBFeAvuhiAMDG4DILKDI/c=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=uKQehd90chfSWU8z8CwwzoJQGulPavfpDX0WNqom0hpWLLygqaTm+wMuV6Qkosn+4t8dCdCil/86mDSzHsmIZnrz8ST7Gsf62ejpBzYnL9oPTRU+neXtHkpyNcVvdLA8Mmp/EqGCxKpCpUvtNVkNwck+XKtxbKhEJdD0uLz8HOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fzZpxCw8; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240530104930epoutp03bfab6ffbb63d9f261b235136668037c7~UPpWmumab2671726717epoutp03j
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:49:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240530104930epoutp03bfab6ffbb63d9f261b235136668037c7~UPpWmumab2671726717epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717066170;
	bh=bayhkHJWgnKx9EEPIcgFg/m+eMAFCDXeiFRm7E7Mg78=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=fzZpxCw8497u8+hZRoz9tVsA75m8B+Vb0bZEyYmewijeqCgPKE7wMXkgvaGfxWMbn
	 ezvBF0O7Ljh/OoxVC8Whn4bmMYmN8An2Qn9lnztcmgorb+2iRyyT/m2lG4YUkSGnZV
	 9HF7pHmijKG7GSjDDjgByxSdonvrpjB9nkosv5wg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240530104929epcas1p1f8ec89fe5f632a0a0e2b2754ca585aa3~UPpWGF9do2008220082epcas1p1k;
	Thu, 30 May 2024 10:49:29 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.243]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VqjgF3PJtz4x9Pt; Thu, 30 May
	2024 10:49:29 +0000 (GMT)
X-AuditID: b6c32a4c-bb9ff70000004a73-91-665859b9ece6
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6C.75.19059.9B958566; Thu, 30 May 2024 19:49:29 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) (2) [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Reply-To: jaewon31.kim@samsung.com
Sender: Jaewon Kim <jaewon31.kim@samsung.com>
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>, Jaewon Kim
	<jaewon31.kim@gmail.com>
CC: Jaewon Kim <jaewon31.kim@samsung.com>, Mike Rapoport <rppt@kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tkjos@google.com" <tkjos@google.com>, Pintu Agarwal <pintu.ping@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240530000301.zvirmigx3pdw474w@master>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240530104928epcms1p8108ece61c39c6e3d0361d445c15352d1@epcms1p8>
Date: Thu, 30 May 2024 19:49:28 +0900
X-CMS-MailID: 20240530104928epcms1p8108ece61c39c6e3d0361d445c15352d1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmnu7OyIg0g9XHJCzmrF/DZvHykKZF
	9+aZjBa9718xWVzeNYfN4t6a/6wW119OY7G40/eKxeLI+u1MFu8nF1vMbuxjdOD22DnrLrvH
	gk2lHptWdbJ5bPo0id3jxIzfLB59W1YxepxZcITd4/MmuQCOqGybjNTElNQihdS85PyUzLx0
	WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAzlRTKEnNKgUIBicXFSvp2NkX5pSWp
	Chn5xSW2SqkFKTkFZgV6xYm5xaV56Xp5qSVWhgYGRqZAhQnZGd/nNzEXdMhUfPom1MD4R6yL
	kZNDQsBEYkv/WvYuRi4OIYE9jBIXr89n6mLk4OAVEJT4u0MYxBQWiJPoXBcKUi4koCRx9scV
	dhBbWEBXoql7NQuIzSagLfF+wSRWEFtEIEli7/HpYDazwFMmif4/YRCreCVmtD9lgbClJbYv
	38oIYnMKmEo09DSxQ8RFJW6ufgtnvz82nxHCFpFovXeWGcIWlHjwczcjzJw/x5+zQdjFEss6
	HzBB2DUSK86tgoqbSzS8XQlm8wr4Snx6sxysl0VAVWLHjiaoeheJpx+/sEPcLC+x/e0cZpDX
	mQU0Jdbv0ocI80m8+9rDCvNKw8bf7NjYO+Y9gRqpJtHy7CtUvYzE33/PoGwPibvXdrNMYFSc
	hQjnWUgWz0JYvICReRWjVGpBcW56arJhgaFuXmo5PHaT83M3MYKTrJbPDsbv6//qHWJk4mA8
	xCjBwawkwntmUmiaEG9KYmVValF+fFFpTmrxIUZToLcnMkuJJucD03xeSbyhiaWBiZmRiYWx
	pbGZkjjvmStlqUIC6YklqdmpqQWpRTB9TBycUg1MLL1nnyjs+r9OM9/88EwL54N570wTJ7Wp
	1//Xrdu4Y0btpfMMnP8ZLz3OYHAxE9hZFXCsOIalrS3DYcq3Ent+Vac5Wx6di5q16dHWy1L7
	c6TfxnydyRn38ltkEpu7j8TXx0U/XaXeTU9Wf76Gp/R1otfBedtuXZi5MSd+SjjjQaszO86b
	TmGMbrr3eM314k+K7eZzKjfcTbe4x5C7J640bNrSvkWpnTOKF61m1szmVgr3NngbP+O5+w/h
	32+Sz1z5tF/1+bfrdcdfuP04tlIuQPlJeYra4U01L3SNlaTT2xfOvTsj2FC07kJf/YJ7OY+L
	bjH3m2bLM0ncfPci/YnIct6wWVa+h9/IVy1NXbC5R4mlOCPRUIu5qDgRAMkaXSo7BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76
References: <20240530000301.zvirmigx3pdw474w@master>
	<ZkxN0yQ7Fb0X26hT@kernel.org>
	<20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
	<20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
	<20240524090715epcms1p274939a1d5954be3423f6ce14a3df6f92@epcms1p2>
	<20240527013504epcms1p22bec7b83f2a42e76877b97ed0d769009@epcms1p2>
	<20240529095119epcms1p73f0e9ff756bcb2ee6a14db459128a644@epcms1p7>
	<20240529113519.jupuazcf754zjxzy@master>
	<CAJrd-UuiDq-o=r7tK=CG6Q3yeARQBEAtaov2yqO6e6tBwJZoqQ@mail.gmail.com>
	<CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p8>

>On Wed, May 29, 2024 at 10:10:29PM +0900, Jaewon Kim wrote:
>>(Sorry I might forget to change to be plain text)
>>
>>Oh good thing, I did not know this patch. Thanks.
>>
>>By the way, I've tried to get memblock/memory and kernel log from a
>>device based on
>>v6.6.17 kernel device, to see upstream patches above.
>>memblok/memory does not show region for
>
>memblock/memory only shows ranges put in "memory".
>memblock/reserved shows ranges put in "reserved".
>
>If we just put them in "reserved", it will not displayed in "memory".
>


Hi
Let me explain more.

In this case, the intially passed memory starts from 0000000081960000 so memblock/memory shows as it is.

# xxd -g 8 /proc/device-tree/memory/reg
00000000: 0000000081960000 00000000000a0000  ................
00000010: 0000000081a40000 00000000001c0000  ................

# cat sys/kernel/debug/memblock/memory
   0: 0x0000000081960000..0x00000000819fffff    0 NONE
   1: 0x0000000081a40000..0x0000000081bfffff    0 NONE

# cat sys/kernel/debug/memblock/reserved
   0: 0x0000000082800000..0x00000000847fffff    0 NONE

The memblock information in the kernel log may report like it allocated those memblock regions, as there was not overlapped even though it is already no-map.

(I removed the name.)
<6>[    0.000000][    T0] OF: reserved mem: 0x0000000080000000..0x0000000080dfffff (14336 KiB) nomap non-reusable AAA
<6>[    0.000000][    T0] OF: reserved mem: 0x0000000080e00000..0x00000000811fffff (4096 KiB) nomap non-reusable BBB
<6>[    0.000000][    T0] OF: reserved mem: 0x0000000081200000..0x00000000813fffff (2048 KiB) nomap non-reusable CCC
<6>[    0.000000][    T0] OF: reserved mem: 0x0000000081a00000..0x0000000081a3ffff (256 KiB) nomap non-reusable DDD

So a smart parser should combine the krenel log and the memblock/memory log.

In my memsize feature shows it like this though.

0x0000000081400000-0x0000000081960000 0x00560000 (    5504 KB ) nomap unusable unknown

BR

>>0x00000000_80000000..0x0x00000000_8195ffff.
>>
>>   0: 0x0000000081960000..0x00000000819fffff    0 NONE
>>
>>The kernel log shows information for 0x0000000080000000..0x00000000813fffff, but
>>we don't see information for 0x0000000081400000..0x000000008195ffff
>>from kernel log.
>>
>>(I removed the name.)
>><6>[    0.000000][    T0] OF: reserved mem:
>>0x0000000080000000..0x0000000080dfffff (14336 KiB) nomap non-reusable
>>AAA
>><6>[    0.000000][    T0] OF: reserved mem:
>>0x0000000080e00000..0x00000000811fffff (4096 KiB) nomap non-reusable
>>BBB
>><6>[    0.000000][    T0] OF: reserved mem:
>>0x0000000081200000..0x00000000813fffff (2048 KiB) nomap non-reusable
>>CCC
>><6>[    0.000000][    T0] OF: reserved mem:
>>0x0000000081a00000..0x0000000081a3ffff (256 KiB) nomap non-reusable DD
>>
>
>I guess those ranges are only put into "reserved"? Have those ranges put in
>"memory"? Would you mind point the code where those messages are printed?
>
>>A smart parser should gather these kernel log and memblock/memory log
>>and should show
>>log like my memsize logic shows below.
>>0x0000000081400000-0x0000000081960000 0x00560000 (    5504 KB ) nomap
>>unusable unknown
>>
>>Thank you
>>Jaewon
>>
>>On Wed, May 29, 2024 at 8:35?PM Wei Yang <richard.weiyang@gmail.com> wrote:
>>>
>>> On Wed, May 29, 2024 at 06:51:19PM +0900, Jaewon Kim wrote:
>>> ><!DOCTYPE html>
>>> ><html>
>>> ><head>
>>> ...
>>>
>>> Would you mind sending it in pure text again?
>>>
>>> --
>>> Wei Yang
>>> Help you, Help me
>
>-- 
>Wei Yang
>Help you, Help me

