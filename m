Return-Path: <linux-kernel+bounces-172619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B391F8BF458
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2BA284240
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843079441;
	Wed,  8 May 2024 02:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JlbXxUzg"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46D79F9
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 02:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715134061; cv=none; b=BBf875gQbrWOn55TmMYquRwvZ/21a/aCkLQJUMJyXcQdj2qyRefVKR9V3DDo5YEFAUnvPiUX+OSysiV4tM+uFODdd49S2uhj+j9sL9g3A/gvQ5t9OYQYGaP7FgX8+E4NHUNLDWmjm0mV0w2+SF2Y0WfIfkCZ15Qw4/N5hYkr2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715134061; c=relaxed/simple;
	bh=gJyCwtiUtpIfDNg3y0G8s9EWAmNQtWMPrno2Nq9j8eA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=m7AVfouNU4rYcQULyqkOPsNPm3PbMGpDaVt7GrJf4pVjYt8xK0zBm1ZUk2j5nDiCHIjCLA4hF/OoQ24kjo04LwQTKAAq9wHKhXOXQjGUzBIZ2na32AEf38ECgibae0Xw8Dlzv2lqbGyyKj9G+GOXcD+FdtjiAvXKfjzlu+GXfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JlbXxUzg; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715134056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myhEc3khl50YDvFOAmyYij1qxZxNkPC/dutCYABfHhY=;
	b=JlbXxUzgjqqYTerWZS/GPmhGKjo52/oU15rnYqI5XqQhu7RoSrNjEgmrSjwUiPj8RpUq11
	3j9LEJCvi0RARl6KQIytc5AVg6kAssPFHKX1OzCSlfYSCs6fZP3ojpFAkyorkIGRCgdCKd
	A46X5sZKCjpdVu8V28W0q3PrLgg8YPc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 2/4] mm: memcg: merge multiple page_counters into a single structure
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <CABdmKX1NfkogiKQ4VGC8WoK4WLEG552QttNSUzLWRT46i2mQmw@mail.gmail.com>
Date: Tue, 7 May 2024 19:07:22 -0700
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Frank van der Linden <fvdl@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <C4D5522D-592F-4E55-AEFD-845D7165F89D@linux.dev>
References: <CABdmKX1NfkogiKQ4VGC8WoK4WLEG552QttNSUzLWRT46i2mQmw@mail.gmail.com>
To: "T.J. Mercier" <tjmercier@google.com>
X-Migadu-Flow: FLOW_OUT


> On May 7, 2024, at 5:26=E2=80=AFPM, T.J. Mercier <tjmercier@google.com> wr=
ote:
>=20
> =EF=BB=BFOn Fri, May 3, 2024 at 2:18=E2=80=AFPM Roman Gushchin <roman.gush=
chin@linux.dev> wrote:
>>=20
>>> On Fri, May 03, 2024 at 02:11:17PM -0700, Shakeel Butt wrote:
>>>> On Fri, May 03, 2024 at 01:18:33PM -0700, Roman Gushchin wrote:
>>> [...]
>>>> enum mem_counter_type {
>>>> +#ifdef CONFIG_MEMCG
>>>>    MCT_MEMORY,             /* cgroup v1 and v2 */
>>>>    MCT_SWAP,               /* cgroup v2 only */
>>>>    MCT_MEMSW =3D MCT_SWAP,   /* cgroup v1 only */
>>>>    MCT_KMEM,               /* cgroup v1 only */
>>>>    MCT_TCPMEM,             /* cgroup v1 only */
>>>> +#endif
>>>> +#ifdef CONFIG_CGROUP_HUGETLB
>>>> +   MCT_HUGETLB_MAX =3D __MCT_HUGETLB_MAX,
>>>> +#endif
>>>> +   __MCT_NR_ITEMS,
>>>> };
>>>>=20
>>>=20
>>> Thanks for the awesome work. I haven't gone through all the patches yet
>>> but wanted to ask a quick question. In the above enum are you trying to
>>> do a union between memcg and hugetlb? It gave me a big pause to
>>> understand what you are trying to do.
>>=20
>> Yep, sort of. So the page_counter structure supports N independent
>> counters, where N is sufficient enough for both memcg and hugetlb cases.
>>=20
>> MCT_MEMORY, MCT_SWAP etc are used directly in the memcontrol.c code,
>> while hugetlb code just indexes. MCT_HUGETLB_MAX magic is needed to defin=
e
>> N at the compile time.
>=20
> Where N is __MCT_NR_ITEMS for all the counter array lengths? That
> doesn't look like it works if MCT_HUGETLB_MAX is small... i.e. there
> is both CONFIG_MEMCG and CONFIG_CGROUP_HUGETLB and (__MCT_HUGETLB_MAX
> =3D 1 or 3) since MCT_HUGETLB_MAX would be < MCT_TCPMEM and then
> __MCT_NR_ITEMS would be wrong?
>=20
> If so, what about:
>=20
> enum mem_counter_type {
> #ifdef CONFIG_MEMCG
>    MCT_MEMORY, /* cgroup v1 and v2 */
>    MCT_SWAP, /* cgroup v2 only */
>    MCT_MEMSW =3D MCT_SWAP, /* cgroup v1 only */
>    MCT_KMEM, /* cgroup v1 only */
>    MCT_TCPMEM, /* cgroup v1 only */
> #endif
>    MCT_MEMCG_NR_ITEMS,
> #ifdef CONFIG_CGROUP_HUGETLB
>    MCT_HUGETLB_MAX =3D MCT_MEMCG_NR_ITEMS + __MCT_HUGETLB_MAX,
> #else
>    MCT_HUGETLB_MAX =3D 0,
> #endif
>    __MCT_NR_ITEMS =3D MAX(MCT_MEMCG_NR_ITEMS, MCT_HUGETLB_MAX)
> };

The page_counter structure is not shared between memory and hugetlb cgroups,=
 so N should be big enough to accommodate 4 memcg counters __or__ 2 * HUGE_M=
AX_STATE hugetlb counters. Your version has enough space for both.

Thanks!=

