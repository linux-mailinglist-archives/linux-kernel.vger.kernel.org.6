Return-Path: <linux-kernel+bounces-376203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F409AA185
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB51B280A10
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F310E19CC21;
	Tue, 22 Oct 2024 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVMNpu5C"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86CC19AA53
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598205; cv=none; b=TJBxxj1BuWRg0frC8j5JETm2NfzTtzNeMfNa+iiMWEQpgMigS8DTyR3RDquRK7ypS7iq8j06hFilUJys7aj/pVyinbNRXnnl/tf7n0kn31iL5dTuADSo2QLkws+jH4uTCbkV3aQcjcCzsn7eb4/n+I3KP1rn2W9HSb8topun4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598205; c=relaxed/simple;
	bh=tFbnDcc2saKPQIMvSWMW1XHTW0iXvou7azsccuMFvYY=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=e7dQ6nDW9yF3Oml0VUVDloyCH8AoowJumVvAK1INVDe0J6qpGDziLwdzRo0hUdIDv2UxmD9P83mQVr1XeI8rsQKN4hqI4/X+NAsX3lARP9fudmwIaIbY9MoUhh4dUBiuni0aqaJ78fsY3wk6Ee4N7xFCUGk8nqNzZEHPrqygNIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVMNpu5C; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so5906126e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729598202; x=1730203002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:to:reply-to
         :content-language:references:subject:from:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLsNmlBiU70Vxew4h8MtwpVRlD3xJo63UJc227ISgrM=;
        b=NVMNpu5CylnYV4Sp/CJLBeEWaYBl3sGWtKuWCKuhmwweuuwo6XWcRiLyAU6egqo2k9
         mZeLqNT2zqKkUAvsFDSZHNisdNiAMhuGaHjNsyIb3Qna1zbj35SGWYZRRapXKzrTUZKR
         pNR2+Lt0GEs3SfgTgxGKQJHIHaMi3U3aqaM1/PrbUwWEH+9rXC5FBwWPY2fx5CqfvxWx
         uCA8SVpm7Gy5zB0c0T2UTNrCSajGmq7afxfVQySiEJUFy4tD0CiNOVMerunhqLu23bjT
         1NNVkH0HhMlLThMmCYSQNbw1X6KDdgZL+YAaVzZg0SHdOOZh92EBlFCchgk7sdA5twI0
         fgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729598202; x=1730203002;
        h=content-transfer-encoding:in-reply-to:cc:to:reply-to
         :content-language:references:subject:from:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLsNmlBiU70Vxew4h8MtwpVRlD3xJo63UJc227ISgrM=;
        b=gv94wGGqPtZ1MhWofihs4liExpp4ylsaECLE+MprW+TXCNyFibKoTZR9qvCg+uIy3j
         iHUJ0EkHdTP1b+hHsBxmdOGbEnQ1uMol52iPJGiyP8R8CahcKimsPQhfGt3JrA+sjBXC
         z0kM6/wNQBh2H8lYt8L9kkjiDW2atXnnh475N5UOCDiG5Fi0TEGJ7cjl/vybWYIyKPUI
         MbWlf2ufuDMH2cLHro2SyjGaUNQ9HNR4rjOSv9mbjOOsMwJtXQehO9cTxyG4oFex5lNn
         BcuT7Ng+9z115sSS4fPBGwR0TREhkAbH3Nuj1lHo5zQZcLUW8f85/rX4OC+auYqAog6V
         5y+g==
X-Gm-Message-State: AOJu0YyQWBzcoVHC38VjM6Q1y0SG+A3NNaCRR/ClJ7nyWD5DZZ/Y/uC2
	yNOEtNBhd6Z6wIDdanDK3noFM6y7tmlhAnh1o/P1k6ah9fUjvW3I
X-Google-Smtp-Source: AGHT+IGjU0OA+vAGQ7I2fFXM/kJpohCA2nfbhZ5ZGqzhYkq72FdPxfaliNfGPNiqoaPtMxvlYFiCoQ==
X-Received: by 2002:a05:6512:334d:b0:53b:1625:bcf8 with SMTP id 2adb3069b0e04-53b1625c79fmr676668e87.30.1729598201361;
        Tue, 22 Oct 2024 04:56:41 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5400:7400:850c:5867:abe5:b8c9? ([2a01:e11:5400:7400:850c:5867:abe5:b8c9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6545csm3209752a12.39.2024.10.22.04.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 04:56:40 -0700 (PDT)
Message-ID: <e7f7a0e2-9095-4a8a-9fff-9879c8ca74f5@gmail.com>
Date: Tue, 22 Oct 2024 13:56:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gianfranco Trad <gianf.trad@gmail.com>
Subject: Re: [PATCH] fgraph: fix unused value in register_ftrace_graph()
References: <34014b43-a347-4fa5-b3af-ac65a24453bf@gmail.com>
Content-Language: en-US, it
Reply-To: Gianfranco Trad <gianf.trad@gmail.com>
To: gianf.trad@gmail.com
Cc: linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
In-Reply-To: <34014b43-a347-4fa5-b3af-ac65a24453bf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

--- Redirecting locally, forgot to cc mailing list ---

On 22/10/24 08:56, Steven Rostedt wrote:
> On Mon, 21 Oct 2024 12:24:29 +0200
> Gianfranco Trad <gianf.trad@gmail.com> wrote:
> 
>> Coverity reports unused assignment to value ret. [1]
>> ret is assigned to 0 here, but that stored value is overwritten before
>> it can be used. The overwrite might happen either at line 1277, 1290
>> or eventually at line 1306. Therefore, cleanup the unused assignment.
>>
>> [1] Coverity Scan, CID 1633338
> 
> What does the above mean? For such a simple change, is it really
> unnecessary?
> 

Static analyzer complains that ret is assigned again to 0 there (doesn't 
complain about the declaration phase in which it was already assigned to 
0) but no instructions later make use of this re-assigned value.
Therefore, it flags it as not needed assignment.

>> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
>> ---
>>   kernel/trace/fgraph.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
>> index 41e7a15dcb50..cc2e065c1c8d 100644
>> --- a/kernel/trace/fgraph.c
>> +++ b/kernel/trace/fgraph.c
>> @@ -1262,7 +1262,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>>   			return ret;
>>   		}
>>   		fgraph_initialized = true;
>> -		ret = 0;
> 
> Not to mention that if this is to go, why not get rid of the
> declaration part too? That is:
> 
> -	int ret = 0;
> +	int ret;
> 

I see this, but the static analyzer will actually complain if we get rid 
of int ret = 0 in the declaration phase here, saying something in the 
lines "ret uninitialized at declaration".
To recap, Coverity complains that after declaration ret is assigned 
again to 0 (line 1262) without using this specific re-assignment because 
later on instructions overwrite this value, before it is even used by 
any instruction.

> But still, this code is about to be merged with other code where this
> change may cause issues. This is such a slow path that getting rid of
> the extra initialization may not be worth it.
> 

Understood. This report by Coverity can be considered something trivial, 
so it's up to you what to do. Just wanted to report it and help.

Have a nice day,

-- Gian

> -- Steve
> 
> 
>>   	}
>>   
>>   	if (!fgraph_array[0]) {
> 



