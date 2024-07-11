Return-Path: <linux-kernel+bounces-248626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D503E92DFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048831C21426
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B7E82D68;
	Thu, 11 Jul 2024 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lKYxVgN/"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD40824B1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720678238; cv=none; b=OTqvZBqAqvToDRh6SCdFOfwQ+PUjev9MdorSk/uwyLPZRwEC+Kc9q0bJw4IOU4mfAqVtLrwE4i+cgzHIq2N+SczhsciWD3GPVkb77lTxqzMYoZ85M8Uw9VnJswKkYjT8jG2ojNYBHXQSw/TuEI6pbXdIiAfJy/ojnf0JjTVYhlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720678238; c=relaxed/simple;
	bh=NFcPF7cszQID+chKYHNaTPZrfL8AE62lG/dtTI1BBwE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=UQbzgxp/xElFj4V2nP8WMiPc8VkZ4Q20MT5LEldY+IdnrisFkKsFPSgBpFPGZOKl1fEdOZbLBWo9N9J8WAORAossji0dWCLzYVgcOfPiN1BfrMYzuqdNoo6QPN30AYW5ZWWzwxV62F2qhh/mnf/kb8EhePFwPdYov45Ud0cqhEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lKYxVgN/; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240711061033epoutp04907d658afc4b3a115e1be7243bae5f6f~hE7yRD_ol3044630446epoutp04Q
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:10:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240711061033epoutp04907d658afc4b3a115e1be7243bae5f6f~hE7yRD_ol3044630446epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720678233;
	bh=LBHZqqdhoRlrj5cqadLXf9+CXx2D7o7g6vvEoWJ4zqQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=lKYxVgN/bgdOzvzfYL+j9zl+Ws+PO72a7HTZdv0yle96OBFw2pIzEapOm6IGDcaKj
	 aTkbQhnehYhxPLoTpG7RozJFMQKHKIZt7cEvLA6QGxq/SRFRwBnVVO8qZLRQ3uau/O
	 ncxN1WByEXZO0plWHF49065wJvLxToCc7ILOAOKo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240711061032epcas1p42d405bbb54b044b581e4b204fb07555b~hE7x7p2Xr0217802178epcas1p4K;
	Thu, 11 Jul 2024 06:10:32 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.235]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WKPTz6L3Rz4x9Q5; Thu, 11 Jul
	2024 06:10:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	69.37.34823.7577F866; Thu, 11 Jul 2024 15:10:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240711061031epcas1p440ca44c1b22b425482063ea641dc8d93~hE7wrMEoD0053600536epcas1p4K;
	Thu, 11 Jul 2024 06:10:31 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240711061031epsmtrp2e67613cac152ab19bea258d67d20add4~hE7wqerNG1608016080epsmtrp2g;
	Thu, 11 Jul 2024 06:10:31 +0000 (GMT)
X-AuditID: b6c32a35-e8dff70000018807-6f-668f7757e9fa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.2D.07412.7577F866; Thu, 11 Jul 2024 15:10:31 +0900 (KST)
Received: from sfoonkim02 (unknown [10.113.222.42]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240711061031epsmtip172c00644b3059d1410c8aab6f804c4b0~hE7wdyg3Y0362903629epsmtip1o;
	Thu, 11 Jul 2024 06:10:31 +0000 (GMT)
From: "Sung-hun Kim" <sfoon.kim@samsung.com>
To: "'Andrew Morton'" <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<sungguk.na@samsung.com>, <sw0312.kim@samsung.com>, <sebuns@gmail.com>,
	"'Stefan	Roesch'" <shr@devkernel.io>, <sfoon.kim@samsung.com>
In-Reply-To: 
Subject: RE: [PATCH v2] mm: ksm: Consider the number of ksm_mm_slot in the
 general_profit calculation
Date: Thu, 11 Jul 2024 15:10:31 +0900
Message-ID: <0ff401dad359$08b54b20$1a1fe160$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGcuK2mUct4l8vOyf6OuFEls7CcWwIwXU5MAt0bt+WyRMcJsIAACuUQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmnm54eX+aQfMffYs569ewWVzeNYfN
	4t6a/6wWzRdeMlo0TlvObrGiZz2jxY55BxktZkx+yebA4fGl+S+Tx85Zd9k9Nn2axO5xYsZv
	Fo++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
	cvEJ0HXLzAE6SEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFqgV5yYW1yal66X
	l1piZWhgYGQKVJiQnbFi+22Wgpe8FRuXnmZuYPzE1cXIySEhYCJxcPd8FhBbSGAHo8SjeTJd
	jFxA9idGiae7V7BCON8YJZZfes4K07Hn0ksWiMReRok1fxczQjgvGCVutP9nA6liE9CRWPZj
	FTOILSJgKHFvz3l2kCJmgcOMEh83gYzi4OAU4JWY8M8apEZYIF1i4fZt7CA2i4CqxKRDO8Bu
	4hWwlLi6/TorhC0ocXLmE7A4s4C8xPa3c5ghLlKQ+Pl0GSvELjeJ13MmsELUiEjM7mxjBtkr
	IbCSQ6L9VjcbRIOLxNq185kgbGGJV8e3sEPYUhKf3+1lA7lNQqBaYupzbojeFkaJfy/3Q71v
	LLF/6WQmkBpmAU2J9bv0IXbxSbz72sMK0cor0dEmBFGtLPH4YDMLhC0p8XXfdaitHhJNv7cz
	TWBUnIXks1lIPpuF5INZCMsWMLKsYhRLLSjOTU8tNiwwhEd2cn7uJkZwWtUy3cE48e0HvUOM
	TByMhxglOJiVRHjn3+hOE+JNSaysSi3Kjy8qzUktPsRoCgzricxSosn5wMSeVxJvaGJpYGJm
	ZGxiYWhmqCTOe+ZKWaqQQHpiSWp2ampBahFMHxMHp1QDU/tnlnezWfKydkzr/yrDt+7wi4Ws
	PVFKpe0rWfI3ONlw+evZH9DJ+6hQ9cbzBGdshIZF5dPpOTNTvvJFHUi8lb9/VapcqHLfq/V3
	99oJhpX8NlkWtEfcXzZaPHbezQvVB4vNzrF2LzKXniH6StPWub1Brj3w7D4nkzb2+VkrnyWW
	XUv8F+Qdbn+grFXKqf/zje6JhxlyGy7U2N15s8X7hdTry5NNFm5YKbDTXkJE6Wbunl3xP/7/
	XemRdiBdL4WtXuB8fVY31wFFVZ66Etel5SpZgqdV6zL81oQvm88jyXpGzzTt2ovg1Q0n9Nav
	neX98sD5v+vUlQp7882naoYkXcu5ERvWdtzsR2r2ckslluKMREMt5qLiRABs0+wNNAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJTje8vD/N4NU3KYs569ewWVzeNYfN
	4t6a/6wWzRdeMlo0TlvObrGiZz2jxY55BxktZkx+yebA4fGl+S+Tx85Zd9k9Nn2axO5xYsZv
	Fo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKWLH9NkvBS96KjUtPMzcwfuLqYuTkkBAwkdhz
	6SVLFyMXh5DAbkaJLz9XsUEkJCXmrFvA2MXIAWQLSxw+XAwSFhJ4xijxcmUiiM0moCOx7Mcq
	ZhBbRMBQ4t6e8+wg5cwCpxklrshCjDzLKPF53zM2kDinAK/EhH/WIKawQKrE9cmeIJ0sAqoS
	kw7tYAGxeQUsJa5uv84KYQtKnJz5hAViop5E20ZGkDCzgLzE9rdzmCFuVJD4+XQZK8QBbhKv
	50xghagRkZjd2cY8gVF4FpJJsxAmzUIyaRaSjgWMLKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz
	0vWS83M3MYLjSktjB+O9+f/0DjEycTAeYpTgYFYS4Z1/oztNiDclsbIqtSg/vqg0J7X4EKM0
	B4uSOK/hjNkpQgLpiSWp2ampBalFMFkmDk6pBibDpDPKZWZV8W1P2jOvfrdZGNze7Wu581zd
	pObgQxw2t9omapuzfioL8PV8WGjVenr7guMPPJ/cvPixeOqq81/KFUzEl7kvLnibFqO+Idtm
	rdJV7pBjN/zO/zH+07U6S0Nh/r98/8Xv45xPCbUw/duSv277nssNjB1aDWktXudnb1b+c9Im
	zumx0nIrYcb5Tg/LGSWYJjG84eRuPBPZUt1bE1egOb1Ne6qLh8M9tQDuUtmvU6a/5f/kv/pG
	Y3XMiwdJ80pdvrefzj+49UyB0vSypbFJh/hXV3CsmGk9KSj99Pwly1hlE8LrJHxuOMgbHHtT
	bT27JnvS0cd/Pp2Sd06dPVuv7PSLjN47hv3L9ymxFGckGmoxFxUnAgDv53TMGgMAAA==
X-CMS-MailID: 20240711061031epcas1p440ca44c1b22b425482063ea641dc8d93
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244
References: <CGME20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244@epcas1p1.samsung.com>
	<20240620043914.249768-1-sfoon.kim@samsung.com>
	<20240620134752.9a63c12403282c0c7e728764@linux-foundation.org> 

> > On Thu, 20 Jun 2024 13:39:14 +0900 Sung-hun Kim <sfoon.kim@samsung.com> wrote:
> >
> > > The current version of KSM does not take into account the number of
> > > used ksm_mm_slot. Therefore, when users want to obtain profits of
> > > KSM, KSM omits the memory used for allocating ksm_mm_slots.
> > >
> > > This patch introduces a new variable to keep track of the number of
> > > allocated ksm_mm_slots. By doing so, KSM will be able to provide a
> > > more accurate number of the gains made.
> > >
> >
> > By how much does the improve the accuracy?  In other words, how much difference does this make?
> >
> 
> I think it makes only small difference. (few kilobytes for hundreds of processes)
> 
> 
> > > @@ -3672,7 +3680,8 @@ static ssize_t general_profit_show(struct kobject *kobj,
> > >  	long general_profit;
> > >
> > >  	general_profit = (ksm_pages_sharing + atomic_long_read(&ksm_zero_pages)) * PAGE_SIZE -
> > > -				ksm_rmap_items * sizeof(struct ksm_rmap_item);
> > > +				ksm_rmap_items * sizeof(struct ksm_rmap_item) -
> > > +				atomic_long_read(&ksm_mm_slots) * sizeof(struct ksm_mm_slot);
> > >
> > >  	return sysfs_emit(buf, "%ld\n", general_profit);
> >
> > This assumes perfect slab packing, no?   Should it use ksize()?
> 
> Ah, thanks for your recommendation. It should be fixed.
> 

I'm sorry. I found a mistake in my previous mail. I think ksize() does not fit in this context.

ksize() should be used for the allocated object. But the calculation just uses the number of
allocated ksm_mm_slots and sizeof() for the data structure like ksm_rmap_item.
The calculated profit is an approximation of real value because the object does not
be perfectly packed as you said.


Best regards,
Sung-hun Kim


