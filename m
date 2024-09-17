Return-Path: <linux-kernel+bounces-331621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E42D97AF16
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A25B2B747
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF761166F39;
	Tue, 17 Sep 2024 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="qnoXUTuZ"
Received: from smtp86.iad3b.emailsrvr.com (smtp86.iad3b.emailsrvr.com [146.20.161.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D51537C6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569723; cv=none; b=U4ikMa7HSjAc0R0PyjjjD5855K424jT8+VM2+HDrFMjws8M7gj4htsqW5DLmKthlIoYWkUXChH+immODeFwanh9QM1OCXqgqCAOUUWc4tb5glgDw7NPkylczzbeKS1uD/Dv2fAVvDVqtHGoG5h0LqnThliVORwQhz0egnRg60aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569723; c=relaxed/simple;
	bh=LFjC9qvfVz9xY8IYtmTgrBOAqLLEB5YbtKAj0tbNYAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQcLvzQOVHkdmenSYU+y5yAJzhBcM3oQrdJ+bzAjCJq5Q2tvIoIvtdoewBrFYn1JlEOvadDAlmW3ccwujF2TU1WwJTJNnwGPh5EcpkO7E8rhxe6tt6c+dD3pu2A5svz06vleKlx+g6FT1jz9AzvyEUT7rxyjhmSSXeOFhp5C9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=qnoXUTuZ; arc=none smtp.client-ip=146.20.161.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1726568542;
	bh=LFjC9qvfVz9xY8IYtmTgrBOAqLLEB5YbtKAj0tbNYAk=;
	h=Date:Subject:To:From:From;
	b=qnoXUTuZT99MLkyxIpzJMk8ADP1VhOOfEPuYWbw+YuzyPJE8fWR/LYdwTOGCxAuaK
	 jeaqa0l2nUyj7Dxw2PNczFbzn1jHGvIDgsGPfoBT9NiwBqByag6APuqj3HQDO9RLdc
	 zBqol2dcAdxCzG23l80qAreE1wWFjzpGi6cEuOT4=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 4EC644010D;
	Tue, 17 Sep 2024 06:22:22 -0400 (EDT)
Message-ID: <5c3172d8-517f-4d23-a713-fc41406c00d8@mev.co.uk>
Date: Tue, 17 Sep 2024 11:22:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: comedi: ni_tio: Adjust clock period calculation
 in ni_tio_set_clock_src()
To: Aleksandr Mishin <amishin@t-argos.ru>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240917062317.13516-1-amishin@t-argos.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20240917062317.13516-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 42b9c177-b03c-47cc-894b-09293ba44710-1-1

On 17/09/2024 07:23, Aleksandr Mishin wrote:
> In ni_tio_set_clock_src() clock period is a subject to overflow because
> 'period_ns' (which comes from user, may have any value and is not
> validated anywhere) is not cast to a larger data type before performing
> arithmetic.
> 
> Cast 'period_ns' to u64 to prevent overflow.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 3e90b1c7ebe9 ("staging: comedi: ni_tio: tidy up ni_tio_set_clock_src() and helpers")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>   drivers/comedi/drivers/ni_tio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/drivers/ni_tio.c b/drivers/comedi/drivers/ni_tio.c
> index da6826d77e60..98b5b44416cf 100644
> --- a/drivers/comedi/drivers/ni_tio.c
> +++ b/drivers/comedi/drivers/ni_tio.c
> @@ -800,7 +800,7 @@ static int ni_tio_set_clock_src(struct ni_gpct *counter,
>   				GI_PRESCALE_X2(counter_dev->variant) |
>   				GI_PRESCALE_X8(counter_dev->variant), bits);
>   	}
> -	counter->clock_period_ps = period_ns * 1000;
> +	counter->clock_period_ps = (u64)period_ns * 1000;
>   	ni_tio_set_sync_mode(counter);
>   	return 0;
>   }

Thanks.  The patch looks good but since comedi was migrated out of 
staging, it should no longer be tagged as "staging:" in the title.

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


