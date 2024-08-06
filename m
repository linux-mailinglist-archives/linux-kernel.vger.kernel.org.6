Return-Path: <linux-kernel+bounces-277029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4499D949B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C751F250DD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AB1171E64;
	Tue,  6 Aug 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BQvyWgja"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314553612D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722983378; cv=none; b=g4d8Z0mtP7zmApsOU6iyDsSSEVuKIaqWXuJTzkftBiaSA/NyWHn4aXCsKwkv2VPWSTBLpU/28MHsnUUAV6fgtk0Xx07jkbzBPMv8DG6zB591DLvfrz/Rb+g4cOlRxIyBG7F4NeLpxjGC96+X6LebECKfHvpcUvFIV15RTgp8aWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722983378; c=relaxed/simple;
	bh=lJWukiyEOezEPrQUk6c2c7g3HFJmueQVSmT1QZqJWcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHwDLVhmw4udAKMkugJWKy7IgYzdFp0uRKoGvYf8sgLoJd68juD8M/jdhBK0OsGkxtOUEW+h4AIQFKUlYkuKjc8QwxQ1WAPxRFIzZAQsCexaHM6PVAs1jvJ5pUySl9mWgCDnrJxQoDuG5O75JnDzOdqvT1lWDewK4x0H+M7X8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BQvyWgja; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-81f7faff04dso3289939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 15:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722983376; x=1723588176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUmYPooDKax1SdVUh0CBefLXmkbt7/VGku+jUgP81QU=;
        b=BQvyWgjagyynNAPVlFYL3QObFRW3ZsOFYojBWW1YdKU6NZrZX2BR2HkX0OcZYxqDX1
         R7ZyRjlerIJnsnIzIlXNpDs+4QcWS79oSzC9kDreUBmphJh13sKxvN/YOZyt3e2359lU
         whYBBRbIyKGl1Lf73aCb76YEYh4xKgdizyyiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722983376; x=1723588176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUmYPooDKax1SdVUh0CBefLXmkbt7/VGku+jUgP81QU=;
        b=SUmfVdG0RwxkpUB+R9etmTbMAuHkUlIie8Q274HUew/I8bcb1Psv+SsyKhigcFSs6J
         u99HSd83Hnx9JnLrp5xU0GEaMR9dlSEyn5LFYomi/Z//OytyNMV9Ls6W2JcY7ekfXAb7
         BMXQ4whNOh+narblwEf0rFvtEmLmOWGpUYRbDHNFOLWVQl2E6QDy8nOIJ/yBWAyUiQnf
         ce3IwlSMc3JNi5gf6VR+E45QzPSDfKo4X90MYecSibzrHLDD+CmE83IktrLFLfJPXrAH
         BZBIITGQNvFAmhXFYV1Ywp9FupGrTf6qD0W3FNykzahmSYVR2FDq1hzY/D4wzfkQQXIL
         A66Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvhYZUOPqPARIx46trJvRi3S0n+KDVvPfI9HyttYnMHiPeDCVVUnypsxMVgDeHXW592G9mpykbwKnTYOkQ3dZeS/mucozTVvHbuOx+
X-Gm-Message-State: AOJu0YxVFRRwPkPoHOTVtSrMrq2JowhlJhfPPiqsT2tkxLrBupwq7Td3
	ep7+AeiDxuSgSibQjRSuzRNBeUIwyTeC/WMu0KIiZp3s+a4M29s46B/4GMjvjXk=
X-Google-Smtp-Source: AGHT+IFYEVpw2EALVMQD+7U9Y9zpwag7gZ9SULOondMLHcaYOTDf2ce2qHhIXrZpueCFpR3H+B+vEg==
X-Received: by 2002:a6b:f415:0:b0:81f:8cd4:2015 with SMTP id ca18e2360f4ac-81fd4395206mr1007903839f.2.1722983376108;
        Tue, 06 Aug 2024 15:29:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d82ef9sm274995839f.52.2024.08.06.15.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 15:29:35 -0700 (PDT)
Message-ID: <ae5edb38-5f77-4104-b541-d2cf2c3011ff@linuxfoundation.org>
Date: Tue, 6 Aug 2024 16:29:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the kunit-fixes tree
To: David Gow <davidgow@google.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Brendan Higgins <brendanhiggins@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240806091818.7b417ee7@canb.auug.org.au>
 <CABVgOSmpcXOKFVYOm4jgJ7STxhA7o2k5SfQgxn=fzkAZYyW-rg@mail.gmail.com>
 <9bd07238-5540-4b6b-9532-8e3590cf2b77@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <9bd07238-5540-4b6b-9532-8e3590cf2b77@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/6/24 13:20, Shuah Khan wrote:
> On 8/5/24 20:06, David Gow wrote:
>> On Tue, 6 Aug 2024 at 07:18, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> Hi all,
>>>
>>> After merging the kunit-fixes tree, today's linux-next build (powerpc
>>> ppc64_defconfig) failed like this:
>>>
>>> ERROR: modpost: "__start_rodata" [lib/kunit/kunit.ko] undefined!
>>> ERROR: modpost: "__end_rodata" [lib/kunit/kunit.ko] undefined!
>>>
>>> Caused by commit
>>>
>>>    7d3c33b290b1 ("kunit: Device wrappers should also manage driver name")
>>>
>>
> 
> David,
> 
> Looks like the above patch below is still under review - I can drop
> 7d3c33b290b1 for now to avoid build failures. Thoughts?
> 

7d3c33b290b1 ("kunit: Device wrappers should also manage driver name")

I did drop this patch for now from linux-kselftest kunit-fixes branch.

I will pull the two patches together when the patch below is ready.

https://lore.kernel.org/linux-kselftest/20240806020136.3481593-1-davidgow@google.com/

thanks,
-- Shuah


