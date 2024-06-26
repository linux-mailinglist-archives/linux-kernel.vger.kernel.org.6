Return-Path: <linux-kernel+bounces-230432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6688917CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0041C214DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2B16CD07;
	Wed, 26 Jun 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nM05GUG/"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A4B16B38F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395006; cv=none; b=PCteJdfKoIT0YI2A9+gNkkZc/TMv6Efb3/L1rWOXcW3/0FSuyFDLxLiUEWvW+XX9JxKEGsRzKM6aMuwRVhQ1XPEBhOHLRKsnRNZfUafAmtQjyPmJWFQFLLt9A29ofxZvZ6xlykdGwN1sLekSxjInJ5SgHXMBc8sxFqrmpwCWdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395006; c=relaxed/simple;
	bh=23vsqplp7p0dTjJyFJ06exBE7rBzCFg/mwbt7R9Zt58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU1dI5/jUtxzzz2J6L2mCeqj2MzZJYa9w1MoYn9EIpQ/1brY1DjKVgP2KBNsHwiqGZeaAObkzbKDrU6qaoPVHkKro4swIvvvxnGkkA25zbLRkqLacoP33JM2D5YUg68Zcz07LXyzwxdzCNJ3hjGCZLtlEwAtpTqlnFnxErIznho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nM05GUG/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d07464aa9so6695091a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719395003; x=1719999803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T7a7vAWfVEZEUomcIDZr7oOcprDh9VkDg31EMGUcI/E=;
        b=nM05GUG/DfKCU4ydFbrfEIfNGJauiGZnCkLkK8VCRyKeUoj0StN3bcHggVWxnvCuVR
         jDGZZzpL8nAozRmpS3OpRtngIHMcvjOXch531lbvG31vi1IXOc1t5XB9598O8ffxd+H7
         gCwZza67VR3QmbTu7VL3ODM7SNXqCkqm/8CnhKP2r2+m2H0rP8ZZFYJNWboRsLL6qAI0
         eYVCmdlPH5B3qv+r9EHJMO/djjkWDC6niJkId2Y/yMo5M88N7sgrYQfplXAw9I/iZDZZ
         FOlplpS48iY5hxSlkuUeaZ5tcn9GyC+ZEgRatow9oo/c4mmuyx2QAgt5lVo1eGqG4qfu
         puSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395003; x=1719999803;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7a7vAWfVEZEUomcIDZr7oOcprDh9VkDg31EMGUcI/E=;
        b=ABs6Ru2YmeV5yj4M4Nj2zrsmxi8DmZwimucNb7zTwpZvf+EBRpebuhNbxz2qoXg7v6
         JZenixRPbjfOd9Ad9rGWiaPTklK6rFNfYl5l32+6oWSvYCt1kcUFvmEZClsn7yi5ERgY
         Zd1BdG01c+aYFHz+L9PhkdR+FfZJ1048EQ+WPSliUSF76di9m2m6dT6xen02ih+mt0g3
         teZWzXAIs4awZ5zi+i0bRjLMWWlBlK3sduw7wQUYfvmQqW6TL+2FVbGYtDv0kxgXxNNX
         HwnHpb4MexRrJ+NSk8UbLZXD9/yH/CqfX3zSumbwCFp+SMEpKaVAa3WM2FLolo0TvYEf
         VwRA==
X-Gm-Message-State: AOJu0Ywnuu+zvt1+IkZyc7HWAjdo0rQR6+yJGvsJLbd2LaZNONV38ffr
	e4Yks+cVyjQzVb8528ILZkcmw9YWnluGllj3P5KayGnssL3J+5VgDrKuM6bi16w=
X-Google-Smtp-Source: AGHT+IEq0RJtYLiCqRoGI4aTI4VSTQHwfMrCezWO3XMrfrXZYmNqHKhZXM4w93fk2hA+LMUbY9zq2A==
X-Received: by 2002:a17:906:35d4:b0:a6f:af96:1230 with SMTP id a640c23a62f3a-a7245b4cb88mr639074666b.1.1719395003280;
        Wed, 26 Jun 2024 02:43:23 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724491c8e1sm404787366b.38.2024.06.26.02.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 02:43:22 -0700 (PDT)
Message-ID: <48ee8fc0-62fd-46e8-aaf9-5ad416706191@linaro.org>
Date: Wed, 26 Jun 2024 11:43:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 2/5] mailbox: Add support for QTI CPUCP mailbox
 controller
To: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
 cristian.marussi@arm.com, andersson@kernel.org, jassisinghbrar@gmail.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 dmitry.baryshkov@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, quic_rgottimu@quicinc.com,
 quic_kshivnan@quicinc.com, conor+dt@kernel.org, quic_nkela@quicinc.com,
 quic_psodagud@quicinc.com, abel.vesa@linaro.org
References: <20240612124056.39230-1-quic_sibis@quicinc.com>
 <20240612124056.39230-3-quic_sibis@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240612124056.39230-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.06.2024 2:40 PM, Sibi Sankar wrote:
> Add support for CPUSS Control Processor (CPUCP) mailbox controller,
> this driver enables communication between AP and CPUCP by acting as
> a doorbell between them.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

