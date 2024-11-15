Return-Path: <linux-kernel+bounces-410936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CD59CF256
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A06B3F721
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D9F1E1C2F;
	Fri, 15 Nov 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jWyzlZB6"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091E1D90BD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685461; cv=none; b=VoZX12/RD9JIUc8IneR4KrmhKkFudwfd0lC7Kz1M8ALCLjzdJRgvYIfq4EKD6JUl/V9OqaLcut9+ugh6ImO45PpWDd6mKR1fNauQSqoCHiMjfWz5hYMnBU9jv0XSUJPapjDTlu0eqM7k0sM8PkDcVUP3dRg7K6+Hnzpd+ZTkJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685461; c=relaxed/simple;
	bh=90wvJYUA6LdxZ4DonNt9wUlHi5YGTteo3uhsbizZ4y0=;
	h=MIME-Version:Content-Type:Date:Message-ID:CC:To:From:Subject:
	 In-Reply-To:References; b=DBAqBWTtFdAjQJdil+b+Z0QZyZmeW4AbLG2QAwrm0DLgufvGT4M4LPOPTuIYeRd3rX2mUGY7PLgrU8JF9iESTi6NM2hii+YbjrRuqKuNXgrgEVexxa/sbxi6PC2Ciw40ARRbOTTwrtRojgfCPBRKZfJIAe0d+xLVrUAgdnqWW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jWyzlZB6; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241115153513euoutp0164fb31744c2a7b84407523da98090a5e~ILkEIoJCR1654816548euoutp01o
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:35:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241115153513euoutp0164fb31744c2a7b84407523da98090a5e~ILkEIoJCR1654816548euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731684913;
	bh=90wvJYUA6LdxZ4DonNt9wUlHi5YGTteo3uhsbizZ4y0=;
	h=Date:CC:To:From:Subject:In-Reply-To:References:From;
	b=jWyzlZB6270/Lp2CZCZmK3Yt8jfZnwi1Z/Uc3FLGX4kUxCj2ToeeSHBhL9m9bQjXU
	 NvW98YfOlsJHfVfIu35gp1AZLSZQo8Ega3m8z2kn9KwLRgdUl1IHCQ3UvhlVSCdnsB
	 mi1SHQF/oz5RNINNRBJWTq98WwRCUkavm7BUg4qA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241115153513eucas1p2ce7d7035f7ca3f6d47eebd338f62df04~ILkD4pqes1281912819eucas1p27;
	Fri, 15 Nov 2024 15:35:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 9B.E2.20821.13A67376; Fri, 15
	Nov 2024 15:35:13 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241115153512eucas1p2e40f67965a69d86223f6dfbd6909248d~ILkDetjyS2159321593eucas1p2N;
	Fri, 15 Nov 2024 15:35:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241115153512eusmtrp2a1810c5d11b6f55c8df9f9049a1ddaa3~ILkDeC_-H0665206652eusmtrp2V;
	Fri, 15 Nov 2024 15:35:12 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-e5-67376a31de6c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id EB.92.19920.03A67376; Fri, 15
	Nov 2024 15:35:12 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241115153512eusmtip24c5b9f345dbcd388e2c09a0702fdd073~ILkDSkTej3024530245eusmtip2U;
	Fri, 15 Nov 2024 15:35:12 +0000 (GMT)
Received: from mail.scsc.local (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 15 Nov 2024 15:35:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Nov 2024 16:35:11 +0100
Message-ID: <D5MV2HU1QPLI.1P2HM7OTCR997@samsung.com>
CC: <willy@infradead.org>, <wangkefeng.wang@huawei.com>,
	<21cnbao@gmail.com>, <ryan.roberts@arm.com>, <ioworker0@gmail.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, <akpm@linux-foundation.org>,
	<hughd@google.com>
From: Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH v2 0/5] Support large folios for tmpfs
X-Mailer: aerc 0.18.2-67-g7f69618ac1fd
In-Reply-To: <3269e0a6-29a4-478b-842a-629efc8d5d59@redhat.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2znbzmar4zJ8sdJa90xNsjpaSFHaydAk0qKgWu2wWfPSjpcM
	ogvdEDE1TFur7IItnWkrtWlpmc5mgqVEl3UxUlNLrC3LGmq6Y+G/530uPO/38hGYtIrvQcTE
	JTKaOLlaJhDj5ebfzT7+e5crFzcVu1D2d1JKV2IQUMMPzIjqL/mDUR22DJy66lhCtVbqBNR7
	wzCfSq/KQdRR+wdEOQZ0glUutOGSAdEm7TshnW9Moo/X9fLpO/qFtNGWLaSf5Dlw2vQxkO6r
	fiGg7UbPSPE28UoFo45JZjR+wbvEqt62SizhJXGgNPMiOoIGBWlIRAAZAPqHXcI0JCakpB7B
	+fRXfG74gUCfU4i4wY6gMK+N/y9S9iabxwk3EFTdaeX/d9U1VI8NJgSZnX34aERCuoLlfLsT
	Y6Q3FFz5gnF4AZyocIy0EwROzgH9OZKzB4CuNMfZgJFlCM7qLM4N3UZkaO/P4426BCPhaovR
	GZ5MBkHHN29uvbkwfCbL2SUig+HzresYx8+EvKybOIcPQePdN84CIItE0JlrGhPWQm7foJDD
	k6Gn4e4YngbDpss8Divh+i3tmD8B7lu1/NEdgFwBGU1qjl4NBeWXhBw9EV71unLPnQjZ5bkY
	R0vg9ElpJpqtHXcg7bgDaccdKB9hhcidSWJjlQzrH8ek+LLyWDYpTum7Jz7WiEb+19OhBts9
	dLHnu28t4hGoFgGBydwkLSHLlVKJQp56kNHE79QkqRm2Fk0lcJm7ZI7Ci5GSSnkis49hEhjN
	P5VHiDyO8NiHZfik+EF90VndYTfttGjbfM+DUf1vzY+aQ5+rv5a8uFcujEr1OVR6rHfq9HkF
	XV5WSfGmpi3PlQMB84rSf1pTQqv2tgypimNabvtFzNrdSb2eyZgcXQekHSERGbW6NZaCL6eC
	Fy21bLeqEsOChLtqfGuWPQjs2dx9csPjT0+jiyXea2Ueik2P/NXqE0q/C4U7UgJ+hTq0la37
	XR5Hbp+d3Nwd1Bb5q+JCh3jSwEbD8fwcc0OF3HqNtyW5je2uv79uf01/UWOUiz1raBVK8xpU
	hcU0/Y5YE95oC5en1q8nc+0ak9czT9H7HVtdQxTtO8NLzKGByYunnD5lnxE9IXNdmKsMZ1Vy
	/4WYhpX/BVFW4NrOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xe7oGWebpBvdP61t8vitkMWf9GjaL
	/3uPMVp8Xf+L2eLppz4Wi0W/jS0u75rDZnFvzX9Wi57dUxktGj/fZ7T4/WMOmwO3x5p5axg9
	ds66y+6xYFOpR8uRt6wem1doeWz6NInd48SM3yweOx9aerzfd5XN4/MmuQCuKD2bovzSklSF
	jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mtw92MRdc56jYMGEu
	YwPjX7YuRk4OCQETia23JjF1MXJxCAksZZQ4tmEXE0RCRmLjl6usELawxJ9rXWANQgIfGSVa
	vxdCNOxklJjevJ0dJMErIChxcuYTFhCbWUBbYtnC18wQtqZE6/bfQDUcHCwCqhIrpglAlJtI
	zNkwFWwxs8BWRomXl+ewgTgiQGmJJ19ngF3BBtS87+QmsGZhASuJpx+0IQ5Sk/jfP5EF4oj3
	jBJTH/aDXcopYCfxfN0SZogiRYkZE1eyQNi1Ep//PmOcwCgyC8mts5DcOgvJrQsYmVcxiqSW
	Fuem5xYb6hUn5haX5qXrJefnbmIExve2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIryXXM3ThXhT
	EiurUovy44tKc1KLDzGaAj09kVlKNDkfmGDySuINzQxMDU3MLA1MLc2MlcR53S6fTxMSSE8s
	Sc1OTS1ILYLpY+LglGpgEm4JaD/rGvUhXP68wJQ1m8pcGaP0zz/uc1eo2cRqH28hODNPuaHm
	dQ7rRI/bhYaam1Y+P3pCektMnRfT521brZjtEr8IPbjm7RK67fzLSUuCU7uiKvIX2v4qCV6W
	8WSHxpeyRfxH1F1m2X68usJEru7JJTPlo695fBbsiUxNYReodL/qfGzppcB1Sr2P3laHf86f
	XPrmkLjhTOGSSS7SMrwHvgtWdHS5b2LyZA6QEGpfErbfI+ToEQaGRWtOGW/5oyT60fKaw4v/
	mrKNErUdj5kc92lVFdX8ur1i2ce9FqLfb/PNmpsYd6DFe+FhrZRZYrxlS3eelBNyYXj8UGne
	pNBHZYJHX/9xSStcELZZiaU4I9FQi7moOBEACyOUongDAAA=
X-CMS-MailID: 20241115153512eucas1p2e40f67965a69d86223f6dfbd6909248d
X-Msg-Generator: CA
X-RootMTR: 20241115131634eucas1p2db22b75fcc768a4bb6aa47ee180110cc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241115131634eucas1p2db22b75fcc768a4bb6aa47ee180110cc
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
	<CGME20241115131634eucas1p2db22b75fcc768a4bb6aa47ee180110cc@eucas1p2.samsung.com>
	<D5MS4CMG4N8F.1M5WPZ1T5UT0I@samsung.com>
	<3269e0a6-29a4-478b-842a-629efc8d5d59@redhat.com>

On Fri Nov 15, 2024 at 2:35 PM CET, David Hildenbrand wrote:
> On 15.11.24 14:16, Daniel Gomez wrote:
>> On Tue Nov 12, 2024 at 8:45 AM CET, Baolin Wang wrote:
>>> Traditionally, tmpfs only supported PMD-sized huge folios. However nowa=
days
>>=20
>> Nitpick:
>> We are mixing here folios/page, PMD-size huge. For anyone not aware of
>> Memory Folios conversion in the kernel I think this makes it confusing.
>> Tmpfs has never supported folios so, this is not true. Can we rephrase
>> it?
>
> We had the exact same discussion when we added mTHP support to anonymous=
=20
> memory.
>
> I suggest you read:
>
> https://lkml.kernel.org/r/65dbdf2a-9281-a3c3-b7e3-a79c5b60b357@redhat.com
>
> Folios are an implementation detail on how we manage metadata. Nobody in=
=20
> user space should even have to be aware of how we manage metadata for=20
> larger chunks of memory ("huge pages") in the kernel.

I read it and I can't find where the use of "PMD-size huge folios" could
be a valid term. Tmpfs has never supported "folios", so I think using
"PMD-size huge pages" is more appropiate.

