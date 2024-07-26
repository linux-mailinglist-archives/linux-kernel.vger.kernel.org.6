Return-Path: <linux-kernel+bounces-263545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C13C93D783
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F2D1F24BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6163A17C9F5;
	Fri, 26 Jul 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WsVcdPID"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954117A5AD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014366; cv=none; b=TdKq3dc2WjaQTVe/2GGIwyEEtlYLYcdy+AWT4oyO17mipaoWnOHP4o9YSdSpcY1s1u6engDmv7jbtE0u6KybEXzwRdYttRWRQjuOmNOXZBrFMleyBPN/NbEoBQJ5BG36FzGQrVuI0i3KkP7nLcKEcEIKNs6SEN3StBnLY3lwJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014366; c=relaxed/simple;
	bh=yJqSDD0DLe0lYbPGZcb80gtke2ZossdCzFPRmv3ir0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7QYiv8Gjh9q1w3iG6jFkzBWnQkk1zGtbmr0FWFsRA3tFtI829YF2HufNvebomCvL6xwsjM4awoUogt94Y4V2HN4loULt7gtGsnh63WyjSJeop0HkCyH0XZxAQSMbX0ON9CN1gCTR/UR6WYDAPdNhr4TjSeXORplbbAUgYQJEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WsVcdPID; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f8add99b6so7490239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722014364; x=1722619164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhQvF/ec0l7nyYt3y7hHMr3GhJ7xb3shAgjsh/1Y6po=;
        b=WsVcdPIDuGrtvodRnD29v/gGrr3lTK7DkrVtuOIWzX3+v4DvFBjsJZIFjIvluSKBm3
         6TJH6e8lZ6GcYSNyw7URXqm4Lpk7yYvcu2CNpdeiJBPMNufsSo3/fcY4Kd+fp8Gw0veo
         cNjAoBtB3dYD7m7P+/7rgj8NzBjdyLJRBpkh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014364; x=1722619164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhQvF/ec0l7nyYt3y7hHMr3GhJ7xb3shAgjsh/1Y6po=;
        b=VI13khhcpJYcw7EObl6+Zh2y6RjgjHxwz4+XT+qQi3vOtSXtOhmQZTD5DMBBAvxJHh
         L+bHKws3+93khs4Dad8XSKI5oxTbNLKaOuiKUiACKNtOMTQukhPerV+01yHzG/P5V0NP
         A7U+KBf578C31QwC3agvYx/wIAGlf9KdNI3oY9xd5fszmkeFtgDTvCnWLjtgjiZdu7qo
         BDTlAkGzv7ZGc0R51vE2DaH0jFb2ogwk/2eAgpu1lVK/PaasL5Vr4xg6u2LBJIsECCjM
         jgRiK4OIDVg37WbCkV2HKg2EoaFXSnFspeBdJZsQFj8W1+trI11BRGBV3aoVGNSqWWoo
         NViw==
X-Forwarded-Encrypted: i=1; AJvYcCVwWdrsymAWyxwjmpIo1wF6QWES6qZhnGD3g1dRutzaFuTSlUKgfQZ2VB/NJYaaC8Pyi2tREST/VOhFpdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpISMr3xVLcHQrUhyTX4v38+Q+1oKsT+bMAJ+Lv1wvimNhhM1
	3UGeM+qa6i5xrQTFS3wAKG0FYf+FZqzwTO0EpQmT0vopChccdGCeqgkJwugzDaw=
X-Google-Smtp-Source: AGHT+IEf97OHkJg2FQVBYCMlBP+bYIuQovRdKxBhpC9+dLivA1TX9QD7IdXWeMCwsdr4zjro+O7+EA==
X-Received: by 2002:a5d:9605:0:b0:807:6708:e35b with SMTP id ca18e2360f4ac-81f7cf104a5mr450700439f.0.1722014364126;
        Fri, 26 Jul 2024 10:19:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc3147csm939737173.147.2024.07.26.10.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 10:19:23 -0700 (PDT)
Message-ID: <cd028a09-c6e2-4c54-82ac-04fe1aa2d20c@linuxfoundation.org>
Date: Fri, 26 Jul 2024 11:19:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: user: remove user suite
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
 David Gow <davidgow@google.com>, Vitor Massaru Iha <vitor@massaru.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110817.659099-1-usama.anjum@collabora.com>
 <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
 <01d804a2-3370-44ec-af99-c21af5df0bde@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <01d804a2-3370-44ec-af99-c21af5df0bde@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/24 02:16, Muhammad Usama Anjum wrote:
> On 7/25/24 7:44 PM, Shuah Khan wrote:
>> On 7/25/24 05:08, Muhammad Usama Anjum wrote:
>>> The user test suite has only one test, test_user_copy which loads
>>> test_user_copy module for testing. But test_user_copy module has already
>>> been converted to kunit (see fixes). Hence remove the entire suite.
>>>
>>> Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
>>
>> Remove fixes tag - this isn't a fix and we don't want this propagating
>> to stable releases without kunit test for this.
> The user test suite has been failing since cf6219ee889f as the test module
> wasn't found. So this is fixing the failure of kselftest. It just causes
> noise and may mask other failures. If you still think that fixes isn't
> needed, I can send a new version by removing the fixes tag.
> 

In which case this information should have been part of the change log to
make it clear this is a fix. Fixes tag should also mention the releases
this is applicable to so this patch doesn't make it to stables releases
without cf6219ee889f - so this test still runs.

If you are adding Fixes tag it should mention the releases this is
applicable to. Can you get me that information?

thanks,
-- Shuah


