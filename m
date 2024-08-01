Return-Path: <linux-kernel+bounces-271201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B57A944AC1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0901C25C02
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDA319E7D0;
	Thu,  1 Aug 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="id7vIxuG"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7C196DA1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722513669; cv=none; b=Io72j7LeGkkQwzbFaS0SrLF+LvxQVB7F5/8MgeACI9eaFn2FhoZw21ouFLfxyO3bX0FpcOAtOYj9V99b/vc6+KqkDYVHknIKmHVpMhFA/3qhSPY9dtJBe/ST7e+olhaqqka2IU32gFUaWzxwdgugvTbdbEfNm6kAlngbAW+fpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722513669; c=relaxed/simple;
	bh=wQMVKFvI0wEAdcNShHStxBQkuySTWHo9KALl2KgeK5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=GIFsrJP0TdwbN+sZOoPaz2gkvkUCpbcZyxLCmCg7mt04orDvCq7d8oJ9OBGrjETBBs6Q3B95t7lsevuFq556el4T24iX7BR9OkAmbppjNvu8ngUDdk5tO+3JUh0GyUpUQ/bDKLq2ECWWT29afEu323Xp3NwgyER4/egQ5o0LdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=id7vIxuG; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240801120058euoutp02e770a05af0709f417b20d3fab8c52420~nmQu9TE352873728737euoutp02I
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:00:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240801120058euoutp02e770a05af0709f417b20d3fab8c52420~nmQu9TE352873728737euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722513658;
	bh=kjW/axZWCmhXZjymH//wwAFqqKZRkQUfK5yHOQ5BNEo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=id7vIxuGmBVaxNPJgZiC7Riqc/H3IKP+aq5x3dXdHWNQRvXvEcLW22UNgU1FQgLbA
	 IvprcbpA/iULRKCHZCo/xnmu8d+fg+0QQ/7oEa6G3MaDxOtib0oyyqNlrnBcTIWs0m
	 QviuKFpswNWwGId8PgJy74O8tR6Rm/QUkTmyvtvQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240801120058eucas1p2b6bdd16c5407aaf3ca9791ba09b11210~nmQu0NkeI2791827918eucas1p2o;
	Thu,  1 Aug 2024 12:00:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id B7.E2.09875.9F87BA66; Thu,  1
	Aug 2024 13:00:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240801120057eucas1p18ac6d3634881e66f089eede5b2a3439f~nmQucMjJ42297922979eucas1p12;
	Thu,  1 Aug 2024 12:00:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240801120057eusmtrp26424c3b0a67c3261bacbd96cd6f5331c~nmQubYLUt1706517065eusmtrp2m;
	Thu,  1 Aug 2024 12:00:57 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-ec-66ab78f9870f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E6.F5.09010.9F87BA66; Thu,  1
	Aug 2024 13:00:57 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240801120057eusmtip1915f2fa26dd4e9f73f5478c4bee8dc38~nmQt-oE3q2547325473eusmtip1m;
	Thu,  1 Aug 2024 12:00:57 +0000 (GMT)
Message-ID: <5895603b-945f-4b05-991c-76b590094354@samsung.com>
Date: Thu, 1 Aug 2024 14:00:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma-mapping: don't return errors from
 dma_set_seg_boundary
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240723000604.241443-3-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzned2fFavTDL5OsLRYufook8WvLxYW
	l3fNYbM4+OEJqwOLx5p5axg9Xmyeyeix+2YDm8fnTXIBLFFcNimpOZllqUX6dglcGSuW3GAv
	mMNb8WPJL+YGxpdcXYycHBICJhJrLn9h62Lk4hASWMEo0Xj8BQuE84VRYteBtSwgVUICnxkl
	2o/bw3TsvHEKqmg5o8S0+13sEM5HRokPL3ewg1TxCthJTF/6mhHEZhFQkdj7dQMrRFxQ4uTM
	J2BTRQXkJe7fmgFUz8EhLBAqcfiNEUhYRMBdYlnvMbByZgFziaPTjzND2OISt57MZwKx2QQM
	JbredrGB2JxA9pW7cxghauQltr+dwwxyj4TAHg6JSx+PMkFc7SLRdfMQlC0s8er4FnYIW0bi
	/06QoSAN7YwSC37fh3ImMEo0PL/FCFFlLXHn3C82kEuZBTQl1u/Shwg7SjReu8AKEpYQ4JO4
	8VYQ4gg+iUnbpjNDhHklOtqEIKrVJGYdXwe39uCFS8wTGJVmIYXKLCRvzkLyziyEvQsYWVYx
	iqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJpbT/45/2cG4/NVHvUOMTByMhxglOJiVRHiF
	Tq5ME+JNSaysSi3Kjy8qzUktPsQozcGiJM6rmiKfKiSQnliSmp2aWpBaBJNl4uCUamBivrKj
	zc/iw37Ty8uSF3M3GM24dd2kl/mc5Mosg/ezu48J6xqtkzrCf/epirNc9tU+k7yXZ7ztJvaw
	LuhIZo0+Eb47andFkuhyZY6JE8wltxRkpZ85+yp0/ivXvFSn5WJxcsWKixgX+Vboe9v1XXU+
	djxz4Z0z6xpMW+pmrTxwcI7//aSNP118JFT0hfepH1n0z+zFD/u7dzc9OMfmrNojvmfpoiPK
	vIeDxLduOC6d5bP69aFzU85+luj7kmHsvev5S75rRy6Lr2Z1uN7Z9y8iexbzoYcuh7tdVl5Z
	sOy82UHj6XN4FnUIv97oMmfp+beaE9i58rMez4yyOmW8/+Gl1EZPpdhbQdW/6rKTLxtdVGIp
	zkg01GIuKk4EAD2HAN2bAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7o/K1anGczfKG+xcvVRJotfXyws
	Lu+aw2Zx8MMTVgcWjzXz1jB6vNg8k9Fj980GNo/Pm+QCWKL0bIryS0tSFTLyi0tslaINLYz0
	DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MlYsucFeMIe34seSX8wNjC+5uhg5OSQE
	TCR23jjF0sXIxSEksJRRonf9LCaIhIzEyWkNrBC2sMSfa11sEEXvGSVe7TzNApLgFbCTmL70
	NSOIzSKgIrH36wZWiLigxMmZT8BqRAXkJe7fmsHexcjBISwQKnH4jRFIWETAXWJZ7zGwcmYB
	c4mj048zQ8xfzSjxbes5FoiEuMStJ/PBDmITMJToegtyBCcHJ5B95e4cRogaM4murV1QtrzE
	9rdzmCcwCs1CcsYsJKNmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMBY2nbs
	55YdjCtffdQ7xMjEwXiIUYKDWUmEV+jkyjQh3pTEyqrUovz4otKc1OJDjKbAsJjILCWanA+M
	5rySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqb9HC/qStYz8DdL
	SW/aZ7C/T/38u/nc6+UWthhOdC885fBaXXpF+HObiDL/S9NnlWl+Yjh4MzD/JP9nkxoe1fPM
	J6XPnNSJcC1RnFK3cnuXnFzS+qexkfuOB7bv1U6vMK9c9Srl9HILvd46w7JdrB5qnv6d/1bv
	DLFbHSL/OEvfPuyZks+POqlJG+oKbr9YmHTJ7PiL47vs3HRuvD341E9OeeYD4/gF4kkpsccP
	Hz4TeX4z/4XMZxLtllzlVx0933Ku12Tc1L3qSLFekvjtrzeu/omtXPvy+TLrPeU/lvdEXpY2
	SGgKjs0U72FN+rD+6bHoJxMDcltEao5Gixv+lrp5X2pVFlfpoR/aQQWOC5VYijMSDbWYi4oT
	Af3I0bMuAwAA
X-CMS-MailID: 20240801120057eucas1p18ac6d3634881e66f089eede5b2a3439f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240723000611eucas1p10986fd51e848a1ee948e71608c26192b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240723000611eucas1p10986fd51e848a1ee948e71608c26192b
References: <20240723000604.241443-1-hch@lst.de>
	<CGME20240723000611eucas1p10986fd51e848a1ee948e71608c26192b@eucas1p1.samsung.com>
	<20240723000604.241443-3-hch@lst.de>

On 23.07.2024 02:05, Christoph Hellwig wrote:
> If dev->dma_parms is not allocate that indicates a grave bug in the
> implementation of a DMA-capable bus.  There isn't much the driver can
> do in terms of error handling, so just warn and continue as DMA
> operations will fail anyway.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

What about devices on platform or usb bus and subsystems calling this 
unconditionally, like scsi_init_limits()? With today's linux-next I got 
a bunch of warnings from this call for various USB storage devices. 
Before this patch, the errors from dma_set_seg_boundary() were silently 
ignored.

> ---
>   include/linux/dma-mapping.h | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index cfd6bafec3f944..6bd1333dbacb9b 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -559,13 +559,11 @@ static inline unsigned long dma_get_seg_boundary_nr_pages(struct device *dev,
>   	return (dma_get_seg_boundary(dev) >> page_shift) + 1;
>   }
>   
> -static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
> +static inline void dma_set_seg_boundary(struct device *dev, unsigned long mask)
>   {
> -	if (dev->dma_parms) {
> -		dev->dma_parms->segment_boundary_mask = mask;
> -		return 0;
> -	}
> -	return -EIO;
> +	if (WARN_ON_ONCE(!dev->dma_parms))
> +		return;
> +	dev->dma_parms->segment_boundary_mask = mask;
>   }
>   
>   static inline unsigned int dma_get_min_align_mask(struct device *dev)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


