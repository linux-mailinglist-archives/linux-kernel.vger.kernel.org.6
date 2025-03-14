Return-Path: <linux-kernel+bounces-560742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DD2A608F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B313917FB7B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2350E1514EE;
	Fri, 14 Mar 2025 06:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ckkt9XiV"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9449A14A09A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932728; cv=none; b=PH4AyxRVpSneE9996XRTa5IE9grxDviagTvjEleSYGRIT/1uA2uZZSq9KWNV9iNx/yLy7SlmwONA3zMCuWfR60NVi78K3zQCBWo0Xa7CIzy5SjpZVUIxoMMf6kNJC1xvbVzz6CF1C6PUXhwZZj7NHMuVLG3TJetHwwjfgT33cCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932728; c=relaxed/simple;
	bh=k/PtdWtd6A3+aNLhLaBx1vx5oX/UVfw1fVBDqkXClSo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=m72C6o5CxWiP090hSG3OafVUSXEBkkwBWpiFZ0t+oZMmyOYg/oTRg99clvUMl2U2ZifyYwMc8Co0FKEV9H6D/rCqgWmwmoV3Q9aFqiHLkNTpFW/N8TfiNhKNErFXI2bkMcJIlG/tle8U8HHNT2K1wCM0PDa+ppKS+JBBUPP06ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ckkt9XiV; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741932720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4tvhtoi8B+ZP0KS2yGU1l6szw3cCmdQt0EmCPV2dCg=;
	b=ckkt9XiVUiQnyCaLgfq2vuFYksNAz/OrwDAIxHiAfU/cNQ0+RGmt7ecdOM6oLdIycYpeV5
	bqE+piyzNKd13hKFmG/947ztNxH14n9w/3Qfaob55pQTUd/Ru/ogUsqQTcopX7t0p3LyBn
	GuHJTfgKvk2gJTaZdCBritT6T5gV2Bk=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH V2] mm: vmscan: skip the file folios in proactive reclaim
 if swappiness is MAX
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>
Date: Fri, 14 Mar 2025 14:11:21 +0800
Cc: akpm@linux-foundation.org,
 mhocko@suse.com,
 hannes@cmpxchg.org,
 yosry.ahmed@linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <829B42A6-4EE1-4875-8D97-1AB0341C85BB@linux.dev>
References: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Mar 14, 2025, at 11:33, Zhongkun He <hezhongkun.hzk@bytedance.com> =
wrote:
>=20
> With this patch 'commit <68cd9050d871> ("mm: add swappiness=3D arg to
> memory.reclaim")', we can submit an additional swappiness=3D<val> =
argument
> to memory.reclaim. It is very useful because we can dynamically adjust
> the reclamation ratio based on the anonymous folios and file folios of
> each cgroup. For example,when swappiness is set to 0, we only reclaim
> from file folios.
>=20
> However,we have also encountered a new issue: when swappiness is set =
to
> the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
> to the knob of cache_trim_mode, which depends solely on the ratio of
> inactive folios, regardless of whether there are a large number of =
cold
> folios in anonymous folio list.
>=20
> So, we hope to add a new control logic where proactive memory reclaim =
only
> reclaims from anonymous folios when swappiness is set to =
MAX_SWAPPINESS.
> For example, something like this:
>=20
> echo "2M swappiness=3D200" > /sys/fs/cgroup/memory.reclaim
>=20
> will perform reclaim on the rootcg with a swappiness setting of 200 =
(max
> swappiness) regardless of the file folios. Users have a more =
comprehensive
> view of the application's memory distribution because there are many
> metrics available. For example, if we find that a certain cgroup has a
> large number of inactive anon folios, we can reclaim only those and =
skip
> file folios, because with the zram/zswap, the IO tradeoff that
> cache_trim_mode is making doesn't hold - file refaults will cause IO,
> whereas anon decompression will not.
>=20
> With this patch, the swappiness argument of memory.reclaim has a more
> precise semantics: 0 means reclaiming only from file pages, while 200
> means reclaiming just from anonymous pages.
>=20
> V1:
>  Update Documentation/admin-guide/cgroup-v2.rst --from Andrew Morton
>  Add more descriptions in the comment.   --from Johannes Weiner
>=20
> V2:
>  Add reviewed from Yosry Ahmed.

Actually, those changelog should be added below "---" below.

>=20
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ---

Here, start to add your changelog. The code looks good to me.

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.=

