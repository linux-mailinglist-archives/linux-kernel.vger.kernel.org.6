Return-Path: <linux-kernel+bounces-326913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153A5976E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDFF282DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854813DB92;
	Thu, 12 Sep 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rpvQsnS8"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354013D245
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157283; cv=none; b=N1nQSX+RjbqSihj58OH5NxFXmue9upQriP/LwVfwUlI7OGyC8tDsWiIc5kA9ebC79CGkfgIcrcFZs9yWzo0HdulO1NLWZEwK3GeLfgT1LsO5fzQgaVy9ES8DDKJ1UDgzYP1oEwKUVOS6xlpzhfSL7qd56zqodcfHtU6hn4uqvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157283; c=relaxed/simple;
	bh=NiEL1aOUQKcCmhchSWTms+dFdXeS36cHJRZLygWOz2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsGEEvyqOD/7mhvOPiAxyF6uOhu0RXDW7gwVLW8Q8RaJdjdcrUYj2UOMXgLkgmMOZ+6QgZ02sVmKTcd/QgAj/obuXckUWSupMZl1Xowa+NQD3w/+2FquaeAALxA1SkD3RPBlozFM5kENDS0FnmvjqyFabDj4B+YCtp6ZxWuettQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rpvQsnS8; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ee8a13f-8308-42af-86a6-610bcde5f7f3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726157279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFBCYm/EpAKj1YNbowSJMHUtEx3CEWM0kM3TF/YAY8M=;
	b=rpvQsnS82zGRxXybsFKH5tKV5N3Nv3wD3Q3A5lCHljhkZxaFoIfZzlOmbUL+QGjPxZszJN
	e51ucs2xnq88zyXAZD3U2hNefGVtnV+BxwB1nHXWuRcx1W6zmhzuAghmeQTEZkQ4vQ63LF
	24BVXoUX8Oc/RhOI/MVAwAOJNDTbh/E=
Date: Thu, 12 Sep 2024 12:07:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: xilinx: axienet: Schedule NAPI in two steps
To: Jakub Kicinski <kuba@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Robert Hancock <robert.hancock@calian.com>,
 linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org
References: <20240909231904.1322387-1-sean.anderson@linux.dev>
 <20240910185801.42b7c17f@kernel.org>
 <f63bf0ad-2846-4108-9a3f-9ea113959af0@linux.dev>
 <20240912084322.148d7fb2@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240912084322.148d7fb2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/12/24 11:43, Jakub Kicinski wrote:
> On Thu, 12 Sep 2024 10:23:06 -0400 Sean Anderson wrote:
>> __napi_schedule_irqoff selects between __napi_schedule and
>> ____napi_schedule based on whether PREEMPT_RT is enabled. Is there some
>> other way to force IRQ threading?
> 
> I think so, IIRC threadirqs= kernel boot option lets you do it.
> I don't remember all the details now :( LMK if I'm wrong

Hm, maybe __napi_schedule_irqoff should be updated to take that into
account. I will resend without this change.

--Sean

