Return-Path: <linux-kernel+bounces-283758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0681894F876
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96343B2172F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C70A19B595;
	Mon, 12 Aug 2024 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX+Ix2Rc"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495719CCF9;
	Mon, 12 Aug 2024 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495691; cv=none; b=HCITu9x3Rh27FVbl51QSIUmxmDbIotCPc4wGxcbzq0KqPgyEmAjd/WFAEQTEnE9pnSmCNvwfJSnDbES3P6GQO5KT5bw7ZueIbYdLPs8vyIWeToLylujCQ6cGjBFxNM4qXFJmpHvC5wnKla0pU/h+X0ANPSX1YhowQc1pVdDNqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495691; c=relaxed/simple;
	bh=tU84VXth7zOeZ3NG4jpxX1eeZefKjb1ainimwbyNa5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4OHPmPD4w+1M8ysXU3TN3RDGYWrJzmKgV2Fp4mtzL51rXpN5ywKrgEiCmyiWhrzlJGcOpXwAAqinRfiEn7P6osO6gXiFQ4b8xy7+FV/yaBIRwIhqMKlDwSq1mN+EwZ0+4hZfDNWJD1GfNmAs2ITDn0WwpmMOj8nzFQvjbtSl7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX+Ix2Rc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42809d6e719so36629655e9.3;
        Mon, 12 Aug 2024 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723495688; x=1724100488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2WDO6OI2qTPW6NvpZVxre/EnUX5gdt3N/GrComBzoQ=;
        b=QX+Ix2Rc+/qf3QanlfRfWD4xCn52223KO8lr3mB6hJvYNXEtbb9qvZzIKOTuUZplGs
         nfKYK/XjNd6pVvG2arZp2jzWjOLJSDMNVm64LjaC/NXEIOVYrdQ7fpo8r0WXIQIPT/Mk
         ov3elVjlNyhQkWHMFHAMs0SeSDgV8albWUPt6hV4MWOJjEN0pODHFU5sPu7y2YC3nQDf
         98Bq2wdRqqkjDi30tSrkEGtv2dBNMtMA9OJWazhHA+YKLg6N7JSsVScbLwj16ZLk91tt
         HRAT/hX2LBbcgyS9/DEvhsWmHOErZ3X/LuwWKC+dZXHyFRtOIdFKoxZNrFDVnh7itXrF
         ySSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495688; x=1724100488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2WDO6OI2qTPW6NvpZVxre/EnUX5gdt3N/GrComBzoQ=;
        b=iUiRF6jeeLmEOC0p9RCmhJtGhf2c1zknn5xJefEssFeTbXgF6H7ZvilftXPUniS6iO
         bp8VLbOlEfIYIdI+RhZKGizhBy9caxuqKr1g9VQWIeuR5BWDUrzrseuPweMrBse8Dmow
         HzwhlgQHKgGHxz4AmJsv+23aNIiOhCtzcsLQ6eu1Rbf9NhMtqH6ZGfp0E6cWm7qN9VwJ
         yt+thUn9Iwdj3Ycj1BxFNilblLWXi+0XPnGO4U8OeDaekKBAwpHTnaRn4YEpqIzbblZW
         +UqT2F6tprdvJICRYs11HKmbnNso9r5cZ7/uLRwbLACBF4wr+SFf8f3jCzIj5Lb34J5W
         eXLw==
X-Forwarded-Encrypted: i=1; AJvYcCV6pDfTj9Vy06/p5CsifBEi+8gh9HTZscC3shjJbWbPPgTDQtY4iP4YJdMFJj3Gkkg8sY4UyRwC0OFCU5qPgM5QDHSPUiRcTZv8ijcF
X-Gm-Message-State: AOJu0YwxfRn1GMQ8AStoB2tBdW9qd6prNll8RpcDxQzg5pa4VH11EDeU
	guwWvw39km4pR9dpThWbLfaxxntMeKubbWSk1GrlxiyhdZIWR9Op
X-Google-Smtp-Source: AGHT+IGF2OahVmdEGp9XqUsqfmuP7orkd9D5Xxfrr30QwactA/2r3T0UuMiYlxmSA0hgJlkMuUVN+A==
X-Received: by 2002:a05:600c:4fc3:b0:426:5f8f:51a4 with SMTP id 5b1f17b1804b1-429d480cb9amr9640645e9.12.1723495687856;
        Mon, 12 Aug 2024 13:48:07 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d05828a8sm63415215e9.3.2024.08.12.13.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 13:48:07 -0700 (PDT)
Message-ID: <f6034baa-3a1c-4bd3-8cf2-cd197e8a0945@gmail.com>
Date: Mon, 12 Aug 2024 22:48:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: chipcap2: disable sensor if request ready irq
 fails
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240812-chipcap2-probe-improvements-v1-0-3cdff6d16897@gmail.com>
 <20240812-chipcap2-probe-improvements-v1-2-3cdff6d16897@gmail.com>
 <9b4f88e8-5fc6-4c4a-b89c-7f96675e81ac@roeck-us.net>
 <9659c699-1ce4-4b74-b697-83d926d80b35@gmail.com>
 <eefbeda1-8c09-4b57-83dc-30be9966de2b@roeck-us.net>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <eefbeda1-8c09-4b57-83dc-30be9966de2b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/08/2024 22:08, Guenter Roeck wrote:
> On 8/12/24 12:59, Javier Carrasco wrote:
>> On 12/08/2024 18:49, Guenter Roeck wrote:
>>> On 8/12/24 08:43, Javier Carrasco wrote:
>>>> This check is carried out after getting the regulator, and the device
>>>> can be disabled if an error occurs.
>>>>
>>>
>>> I do not see a possible path for a call to cc2_enable() at this point,
>>> meaning the regulator won't ever be enabled. Please provide a better
>>> explanation why this patch would be necessary.
>>>
>>> Guenter
>>>
>>
>> Hi Guenter,
>>
>> this patch enforces the state where the dedicated regulator is disabled,
>> no matter what the history of the regulator was. If a previous
>> regulator_disable() failed, it would still be desirable that the
>> regulator gets disabled the next time the driver is probed (i.e. a new
>> attempt to disable it on failure).
>> cc2_disable() checks first if the regulator is enabled to avoid any
>> imbalance.
>>
> 
> That is very theoretic. Sorry, I am not going to accept this patch.
> 
> Guenter
> 

I get your point, but given that this device requires a dedicated
regulator, I believe it makes sense that it tries to disable it whenever
possible if it's not going to be used. I think that makes more sense
that just returning an error value without even making sure that de
regulator was disabled, doesn't it?

Of course this is not a killer feature, and I don't want to make you
waste much time with it. But I think the dedicated regulator should be
shut down in all error paths, whatever status it had before.

If that does not sound convincing, then I won't argue any longer. Please
take a look at the first patch of the series in any case, which is not a
killer feature either, but cleaner than the current implementation.

Thanks and best regards,
Javier Carrasco

