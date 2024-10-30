Return-Path: <linux-kernel+bounces-388511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B178A9B608C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529BCB21682
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F9F1E3DD5;
	Wed, 30 Oct 2024 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKzAJtl6"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0C1E32CB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285632; cv=none; b=KKSoI+x5mtBRV/d0fuRgoQ8ZHEbWtV+6/B+33ilIQu8Cg9cJb9sD6N46LeNz5GAMZOItnOcQCvKFO7FK1qqrLKFfxlmdBuJHvyqtA/Cwz6VWzqGG0sO4BMKm/6Z4Hs9bhkrFd7107hdzeubDBbGrMWGrnoXkiX8N/FU6QAiglLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285632; c=relaxed/simple;
	bh=KDU1+7ZnVtYCy9gRBggHWB94leu6oxv4QpxSzLT4cLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USN2kzGB2GwtpVtjvrs+GnsZ0rK+wtrH4AFHsNGJrAR7DpCir6v48/BvagXH6VX/CjV6ESnghfzDsJCmfKUJygj423y7tJLM6KG23ameuFeLMzNUtP/DOwIlSTW0JhS11avLOu2wCMlXIFc4IuBerd5ElkAZgiBhfjnZHcjgjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fKzAJtl6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e4488012so759257e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730285629; x=1730890429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r90YpozeaoCUvndH8AD2U9m1kd09qNk8K+E3W0sjRsI=;
        b=fKzAJtl6J7foWoUIsIvQiEkAdmIXIYogNITdAOzsdKRalaKg8QcSEofbFgZTF4gDz1
         DaULU6TiYEOp8X8ymFBtmw5tuZTMg+AMRtCSJaux0CvJ0lHQQWSOzvKANluusK7Pk1or
         h7Sqm8KbINxsUuMbBmGkO8AUNq0NuhAuuElsBFTLcF7p6vT93IE4fbF4OG/PYDyVJzcR
         55CClvIw5RREEI+6dLW3zj/0g7+/QwW0CwNOW13VoyDENZcXoYJ15wRIyXmf8kcHlYBK
         cGq0kKomn0BrnJQu/OpgKIhoTl8pSZowD6rTEEb9PkjTpdsRa0X7XqhnvIBEcmoyOfKk
         4bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730285629; x=1730890429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r90YpozeaoCUvndH8AD2U9m1kd09qNk8K+E3W0sjRsI=;
        b=lKNPc3tr06u3wh/92fyOeVLvRN3gHfETvMdnySSYK9v5WjORxQP826kyPhzdfuou+3
         5bueHcNJAEAZARHTSkyTq/n1k173DfNQWWwU2kc/sMLTMNJf9sqtvhLa+XLGNv+QDgq3
         fQLjIql0qtfPULNKV+CYzL8iOTkG/nJuINxxLi2BX2Y0ZcHrJMD2VF8oUa0lqBiR07W0
         AKn2odZiUBqSTI/woPg3BuhWaO1mqr8mbIOrkpawELAln2apUFQ9B6+rQOgJ+dnVU7dC
         ZwMHXl4MEL+111VZdaAp1EyU9ycg0zbpQmbRtCxqpA4CcJbYdfHZzkhPcnAaqBzKU/kX
         dLCg==
X-Forwarded-Encrypted: i=1; AJvYcCXAu4QfLoi0EMSHgO54bSPQgR05XGzg0UawKxYfQhruddFwGlC1oVINQmp2V7ne7qKHQ9Ywqm1Udzz3mSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQbft1R6MLGoujs0do/BG7LLrSnbRCFm1ITT/u3mxSiHK/lA7z
	qqMTcaN5kozNH9l0qBkaHD7m6SwrfslTAsW0OBzSITJ6faX3HtA1HredOe0K6GI=
X-Google-Smtp-Source: AGHT+IGYv8fqW9j0td8pyKJ/XV0vhPCxGKBeN/I4HT71o3DsyGkxaEPZa0NHC4ebYcOXKS9xLYt3Bw==
X-Received: by 2002:a05:6512:104e:b0:536:9efb:bb19 with SMTP id 2adb3069b0e04-53b348c8a1emr2185606e87.3.1730285628678;
        Wed, 30 Oct 2024 03:53:48 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bc0d7024asm215292e87.293.2024.10.30.03.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 03:53:47 -0700 (PDT)
Message-ID: <f5003f25-6a00-42f8-a130-5ce3c8761674@linaro.org>
Date: Wed, 30 Oct 2024 12:53:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] i2c: qcom-cci: Remove the unused variable
 cci_clk_rate
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, loic.poulain@linaro.org
Cc: rfoss@kernel.org, andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20241029020931.42311-1-jiapeng.chong@linux.alibaba.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241029020931.42311-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/24 04:09, Jiapeng Chong wrote:
> Variable ret is not effectively used, so delete it.

Variable ret is not deleted, the commit message is misleading.

> drivers/i2c/busses/i2c-qcom-cci.c:526:16: warning: variable ‘cci_clk_rate’ set but not used.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11532
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

With the needed change to the commit message:

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

