Return-Path: <linux-kernel+bounces-570434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E82A6B048
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20A8483CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6507C222596;
	Thu, 20 Mar 2025 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Zirxau5G"
Received: from zebra.cherry.relay.mailchannels.net (zebra.cherry.relay.mailchannels.net [23.83.223.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE71221702
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508414; cv=pass; b=PMVs9cTJXeEL6D09lqzMSesa0pzS5hchyRFOYWi5fi7OJ2ThzwsVSMx5oD/lgg+KylxgGv54NHLlA6UMUO/GpkT/ofarkqrooT4fuO93d4fKCnnCiycjs2UORt+47n13ZktvJj4ZSxEatDWElnaQiRBf66AXZGRCZV8W0DRNNOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508414; c=relaxed/simple;
	bh=rKnRuj1sOu1P6GoDMqyMdLAxFo1dk1B7Wxfi2jiBslQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skSqOBsqxIcRf0qumQQQis3jSKsCXROmgv/BeE1dbbpoQQryCbJaGRMLmUbkmzDFKdvDaL2mLkSCvcMwVcv2JXAPypyF4UhBT8157ydchF+ZBoJbsk78IrAt1DwwDtFNVkJf6lkRNWYhJxyPcacaFIs5T1MpJVTEKyUYbA0xihM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Zirxau5G; arc=pass smtp.client-ip=23.83.223.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 70FE42C45EF;
	Thu, 20 Mar 2025 21:51:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com (100-118-196-158.trex-nlb.outbound.svc.cluster.local [100.118.196.158])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 529622C2B48;
	Thu, 20 Mar 2025 21:51:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1742507462; a=rsa-sha256;
	cv=none;
	b=b6kki2cOSvV90fmc/GzqhMDjx6vucTa1JoGeYHYgZoQpP80GyGzC41lfN/mugdu+JJkx0H
	+gkoI1vjsInROXn2gf2UD8dJp8ExkH7aOi5Y2KPrduabLCbd/PdSjYThVpbvJStPpkeqRZ
	enG/TorqqDtMKV5jS37HgBG2iCf38qeOjYHDj7qxgSKVpyn3qfBMP4P7cofiCknGkIKyh0
	RJKgUxmf9SsA6JngZwPKunByl7CrYdNJrBJaK/ahF5ry3IWYimuQJm+Hi5qwsTPaCb3yCZ
	2OkYY4DeciX3kf3hSiy+8yjF4WYTcDE9op7sXk1RsldlTkNVYjK1UwgdSg6Rww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1742507462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rKnRuj1sOu1P6GoDMqyMdLAxFo1dk1B7Wxfi2jiBslQ=;
	b=oR0KJfYEbBEqzhU9m2NvAZaVh0aIjzFR7+EFX7ceHFwxvlwuDk7lsAEFlGmM61Z7j8ZOKP
	gGnzNhivm7o0YTIapWUBmjkjX35zAI+TUaCS1vG2ella8ic7ViLnU00Pl5i5T0CuT28qJe
	O0ekW+a2zN9gYA1E6pg28AHEhKuwX/97nG84JEHYvNKmtUidK29aeYmUIcp9f6FIqh/CRe
	MJwTNj6a9G/kbXhcZsm7na40LGCKTuv1ZCfJFcEEWyAKFn+MudDNU2FcYTTU95J01v5ar7
	/sjTQpd85SmpQ6TLPj4MX+dPQLpOGmwkBy2sfsDR+Qa+lS2cxiGWIehAnxy1+g==
ARC-Authentication-Results: i=1;
	rspamd-588454d544-hp7ss;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trail-Average: 537d018d746d63d8_1742507463174_1537222768
X-MC-Loop-Signature: 1742507463174:1378819086
X-MC-Ingress-Time: 1742507463174
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.118.196.158 (trex/7.0.2);
	Thu, 20 Mar 2025 21:51:03 +0000
Received: from offworld (unknown [104.36.25.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4ZJfQq3VzSz4x;
	Thu, 20 Mar 2025 14:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1742507462;
	bh=rKnRuj1sOu1P6GoDMqyMdLAxFo1dk1B7Wxfi2jiBslQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Zirxau5Gg+fixQD8oJaOo/EhgqYA95gOT5zQ0Lt8ulojHb2y04BLjtm5yOHukUXwO
	 CFe9jLHE51bHO4x7xpV+pGADEXUmi+NQfMke0uotwCrLHADSwNrf+X3JHTeWfVR8/Z
	 zaFjp5z4wG2c70vA3Gpvv9h4vjmPgHFX0nsuaPF3KLfym9TmGA4VeWvlN8s34cGFdQ
	 LqV3plDIdVhUmOrycylqHMpzo3kLdTRbRApaxS3W8ZkyGk5DIDfL9L7DmVIgC3HxcL
	 oLJW5cNIRjrjO1zatLFeJlVkkxgGrDlchLTJ0fK99CCw1kHyPznXVmSN3v/XaAUtpK
	 KNH28qH5wLh9A==
Date: Thu, 20 Mar 2025 14:50:56 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
	Michael.Day@amd.com, akpm@linux-foundation.org, bharata@amd.com,
	dave.hansen@intel.com, david@redhat.com,
	dongjoo.linux.dev@gmail.com, feng.tang@intel.com, gourry@gourry.net,
	hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
	jhubbard@nvidia.com, jon.grimm@amd.com, k.shutemov@gmail.com,
	kbusch@meta.com, kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com,
	leillc@google.com, liam.howlett@oracle.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
	nphamcs@gmail.com, peterz@infradead.org, riel@surriel.com,
	rientjes@google.com, rppt@kernel.org, santosh.shukla@amd.com,
	shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com,
	Jonathan.Cameron@huawei.com, alok.rathore@samsung.com
Subject: Re: [RFC PATCH V1 00/13] mm: slowtier page promotion based on PTE A
 bit
Message-ID: <20250320215056.miwm2vdphdksrfjx@offworld>
Mail-Followup-To: Raghavendra K T <raghavendra.kt@amd.com>,
	AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
	Michael.Day@amd.com, akpm@linux-foundation.org, bharata@amd.com,
	dave.hansen@intel.com, david@redhat.com,
	dongjoo.linux.dev@gmail.com, feng.tang@intel.com, gourry@gourry.net,
	hannes@cmpxchg.org, honggyu.kim@sk.com, hughd@google.com,
	jhubbard@nvidia.com, jon.grimm@amd.com, k.shutemov@gmail.com,
	kbusch@meta.com, kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com,
	leillc@google.com, liam.howlett@oracle.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
	nphamcs@gmail.com, peterz@infradead.org, riel@surriel.com,
	rientjes@google.com, rppt@kernel.org, santosh.shukla@amd.com,
	shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com,
	Jonathan.Cameron@huawei.com, alok.rathore@samsung.com
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
 <20250319230015.bewglxf3hrf2mx3f@offworld>
 <52b2c1dd-2f4a-42fa-8a40-bd3664e7c56a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <52b2c1dd-2f4a-42fa-8a40-bd3664e7c56a@amd.com>
User-Agent: NeoMutt/20220429

On Thu, 20 Mar 2025, Raghavendra K T wrote:

>>Does NUMAB2 continue to exist? Are there any benefits in having two
>>sources?
>>
>
>I think there is surely a benefit in having two sources.

I think I was a bit vague. What I'm really asking is if the scanning is
done async (kmmscand), should NUMAB2 also exist as a source and also feed
into the migrator? Looking at it differently, I guess doing so would allow
additional flexibility in choosing what to use.

>NUMAB2 is more accurate but slow learning.

Yes. Which is also why it is important to have demotion in the picture to
measure the ping pong effect. LRU based heuristics work best here.

>IBS: No scan overhead but we need more sampledata.

>PTE A bit: more scanning overhead (but was not much significant to
>impact performance when compared with NUMAB1/NUMAB2, rather it was more
>performing because of proactive migration) but has less accurate data on
>hotness, target_node(?).
>
>When system is more stable, IBS was more effective.

IBS will never be as effective as it should be simply because of the lack
of time decay/frequency (hence all that related phi hackery in the kpromoted
series). It has a global view of memory, it should beat any sw scanning
heuristics by far but the numbers have lacked.

As you know, PeterZ, Dave Hansen, Ying and I have expressed concerns about
this in the past. But that is not to say it does not serve as a source,
as you point out.

Thanks,
Davidlohr

