Return-Path: <linux-kernel+bounces-169630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 364D58BCB60
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB58B1F21651
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19911422DD;
	Mon,  6 May 2024 09:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzyrS+61"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658365CDD0
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989542; cv=none; b=c1J1caY9J3ME1xx5Jnb64G9ZK4g0ev+e2A2/mJuOpbjef0HZAY1ZdVjOdX7sX11U4gIF2HGRqB0x2am5XGNwJFc6epNPkfAfPJ3cSFvtZYhSnzuz/G5GQUh62mA9ZLfTOe9FnCghHGHnJ8jeE1ICKeNKusTfc0I5mf0fuojGivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989542; c=relaxed/simple;
	bh=ktiWEvaWOogKlVw7cKu3IKBJf+uwA018lnvwmaVFeRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUvj+i8jzmcOkY7vx+3nfN/vRvvvBzTcqxTzUmZJWoqPnmPjQH7R0/OqC8QeJ8HgZEieNyNxA/w6qExQ00TvxOeWoIh0xViQ+aNUc6PkU71lypGyiUpDvuYCsWPzGJKTh+0SE3cvzfr0KPAy0HOXwYJoXj4XTqlQBA4XX+makAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NzyrS+61; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ecffed96cso6312455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714989539; x=1715594339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIdEzQj4hbIBx0W72x+eRWZdMeEcP6yVymjAkhZ8EkA=;
        b=NzyrS+61TbChCezL9+nQzLqRbac4ZOQ3bCOW+P2z/6WEqJoY8ekteA6+3txy4V3wnE
         WlF1dLAsUUY0kF5CJ9YJMHBVIUqnQsuDVVbI8Md7TLmN7UySJsQHpxtd+5MuDdzalQTO
         +EeOo6IZBurviTehwEtx39vqsIC2Ar4WoUtjrh+vrwe+u+KOXwC9QEaqZc52adUfcezr
         F9N26CnnUdjJ8ADE9mdcWmaDpvRP2pSbmCzQBwAWEmjbK2GDgytC5FLtOE779SD5uGs9
         8oHDg6WT/M9wBrEz3O0LWpRrHq2LQOMuGt/Dc8MAE5zIH14jswtGMK3VvNi07f59Qo8p
         HYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989539; x=1715594339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIdEzQj4hbIBx0W72x+eRWZdMeEcP6yVymjAkhZ8EkA=;
        b=hAwJPGpE+dc4ylEtYyjAkkSjPC0s6Ok/P5gLEe7NlVqgNHM5eLNEu3GZk8hR8o2XF9
         48mEBg19K3Gi5gZoC/AZ4Kdq0sSrE+/lMRd7VzlFHm0ZH1tS8zmonLASkXBHVcHnjSFR
         W36GEcZXQ28imqdhgzjjConcuf4NNxCSI59qK4lnZIjc6pKyvKmLG+Txs/K9D4ZHXh4P
         spPo7Surfi7cBnxEUr00F62CjF8uLk54kqvyZYyergkuvyK2DuoSto1sxRJyVY8YQ3l9
         PFYEuOadrHtI+DpezN3AQSdkK5hcBSQTUIekGQGmliMrrsqsMtJQb0saH3c91EzGVH2/
         eFcA==
X-Gm-Message-State: AOJu0Yz5VOTNsW76wDHKXl0mLSuXxfveiVE9VnqBXgU3B+/utkbFLs0H
	JIgeEbqB1CiOsf1KNcqXK+2Qu6ocUZ1U4PDJqqXNKlwMiBTdT/Uior997NQMxLs=
X-Google-Smtp-Source: AGHT+IEHezJh5zrqJL7UYUAZl7Y+8tV+sdORRjRHOcb8S3r1UMI/BSI7cZaE4ybcNmJKBzI3ySWahA==
X-Received: by 2002:a05:600c:46ca:b0:41c:11fe:4de3 with SMTP id q10-20020a05600c46ca00b0041c11fe4de3mr7616582wmo.24.1714989538780;
        Mon, 06 May 2024 02:58:58 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q31-20020a05600c331f00b0041e92a08739sm4835360wmp.1.2024.05.06.02.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 02:58:58 -0700 (PDT)
Message-ID: <42e1341a-e06d-446c-8992-986263d527db@linaro.org>
Date: Mon, 6 May 2024 10:58:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patches in the slimbus tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240506152414.5796b14b@canb.auug.org.au>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240506152414.5796b14b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stephen,
These branches are now fixed. Thanks for reporting.

thanks,
Srini

On 06/05/2024 06:24, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>    b12bd525ca6e ("slimbus: qcom-ngd-ctrl: Add timeout for wait operation")
>    772be93c1c24 ("slimbus: qcom-ctrl: fix module autoloading")
>    f6c637ffe528 ("slimbus: Convert to platform remove callback returning void")
>    5e8e32f81813 ("slimbus: qcom-ngd-ctrl: Reduce auto suspend delay")
> 
> These are commits
> 
>    98241a774db4 ("slimbus: qcom-ngd-ctrl: Add timeout for wait operation")
> 
> in the char-misc.current tree and
> 
>    35230d31056d ("slimbus: qcom-ctrl: fix module autoloading")
>    880b33b0580c ("slimbus: Convert to platform remove callback returning void")
>    4286dbcecc3f ("slimbus: qcom-ngd-ctrl: Reduce auto suspend delay")
> 
> in the char-misc tree.
> 

