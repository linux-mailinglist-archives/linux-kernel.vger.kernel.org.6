Return-Path: <linux-kernel+bounces-384946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBAC9B307E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5621C2168C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA2B1DA0ED;
	Mon, 28 Oct 2024 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4VwuCBy"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E524C83
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119166; cv=none; b=uW0YcznNoQGBPMG+rfRyAIMqWFPzuP4RwkwSXCBoqJmMlfAwfuWtd0EY+kpWGxNB7ab6zzC80kq0Y3OEdBiniNo8eHIShgsqJjUZVzs8Mt3gXQC3Bt1HFHghJ9LvLp3L7QFrNG282yzNzX3ZTFuaoZXrRX5OBWwntnfGBdFWs9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119166; c=relaxed/simple;
	bh=Qo2/7zBLH4cKjHHpFrHWpoHmC6NIgUGxkPKknRSZSX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZha7nA/sV+ZRXLhAVTxI3z/7itDejuR2zTAqRUx9IyCdh3dNgKyHU8eGW/7k+09bfxrunx9udXMioRoJv2K4b3RAM/3dSv9/gHitc6hHdkqrJYKNT/aoGw9RPV3pGk4mgZo49oJ369aCQIeShPNG8jqhXAWqIVg1QYzGjGCHrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4VwuCBy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c693b68f5so43405955ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730119164; x=1730723964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U5Sx48grKqHsy37KXM/hKgSyC5WUqWWqfMWmYpRnhJk=;
        b=l4VwuCByIePCmcgOSB6IYbgWH4na0vcFmkB5mDOPRZr/Ivlxn0/e9mNf9Y7mzwmKB/
         nGUn411gnMPxBNzmKSr2bQtautRE/RYOapQDFFRhlbTEDzU7+/vQz23G6WO8N/XbqBoE
         /RXwhGvakNDnYTfewwgJRsXervJP1C3g6Tzct42QaAvUSyf/h2egIXlv6RZ1LR5Z0Gxh
         ZcAFhJQCEMJoiX8sHc8yZGfDLbIxXKfK/chkA05dWYWRwwR5sru+QcO/LQ7a8EIgkL7Q
         ij6/YvZ3D5lobfq63yGI3mfhvGE8uhZD7+p1XDKyFkGCuprdcW+mASpQ1r0lE5VxNnxU
         aO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119164; x=1730723964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5Sx48grKqHsy37KXM/hKgSyC5WUqWWqfMWmYpRnhJk=;
        b=ZSNjhgNBkSavLrONc/Gzj9O4yVy6RGlYPdFowMBge6NagmcxD/L7CmA9dAZ3vpPTd6
         f317rrhvFa+ny6I+7VctoB+qL1IZHZpUw081Qg8oNqrIr+OlwnZe82YnjenVuIwyCnUs
         dJSkyTC3NplvMRlEMbSg7at8dkatOfWJAx9d6kLEsZ/1T8M8AKjHvdrOgO0qctl2VKd3
         6XjRoMwHQbpuxhnJubLvhZWuNAdEDOGqoXRPKjDk9dKdjDtPtZ9gHTU1oa/RM1W+OEdl
         hSsLDxiD8Kczj3RttYtaCI56IstDbcZN8bgC55tdq3XBPebx9/mleMEWJzA4ONMTXx3i
         y2zg==
X-Forwarded-Encrypted: i=1; AJvYcCW0AzTCaTk/l9xzwX8k+sHhmKkdPWItUo/32jYgegllGuC+BOUAIJdG3F73UPN6Z7RJcbkrHgQNK+guCU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2YG47qnFHjixNWI9YzEGSZ1iJ2XpLB333xtgC45EVEbS9Lnp
	4Fe6l/tLDCrv2z/ODmKEPb19oAuEFStn17o51Z8nyf89aKtD/C5JCDhnUw==
X-Google-Smtp-Source: AGHT+IFAF961EGwJJAgzOy0d64udLQNZhrCkOyeyGuTZN2uShdoAYIVwh5mdVFeMziYjbrJwJt4dsg==
X-Received: by 2002:a17:902:da8f:b0:20b:ce30:878d with SMTP id d9443c01a7336-210c6ae2174mr119702315ad.23.1730119163546;
        Mon, 28 Oct 2024 05:39:23 -0700 (PDT)
Received: from ?IPV6:2405:204:5403:2960:cfd7:84a5:5418:bd66? ([2405:204:5403:2960:cfd7:84a5:5418:bd66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf88490sm49578975ad.114.2024.10.28.05.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 05:39:23 -0700 (PDT)
Message-ID: <7906ba56-e476-4836-ad33-2504b2f635e1@gmail.com>
Date: Mon, 28 Oct 2024 18:09:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: Fix null pointer dereference in
 gb_operation_response_send()
To: Peter Seiderer <ps.report@gmx.net>
Cc: johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
 greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20241027075304.7301-1-surajsonawane0215@gmail.com>
 <20241027145754.78cff9c4@gmx.net>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <20241027145754.78cff9c4@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/24 19:27, Peter Seiderer wrote:
> Hello Suraj,
> 
> On Sun, 27 Oct 2024 13:23:04 +0530, Suraj Sonawane <surajsonawane0215@gmail.com> wrote:
> 
>> Fix an issue detected by the Smatch static tool:
>> drivers/greybus/operation.c:852 gb_operation_response_send() error:
>> we previously assumed 'operation->response' could be null (see line 829)
>>
>> The issue occurs because 'operation->response' may be null if the
>> response allocation fails at line 829. However, the code tries to
>> access 'operation->response->header' at line 852 without checking if
>> it was successfully allocated. This can cause a crash if 'response'
>> is null.
>>
>> To fix this, add a check to ensure 'operation->response' is not null
>> before accessing its header. If the response is null, log an error
>> message and return -ENOMEM to stop further processing, preventing
>> any crashes or undefined behavior.
> 
> False warning (?) as the complete code is as follows:
> 
>   823 static int gb_operation_response_send(struct gb_operation *operation,
>   824                                       int errno)
>   825 {
>   826         struct gb_connection *connection = operation->connection;
>   827         int ret;
>   828
>   829         if (!operation->response &&
>   830             !gb_operation_is_unidirectional(operation)) {
>   831                 if (!gb_operation_response_alloc(operation, 0, GFP_KERNEL))
>   832                         return -ENOMEM;
>   833         }
>   834
>   835         /* Record the result */
>   836         if (!gb_operation_result_set(operation, errno)) {
>   837                 dev_err(&connection->hd->dev, "request result already set\n     ");
>   838                 return -EIO;    /* Shouldn't happen */
>   839         }
>   840
>   841         /* Sender of request does not care about response. */
>   842         if (gb_operation_is_unidirectional(operation))
>   843                 return 0;
>   844
>   845         /* Reference will be dropped when message has been sent. */
>   846         gb_operation_get(operation);
>   847         ret = gb_operation_get_active(operation);
>   848         if (ret)
>   849                 goto err_put;
>   850
>   851         /* Fill in the response header and send it */
>   852         operation->response->header->result = gb_operation_errno_map(errno)     ;
>   853
>   854         ret = gb_message_send(operation->response, GFP_KERNEL);
>   855         if (ret)
>   856                 goto err_put_active;
>   857
>   858         return 0;
>   859
>   860 err_put_active:
>   861         gb_operation_put_active(operation);
>   862 err_put:
>   863         gb_operation_put(operation);
>   864
>   865         return ret;
>   866 }
> 
> Lines 829-833 make sure that in case of '!gb_operation_is_unidirectional()'
> 'operation->response' is allocated (in case of failure early return with
> 'return -ENOMEM')
> 
> Lines 842-843 do an early return in case of 'gb_operation_is_unidirectional()'
> 
> So no chance to reach line 852 without 'operation->response' is allocated...
> 
> Regards,
> Peter
> 
>>
>> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
>> ---
>>   drivers/greybus/operation.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
>> index 8459e9bc0..521899fbc 100644
>> --- a/drivers/greybus/operation.c
>> +++ b/drivers/greybus/operation.c
>> @@ -849,7 +849,13 @@ static int gb_operation_response_send(struct gb_operation *operation,
>>   		goto err_put;
>>
>>   	/* Fill in the response header and send it */
>> -	operation->response->header->result = gb_operation_errno_map(errno);
>> +	if (operation->response) {
>> +		operation->response->header->result = gb_operation_errno_map(errno);
>> +	} else {
>> +		dev_err(&connection->hd->dev, "failed to allocate response\n");
>> +		ret = -ENOMEM;
>> +		goto err_put_active;
>> +	}
>>
>>   	ret = gb_message_send(operation->response, GFP_KERNEL);
>>   	if (ret)
> 
Hello Peter,

Thank you for the feedback. I understand your point about the existing 
checks ensuring operation->response is allocated before line 852. It 
seems this might have been a false positive from the static analysis tool.

Once again, thank you for your time and consideration.

Best,
Suraj

