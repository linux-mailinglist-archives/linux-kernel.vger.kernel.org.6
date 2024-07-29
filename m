Return-Path: <linux-kernel+bounces-266362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CDF93FEB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15EB11C21E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6311188CA3;
	Mon, 29 Jul 2024 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cpC/kJAQ"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28C84D02
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283606; cv=none; b=StL5Omhr0ienTD0AgNbyhrcKTV1kw0IdMLvbEVqiVHguioXdklFivaz3ZGw1esJQ4K0raFiNT6WpQy1f6IiIRl4hwAJPhLzFGC6aK+K/XM+XzfrTVjjlbIRxFZPbicSz3gHg1mMuPIhLd7YcDfjPY/Axhc09jhnEzWrrq8SvdvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283606; c=relaxed/simple;
	bh=KjEQYXhZpuXI85R4ke3sAqQosA+4ryk0THAgPTQISFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LX5nLMvebAUScSnl+I+tTmVDLZlL9icgpk4VK+nMxlCU/K9CmLR9cUctcoW5OIX77B0AhIr6WfgZ0bVuLwt5qxuVBDGGsUg5hOvRIT47+hi5ASniskIXCLJTW2TM4hRZzt/z0JPme48R19Prm0Qd1rG/zsCzSRci0ip5DcFFlSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cpC/kJAQ; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-810ca166fd4so23235439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722283603; x=1722888403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTbVzuXlVL3BlKEZf0AF1K6/QD4kEVSDRmvl/xKfGkw=;
        b=cpC/kJAQ1uoVlbgLZQ0QM0axe8is6VKEtcBKkJCQR55GY6d9ukLkM/uo88KQfaa3AE
         vL0BlHZFrRlVwI9MUSD8NL/RHEs5IC0nFm/Jzn7khN+UiL5sdq09t2frVCyqzKwHxNDA
         6TsUSeeTYrBr6z1J4IEZ9ByyVR1kJp6+RlNVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722283603; x=1722888403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTbVzuXlVL3BlKEZf0AF1K6/QD4kEVSDRmvl/xKfGkw=;
        b=tqYdVZ9O7M5rhuo6EMrad3Nrtc73GtUtoveTnMHDFrvITppsAlhe+uI6QzC+waLdRz
         xVqoeoopXz/h2gTGq+XmY08hv7K7CNAbs5RX2wHr1+SnwgoekxasNKLG+Rr1uG26P/kb
         ZougzCEx9pEsNMx5DGPHbjkI97M+wqORS94dwjj/gLCFC5h0B7Ed1y9yfCKY4Yixdrf+
         GexpyGgqheItHO1pRVcqG9jF13E/qRvEOg0+ljWJ++IBujQHkMSCc9CuZyV3qzPmOBRw
         UBVnTVjY+cCmOe7VJebqxW/SBLuvUc79jqEly3BYX5cspc/zvvFwfX6ow+taO9O7C8qb
         zOvg==
X-Forwarded-Encrypted: i=1; AJvYcCXwMwU/RpNUM9iYONEwHxsMSk+ujEPfXGAF8C5QtyHllluTbxaDFDtpSS6o1tNkLPyyP8IEZiWXSaUoLys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0XUGglhUGAePYQxozpdXpsrpV4jOk3WZSnfpA6737SUY18PE
	aGaT8REbto/CEBBx6t8St/TPQnBnp/Cfq3tptllr68m7Vkae33XuX/3/55OJink=
X-Google-Smtp-Source: AGHT+IGuixV7PHWAzwND21GiF3ygwDujoVE6AHjJe4RUUCpFVPwO7LvE9EP17NTlBVOa4hCI+gEPkA==
X-Received: by 2002:a05:6e02:1d9e:b0:39a:f291:1e72 with SMTP id e9e14a558f8ab-39af29121eemr34196065ab.1.1722283603518;
        Mon, 29 Jul 2024 13:06:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39aed128b64sm25421845ab.9.2024.07.29.13.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 13:06:42 -0700 (PDT)
Message-ID: <2bb2d338-cd00-4ac2-b8bd-5579eae82637@linuxfoundation.org>
Date: Mon, 29 Jul 2024 14:06:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ksft: Track skipped tests when finishing the
 test suite
To: Laura Nao <laura.nao@collabora.com>
Cc: gregkh@linuxfoundation.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 nfraprado@collabora.com, shuah@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <9009f4df-ca7e-4961-97e4-446afc4e87d2@linuxfoundation.org>
 <20240729145222.119830-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240729145222.119830-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 08:52, Laura Nao wrote:
> Hi Shuah,
> 
> On 7/23/24 18:17, Shuah Khan wrote:
>> On 7/22/24 09:43, Laura Nao wrote:
>>> Consider skipped tests in addition to passed tests when evaluating the
>>> overall result of the test suite in the finished() helper.
>>>

I am finally with you now. Can you please more information in your
short log and commit log.

Isn't this a bug fix? Current logic before this change will report
tests failed if there are any skipped tests?

Can you send v2 calling it a fix and explain the problem clearly.
  
This isn't problem in this patch, but I am concerned about how
simply calling tests passed without calling out skipped tests.

This problem could be solved by printing a message at the end of tests
for non-zero skipped test conditions to say the coverage could be
increased by enabling config options.

thanks,
-- Shuah

