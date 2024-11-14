Return-Path: <linux-kernel+bounces-409001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C169C863C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C66F1F22AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7701F6669;
	Thu, 14 Nov 2024 09:34:27 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 41B081E9089;
	Thu, 14 Nov 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576867; cv=none; b=je/fltEY2DAm+athIV8fzVaYLF6Oaq9g3tfX3GC/+bxrUZ5nnbpEEUvHQgBc6Q+Cw0qdee5UGm9BaJVX7D++LmT8XodwwCMvPTy5SZ1H16Au/+x25Lz/8mtFjmJVB/q86/mw+zNnzzXFA4OjVGvU5ARBp+zF0xrb0dxiuw2+vgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576867; c=relaxed/simple;
	bh=myrJcA/kaJM9MSdwEkR2gSyVF5erP6z7ffO5TOvnsNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=rk5yWoIdZWV/gkIK3r8x90qC3HaxDWCLNzkgKQyTwsSSO9O7wJ+teOEQMfSwpacU8tya60wAIYPr6IwLzUdQqZj9IFqrDBEmLu4bvxd5Gxs5rhtEJfjlvON7kdQPYOHoI85mtmBYxqf1PnJZIUJtFBDf/TFD36BlGejSnfoAWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 6D581613746FC;
	Thu, 14 Nov 2024 17:34:18 +0800 (CST)
Message-ID: <3c35be8b-95e2-1ee6-9745-7766008fd1f6@nfschina.com>
Date: Thu, 14 Nov 2024 17:34:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] bus: fsl-mc: Fix the double free in fsl_mc_device_add()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stuyoder@gmail.com, laurentiu.tudor@nxp.com, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <b767348e-d89c-416e-acea-1ebbff3bea20@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/14 16:57, Dan Carpenter wrote:
> On Thu, Nov 14, 2024 at 11:41:25AM +0300, Dan Carpenter wrote:
>> On Thu, Nov 14, 2024 at 04:27:52PM +0800, Su Hui wrote:
>>> Clang static checker(scan-build) warning：
>>> drivers/bus/fsl-mc/fsl-mc-bus.c: line 909, column 2
>>> Attempt to free released memory.
>>>
>>> When 'obj_desc->type' == "dprc" and begin to free 'mc_bus' and 'mc_dev',
>>> there is a double free problem because of 'mc_dev = &mc_bus->mc_dev'.
>>> Add a judgment to fix this problem.
>>>
>>> Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")
>>> Signed-off-by: Su Hui <suhui@nfschina.com>
>>> ---
>>>   drivers/bus/fsl-mc/fsl-mc-bus.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>> index 930d8a3ba722..8d2d5d3cc782 100644
>>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>> @@ -905,8 +905,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>>>   
>>>   error_cleanup_dev:
>>>   	kfree(mc_dev->regions);
>>> -	kfree(mc_bus);
>>> -	kfree(mc_dev);
>>> +	if (strcmp(mc_dev->obj_desc.type, "dprc") == 0)
>> This works, but it would probably be nicer to write this as:
>>
>> 	if (is_fsl_mc_bus_dprc(mc_dev))
>> 		kfree(mc_bus);
>> 	else
>> 		kfree(mc_dev);
>>
>> That way it would match the release function.
Yes, it's better!
>     820          mc_dev->dev.release = fsl_mc_device_release;
>
> 	[ snip ]
>
>     891           * The device-specific probe callback will get invoked by device_add()
>     892           */
>     893          error = device_add(&mc_dev->dev);
>     894          if (error < 0) {
>     895                  dev_err(parent_dev,
>     896                          "device_add() failed for device %s: %d\n",
>     897                          dev_name(&mc_dev->dev), error);
>     898                  goto error_cleanup_dev;
>
> I don't think this goto is correct.  I think fsl_mc_device_release() will be
> called automaticall on this path so the goto is a double free.
Agreed too, maybe using put_device(&mc_dev->dev) to replace ?
>
>     899          }
>     900
>     901          dev_dbg(parent_dev, "added %s\n", dev_name(&mc_dev->dev));
>     902
>     903          *new_mc_dev = mc_dev;
>     904          return 0;
>     905
>     906  error_cleanup_dev:
>     907          kfree(mc_dev->regions);
>     908          if (is_fsl_mc_bus_dprc(mc_dev))

Yep, this looks better :)

I will send a v2 patch to use is_fsl_mc_bus_dprc().
It might take some time because I'm not sure about using
'put_device(&mc_dev->dev)' to replace 'goto error_cleanup_dev'.

regards,
Su Hui


