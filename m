Return-Path: <linux-kernel+bounces-191502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B938D1066
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C601F21D86
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F315FA62;
	Mon, 27 May 2024 22:58:56 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998CE1E880
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716850736; cv=none; b=CZWr7MW090y6XW8NC46AwpVGjkFvq3Wlr3PfOvYpQazBb7jZk/ZtQasuVGJJCu03H+/8RFhZYtQOGf6BCOCdrO0LVPKaWRZh5ZpnwvVFaOZcB3Z6W5BoXgp34LZolnR5yTiSi5LGG5MtN+fRUgJE384A/VeHpWX/yeX2nncPNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716850736; c=relaxed/simple;
	bh=Olu29UeVSkVbGtShgyYhAHPd6LxKRQmLgqch29oHb5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6R/TL0zlYdGm/4TogBLDNNJ3awWl8WogUgVbia0E88xk+1pfnk3Ft120Tmb9j4r9j0/1M/pqwgW3wZKzTcLaUk8xj/btSG+ggFFORaAuz/3ZYVam7TaaGU7OOS5ci7BOLXmxbeJCQ5GOpRC5LHZxSTV7SdsLWwl7gBg4w08kxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-82-66551028e845
Date: Tue, 28 May 2024 07:58:43 +0900
From: Byungchul Park <byungchul@sk.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <20240527225843.GA50818@system.software.com>
References: <20240510065206.76078-1-byungchul@sk.com>
 <982317c0-7faa-45f0-82a1-29978c3c9f4d@intel.com>
 <20240527015732.GA61604@system.software.com>
 <a28df276-069c-4d4d-abaf-efc24983211e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28df276-069c-4d4d-abaf-efc24983211e@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsXC9ZZnoa6GQGiawbU+XYs569ewWXze8I/N
	4tPLB4wWLza0M1p8Xf+L2eLppz4Wi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2Ty2/rLzaJx6jc3j8ya5AL4oLpuU1JzMstQi
	fbsErozHb4+xFnQwVzQveszewLiNqYuRk0NCwETiaMtFNhh7ye9zzCA2i4CqxINvG9lBbDYB
	dYkbN36CxUWA7FMrlwPFuTiYBf4zSdx/2AqWEBYIkZj2YQ3YUF4BC4kpbRvBioQETjFK9F16
	wwyREJQ4OfMJC4jNLKAlcePfS6AGDiBbWmL5Pw6QMKeArcTOuQ/AFosKKEsc2HacCWSOhMAm
	dqA531ghLpWUOLjiBssERoFZSMbOQjJ2FsLYBYzMqxiFMvPKchMzc0z0MirzMiv0kvNzNzEC
	o3JZ7Z/oHYyfLgQfYhTgYFTi4b3RFZImxJpYVlyZe4hRgoNZSYRXZF5gmhBvSmJlVWpRfnxR
	aU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQbGhDsyfnHhmy6c6xPmV3YV+jov
	uethCN/T7iV7XnlIf/zqrlPjLWr87V8cV7/Fq1rPQrNU0Y6/YgdOcSrYyCm1Wv1iEH/SoZ2w
	vtJli/qPea+ezbBij0iSEFS74uzzxvDp2qt7fnUd2TCRVfzrD6OgXpvSXV9+P2nuXbRqwueH
	wp2RNUF23keUWIozEg21mIuKEwHZluERxgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXC5WfdrKshEJpmsPKqtMWc9WvYLD5v+Mdm
	8enlA0aLFxvaGS2+rv/FbPH0Ux+LxeG5J1ktLu+aw2Zxb81/Vovzu9ayWuxYuo/J4tKBBUwW
	x3sPMFnMv/eZzWLzpqnMFsenTGW0+P0DqPjkrMksDkIe31v7WDx2zrrL7rFgU6nH5hVaHov3
	vGTy2LSqk81j06dJ7B7vzp1j9zgx4zeLx7yTgR7v911l81j84gOTx9Zfdh6NU6+xeXzeJBfA
	H8Vlk5Kak1mWWqRvl8CV8fjtMdaCDuaK5kWP2RsYtzF1MXJySAiYSCz5fY4ZxGYRUJV48G0j
	O4jNJqAucePGT7C4CJB9auVyoDgXB7PAfyaJ+w9bwRLCAiES0z6sARvEK2AhMaVtI1iRkMAp
	Rom+S2+YIRKCEidnPmEBsZkFtCRu/HsJ1MABZEtLLP/HARLmFLCV2Dn3AdhiUQFliQPbjjNN
	YOSdhaR7FpLuWQjdCxiZVzGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgTG2LLaPxN3MH657H6I
	UYCDUYmH90JzSJoQa2JZcWXuIUYJDmYlEV6ReYFpQrwpiZVVqUX58UWlOanFhxilOViUxHm9
	wlMThATSE0tSs1NTC1KLYLJMHJxSDYxBhxKnLRcvfs647OSbCQmvk3539C3t2Fmku7mk4sMj
	i2XMZ6f5d1+8wGh2+t+F55aPf0Q56M6qyd3kNEFOkH3GastjW1xLmee6aS7etEyt+4PbxU+W
	nOfYbzzSqpSfuFvo5vLfn2bfFDb3OPUqVjjY6GIY8wbxb3O3CkmnlX35tj9+nU+e5sW3SizF
	GYmGWsxFxYkAbXST8q0CAAA=
X-CFilter-Loop: Reflected

On Sun, May 26, 2024 at 07:43:10PM -0700, Dave Hansen wrote:
> It has absolutely not been tested nor reviewed enough.  <fud>I hope the

It has been tested enough on my side, and it should be reviewed enough
for sure.  I will respin after rebasing the current mm-unstble and
working on vfs shortly.

	Byungchul

> performance gains stick around once more of the bugs are gone.</fud>

