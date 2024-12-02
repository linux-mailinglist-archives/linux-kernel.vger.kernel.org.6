Return-Path: <linux-kernel+bounces-427484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5B9E01FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA406168C46
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7E209F2E;
	Mon,  2 Dec 2024 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BvhJpLxO"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25920968F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141468; cv=none; b=diXXFNt2aWcmUValN8MDEsoWEEkyA4E68TxSmFWFcrvkJ+YSo6ky2iVSUUC9rzM+k91n89ss81xMkR8b70r2dT3X9Ox/LkEahEDrR2loKp954hiOI4KtlS7+mG6dMLCdKYYEv0lN5Ka1bpKjmcFBp871tZW3Nvj71Uv+xRkjVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141468; c=relaxed/simple;
	bh=h6VpcuSndvt5gb/Lu3I7A7ng3nwMLL1ZD7IPVdwY++s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHLMBedshvouWldrea7i8TWqc0nsZLveQv48FhOo86NXtStO5iGPenrKZZtD528M/akf/m2q9QL44QfZ5zQzeCVj1E8J/UL+Hh/fizrmm1KA6VJpKk0s1dE/cJN4D3aVP+3qr/ar95Spw9E4K/+24xDFs+GSz0oUMfsQZDQsz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BvhJpLxO; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53df67d6659so6064910e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 04:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733141465; x=1733746265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQXENZQVJNQwnHrGpO9XimeeddczjCL8gDUobO6Gaic=;
        b=BvhJpLxOWGf4z5LOJu1sLGJhk7b7mAU0wz2VVtmyrflK28Be8nX9jWEishs4RSSvEh
         y9ZhnI4D5D8xSo4A+K/sZxrtaV0lwMeKpRnMkHN7rxwZt+dZukd59uj1Ou3m+YllaFC1
         s2TpnZd+CCPmmSD/4QG4tn94qfjgw5U5CvzdjvPM2YYHBVJSNfY7GnuViEqx2nIEKRhy
         DLopHQ3fu3aknKtwk0nSO9dzv7ZIy+A0RarB0Y0P2HydFFtI0rQc/dOxxHigxj7tE9gU
         csAlkcXihu8R/dsOrk4P0kbHFI2GYueABRf1rQ2s2GQKqLZmrW9tEiHhY2lPC532nMhp
         MeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733141465; x=1733746265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQXENZQVJNQwnHrGpO9XimeeddczjCL8gDUobO6Gaic=;
        b=cfgjWIElRQXZRSFuhieO7/7Ya2Fha4lwpqL/h6SKBRuJiOhCTSrbkx4UXPq8MsAta3
         OlZVk2ViP5sJphdtaW63nSeTSSmitMXeAg7jUFNHF7qF9js6wKoJ16ipUJejdAlXMIcU
         fsbnG1yovrPSNlGQLC5HFRRNebABfgPSoOkhIItTfZtgDXVdv+Es3/BNyUMmvAFxOPF5
         5AH7GSXzoXT6hurN0URfHZGqRs9kGtZGz4LrpPNtl9X3WppznAxlgLBMiR4PAILEWfsc
         NVAYTci2mjbTUl/HFbUXziteT/kqwSXo/5bF3pp9GPmxRTtGBcAmalrF7E3udkNV3XXP
         AiXg==
X-Forwarded-Encrypted: i=1; AJvYcCVEE2yv00nRT2H/0dGOjy+Q/b51RGLPIPw3Z4kF7MRIjVg/XX/22w/6+BmC/nv+AxKnuaK+tKNdJVn4Mmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBt+A6lRxhPeoCJGZUkuSI0zV+oM5eA5GjxgFRSSJbR4hDQHJy
	62PozNq3sYEXImsDdNG+J3ZzVMq5d8UvyeWab8dK62Kk+jLePNPIja4/kZREPko=
X-Gm-Gg: ASbGncsFYGNwAXto77FspH1SZe/QFvOh2gitEVcIWTh3Y7VLr8ZmFuc1VMUbTZADnB2
	lWgVvx3/m5n88761UQT3zXN2pl3RUv3L6atoAEeT92GVFRNaexRIu/lXqw2VwgEGvqJIPUhB09z
	5l5iR4xrnOEhIrF8KlPT5vGBYBvigIZrMDpuOaTAdHCYuT3s+iNLefsDoeDeFtN5Rram99GZlNd
	vyDIgC0buKb3pt0kxdBa4U9agV8HBeHz6+DJBPDIVDNzXa2lqXAkRyKK5mivO8of0eA1Ino7s2/
	Ls+zmBTkwtEXzLIKy9tG3WDwtxBxeg==
X-Google-Smtp-Source: AGHT+IEzRcIhzwnknvixHamvE9vlf/Jqh7zUcscNKtxe89RF9mRI+5Y0+FdqdzWwutifP0uXEZ5FAQ==
X-Received: by 2002:a05:6512:1247:b0:53d:deb5:3376 with SMTP id 2adb3069b0e04-53df010b17bmr16440685e87.40.1733141464583;
        Mon, 02 Dec 2024 04:11:04 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64968d6sm1416507e87.200.2024.12.02.04.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:11:03 -0800 (PST)
Date: Mon, 2 Dec 2024 14:11:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Abhishek Sahu <absahu@codeaurora.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Gabor Juhos <j4g8y7@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v3 00/11] Add support for videocc, camcc, dispcc and
 gpucc on Qualcomm QCS615 platform
Message-ID: <urlb2pn3cezyx7e6fxxf4j7psmf37amshnlzu7buixp6sxkrgy@mg4zljxn5s3v>
References: <20241108-qcs615-mm-clockcontroller-v3-0-7d3b2d235fdf@quicinc.com>
 <a4f6ojknv3hats4rwmdg5mw2rxhx7kq4u6axybdawak54crn5s@xnjbl7zno42s>
 <bfabfba2-6688-4461-83d6-b6f4c86b08ab@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfabfba2-6688-4461-83d6-b6f4c86b08ab@quicinc.com>

On Mon, Dec 02, 2024 at 01:09:12PM +0530, Taniya Das wrote:
> 
> 
> On 12/2/2024 9:55 AM, Bjorn Andersson wrote:
> > On Fri, Nov 08, 2024 at 09:39:17AM +0530, Taniya Das wrote:
> > > Add support for multimedia clock controllers on Qualcomm QCS615 platform.
> > > Update the defconfig to enable these clock controllers.
> > > 
> > > Global clock controller support
> > > https://lore.kernel.org/all/20241022-qcs615-clock-driver-v4-0-3d716ad0d987@quicinc.com/
> > > 
> > > Signed-off-by: Taniya Das<quic_tdas@quicinc.com>
> > Dropping this series from my queue, due to lack of response from author.
> > 
> > Taniya, please answer questions/feedback from Dmitry, Vladimir and
> > Bryan, and repose as necessary.
> 
> Sure, Bjorn, I had a dependency on the GCC patch.
> 
> https://lore.kernel.org/all/20241022-qcs615-clock-driver-v4-0-3d716ad0d987@quicinc.com/
> 
> I will fix the comments once the Global clock controller patch is picked.

I think this makes a good generic feedback (I observe the antipattern in
other engineer's behaviour too): please try responding to the comment
after receiving it, not just before getting back to the series.

For this particular case: there is no need to wait on GCC. Please stop
using the external dt-bindings header and use <&gcc_foo_clock> instead.
This is just an example, not a c&p from the platform's DT.


-- 
With best wishes
Dmitry

