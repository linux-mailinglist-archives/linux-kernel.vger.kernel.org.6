Return-Path: <linux-kernel+bounces-417145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBF29D4F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6305D2854EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921CE1DD0FE;
	Thu, 21 Nov 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oTpDmAUu"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8716B1DD0E7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202234; cv=none; b=K+or6liNgRdkNqIq9OqSpsmsVV80ZOifXSq9bPeKb+eSulAtvKtx93i6nVJ6e01D2t1h858cf3f4X/8RcB8SbZmWwwz/yN8MXihQCyVCJBAQmuAaOa64xnzfaZfrFbDTDNAElaGkw1kB9xPdsBgvkPw5SkpHZpx0HTveIcY2+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202234; c=relaxed/simple;
	bh=FbMXZsmEuN+gyzKjH3HhIo/y8PtoDZn+HMJmDZrOOG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cv+qofPHzP5ZMC4rc0sxifYmtxBeH1UkrzkYol9Jlgpjo4vIsLAvHjZgOuNQJhzJkll0CRvqNPX7E/n60eMadL9LKaERcz+awH8yvlJMbDzvVdG7mJGGOWJDMQnApwefXK4kK9jjNcWXAr2drZS0hPDyaYkUJ/Ln8NgNWsg6D4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oTpDmAUu; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb561f273eso11668211fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732202230; x=1732807030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYaD+vIxRvyp4MCsUv1xsGtNN9FeP7FHLUrmhzNgycg=;
        b=oTpDmAUuHsNbI7Lj6H6QC1SdcYzqc202FJTTzeJPijLqDEWgIBlfiX9ik2ewb2Ue8B
         LaWr6qzI9uDv9WUX1Hy1V9edjm//98SAIQbdiyoSM61AWZWHNHkL5ohjLRr+PsmWfMrp
         2DoRj1FYBEcfptEWMR7F+Yvrq8h2568CRk1qqRhEsgUju3ixZ37Isdh7Idbr5khvCj5F
         brlrLsi3tbXcnrU5EktVDqGL80omevk6eo+5FZ2HmcZL1eahzO9+4MHEUCHfIUgo6wLf
         lQ6kJIQslWMEIBM1o56q3xFREDKWnSbyJvGhxj03R/VweTJpi7s1dIUcoEAbxgtGHqd7
         rPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202230; x=1732807030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYaD+vIxRvyp4MCsUv1xsGtNN9FeP7FHLUrmhzNgycg=;
        b=sEHU067brmp/24G+O6ClKItY6E2x4HlYZy1jADRCxwS5CL93fgB3vQhMCHk9wAREg+
         VPTCewPQRmrRclAAuhi0UFELLGgKGlxDZVjIduK0ZDvIYrl3fuTau9vDoiGp6dbR74uR
         CcjPqWBxJXsr2bphAu1BXTg0KSBmSZDt6km97D2jHrSOp4r6Q0sVV0ggZ/1/SKwLfwsJ
         vOBkau+Uii3oCeuGy6t4xcedwxryO5YN6gdUREQIKwDEKPD8q6Pbw7McEqoAqjukmZMv
         7gDRRj+Er9+vSiQk2JqQYBQyhd+prH+879wJDbwxAt3di7jfx4gLlY6/HcpVm2afPeJd
         Emrg==
X-Forwarded-Encrypted: i=1; AJvYcCX2pBkqvN+SUZqqeBpopQb38WoZmMn0l8HtUxF6Cui15Txjg3ySkirgwhQSaitU2Ww1Ea38xu8fG2oVBLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5Z8ycTJm2IcJKBLqLfBsebYlhC07OQSlPdtmb2ecQP6a9JAI
	QDns9VVGd9iDUXiVM5k3hWg8kD2gCOr7q9+uNJ1vjYJatBZPD2OYYDF2aFPZZY8=
X-Gm-Gg: ASbGncvFSLrX6NRMyIJ964su5khB1qPDk/I0qOf41kavyhYuPEWLoQ3rQ7djWtP7orV
	cDk7iriZes9NqdE4FkLaoaoEHlSzjS5N7dwUGQ5C1c9eqMXHWdQZ5IGK023jFQHH/QF3CIQs1PI
	T00hgmlQ86xv2jpDUzQRN+tjnlSOiHTYno38nw0d5avMoT+8Z135lUEtcnEHnzHCub+KhlN89Ms
	aRmZjcJSYcEKztFTw70wUR9ewBRrrhCQv7JK6W0sU4ySqWzGG+zjc2TdMSY
X-Google-Smtp-Source: AGHT+IGuGkDWEGa66FRHfJwCBFniq/w48rL31cV/pcGtRhPh4zpF/rbVtHIdfpipVfcQosiMjkCEvQ==
X-Received: by 2002:a05:651c:4017:b0:2fb:382e:410b with SMTP id 38308e7fff4ca-2ff8dcc9c22mr36130851fa.32.1732202229431;
        Thu, 21 Nov 2024 07:17:09 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff453e2f8sm1962653a12.68.2024.11.21.07.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 07:17:08 -0800 (PST)
Message-ID: <55469393-551f-4ad6-ae03-56306e474f58@linaro.org>
Date: Thu, 21 Nov 2024 15:17:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Fix dsb_mode_store() unsigned val is never
 less than zero
To: Pei Xiao <xiaopei01@kylinos.cn>, suzuki.poulose@arm.com
Cc: kernel test robot <lkp@intel.com>, mike.leach@linaro.org,
 alexander.shishkin@linux.intel.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202410150702.UaZ7kvet-lkp@intel.com>
 <122503017ada249fbf12be3fa4ee6ccb8f8c78cc.1732156624.git.xiaopei01@kylinos.cn>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <122503017ada249fbf12be3fa4ee6ccb8f8c78cc.1732156624.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/11/2024 2:40 am, Pei Xiao wrote:
> dsb_mode_store() warn: unsigned 'val' is never less than zero.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410150702.UaZ7kvet-lkp@intel.com/
> Fixes: 018e43ad1eee ("coresight-tpdm: Add node to set dsb programming mode")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>   drivers/hwtracing/coresight/coresight-tpdm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index b7d99e91ab84..158950243d83 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -640,8 +640,7 @@ static ssize_t dsb_mode_store(struct device *dev,
>   	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	unsigned long val;
>   
> -	if ((kstrtoul(buf, 0, &val)) || (val < 0) ||
> -			(val & ~TPDM_DSB_MODE_MASK))
> +	if ((kstrtoul(buf, 0, &val)) || (val & ~TPDM_DSB_MODE_MASK))
>   		return -EINVAL;
>   
>   	spin_lock(&drvdata->spinlock);

Reviewed-by: James Clark <james.clark@linaro.org>


