Return-Path: <linux-kernel+bounces-249535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D274B92ECED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024FE1C21B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C04A16D33E;
	Thu, 11 Jul 2024 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JN6xzLMr"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8616D32C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715970; cv=none; b=gQ6NXlRtZhps3RDapLZhmykVR714KOw52vh0ovaq+3CwjJveul4/U/TKPQQ4c7+fN1hW3u9ISQ2/1kFWERwv6wmTnBhZn9a4zUrFSoX1SZREqb8zPNKvYQ0rD424jfkyOgjix5XAdoz7LROPu5kUREc4KhMdcTKu1k0hTCtjd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715970; c=relaxed/simple;
	bh=e5C+mBjqB8nH1NxFpCc1+REgaVsgeWQdh56jyItZEik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4MpJQnBLW0pdzWl4wgpjDMs1mBkPnmqedCofM7vVBiP2JAZ70vtwQoeze76Xuo8jg/M7gGZqRVaHRtCQReZkcq3dL9jY++zGY9pramso1ZauXi7TzaEVWOYesXgAdw4ThqHPsO1ufKDmyB/Un1LFjVJCUg9tqPOa5P5+3hei3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JN6xzLMr; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-38713ffc5f7so580745ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720715968; x=1721320768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5C+mBjqB8nH1NxFpCc1+REgaVsgeWQdh56jyItZEik=;
        b=JN6xzLMr2kFJcWlYbA9ZkaNrC0UcVxqb4XEQ6SoznaHJeC2JV4d+zc0B0mz636aHRE
         1ulycWNjN8CE/lANcKq4Iue+qKay8HzAEn7bD0LYKYb9IzoGOJR3EI9rkuOz0o3Z6x9R
         qt4a2xaCNZzhQvn5JY8BxBCNJs1KfneCSCj1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720715968; x=1721320768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5C+mBjqB8nH1NxFpCc1+REgaVsgeWQdh56jyItZEik=;
        b=ccDTjl6Dps8xwI0F4MbGZjcvU59MkCdX0LoydMvIiyUsKYRFyA9gS1OU75nZoMxKVx
         m5uWdWL6COe8HUb4lSoZyvKO5zrncr4WPBi+WcD2w/1SrD2l5Tep+V9vNqUts3JuLIau
         F+Jd9hmLZNTJzhuRC2PgtvefuTM+FLck5+pPA7J9evhtkVG7aP3/ar1a+z6tvBxSpTEE
         CJKJI+cdsxfUOJ/rrddRIzj9FBR/ApIpwSyFupoOnmH35PjSCW7xc15empz3ZOYmUjZv
         ojmP2c5BwWWfwJwVWq3DUsFQxnFs1zs67ujtbuiRiI4t3E19xyNG4epu5a214CIXscoS
         hW/A==
X-Forwarded-Encrypted: i=1; AJvYcCW5BPx3+fdFazp9E8zOJR0S07NGQ21eUCMAxxUvWtLX4yjKqaS3UEYEeqLL/d/tMdZB8x14zR1dICP5BlbJJVuUlADjOI1WVD57STva
X-Gm-Message-State: AOJu0Yyi232pf2WqeWsYAzjo+2zi5u5wQjjHbXkOsipWoJ1Qm/wyDBGj
	vNlyRC7H/JaGsuTJwecwrWFSmETWL5xiToGqP1Mv2vEUTcEhx38ST6cKm/BMSmU=
X-Google-Smtp-Source: AGHT+IEcVXOWjzyyxDKz9J9qAwm6coQfMOzLMPdETUPQ+DFRggTMe1LEOGI457+OLkIquTJysLumyQ==
X-Received: by 2002:a92:640e:0:b0:383:17f9:6223 with SMTP id e9e14a558f8ab-38d1946e3b9mr29768555ab.2.1720715967995;
        Thu, 11 Jul 2024 09:39:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a4a00665dsm15392495ab.52.2024.07.11.09.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 09:39:27 -0700 (PDT)
Message-ID: <390d33da-1676-4b01-a7d5-8b5c2cc6a3a9@linuxfoundation.org>
Date: Thu, 11 Jul 2024 10:39:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: x86: conform test to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240426101824.2894574-1-usama.anjum@collabora.com>
 <da0f535d-b970-4de5-9dfb-e2cbf62c816b@collabora.com>
 <890460a3-fd09-4f59-ab21-4f5b16256175@collabora.com>
 <f929b8c4-fb66-4724-b2ee-d012a5c20324@collabora.com>
 <0333bafc-295a-4fd8-8099-8fa8c6b0ae23@linuxfoundation.org>
 <0b731ef9-3110-44d8-b768-ccbf7585a08d@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0b731ef9-3110-44d8-b768-ccbf7585a08d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 00:52, Muhammad Usama Anjum wrote:
> On 7/10/24 9:16 PM, Shuah Khan wrote:
>> On 7/10/24 03:37, Muhammad Usama Anjum wrote:
>>> This patch brings just readability implements by using kselftests wrappers
>>> instead of manual pass/fail test cases counting. It has been on mailing
>>> list from several months now. Please can someone ack or nack?
>>>
>>
>> Okay. I think I responded to your other patches that are adding TAP
>> to individual tests when kselftest wrapped does it for you based on
>> return values.
> The current test doesn't return any exit value (hence implicitly always 0
> is returned). The return value in addition to some other changes is getting
> fixed in this patch.

Yes. Fixing the return the problems. Please send patches to do that
and I will take them.

thanks,
-- Shuah


