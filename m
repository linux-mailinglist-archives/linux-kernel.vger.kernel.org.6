Return-Path: <linux-kernel+bounces-443275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7220D9EE9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9E0284413
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB3321639F;
	Thu, 12 Dec 2024 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8DxFlzl"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E922EAE5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016004; cv=none; b=MDtcAXhNAJ93kh/lMWQr3wnsTu4XuuASWtLodHYtvrTOrZTBzSgqpkUsqsq/qaEBRA1YrVRuErOEWKfIqdUBo2xxcNHW4M86WSIbC0FJsynYWwxTw3two7TMKmVJkY7pZPkfI64rjEkQV1zWDkWCo0BsaQ9wrThQw4VDec8mU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016004; c=relaxed/simple;
	bh=/wZygdcPbfhCUlwBFtGxcK7TxSYJ5BeDftNO0C1wHg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aa4GCpqmjogs/CDvoXxdni3obLmdhjGa9NWpYrDydU/uF/+lrTNwlQLjd1bd53Ppy3lWxxnY8FIkWkRFleE+OTjeu6yYdWMJ/Mrpue6lP8a0N5hGfxFytMHMgrkF1vD9OP9FEvx+70tboBIuP5+D+n0+i1LdMY/aQ34K5LHRY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e8DxFlzl; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f75d529b49so183681fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734016001; x=1734620801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/O98ViGQY1w3fTqJRY4spp8fbDk/chDJNOLVHC54GE=;
        b=e8DxFlzlD/kAqjDBbtpjfHl0MgPX+mZuyVr31LBWRZBiP7Dd4Eyt1wCM8TxOk82Qyz
         2DrFPG7ZY4mC363B3KdkcbITkMqil1x311U858YY2toAspTMckYV4hd2xEy6ZcjW40O3
         pNmr2sP4u06XVKUyByYNCMNeo8yQU0QE0oPcib4yBGG1o4tTRLaapXLIlbdC25FGaxto
         BrVmbtyxHcUS638OoRgI8zMkVEjz6BdeOkiYxCGVCo9padVIz0r7evPcPbQf8oB11XpZ
         U7aT0v6aTcDxii3++JvDQXUL51wNawl0FaSHThuhQtFQUV2dfKxalkNQw840pMbAknhm
         YRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734016001; x=1734620801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/O98ViGQY1w3fTqJRY4spp8fbDk/chDJNOLVHC54GE=;
        b=L9ihwH/x765dbkvSgZd6QPTLVNXHK7rJ3TXB9aLm3/mOFQNHzQ+mgCQa37ziLpL0AE
         ArLva1S6ZC6+pO9xxwo1C4MoZjsUm6PnX9PhgLF6C98TrsFVys0zgLWBX03/ZrmjKYtt
         Yq6zAEGEbCcZoe++bVDKDXYlL2NQX/POTSR0RmxIbkry81HUPk8A5ITO/JECnc9r2rri
         iIYJuUuJ1hfWkULxv6/Uol1TDK3QUqpAYU97/YnRPajo3oamH16wi51BOfId9trvR7wO
         nFPYVef3zPHrA10ObqnTODJHFEm0Oj5h2jERiaaT0XDk+/eV667DSPgbcVnjRYDHU79r
         +cHA==
X-Forwarded-Encrypted: i=1; AJvYcCWevoIg+6DPJZl3ZMPuhS9spOCj1CcNebVtX90FxWqnewzY3Uz2gFgIB+dh936sWuHLqJXvp/1dxatUQs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbzxG8E/gxxZ7RB4EbZrxbhnBPAzfmN+1mfOxaVWduwa/BZhEs
	SbKnGMLtHWxtmoiW1g87d4cfmRZG8EN39EHWtHpJaN6SIk2GbbDhIxQe+FZHwKo=
X-Gm-Gg: ASbGncv6aRVML17Mw0sQ43kqF5XI0QPOElqP2ptVWSuaZMDz9ardJuQtgISIERyJZw5
	pLQBfH7LXv7p5nLpH8DLd49opCM7/+Y8B7cs3PhsDfd3QPGBh4Kz+MNslCDjy9H89OStO/Xpn63
	1Gl512g5apl8LT/oipB65STUZ8iUOcyza5+Z6UCJMexh5a84MHsMrNQY5oT7rJzoeaenl9oAmkc
	lpucUvquhdS5AuebtntUYnF83t0SW3HmA5/gMbi39AaZic5ZjLj5JH2lTDX5ZA1fRg1N56cX9un
	Zd2sP4udXve0y3sBT8QgbmbkbRKvpxYDfKg=
X-Google-Smtp-Source: AGHT+IGCHJsVNeNFIhfvJaRBPxfq+foN6JZUPLah8jpJwqCp2Bz493COAu9+f9Y5GGf9k2n7G5+5gg==
X-Received: by 2002:a2e:a98a:0:b0:302:1cfa:2460 with SMTP id 38308e7fff4ca-30251cf9c61mr646791fa.3.1734016000595;
        Thu, 12 Dec 2024 07:06:40 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3021df72603sm13524291fa.100.2024.12.12.07.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:06:39 -0800 (PST)
Message-ID: <ec2d1916-45b5-4b90-ade2-3fdc091fc0b8@linaro.org>
Date: Thu, 12 Dec 2024 17:06:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] clk: qcom: Support attaching GDSCs to multiple
 parents
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-0-5d93cef910a4@linaro.org>
 <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-3-5d93cef910a4@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v8-3-5d93cef910a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryan.

On 12/11/24 18:54, Bryan O'Donoghue wrote:
> When a clock-controller has multiple power-domains we need to attach the
> GDSCs provided by the clock-controller to each of the list of power-domains
> as power subdomains of each of the power-domains respectively.
> 
> GDSCs come in three forms:
> 
> 1. A GDSC which has no parent GDSC in the controller and no child GDSCs.
> 2. A GDSC which has no parent GDSC in the controller and has child GDSCs.
> 3. A child GDSC which derives power from the parent GDSC @ #2.
> 
> Cases 1 and 2 are "top-level" GDSCs which depend on the power-domains - the
> power-rails attached to the clock-controller to power-on.
> 
> When dtsi::power-domains = <> points to a single power-domain, Linux'
> platform probe code takes care of hooking up the referenced power-domains
> to the clock-controller.
> 
> When dtsi::power-domains = <> points to more than one power-domain we must
> take responsibility to attach the list of power-domains to our
> clock-controller.
> 
> An added complexity is that currently gdsc_enable() and gdsc_disable() do
> not register the top-level GDSCs as power subdomains of the controller's
> power-domains.
> 
> This patch makes the subdomain association between whatever list of
> top-level GDSCs a clock-controller provides and the power-domain list of
> that clock-controller.
> 
> What we don't do here is take responsibility to adjust the voltages on
> those power-rails when ramping clock frequencies - PLL rates - inside of
> the clock-controller.
> 
> That voltage adjustment should be performed by operating-point/performance
> setpoint code in the driver requesting the new frequency.
> 
> There are some questions that it is worth discussing in the commit log:
> 
> 1. Should there be a hierarchy of power-domains in the clock-controller ?
> 
>     In other words if a list of dtsi::power-domains = <pd_a, pd_b, ..>
>     should a specific hierarchy be applied to power pd_a then pd_b etc.
> 
>     It may be appropriate to introduce such a hierarchy however reasoning
>     this point out some more, any hierarchy of power-domain dependencies
>     should probably be handled in dtsi with a chain of power-domains.

If so, the description shall be found under Documentation/devicetree/bindings/

>     One power-domain provider would point to another via
>     dtsi::power-domains = <>.
> 
>     For the case of GDSC on/off there is no clear use-case to implement
>     a mechanism for a dependency list in the GDSC logic in-lieu of already
>     existing methods to do dependencies in dtsi::power-domains = <>.
> 
>     A defacto ordering happens because the first power-domain pd_a will be
>     powered before pd_b as the list of domains is iterated through linearly.
> 
>     This defacto hierarchical structure would not be reliable and should
>     not be relied upon.
> 
>     If you need to have a hierarchy of power-domains then structuring the
>     dependencies in the dtsi to
> 
>     Do this:
> 
>     pd_a {
> 	compat = "qcom, power-domain-a";

Please remove spaces in compat property values.

>          power-domains = <&pd_c>;
>     };
> 
>     pd_b {
>          compat = "qcom, power-domain-b";
> 
>     };
> 
>     pd_c {
>          compat = "qcom, power-domain-c";
>     };
> 
>     clock-controller {
>         compat ="qcom, some-clock-controller";
>         power-domains = <&pd_a, &pd_b>;
>     }
> 
>     Not this:
> 
>     pd_a {
> 	compat = "qcom, power-domain-a";
>     };
> 
>     pd_b {
>          compat = "qcom, power-domain-b";
> 
>     };
> 
>     pd_c {
>          compat = "qcom, power-domain-c";
>     };
> 
>     clock-controller {
>         compat ="qcom, some-clock-controller";
>         power-domains = <&pd_c, &pd_a, &pd_b>;

IMO it's a very fragile scheme, and like I've stated above at the bare
minimum for future usecases the description shall be found outside of
commit messages, preferably in the device tree bindings documentation.

>     }
> 
>     Thus ensuring that pd_a directly references its dependency to pd_c
>     without assuming the order of references in clock-controller imparts
>     or implements a deliberate and specific dependency hierarchy.
> 
> 2. Should each GDSC inside a clock-controller be attached to each
>     power-domain listed in dtsi::power-domains = <> ?
> 
>     In other words should child GDSCs attach to the power-domain list.
> 
>     The answer to this is no. GDSCs which are children of a GDSC within a
>     clock-controller need only attach to the parent GDSC.
> 
>     With a single power-domain or a list of power-domains either way only
>     the parent/top-level GDSC needs to be a subdomain of the input
>     dtsi::power-domains = <>.
> 
> 3. Should top-level GDSCs inside the clock-controller attach to each
>     power-domain in the clock-controller.
> 
>     Yes a GDSC that has no parent GDSC inside of the clock-controller has an
>     inferred dependency on the power-domains powering the clock-controller.
> 
> 4. Performance states
>     Right now the best information we have is that performance states should
>     be applied to a power-domain list equally.
> 
>     Future implementations may have more detail to differentiate the option
>     to vote for different voltages on different power-domains when setting
>     clock frequencies.
> 
>     Either way setting the performance state of the power-domains for the
>     clock-controller should be represented by operating-point code in the
>     hardware driver which depends on the clocks not in the
>     gdsc_enable()/gdsc_disable() path.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   drivers/clk/qcom/common.c |  1 +
>   drivers/clk/qcom/gdsc.c   | 35 +++++++++++++++++++++++++++++++++++
>   drivers/clk/qcom/gdsc.h   |  1 +
>   3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index b79e6a73b53a4113ca324d102d7be5504a9fe85e..9e3380fd718198c9fe63d7361615a91c3ecb3d60 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -323,6 +323,7 @@ int qcom_cc_really_probe(struct device *dev,
>   		scd->dev = dev;
>   		scd->scs = desc->gdscs;
>   		scd->num = desc->num_gdscs;
> +		scd->pd_list = cc->pd_list;
>   		ret = gdsc_register(scd, &reset->rcdev, regmap);
>   		if (ret)
>   			return ret;
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 4fc6f957d0b846cc90e50ef243f23a7a27e66899..cb4afa6d584899f3dafa380d5e01be6de9711737 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -506,6 +506,36 @@ static int gdsc_init(struct gdsc *sc)
>   	return ret;
>   }
>   
> +static int gdsc_add_subdomain_list(struct dev_pm_domain_list *pd_list,
> +				   struct generic_pm_domain *subdomain)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < pd_list->num_pds; i++) {
> +		struct device *dev = pd_list->pd_devs[i];
> +		struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +
> +		ret = pm_genpd_add_subdomain(genpd, subdomain);
> +		if (ret)
> +			return ret;

It's needed to rollback call pm_genpd_remove_subdomain() for all added
subdomains on the error path.

> +	}
> +
> +	return 0;
> +}
> +
> +static void gdsc_remove_subdomain_list(struct dev_pm_domain_list *pd_list,
> +				       struct generic_pm_domain *subdomain)
> +{
> +	int i;
> +
> +	for (i = 0; i < pd_list->num_pds; i++) {

To be on the safe side, and especially because the order on the list has
high importance, please remove subdomains in the reverse order.

> +		struct device *dev = pd_list->pd_devs[i];
> +		struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +
> +		pm_genpd_remove_subdomain(genpd, subdomain);
> +	}
> +}
> +
>   int gdsc_register(struct gdsc_desc *desc,
>   		  struct reset_controller_dev *rcdev, struct regmap *regmap)
>   {
> @@ -558,6 +588,9 @@ int gdsc_register(struct gdsc_desc *desc,
>   			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
>   		else if (!IS_ERR_OR_NULL(dev->pm_domain))
>   			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
> +		else if (desc->pd_list)
> +			ret = gdsc_add_subdomain_list(desc->pd_list, &scs[i]->pd);
> +
>   		if (ret)
>   			return ret;
>   	}
> @@ -580,6 +613,8 @@ void gdsc_unregister(struct gdsc_desc *desc)
>   			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
>   		else if (!IS_ERR_OR_NULL(dev->pm_domain))
>   			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
> +		else if (desc->pd_list)
> +			gdsc_remove_subdomain_list(desc->pd_list, &scs[i]->pd);
>   	}
>   	of_genpd_del_provider(dev->of_node);
>   }
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index 1e2779b823d1c8ca077c9b4cd0a0dbdf5f9457ef..dd843e86c05b2f30e6d9e978681580016333839d 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -80,6 +80,7 @@ struct gdsc_desc {
>   	struct device *dev;
>   	struct gdsc **scs;
>   	size_t num;
> +	struct dev_pm_domain_list *pd_list;
>   };
>   
>   #ifdef CONFIG_QCOM_GDSC
> 

--
Best wishes,
Vladimir

