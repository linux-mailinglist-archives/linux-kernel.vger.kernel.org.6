Return-Path: <linux-kernel+bounces-251954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E38D7930C21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 01:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9CD1F21EAE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 23:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A7015C0;
	Sun, 14 Jul 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMIdFc4M"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56E81BDCD
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720998497; cv=none; b=AS0m93l5wG2ZehvaiN8boc5VpPkTXuZiFFQb1N8qQlh4DUq7lS8qXKo/id9nHjQ6Vi/O6mekY9SMH7KN1dD5P5PKrfk5xj5Mu5SrqprCnJwpabYwj6suEf4pHTwQ+QTfLggxbBvbGOG03g1o2zjSy+a1plMsLB/vCLS5uqiEBuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720998497; c=relaxed/simple;
	bh=OMkN5np2QtCs1JNvE31sSeSC1J+h0T2xqETYrtz/Jvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nk5fnDCoHlSwlorZTzftJOl4GqMZO6s+lYqC/AFDFPN18c+F3S8oe5Rao4BkQwZm+hByPgMjURTFP9BtLhmfdnRRVLXuaAD8IfXwEHS0WgHaZ0KMJF1DufqbzfpxZZI+HK/PbS/VpJ7P+pC9qSzXEVrLO5U2zXiCyFCUdvxRsoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IMIdFc4M; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367a9ab4d81so2260875f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 16:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720998493; x=1721603293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giOaqGkW3gh78EAsAQJqHIlxqObHcBjMGF7SPoyrBgw=;
        b=IMIdFc4MW2Yg6OPSpUgXBa4MZbS6twZtslBhTsBJ/IK001rWc78GjXZPPWUOeHMfem
         NRTkTmWSWoTKQoznW7tU+fXPkOnQPuQzCu/WbSOg71unlJYQo+mcFADiKCfGX5vv6qwi
         gmiFfLImakLREO9JdXat5GPOOPSyrOQkFQVy4WRbDCBkrE2s/4VKmLp9U3cCWYXBM//E
         DHFY3FAAN2d13PTOmtvWc3b+AgUkAtfuO/f7+FZCbX8ouqDizj7YZHVwvO3MUnBnIxm6
         1CXBX/53qgkJAGhy8gq1OXN+Wd9P/wMTBKHgURf2+QbCEvS3ROKrhD3ZqF3BK6lf2r0o
         3PLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720998493; x=1721603293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=giOaqGkW3gh78EAsAQJqHIlxqObHcBjMGF7SPoyrBgw=;
        b=oTJxJ58RuUjcZwsCc59ZBShi3ip/88/Y/5Rmd+DFll6ycrJPBp/1AK2HK9rYARzGb5
         yxvBblMFdbVo8Jl4qUmyHFuLCcULBlsjcm55Ng01CCSEy//o0dYq5pxctugHcrXFmvvv
         oJaxrmQ+SyVOJwznZBfUL9Im1kdrcba5m3RFwk87tnx49u8GBHapMyJbk1uqmg7PgcwQ
         69zelDbK72ySWsYOt4KTfcWGG10iJZYNTIqC6yi+ojSk6xqiGEReDJjxWHDZ8OuaOU1Y
         1gBs05c/zBvFPP8sQoRhRuKmG7YGdHQuvWWpYFfOBm5rbf5KJpXRq1JVnB16DSn+31AB
         DNdw==
X-Forwarded-Encrypted: i=1; AJvYcCXHzi/XqOT/z7nUd8MYmHzZE0uS0vY4Aw3vhcJpDhJ/qdx2lYrAgc8HD0sJT1f4/7zLAKcPiDtcAQ8fz7NbrNZreNIohefwi5L8pK+b
X-Gm-Message-State: AOJu0Yxg7qOba2jz+0ugu0d8unTwOIlvK7p+QNyPYhgkGBTyRMpYtvvl
	RkN1UQx5l3HWk3GoEoZHyAvOu2eFnj17Sof/lqg7J+IOUHYMVsA7boHMojWvpLs=
X-Google-Smtp-Source: AGHT+IHEJtdJ8gx7OOIcLqOTFIx9I0LKxCSaI1ZsOORagte27E0UhFbA3bxbSv/hBaM4nMePlTVBRg==
X-Received: by 2002:a5d:6a52:0:b0:367:8909:197b with SMTP id ffacd0b85a97d-367cead94b9mr10738905f8f.61.1720998493213;
        Sun, 14 Jul 2024 16:08:13 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccc55sm4807421f8f.50.2024.07.14.16.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 16:08:12 -0700 (PDT)
Message-ID: <dfe6be96-9ec1-4f49-b561-19865bc313c9@linaro.org>
Date: Mon, 15 Jul 2024 00:08:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: domains: add device managed version of
 dev_pm_domain_attach|detach_list()
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
 <1720763312-13018-2-git-send-email-quic_dikshita@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1720763312-13018-2-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/07/2024 06:48, Dikshita Agarwal wrote:
> This patch adds the devres-enabled version of dev_pm_domain_attach|detach_list.
> If client drivers use devm_pm_domain_attach_list() to attach the PM domains,
> devm_pm_domain_detach_list() will be invoked implicitly during remove phase.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---

> +	num_pds = dev_pm_domain_attach_list(dev, data, list);
> +
> +	ret = devm_add_action_or_reset(dev, devm_pm_domain_detach_list, (void *)list);

Fairly sure that cast isn't necessary eg

drivers/input/touchscreen/ili210x.c::ili210x_i2c_probe()
drivers/power/supply/axp288_fuel_gauge.c::axp288_fuel_gauge_probe()

---
bod

