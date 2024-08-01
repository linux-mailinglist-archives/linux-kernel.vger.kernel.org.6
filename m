Return-Path: <linux-kernel+bounces-270550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6212944153
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E77B283A07
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1186913211F;
	Thu,  1 Aug 2024 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XRK+N5mA"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8EE131BDD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722480182; cv=none; b=X3lwbtSzlJUM00cI1kAYAlsOvPUp1swuA4uT2h4whlVxAQAb64zqcz/4mRy9ci4i5+VZrAxg5O2ZeeDMXY4WMF0mVvp6d2a2lHzkZMpCiYyY710goQIJVmfTPYIkxrSGgW0I3J7HEe1PM2bh4ZOy24YA8BbUywUv1EPTB4KHvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722480182; c=relaxed/simple;
	bh=6285+tUHdQTcg6DEPpwjsL4gMQQByjJdChORJZAXZcY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ikbftv5AV/ieV4C/Ze9fNI7gYHv/7UEYjQfk7iAtyicFAtTtwdMkSUdVNHGLsEffUJkuZZsFZcq/4WaR8S+K3jAHYIRNbC6XZezLrV/cI/5fOWLackB2+0+RkoeaEm0JUePpspzBQkL1NoSDRwIsoU9uKBkT7STVpCPbqU940ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XRK+N5mA; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722480176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6285+tUHdQTcg6DEPpwjsL4gMQQByjJdChORJZAXZcY=;
	b=XRK+N5mAgJAg+xQTuOTTEkhPvx8G6KGCTxdq+vVwPOiLQ0sK3LIbA1qLXWyJaDE2ZsA1+z
	MTubxZqNpM62pddos+ThRRxA6+VfDymtFsTcboWvru1NYSEcXkn80aflZM0TkPO+FJIXrg
	gmfQK7ulc0WpLNz0oqP34mF6ZCW08f8=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] mm: list_lru: fix UAF for memory cgroup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240731132825.1fb29122d35997a425368b32@linux-foundation.org>
Date: Thu, 1 Aug 2024 10:42:02 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Nhat Pham <nphamcs@gmail.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>,
 Shakeel Butt <shakeel.butt@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AA53CB7-1E21-4B79-8BA9-B1F40D3E15DF@linux.dev>
References: <20240718083607.42068-1-songmuchun@bytedance.com>
 <20240731132825.1fb29122d35997a425368b32@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT



> On Aug 1, 2024, at 04:28, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Thu, 18 Jul 2024 16:36:07 +0800 Muchun Song =
<songmuchun@bytedance.com> wrote:
>=20
>> The mem_cgroup_from_slab_obj() is supposed to be called under rcu
>> lock or cgroup_mutex or others which could prevent returned memcg
>> from being freed. Fix it by adding missing rcu read lock.
>>=20
>=20
> Well I grabbed this, but the review led me to expect a v2.

Will do.

>=20
> Should it have cc:stable?

Yes.


