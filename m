Return-Path: <linux-kernel+bounces-443300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99429EEBF2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6C6188C0C9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEB2215764;
	Thu, 12 Dec 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArU11VIy"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3BA748A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017252; cv=none; b=eJAuKf2y+WqHtA1AopDEBBnr7Xp+9SIXy5dVio8rcBY0htSL182KS8Ru51KtQimT/WAB6se1HP8J0WkUk0xYYu+dj/CxKqV3oqX5qmDRRhA71En7Oti7E3Gzia1+TmgFYzreaoY4MwEWy6IpStcuPQnvpyw6FWDnn91HEaavnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017252; c=relaxed/simple;
	bh=kPTkKrM3kFQT1WhPXY8whVxdWlSJRTnDz/er3losxv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0xuylhuGhBLQPfJj+LgAHA0SWQWByPrHY7qqzHKOqkBBPOqO5tv3QwJnfUrGVHsUg8+iTQyfBXAqYJu7TxROTUnanaVbCYsvktNOrgH96X2zKbUJLm6KIj56tivcIgCMuDtYOeitq3m2fcpTJYBqH9lebNwoN6o24FI7xvo09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ArU11VIy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so8155795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734017249; x=1734622049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpS9P9XwAS30njS9V7ckdqZVR6lOQbdme3ixokuDXWQ=;
        b=ArU11VIyVBd0nOSKkiUCGzVcnO5WEx0IPbcNgnZJDET7COlywsLoffg6EMno9KtxEN
         xLPtXTa5cluSa1ACJwpyDUYX82XEFZ/h39UQ5l3b3xBRV8PwkSEjDeJPRdkkr2T2otFH
         Ryk3OXcJHUlzOv5ydxfI+i54OyYNS47ysesQavF1s/chRHf+OpfM7024T8acWOUgwlXK
         DeYkngSx09LQlIWdCJDOCSgTuyBQK7JS94XYlcx3pTehfI9D2N2AC8VLAWM1DgDY8wCa
         kDjutmGnr5aGIO70SULI2Vx1MeSOzfDHC3np1X6PemT6jCsn6hNIiTAlwj8nxGW4TI66
         2JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734017249; x=1734622049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpS9P9XwAS30njS9V7ckdqZVR6lOQbdme3ixokuDXWQ=;
        b=axkVDUzuKfj6xeiY9BAPvEX7hZYSZetAE20gaGp9/buh6kCyhnJ9jrr0SDmdSciRYy
         gQYGRpUPAaQbmM5ymdoDX0+d/epf8O2dMM0QSOcVsArb6fIGU4s5v/Ku59vG/bpY7Y9Q
         OD/0+0jPkJ4clPHbX4sSfxpcLBSkhno5bgkLekAUckX0/aFb6Q+2gWWfiypAAPa9qL0V
         HdBSHOpBug+FLzq2pGMDthooiYg57+1CLKUxXHAxs+Ge2zIiCp/buFVc+NFh5bYz1KPY
         FfuiQE0JFlUMd0AMF5eahNdJEkXqz+a6Ckd90QlZwSv5w9d0GyntcnBYqQ/mcJ694UY7
         X1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9XPeW8rS3MbvNiJVobM9mmmW9pXoLAo8O1zZYCn4RK2n/MLEtH4rImOq3CqJ80njZIa/P9AbdprPydrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzW1/D43bbdC2BNAm8LEv2uoGgMhqxKYpv4uRNT1/zhByNSNZY
	+asT7pJqe3bznn8QeBadEWrr1oG2Vfjcl54tzAl5m2pxVEaM1/eZ7wAvsWCUcuA=
X-Gm-Gg: ASbGncuq/kz4aaTDjkqpd20pSwQzFdHOSwt4LHAl3gqCkNtHttyvLLQethSDFr9ati3
	pV5NFt1n/Cwm8qfDHJo3JjVk4v6TekJfL3odU87s2ewB51oc0zq/aOWyiF+VhnBNFMA34T5WMNL
	SAAuIM9A0Y905J7/HpakL7eSff2+mByeXlJ7l3Uw/58MR4pBrTbv76+ofPO7+VFs4Xkw34RlAei
	Lt8fOjf/CiacaRQUAuyiUBI/+L79jyNn9FF1t1w5D0AUm7Zz1kNio15cg3stzdFXtI=
X-Google-Smtp-Source: AGHT+IEhNl36m73Z9uj23to0PG8NFMTyNmDs7ZQ3Hettg3uLA6lpt+bVWiT/atLfW0TWRdXrBJzlMA==
X-Received: by 2002:a5d:64a9:0:b0:386:3213:5b9b with SMTP id ffacd0b85a97d-387877c9747mr3330810f8f.43.1734017248923;
        Thu, 12 Dec 2024 07:27:28 -0800 (PST)
Received: from [192.168.68.163] ([145.224.65.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248e54dsm4329749f8f.19.2024.12.12.07.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:27:28 -0800 (PST)
Message-ID: <24299600-277f-48f4-9be5-cbd65ab6ddb7@linaro.org>
Date: Thu, 12 Dec 2024 15:27:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: docs: Remove target sink from examples
To: scclevenger@os.amperecomputing.com, coresight@lists.linaro.org
Cc: yeoreum.yun@arm.com, Mike Leach <mike.leach@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linux.dev>,
 Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210144933.295798-1-james.clark@linaro.org>
 <9e53f5b9-d8a9-46b8-8ff1-7f018e2d9c06@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <9e53f5b9-d8a9-46b8-8ff1-7f018e2d9c06@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/2024 6:01 pm, Steve Clevenger wrote:
> 
> Hi James,
> 
> I thought I'd mention this issue with multicore self-hosted trace. The
> perf command line syntax does not allow a sink "type" to be specified
> (e.g. @tmc_etf or @tmc_etr). For multicore, it doesn't make sense to
> specify a processor mapped sink as would be the case for single core
> trace. A sink "type" should be allowed to avoid the auto select default.
> In our case, the default is the ETF sink.
> 
> Thanks,
> Steve C.
> 

I'm sure it would be possible to add support for this, but I'm wondering 
if the real issue is that the default selection logic is wrong? Are you 
saying the default you get is ETF but you want ETR? And there is both 
for each ETM? The default selection logic isn't easy to summarize but it 
should prefer ETR (sysmem) over ETF (link sink), see coresight_find_sink().

It's probably better to fix that rather than add a new sink selection 
feature. Maybe if you shared a diagram of your coresight architecture it 
would help.

Thanks
James


