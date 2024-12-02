Return-Path: <linux-kernel+bounces-427698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57929E04E5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654AB2866C6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B2E20371E;
	Mon,  2 Dec 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewY7/zbV"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CDC203705
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149746; cv=none; b=IxaMcRLopGqq0/3YgvOM4VwOVJmxyTt3u9Lm+bvSttbcc5NIOr6sW+FlNcn4ToW1DNOqC3A8OGOLSPRHjOgwO6+b53rEpslGqNe1HUgFKJBP0zoqBnyBmlGI6+ujtZ+gyhtdoLp5eMPnAw4KMBEJ1IzYhuK3M73KeB9IUgpXF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149746; c=relaxed/simple;
	bh=wlRI2OT+rw+dkTzxhV2YE6EaBFnDzidyVxfTdeJxCaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZM+99KCW5CK9sUDYepz6gaglXeeYzfOB0JlHMXbAzprqbXg32hcy3ZYeuGU4CtvOPX7TM0jXUhCxpefNl7EyA7l7gRasVOjWO/KjsExtzoMfe9lHkgSgxRiUg8Gy/3lE8fvQYG/LsQ4pbr9vPMmgy891mDnWRLCEGhgZxYJFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ewY7/zbV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-382610c7116so2884759f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733149742; x=1733754542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oqc50eNxXUAqEFVmJyEUgH5BLlmcgcNvNFQIb4r4jyE=;
        b=ewY7/zbVVpHL1TlXvdyPSb7QDzLf49TkbToBS848ZhYHhZ6uBz3gdvyfPWxDBifWl+
         353Exkn69k2cjpTOfzq4QSSCa7/B7hxY9D0Ifs3FOinqE8U7LACKOoDNqHg+KH7NRxms
         0hMLzso+AxPP4xBnYUcYB5jG0AADP0btsHpxIZilnhHUHTISUTWNvXnYtAqFj9MxPJtD
         RiowDqjNYJQYTwNkC66X+2H+MlJqcGBkA/WYbPtW84Tg0rOyhxGX0bNVvr5qXtVnN97A
         itcG2+DwfdIFEW5f4wpbTiNn1JvVc9DJqx0iME5L9k+cnUpQ8vUMLvQTeXG8gPfYSkfV
         sU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149742; x=1733754542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqc50eNxXUAqEFVmJyEUgH5BLlmcgcNvNFQIb4r4jyE=;
        b=Q3v6K0qyepKZ8IqMqy3S3YrfHlciABLrvgis+8rS5d72jdw87ufAhv1irJFxhpYEuT
         3TJl1/4QtF+aCFt4+frNLSeOo1eLXW1rWGcAzZJudZBFU4acyPDOYyHYXlLNnjsBW4vY
         HyMAN+SCosM7AUyx7LnZV06fM4+6ZzIbEqCAyz5J59v+gPpugGnp420puFXpvrkDQRf/
         bS4Thumfwy5yTrPD+W3fJaw2ZVPE4OXZfclSoDNOGfo6ipD+vxC/VZOUFcp0FojN67mh
         PQ043ZOxvOPINw1u6dR+mN69rTDIzDV5n7sLDOcaTsbTzf1v5h8nrOsCBHgfDkINVDWO
         nY2g==
X-Forwarded-Encrypted: i=1; AJvYcCXZUWNELzPRbQxIVDxmHIC9GtpsPVNlv9+nf5gWfav5Mz+VYSkibVEE7ByDYo1/Qi2v8N/1Ze40KWVdvC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmHqEF9lXDeaH0H0J6kDRYsULhDHOsU020CT66gRz5eS8wxro
	2rNnWreW+AGLAjjduHIVgQq6iDm4z6pbfrayjwWfLdB1j4ggY1TOVUqdgcv083s=
X-Gm-Gg: ASbGnctGjcPlSm9zssB1sWPt/Lt1b2qHu6imHGQlKLVjErN7EQTFAk4QrmjmrHFq6C9
	xVtjC9oMeCHbm/Cq7J8wcSIaRZU8iYvh8vKTcBZ+WvFcgfsO7pgYULsR8OxJf9qvQSNXLenbfTa
	eTaYRpSUTClYeV5j0Y1DAYukAquiePYeacL5ynq9Si4pfUoPVmTPiPgDcnrxNmh7j52oGlf1ECh
	5C/0bgTjdW4s6Oi9ujtV1RQD0AW5l5S2R02Zc4uNTvKSrcpi54g8R1GcnIJFeQ=
X-Google-Smtp-Source: AGHT+IHBqpOA5WusxHmAizK11N8tj+m+7ZyOd54zDM1M4eEtwjJnc+y1fKMouKLmUy05ESmk1DPYLw==
X-Received: by 2002:a5d:6c62:0:b0:385:f1f2:13ae with SMTP id ffacd0b85a97d-385f1f21692mr3253536f8f.41.1733149741845;
        Mon, 02 Dec 2024 06:29:01 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e9fda2f6sm5698820f8f.107.2024.12.02.06.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:29:01 -0800 (PST)
Message-ID: <84744442-73e4-49c0-a54f-1530093fb27b@linaro.org>
Date: Mon, 2 Dec 2024 14:29:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] clk: qcom: Support attaching GDSCs to multiple
 parents
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-0-24486a608b86@linaro.org>
 <20241129-b4-linux-next-24-11-18-clock-multiple-power-domains-v6-3-24486a608b86@linaro.org>
 <7slvjokv5xcwdpoa77vtg5ihkmgsok5arz2aw2f3wfh4hffkzu@rep6qmkqy2ro>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <7slvjokv5xcwdpoa77vtg5ihkmgsok5arz2aw2f3wfh4hffkzu@rep6qmkqy2ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2024 03:58, Bjorn Andersson wrote:
> On Fri, Nov 29, 2024 at 01:06:49PM +0000, Bryan O'Donoghue wrote:
>> When a clock-controller has multiple power-domains we need to attach
>> parent GDSCs in that clock-controller as subdomains of each of the
>> power-domains.
> 
> I envision a fair number of current and future readers will wonder why
> this is... Why do we _need_ to perform this attachment?
> 
>>
>> Testing on the x1e80100 reference shows that both power-domains need to be
>> switched on for the GDSCs in the clock-controller to work.
> 
> You're making a completely generic change, but are referring here to
> some specific (probably camera) case.
> 
>> Some open
>> questions remain.
>>
>> 1. Should there be a hirearchy of power-domains in the clock-controller.
> 
> Your TITAN_TOP patches is already an example of such hierarchy, so I
> don't think that's an open question.
> 
>> 2. If there should be no hirearchy should the parent GDSC inside the
>>     clock-controller attach to each power-domain in the clock-controller.
> 
> I suspect that the TITAN_TOP gives you this impression that there is a
> "parent GDSC"; that's generally not the case - but the mechanism
> introduced by the patch is still needed.
> 
>> 3. If there are multiple parent GDSCs in a clock-controller do we attach
>>     those top-level GDSCs to each controller power-domain.
>> 4. Finally should performance-states be applied equally across those
>>     power-domains.
>>
>> It may be if we see more clock-controllers with multiple power-domains that
>> some mixture of these questions will need to be implemented for specific
>> hardware.
> 
> GPUCC has always been an example of this and there are several other
> examples in multimedia, which we've just ignored. And even for GCC you
> have a mix of voltage requirements cast across CX and MX.
> 
>> Right now the approach taken here is to attach the
>> clock-controller GDSC parent to each clock-controller power-domain.
>>
> 
> What is "the clock-controller GDSC parent"? Perhaps I'm just parsing
> this incorrectly?

> Perhaps we can use the naming from the API and say "each GDSC is put in
> the subdomain of all power-domains of the clock-controller"?

OK

> 
> I'm not convinced that the propagation of set_performance_state has been
> adequately been understood.
> 
> But, in general, I'm not against the idea of starting off by voting on
> all rails, mentioning that it's likely that in some cases more effective
> propagation of votes can be made and then leave this as a future
> exercise.
> 
> I would like to see 1-2 use cases beyond camcc being exposed to this
> though.

I'm not sure we have one on x1e - GPUCC maybe, I think you mentioned that.

                 gpucc: clock-controller@3d90000 {
                         compatible = "qcom,x1e80100-gpucc";
                         reg = <0 0x03d90000 0 0xa000>;
                         clocks = <&bi_tcxo_div2>,
                                  <&gcc GCC_GPU_GPLL0_CPH_CLK_SRC>,
                                  <&gcc GCC_GPU_GPLL0_DIV_CPH_CLK_SRC>;
                         #clock-cells = <1>;
                         #reset-cells = <1>;
                         #power-domain-cells = <1>;
                 };

I can look around for a list of power-domains = <>; for this block.

I suspect though they are already on as they aren't list.

Do you want examples in the commit log or dtsi changes to accompany ?

---
bod

