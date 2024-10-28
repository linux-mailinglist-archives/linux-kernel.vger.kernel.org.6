Return-Path: <linux-kernel+bounces-384966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C421A9B30BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828DB2820A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A441DD525;
	Mon, 28 Oct 2024 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfg9Xx0i"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8441DB527
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119418; cv=none; b=qdL8K7Yo1K6ZsMt4r/ExlTdxFKGIDP2GY2twFJwCzXM8klBUdvdJs73J4+mz6+etJmVKNGm+IXowuA8ieb1M5KwIqrAi2lAv42nz6e3ve2VkthEJvY7Xi45UYCQXRy6ZolAFSnglRUfUAkyCLwqhysFEYICcgvGWg1fub1cagJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119418; c=relaxed/simple;
	bh=BXJ7Fa6rgi1Gkae8JEWMfGzU85rJWbX4anRz/PAmyvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGOYbssNeFLHvfhXWeWElEam5Qxun80GvFQSstHLFl2iSYZPukgJ8QXf3xFpZhVF8oUPgB/N3f9tqqI5WsOxntyDijNX428bTJv9ZMb7QERKhtV48dvIsxVrBa8hUC2q97z3NiVoJkBYVwClICeUxW5zIbSAG6wPA2OdZ3/lt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfg9Xx0i; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7edb6879196so2584047a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730119416; x=1730724216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3FRgGM16VBkuEgKEXxMtfKp/CCHFRbja8EXJUXlUni0=;
        b=nfg9Xx0iNysX9R417sq+inl3SSyfnHPVxVOsGAMR1M2fw4V5zlHlN6VPTBHC2ntsGl
         OxtEhzWAkGe0pFyL8sFQS8yUjI78MsUQA7KpRuY5ALTcf5MTxvJi8b2pTsaGkrWy28rm
         6HppVotco+RSI6zmjAQJ101CUWbDHrEM2YIYnQjdyl/Am3YMC8tlYMiB4adpFCGpQmcf
         TOHFIXu/7NGXlsuC1s76hgGPBz5xBfV7djeSBN0VX5d5faP5le19yGPFbRVickeXAA/2
         QOPyKktp1QSor131LCH/URF7wnaYERnsN0oYo+zsNJJ4Z4rPEZxyzhpqD6veefhiXWKG
         PICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730119416; x=1730724216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FRgGM16VBkuEgKEXxMtfKp/CCHFRbja8EXJUXlUni0=;
        b=B+q8cePNdV+LoO4abeBIDFDdELvAvrycPorxyz75Da+SsqyuPiAe6NQW8KuvBIrKRn
         SWB/NOUwz8JJrDUpIVHoVDOq/s+SjBArpka8f+ZbCjrNZ5WbfXxpulY6t85coJsNyVUf
         +PZHvfSOZ/by9aBxZJK9UX/N9Cy5BDFt2aZtE1Bmqfrd+EtrH085wwj2IpxVXgTBUbfd
         bLKXUiFmAIqBpZh5ILsEqQpD/RLps/Tt2iKQaF/4QPkVWIWwCupwf5AOduyKluVrQru5
         dbJTz2xjUMQvVDf+ibbSQhIGT3eON67MFjVOU7rwn36FGJ5C0v79+uaviPgGO3Ko8iDk
         Ukug==
X-Forwarded-Encrypted: i=1; AJvYcCVrCgNQNPnfuSDHflHBQ5Hkeyd6+FUcNLi77MAIUou47MlNKH1ym+lGYv6TtKL2DAfjEoTKPhcmJ/tCl+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJylohgdrJycIbTS7OnFPI3v1PGR91vSSdk/O4NDlNjk7YXTY
	P4ev1/TJcJJJyKJ/bQQQxf06UMIy3h/0DK4OfjVQrKULxDBN1MZm
X-Google-Smtp-Source: AGHT+IEan3pVYKpKAUNOnEppg/1Kzl65VAn8UbEyWi+0ByplnVFp49k1faXy9FP+s839bq4vvWCr5w==
X-Received: by 2002:a05:6a20:c793:b0:1d5:144b:5941 with SMTP id adf61e73a8af0-1d9a840afc8mr11042289637.28.1730119416031;
        Mon, 28 Oct 2024 05:43:36 -0700 (PDT)
Received: from ?IPV6:2405:204:5403:2960:cfd7:84a5:5418:bd66? ([2405:204:5403:2960:cfd7:84a5:5418:bd66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e4dasm5577827b3a.25.2024.10.28.05.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 05:43:35 -0700 (PDT)
Message-ID: <c2e81a50-3716-4ee9-9ada-5d4d9287e564@gmail.com>
Date: Mon, 28 Oct 2024 18:13:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: Fix null pointer dereference in
 gb_operation_response_send()
To: Alex Elder <elder@ieee.org>, johan@kernel.org, elder@kernel.org,
 gregkh@linuxfoundation.org
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20241027075304.7301-1-surajsonawane0215@gmail.com>
 <106ff2db-befc-4899-8f28-6f8b6276cdd3@ieee.org>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <106ff2db-befc-4899-8f28-6f8b6276cdd3@ieee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/10/24 19:30, Alex Elder wrote:
> On 10/27/24 2:53 AM, Suraj Sonawane wrote:
>> Fix an issue detected by the Smatch static tool:
>> drivers/greybus/operation.c:852 gb_operation_response_send() error:
>> we previously assumed 'operation->response' could be null (see line 829)
> 
> There is no need for this.  This is a case where the code is
> doing something that is too involved for "smatch" to know
> things are OK.
> 
> A unidirectional operation includes only a request message, but
> no response message.
> 
> There are two cases:
> - Unidirectional
>    - There is no response buffer
>    - There will be no call to gb_operation_response_alloc(),
>      because the operation is unidirectional.
>    - The result gets set with the errno value.  If there's
>      an error (there shouldn't be), -EIO is returned.
>    - We return 0 early, because it's a unidirectional operation.
> - Not unidirectional
>    - If there is a response, we attempt to allocate one.  If that
>      fails, we return -ENOMEM early.
>    - Otherwise there *is* a response (it was successfully allocated)
>    - The result is set
>    - It is not unidirectional, so we get a reference to the operation,
>      add it to the active list (or skip to the end if not connected)
>    - We record the result in the response header.  This is the line in
>      question, but we know the response pointer is good.
>    - We send the response.
>    - On error, we drop or references and return the error code.
> 
>                      -Alex
> 
> 
> 
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
>>
>> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
>> ---
>>   drivers/greybus/operation.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
>> index 8459e9bc0..521899fbc 100644
>> --- a/drivers/greybus/operation.c
>> +++ b/drivers/greybus/operation.c
>> @@ -849,7 +849,13 @@ static int gb_operation_response_send(struct 
>> gb_operation *operation,
>>           goto err_put;
>>       /* Fill in the response header and send it */
>> -    operation->response->header->result = gb_operation_errno_map(errno);
>> +    if (operation->response) {
>> +        operation->response->header->result = 
>> gb_operation_errno_map(errno);
>> +    } else {
>> +        dev_err(&connection->hd->dev, "failed to allocate response\n");
>> +        ret = -ENOMEM;
>> +        goto err_put_active;
>> +    }
>>       ret = gb_message_send(operation->response, GFP_KERNEL);
>>       if (ret)
> 

Hello Alex,

Thank you for your detailed explanation. I understand now that the 
existing code already handles both unidirectional and non-unidirectional 
cases properly, ensuring that operation->response is always allocated 
when needed. It seems the Smatch tool flagged this as a potential issue 
incorrectly.

I appreciate your insights, and I'll make sure to be more cautious about 
such false positives from static analysis in the future.

Thanks again for your time.

Best,
Suraj

