Return-Path: <linux-kernel+bounces-383265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DA89B1931
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDDA282583
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE8F7EEFD;
	Sat, 26 Oct 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKms4BM/"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF427E0E8
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956931; cv=none; b=helMjRNJJhggBJQWws0xeOxkSxSFL8DJXYr51Ms5Kjkx2AMW1wIgnllI0h7Yp2xpJfxxmNhVJmQeCUQD6VYo1TiQwieoeWFM3yxZ8SUhGX6vZ6IPLsyoy5NtwAp1t4FumiHjwNoUWI4SWNXscQ+FKKUXBZQTI7Ierth0aIrAKF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956931; c=relaxed/simple;
	bh=mdQYiaomvhdpmHyQG52noyvqtrBn2stZ76chv5EcHrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1MeTk7Mg3n4rd5X85itGfgTZfC4I2t1ePTf/COzhDviO82f7/0j5lVJ/loOrZRqvdFg31pvn0gHqvxnbnFv/2nDdmsZ+45QhheHHT/JgiHqDIjJcGy9GMMYu7TwmdHbfj/+wRkC2ug05KN3CprkdD8HdadczkYq9fzG0LRMKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NKms4BM/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53b34ed38easo535225e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729956927; x=1730561727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AlN9+w2bjw2QXGPj8VrPbZ1ah949/Sf5tMB1FO8k3zA=;
        b=NKms4BM/pJICbyp9gW+6u6azWUVp46b+cUrf4zGflR4ZEWTBidQg2c2xEf02mKrmnr
         TPbD8uF48JVUP7CG76VcUaWYV78Gh5gN8prnieo6myFXKHrrE+wf/6y5aeWbaomo5Dvn
         fFVE9kZ138yTlsYjQuZ0oyNIuumH8HvAosm80p5WbnJtCPmD45thb4/4QWdDZeM0Yunm
         k6TKKGHUdG9ngqqaunm6dXQSnYjIGEO2aHwyrjZQMhk9GqcEMaV3wrr3NtD3t9Rr/+qk
         ZruTwNXw/TZ8hq3/HlRIAsYYIPcg0W3WhjLgVqcDQ1v2ZlE4BeXAEzByUsosJ64TQkYs
         dhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729956927; x=1730561727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlN9+w2bjw2QXGPj8VrPbZ1ah949/Sf5tMB1FO8k3zA=;
        b=VFyxZIf+M/su04c3ssx3YwrI+fDNPi7gqZ53I8OmB0+tpgKHW/BRIeN8zuag06c3lx
         ZmrT4kfeN7Vb7sEfR9F0XSSMueC0m8hK7O8Jr4YagLyanvkI121OQPsqQ8Qv56pLEI//
         16T4YvlUzSO4H64sLmPzlM8TR0eSYdRleAbnZL4F7hJ+TcOLi6ouw4FNqWdlLKcf93EN
         keRfT+XhoxBHV6mnDbPXNitSHlHnmwctyMICyev3ayUtVlHMJ7JFimYazAuktlFcaa5S
         mZdfjNCfuL0mUe7webFcpz7jGyJFY3ngex1k0q9TfdKDVQx3Xmw88MdI0VSE5q2Z00eU
         onvg==
X-Forwarded-Encrypted: i=1; AJvYcCWB2NH0b1vS57b/63PxukbIQfd2Fnk1mciyBXSQJC1f9wDIjhOeUqffmSetBdtGxcA450vLZa2FcsGdhdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEWdTImBQsNkqbGZDczYgv/RSW0N9tJL1EimbVPXNODozGi6am
	87W26wze0yttLDoaccLm83qF7M9BBuDJEEqtsrIuaBY32cQ/0+wybQrqRssdAE0=
X-Google-Smtp-Source: AGHT+IHFYEWMXgj6VaB1nU6COZmgKL9YfaX8XVC/6HlIR/MdBPbuOqcUJzshyzPvpMz35vDw3HHtHw==
X-Received: by 2002:a05:6512:1082:b0:539:fcf9:6332 with SMTP id 2adb3069b0e04-53b348e554bmr1270786e87.33.1729956927414;
        Sat, 26 Oct 2024 08:35:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c98b9sm542555e87.224.2024.10.26.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 08:35:26 -0700 (PDT)
Date: Sat, 26 Oct 2024 18:35:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: [PATCH] clk: qcom: Make GCC_8150 depend on QCOM_GDSC
Message-ID: <zi2wikjtiniqjukq4bgfdpnq5qdh5h2ogkp5vtc6mre4pwmoho@uy25ljyh726k>
References: <20241026-topic-8150gcc_kconfig-v1-1-3772013d8804@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026-topic-8150gcc_kconfig-v1-1-3772013d8804@oss.qualcomm.com>

On Sat, Oct 26, 2024 at 12:58:13PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Like all other non-ancient Qualcomm clock drivers, QCOM_GDSC is
> required, as the GCC driver defines and instantiates a bunch of GDSCs.
> 
> Add the missing dependency.
> 
> Reported-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ab85f2ae-6c97-4fbb-a15b-31cc9e1f77fc@linaro.org/
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

