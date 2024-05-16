Return-Path: <linux-kernel+bounces-180570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E08C704A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F7E1F232CF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515A1FA5;
	Thu, 16 May 2024 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W6AFsVHd"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1B138C
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 02:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715826578; cv=none; b=u5wxCOt6QvQE4Ndvuo9ASQO4iQWSDemhXDF+MYtWJPvk0nSghdpTHaD6WRaJm1W3CqOEzQ2iVY59qRYgMZMdA/Ypf2SsTc/bNWxJsOFPRPQ3VUOxXkckTDiZWR0hcU1S7lRHhmqGyAXKGDQI6A/65ziTLbvSuE/ixGeS40iUWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715826578; c=relaxed/simple;
	bh=64eqbHF30pFDvZplJnmy2dWsn/ELyqHpe4QH89CQlOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOWJg0Sjvox1gcNIT1M84GKPnHqgZrfzw7YKOc3OqLgbNCn6sYXRnwoNsfqYeYeU1upFprgDtgeYp476BasvviZLUvCGg9ngvpy+qYBik0hStzbvPxIXHF1Qk2iQxoyTPwug8TN6LsMkqm9JhGYzC9RVH0rHulFewgZJ61vyyAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W6AFsVHd; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f90a46dc-8842-47a2-a269-826367f991fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715826574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POjo41Qty2BYUDgH9m3H+3cml12oIPmG9DVVmyYHKx8=;
	b=W6AFsVHdGQnW0sZExoT5TvfA/u6N2+D9Hv5YDhe5+QkE3S/K1Ccn3GZOlNW5uQkXqSlLIu
	q/Vw4SGlKr+0G0E8IaCsMQDj9w9/wVkI1/jlza8rB2HAsAGDI+8owaDIceKTvGYBUtPlow
	PGfiHkX9qfYZUe83PEw9XBDQcsQI4nc=
Date: Thu, 16 May 2024 10:29:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] drm/loongson: Add helpers for creating subdevice
To: Markus Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sui Jingfeng <suijingfeng@loongson.cn>
References: <20240513001243.1739336-2-sui.jingfeng@linux.dev>
 <fe55ddf4-b86f-4d9f-aac4-373c5f2a46ac@web.de>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <fe55ddf4-b86f-4d9f-aac4-373c5f2a46ac@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 5/16/24 04:30, Markus Elfring wrote:
>> In some display subsystems, the functionality of a PCI(e) device may too
> …
>> of the functionality into child devices can helps to achieve better
>> modularity, eaiser for understand and maintain.
>>
>> Add the loongson_create_platform_device() function to pove the way …
> 
> Please avoid typos in such a change description.


I was too hurry, sorry, my bad.
Will be fixed at the next version.


> Regards,
> Markus

-- 
Best regards
Sui

