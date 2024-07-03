Return-Path: <linux-kernel+bounces-239235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11667925838
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AD51C2128A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8F9143744;
	Wed,  3 Jul 2024 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c+wlb7UM"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66DD139590
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001989; cv=none; b=I74tCEC10yrLNaPHOet9og1YpYfP/n4oa1jJd6DfvAJkHwABQavNp3AGH39k4d8D+pvD1iX8Bme15OzVAVsDScta4Rqi7StkeRDX4SHp+1GBN7rp/cIcEzZwwa7CPtvkNbjlrz8YbPTQ0I02fgwgxFQH1DElyk8ENL1KCjAICVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001989; c=relaxed/simple;
	bh=Dr1Yt/KrYHkti6C1KYzV+Dlm4Qfz5vwM66rts5wWsJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzVlg0KTVg8/XBZeZt6hqZ7RlLeCNK2W3slvLzhA174lWoWnrscwmfCMpQ4KWZuCYDyfqqBmnyX6+1KoAwWhtV/K66lORe8Occosg2HPD+HWJ29RxBB9zTfB7RoOi8Stldi6NT80AWjHi37bxGnwDuiTojAUTrXV2oNh0n4w2jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c+wlb7UM; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-71871d5e087so3351372a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001987; x=1720606787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WX20iHFYDh67zOaOY8ZhhJ6ZKT9LK6c3VfSACtwvVgg=;
        b=c+wlb7UMm1Td3HJlT0HfFIEvjcKjt+pp/vk6JHKzeSyWmDMPGBwiTaZ90w+zq+2WaP
         CxlTU5dRUOyzLZ8Dqn7fVo2bWxUW2CX29GIZlXfuNxwVhrKCvzK/2syhj6jGYMLPcLdQ
         hngqveN+P6b0g0747lmOMaQl5ziRFl/OiiHVRxipXISY3EpIJL64TAsgeY2LCnap8drI
         gERcOUQJI1sM61Am50zTH8MWtg8jY4eu7rjegytAj8Z8xaKm/O9y9UxzwEdhCWmoT17z
         oYJ/mZQl6UPXzZ1rAAz3rhIPJPCxF7qlQ9Zj4IuMGupjeoUwLNd9U8vUWzV7OFp9a8qT
         X9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001987; x=1720606787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX20iHFYDh67zOaOY8ZhhJ6ZKT9LK6c3VfSACtwvVgg=;
        b=RkGLC9K7w5kUxARvd3XLgYBE47c111+Z2sr2PZ7VB3qtsEOeO0EsXDxS/GSEQKGGzy
         rXG3ikReDlcKd0xNZTNQJqO7cWY/kCtBjtDdhoec7C2I02+O3FHrNdQ/647e3O9i5wut
         AX73kgmqSAeaWoMY17HyMqklJ58QMnkmXrfRFR+BFGc3RUzqRYnO6eSxxPh49J+EoXtE
         MjJLot+kJZTuT2sfDHtdTJhGxBpvX3kKm+B0mgPhzqDQDNL4eFtyvpoBGRnANwGMGgTF
         3TykJewCSBZ6NfqTsWAiAuZ8B5sgfhxDXYGce/1vJdU8O+gDC4TPSpSs6A1+XAZUrOlC
         JVaA==
X-Forwarded-Encrypted: i=1; AJvYcCUVF+bVQLLv+J79Sy9MqrHNBHCc8UzYcnCW0cPpK4JNZL3nk2s9vVM1yo87mUpNJw3Iq+InlfRthJbofHDrhZTMiDUyWn4tLj9z4lX2
X-Gm-Message-State: AOJu0YzI9FueZ4+Bzj5HaStEfc1wGjkX+YUNHPylTGAKITHkacUfbl8w
	0W5g4fDsp+fdxlzf0o9LvoKQPx1hy+8MOux1x1dz8xDL3nRR6rhNJE9GU0SEsq4=
X-Google-Smtp-Source: AGHT+IEvSWK3AHjhs//D5/KK7bYouCT5r+gWqcmSkgVEyw8WawTRpeA5e5mSwaWYHuM+L0bWLij7Yw==
X-Received: by 2002:a05:6a20:7f89:b0:1be:c81d:7314 with SMTP id adf61e73a8af0-1bef60ee48bmr16636953637.8.1720001987024;
        Wed, 03 Jul 2024 03:19:47 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d96cbsm99891255ad.119.2024.07.03.03.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:19:46 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:49:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	angelogioacchino.delregno@collabora.com, andersson@kernel.org,
	konrad.dybcio@linaro.org, mturquette@baylibre.com,
	ilia.lin@kernel.org, rafael@kernel.org, ulf.hansson@linaro.org,
	quic_sibis@quicinc.com, quic_rjendra@quicinc.com,
	quic_rohiagar@quicinc.com, abel.vesa@linaro.org,
	otto.pflueger@abscue.de, danila@jiaxyga.com,
	quic_ipkumar@quicinc.com, luca@z3ntu.xyz,
	stephan.gerhold@kernkonzept.com, nks@flawful.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 02/10] cpufreq: qcom-nvmem: Add support for IPQ9574
Message-ID: <20240703101944.tiyaweflcs6nkx4p@vireshk-i7>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
 <20240703091651.2820236-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703091651.2820236-3-quic_varada@quicinc.com>

On 03-07-24, 14:46, Varadarajan Narayanan wrote:
> Add qcom_cpufreq_match_data for IPQ9574. This is used for tying
> up the cpu@N nodes with the power domains. match_data_kryo is not
> used since it doesn't set genpd_names. If genpd_names is not set,
> 'cat /sys/kernel/debug/qcom_cpr3/thread0' causes cpr3_debug_info_show()
> to crash while trying to read thread->corner->last_uV as
> thread->corner is NULL.
> 
> 	Call trace:
> 		cpr3_debug_info_show
> 		seq_read_iter
> 		seq_read
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: Update commit log to include stack trace
>     Introduce qcom_cpufreq_match_data for IPQ9574

Can I apply this without other changes ?

-- 
viresh

