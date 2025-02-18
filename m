Return-Path: <linux-kernel+bounces-519789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68955A3A1F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93045174FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B7190068;
	Tue, 18 Feb 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eq5KNrqP"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5AA158A13
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894430; cv=none; b=TQhQ2BXN1oNV57ppzdhSJu+b3l2dstRYfqUPUG44LTKOwiD7JUaho0vFXONnoat8xJBBWyM52gooJate4IsOXTa26gOQJhOvJf1Nks7GUIz+WPgxOY8SUFalKSjU4y0qnYphOMk04iOUerXnNt2bSYc67/kPUKA+xn1AztbnWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894430; c=relaxed/simple;
	bh=hHtYHj3QkVqLn3+B49q9SZJqcGXO10WYZMImh6cF94A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9TKfDV9eUjOHKp2FzGeMTKluPVHpxlL11KzkX6EccQqSxebatYcdHxlVzmanUWkPMYyljrYjfcBOmRR9ePj0uWafWb43/Ipe8mnb7B3IcyCqTu2gJmxf/6pq2zix2sNxZRXuK7c1HLB9rI4p06w2p+NwMMYN0zY4AEuwABbobc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eq5KNrqP; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <427249dc-87cd-4653-aefc-3b8451b9bf2a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739894416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFEppCOsYoAmws7gd2b+/HH38xoPd7rswtetMcS8tx4=;
	b=eq5KNrqP67mWZTZnNfoWzrmYduP6f92WSsPdajqIuuJOgTJWWMM8LTmyzOSy5SUPltX0Ws
	gOu4V3fI7sEF3JPEWIE2BXB8bz3tWMMnstAp3pgkvPp5uDUa7inrGB3g8DmDRoZ5UM36A8
	BJ+Na7/hwT84+FGwhsOvOi/DH03tUMY=
Date: Tue, 18 Feb 2025 11:00:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] net: cadence: macb: Convert to get_stats64
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
 <20250214212703.2618652-2-sean.anderson@linux.dev>
 <d4e1438f-511a-45c5-8e77-29be1b85e62e@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <d4e1438f-511a-45c5-8e77-29be1b85e62e@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/14/25 17:59, Andrew Lunn wrote:
> On Fri, Feb 14, 2025 at 04:27:02PM -0500, Sean Anderson wrote:
>> Convert the existing get_stats implementation to get_stats64. Since we
>> now report 64-bit values, increase the counters to 64-bits as well.
> 
> It would be good to add some comments about why this is safe on 32 bit
> systems. Are the needed locks in place that you cannot see a partial
> update?

Well, it's no more unsafe than the current code which does RMW without
synchronization. So I guess I'll send another patch to add some locking.

--Sean

