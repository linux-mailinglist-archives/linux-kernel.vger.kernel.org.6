Return-Path: <linux-kernel+bounces-371199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D696F9A37BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78168282D58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CFD18C334;
	Fri, 18 Oct 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CF/z+XZT"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9BD18C031;
	Fri, 18 Oct 2024 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238112; cv=none; b=j4CcuAsUs+gezo4d55NMzasTmQNpmykVZanbOP1V/775uTmgnlATldCtp4M6FTEuaU/vEqU7m0c+2D2qRUMQzbFUetxX+De64eQBJEwoGN1306hQBqdDtnQL/2Yza8bS3Rnp851+TkIcjnADPv1F6poOJuFB/a4yDVSh1NPHFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238112; c=relaxed/simple;
	bh=SlomN5juD1cQe+jLGH3mhG6rPxQkxBNtyubBhNNoqfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUII6Nftcki1zWitHjUtTDXHT9zoisikpogaEPi80r/Vj0qeF5ysGaShSlShgv3MVgsesdcQ2xR9/0dHJgEOyLFfIPVkrI71jn8UI/G34AEGR9o+FRP4AsKUl6AQTZEi9hMjZ4FzwBNqG6WG+pmepvCKn6vlTSVmwNw/t/6hF10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CF/z+XZT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.96.144] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86DEF20FC61D;
	Fri, 18 Oct 2024 00:55:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86DEF20FC61D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729238105;
	bh=mMyrEuEiCBQF7MHoAC5SVn0Ee1mUiVPLMQo+UXbUTk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CF/z+XZTlwxeV14iuxX5KoxPIkBM5azmc9ijJUEmdWj9PW/BgFyAHT0sVFGS6C/zd
	 yYgmjyWaoE7tgb3FyvO0Fuvc+mfnIkPfqYsoMqKmlp1+4FZvIMCk61QG5+21g3Bil8
	 z/GZz5OwKArw6o/hZMB4TaSxTiCmXXwRyBc/2J6U=
Message-ID: <9f4baf14-8182-451d-9849-4326a783d5c1@linux.microsoft.com>
Date: Fri, 18 Oct 2024 13:24:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drivers: hv: Convert open-coded timeouts to
 msecs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>, lkp@intel.com,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Naman Jain <namjain@linux.microsoft.com>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>
References: <20241016223730.531861-1-eahariha@linux.microsoft.com>
Content-Language: en-GB
From: Praveen Kumar <kumarpraveen@linux.microsoft.com>
In-Reply-To: <20241016223730.531861-1-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17-10-2024 04:07, Easwar Hariharan wrote:
> We have several places where timeouts are open-coded as N (seconds) * HZ,
> but best practice is to use msecs_to_jiffies(). Convert the timeouts to
> make them HZ invariant.
> > Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/hv/hv_balloon.c  | 9 +++++----
>  drivers/hv/hv_kvp.c      | 4 ++--
>  drivers/hv/hv_snapshot.c | 6 ++++--
>  drivers/hv/vmbus_drv.c   | 2 +-
>  4 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index c38dcdfcb914d..3017d41f12681 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -756,7 +756,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  		 * adding succeeded, it is ok to proceed even if the memory was
>  		 * not onlined in time.
>  		 */
> -		wait_for_completion_timeout(&dm_device.ol_waitevent, 5 * HZ);
> +		wait_for_completion_timeout(&dm_device.ol_waitevent, msecs_to_jiffies(5 * 1000));

Is it correct to convert HZ to 1000 ?
Also, how are you testing these changes ?

Regards,

~Praveen.

