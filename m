Return-Path: <linux-kernel+bounces-228289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F05915DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10FEAB20C56
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4304313C823;
	Tue, 25 Jun 2024 04:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLOu6b8O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C20135A7F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290308; cv=none; b=OIQ/SUS2fDT7qxbJwiJoygPMq7e88cqdMoIIKn0z4aD2nT4TcIjouVARJe1FtOgZqd8tlYGOh2oZOgGnlrnquOe1q/KGMBb01VDd34PHzJqUdfZS4Yd5JXejE2sr+bOUlmGGy4Klmd1b47OoaHMmOL/99x/OfAxeWL5goajdFuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290308; c=relaxed/simple;
	bh=EGZvQJESo6gryhKMWkPpgTasuq63w/uSx/WXHZYgYyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BE3deIXBGhCkWajb6ErRaIAXovCU1G1ANTjjQDm9NvyiIhJ5p6rNBjJPsx3xBCe1189ALnlA92z9ATMVbfjxQXNIeveaqWqTSgjq/h32cl6sNXy33asO11/CCk6DUGuYa4wO0NksxX766GOcZxxH9vidBKXG4EfT8V8FQA5amQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLOu6b8O; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719290305; x=1750826305;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=EGZvQJESo6gryhKMWkPpgTasuq63w/uSx/WXHZYgYyE=;
  b=iLOu6b8OscV/eEXqPJQ7FAIYmBDv4n+ibH0z2/23I7N8POgDxwrirT7w
   Ca67KJVVYSPY3t2gMFKVpTlBxBFGs5O8enBXUrQl529zlGUgAQQ4hH9IO
   Am16NhvkzB4xxXOqCyXxX9r4bz+sLWIJwdlLW9zsL5ah0GATfutOdGBCX
   mO3378452R2wSM0hORE5C9KOaDDw2g97zE1zyH6rzz2XphiEvtFbebn88
   J1kyu/KI2MTrLnZ6VyOgMASlYYbu5KeSOY8LgV2PlkZD/dSCsvTWuTln4
   n7j5VaVaQiXCV4VSzG2MsXGOMZqhMUgX7KwlKxk8/v3i07gIjIWjeE4pk
   w==;
X-CSE-ConnectionGUID: D06o0grQRSeJobmdNSFapw==
X-CSE-MsgGUID: 3TLIuvxnTnCa/39RUBqk2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33743754"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="33743754"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 21:38:25 -0700
X-CSE-ConnectionGUID: 8+m6qDnkSV6zvLGkQT/UeA==
X-CSE-MsgGUID: iGfM5Oo1QHeuyLNM8PJY/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="47954618"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 21:38:25 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: =?utf-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm
 <linux-mm@kvack.org>,  linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOg==?= Re: [PATCH] migrate_pages: modify max
 number of pages to
 migrate in batch
In-Reply-To: <7ii375j23j-7ikn2sd5r4@nsmail7.0.0--kylin--1> (=?utf-8?B?Ig==?=
 =?utf-8?B?5p2O55yf6IO9Iidz?= message
	of "Tue, 25 Jun 2024 11:33:54 +0800")
References: <7ii375j23j-7ikn2sd5r4@nsmail7.0.0--kylin--1>
Date: Tue, 25 Jun 2024 12:36:32 +0800
Message-ID: <87zfr9y6y7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=E6=9D=8E=E7=9C=9F=E8=83=BD <lizhenneng@kylinos.cn> writes:

> ----
>
>=20=20
>
>=20=20
>
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [PATCH] migrate_pages: modify max=
 number of pages to migrate in batch=20
> =E6=97=A5=E3=80=80=E6=9C=9F=EF=BC=9A2024-06-25 09:17=20
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Aying.huang=20
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=9D=8E=E7=9C=9F=E8=83=BD;
>
> Hi, Zhenneng,
>
> Zhenneng Li writes:
>
>> We restrict the number of pages to be migrated to no more than
>> HPAGE_PMD_NR or NR_MAX_BATCHED_MIGRATION, but in fact, the
>> number of pages to be migrated may reach 2*HPAGE_PMD_NR-1 or 2
>> *NR_MAX_BATCHED_MIGRATION-1, it's not in inconsistent with the context.
>
> Yes. It's not HPAGE_PMD_NR exactly.
>
>> Please refer to the patch: 42012e0436d4(migrate_pages: restrict number
>> of pages to migrate in batch)
>>
>> Signed-off-by: Zhenneng Li=20
>> ---
>> mm/migrate.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 781979567f64..7a4b37aac9e8 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1961,7 +1961,7 @@ int migrate_pages(struct list_head *from, new_foli=
o_t get_new_folio,
>> break;
>> }
>> if (nr_pages >=3D NR_MAX_BATCHED_MIGRATION)
>> - list_cut_before(&folios, from, &folio2->lru);
>> + list_cut_before(&folios, from, &folio->lru);
>
> If the first entry of the list "from" is a THP with size HPAGE_PMD_NR,
> "folio" will be the first entry of from, so that "folios" will be empty.
> Right?
>=20=20
> Yes, It's right, so we can check whether it is the first entry of the lis=
t "from", new patch are as follows(attachment is
> patch file):
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 781979567f64..cce8e2b85e89 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1957,11 +1957,12 @@ int migrate_pages(struct list_head *from, new_fol=
io_t get_new_folio,
> }
>
> nr_pages +=3D folio_nr_pages(folio);
> - if (nr_pages >=3D NR_MAX_BATCHED_MIGRATION)
> + if ((nr_pages >=3D NR_MAX_BATCHED_MIGRATION) &&
> + (!list_first_entry(from, struct folio, lru)))
> break;
> }
> if (nr_pages >=3D NR_MAX_BATCHED_MIGRATION)
> - list_cut_before(&folios, from, &folio2->lru);
> + list_cut_before(&folios, from, &folio->lru);
> else
> list_splice_init(from, &folios);
> if (mode =3D=3D MIGRATE_ASYNC)
>

I don't think that it's necessary to change this.  Yes, the max batch
number of the page migration may be 2*HPAGE_PMD_NR-1.  Does it cause any
latency issue for you?

>
>> else
>> list_splice_init(from, &folios);
>> if (mode =3D=3D MIGRATE_ASYNC)

--
Best Regards,
Huang, Ying

