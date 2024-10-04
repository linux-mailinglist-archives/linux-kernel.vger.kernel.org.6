Return-Path: <linux-kernel+bounces-350820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C519990A11
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB409B21AA9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3551C877E;
	Fri,  4 Oct 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="av8EjpW3"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79D15535B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062580; cv=none; b=MrQNw+HEKJKiB52mqms883RjHrL1Gxa1hl10Tk1Mge9Crui6N9Y6f4UdA7f33al7nKkMgh94nzZiZ5ZQevAh5Re66ILQ/C8GfAxD2o9ZX/fb9ZEhVi4H+RULGEMPs6LUvfrQHZ+RS0QPpZ57Gq6PRZrHTvIRbxReAJyxndRtous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062580; c=relaxed/simple;
	bh=vkXradS47TZRsD+Tw9Obi8t9ec/M35OKeWU2WxNXipU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejKlh6EtiJ2FGNNk1qH2v1hUITeiDjKtmqNCg72Jqbxxpo3AnxnWlE9Y0RuZNIq0QwlssOe4Guo6aVXawjpefUi8x1cidFsDg8Ls8LD+ibmHdHU6atsZc3XlDFNml4yzBv9NveicWNwUjjJpqAT0FnlSTh5yp/hNmsVdGTZdGMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=av8EjpW3; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8323b555ae2so110642339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728062578; x=1728667378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjxtETvebgPu96nn5gAk9Ijr0Fw8D2drEbjhjiJbq5Y=;
        b=av8EjpW3Pu0NyRzwyQZX+el+1L4NmBSVlqC4pjlQn6qSNho9LaojS26Wqs1mPlmpNa
         Cc7443uBpe2kfdCA3NX4mj9ImZShSi3UDQ6khAcVKgichQkGpAS/dimEVDaAJA2vxQmm
         sZABGKLCrCytF43hD7pbIAiwScz0ZtIvpIZ/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728062578; x=1728667378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjxtETvebgPu96nn5gAk9Ijr0Fw8D2drEbjhjiJbq5Y=;
        b=RcabH1dTOAMLmzV5DY+Oud3pKuLb6MGrkoHCS/J/xOg/Kggyl/7PouevjyKo8I5Dts
         oFMLrcf+hgxdrHln8QNnsj9At0wu0CPvyWBZMvTyzE3cXEWQjJvXYWqRISPwo1HUZbvT
         XUESXpK85sDK47Oaf54xxvjXB2B4fszGQvpBl0uO6Y+aTIl9TBYlnAa1IwCEX7ziKfJq
         16TuXAktOc5+Vx6uo+q5D5jKtppVaG9a5EiC6kmQDqgVtG081NWQWDgowUnFQJ5eTtjl
         16Gr9j4spH+hs1/qjQUJT6q10UrkH0hJY5hP95coofZ6+EBQrgvjSTsi75KkPu7sPotJ
         JgJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1wCPSU85DiH6TWpn7NHgCn5nfsAtrXcGaHcCy0CJrB8kaJzEv7fEkDUFXsy3RIDHuhsR3bHJuLSZLfAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoysw5y07Q/lhGXhJS4ykcyFU6luXhjUHvxBdJHVuFxcLU3UFH
	PPJ7uQn10gLmr3lkQNfdX3cOwGH/2tDLgrYJfkv7roP1jeeG0bjssfZHsCOLFc4=
X-Google-Smtp-Source: AGHT+IEng1VQK79hPV945GkxjWJmm7jzrP9Wu7f2kokbpX4AGNwAmboL7kqahAU8iEa3xBWgrBpQ0g==
X-Received: by 2002:a05:6602:6c1c:b0:82d:d07:daaa with SMTP id ca18e2360f4ac-834f7c741d9mr304525239f.4.1728062577959;
        Fri, 04 Oct 2024 10:22:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503a92f7bsm4195939f.18.2024.10.04.10.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 10:22:57 -0700 (PDT)
Message-ID: <e3602786-d656-40ae-9e22-0e8195d33f0f@linuxfoundation.org>
Date: Fri, 4 Oct 2024 11:22:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: dev-tools: Add documentation for the device focused
 kselftests
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 kernel@collabora.com, linux-kselftest@vger.kernel.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernelci@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241001-kselftest-device-docs-v1-1-be28b70dd855@collabora.com>
 <0040a842-de9c-4f9c-9d61-c1bfbd010470@linuxfoundation.org>
 <ef428a44-783c-43c3-81c6-9abf88ae8949@notapiano>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ef428a44-783c-43c3-81c6-9abf88ae8949@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/24 08:41, Nícolas F. R. A. Prado wrote:
> On Wed, Oct 02, 2024 at 12:00:10PM -0600, Shuah Khan wrote:
>> On 10/1/24 09:43, Nícolas F. R. A. Prado wrote:
>>> Add documentation for the kselftests focused on testing devices and
>>> point to it from the kselftest documentation. There are multiple tests
>>> in this category so the aim of this page is to make it clear when to run
>>> each test.
>>>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> ---
>>> This patch depends on patch "kselftest: devices: Add test to detect
>>> missing devices" [1], since this patch documents that test.
>>>
>>> [1] https://lore.kernel.org/all/20240928-kselftest-dev-exist-v2-1-fab07de6b80b@collabora.com
>>> ---
>>>    Documentation/dev-tools/kselftest.rst       |  9 ++++++
>>>    Documentation/dev-tools/testing-devices.rst | 47 +++++++++++++++++++++++++++++
>>
>> The new file needs to be added to Documentation/dev-tools/index.rst
>>
>> Docs make should have warned about this?
> 
> There is no warning. I have added this new document in a new toctree in the
> kselftest.rst, as you can see in the hunk below.
> 

I missed that.

> Since this new page is specific to kselftest, I think listing it on the
> kselftest page makes the most sense and will make it easier to find.
> 

Yes - including it from kselftest makes sense to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Jon, Let me know if you would like me to take this through kselftest
tree.

thanks,
-- Shuah


