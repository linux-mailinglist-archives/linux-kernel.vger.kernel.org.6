Return-Path: <linux-kernel+bounces-316275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C5896CD63
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1260C1C22096
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25831442E8;
	Thu,  5 Sep 2024 03:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="UsDe89tB"
Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806B5143759
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507329; cv=pass; b=VCAYz38cKY+z8eLdjBdr87EwVJlfi9/XD6H5PjEFj0z439J3I8eIKFIh6WpZiPHODDJACFtvHI8zzlN3dNX8iGFg75BkWMCnnsPakj/Fs5lxkSqsrOZYzaeOOIpPuvuU/Pk6xbylIazrs9PwEt9n2muEYTX1HdjH1P27ffXmAT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507329; c=relaxed/simple;
	bh=qtqGJKmeGYjAmolO6g//CYy841MhMDCQ5pY+e3IYnTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCV2a4wPIkf9BsGQBCqDopwaskjFaER7O+FSjJLCJ3wXZXxmaAwRfNygpp0gevZOYHJb3lrCdnCzTVwwSVpBgb1vreCwmnZboDZOapV5gKpkhnCtJ3zxrXubhGF6LLZ3Luclpi8I5Fi39xW0CSRZ4PWDJcXwSivllNSeVfMPJto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=UsDe89tB; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D6EB72C6F27;
	Thu,  5 Sep 2024 03:35:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a262.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6C4692C6DA2;
	Thu,  5 Sep 2024 03:35:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1725507326; a=rsa-sha256;
	cv=none;
	b=Trz7bC3h4Yky6kz33kOgYl0pzPL911I87IwVZNyUReddSV0yENtO3PIVnKfAFMiZTcRnK8
	ocEJONF5dM1tB5Nh7zZnr8RbtV00/ScB5GbklLJfsFYHv+3zV6xCfkgSfqtpWdsb3p3hdF
	UDPx/8iAMMIV1punbZTXLLdQlmuaUCcbiGl7s6U+UXLxau8MNhCLlhi6jYV2wjJF0V75Vt
	pkJ+bsPiSu+obEPBo2la0cruFxNvEmMQqXHhm/I3PW1r4nakxfLT8InGqUdUWNzix1o4Z3
	ac8O+q/vok/S/jzOFUZXsZsaInr0Pxx66sRjXrOjZyNQl+oRI+6xJVIB9vagEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1725507326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sqv0e0qkAp5wHmZcV7cPBzn1r7u2Pw6TA23Yco90OIs=;
	b=SjdMY07rbVcTZbkGMdqY6lhcJLUPcJ+q5BWwhvEBHddL+Q34T/7PLRe3HVWQu8uOg5/FQV
	fSpdP/z1gDbQxRWoArRwz5GFI8o2HX/+m5qh/IOj3dOA+1AfrrrxwnyWxuo5M7XZZF44ZI
	rQOgAic6MV3kd35/A4npPBmqL3G58xBqseegVo8DOPTg+MtmKU1V4akjMspvJ9wGBdHsvV
	YG9BgDblT+ggBOn2YSoJiszBqquW/SVrtLP6z3pN3TQfbZWiU6SCxa9vlcGkvWoaEvzOI8
	D4iEHFn2ZjLpTiQg71XiB/JwIpj9htjJX/zT/PQrWFI3LJfIAMY2pgTi5ahwkQ==
ARC-Authentication-Results: i=1;
	rspamd-6bf87dd45-4wmp5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Rock-Reaction: 5bd992fb6fd8a490_1725507326763_2866573522
X-MC-Loop-Signature: 1725507326763:1884108718
X-MC-Ingress-Time: 1725507326763
Received: from pdx1-sub0-mail-a262.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.23.7 (trex/7.0.2);
	Thu, 05 Sep 2024 03:35:26 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a262.dreamhost.com (Postfix) with ESMTPSA id 4WzlP94QRXz75;
	Wed,  4 Sep 2024 20:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1725507326;
	bh=sqv0e0qkAp5wHmZcV7cPBzn1r7u2Pw6TA23Yco90OIs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=UsDe89tBIYADnq175TNv41WyX2G/T2Tg4gDQM8Q6VMskZGZjnPVj1NkelevY+11CY
	 WbuuCVctBRH1fypGmYzaPjRIpR51dJn0g2DjRzfQB0na89FYF8jEgwc6GC0MThG+Kc
	 i0wm4gwrj5JABnhoumT3MgXet4lvFpGV4xgklSjiVCXbZ0gik8jpL4Ekk2rl87bwHV
	 SZcN1Ljsi1PrMyJUzpdEpIovYJJZOoxMRGUskb/o3zA1NOtDI7+GdLoMKarK9SluW8
	 kR3sUURMqZbRrp0fNCp2YRtL2ay865jt3piUcW3DWPmI9zh6Hca1x5H1bmBrW36RW5
	 M8eSpFAp4XJDg==
Date: Wed, 4 Sep 2024 20:35:22 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mhocko@kernel.org, rientjes@google.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, almasrymina@google.com, 
	roman.gushchin@linux.dev, gthelen@google.com, dseo3@uci.edu, a.manzanares@samsung.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: introduce per-node proactive reclaim interface
Message-ID: <a2fdrnaagcgp4hllalttaxs7ckc6w5bt2j7fg4upagqhfvoc3b@jsmugftxvyyz>
Mail-Followup-To: Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, mhocko@kernel.org, rientjes@google.com, yosryahmed@google.com, 
	hannes@cmpxchg.org, almasrymina@google.com, roman.gushchin@linux.dev, 
	gthelen@google.com, dseo3@uci.edu, a.manzanares@samsung.com, 
	linux-kernel@vger.kernel.org
References: <20240904162740.1043168-1-dave@stgolabs.net>
 <20240904131811.234e005307f249ef07670c20@linux-foundation.org>
 <nwutv6cuuyajmakiiznb3hoao6jfhrs2clpqi76xomqbc6yymg@n7inzwjcskhf>
 <20240904181543.02de2242490cf233c7879697@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240904181543.02de2242490cf233c7879697@linux-foundation.org>
User-Agent: NeoMutt/20240425

On Wed, 04 Sep 2024, Andrew Morton wrote:\n
>On Wed, 4 Sep 2024 18:08:05 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> On Wed, 04 Sep 2024, Andrew Morton wrote:\n
>> >On Wed,  4 Sep 2024 09:27:40 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:
>> >
>> >> This adds support for allowing proactive reclaim in general on a
>> >> NUMA system. A per-node interface extends support for beyond a
>> >> memcg-specific interface, respecting the current semantics of
>> >> memory.reclaim: respecting aging LRU and not supporting
>> >> artificially triggering eviction on nodes belonging to non-bottom
>> >> tiers.
>> >>
>> >> This patch allows userspace to do:
>> >>
>> >>      echo 512M swappiness=10 > /sys/devices/system/node/nodeX/reclaim
>> >
>> >One value per sysfs file is a rule.
>>
>> I wasn't aware of it as a rule - is this documented somewhere?
>
>Documentation/filesystems/sysfs.rst, line 62.  Also lots of gregkh
>grumpygrams :)
>
>> I ask because I see some others are using space-separated parameters, ie:
>>
>> /sys/bus/usb/drivers/foo/new_id
>>
>> ... or colons. What would be acceptable? echo "512M:10" > ... ?
>
>Kinda cheating.  But the rule gets violated a lot.

The only other alternative I can think of is to have a separate file
for swappiness, which of course sucks. So I will go with the colon
approach unless somebody shouts - I still prefer it as is in this patch,
if we are going to violate the rule altogether...

