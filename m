Return-Path: <linux-kernel+bounces-235126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7638291D07B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6891F210A7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59840C03;
	Sun, 30 Jun 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dpolakovic.space header.i=@dpolakovic.space header.b="RnMA7DNk"
Received: from m1-out-mua-14.websupport.sk (m1-out-mua-14.websupport.sk [45.13.137.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6A3B2BB
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.13.137.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719735054; cv=none; b=MjoBgrXAnqHVHFd7Wp5EVNQugU9AB9Bw58rtsDySJxQWB9EJ62ZMf0sjIycCXp7Jc5SHKUDQVhrTVJpFRLtNBAYJNCM1fk+tPVkLlfij590970IbHH0GZEIt9ot4N4MO7rMMV46QYvORA7Uw1Y4KZGc/WdPmjvbBd0RsMEO/V14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719735054; c=relaxed/simple;
	bh=xVaM5Zi24tUv2+zX/Vj4NJdlvblvkRzFs9lbnnkL6+c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WcNpneHNCPEuYrG+zhTFYR0dE6OX7OdwSaubziyFLezNuXjYsH5ZulGc65Zs87KDm+R8asWRcV+0vBE64k8QrrBY4hASSE7imC027jSD5aFXzCWSrPMlxWDH+pTl7hHfVqIzR8vIhBNlSQJQIf42jEJjjZROMQJrzG7DHZP4mWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dpolakovic.space; spf=pass smtp.mailfrom=dpolakovic.space; dkim=pass (2048-bit key) header.d=dpolakovic.space header.i=@dpolakovic.space header.b=RnMA7DNk; arc=none smtp.client-ip=45.13.137.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dpolakovic.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dpolakovic.space
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dpolakovic.space;
	s=mail; t=1719734720;
	bh=xVaM5Zi24tUv2+zX/Vj4NJdlvblvkRzFs9lbnnkL6+c=;
	h=Date:To:From:Subject:From;
	b=RnMA7DNkEgC3k3KjgUnx18vJx6+JR7sDilP6r12jFw0JF8GATOi5wJaE2S+G2xvuI
	 Yt97A/OovlorYyWScSlycCqVhhO0A/7lGsyYXaUDHMzBdvgjjB9RhM7c8U400aGIoK
	 ukJR0AQnL8M9c9Y9xvdjQIRTmAFFz3wCUs7eLP99DvI0H/ut39PETAZbmCd1ItXEeJ
	 wdjlg838O/jP4IDB3ihzomysQsWg0RYc+5DmsNOSW90cMGPxeP1/SkJOWy/pXsfqMv
	 mWwi6nYWkESdgyFbEhNYZqgKBag5dP+4w6C5nlaaME4Y5s5jhoje1ZZmTu/Kgsk9FV
	 O8NSTi9HTmWbg==
Received: from m1-u6-ing.websupport.sk (unknown [10.30.6.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by m1-out-mua-14.websupport.sk (Postfix) with ESMTPS id 4WBhYX2HXFz1xV8
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 10:05:20 +0200 (CEST)
X-Authenticated-Sender: email@dpolakovic.space
Authentication-Results: m1-u6-ing.websupport.sk;
	auth=pass smtp.auth=email@dpolakovic.space smtp.mailfrom=email@dpolakovic.space
Received: from [192.168.0.54] (dev190.net181.ip-net.sk [46.227.181.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: email@dpolakovic.space)
	by m1-u6-ing.websupport.sk (Postfix) with ESMTPSA id 4WBhYX00WFzdvMt
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 10:05:19 +0200 (CEST)
Message-ID: <3be3235a-dea7-a5ca-b5ea-4047bdeb695d@dpolakovic.space>
Date: Sun, 30 Jun 2024 10:05:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-kernel@vger.kernel.org
From: David Polakovic <email@dpolakovic.space>
Subject: proposition for fixing Y292B bug
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Out-Rspamd-Queue-Id: 4WBhYX00WFzdvMt
X-Out-Spamd-Result: default: False [1.90 / 1000.00];
	INTRODUCTION(2.00)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:56349, ipnet:46.227.176.0/21, country:SK];
	RCVD_COUNT_ZERO(0.00)[0];
	HAS_X_AS(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GENERIC_REPUTATION(0.00)[-0.49971426981811];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1]
X-Out-Rspamd-Server: m1-rspamd-out-4
X-Rspamd-Action: no action

Hello dear developers and enthusiasts.

My name is David and recently I wrote a blog post about "necessity"
of fixing 64-bit signed integer overflow of time_t, sometime in year
292 billion. I proposed this to simply have software complete solution
for timekeeping. The blog had somewhat nice feedback and few people
told me to write to your mailing list.

As I mention in the list, I am no way experienced enough in kernel
space to turn this into full merge request, so I post it to you and
if anyone would like to build on this idea, it is GPLd for your convenience.

Any feedback is highly appreciated so please, include me in CC's.

The blog is written with funny attitude, but it is in no way meant to
be joke, parody or insult.
https://dpolakovic.space/blogs/y292b

The source code can be found here.
https://git.dpolakovic.space/?p=unix-time-fix;a=summary


Thank you for your time.

dpo


