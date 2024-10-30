Return-Path: <linux-kernel+bounces-388640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A09B626B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F06D1F21D28
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF51E8841;
	Wed, 30 Oct 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwu1UdnX"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DFA1E3DF0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289629; cv=none; b=BhmwCYe0s50llw0wIyX+3LgnwHEti/NGUiuW5d7LGuTChJ2aVDztcb1T+XLclkEiX0/+e5d2rvcYt08CKctG0j68xMZnZh83j5y3x7rV99aVZJTO0Nte44EJG7DCLCWaLgny6K0mVgNHgFmsCYXVji3xz5kjOsO4CKD7qigMLu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289629; c=relaxed/simple;
	bh=nM38MNJvKA1mecfRM7u5vCbSbJQllP2Ezo9yQDCPKDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZmfPCDA/H/XF2p2URNjtNHDQlVOvcprHutHIeoDr8OAmQlXmxieUXuQDParyLU/h6KYL7lBAjPjmjphKr+DkyWJbg/3nmGXRyYK9pMClGIjUhB//opSi6Hn2tXpt3DIae2n4uKpucgAobrS6JaGeFCfI/ko+JXzRWZ1gZFbUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wwu1UdnX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so4599195f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730289624; x=1730894424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heM+XH6baATko105nYV8E2040lmy0LhxFZdot+CyuRw=;
        b=wwu1UdnXlNqqfLKebzkbOvo+TJ1bD0rSwmONnuKARwoq3V2ZViDauVnWlFv8lDx9EZ
         wddmg0pR5LwJjoCuUaoz6qwoW5cSRm3+6S4zoqTjFWtFPgJex8dA7yvPjD5l4vCPLHIO
         ljfmXFaYgSvNkqFIyj4qMDDxPL1rylBzjP3JdLIXXG9LzxSUcDF2jsGo9j1S/GvHcXLZ
         y1vYILv1yZnWq6eKS8MougYlWZ+n2deKA9HMa62+ugHRYKNxgPTuJhkvBXj/fh5fbsxo
         AU2ShtFYSBskyrUT1ndAvldyckmFh+MVmWC4CrVGW/3WSJbZRYExJiyB2yyMRx5kms4m
         bYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730289624; x=1730894424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heM+XH6baATko105nYV8E2040lmy0LhxFZdot+CyuRw=;
        b=FrfRZ5HgprYIYF21wv44hBlCwBZ7CAFYB34DR9Zp5u0tkMG+6ckizysupumIpFVJQb
         Osu1pULciqi1fNbVAm5jBTYQs40bLukrQOJ3YFuqHmyaUmafRPNhVMT2hTyUYWoIor6z
         UqHYljW+DM7G+NMZtQU3m3NUvzDM97fWSj0Bdp4mWd8+lyKGsQYqrbOYyCN9AUSdKle3
         Dtp2vrwstJQ6HE044zEbSbavmf/2BRgTE0wjjsXZnnKjycyinScDMJXkOwtMgL++cvRN
         Xcd3XfOcJUwqUbjatXMMx3PAM6Dy44fOrV/AGUGSFPKgtJnFxmh+8WouPxhZ5UgUJJrs
         TqEw==
X-Forwarded-Encrypted: i=1; AJvYcCVkuKVqWkE6zY0P8A30LzLrMO5biqirC+pevErAjfMwhlX3oBOUFxrsT6f89bTTtMV4B96psmZ069/JWa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0658D1APR33L2fdYRiqo6osmGf58jPNoAVrubEFfq2nv6TdX
	rsniJcj1TRFbmzkbeJsTocunIZoQ+7DQSXvK07Qu5WlNMYQsdZyzBH0MUjQ7glg=
X-Google-Smtp-Source: AGHT+IHdqyep7BVt0uyn5JbTz0KBCY80ohOEAxNDfe2YT8nR9HTsXFBe91fCaeMmIZfL9ezJQQxpbg==
X-Received: by 2002:adf:ec8f:0:b0:374:b35e:ea6c with SMTP id ffacd0b85a97d-381b70ed1c3mr2049217f8f.40.1730289624347;
        Wed, 30 Oct 2024 05:00:24 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9480e5sm19330995e9.16.2024.10.30.05.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 05:00:23 -0700 (PDT)
Message-ID: <b5dcd5df-7215-4679-a6be-c45d525e8051@linaro.org>
Date: Wed, 30 Oct 2024 12:00:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] scsi: ufs: exynos: fix hibern8 notify callbacks
To: Peter Griffin <peter.griffin@linaro.org>, alim.akhtar@samsung.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 avri.altman@wdc.com, bvanassche@acm.org, krzk@kernel.org
Cc: andre.draszik@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, linux-scsi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ebiggers@kernel.org
References: <20241025131442.112862-1-peter.griffin@linaro.org>
 <20241025131442.112862-11-peter.griffin@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025131442.112862-11-peter.griffin@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:14 PM, Peter Griffin wrote:
> v1 of the patch which introduced the ufshcd_vops_hibern8_notify() callback
> used a bool instead of an enum. In v2 this was updated to an enum based on
> the review feedback in [1].
> 
> ufs-exynos hibernate calls have always been broken upstream as it follows
> the v1 bool implementation.
> 
> [1] https://patchwork.kernel.org/project/linux-scsi/patch/001f01d23994$719997c0$54ccc740$@samsung.com/

you can use the Link tag, Link: blabla [1]

A Fixes tag and maybe Cc to stable? Or maybe you chose to not backport
it intentionally, in which case you have to add:
Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present

In order to avoid scripts queuing your patch. It contains "fix" in the
subject, there's a high probability to be queued to stable.

With these addressed:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

