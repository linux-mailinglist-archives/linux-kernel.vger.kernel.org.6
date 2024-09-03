Return-Path: <linux-kernel+bounces-312737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF8E969A84
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C311285669
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A381B9859;
	Tue,  3 Sep 2024 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvRmQNfO"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B031B9849
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360396; cv=none; b=UGhx70SLtZaWkQHTBUxPUVfGorPhpzbkXGVcJRrhVa0VclA0xJzQg+iUbT/RRWRHhGv+dLRzjdcEeuPULL0QpEq8sesNwpxaq1xEoONqn0Wn6ysXKW9/Q3/e1kSAbV0mJDxRG+SNGHl0fiXTpmLpFhPRJV4jYYAIjyiBp23g1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360396; c=relaxed/simple;
	bh=wehNzBtE9b2/qO208isowR5i7B15OzxU4kmmWQMH7C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sB1fA01dqM4DLn4GiGjWwh9N7iDXwirdysDkMwYYy1WaEOQsKbobR7fqjuz5dl1Uqgyd6fItaxj2rEHuUFFRglN4m+5knzI/NqUkF6IV3WUdai5MxpAdWswyotWZNXZZoVThhYNJZpRSm7M1s8JyGMlXzGctQQfZ7Niw/K/Xy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gvRmQNfO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5343eeb4973so7946909e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 03:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725360393; x=1725965193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9h4UaMmJVxnvLvXCud174E5c95sQBkw6G5KmKqalQ68=;
        b=gvRmQNfOWA6nWGzdnI8def+Vh2XFJcthod+/9ADOdFWdLFGqZ4feJBiPHcZz6e+Sgm
         hOuHgtxlFjIBzei6bh0R1keb3hgBeMwPfNifuaPrUubiyEHtrf4QfwqVv5uH//Ihc33n
         1UsK59ra1ptxIvk3J1bp7URZ4CYnT1ppTVmvfV/GE+SkXxDA2d6iu7QVw7t7DsgQGkDJ
         ihMXZBebeZ3gtoFrUjaXVrxvB1wrjGqnfMk81Va1V90nNB2uV7x5xXiWyF7910rMxu3T
         7fOt4MN4+0YdGu3Vk3uzKkVRohMXd9D2gQVz03LkL0Pv2gekMwEN52d2gHmPgCDSXJZP
         yw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725360393; x=1725965193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9h4UaMmJVxnvLvXCud174E5c95sQBkw6G5KmKqalQ68=;
        b=JdzVI2FyUOhbKjObKFf4sBqFI3GT0972gu0vlgrugnvDK1thSHMyoM+IurZkauWrw5
         X07NLMxhwLYiqAJpLIypndQCdEFSaqK7O568dicHuj9bFtA/ZDmQaRSjWqFL8z6bTnwi
         wmshS/EBzLnWaY9ChILP5Lnaj9ere5gjrCUfvC50MElJsrFJpLMM2DuIz/kgGLjSFkeV
         mzWd60QzFCOfwliCOuajGIUQvpM5k5oVh7XgJFxkpp0hB2Lw2krbqjBbpZ9wGh+P8rkW
         dIbCu3PbLHi1X9eT0vxVCapCbq9bzGO1T+80dhI4euuIqCJc40bkliFPsmdCX5VAb5xJ
         hGhQ==
X-Gm-Message-State: AOJu0Ywv3GASfMDVx/nx6gsP22i7VnWaW57q1agTfvFAG2yWkkBeBwHa
	+kwRrjQ1zGdzudcN79VgggS+J/uN4/BBcT3odervx4c4idpcnw7s4yJ0rFTtC8c=
X-Google-Smtp-Source: AGHT+IHznmNPDh4j/BXyqfSQKZtEzd3Fy4fTGbJ1+dZYEAr4elIJDPfEzupeEWU3oAdyHujWJoSOcg==
X-Received: by 2002:a05:6512:33d4:b0:533:4497:9f29 with SMTP id 2adb3069b0e04-53546b55282mr10190173e87.31.1725360392895;
        Tue, 03 Sep 2024 03:46:32 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8989196980sm664942166b.126.2024.09.03.03.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 03:46:32 -0700 (PDT)
Message-ID: <7ffb8938-bd3b-45b0-a7fe-733ea9646ed8@linaro.org>
Date: Tue, 3 Sep 2024 11:46:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] misc: fastrpc: Fix double free of 'buf' in error path
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Sukrut Bellary <sukrut.bellary@linux.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240902141409.70371-1-srinivas.kandagatla@linaro.org>
 <20240902141409.70371-2-srinivas.kandagatla@linaro.org>
 <2024090311-foam-pouncing-fcdd@gregkh>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2024090311-foam-pouncing-fcdd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/09/2024 11:19, Greg KH wrote:
> On Mon, Sep 02, 2024 at 03:14:09PM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Sukrut Bellary <sukrut.bellary@linux.com>
>>
>> smatch warning:
>> drivers/misc/fastrpc.c:1926 fastrpc_req_mmap() error: double free of 'buf'
>>
>> In fastrpc_req_mmap() error path, the fastrpc buffer is freed in
>> fastrpc_req_munmap_impl() if unmap is successful.
>>
>> But in the end, there is an unconditional call to fastrpc_buf_free().
>> So the above case triggers the double free of fastrpc buf.
>>
>> Fixes: 72fa6f7820c4 ("misc: fastrpc: Rework fastrpc_req_munmap")
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/misc/fastrpc.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Any reason you forgot a cc: stable@ on this?
> 
I think it was forgotten.
> I'll go add it by hand...
Thanks for doing this.

--srini
> 

