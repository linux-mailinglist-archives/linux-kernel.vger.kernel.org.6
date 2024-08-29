Return-Path: <linux-kernel+bounces-305992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE849637BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE45C1F2366A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CD81AACB;
	Thu, 29 Aug 2024 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VxWvyHfI"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F214AA9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895122; cv=none; b=pZbrHQxrrz+OkD/KYbAWhg0C+nYKaipw23i0LFxsUj4lXQfmygtMYoQ7fjiBYF/g+54I8Pad9s1eAynMrUbHKmhZ+E0S23lskU62Z4CgDZeNVzhCk0ErnaQHJ7WVygcpKEgxe4VsVUgwtCrE8Aav3K1G6kiyMC6rpDNAjnnikuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895122; c=relaxed/simple;
	bh=FZXPCj00Weq1gLqsglY7RCQ3As7Q0g3sfg7I3DjiDgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffhVudgqROEO1ED3vILXXCt6VzH4uWp9Zxytq9V283d4lvpmHdmzJY5oh3O1jEi8P8g0B3meiCj40EAGy2W/DdVeOI3C4/HylR2mZZIFGMKpuQO4hHYrXJL3HaY/wSGjK9zLPxIiiNgOJuRqBBgftDROo/OEHmpwYVzpNWqk+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VxWvyHfI; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <65c80deb-21e1-44eb-87c9-c7cdd36d77cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724895118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXZzZlfoTAUodWHhNgPTnZa32El/UIbkLZTKOvvacJE=;
	b=VxWvyHfIetlPiuInI6kjCSOyCchp7zCD/gU8HsbzDm9ghVwzEE12Kqo5uIxVRkj54wDxvz
	myNGX5DvKxETQMmMlz9TlzETPO1jB98+yWofAJoIryUyfzqLcC+gYWrC3nu+009tbBc+ce
	br6500aG1W61Pm+j71E1w2DdXL9ynCE=
Date: Thu, 29 Aug 2024 09:31:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] amba: make amba_bustype constant
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux@armlinux.org.uk, krzk@kernel.org, andi.shyti@kernel.org,
 robh@kernel.org, gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
 rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org,
 Kunwu Chan <chentao@kylinos.cn>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
 <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
 <56e29159-3ebb-425a-9bd6-cb66484d7738@linux.dev>
 <ZsxbjnMa8teJ5_Pg@smile.fi.intel.com>
 <5b4987e3-af8a-413f-bbbe-d493d6c371f6@linux.dev>
 <Zs3Wt5xkFOiuH-iP@smile.fi.intel.com>
 <6774cd23-47f9-4d15-8954-a9f749998fe2@linux.dev>
 <Zs8jZiN1TvNfHQ9N@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <Zs8jZiN1TvNfHQ9N@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Thanks for the reply.
On 2024/8/28 21:17, Andy Shevchenko wrote:
> On Wed, Aug 28, 2024 at 10:51:54AM +0800, Kunwu Chan wrote:
>> On 2024/8/27 21:37, Andy Shevchenko wrote:
>>> On Tue, Aug 27, 2024 at 03:45:31PM +0800, Kunwu Chan wrote:
>>>> On 2024/8/26 18:40, Andy Shevchenko wrote:
>>>>> On Mon, Aug 26, 2024 at 06:08:11PM +0800, Kunwu Chan wrote:
> ...
>
>>>>> Make it patch series:
>>>>> 1) patch that introduces exported function called dev_is_amba() (1 patch)
>> Done.
>>>>> 2) convert user-by-user (N patches)
>> I've no idea about how to modify, such as in iommu.c:
> Oh, crap. Yes, this need more thinking.
> Anyway, Russell is okay with your initial patch, the rest can be done
> separately. For now probably we can leave it exported for this only case.
>
Anyway, thanks for the suggestion, i'll   introduce the dev_is_amba 
function

and  add the Suggested tag for you.

If you have a better idea and need me to do it, you can always contact me.

-- 
Thanks,
   Kunwu.Chan


