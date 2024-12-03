Return-Path: <linux-kernel+bounces-428967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788C29E1685
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D46E6B2F51F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CEF1C0DE2;
	Tue,  3 Dec 2024 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jCc12JLi"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01F156F45
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733214086; cv=none; b=lbZBgr9YJaY88TZYh/1OGf6tX1ADsL1KRoA5v1hnVqLwjaWS+6DNR574t1NiZENtXRQ+YBfAD32x5BkkVagS4NBD8jCfQs9koegCJwNjWzxl5mZR2W4YWmov5EjkQ4XW/gvpJFXxSi69tb1R/SF8l3gwOqUbkbANBIXP2VHqeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733214086; c=relaxed/simple;
	bh=uUbbwkJKS1ShWdWJZHzz5FVjh/063SZkcFvSReB1H6I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hOpWG5tNH1D1Q18NS3GnStsTDRkuEzIr0bhzT0IwPfH6I77rOaxI783az9P/Acti1g1WEEfDXno/RyNIqeyrkow/65JZ43StnhELQxVGV3dt8ayBlLGc1rO4Rw0GVVQ09HjaZPM9BAiCeDwLnaNySKmgxtXHQUZG9rHTqGULn80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jCc12JLi; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733214076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MyB1FtEs1wS782QrJMZLEc0bIHq1bVJJUh447GB5OD4=;
	b=jCc12JLi+cyX3ScPSdCjHHorUnaPzxF1KYMZQ7lxBAdosoxtkV6LAfSzXKwpY1T6H+p4u+
	ra/OLW5BZuWxjg+TFrv2JlpRcU/SQHkOmw/CCALDB3WT3cDbbULK/R+iEtQtoalziuxwBF
	neV3uQKwRFbswdmhH8e8bfrZPcXe3Bo=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH V2] mm/hugetlb: Make __NR_USED_SUBPAGE check conditional
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <3733d1e8-6e9d-4337-aeda-a6d5366d4a4c@arm.com>
Date: Tue, 3 Dec 2024 16:20:38 +0800
Cc: linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C1A9184-7432-45CB-89E4-D0A62C992C76@linux.dev>
References: <20241203023207.123416-1-anshuman.khandual@arm.com>
 <A9973D39-9840-40F2-91DA-1CA8ADC06AA1@linux.dev>
 <3733d1e8-6e9d-4337-aeda-a6d5366d4a4c@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
X-Migadu-Flow: FLOW_OUT



> On Dec 3, 2024, at 15:46, Anshuman Khandual =
<anshuman.khandual@arm.com> wrote:
>=20
>=20
> On 12/3/24 08:59, Muchun Song wrote:
>>=20
>>=20
>>> On Dec 3, 2024, at 10:32, Anshuman Khandual =
<anshuman.khandual@arm.com> wrote:
>>>=20
>>> The HugeTLB order check against __NR_USED_SUBPAGE is required only =
when
>>> HUGETLB_PAGE_OPTIMIZE_VMEMMAP is enabled. Hence BUG_ON() trigger =
should
>>> happen only when applicable.
>>>=20
>>> Cc: Muchun Song <muchun.song@linux.dev>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> This patch applies on v6.13-rc1
>>>=20
>>> Changes in V2:
>>>=20
>>> - Fixed #ifdef with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP per Oscar
>>>=20
>>> Changes in V1:
>>>=20
>>> =
https://lore.kernel.org/all/20241202090728.78935-1-anshuman.khandual@arm.c=
om/
>>>=20
>>> mm/hugetlb.c | 6 ++++--
>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index ea2ed8e301ef..e6a5b21e3578 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -4513,11 +4513,13 @@ void __init hugetlb_add_hstate(unsigned int =
order)
>>> 	struct hstate *h;
>>> 	unsigned long i;
>>>=20
>>> - 	if (size_to_hstate(PAGE_SIZE << order)) {
>>> + 	if (size_to_hstate(PAGE_SIZE << order))
>>> 		return;
>>> - 	}
>>> +
>>> 	BUG_ON(hugetlb_max_hstate >=3D HUGE_MAX_HSTATE);
>>> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>>> 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
>>=20
>> Hi Anshuman,
>>=20
>> __NR_USED_SUBPAGE indicates how many struct pages are used to store
>> extra metadata for a HugeTLB page. So we need to make sure the order
>> of a HugeTLB page should be bigger than or equal to =
order_base_2(__NR_USED_SUBPAGE).
>> So It is not related to HVO. I don't think the changes make sense.
>=20
> I did think about that but order_base_2(__NR_USED_SUBPAGE) actually
> turns out to be just 2 as __NR_USED_SUBPAGE is 3. Would not HugeTLB
> size be always greater than four base pages in reality, thus making
> this BUG_ON() check just redundant ?

Currently, there is no architectures supporting hugetlb page smaller
than 4 base pages. I think the smallest size is 64KB in arm64, but who
knows whether if certain architectures supports 8KB in the future or
we want to uses more struct pages to store metadata for increasing
__NR_USED_SUBPAGE (e.g. change it to 17). So I tend to keep this
BUG_ON remain to catch unexpected bugs.

Thanks.

>=20
>>=20
>> Thanks.
>>=20
>>> +#endif
>>> h =3D &hstates[hugetlb_max_hstate++];
>>> __mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
>>> h->order =3D order;
>>> --=20
>>> 2.30.2
>>>=20
>>=20


