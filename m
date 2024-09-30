Return-Path: <linux-kernel+bounces-343273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 867209898FD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6111F21B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408CF79EA;
	Mon, 30 Sep 2024 01:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IdhQP2pj"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F202CA2
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727660376; cv=none; b=YCc87G6jG35jBTRwlezelWRyUw4OEDcH9xnRvV3gZifI2+GTbT7r39gYCjL6WQxi65ZkZtRMT8c4k7Kdhi6WldJqlRmBAilTWenh42yX0Nvz02mkmd7vR+yO3hHFBQkSxIsDHwLUbt9aeihu3OVhm0Jw1BoCz0mjqNuMK0ob2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727660376; c=relaxed/simple;
	bh=rg3+ZaIKPQIuaIo8I9fHK/6VgqiaSpXLidc/ska4nXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/UZkYQVi4p3tpsN9KSUlTDmfN2ekzZdkfX2XOsNck676SujvYVdI7Ymr8KZyruUq3kQYKZ3eRqwsBYBE8CMgTTSFrXCM0o0UfN9St8VzIayTCE8Q04GDKhTWWgPiXnGpk7k6mKNIblyNfD+bNXwU0ZKDNiD+uK4eyRyHApw3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IdhQP2pj; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e3688d85-5cab-41b9-a77f-d1229d9c3b5c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727660371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAY7TPcfuJe9Y1D5+TkGWlwCmuxBEheRTYpfat8WovA=;
	b=IdhQP2pjWP8TOwERDUGjnrxKVJWNNfrPpojiK4eEJq4rjXoYmtFy5cE3tkIF57hrN+GqhN
	vtNtogk8G/cd35fbchHv4U5ESfEnflYTOjMUcV5K5/cFNBvFlG/gdLHFGI2kJnq2ULTuLS
	KSVsDnzjpZRi9tK++A5d+bVva8vKB50=
Date: Mon, 30 Sep 2024 09:39:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] amba: Add dev_is_amba() function and export it for
 modules
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Rob Herring <robh@kernel.org>
Cc: saravanak@google.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240923094249.80399-1-chentao@kylinos.cn>
 <20240923094249.80399-2-chentao@kylinos.cn>
 <20240924222857.GA404805-robh@kernel.org>
 <ZvNAr0d5gYmuM+Zt@shell.armlinux.org.uk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <ZvNAr0d5gYmuM+Zt@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Thanks for the reply.

On 2024/9/25 06:43, Russell King (Oracle) wrote:
> On Tue, Sep 24, 2024 at 05:28:57PM -0500, Rob Herring wrote:
>> On Mon, Sep 23, 2024 at 05:42:47PM +0800, Kunwu Chan wrote:
>>> Add dev_is_amba() function to determine
>>> whether the device is a AMBA device.
>>>
>>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>> ---
>>>   drivers/amba/bus.c       | 6 ++++++
>>>   include/linux/amba/bus.h | 5 +++++
>>>   2 files changed, 11 insertions(+)
>> Russell, Can I get an ack for this to take it with patch #2.
> Would be nice to discuss "how shall we merge this cross-subsystem
> patch series" first, hmm?
>
> The reason I didn't take patch 1 originally is because it was submitted
> to me without any users, and the general principle is not to accept
> patches without users. Too many times, I've merged code where there's
> been a "promise" that it will be used, only to have the author go
> silent and users never come along. So now, my rule is... any code that
> adds something must also come with its user.
>
Just one user in drivers/of/platform.c right now.

Actually, I don't know if dev_is_amba will use it more in the future.

So we keep the usage of  "dev->bus == &platform_bus_type " too?
Although here come a wrapper function "dev_is_platform".

-- 
Thanks,
   Kunwu.Chan


