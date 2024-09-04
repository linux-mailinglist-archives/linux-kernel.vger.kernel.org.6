Return-Path: <linux-kernel+bounces-312768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4404D969AFA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AE3286EB3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18ED1D86F8;
	Tue,  3 Sep 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tuFd4wzv"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A901D86EE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360807; cv=none; b=RisMD47x95FL1PDD/kkgF4kXVfKI5a6EVuzDyaC/kuc0AoXk52YSI9WrHt+9ZND8f6tr27g2KsPzr+SAx3l2RskNDObb+rhHwcLM5QXLzF3X6ylUFcW1EHjHuqxEHatYA0XVOqTvK4YGJe30g7h2A+Zkq6y2dJMfdWdzbhffLY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360807; c=relaxed/simple;
	bh=5kn8MpxGBa4vJQej9zGXkwwLvcJtv98/xUQ8glPnlG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzsSrvHsfZdJm8mMF4nDH06g1eFAxzNN5Aq9hw+43lXru3u7NCrdSS5EOCbQZzNagz/e73QWCg3O4Pv6xUwGuWLwiYETBbj2fjIk5NFHJfMPfeVNCzsZewYykO7f5uCJgD3sj7XZHobzXwAEzqEkLPMdbqmW3oSBpIVN/Txf3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tuFd4wzv; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd830e0711so3163023a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 03:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725360805; x=1725965605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aal6UqOGkqZkqna94iUuUosjVWaQsTHPERAhd37Lruw=;
        b=tuFd4wzvECe8247zHaO7j3Dzyf9D+7bbzS8iRuW6Z5kP7nH5pJvTtNMCikB0HLUIzB
         MzVKoolRyICJGXA8+Kmk1hsWod/z1PjmVHC1Vtq78YOBZms3FTYYpLIiZq1rcvQ3Y6GH
         o1D/bVXSjMtzwzCuQ747gtEM8tH+ByQFDMLnfcc6blwjtbm8simKai3LTFIh2shYs0BF
         5y9Wn51BiWKAIj4Zzwntmt8pq5OrPXXOSsbkd4CJ2zZJj+xQ0dMcqkK0viovOtX6Svci
         Ro5IkHAUfZnuutqCoC69JQ24OxT//zv1oNoSz4EDV2PwLjujC9ompgaRpgP5XZJFx0xI
         Ry9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725360805; x=1725965605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aal6UqOGkqZkqna94iUuUosjVWaQsTHPERAhd37Lruw=;
        b=ENZ5CXShwSKmpYtyXTNxZqBlxwWaaOYBDw3cSp0dFiiTjiX1HNb7/Hk4QSRLvaPAd9
         F1K3MOWaFHSTmUoivpRZZ+xqUX2LNCiiak4f+LSfKkG06TRKdlk4NqbfLYlMWt4ccZ7t
         +EOuxRV38nYrzej7aOSPv4Q7obXcqLIJYVhWGEiS0tbdNTr50VohYsdp+HDanpITybIX
         1IcRrZO9Ou6dZOOl0w8ChL4CItAo+av5EpcV51gRLaoxeT9A6HEJp4HDvLV2TxsDAlhM
         +j9AHgQFeZZa7hGoeEAO4wXLGYEynF/8brfASMiFWGuffhHLZPunaKCgTLHYAjIS80FU
         OZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8NrNXI5tElt0u5jorOAUaqdutNLnBzx/lWYdZQJrzbfFafmhA5LaAq8e+193C5m3xDhy2CWfpL9qmwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIRT6uHduYBcsvRM7IlAmuVXnbw3mNTd8Q3JcWqnL5l+J2GILx
	fZ5xAEYxx6Eq/LqNf9BZMQRC3JR9Wqs2V62fkKv/MfSp+reHny/Uojo77ReO2Jk=
X-Google-Smtp-Source: AGHT+IEO949mx2BbO/B5MkzoysN8aCenWGXxXwYLPohVGFSukAW3tdUV7R828HwAqgN08bopLVe5pg==
X-Received: by 2002:a17:902:c948:b0:205:8a8b:bd2a with SMTP id d9443c01a7336-2058a8bbdd9mr58434765ad.22.1725360804781;
        Tue, 03 Sep 2024 03:53:24 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515545264sm78738975ad.225.2024.09.03.03.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 03:53:24 -0700 (PDT)
Date: Tue, 3 Sep 2024 16:23:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] OPP/pmdomain: Fix the assignment of the required-devs
Message-ID: <20240903105321.suosbhkkkylfw4bv@vireshk-i7>
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
 <20240902224815.78220-3-ulf.hansson@linaro.org>
 <20240903071638.bedt3gllqdacf43a@vireshk-i7>
 <CAPDyKFoqEAHns0nrXT6dJR3sRd5VWidK_rzXGHzJiZtk_p0cKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoqEAHns0nrXT6dJR3sRd5VWidK_rzXGHzJiZtk_p0cKw@mail.gmail.com>

On 03-09-24, 11:54, Ulf Hansson wrote:
> Let me try to elaborate a bit more.
> 
> In the current code, genpd_find_opp_table() tries to find an OPP table
> for the genpd that the device is getting attached to. Then genpd
> passes that OPP table via devm_pm_opp_set_config(), to let the OPP
> core to hook up a required-dev for it. This was a naive approach, as
> that OPP table may not be the one that actually corresponds to a
> required-opps for the required-dev. Consider the below in DT.
> 
>         opp_table_devA: opp-table-devA {
>                 compatible = "operating-points-v2";
> 
>                 opp-devA-50 {
>                         opp-hz = /bits/ 64 <2500>;
>                         required-opps = <&opp_pd_50>; //corresponds to
> pd_perf1's OPP table
>                 };
>                ....
> 
>         devA {
>                 compatible = "foo,bar";
>                 power-domains = <&pd_perf0>, <&pd_perf1>; //both
> pd_perf0 and pd_perf1 has OPP tables.
>                 power-domain-names = "perf0", "perf1";
>                 operating-points-v2 = <&opp_table_devA>;
>         };

I think another way forward would be to send an index along with
required-dev information (now that you do it one by one). That index
would be the index of the genpd in the genpd-list for the device. That
would make it work, isn't it ?

I would like to avoid (another) callback from the OPP core, we already
have few of them and I don't like them a lot. Moreover, genpd should
be able to get the right required opp, with an index. Unless I am
mistaken and this still doesn't solve it :)

> To make sure we assign the correct required-dev for cases like the
> above, we need to let the OPP core to iterate through the available
> required-opps and see if some of them are corresponding to the OPP
> table for the genpd the required-dev belongs too.
> 
> To manage this in a non-genpd specific way, I added another callback
> in struct dev_pm_opp_config. In this way, it should work for any
> future possible required-devs types too, I think.

-- 
viresh

