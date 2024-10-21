Return-Path: <linux-kernel+bounces-375063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD119A906A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BB41C22949
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2CC1DFD81;
	Mon, 21 Oct 2024 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YJVnyRe5"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8671DE8A8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540610; cv=none; b=tsk/iI+vBD7RillfKGaYR5l805F71ax/dxq+p+bA2CNTL/1vxopoDG4vqmkjkOTD+Qx0o5DovwCJTbFmB8YnC3x2536lh6GfQx7ujNoCC9i9w4HAikVy9VtN5cud2XiP1iW8L344ub3SJyK3Zry3madzQBYV5YSauj3Mqh0d0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540610; c=relaxed/simple;
	bh=MnLEmxJdsXsn+v7/99E5CG1QnMj9a+ZYbaS/Jkzq7gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBJU+Y+PX8HGKWq+emirEv2KoXgrNulrA6uaaJ2Hg744tJx5tNR3FpY+LWTFP8s8j383Dva5k7kodu4bOp4ZelyWT9wFbUAtyKiCr0Bi1yD6FG2xbJuXQDdWniB19ZctJn7w3p23QUGzTxNU+znJPMzYzd403mL7KMf/WiknaQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YJVnyRe5; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83abf71f244so111218939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729540607; x=1730145407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BKtvcLNNbnKyTJESM7K49WGT/3tZCTVPbN8br2xiYtU=;
        b=YJVnyRe5TNjzaQxaluSlrjKoLibdJ3ZPElD3ifU9vF2K4c4ITudKHAUzgoHJzkl6By
         TyaBHxf7s4V5q3XX3mp64tafwIhMYiTR2eLb0FseU7fN9mKkoCui7X7l/10oGOXUIifr
         5tpI2TJIc4QMSdC30fFIWPa2oAXJ1cNtJqQD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540607; x=1730145407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKtvcLNNbnKyTJESM7K49WGT/3tZCTVPbN8br2xiYtU=;
        b=LTT9fvEOHdgOterTLlTYD3g0euTz+3Mj3P03N31gTSnzOEXpaZ6QrzpuvAbScIQnvi
         Xn07wLaJG3AH3PAtfLy2ABc5Q7c2tHmGLvYgE/yH7+T/tl+Htn7guVfwnH6cMPO8/z/K
         msHLxE2LKAtkRUQcRfj0K/1rVffVnOIHYcel/9KDWWLDbgpp3PV0VlxNFrAUwyWlodeG
         1+dCrf61keSgmMLqxb7m5Raq7dOPNwlVcZzq6p/ikF9AYapqYDbY3af5CK8ioW6PfCgw
         7mjeMoU2HeRNhA8kMJWZmToJ0kNVX9tgs1+v2T7EdDRRA9eWgHf1GvQROAhWnMgc3r89
         clyA==
X-Forwarded-Encrypted: i=1; AJvYcCXANFknwPK5/q1IGxuCC7mynwjh1vay25kTZyR0z+aw6ffjdBtCNF2Vih+tQTJRDxreyuKu/GhnU0CT1LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLEdlTFbhctzRfdgasz0xiE9vJjs5IjHloVFtEev4Gd9KjKX1
	EMOwEMYJIiT7THgsIrfpQwjR1hYvAGnsxZ1aGO2CHjRt6xr5y1V8kwNIZyDNUVM=
X-Google-Smtp-Source: AGHT+IFnTKl5fie6QN3CpJBPY+QHA/jpyUzP4xZHWb8Y++Xvm5l4LaNl1rzIJP3NZYAZOH2JoWTueg==
X-Received: by 2002:a05:6602:6d14:b0:83a:639b:bc44 with SMTP id ca18e2360f4ac-83aea8e14edmr30545639f.3.1729540607491;
        Mon, 21 Oct 2024 12:56:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a52fb45sm1198309173.6.2024.10.21.12.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 12:56:47 -0700 (PDT)
Message-ID: <26673670-6e3b-49fc-b66d-26362bde6590@linuxfoundation.org>
Date: Mon, 21 Oct 2024 13:56:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: chemical: sps30: Add Null pointer check
To: Karan Sanghavi <karansanghvi98@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Karan Sanghavi <karansanghavi98@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241018-cid1593398badshift-v1-1-11550a10ff25@gmail.com>
 <20241019122133.13d59dfb@jic23-huawei>
 <upme6hy6sroszgdhj7ucg6iksxuim26grhgaypegu2vzdtsp6z@ne33c5yhbhe2>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <upme6hy6sroszgdhj7ucg6iksxuim26grhgaypegu2vzdtsp6z@ne33c5yhbhe2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/24 06:08, Karan Sanghavi wrote:
> On Sat, Oct 19, 2024 at 12:21:33PM +0100, Jonathan Cameron wrote:
>> On Fri, 18 Oct 2024 18:54:42 +0000
>> Karan Sanghavi <karansanghvi98@gmail.com> wrote:
>>
>>> Add a Null pointer check before assigning and incrementing
>>> the null pointer
>>>
>>> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
>>
>> It would be a bug if rsp_size was anything other than 0 and rsp is NULL.
>> So this looks like a false positive as the loop will never be
>> entered.
>>

This routine checks rsp in the earlier logic

	if (rsp) {
                 /* each two bytes are followed by a crc8 */
                 rsp_size += rsp_size / 2;
         } else {
                 tmp = arg;

                 while (arg_size) {
                         buf[i] = *tmp++;
                         buf[i + 1] = *tmp++;
                         buf[i + 2] = crc8(sps30_i2c_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
                         arg_size -= 2;
                         i += 3;
                 }
         }
  	
	ret = sps30_i2c_xfer(state, buf, i, buf, rsp_size);
         if (ret)
                 return ret;


Looks like the  tmp = rsp; could be reached depending on the
sps30_i2c_xfer() return value?

Maybe this isn't the right fix but looks like the code could
use looking into for accuracy.

>> How did you find it, in particular have you managed to trigger this
>> in the driver?
>>
>> Jonathan
>>
>>
> 
> I found this bug in Coverity scan with Cid: 1504707.
> Link below, for the same.
> https://scan7.scan.coverity.com/#/project-view/51946/11354?selectedIssue=1504707
> 
> Rsp here is a void pointer received from the function arguments
> which can be NULL for a no respone call.
> Thus incrementing the NULL pointer can lead to some unexpected
> behavior which cross my mind thus added the check.
> 

thanks,
-- Shuah


