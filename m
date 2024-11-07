Return-Path: <linux-kernel+bounces-400700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F73E9C1122
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FAC1C24279
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5F92185B0;
	Thu,  7 Nov 2024 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="j1vyvytM"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F0F218321;
	Thu,  7 Nov 2024 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015611; cv=none; b=N6jGeAD5CnCLjODRi3z5aqXboz35gEpKDEX4APokmhoQh6zsIbMD28SfPPyJnDYf8EazYLnpr3azZnXDxlFdPghMpPUl9AXDCEWVFxDhv6meLK5r0J93owUL0zoOJE4dNFfBRVC4KH4QabOagILgbW2exZBwhvNXXxYAoEFoWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015611; c=relaxed/simple;
	bh=Ny3CvDITHPlWuLENehbt2wBLEtAQD5elgy+cqkIZrlw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uk8uahY91dWOKL9OQn+grQLUByJuDs4dwW2Ldg2zGvlouHoCHrRjSuP3X3nGjmAJx8PuB6FGg/8q0gG8SlDf6kV1vxefwt6w6QjMuKoAHQKkQ/fPanfMsALaHhXSXVgxr1gj8FtcsyyXJdfMc5RRV3Zqs3vqM88ZAQpqFJwSIpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=j1vyvytM; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3787242C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731015609; bh=9RmQRPJTo4xCHUR8W21tIIx//2ebI1VDFOkqO+ne6B4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=j1vyvytM42Ueu1w1uY8YbT1XUnDs17/GQ3PH3nJ3iKs0gh4FOJV37L/yM812O8wco
	 4AkHIrW8lOprR9eKggJDgFpCY1H5OJsPP5dmE82fz8rVxpeEsWHcaQD56BTWFJ2HPd
	 DZNeYkoiqdVpJ4lcRVL/scafDB1Im50xt2luLLd+Iy1egho16rQweiI5UAZNFtNPLX
	 HzznxasHopFu/mL60NvI0APOb4vTgq64kMUqFxe0jX145fuE5RP4FqpAfG2C7U4yOy
	 63VHdPtVfBu+fWsN1R0u0bKRd7uslvraxI7FVKxwGB5wldbeH6m404phqzs0lmV5JQ
	 Do6wIFqjN3UyA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3787242C17;
	Thu,  7 Nov 2024 21:40:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, anish kumar
 <yesanishhere@gmail.com>, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, Sebastian Fricke
 <sebastian.fricke@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: Re: [RFC PATCH] ALSA: Add debugging guide for audio issues
In-Reply-To: <274400c3-fd64-4e45-bbd2-319634a09d61@infradead.org>
References: <20241107200835.3033-1-yesanishhere@gmail.com>
 <87cyj622oc.fsf@trenco.lwn.net>
 <274400c3-fd64-4e45-bbd2-319634a09d61@infradead.org>
Date: Thu, 07 Nov 2024 14:40:08 -0700
Message-ID: <874j4i205j.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> On 11/7/24 12:45 PM, Jonathan Corbet wrote:
>> anish kumar <yesanishhere@gmail.com> writes:
>> 
>>> Add a comprehensive debugging guide for ALSA audio issues, covering
>>> topics from bootup to runtime debugging. This document aims to help
>>> developers diagnose and resolve common audio problems in Linux.
>>>
>>> The guide includes sections on:
>>> - Bootup/bringup issues
>>> - Runtime debugging
>>> - XRUN debugging
>>> - Audio pops and clicks
>>>
>>> This addresses the lack of a centralized debugging resource for ALSA
>>> and should help improve the troubleshooting process for audio drivers.
>>>
>>> Inspired by discussions on LKML:
>>> https://lkml.org/lkml/2024/9/24/392
>>>
>>> Signed-off-by: anish kumar <yesanishhere@gmail.com>
>>> ---
>>>  Documentation/sound/soc/debug.rst | 334 ++++++++++++++++++++++++++++++
>>>  Documentation/sound/soc/index.rst |   1 +
>>>  2 files changed, 335 insertions(+)
>>>  create mode 100644 Documentation/sound/soc/debug.rst
>> 
>> At a first glance, this seems useful.
>> 
>> I was just looking at Sebastian's new debugging documentation:
>> 
>>   https://lore.kernel.org/all/20241028-media_docs_improve_v3-v1-0-2b1b486c223e@collabora.com/
>> 
>> ... so my immediate thought is that this documentation should be
>> coherent and together, rather than scattered though the docs.  Maybe
>> move this to process/debugging and integrate it with his work?
>
> and once again I disagree that these docs should be in Documentation/process/.

OK, I guess I missed that...where do you think we should put them?

jon

