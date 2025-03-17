Return-Path: <linux-kernel+bounces-564059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD84BA64CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA0216E732
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C039F2376E9;
	Mon, 17 Mar 2025 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euz0JyeT"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592AB237180
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211405; cv=none; b=LGKCv6Z/IR/f4jj385hm+Ttb+sqqAoT5/cl+GF/nhOFx+Zm9+MjmuMAkXtWx3SkSLEaFnkeGAaBPS3oMEMOoIm8NXPkQQJ+P9mBrkVLo/kqFSxnSuizcGr4ktyk49TCyLPIJpZDj3kE0iEqEmGYIEjN1Qllgz4uOjV42JOdjZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211405; c=relaxed/simple;
	bh=XF+xjFzfvsRusTv+hNUdH1HO8A7M/Z2r9YWIS8m7KTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlXLKrK7ZKB17O3VBRV7f0geK0liWUe3434K/ow97Bzu3kfsCLI2+pLLovMC9DtbeV12Jig4NQPl4l9FIYCCOI8gRWg/jXWv2gmKJ9E+QZWxCsS1+ih+IkzDJ+XA8SOH/ZhzcZpRFNni6lqxMy8Oumea6pg3HttDDIp/eQ4Eads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=euz0JyeT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso14015715e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742211401; x=1742816201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jN0+M4gX8uMSJYT62hKxDE04ZoXl8RCCMboFMq8K3LM=;
        b=euz0JyeT2ItY0F8ky0Zq/rnDtooojtWv5fN5TDrK3q4UdJGU+gbAWl+YBDU3YXuOrt
         G+ROZ+Poi+2bXnvNgneArxV3CqAEotOtal86PBQysaDPOuHah8OJOPus463TdaUIP9ai
         zFqpHbaDiyNQnrZn1Z1Xihh7YA1IP5kga/TZMqsh1dGc6lbWBvC7yJch0C6BO0AJ0Prh
         BKMUIgaR4t9VRuy9aKAANt3t0OkQBH3OysAQEKHZX5bD0ZITGQw8/XIQw92Fp6PutYeY
         bJurU+9G+Nw+MfwwmTvEvGhjxMtoeO2ESFIXDc0Ok97QLQxVfiwZzXoaK5hB1btEHEJK
         XNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742211401; x=1742816201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jN0+M4gX8uMSJYT62hKxDE04ZoXl8RCCMboFMq8K3LM=;
        b=YBIt3aDPzgOF6aNbD/SSg2z8DtGE03B0RmLmaGdclT8H670zT5mC6ujkn9UWM6G5AV
         bKffRsovF4Fcn9mvw6qntpzBTg7G+ixv0h9Vgvlt6PkRsd/jqXKLHqToJAQ4n4hOa30U
         JuCjctSzLqkneEh+bYHSBt2o8kglTSxr7uvQ2fWhM1LcmKWtwmYHvHUng9jooRDj9Qwk
         wpwiNsxIPxQ0tGGrgoqTNlxB3GV5eHtswGRm1TjMJcQeR8HpCr14k9ZLN8nHS5dDBlP2
         BWortxtQK7BIrows/+Lk1Hv2wWYG6NWX1IocQLFpnuiXwzra0RnKanK1TiyaVoNAoxiv
         jplA==
X-Forwarded-Encrypted: i=1; AJvYcCX6ImoiDelfmsjSQtTH2qD59gIbvD9jCL/cO4Z1OE362NiFqdAFmqYBsq07UhIcklXLd5y4Gl5M7gSw9zA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3/6ZFwgBlusWfWf2q0fgoIjXa6BrSJAFL5isvCdI6mJuZnC1
	H2Y9Di98WmSP/mKHZilACOMr845ml9poLjI/cEv61CZpCjAaV9Dn6EOzi/iwBadFsWmii2EWA99
	n
X-Gm-Gg: ASbGncuP8jucv+aW+9hbIIDEj8x3QM1/mRrEQazdgfQ7pDYjMMt8K/eEMcwy82TQOqb
	9JygandmAQgjGRNcsCdc1/FeF+Hbh1gSMuKcuZwSL0q+X26+fmD9QhKUVpmNLwNTT44mlhtobjN
	PiFh/VgammmKQMLHMaTDJCKzxVg1sqW46lu1GjDD7bul+qETdW2hXObCcCEfZcZa4yE3Yo/hhBw
	DKKVm4C6hreiszWfn+dcVJOEQTczXmxzIx6GnXCq8o4G9sc8oAjAx0Ms5mwDg/jIhvbqUjOvrxq
	SEfbgdGBMokBhOcRwy4esEnJ58xKljoDRkZMqCBxikT011tgoaU1NA==
X-Google-Smtp-Source: AGHT+IGpe6gVPMzyOS93xBARTNQJHQXaN3m0Z+9TNyPFS5vYkYlGiqRdgGrs5Bmtix92MgU8E4mTig==
X-Received: by 2002:a05:600c:358c:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-43d1ecc3969mr122779395e9.13.1742211401582;
        Mon, 17 Mar 2025 04:36:41 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ec14bsm14651972f8f.100.2025.03.17.04.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 04:36:41 -0700 (PDT)
Message-ID: <c6a86373-64be-4101-a08a-74aa302bf64c@linaro.org>
Date: Mon, 17 Mar 2025 11:36:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] coresight: Convert disclaim functions to take a
 struct cs_access
To: Leo Yan <leo.yan@arm.com>
Cc: lcherian@marvell.com, coresight@lists.linaro.org,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250211103945.967495-1-james.clark@linaro.org>
 <20250211103945.967495-3-james.clark@linaro.org>
 <20250313145456.GR9682@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250313145456.GR9682@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2025 2:54 pm, Leo Yan wrote:
> On Tue, Feb 11, 2025 at 10:39:38AM +0000, James Clark wrote:
> 
> [...]
> 
>>   static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
>>   {
>> -       return coresight_read_claim_tags(csdev) != 0;
>> +       return coresight_read_claim_tags(&csdev->access) != 0;
>>   }
> 
> Likewise other claim functions, can coresight_is_claimed_any() change its
> argument type from struct coresight_device to struct csdev_access?
> 
> Thanks,
> Leo

I only wanted to change the ones that I had to. I think we should 
prioritize passing csdev as much as possible in the coresight framework 
to make everything consistent. Otherwise it's extra churn for no 
benefit, and if we need something from csdev here in the future we'll 
have to change this one back again.


