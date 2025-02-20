Return-Path: <linux-kernel+bounces-524306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391DEA3E1A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA8119C5506
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A401B212D86;
	Thu, 20 Feb 2025 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jrRUZpVS"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197B211A2B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070503; cv=none; b=cV3DE39okh7+Xtd7e3eZQPLmCvTD8aUIIjNDJk812mmtrXIG93z7dHVBnVl8DSxNBZOVqiK0ICPgbo/s/iWCFHHb6SXNgloBrMEU5wrQBdokRsqQdmg20loy1Zh7pwYLu+qM/Mri154ut1pn3bpeOS51tfQ5ZastVFWe4lZMSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070503; c=relaxed/simple;
	bh=aEruYy9Jupi+QeIVYrobX1arErkFRLvPPiRVFuahcLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVb39Ica4FxZW4Pltm9jaY1vEN3tLK8zHHR86sFUT3L2LQrVpMBl4ArlPv18c2h76M9EW6T9RWgnQis6hMANqmtAzihZH+EogXRbI2HEeDUInI7yAlquWe6qbKVJneYHxhzFu2Tf2OPsIi3sGmxdozeq4GDaYgrP1+nGYXdyvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jrRUZpVS; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0d729331-fab0-4b59-8d58-ce22e99b269a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740070500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtG6ZjpAmeJKxNeyEoaFjSdFaIwdGa1v9iPU/FPE11Y=;
	b=jrRUZpVSLWy/ItsZGz27gX9dI3AuXjsM0KbdNPZSAfF81twYEgs2mk43kO3PqZb8aNm+Qo
	Ii0C2T4GKl/04TSRZW2ivhjG96n66eqmPWX+tge6PiwXVryAbsjn+f1Z4URT9G2+P15le7
	t5G9+Eg4v2Yqjm1KCiNOClSuQy3QsaI=
Date: Thu, 20 Feb 2025 11:53:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: cadence: macb: Implement BQL
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <20250214211643.2617340-1-sean.anderson@linux.dev>
 <20250218175700.4493dc49@kernel.org>
 <10a50a6c-a6be-4723-80b3-62119f667977@linux.dev>
 <20250220085137.62360239@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250220085137.62360239@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/20/25 11:51, Jakub Kicinski wrote:
> On Thu, 20 Feb 2025 10:55:45 -0500 Sean Anderson wrote:
>> On 2/18/25 20:57, Jakub Kicinski wrote:
>> > On Fri, 14 Feb 2025 16:16:43 -0500 Sean Anderson wrote:  
>> >> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>> >> index 48496209fb16..63c65b4bb348 100644
>> >> --- a/drivers/net/ethernet/cadence/macb_main.c
>> >> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> >> @@ -1081,6 +1081,9 @@ static void macb_tx_error_task(struct work_struct *work)
>> >>  						      tx_error_task);
>> >>  	bool			halt_timeout = false;
>> >>  	struct macb		*bp = queue->bp;
>> >> +	u32			queue_index = queue - bp->queues;  
>> > 
>> > nit: breaking reverse xmas tree here  
>> 
>> It has to happen here since bp isn't available earlier.
> 
> Move it from init to normal code?

That's what I ended up doing.

--Sean

