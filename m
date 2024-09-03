Return-Path: <linux-kernel+bounces-313457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB7196A5AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 475BDB2422C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810A218F2DD;
	Tue,  3 Sep 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R3MwxzxZ"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6B19005F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385543; cv=none; b=NYYZyXGtbUBuwhoTyproJBq6r+AxRpOKntV/fGhjypVlBXVYG8/xhbddq65wbLnAhUKM5/WXEEsURbOC5zAby9R2oFUkxFhsPbXRpJPelkNm+Aghy8+FuB4Yr+0Jw1mvNc1IO+P88k17W9BlcOl6SqJgxhRECZm0+QWz3hBeEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385543; c=relaxed/simple;
	bh=tmLHyBWRKQOXP83hFUC5eqTGxvHhDGqj62+4WSqNhLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1+4LLG7fTw+rlgmRfpfAkqtAOrh6h4lqeXSgd15qA+W4iawqfyIMm/TezOyROtX1Siq3VBbD17SjI0olevRTK9GZWP2xseM//4n9y5kw7HbmlgJcR/7o8yN1S1BNMw6pCwbRO7EmA/eJZG8bstZpNfuWKO6VOJd5oNH0ho/e3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R3MwxzxZ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82a13d1c8f9so245902139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725385540; x=1725990340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CfCUXPwTuKDSS4V+2JDx2g+w3NaNXN4kLDT7fz6YbA=;
        b=R3MwxzxZgwBd2D3rXY82ixVfku9uU+HI5Sueq6caBdIg5Ww1tcImSsVOfPRCp3/CNZ
         2g/hz6HWtJIJdDrH0XLkiT767So23LwmMD8dX1ihf7HwuJ8Q3NhGGuNGVeg0cxOfu7UD
         GznBhJnffkywvNQ1dCbUPUEEZyrS9A0Pq4J0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725385540; x=1725990340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CfCUXPwTuKDSS4V+2JDx2g+w3NaNXN4kLDT7fz6YbA=;
        b=osfFlWjzGZffcMmZgPZxYbIORNueuj8eCIzS03E7hEIOLBzPottGzkZTIN/VqXHYNB
         ldkweDuqU5M3dg68x/rn+3A3pu/eaSiNZ6pkTbkBD04/9/AKFPkvKmVQP9NC9Kua+n9r
         G9KUaBYi2ckvBjutv7OF7vntUCo1YDTwlzKi0HLu8t7q51TtVJ8bmNsbxsxHBNLLeR/P
         Lvkq8EPnSel1iaHvstk8QO1uB/s52S3wVsgP9Y2VeKET0Yju8pmAoa+d0LzI+vs0LSnF
         ELfEd1B8LmdQxJRO19WafPEb1MZTciW0PwxQB9pvXniia4pEoh83a/+Ld4TSKIVfcrtc
         v8Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWYGrHIEeDReuXcxYMroFzuanBwkxWScK3MhzIZlU7kj1sHTqCgAbg1zPf0MCvAQxSC2kRx1FxLSlCP0iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBPFisfwPaszSkm2mj81ijQlBILQ2FjlZ7ske1upJH9rIf10oO
	dePUk405DGOE7GqN2dfqZoAsHPFnF4B7jR5Ui2wX/jtS1eTyZfdA/okKTLb1EG0=
X-Google-Smtp-Source: AGHT+IFj0D0gfLdT8okAc9oFR9k6hi/DKqmjBZCI1iVGf8G9Z3WbgHeoS8IPkBZMqCW9IAWep0jTUA==
X-Received: by 2002:a05:6602:6c0a:b0:82a:3ca1:6f75 with SMTP id ca18e2360f4ac-82a648a0e4emr419865839f.8.1725385539904;
        Tue, 03 Sep 2024 10:45:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2ecd888sm2729179173.156.2024.09.03.10.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 10:45:39 -0700 (PDT)
Message-ID: <405c28dd-bf6d-4f17-92c4-182808182899@linuxfoundation.org>
Date: Tue, 3 Sep 2024 11:45:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: filesystems: fix warn_unused_result build
 warnings
To: Abhinav Jain <jain.abhinav177@gmail.com>, shuah@kernel.org
Cc: javier.carrasco.cruz@gmail.com, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org, brauner@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240810135333.672845-1-jain.abhinav177@gmail.com>
 <5fd97d54-fa64-4c03-865f-961ed4596a6e@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5fd97d54-fa64-4c03-865f-961ed4596a6e@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/16/24 07:11, Shuah Khan wrote:
> On 8/10/24 07:53, Abhinav Jain wrote:
>> Add return value checks for read & write calls in test_listmount_ns
>> function. This patch resolves below compilation warnings:
>>
>> ```
>> statmount_test_ns.c: In function ‘test_listmount_ns’:
>>
>> statmount_test_ns.c:322:17: warning: ignoring return value of ‘write’
>> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>>
>> statmount_test_ns.c:323:17: warning: ignoring return value of ‘read’
>> declared with attribute ‘warn_unused_result’ [-Wunused-result]
>> ```
>>
>> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
>> ---

> Hi Christian,
> 
> Let me know if it is okay to take this patch through kselftest tree.
> The change looks good to me.
> 
> thanks,
> -- Shuah

Thank you for the patch.

Applied to linux-kselftest next for Linux 6.12-rc1

thanks,
-- Shuah

