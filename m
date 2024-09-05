Return-Path: <linux-kernel+bounces-316174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9199096CC32
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D511C2245E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AD7B661;
	Thu,  5 Sep 2024 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="KcjvczhZ"
Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8908F7D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499429; cv=fail; b=F9ACj/skcEw7Eu44rIYd/0gU32rAZuVSDUJi8S9ylpjbHo5Mjr0C5F7oURLvIkCqsKtZE0KO6QjCrlnMtC/c4hxgQZbMgq7Ag0Hf+c0Wqlx6ctbjBZVdWSmRlgMqVFdO3FcpKMbVfbKPj3stt2/Rjjw4wIm54SfIuldkAWIA7M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499429; c=relaxed/simple;
	bh=ZzfYZqACgthquqTa5yEnv0G+jvgg/CO1OZ9MHpeX1mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLlcRKhmjsh4cvpdjAmDJWfYPsGqwKUPzSXHeaNTyg+qvsOPrymSCK7oJSkaqeUR6Ex92eEbMuczCLHmwsmMf431htsm8fl4c+INiDomJDmE1BM69PJj0fdhxVxYnwXzQT6vMu+iiB83qKRatvd7mfrxiciXLx4djOl1f4QoMtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=KcjvczhZ; arc=fail smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8DF10C77BF;
	Thu,  5 Sep 2024 01:08:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 07F60C75B2;
	Thu,  5 Sep 2024 01:08:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1725498490; a=rsa-sha256;
	cv=none;
	b=I7pmC918ScggNcVYkv9qja4dn46JsAhOFZVbCgguPd3MQ3gxYJi/pTdkVLRrLGlZgSmtkv
	uvAQNOfkkfHUzjqwjIyHB0uDKz6WTTXNwBXDrIQI2Fl8dEh37vIPBKreZFkQvU03E7JBoV
	WXKXZ9MJf93RQM1uqCh80jJkbySM5PfC/TdnK+J9fYgshPsvQFEdtxCyx+k/gRNnzbgXwb
	Ox25qpXHOlPhtH0pbRjtG600kJG3Doq7ccXzbGK5SM8UvmLQtDBEJgaWORmORnophFbKV1
	ZEDYndhhvQcBJlvdYDSP8qYQ8aLh7S7pRQBWFNhU5i0WzBewWKwSVtIupK+qtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1725498490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9GEj4OM/a2qb4uz3i0fngIpeBJBLKnbIBwE1moCNumc=;
	b=xKl2G/GYHiJflz4W/uNO5aDH3R1MZWrf9TZQt9IDECi4fPA4i4JR9RRQ0zjd9fcM61l+wi
	P/AfUtY2CxDRVOYzoxFrytYP+WIPM/lNHZi/+FFyUH2O/sDSPZX0IeJX3BSpALqeiO8BdA
	zXTn/5mZkREtjLvuFNthApMKA8Qd26Q57XNzTugtH6X69isG0v3FKPy5WnmiwlLxPjySET
	bHoKC7sedCNkkD0Om4GO6vUPcrZ+W1V/slIXxb+L1/EbS26tf8dDoK3NCh1ptqaSJJNThr
	9yOafy1a81h+83ENLF8l5gZ12wI+6u1bUfhEYldWVIGyVqFOdGxFkLeqJoKJ3w==
ARC-Authentication-Results: i=1;
	rspamd-85dcd79db4-h6mk5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Print: 2eed196d76f6f3a6_1725498490397_2196151604
X-MC-Loop-Signature: 1725498490397:669959050
X-MC-Ingress-Time: 1725498490397
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.55.150 (trex/7.0.2);
	Thu, 05 Sep 2024 01:08:10 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4Wzh7F0WkrzKl;
	Wed,  4 Sep 2024 18:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1725498489;
	bh=LKY+eXNh+b8+ANsTonvdMbko2ru5DwhYm9x7uRWa5wQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=KcjvczhZ97oGMqoz5+R7HitoZ5hENAKtTGSk8TsLzra/tW1uCkv1pc+9uZd6U0Cm5
	 weddqZBIm0d4RtygWsSxkty0zfsr1jDum4U2VYp+EOIDR9ViybThHv5LQxO1ixNn4N
	 tKnMwuPONWU01ZTXOvzVBbpVfoz/HUvopu3/BW6hVy6njJ1VRhQR86iiBWpmVjlSR+
	 jxKYMd0Q2cElU+kNM3Ujs0iuVmNTPf2SYSfI7Or13XJn21ch6UCFOtzm6myWLyDQyR
	 tpkRyUJzkBAGR+8oKtIxKxN4OhkZERWUuld8WrM6DISllJ8umdQ5rlVRDV40zqu3WF
	 zH+codBc7GPLQ==
Date: Wed, 4 Sep 2024 18:08:05 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mhocko@kernel.org, rientjes@google.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, almasrymina@google.com, 
	roman.gushchin@linux.dev, gthelen@google.com, dseo3@uci.edu, a.manzanares@samsung.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
Message-ID: <nwutv6cuuyajmakiiznb3hoao6jfhrs2clpqi76xomqbc6yymg@n7inzwjcskhf>
Mail-Followup-To: Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, mhocko@kernel.org, rientjes@google.com, yosryahmed@google.com, 
	hannes@cmpxchg.org, almasrymina@google.com, roman.gushchin@linux.dev, 
	gthelen@google.com, dseo3@uci.edu, a.manzanares@samsung.com, 
	linux-kernel@vger.kernel.org
References: <20240904162740.1043168-1-dave@stgolabs.net>
 <20240904131811.234e005307f249ef07670c20@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240904131811.234e005307f249ef07670c20@linux-foundation.org>
User-Agent: NeoMutt/20240425

On Wed, 04 Sep 2024, Andrew Morton wrote:\n
>On Wed,  4 Sep 2024 09:27:40 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> This adds support for allowing proactive reclaim in general on a
>> NUMA system. A per-node interface extends support for beyond a
>> memcg-specific interface, respecting the current semantics of
>> memory.reclaim: respecting aging LRU and not supporting
>> artificially triggering eviction on nodes belonging to non-bottom
>> tiers.
>>
>> This patch allows userspace to do:
>>
>>      echo 512M swappiness=10 > /sys/devices/system/node/nodeX/reclaim
>
>One value per sysfs file is a rule.

I wasn't aware of it as a rule - is this documented somewhere?

I ask because I see some others are using space-separated parameters, ie:

/sys/bus/usb/drivers/foo/new_id

... or colons. What would be acceptable? echo "512M:10" > ... ?

>> +What:		/sys/devices/system/node/nodeX/reclaim
>> +Date:		September 2024
>> +Contact:	Linux Memory Management list <linux-mm@kvack.org>
>> +Description:
>> +		This is write-only nested-keyed file which accepts the number of
>
>"is a write-only".
>
>What does "nested keyed" mean?

Will re-phrase.

>
>> +		bytes to reclaim as well as the swappiness for this particular
>> +		operation. Write the amount of bytes to induce memory reclaim in
>> +		this node. When it completes successfully, the specified amount
>> +		or more memory will have been reclaimed, and -EAGAIN if less
>> +		bytes are reclaimed than the specified amount.
>
>Could be that this feature would benefit from a more expansive
>treatment under Documentation/somewhere.

Sure.

>
>>
>> ...
>>
>> +#if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
>> +
>> +enum {
>> +	MEMORY_RECLAIM_SWAPPINESS = 0,
>> +	MEMORY_RECLAIM_NULL,
>> +};
>> +
>> +static const match_table_t tokens = {
>> +	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
>> +	{ MEMORY_RECLAIM_NULL, NULL },
>> +};
>> +
>> +static ssize_t reclaim_store(struct device *dev,
>> +			     struct device_attribute *attr,
>> +			     const char *buf, size_t count)
>> +{
>> +	int nid = dev->id;
>> +	gfp_t gfp_mask = GFP_KERNEL;
>> +	struct pglist_data *pgdat = NODE_DATA(nid);
>> +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
>> +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
>> +	int swappiness = -1;
>> +	char *old_buf, *start;
>> +	substring_t args[MAX_OPT_ARGS];
>> +	struct scan_control sc = {
>> +		.gfp_mask = current_gfp_context(gfp_mask),
>> +		.reclaim_idx = gfp_zone(gfp_mask),
>> +		.priority = DEF_PRIORITY,
>> +		.may_writepage = !laptop_mode,
>> +		.may_unmap = 1,
>> +		.may_swap = 1,
>> +		.proactive = 1,
>> +	};
>> +
>> +	buf = strstrip((char *)buf);
>> +
>> +	old_buf = (char *)buf;
>> +	nr_to_reclaim = memparse(buf, (char **)&buf) / PAGE_SIZE;
>> +	if (buf == old_buf)
>> +		return -EINVAL;
>> +
>> +	buf = strstrip((char *)buf);
>> +
>> +	while ((start = strsep((char **)&buf, " ")) != NULL) {
>> +		if (!strlen(start))
>> +			continue;
>> +		switch (match_token(start, tokens, args)) {
>> +		case MEMORY_RECLAIM_SWAPPINESS:
>> +			if (match_int(&args[0], &swappiness))
>> +				return -EINVAL;
>> +			if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
>> +				return -EINVAL;
>
>Code forgot to use local `swappiness' for any purpose?

Bleh, yeah sc.proactive_swappiness needs to be set here.

>
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>>
>> ...
>>

