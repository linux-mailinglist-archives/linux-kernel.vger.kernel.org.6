Return-Path: <linux-kernel+bounces-248592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE78092DF69
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18901C2140E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B295A110;
	Thu, 11 Jul 2024 05:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jP/aHPb4"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55E1C3D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675562; cv=none; b=efF4FMS1JEeGeenLGE3LawLQsILsHmfO1uIeODuQHUt3rHJqCxsnN7l6uF5xVdOvRsYYO+Drz8n1oM3Qidz7SNa0RTN+z80ZwCQIcxoT30n/Y66q9GhlFJQK98vn8ncop7MogwHc4ikruq1HlZuInuog7XcajzgQlJ/8/CuDa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675562; c=relaxed/simple;
	bh=QrG6QX4SYngEj+BhzmIkD3hsK1M5pDpt0Q2rr1pJcpI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Y/TMy2r74XDL0yeCgbZ2SvE60CCwbQaQPDcATzpTZf5OgNMT0kHim7+GprjfyDRQrIu+6oO79xyWZP1bgSeiXP1+6aQyRl/RkgT8HleGOgh3dFnCEN1MBczlfZ/eIuyuCjq9gfQSCgofYKfxqkmAx3J49o1HWzM2AmbesLbebPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jP/aHPb4; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240711052557epoutp0441ef726ed226c1f4fcd7ff31c7b91da4~hEU2CdsQn1666416664epoutp04-
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:25:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240711052557epoutp0441ef726ed226c1f4fcd7ff31c7b91da4~hEU2CdsQn1666416664epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720675557;
	bh=47qwGYFiW4KnEVF6xAAGa2SWr3EReswlU/tDHImZ5PA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=jP/aHPb4F6KMIj22jb8QKzmISdcj9GbilbnSEdcDceR8F0b6Gs1HszsiqeWb63/7K
	 Z4wKi/hFpb0nm3RpvHl5peOKYwMJqgrOieOrjrPShQwreahYyO7RAeGpcQH8vNuqn3
	 y/A7GP5iuL3Z3X+TiGQDpvOoPI8LCFF3+y+4Ydik=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240711052555epcas1p304ae0d9346be4ae674f93b73cd622b46~hEU035iQD1972019720epcas1p39;
	Thu, 11 Jul 2024 05:25:55 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.234]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WKNVV3jrPz4x9QB; Thu, 11 Jul
	2024 05:25:54 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	42.1F.09561.2EC6F866; Thu, 11 Jul 2024 14:25:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240711052553epcas1p2b1ba57b6552ef0b5e8fcf866de32d20e~hEUyz0qw_2900829008epcas1p2F;
	Thu, 11 Jul 2024 05:25:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240711052553epsmtrp298de9a77ac9b4dda35ac1dd24df70ebd~hEUyzHEId2207222072epsmtrp2h;
	Thu, 11 Jul 2024 05:25:53 +0000 (GMT)
X-AuditID: b6c32a39-b63ff70000002559-af-668f6ce21d84
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	34.07.07412.1EC6F866; Thu, 11 Jul 2024 14:25:53 +0900 (KST)
Received: from sfoonkim02 (unknown [10.113.222.42]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240711052553epsmtip17fd478f6506d4aa0d149b71aaeb8d539~hEUykx7Yo0829308293epsmtip1i;
	Thu, 11 Jul 2024 05:25:53 +0000 (GMT)
From: "Sung-hun Kim" <sfoon.kim@samsung.com>
To: "'Andrew Morton'" <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<sungguk.na@samsung.com>, <sw0312.kim@samsung.com>, <sebuns@gmail.com>,
	"'Stefan	Roesch'" <shr@devkernel.io>
In-Reply-To: <20240620134752.9a63c12403282c0c7e728764@linux-foundation.org>
Subject: RE: [PATCH v2] mm: ksm: Consider the number of ksm_mm_slot in the
 general_profit calculation
Date: Thu, 11 Jul 2024 14:25:53 +0900
Message-ID: <0fe601dad352$cca07de0$65e179a0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGcuK2mUct4l8vOyf6OuFEls7CcWwIwXU5MAt0bt+WyRMcJsA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmnu6jnP40gzNNUhZz1q9hs7i8aw6b
	xb01/1ktmi+8ZLRY0bOe0WLHvIOMFjMmv2RzYPf40vyXyWPnrLvsHps+TWL3ODHjN4tH35ZV
	jB6fN8kFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
	ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAt0CtOzC0uzUvXy0stsTI0
	MDAyBSpMyM74eruPvWA5V8X9c/+ZGhincHQxcnJICJhIfD77hrWLkYtDSGAHo8Snqe2MEM4n
	RonjE3YwgVQJCXxjlLjxsR6mY92P2ewQRXsZJToWnoVyXjBKbNjxGayDTUBHYtmPVcwgtoiA
	ocS9PefBipgFVjFKvL3SywiS4BTwluj+MhOsSFggXWLh9m3sIDaLgKrE9beNrCA2r4ClxMSm
	DWwQtqDEyZlPWEBsZgF5ie1v5zBDnKQg8fPpMlaIZU4Sh3atYIeoEZGY3dnGDLJYQmAuh8T1
	9lksEA0uEgef34BqFpZ4dXwLO4QtJfH53V6gZRxAdrXE1OfcEL0tjBL/Xu5nhagxlti/dDIT
	SA2zgKbE+l36ELv4JN597WGFaOWV6GgTgqhWlnh8sBlqq6TE133XmSBsD4mm39uZJjAqzkLy
	2Swkn81C8sEshGULGFlWMYqlFhTnpqcWGxaYwmM7OT93EyM4nWpZ7mCc/vaD3iFGJg7GQ4wS
	HMxKIrzzb3SnCfGmJFZWpRblxxeV5qQWH2I0BYb1RGYp0eR8YELPK4k3NLE0MDEzMjaxMDQz
	VBLnPXOlLFVIID2xJDU7NbUgtQimj4mDU6qBqXKh0nyD1tT+x4w7JNhTHG8c2LBG75J9dvmN
	5PDOXYv2Xn8XI2V8Sj/j9fr2h/N8Am+1KC6Re3PtzZKNT1sXv8hcsdOwakbYDNkjjgvm9G1I
	kO7pk7DJfuB9/YSB9tSfvKlbXj++OE3m2sND52srO+a9uKas+lTnudCJI79aNLRrbTfyfEmt
	/ZLM80Ijs3xh3K5D6xYt4HbPqjnhOqexxd821umver2Cc2PqnW3zityc5zGFTr+4fbvJRR5m
	jxMz9RbK3t+8qP/cXg2ht0aPPsY+XDrFLuvjVWfRTfX/lz6xPHBRxmjRR2a+tWaJ/1/JlHEe
	C2b8GvH0ELNO/e/LW6IZv3kxqHJvLNV/sGj13VIlluKMREMt5qLiRACOoMK6MAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJTvdhTn+awYOdGhZz1q9hs7i8aw6b
	xb01/1ktmi+8ZLRY0bOe0WLHvIOMFjMmv2RzYPf40vyXyWPnrLvsHps+TWL3ODHjN4tH35ZV
	jB6fN8kFsEVx2aSk5mSWpRbp2yVwZXy93cdesJyr4v65/0wNjFM4uhg5OSQETCTW/ZjN3sXI
	xSEksJtR4snjhcwQCUmJOesWMHYxcgDZwhKHDxdD1DxjlFg9/yRYDZuAjsSyH6vAbBEBQ4l7
	e86zg9jMAhsYJdo310E0nGGU2HD2BBNIglPAW6L7y0xmkKHCAqkS1yd7goRZBFQlrr9tZAWx
	eQUsJSY2bWCDsAUlTs58wgJSziygJ9G2kRFivLzE9rdzoM5UkPj5dBkrxAlOEod2rYA6QURi
	dmcb8wRG4VlIJs1CmDQLyaRZSDoWMLKsYpRMLSjOTc9NNiwwzEst1ytOzC0uzUvXS87P3cQI
	jiktjR2M9+b/0zvEyMTBeIhRgoNZSYR3/o3uNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8hjNm
	pwgJpCeWpGanphakFsFkmTg4pRqYJlfOWxP95I9SXu2ju7f/z11y1SQ5NOQcg4zfzFnuX9yk
	OxWuS3f6nC7S/iW6JOxpuWsuf0zQseRt/1adEfu5YeL+gMd3i1UUbux4zVK2r9H37cH1V7UW
	GPHs2hfepfppr8t0xuZ3VVf2tnmYNpRk9TFvtnymFldy42+jb49d9PubeYkn/iTpGdaGa7Ws
	3bIwbXLsogcpjAEXmUMZklVcqpW4vF9sdZPdrfNyhUDRvkvxLZJ9edvXO+8patmdET9ZJan8
	2IT52868f1ZfNsUt6KtVTwubqp4i4y2VWT2sMTb/TLaY3fx5eTGvzIx2rlsrDjpq1a6JNV7k
	ZOnBp5fhx38zcS/31n3pT5ye7gtXYinOSDTUYi4qTgQAoVzStxgDAAA=
X-CMS-MailID: 20240711052553epcas1p2b1ba57b6552ef0b5e8fcf866de32d20e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244
References: <CGME20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244@epcas1p1.samsung.com>
	<20240620043914.249768-1-sfoon.kim@samsung.com>
	<20240620134752.9a63c12403282c0c7e728764@linux-foundation.org>

> 
> On Thu, 20 Jun 2024 13:39:14 +0900 Sung-hun Kim <sfoon.kim@samsung.com> wrote:
> 
> > The current version of KSM does not take into account the number of
> > used ksm_mm_slot. Therefore, when users want to obtain profits of KSM,
> > KSM omits the memory used for allocating ksm_mm_slots.
> >
> > This patch introduces a new variable to keep track of the number of
> > allocated ksm_mm_slots. By doing so, KSM will be able to provide a
> > more accurate number of the gains made.
> >
> 
> By how much does the improve the accuracy?  In other words, how much difference does this make?
> 

I think it makes only small difference. (few kilobytes for hundreds of processes)


> > @@ -3672,7 +3680,8 @@ static ssize_t general_profit_show(struct kobject *kobj,
> >  	long general_profit;
> >
> >  	general_profit = (ksm_pages_sharing + atomic_long_read(&ksm_zero_pages)) * PAGE_SIZE -
> > -				ksm_rmap_items * sizeof(struct ksm_rmap_item);
> > +				ksm_rmap_items * sizeof(struct ksm_rmap_item) -
> > +				atomic_long_read(&ksm_mm_slots) * sizeof(struct ksm_mm_slot);
> >
> >  	return sysfs_emit(buf, "%ld\n", general_profit);
> 
> This assumes perfect slab packing, no?   Should it use ksize()?

Ah, thanks for your recommendation. It should be fixed.


Best regards,
Sung-hun Kim


