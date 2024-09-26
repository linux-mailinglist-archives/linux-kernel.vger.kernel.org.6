Return-Path: <linux-kernel+bounces-340483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425429873F5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646BA1C22D56
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512851CAB8;
	Thu, 26 Sep 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VKJ1HVFn"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E571C6A5
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355524; cv=none; b=f3G2B1E+Am/wJSfb7muWz//JbkGVLboO4O7UhR6v8vl6T/Y2wgqnnfT5hXQWU2YypCucoA+5dGZhQFAaXXvw/wR4LcdZBj6Al/qPsWRElc/+fcUeJ4mDupGneR2Q7faqwwIQcTMjd1lIhtGdliYwe911xOhShAEbPtGnUvtKxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355524; c=relaxed/simple;
	bh=SmtIA7XYQx4nX6+fGbTqnqCSm7yRmL3RORcONRWqcWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:From:In-Reply-To:
	 Content-Type:References; b=mdtgkd5WAwVg2hiVVRGrudSxQhQIi5IqEh2To/Jg40/nt3yhaT0zAhgWoHEL0PWbb7O/QrBAL+tOGGdJ0V8trmr0pgmcIPDs5JznLp7xtXoUtAjDB+x3HKSvQinK4MbJRAiZ5IfpKtKNXM6sIhCf23re5D4i/T36JwLYmtCTARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VKJ1HVFn; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240926125833euoutp01acb87cc3f5966ba5e9cf20930e5df610~4zLAeO1UV3237432374euoutp01G
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:58:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240926125833euoutp01acb87cc3f5966ba5e9cf20930e5df610~4zLAeO1UV3237432374euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727355513;
	bh=da4ojY3FKYoZj4Metcz6gYoYuDUssygQUDpJ4V+FW2E=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=VKJ1HVFnPZeq8nQMYmyC+lMUhP8B1KnE8EWyHrSqLEuLnIWjA1Y1jgqGFtrelpsoJ
	 tM2mErwTNcT+DPgRem2GWVl1CH7tTBaINNGNLFImbzIeB+ubF7gI+I4sChKu3/IoGD
	 gqBFR1G2Iw4i9jGM+9lxS+dnIQmMdvqRbKfIcHJQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240926125833eucas1p25553c8da37e5630ef564cb2acbd36260~4zLAMjar72928829288eucas1p2t;
	Thu, 26 Sep 2024 12:58:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id BE.1C.09624.97A55F66; Thu, 26
	Sep 2024 13:58:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240926125833eucas1p16d318f89b21db92af582be778eedde4c~4zK-rIBcH1657916579eucas1p1I;
	Thu, 26 Sep 2024 12:58:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240926125833eusmtrp26c051f0c4eba6a7cea62b08023158779~4zK-pSTV31891318913eusmtrp2T;
	Thu, 26 Sep 2024 12:58:33 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-d1-66f55a79a688
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C7.90.14621.87A55F66; Thu, 26
	Sep 2024 13:58:32 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240926125832eusmtip28fa82999f1ebdbf9b8ef66fbadcb8178~4zK-dGYMa0982809828eusmtip2c;
	Thu, 26 Sep 2024 12:58:32 +0000 (GMT)
Received: from [106.110.32.87] (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 26 Sep 2024 13:58:31 +0100
Message-ID: <18532bd8-08bd-4494-a3af-fe252a803380@samsung.com>
Date: Thu, 26 Sep 2024 14:58:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] mm: shmem: add large folio support to the
 write and fallocate paths
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>, Baolin Wang
	<baolin.wang@linux.alibaba.com>
CC: <akpm@linux-foundation.org>, <hughd@google.com>, <david@redhat.com>,
	<wangkefeng.wang@huawei.com>, <21cnbao@gmail.com>, <ryan.roberts@arm.com>,
	<ioworker0@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
From: Daniel Gomez <da.gomez@samsung.com>
In-Reply-To: <ZvVQoY8Tn_BNc79T@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7qVUV/TDP79kbH4fFfIYs76NWwW
	//ceY7T4uv4Xs8XTT30sFot+G1tc3jWHzeLemv+sFj27pzJaNH6+z2jx+8ccNgdujzXz1jB6
	7Jx1l91jwaZSj5Yjb1k9Nq/Q8tj0aRK7x4kZv1k8dj609Hi/7yqbx+dNcgFcUVw2Kak5mWWp
	Rfp2CVwZTYdWsRY846xofH+DqYHxPXsXIyeHhICJxImFX1i7GLk4hARWMEp8u/qFBcL5wiix
	Z9UtNgjnM6PE1Ia7cC3Plv9igkgsZ5Q49XsHI1zVolcHoIbtZJTYPuUBG0gLr4CdREvrEbB2
	FgFViYstS1kg4oISJ2c+AbNFBeQl7t+aAVYjLJAq8fLvfzCbWUBcounLSlYQW0QgXOLUkoVg
	BzILPGaUWP/6A1iCTUBTYt/JTWANnED3Td7wiLmLkQOoyEpi+glPiDnyEtvfzmGGeEFRYsbE
	lSwQdq3EqS23mCDs3ZwSc3cpQtguEtNmLYSKC0u8Or4F6n0Zif8750PF0yWWrJsFNadAYs/t
	WawgayUErCX6zuRAhB0l+tafZ4MI80nceCsIcQ2fxKRt05knMKrOQgqIWUgenoVw/ywk9y9g
	ZFnFKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmNRO/zv+aQfj3Fcf9Q4xMnEwHmKU4GBW
	EuGddPNjmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU1ILUIpgsEwenVANT
	3q73Zb9OcJ+KiJT0zRcr/5Pi9cN4xyNB009i8g+Le47P9xEXm5ea16y/96KruBZ75LTgm3cf
	SfRPVPvRu3B2itr8zfzCE1dNj/0RVuuzbvmhSon6zQebgrpq3TiP6exzkrgUpcRQkRC2XuTk
	b70EkzSXa//ZPS6J1JZyaQZ8FFx9lONg7a3Zguu+3PwRefT8N152M97rlWVzvQIXfU60CKqq
	2xcQ1GEdNfVprubckNsOmrdnH2DX23i04GeOxGblTTG7844tjf/4TuRo9EI+q+OHQuQkW7br
	J38pflG/39nlYsDG8oRFxiu6Vb09zqjGHhZkOei50UHttqKZTVZ25Pv/Ort3XBKVX/lh4gUl
	luKMREMt5qLiRADymlZs2QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsVy+t/xe7oVUV/TDF72W1h8vitkMWf9GjaL
	/3uPMVp8Xf+L2eLppz4Wi0W/jS0u75rDZnFvzX9Wi57dUxktGj/fZ7T4/WMOmwO3x5p5axg9
	ds66y+6xYFOpR8uRt6wem1doeWz6NInd48SM3yweOx9aerzfd5XN4/MmuQCuKD2bovzSklSF
	jPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MpkOrWAuecVY0vr/B
	1MD4nr2LkZNDQsBE4tnyX0xdjFwcQgJLGSW2z5/MBpGQkdj45SorhC0s8edaFxtE0UdGib2H
	TjFCODsZJW5d6WMEqeIVsJNoaT0CNpZFQFXiYstSFoi4oMTJmU/AbFEBeYn7t2aA1QgLpEq8
	/PsfzGYWEJdo+rISbJuIQLjEqSULWUAWMAs8ZpRY//oDK8S2GUwSq5d+B9vGJqApse/kJrBu
	TqAnJm94xAwxyUJi8ZuDUFPlJba/ncMM8YOixIyJK1kg7FqJz3+fMU5gFJ2F5MBZSA6ZhWTU
	LCSjFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAhMCduO/dy8g3Heq496hxiZOBgPMUpw
	MCuJ8E66+TFNiDclsbIqtSg/vqg0J7X4EKMpMJQmMkuJJucDk1JeSbyhmYGpoYmZpYGppZmx
	kjiv2+XzaUIC6YklqdmpqQWpRTB9TBycUg1MzVXRXdu8QzVaDj0/3MLXu4yz1MBAQZf9kwbf
	8anbOLX3nV0dw2XjxG0vd9V/673G+vAWrvdnvd8ui8gNroq2Sl7B3iCcstb85tzHXp8/rNy0
	Ltkw6OjaXf+rYx0Pzvth/1SJWVr9ya3nURUJ2dFuxxfen8MorOh+8dILi8330ozUd/j1bzj2
	teKS+z92x22556qyvfbereJ1W9J/7sShp73dBxZqN/6SXcOl9sLM625QWuuqYwtE/hXn5jjv
	PzPj8JGY/C6F1kdnyhgU2i3k738V9Gp7z7wo/uOjZds28h89lZs87bKFx/xA8YLFE+bP2P3g
	kN7GbFvjImG7lz56zovlY6R5rv36feZh8159JZbijERDLeai4kQAmuoMhJIDAAA=
X-CMS-MailID: 20240926125833eucas1p16d318f89b21db92af582be778eedde4c
X-Msg-Generator: CA
X-RootMTR: 20240926121649eucas1p2aec9398cab6db6fee1251a1a61568857
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240926121649eucas1p2aec9398cab6db6fee1251a1a61568857
References: <cover.1727338549.git.baolin.wang@linux.alibaba.com>
	<c03ec1cb1392332726ab265a3d826fe1c408c7e7.1727338549.git.baolin.wang@linux.alibaba.com>
	<CGME20240926121649eucas1p2aec9398cab6db6fee1251a1a61568857@eucas1p2.samsung.com>
	<ZvVQoY8Tn_BNc79T@casper.infradead.org>

On 9/26/2024 2:16 PM, Matthew Wilcox wrote:
> On Thu, Sep 26, 2024 at 04:27:26PM +0800, Baolin Wang wrote:
>> +static inline unsigned int
>> +shmem_mapping_size_order(struct address_space *mapping, pgoff_t index, size_t size)
>> +{
>> +	unsigned int order = get_order(max_t(size_t, size, PAGE_SIZE));
> 
> Why introduce the max_t() call here?  Did nobody read the documentation
> or implementation for get_order() before writing this patch?

get_order() result is undefined if the size is 0. I've used max_t() here 
to avoid that case. Perhaps should we prevent that case before getting here?

> 
> Besides, get_order() is wrong (at least relative to other filesystems).
> get_order() rounds up instead of down, so what should we do for a write()
> of size 512 * 1024 + 1 byte?  Other filesystems allocate an order-8 folio
> plus an order-0 folio.  This code would have us allocate an order-9 folio.
> I think that's a bad idea.
> 

I think one of my earlier attemps was to use fgf_set_order + 
FGF_GET_ORDER() as in iomap. But the solution taken there was to share 
code between shmem and filemap and that wasn't considered a good idea. 
Shall we just replicate iomap_get_folio()? Or else, what do you suggest 
here?

Daniel

