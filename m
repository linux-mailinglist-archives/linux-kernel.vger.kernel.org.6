Return-Path: <linux-kernel+bounces-312667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CAD96998F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6988E1F23A97
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068E51A4E73;
	Tue,  3 Sep 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWQLHUpO"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3985419F42D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357310; cv=none; b=S+5aEzKs8NyJ2+YHfntarvSGtd9gt1vkwQ8f+9rpvGX78VXW2f9ZsqT6RHJm2cuBC68k0KDpDjJUARJBrg7a7gUaoRnsmgFZeOKGFln5B9ayz/wJ9OJcko38JOmxdI/UALibeUnguXTfEaluEEFhc1HTNb6II+ECE1As9E7gvo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357310; c=relaxed/simple;
	bh=r/D2XT9csu2hRnKwa7lr4pddgJFqYkNRTZD+HvrK5yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhtJxHTsREa1fS+x9wde46V4/g9oW27YRFWNm68+FifWuiGJKVxIfU9GvBHFAXuHgNwdKrEkzFWkYx5dFhXsQdEKfzrbR7a+9gm48EKsiiMoMVxjIOzRoPH6d4CsGhNIoTk+b8lUTuJXJNmCndrVETDcnPCpMITFD2l1Ooi/8VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FWQLHUpO; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso5164716276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725357307; x=1725962107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cFqqyo1243gLC8lCdcnS069gRZejGhzhqXUGlqO3d/I=;
        b=FWQLHUpO39uToecSQdsk7vlCb0xkyRpSb0COBxCyy3BGLftVXO3K9624zyCqWHgWlM
         6myKdEgRNH2O0OynsP+4dulNFeMGe9eHK+hxY6tbFIL82/xglOq0kSR8LOI4kqpxjCpP
         meB11FoRFTIoVOYaud/TCllqed/bsC6yCt7oXc0i3fQQes2mHR1B0k//3Ootyowo0bSx
         l8Fcgf00K6dxfHj2N5LrqhnSTYRXKkmbyTvjjeyzo76RUfrxHYfzvi7t+kQUwJIqRYOj
         GY21wwWqNn4x3fSTvxDUXT1ZIigZulPolYVT47equ7HCQiJpA0WqhESQAHDHMAVy1ZbY
         u+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725357307; x=1725962107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFqqyo1243gLC8lCdcnS069gRZejGhzhqXUGlqO3d/I=;
        b=R+1o1peH4TJncEh+qDuqZo6dD88X8cUbl6XfFso8ybsEy0N/mDQlrLAOleW6YvA18q
         wbPKshqEZvg5sc9H/stI/xS/MqV7VPafXfdrNGjqIjz0z+dAN7El6YSF5Q8ESGtYm1h4
         mm5EaEKS75zpUCS5F+vpXi+B3oiDwtQO5Y9T6g9vDR/JJYeEfNAk6Jd0OVEjsWkiVlWn
         PdXApf1id6S9/prv29+Oh2LYjWQg/ro3EicVNxxPQxBJPBvrvTRksiZhBBQi3bmQIU3u
         I9FKnzW3iiWad1G5ORec7uBEkOJ7ZcV/QLTdqv4FC5stViCIpxd04RUsFvF3u/F32+Za
         JGKA==
X-Forwarded-Encrypted: i=1; AJvYcCV2lMSOQ78gpjLJ6qS4AXeIkz4Mi6KYnwcO11GAxKG9Qm6IBGTjYsNdYsWZI1MeyKizUQYL5jVX7D1OV/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlMoXZDzMA0YqXDWB+pLvf+yHe1NHmHWzlFidwq5O53DL9eBq1
	aoCqiH8vhiBriHcRU/wBw4WW5VzKiu16iikbRgl8GeIf8KLwI3F1Y4BgFRNlDWPpXPc8TnKaWYX
	yTtfUZ8qpMgWMBwP6iDZuPZdhmvCUKxnBpjitAQ==
X-Google-Smtp-Source: AGHT+IH+1PDql0ueQ/ES8PwB2F7M/INUIUGvNZZEUFj51QsjECCxPIJAbbiizLcpEvWmhRUegd7BueLrC0lx7UTd+48=
X-Received: by 2002:a05:6902:723:b0:e13:cb77:5fda with SMTP id
 3f1490d57ef6-e1a79ff67d7mr15832832276.12.1725357307286; Tue, 03 Sep 2024
 02:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
 <20240902224815.78220-3-ulf.hansson@linaro.org> <20240903071638.bedt3gllqdacf43a@vireshk-i7>
In-Reply-To: <20240903071638.bedt3gllqdacf43a@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 11:54:30 +0200
Message-ID: <CAPDyKFoqEAHns0nrXT6dJR3sRd5VWidK_rzXGHzJiZtk_p0cKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] OPP/pmdomain: Fix the assignment of the required-devs
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Dikshita Agarwal <quic_dikshita@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <quic_kdybcio@quicinc.com>, Nikunj Kela <nkela@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ilia Lin <ilia.lin@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 09:16, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-09-24, 00:48, Ulf Hansson wrote:
> > To fix this problem, let's instead start by letting the OPP core find the
> > device node for the required OPP table and then let genpd search for a
> > corresponding OPP table, allowing us the find the correct required-dev to
> > assign for it.
>
> Why was doing this necessary ?

Let me try to elaborate a bit more.

In the current code, genpd_find_opp_table() tries to find an OPP table
for the genpd that the device is getting attached to. Then genpd
passes that OPP table via devm_pm_opp_set_config(), to let the OPP
core to hook up a required-dev for it. This was a naive approach, as
that OPP table may not be the one that actually corresponds to a
required-opps for the required-dev. Consider the below in DT.

        opp_table_devA: opp-table-devA {
                compatible = "operating-points-v2";

                opp-devA-50 {
                        opp-hz = /bits/ 64 <2500>;
                        required-opps = <&opp_pd_50>; //corresponds to
pd_perf1's OPP table
                };
               ....

        devA {
                compatible = "foo,bar";
                power-domains = <&pd_perf0>, <&pd_perf1>; //both
pd_perf0 and pd_perf1 has OPP tables.
                power-domain-names = "perf0", "perf1";
                operating-points-v2 = <&opp_table_devA>;
        };

To make sure we assign the correct required-dev for cases like the
above, we need to let the OPP core to iterate through the available
required-opps and see if some of them are corresponding to the OPP
table for the genpd the required-dev belongs too.

To manage this in a non-genpd specific way, I added another callback
in struct dev_pm_opp_config. In this way, it should work for any
future possible required-devs types too, I think.

Kind regards
Uffe

