Return-Path: <linux-kernel+bounces-416143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EB49D40D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B051F253AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D4F19E82A;
	Wed, 20 Nov 2024 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQ890Sme"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B96D16D9B8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122553; cv=none; b=rEkzh1gnvQue2e9rcJhd5dl6ImtWtS8iC97GhduUySzxMSfYIj0XWpmA0DZ3iCSLXZry0MbcawZS5MMZbX0jHW4KEqJjStftAAoOtpW3532c7LA4FSBm2W1vHYNTUBs4NHvRN4t5NPBBtXAoRp2XsqMYK4gZ3c1g7/yF7hPcab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122553; c=relaxed/simple;
	bh=GxGYBTBzNgOeIfq/QdI2OaIkEKakJlVruSDheSbNFFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZG49AaIMX/K8kuMlBrP1+NkiG0j36nnrWqGLVJCK6L4cwbgoHJ/kgM/3SR4SvEi+rjwtQiQ9JaTwZ1i/lqVWnSrjqTSnhwzKqld3CWu6bzKcfET1V6d4z/kkHQ6mGRNzNA+Y7ki1N7BEOIornuw6gen2gmQ3w/EdxdYMRGKIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BQ890Sme; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so61803175e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732122550; x=1732727350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lBaWVIKUDm8mK0qFWu7ZMD66HrRVg+A8qSokIpCLr0=;
        b=BQ890SmeFYdur6wFjXEHO7s5gpo3VUjwH1KfoUuCzRrDxF6USOgLfi1KvtlMX48NSJ
         m8r+yEcEAUGMWSASciaAe+LZZRLIb7Wj5FZQ9ajG0PYlopMG4nO7cxTXtCrQ6Y6ULaSV
         MjlDNHR+iABTSPetyJVowR7FLYBufsdLYSEldM/p69njeUw+VzsJbuSIek6lgT7I26B7
         AAjxWOnSU4BC2rW8l/MMHjzoNB9Rb8h/YwF5DS9rpkW/NyCccIZMpiNkMOcboppJchGX
         BJyUVVMwfOAxz59qHeK9ZlbFUR6yrOOAT/90sYSk/030U5l0J82BWG/Lkq1Xfzk4eMY5
         Apgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732122550; x=1732727350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lBaWVIKUDm8mK0qFWu7ZMD66HrRVg+A8qSokIpCLr0=;
        b=kck5D0OJ4n43iel2mIGGKYcfwZi8s4lbEHVmAEo0LVu0p4gFvVzed8DxzPrkGJVcDs
         ZXbXA9cYkIgjPQf3PhUdt7yaK/m1URYtj+NiXZ+ttFRQNBIrgp4sWE5xd5WGX+pUwBvB
         Z5OTKOzNMOF42siT5caWxphBYxSWWIiFhhkAc4Q74AZygtx4wRRsrPAJSgBwAPG1zaem
         U097N+LGTSZMpykAJHQ1rsv0VgKdhAn4oNTxkx8A0Q8LJJseszuIpR8GQNad7eoEp6jp
         slJaifUyCpuIIp+CpmYKgWK4aAVteq3dnOO4tVhpUnaoemjOTUYVIA4A6/lFHKkwohVO
         m4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVdT+7b8BkjzMxdHIqoQFgvmna8hkJFh83nRCQQwFu8l5tmqGcGQOD0q4qEcNNDj7XwZWCDkYrLgC5cDVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7n2WKec/jNVfPnKZszmyM458zhpn/AKGYC5Ym4TjtRC+iNLq
	ucgz9Fg3lqlHc9yvAHt6U/l3917HZiwMHcOhMoQLgJDM+K3sPm5IlOLGMKB/tjw=
X-Google-Smtp-Source: AGHT+IGiaYIxKh7fbsrmK6tgUUwDYtTaqJ5Wpge3WBivCuMq4wZZiH8eGrvzsvlRCSKNGG+wDtIT/w==
X-Received: by 2002:a05:600c:3b12:b0:431:4b88:d407 with SMTP id 5b1f17b1804b1-433489819c0mr37456805e9.5.1732122550515;
        Wed, 20 Nov 2024 09:09:10 -0800 (PST)
Received: from [192.168.0.200] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b46359b9sm25029685e9.36.2024.11.20.09.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 09:09:09 -0800 (PST)
Message-ID: <7a52ca1f-303e-44ae-b750-6aaa521516c3@linaro.org>
Date: Wed, 20 Nov 2024 17:09:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: qcom: gdsc: Add pm_runtime hooks
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org>
 <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-2-b7a2bd82ba37@linaro.org>
 <zhhna2wni4yqhnc2tqfc2ugril3h4kzbyr3ix6vpwrgghwytfa@kjfpff5zdl4z>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <zhhna2wni4yqhnc2tqfc2ugril3h4kzbyr3ix6vpwrgghwytfa@kjfpff5zdl4z>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/11/2024 15:34, Bjorn Andersson wrote:
> What I think you want is two things:
> 1) When you're accessing the registers, you want the clock controller's
> power-domain to be on.
> 2) When the client vote for a GDSC, you want to have the PM framework
> also ensure that parent power-domains are kept on.
> For the single case, this is handled by the pm_genpd_add_subdomain()
> call below. This, or something along those lines, seems like the
> appropriate solution.

Yes.

I'm finding with this patch reverted but, keeping the first patch that 
it pretty much works as you'd want with the caveat that gdsc_register -> 
gdsc_en -> gdsc_toggle fails the first time.

After that I see the GDSCs on/off as excpected

cat /sys/kernel/debug/pm_genpd/cam_cc_titan_top_gdsc/current_state
off-0

cat /sys/kernel/debug/pm_genpd/cam_cc_ife_0_gdsc/current_state
off-0

cam -c 1 --capture=10 --file

cat /sys/kernel/debug/pm_genpd/cam_cc_titan_top_gdsc/current_state
off-0

cat /sys/kernel/debug/pm_genpd/cam_cc_ife_0_gdsc/current_state
off-0

Perhaps we just need to fix the probe path @ gdsc_register()

---
bod

