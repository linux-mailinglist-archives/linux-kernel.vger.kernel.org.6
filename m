Return-Path: <linux-kernel+bounces-231334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668A6918E49
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EFF28CB29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971419048B;
	Wed, 26 Jun 2024 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFnHDyoW"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26ED19048F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426203; cv=none; b=APTP6kvJYO5fnjsMGdbsSnGUs7sm2uHbyp489AxSv7xZ6OOEt7AGJ8o40+FCEFJg9yGLOJave33L+AsuML9V3SS1rfgy857twbSbpZVUwimX5VCU+e/yFVX603KeU0r8GDkHJuRKfFQ95xtMDHDDF84W55HSXUcO91DMSYPzhic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426203; c=relaxed/simple;
	bh=+O9+3Tj5o1+8awe97/tVFlTIjZPsuMt7DNFJlAt9VHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPv6IkTOpQFM9+HInKxjjC69QGQi2A4on2K38nLrAeJusVRZw0xp60DwQDnk+zpRjCB613ZxNtdFh9+wBsjVNwNBbb1Y7v4SS3NF0UolEgUdin3zeYfKkCrBOdOzqH9XRNvS0DjSHli09BL4GDtNT8KivK7f4vuQxDlY7TwyvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFnHDyoW; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe3fb5d4dso9453311fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719426200; x=1720031000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9eJH6Q1RShlmHM1ZlQieGvydRc7/ZyO2tJLDZW0TZMA=;
        b=RFnHDyoWmTepmXhf3PPRlED/xXnC+Ib8BINctnr5fYZs7f2oSb/w3XZTQlItq39bd1
         KZUO3WQoaFuLAGcqUhfhd4Sv2uTMW0fLZ5wC0Tq0NYV6p3RYb49t6l0bY/3crm4jwnrB
         md6RyJWEzoNvrQu7g89N9aWEfF7/eZa5o8kNo9gMkB5wlXxc1KILKG/IoROlA4xgUwdr
         4PFtDybxIPgeClAsJXxqiIlU0aALX3QDoecshAYbP4TyXNZJsVsgzrq3/lryI1IPsECU
         AfCiTG1auF3id9a1gByU7b+Db9ntdlozD0jcr4ucMCecvM0+bb3Enu9tppzopBnrBhIe
         bsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719426200; x=1720031000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eJH6Q1RShlmHM1ZlQieGvydRc7/ZyO2tJLDZW0TZMA=;
        b=kXHA/Tv8mPWUP2+75Wab6MyHy8RCCqDA/mHGovl7eNW98zD0SVR+XAHpAqQH/o+bOQ
         pyUXEY9XiNaVGk8TiZJx/SSCPGQuBrbbUWcd5UISKnZZ2FQdA2s47j20jCKVx6n68uIz
         FU2DsF9K9h8i0G9OkRLgzYuqCu//Cb9Ad6iJQLjULaaE5QvbCysZ/bHrswuEMFXB/8I6
         CaO6mGCaSpfhbePvqUldeSFGEW+yA+waOgjCwZQRUI6Tc+4cHn0nwwa8ikdX8cj6pHmi
         6tRO3ae1l5FTH2HIf/v6Qgr7uND1yCkQiS0lMg7/CrWzIMS1X7nF4yXaJ1OBgdrYf2EN
         cljQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4JW/7WtxO5n0BIdBmvXqfY1AVNvY1PhuQBrqmoUyNlagfAS+lw0yOl6+szZg5gI7e2wwEl99XKYka+UDqrlJrA1jUBvDhS/rThqC2
X-Gm-Message-State: AOJu0YxN1hF1B+WduFJUtPm0c32fYJzqcrKy7WDexZttJF2EsGRbz4ia
	2ld/X1VfA5TpeB+wvynsrrTqEiTN42sI0aLjYM73iiiYPHX0uozWxUbSOOBJjoA=
X-Google-Smtp-Source: AGHT+IFXCqFuajLOraGQqNzbZlp4TTxQraecaBDsIDB6TAAsyKR8HxVaBp9DwXY5qUzkh+wVwAAMMQ==
X-Received: by 2002:a2e:81cc:0:b0:2ec:4deb:482f with SMTP id 38308e7fff4ca-2ee48040234mr1088621fa.8.1719426199846;
        Wed, 26 Jun 2024 11:23:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec53b7c876sm12791181fa.62.2024.06.26.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 11:23:19 -0700 (PDT)
Date: Wed, 26 Jun 2024 21:23:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ilia.lin@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	otto.pflueger@abscue.de, neil.armstrong@linaro.org, luca@z3ntu.xyz, abel.vesa@linaro.org, 
	danila@jiaxyga.com, quic_ipkumar@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/9] cpufreq: qcom-nvmem: Add genpd names to
 match_data_kryo
Message-ID: <za7t6ltttq2o5qwahfrzftsb7xfzbzdtg4zx3bvnf3fewhfeqf@vjrq7na5ioqm>
References: <20240626104002.420535-1-quic_varada@quicinc.com>
 <20240626104002.420535-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626104002.420535-3-quic_varada@quicinc.com>

On Wed, Jun 26, 2024 at 04:09:55PM GMT, Varadarajan Narayanan wrote:
> This is used for tying up the cpu@N nodes with the power domains.
> Without this, 'cat /sys/kernel/debug/qcom_cpr3/thread0'
> crashes with NULL pointer access.

Add the interesting part of the backtrace, please.

> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 939702dfa73f..5e6525c7788c 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -399,6 +399,7 @@ static const char *generic_genpd_names[] = { "perf", NULL };
>  
>  static const struct qcom_cpufreq_match_data match_data_kryo = {
>  	.get_version = qcom_cpufreq_kryo_name_version,
> +	.genpd_names = generic_genpd_names,

This forces that every Kryo SoC has "perf" genpd, which obviously isn't
corret (at least from the upstream support point of view).

>  };
>  
>  static const struct qcom_cpufreq_match_data match_data_krait = {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

