Return-Path: <linux-kernel+bounces-328550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E51F9785A3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914271F25044
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6916F067;
	Fri, 13 Sep 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IICPfmg+"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6AD2FB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726244352; cv=none; b=peVsARPbhFJaJFkjfIaYBL43Czr9EeZ5RL5JDndi4jjEU2OP07Kb6DOxDD9tJl+B4FzjM/yWaSR5m4Pc+9+15qN0bflPoU2ikNmmVs2b3pWuEZmbIzgAIWWh/7SoXB0dVgrwby0NoyV+1wn0ms7qOCGwmdRwVv232VyUF0Yn+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726244352; c=relaxed/simple;
	bh=ba9NAQQadx+oecoJZRUU7QU7IEo6/AwWd4/rRGZ8DX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+SXPVRxITIKrIEfD/zbuQrrPMLa1J+uQfT3R9E9maPC5yTKK+l+5OESOCvtAk1NY99MbQKKvt86IHTItK5/YlyZ3YDpjmbMdHEKUh+4c87yj1a+YHChvVSnD5QK+tM9/0P/IBUJH8WZbw09rAuFSRtPoNSjbLfCtiP97ULRSIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IICPfmg+; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0735aa31-3fc0-4767-9372-23509df751df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726244348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzHB242tVGcnZIVMC2vH42EKkLNNcZB9RNcITbq4g8I=;
	b=IICPfmg+44q75lKxAOccQGhjn640O1CxfRdLcOrkBfgr+GTn4RdyblNcCeraXhT4JfmQmy
	mWT1SFmGnFV+4eTNvUl6DF975O5AUJZWR8keGpk0Z/xA9TNnHjlMYbIaVY1YmWreRjQ2H/
	OeV7y4yhixrz6bQXZREDT42lzFrZ1Q4=
Date: Fri, 13 Sep 2024 12:19:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: Handle threadirqs in __napi_schedule_irqoff
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
References: <20240913150954.2287196-1-sean.anderson@linux.dev>
 <20240913161446.NYZEvAi1@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240913161446.NYZEvAi1@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/13/24 12:14, Sebastian Andrzej Siewior wrote:
> On 2024-09-13 11:09:54 [-0400], Sean Anderson wrote:
>> The threadirqs kernel parameter can be used to force threaded IRQs even
>> on non-PREEMPT_RT kernels. Use force_irqthreads to determine if we can
>> skip disabling local interrupts. This defaults to false on regular
>> kernels, and is always true on PREEMPT_RT kernels.
> 
> Is this fixing a behaviour or is this from the clean up/ make it pretty
> category?

It's in response to [1].

[1] https://lore.kernel.org/netdev/20240912084322.148d7fb2@kernel.org/

> The forced-threaded interrupts run with disabled interrupts on !RT so
> this change should not fix anything.

OK, so maybe this isn't necessary at all?

--Sean

