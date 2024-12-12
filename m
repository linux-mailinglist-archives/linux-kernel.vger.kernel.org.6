Return-Path: <linux-kernel+bounces-443283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A23E89EEA34
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F90282E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1992165F0;
	Thu, 12 Dec 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ibgVMhkL"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E1213E97
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016231; cv=none; b=gmDgRSNBIj6gRLXvL8uvYNp9UsZqHEHH/Ag2VMDSL1uvyMi4iUtXzgDJm9B+SqO0gbUITBTFqlHdV1lZI4v+OXCeO7HyPbSzLtYCuPfVABeqsUTvVIPcsyefVlFgVV4yRPinuSi8XdngvCUdDSPzIYxv4JLrayJ2r3Qvzz7SGeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016231; c=relaxed/simple;
	bh=PVMqYhRnm+wlo36tmUvToJZQuhqtTu5OAs/h41zHOy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZR2tYXW0KSNzkH42jDpmMTqIA0ReGgHhp7SS6/jvKypD2MkQjx+7G5mBsevtPdeBxSt5dYva/eylWBgCrswux0w/VNV59OS/cUVS+qggK2rlNZgtbD0nREaAORTdb/CpzKb+6kUHDXys34YLRZ+DeFkPY/qOOz0IRfnbRoR7Fbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ibgVMhkL; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de3ba3d39so109552e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734016228; x=1734621028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4SFfVxcg8kxQKbemWXTRZwVNSWaAt8ZevWakc+qwDM=;
        b=ibgVMhkL6Otf7ODVkhwzJ/CLnP9eR+Zuu68Kkh7XIkOviVjLNPvmq6ExbrhFjbue5K
         zM1lrUw5Efyy0FgRDy0enc6nSPkfreLXck+Uf4Sg8QUtYP85u2aOjyPz5X6MJ+/9UV7i
         CYTkw0j6Coru8o/Q/ND3wCef6rF/OcvxITDD5S2dtNgXSCr77ELzFrnpqNIQJGNImggm
         lWLUfIRBFeddbvSocnd1e8UruTc72PJDxN90b2fNT7PrwBKXoWPrvFkCT7XxLo3lOnmY
         mLZAHi8wBLLC681gdWFGzISH+pTK9xIvhWy6tvETPCou4yS8GS2oafDR87+Q4HaeSAuk
         QH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734016228; x=1734621028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4SFfVxcg8kxQKbemWXTRZwVNSWaAt8ZevWakc+qwDM=;
        b=XuyKrbe8E775Tkb1/MgVdwVr2s+Jp/8dE+8AD1dbvNqQfMKeFoA3jTVu1rgJ3RfocR
         HxNrUQHCXYmPMfGrCPuvvurRXdKrBidtDRxRyQ0ZUDRgNRx6d3+oVfYVBVNM5vqV2qVG
         IY8UuaKRWOj4R6Xrsl9jn7r0kPKvYDBkEEGyq4BSX4m+dgBLcLjJhotGkDNuGAXZYKOh
         /7YsFhSrVyFAs28eL+reFha+E+krbQ1KC7JWVqy/6Cr/2WohUQehlBfPVh9hqLLIoiCp
         lSBBrE3uhsFTSEo66jq8x3luxROz6LoDWWtwqDk61H2VgdUAgOoqR5jde1n/oVg8etk+
         tjwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpxfMNLubnkeVjzv5gGMA60ttr6/UBDJZ0rahfKzTTTEBxHBizNUifvuLRHkP+gx6j66mNLCH7MWdYduE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK5+ZK5RV5eEkeMLQn3pUAopDd7smO9KZCO9G0fYINmh/c+9wg
	RGRUtnHGFpcyO3S8KSa4f1x/HPTmIti3cqhP9YyJjEmtzkrLDvpQVKBA9y4eU+g=
X-Gm-Gg: ASbGncv/gVAK2cJWANMwM072t/q6r+MAyDMvnZb7BoZ3xRmjhLhy5otDpg1vXnD9qlm
	lWKqumpRvC6acNrnMgXMbeHrqkSHB0+NnuDYs7R9jf/V7l7t0ejQ2gaCJyk7/oU7juUY2cMZXqc
	UdnIedfu8EUHuWzPV4nHR0h5D1+0h/FUZILGS6zTjR7EDNVcBU69QR6vYbefFrsCKC2MMHpTzKj
	iwqvrziu47T4IYUN6HNf2DoTUxkC6LJKCa3hKzmj9lAuY8vqfsjDXeL8+WBRdSf3IBocb6zR8z9
	g3HBOY2TQRcWIxI37kKSMnNVU0KPsGSjV9A=
X-Google-Smtp-Source: AGHT+IGoT95idUMEO9RITO/ZyilZmUskXfV3dbvT0qvNs7YP/Wmf43CG98sgGDEwsXtCh7HB0MnesQ==
X-Received: by 2002:a05:6512:3a96:b0:540:1d6c:f1b1 with SMTP id 2adb3069b0e04-54034101c2emr104792e87.2.1734016227943;
        Thu, 12 Dec 2024 07:10:27 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e34a49561sm2002136e87.83.2024.12.12.07.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:10:26 -0800 (PST)
Message-ID: <09dd1971-74f5-45df-9ecc-e5c2253f416f@linaro.org>
Date: Thu, 12 Dec 2024 17:10:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] clk: qcom: gdsc: Capture pm_genpd_add_subdomain
 result code
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-0-5d93cef910a4@linaro.org>
 <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-1-5d93cef910a4@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-1-5d93cef910a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/24 18:54, Bryan O'Donoghue wrote:
> Adding a new clause to this if/else I noticed the existing usage of
> pm_genpd_add_subdomain() wasn't capturing and returning the result code.
> 
> pm_genpd_add_subdomain() returns an int and can fail. Capture that result
> code and throw it up the call stack if something goes wrong.
> 
> Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/clk/qcom/gdsc.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index fa5fe4c2a2ee7786c2e8858f3e41301f639e5d59..4fc6f957d0b846cc90e50ef243f23a7a27e66899 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -555,9 +555,11 @@ int gdsc_register(struct gdsc_desc *desc,
>   		if (!scs[i])
>   			continue;
>   		if (scs[i]->parent)
> -			pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
> +			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
>   		else if (!IS_ERR_OR_NULL(dev->pm_domain))
> -			pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
> +			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
> +		if (ret)
> +			return ret;

This is wrong, on the error path you shall rollback the registered subdomains
in the reverse order.

>   	}
>   
>   	return of_genpd_add_provider_onecell(dev->of_node, data);
> 

--
Best wishes,
Vladimir

