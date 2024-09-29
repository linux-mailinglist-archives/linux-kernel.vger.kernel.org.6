Return-Path: <linux-kernel+bounces-343103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277DF9896CF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7501C209B5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5C84D8D0;
	Sun, 29 Sep 2024 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/x4qoX6"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92F2C1A2
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727635737; cv=none; b=FXmxjzlHpmH5QpJW99nbPdWYSCnQZ63Ivm3sIn/7DDC5rFV73gUwaoEfl4hI152lErh3axfVbSmdF1/UgFy1tHMzaiMWgqUCaWd8vX6t3Y7tdKbqbfnDE8hN4g6EOlP0VBiU6qwdEzfDknrZrCOwSyBUqOmUKvR0Uyz5YGP2oH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727635737; c=relaxed/simple;
	bh=nUPjYEgAk5KMAMJbfC9ZdcCigam5EcJyg47+7/jI6b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q82NY2ROQtc4XevDSBZJt3ODTUMFHuFkAas19SvEg2+moBPMi64IwFsaTznW8HNuQsm+j+vwCX7ODzXQvbrlyxjalsEFTC41gColZbjDzhMV/YTBN3BCrv48tSBMOctg7qGXymBpepaXDM8Kz5kzGA+9NEfvtHAhCGnOjL5YsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O/x4qoX6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb1e3b449so4977985e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727635734; x=1728240534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be22n4py706xVMqQiIyblI8Bef7MD0N1TCaiC74U/w=;
        b=O/x4qoX6vCPWnzXP+FKqNnFwlhm3NBe9cjKhF9fTjToICt0EfJnaNGRLVxm3d2TESk
         wgzL836qyuSlBH0KCEOKKJ04RWrfp7oOMjBtv9uLWRLERw6tzeBfvrTUW/uhcatlsBLy
         BRfpvLkOpERQg3aKLn6KeVKqlAGmyZmu2+Y2t2U5sBlzT922QYecbsug6PBFdxhFTF/N
         Fgtam4Qhn44bmQmylI6w4C915AIAVPrXTfscvE9ZYcP5aqrSb8Z4Dou2DpUkpG3b45lz
         02TAqq24b7CDkTLtxNHDc0bd8nLfQwGENzaLZTIlK32OfBIpMT0XmwJkwYRmtjIYny/e
         dNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727635734; x=1728240534;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Be22n4py706xVMqQiIyblI8Bef7MD0N1TCaiC74U/w=;
        b=K+V+g1P0O8SqtwDDBVdQU90TKqtCcH9HS5EfQMjk7X1iZ2Fo2q8Bblqpf5UnCdIwrc
         UEQfQQeQMZxSesllk/3ISQrV6kzJFGE0XpT/Xm1jdVNtXPGOBq27vYD3iWp13s5phUQA
         QGbW1NpaKTvXWmWgjm/gy2QqMQbxxTPv9Isc5VcS31quabqHBnRrvb/7bl2/oMtnQ6M1
         gTCgwB8p9ATUoMAbpgVdNMM2sOZEqCsA6BtPZM3L02e6UIYORHmFUofk6yd7uYgPWkyU
         cnRPk6OQ4rAW9PnO5MmsktlvbUUFvxyaHXEHGDb25VfH9sU2e1TLqw8IJ9QAeF/TOgjT
         avfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNI/Sq1YvajJFi5UYyIlZUqsJ9FbJhf2ka3FDH425L1RtSqy6/OlEmP5yY9wvdfXXQ+EvHfUyUkoSiePo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIlh1NbdRjt+/1zO8oIWVPMgwUt1CZqAR2WjD6f/YwrfUSCEog
	qNNqhyt46FQXzF0KfOzPRir/s6lKVsETtu0XZu/LAR0pgrGeXdFg1GryRCG8aUM=
X-Google-Smtp-Source: AGHT+IHECgYt4uZOTNAo47cX5T7GkLzPjvI8LzfSj74mgd/41q5m7wbj5V/0dtZgzd3TRiuzBi6tDA==
X-Received: by 2002:a05:6000:1acb:b0:374:cef0:fd2a with SMTP id ffacd0b85a97d-37cde3f8899mr1718344f8f.7.1727635733743;
        Sun, 29 Sep 2024 11:48:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6875sm7372822f8f.55.2024.09.29.11.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 11:48:52 -0700 (PDT)
Message-ID: <97b2b218-b46e-41a8-9379-09b76569f3f1@linaro.org>
Date: Sun, 29 Sep 2024 20:48:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [heads-up] Re: [PATCH] reset: Further simplify locking with
 guard()
To: Al Viro <viro@zeniv.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240927-reset-guard-v1-1-293bf1302210@pengutronix.de>
 <20240928222702.GX3550746@ZenIV>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240928222702.GX3550746@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/09/2024 00:27, Al Viro wrote:
> On Fri, Sep 27, 2024 at 04:02:32PM +0200, Philipp Zabel wrote:
>> Use guard(mutex) to automatically unlock mutexes when going out of
>> scope. Simplify error paths by removing a goto and manual mutex
>> unlocking in multiple places.
> 
> And that, folks, is a live example of the reasons why guard() is an
> attractive nuisance.  We really need a very loud warning on
> cleanup.h stuff - otherwise such patches from well-meaning folks
> will keep coming.
> 
>> @@ -1041,29 +1036,27 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
>>  		}
>>  	}
>>  
>> -	mutex_lock(&reset_list_mutex);
>> +	guard(mutex)(&reset_list_mutex);
>>  	rcdev = __reset_find_rcdev(&args, gpio_fallback);
>>  	if (!rcdev) {
>>  		rstc = ERR_PTR(-EPROBE_DEFER);
>> -		goto out_unlock;
>> +		goto out_put;
>>  	}
>>  
>>  	if (WARN_ON(args.args_count != rcdev->of_reset_n_cells)) {
>>  		rstc = ERR_PTR(-EINVAL);
>> -		goto out_unlock;
>> +		goto out_put;
>>  	}
>>  
>>  	rstc_id = rcdev->of_xlate(rcdev, &args);
>>  	if (rstc_id < 0) {
>>  		rstc = ERR_PTR(rstc_id);
>> -		goto out_unlock;
>> +		goto out_put;
>>  	}
>>  
>>  	/* reset_list_mutex also protects the rcdev's reset_control list */
>>  	rstc = __reset_control_get_internal(rcdev, rstc_id, shared, acquired);
>>  
>> -out_unlock:
>> -	mutex_unlock(&reset_list_mutex);
>>  out_put:
>>  	of_node_put(args.np);
> 
> Guess what happens if you take goto out_put prior to the entire thing,
> in
>                 ret = __reset_add_reset_gpio_device(&args);
> 		if (ret) {
> 			rstc = ERR_PTR(ret);
> 			goto out_put;
> 		}
> That patch adds implicit mutex_unlock() at the points where we leave
> the scope.  Which extends to the end of function.  In other words, there is
> one downstream of out_put, turning any goto out_put upstream of guard() into
> a bug.
> 

cleanup.h also mentions that one should do not mix cleanup with existing
goto, because of possibility of above issue.

But except careful review, this patch should have been simply compile
tested which would point to the issue above. Any guard/scope works must
be checked with clang W=1, which reports jumps over init.

Best regards,
Krzysztof


