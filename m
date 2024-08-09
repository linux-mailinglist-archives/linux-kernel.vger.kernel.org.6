Return-Path: <linux-kernel+bounces-280360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A84494C984
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA8A286781
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5FC16C69C;
	Fri,  9 Aug 2024 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXEypYFx"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2718016B75C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723180502; cv=none; b=ebSp0+DNIa/df7JZfW0X0P220LqF40lGaZ6DUzZldp+rRGYeNcwxMNcAD79HwRbbm6yBsO1twFuIUcqfOD6wyta5+92FVVVf35opJ243nPkkecGtKlrIenw2XDAqt91E+mKtbfi8fhS5O92PdKm73cDdahQtDiPnSF8n1moB2fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723180502; c=relaxed/simple;
	bh=TDCPxuODPaukuKZsL8kyvuCYXndR12/ClqxBAqUEu/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxHA6oMeLjUxq4DqTcQzXL4dfIY+Okeg0TPbD3L8cx2YB7zOI0ROeE+PKktzX25Yy1sxPWpoMyo6BQbWyrsktFrYugyaU8pNh2AaeEjK097QTlU8Q8XtqC1REt+tLQWfz1ejQNvvjRPmFqawbDHtesPd9mMq8y/zATre/2eTX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NXEypYFx; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7aa7703cf08so1277670a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 22:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723180499; x=1723785299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ai4n1ojH4BrMxHYhxOPvkGHen4LMeRJtChl2a3se8Cs=;
        b=NXEypYFx/362L5oG2CgLh6t1L98NQ1EEU8m9GKaVDqfxWQ1lN0M7u5UQBBdXdrtcBw
         ys2i1NEDi5kKlpNNga2a17t/ikSDt+hfg9kOZi6YeZNHLvs9cwu/ckn4mCuT120b8A+M
         u2LA/DjJlA2O2UmrGlO9vNs2O7RI0SFrW/ybzPlndq3OgKbxqcS3hgwiQzj6gG1IWixj
         m/cFTtwD5iQQBrMviP4z/IuGThvyATrJ89GYvc2/86WVbnblS8Yy09Djdw3CypTRBvV2
         +4v/ZaHTfmYkmO/AoYsOUdhO7o+heUi2yWVAdlGS1RrSpVeu9IZOcpfO6Nq00g372eaw
         Dnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723180499; x=1723785299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai4n1ojH4BrMxHYhxOPvkGHen4LMeRJtChl2a3se8Cs=;
        b=VOxTqmMGtQ3IvokFq3UHoNz/5HO2VcCDlG4LDuRXL/foPfOfMHGq/3Ae3EHUlgUgrL
         x34jTknFmdv0VVZr3BV9phx7A82K1ObsJDq0J+5QOy4VniKxzEDXaG72aIoBqoODdWDG
         WZ8lx9em6v0Zyd8yJh8XzA5L0Sna/w21t/sUh9wYZxJBby77iHXzG/Bytq1CAsewnQzJ
         V6m4SP9sH1ogqZYbKvgdnGaST4uKXYq9jykRZU/lAx+jdSkSe8y0OCh/iMLjqelfHhj4
         Ooqo9ZekWn7wdQ5XuPjElazmU6xmRZobx766tL9kDdGA3XbCbnAnZo93dd2OaQ7ao9tZ
         mfZw==
X-Forwarded-Encrypted: i=1; AJvYcCXD8DXmX1zQ7uY9iD1a+AxtQy4FAloGsc9YC/jGRq1H7+N3rv3zAVo5u8zT4b8/qc5sOrkRTuIlkCp9d0sG3jkUCGnsb1wjeDPmCEuu
X-Gm-Message-State: AOJu0YzsQ8F24Vk82YNIt4cnmEC+asG2bm94DIfnn6sO+ObqBryA3cc4
	wFHSM5ta7ah9xujs+zcrVBw8n81cjr6WAF4VEXKY9rpxsPJg7auwsiQxlLpchHk=
X-Google-Smtp-Source: AGHT+IE/QAvLW2koC535BQ4c0HdzUo6YI0VqTDy0Vl7iBvIPYYqVQatuesL1BwYWFpNjl9gKrC8TPg==
X-Received: by 2002:a05:6a21:3a4b:b0:1c1:89f8:8609 with SMTP id adf61e73a8af0-1c89f9c0f53mr723935637.0.1723180499370;
        Thu, 08 Aug 2024 22:14:59 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c9d745sm2050554a91.28.2024.08.08.22.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 22:14:58 -0700 (PDT)
Date: Fri, 9 Aug 2024 10:44:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
	perry.yuan@amd.com, rafael@kernel.org, li.meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
Message-ID: <20240809051455.eswe346caiee6gpp@vireshk-i7>
References: <20240808123651.3741-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808123651.3741-1-Dhananjay.Ugwekar@amd.com>

On 08-08-24, 12:36, Dhananjay Ugwekar wrote:
> Fix the reference counting of cpufreq_policy object in amd_pstate_update()
> function by adding the missing cpufreq_cpu_put().
> 
> Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 804fab4ebb26..36edae40db1a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -560,6 +560,8 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  
>  	amd_pstate_update_perf(cpudata, min_perf, des_perf,
>  			       max_perf, fast_switch);
> +
> +	cpufreq_cpu_put(policy);

There is an early return path in this routine, which still doesn't
perform this action.

-- 
viresh

