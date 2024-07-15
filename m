Return-Path: <linux-kernel+bounces-251994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D8F930CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24231F21283
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E44B9474;
	Mon, 15 Jul 2024 02:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EhiVEr1s"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FABDDA6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721011295; cv=none; b=IvJ6YhcKj2qdYz9/yWK2WimzwWWhKvS/FfkEXCDRPXtip0k9dEMZkdLrrBt4YwYJ7DStu1NjX4AyxxUQqiH+tgR80I1c2va5Q0HsYRApkwrMpDv0xC1hB93u+0toCAPuZj89KkS1qmZCshncCAt+1kfW26raCOKhpv0wSidYHcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721011295; c=relaxed/simple;
	bh=snMf7HzH7J2dr+IDOBFDYmYluvIOXw6b/0NlGy93V+s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UPBAreDl68FzBum3Xjt51TU0hh9cT/U+hC5G6j3jGYnVaWXhnY6ONIFR2nEYvvhIJKQ14mvs4QzUIg00gAIf42U5ZSmk3FcKv7i9g+NpFTOQVNnvxp+/o6LqRva+aO7fZqqzMyum3AKOQWygI/hf8+2LadDzpCdobC1eMBSGWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EhiVEr1s; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: oliver.sang@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721011289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snMf7HzH7J2dr+IDOBFDYmYluvIOXw6b/0NlGy93V+s=;
	b=EhiVEr1s1uBJO3KUGzG42t0vzhixEhQL9Cc5s24YTX/YL0uw4hKXhPGRYHFs33PioDKT1M
	LhTm+FjmNe4HiZTSSrBWyeJIqbkXN6DVAVK6zXVSl74dZwtXGhSOLt/Y1PhPlz96E1F0S5
	SP2pEL/Wl0Z67rv7j6WOswnpMKJyOi8=
X-Envelope-To: yuzhao@google.com
X-Envelope-To: oe-lkp@lists.linux.dev
X-Envelope-To: lkp@intel.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: david@redhat.com
X-Envelope-To: fvdl@google.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: peterx@redhat.com
X-Envelope-To: yang@os.amperecomputing.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: fengwei.yin@intel.com
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [linux-next:master] [mm/hugetlb_vmemmap] 875fa64577:
 vm-scalability.throughput -34.3% regression
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ZpPD4Mz3t5xT87aN@xsang-OptiPlex-9020>
Date: Mon, 15 Jul 2024 10:40:43 +0800
Cc: Yu Zhao <yuzhao@google.com>,
 oe-lkp@lists.linux.dev,
 kernel test robot <lkp@intel.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Frank van der Linden <fvdl@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Huang Ying <ying.huang@intel.com>,
 Feng Tang <feng.tang@intel.com>,
 Yin Fengwei <fengwei.yin@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB8E06DE-0DB7-4605-AB19-19CF4F0F17B9@linux.dev>
References: <202407091001.1250ad4a-oliver.sang@intel.com>
 <CAOUHufYdGbgnqNprKVUH8woMR_R5Wcc=281vcmm3+NRO-=+-jw@mail.gmail.com>
 <ZpPD4Mz3t5xT87aN@xsang-OptiPlex-9020>
To: Oliver Sang <oliver.sang@intel.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 14, 2024, at 20:26, Oliver Sang <oliver.sang@intel.com> wrote:
>=20
> hi, Yu Zhao,
>=20
> On Wed, Jul 10, 2024 at 12:22:40AM -0600, Yu Zhao wrote:
>> On Mon, Jul 8, 2024 at 11:11=E2=80=AFPM kernel test robot =
<oliver.sang@intel.com> wrote:
>>>=20
>>> Hello,
>>>=20
>>> kernel test robot noticed a -34.3% regression of =
vm-scalability.throughput on:
>>>=20
>>>=20
>>> commit: 875fa64577da9bc8e9963ee14fef8433f20653e7 =
("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")
>>=20
>> This is likely caused by synchronize_rcu() wandering into the
>> allocation path. I'll patch that up soon.
>>=20
>=20
> we noticed this commit has already been merged into mainline
>=20
> [bd225530a4c717714722c3731442b78954c765b3] mm/hugetlb_vmemmap: fix =
race with speculative PFN walkers
> branch: linus/master

Did you test with HVO enabled (there are two ways to enable HVO: 1) =
adding cmdline with "hugetlb_free_vmemmap=3Don"
or 2) write 1 to /proc/sys/vm/hugetlb_optimize_vmemmap)? I want to =
confirm if the regression is related
to HVO routine.

Thanks.

>=20
> and the regression still exists in our tests. do you want us to test =
your
> patch? Thanks!


