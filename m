Return-Path: <linux-kernel+bounces-543062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83EFA4D116
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120C5174A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2014613B58B;
	Tue,  4 Mar 2025 01:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vcP27uJj"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A6C1754B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052362; cv=none; b=U9ykCfxeQRgqI0SxivrbjbmyTGFKxM94lDVIuYGyulIBS7a7o6RKkXic6D8bwc8hry5ZgeUUwOX6wH/pBoMN1FVQt7DV6ZQchpD2lFvJDRSVcpqxY8UDOprq+tpfRYaNs1+JiDmg4WXjCHJJd6igPp5DEl2y9v/GPaRIwSEAc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052362; c=relaxed/simple;
	bh=ojJcx8PjLXoEZC9FDO1R3bRo2y1vdh6SRPTkxfXuyW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=czo0S3hk87P7ENVldl0+s4d3Gjq9qIHih46F08Zv9KycXjMCJOeG4DjSP+L5s6IrZIapSOXC/F2NegsGKt+iPgE05Tw6CJtBrEkgi8/eQnsvvtdr30AE+YIUiDjOARd834jKByP/kxqzigMpEBUxPFcbXV2Iv1P7pkmwSTajd1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vcP27uJj; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250304013916epoutp03dbca3a4d8d6b4332d4599bcf7193cd94~pdeTnqBWQ0306403064epoutp03r
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:39:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250304013916epoutp03dbca3a4d8d6b4332d4599bcf7193cd94~pdeTnqBWQ0306403064epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741052356;
	bh=WzVIasWSNBcOuq6okEIYOlGRLphFTZ6q35ajcfpcLno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vcP27uJjIqjO9bSaQIsb80Dh3BSKobvdLcbeXg4o8iSjhfAMQpJd5uRAxUt49e/++
	 JINayB9MmRSPmUVUevex70LaaoXuOuLu0sIZtNfJZn70VB11/EsKi+xIxWLNZzgVH7
	 3wIT7pJa+mYJeKvLpjvBGActNCuUhK5j+3/1N/AQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20250304013916epcas2p1c3fc29ec27298e8c1a0dcc75bce4a747~pdeS2KMqr1780917809epcas2p1l;
	Tue,  4 Mar 2025 01:39:16 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z6JJ33Nt6z4x9Q3; Tue,  4 Mar
	2025 01:39:15 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	4E.00.23368.2C956C76; Tue,  4 Mar 2025 10:39:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250304013914epcas2p1de7e76960cdf41aa0ea3f54726171206~pdeRA1edj2265022650epcas2p1u;
	Tue,  4 Mar 2025 01:39:14 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250304013914epsmtrp17ae171ef24522904060d10a91b62011e~pdeRADW600514605146epsmtrp1P;
	Tue,  4 Mar 2025 01:39:14 +0000 (GMT)
X-AuditID: b6c32a45-db1ed70000005b48-3c-67c659c2185e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.E4.18949.1C956C76; Tue,  4 Mar 2025 10:39:13 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250304013913epsmtip203bb47ab3ebc483e381a8edfe6704dd6~pdeQxDTHT2648626486epsmtip2-;
	Tue,  4 Mar 2025 01:39:13 +0000 (GMT)
Date: Tue, 4 Mar 2025 10:37:43 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, janghyuck.kim@samsung.com, Christoph
	Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes
	<rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton
	<akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] mm: slub: Enhanced debugging in slub error
Message-ID: <20250304013743.GA3859715@tiffany>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <af14d7c4-cb12-4b48-be67-5dcfc50aec09@suse.cz>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmue6hyGPpBnfvaVpM7DGwmLN+DZvF
	9W9vGC3uL3vGYrGyu5nNYvOcYovLu+awWdxb85/Vou3zPyCxZCOTxcQ1ohazG/sYHXg8ds66
	y+6xYFOpx6ZVnWwemz5NYvfoenuFyePEjN8sHk+uTGfyWNgwldnj49NbLB59W1YxepxZcITd
	4/MmuQCeqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfM
	HKDzlRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYG
	RqZAhQnZGX2/2hgLznBX9C7WamA8xtnFyMkhIWAi8ebRK+YuRi4OIYEdjBKrJp5lBUkICXxi
	lPh3OQUi8Y1R4vTXLcwwHX8+rGOCSOxllGjcNJcRwnnKKLG3YQsLSBWLgIrEw2uHmEBsNgF1
	iRNbljGC2CJA8UcbjrKCNDALtDNLfDt1AqxBWMBN4tS1D2C7eQX0JI4/nssGYQtKnJz5BKyG
	U8Ba4tDey2wgzRICBzgkfmx/wQhxk4vEvj0XmSBsYYlXx7ewQ9hSEi/726DsYoltiw8zQTQ3
	MEps7rgP9ZCxxKxn7WCDmAUyJSae3QXUwAEUV5Y4cosFIswn0XH4L1SYV6KjTQiiU1li/7J5
	LBC2pMSjte2sELaHxL1359kgobKbSaL10iPWCYxys5D8MwvJNghbR2LB7k9ss4BWMAtISyz/
	xwFhakqs36W/gJF1FaNYakFxbnpqsVGBITyGk/NzNzGCk7OW6w7GyW8/6B1iZOJgPMQowcGs
	JMJ7q/1ouhBvSmJlVWpRfnxRaU5q8SFGU2DsTGSWEk3OB+aHvJJ4QxNLAxMzM0NzI1MDcyVx
	3uodLelCAumJJanZqakFqUUwfUwcnFINTBE84suNbJaH7i1/qDb5RWn3tPD9oss05/0+fnxL
	2rzLrTqKfVm/1i/3Yj5r+vPuK5NpEnMWrfjz7nTAnhCxrJPqQtteXXCtFov88/PX1gMys7yn
	rFHxKt4w0cf0Q+Gt35U5r8vqebletD7RLe007b8274zBNqH+39stbMMS854t/O26QviBbPpH
	zRn/sgqlzJXLJj8/YVz8VF78XvHeV/WaP8XTyxdN3is6JSmqN/p/g1YDQ7eVcPnKUwZCn17J
	hS04+Lmgfd7qQJ74ezPyv09XvBuvdH7FG+MnkxIaDzWbq8udW2r8o7+Ne9Z5BcOkjyl/ko96
	t1rGL7J93xM15+Sjcu8zP94qJR36LJnpvUWJpTgj0VCLuag4EQB5QN0LVwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXvdQ5LF0g2XhFhN7DCzmrF/DZnH9
	2xtGi/vLnrFYrOxuZrPYPKfY4vKuOWwW99b8Z7Vo+/wPSCzZyGQxcY2oxezGPkYHHo+ds+6y
	eyzYVOqxaVUnm8emT5PYPbreXmHyODHjN4vHkyvTmTwWNkxl9vj49BaLR9+WVYweZxYcYff4
	vEkugCeKyyYlNSezLLVI3y6BK+P3+32MBZ2cFV+Ov2VsYJzD3sXIySEhYCLx58M6pi5GLg4h
	gd2MEn3njrNBJCQlZn0+yQRhC0vcbznCClH0mFHi/pJlYEUsAioSD68dAitiE1CXOLFlGSOI
	LQIUf7ThKFgDs0A3s8Stzf9ZQRLCAm4Sp659ALN5BfQkjj+eywYxdS+TxLm/E5khEoISJ2c+
	YQGxmQW0JG78ewm0gQPIlpZY/o8DJMwpYC1xaO9ltgmMArOQdMxC0jELoWMBI/MqRsnUguLc
	9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg6NLS2sG4Z9UHvUOMTByMhxglOJiVRHhvtR9NF+JN
	SaysSi3Kjy8qzUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoFJtdLrYCjHl6fn
	n/cyr3BfZ7lZMOlK8vpfhqHp5o0srHWX8v4m3P9SNWHRFK+LdSc53j7sXHZYm2tyxPXzpX/u
	K9U+dTq9b0ljTXP3TKXA9Gotva5f8klTQxcdDsk7up6BRYJrR7up20NW/0uiapN7NbddzEtJ
	F5f4H89d8DBIIHL6XPtrXC/+WFtEPGH7OqnjaVbMIy4uwWftOfnlP3c126vsmJWoeJx7dfil
	xQEhE+akJ66dfadIsDXUhc3XlDP4scyfvpk+RyfO8JpkmrN4gu/nXRxcWvzyMVzeC1XLdzyL
	TZnKnhwnKWU+XXZD5N4/n8pn/tonz3AyNbo1jNtVSWLpNzmrs/VZT2YGfFJiKc5INNRiLipO
	BABU0wktHQMAAA==
X-CMS-MailID: 20250304013914epcas2p1de7e76960cdf41aa0ea3f54726171206
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----m7PZ4BT1ldTQPVcONAqyTj2Zy1CXq_CO7oNb.DekQ57E.lpM=_17f50c_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250226081354epcas2p44c2f53d569296ac2e5f8a7b01f4552fa
References: <CGME20250226081354epcas2p44c2f53d569296ac2e5f8a7b01f4552fa@epcas2p4.samsung.com>
	<20250226081206.680495-1-hyesoo.yu@samsung.com>
	<c1db529b-f16c-4195-8832-8f2cecd84ece@suse.cz>
	<a206637e-f63b-432a-aaa2-2e947ae5f4d8@suse.cz> <Z8GwbynIs1N_GeE6@harry>
	<af14d7c4-cb12-4b48-be67-5dcfc50aec09@suse.cz>

------m7PZ4BT1ldTQPVcONAqyTj2Zy1CXq_CO7oNb.DekQ57E.lpM=_17f50c_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Feb 28, 2025 at 05:02:00PM +0100, Vlastimil Babka wrote:
> On 2/28/25 13:47, Harry Yoo wrote:
> > On Thu, Feb 27, 2025 at 05:26:26PM +0100, Vlastimil Babka wrote:
> >> ---8<---
> >> From c38dadde6293cacdb91f95afc3615c22dec5830a Mon Sep 17 00:00:00 2001
> >> From: Vlastimil Babka <vbabka@suse.cz>
> >> Date: Thu, 27 Feb 2025 16:05:46 +0100
> >> Subject: [PATCH] mm, slab: cleanup slab_bug() parameters
> >> 
> >> slab_err() has variadic printf arguments but instead of passing them to
> >> slab_bug() it does vsnprintf() to a buffer and passes %s, buf.
> >> 
> >> To allow passing them directly, turn slab_bug() to __slab_bug() with a
> >> va_list parameter, and slab_bug() a wrapper with fmt, ... parameters.
> >> Then slab_err() can call __slab_bug() without the intermediate buffer.
> >> 
> >> Also constify fmt everywhere, which also simplifies object_err()'s
> >> call to slab_bug().
> >> 
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> > 
> > Looks good to me.
> > 
> > FWIW,
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Thanks, adding to slab/for-next
> 
> 

Looks good to me.
Thanks! 

------m7PZ4BT1ldTQPVcONAqyTj2Zy1CXq_CO7oNb.DekQ57E.lpM=_17f50c_
Content-Type: text/plain; charset="utf-8"


------m7PZ4BT1ldTQPVcONAqyTj2Zy1CXq_CO7oNb.DekQ57E.lpM=_17f50c_--

