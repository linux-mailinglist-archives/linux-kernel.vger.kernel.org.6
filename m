Return-Path: <linux-kernel+bounces-233276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD2491B51D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA2A1C21C0E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D62018633;
	Fri, 28 Jun 2024 02:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lYAsBF6v"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7716917BDC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719542181; cv=none; b=j2UGVs58RYT+GURRhkLfOZUMdcLNKyaCSngMTRAj4iRMZXlJuDAylUvxmsb35BuD8MgqjP39PdUJFxWK+p7iX4tKjVzNvUNtsEo4JwRyF6OSPmFClvVZ1C/QtmWMHI+3wD/8pftAQNZEOUg8ppU0ckb95CdP8QYQ0QXaebWv73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719542181; c=relaxed/simple;
	bh=odWNBzGpGpqwYnlv5D0E26+8eqkD01MuSbvssp3W8IQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BNjs0WQll67vcSkb7UfmGxBxb1PnnJOcWzxmHLhllpGZk824q6yqxq+JtNvhO/Z6+bc/Ahz8JtJhx6iDHYYgLDEUxaob7H/TH8WCcxBjzHbkVydlK/vILszpjmHEyyFPlCvb4kxcuaTY5m1QIivSYD3gJOHiz9w+t92OaJjfrdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lYAsBF6v; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yuzhao@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719542176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZ1H78Lr8pdLC8hgwNwXik7HRZRn/KcRuMAtuxdwQdk=;
	b=lYAsBF6v/GqCpcUGM2oxS51sOoC5pjJzP86e4RCeJzmj/KdeJViSI/OmQ2yqIDCCsYq5VG
	TP6Pzc8InAAaKbzofGUowMgEfhTGBjh8v0qzPdtZOi2jqMi+07ET8BNfOEuhHN21Kd1GVP
	Ok2urOve5UE0CYpb5Q0WYGUwr0XrIzA=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: david@redhat.com
X-Envelope-To: fvdl@google.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: peterx@redhat.com
X-Envelope-To: yang@os.amperecomputing.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH mm-unstable v2] mm/hugetlb_vmemmap: fix race with
 speculative PFN walkers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CAOUHufb4O7oCsGcH5VcSoAw5cUiwYjGCfvLBHPZgo-G=HtiLVw@mail.gmail.com>
Date: Fri, 28 Jun 2024 10:35:16 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Frank van der Linden <fvdl@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <38D49672-674B-43F8-AFD3-73BFD8876DCE@linux.dev>
References: <20240627222705.2974207-1-yuzhao@google.com>
 <20240627154721.69aea29609984bd5422afc97@linux-foundation.org>
 <CAOUHufb4O7oCsGcH5VcSoAw5cUiwYjGCfvLBHPZgo-G=HtiLVw@mail.gmail.com>
To: Yu Zhao <yuzhao@google.com>
X-Migadu-Flow: FLOW_OUT



> On Jun 28, 2024, at 07:04, Yu Zhao <yuzhao@google.com> wrote:
>=20
> On Thu, Jun 27, 2024 at 4:47=E2=80=AFPM Andrew Morton =
<akpm@linux-foundation.org> wrote:
>>=20
>> On Thu, 27 Jun 2024 16:27:05 -0600 Yu Zhao <yuzhao@google.com> wrote:
>>=20
>>> While investigating HVO for THPs [1], it turns out that speculative
>>> PFN walkers like compaction can race with vmemmap modifications, =
e.g.,
>>>=20
>>>  CPU 1 (vmemmap modifier)         CPU 2 (speculative PFN walker)
>>>  -------------------------------  ------------------------------
>>>  Allocates an LRU folio page1
>>>                                   Sees page1
>>>  Frees page1
>>>=20
>>>  Allocates a hugeTLB folio page2
>>>  (page1 being a tail of page2)
>>>=20
>>>  Updates vmemmap mapping page1
>>>                                   get_page_unless_zero(page1)
>>>=20
>>> Even though page1->_refcount is zero after HVO, =
get_page_unless_zero()
>>> can still try to modify this read-only field, resulting in a crash.
>>=20
>> Ah.  So we should backport this into earlier kernels, yes?
>>=20
>> Are we able to identify a Fixes: for this?  Looks difficult.
>>=20
>> This seems quite hard to trigger.  Do any particular userspace =
actions
>> invoke the race?
>=20
> Yes, *very* hard to trigger:
> 1. Most hugeTLB use cases I know of are static, i.e., reserved at boot
> time, because allocating at runtime is not reliable at all.
> 2. On top of that, someone has to be very unlucky to get tripped over
> above, because the race window is so small -- I wasn't able to trigger
> it with a stress testing that does nothing but that (with THPs
> though).
>=20
> So I don't think it's worth cc'ing stable, unless Muchun recommends.

I agree with Yu.

Thanks.


