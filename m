Return-Path: <linux-kernel+bounces-369608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0DD9A1F84
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CEF1C21FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A51DA0FE;
	Thu, 17 Oct 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yj48kNOS"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337591D958E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159864; cv=none; b=Kc4jymoGZA6W1fNQ977/vJTlyfoyWsWvRUjGYfGJUh2DHG80GVrmzPf0Od0SherVekTHQyyH99/z68IrEN8ZMcuW4/l1GSp3Iim4Br0MhX0/ihc79S6fO747c/sdkW9BMOc+nRSVCqtFioA256/344+9v/WEmcnXbyAjRPotQh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159864; c=relaxed/simple;
	bh=lc00AdCTq/2/t/BtdkukbdZlvrRHBBk0m7Agx+nLNRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCcrf8QM0wbvJonlxl2Vf/8aDnlGJjymLg9ejmRDQ/XJVEwh7lNctjgRPwz6KjHcXBZc8nH/jB25Y4B3dXkckuN7Q3zxFLiIbKSyZMqX9txYRCYxqg5YkbRGPOpDG2pIaBxf2Ft1UVCLABcMdGmw8sMO+XGVftc+dzvROddqMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yj48kNOS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so10650185e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729159859; x=1729764659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwSUtbC2QG30gzod5C51rIfQVl2oLZUpp827zDQsEaw=;
        b=Yj48kNOSHe/z1qV06+sEyMnPtZv8Hrj3S2SRAyPcsH3pPOefEhEtd9TBFIJOOzuXDJ
         u6/ndbYAbcln/YE3KHWMVB/5i4RsIvHO/KuhNvep9Cg+qSGpawV+o6fl/7DgkvPPL6Iy
         yH13uPXc4mP3+gPJXDA8DpFaPpD0nfR3Hfn+kiT5IdS4dccwA1w4qCJPtpaQCjnwyl8f
         OsXoBIA7I7fq8zewHLPFAaWM7zqpQ3R50U1tGhLGQoDthSWoAe0Z07jWTMUMCWNZKNxu
         luls8wbWrFzkDZ/2ZHeKIb4wTeDacY3y4cmJHCVPMHyLkp4YbHCSNlnD0s1bso6P685J
         ZdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729159859; x=1729764659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwSUtbC2QG30gzod5C51rIfQVl2oLZUpp827zDQsEaw=;
        b=TbPGu+x7/HETLXXJlFuyyDwn1ctl8RgP3zBGhZhF5x10tb+eYvv/gjveCUECkiXeYw
         axCXujq6lsWTNVOyWt9/6fbuZs38ir82lLE8wP3OdAhNbr0Hn72Rrj5XTnPkYoayEI6N
         ruUJUC8eXPf0sopAZ+HOHqX/6ItTpcy0cp6V65Q5hprt0XWsSW54H2Ock2u4iPeuAwaR
         Z6btQDKsPEq02XD+w+LWggujNpjWaNIhD7NAUDXL7j7t5XxrVXEzqBucrkme5/sdk2EC
         bRg02U+5k9oSKXHnl32sK0wOj2vJTx2kreWsJ3w73lVHZE26RkHKys9eRy58PQcUx40u
         4UZA==
X-Forwarded-Encrypted: i=1; AJvYcCVWPjCUvrVVoNbnkUd9O71mhbtJ887RESfBmwPixYO2WRLJeP6DVTcaRYCT40q/kI1MdRTOe2o6vwcRvtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+ahcDBtOR+H/GO5dZGXECKe1SLAfbkOqfziZmyQu6EODTwTH
	KuOgd5NURAZeXXv/WrLxoa2YkjWLWCHWgAi9MuwiZlf9499/5qpbgjfNlV17jJM=
X-Google-Smtp-Source: AGHT+IFDQUgdscbI1Z5kPHdk5TBnLr4yFEtXtID8TH+QUdBD6eqOKePMA6XnxQ0TdtETvjOCosrMlA==
X-Received: by 2002:a05:600c:3d89:b0:42e:8d0d:bc95 with SMTP id 5b1f17b1804b1-431255ceac1mr198501805e9.6.1729159859499;
        Thu, 17 Oct 2024 03:10:59 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4314f1c3197sm37677105e9.0.2024.10.17.03.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 03:10:59 -0700 (PDT)
Message-ID: <523d2a1b-7a6e-4447-b74c-9ccd5a6ff870@linaro.org>
Date: Thu, 17 Oct 2024 12:10:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] tools/lib/thermal: fix sampling handler context
 ptr
To: juhl.emildahl@gmail.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Emil Dahl Juhl <emdj@bang-olufsen.dk>
References: <20241015171826.170154-1-emdj@bang-olufsen.dk>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241015171826.170154-1-emdj@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/10/2024 19:18, juhl.emildahl@gmail.com wrote:
> From: Emil Dahl Juhl <emdj@bang-olufsen.dk>
> 
> The sampling handler, provided by the user alongside a void* context,
> was invoked with an internal structure instead of the user context.
> 
> Correct the invocation of the sampling handler to pass the user context
> pointer instead.
> 
> Note that the approach taken is similar to that in events.c, and will
> reduce the chances of this mistake happening if additional sampling
> callbacks are added.
> 
> Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
> Signed-off-by: Emil Dahl Juhl <emdj@bang-olufsen.dk>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

