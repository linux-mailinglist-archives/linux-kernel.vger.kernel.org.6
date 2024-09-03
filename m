Return-Path: <linux-kernel+bounces-312834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA89969C38
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DEEEB23C94
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD231A42DB;
	Tue,  3 Sep 2024 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/cqvHR4"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C74195
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363823; cv=none; b=a3hGHL7SYJ4xUol8gPGy8I0nJTKsiKq/peg4LKRdatKBoeScpde8hIFCP2MsSxInO4BUB+WGqRu1YHPUffLkXSbGUkxtctuf8a8OtvTn50r64YKv2SzHTbMHZ0jJhmhtO17tUBwWAAYiggbdg/ysIa0lKyHv2hx3D1ZMAu1EJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363823; c=relaxed/simple;
	bh=TxBUswhpUFjD2PIh0U8XQayS/jnbn9rUdr1/vY8JI/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKDZ4kiaFOD8R2B635T2zj0B4erps4Gly/EOKJ8B2HoByR40j9VoFBQy8pdDoDIPlaaxVJVS08gU4nxAucdZjFf3DfBjFftzvYhA//8hnpIXkWZmyYGjXG39v8PoV1raTaPN/0m3U/R7f+d/HHh7jFr6BP0fIjKJYH0kO52fMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y/cqvHR4; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e1654a42cb8so5005518276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725363820; x=1725968620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HdF9MVtCXj0ldBEZbIYs+MFigsWqijFAoDRsuv3Mur4=;
        b=Y/cqvHR4veWm2roLuwqWuhxKJcw9fbUsm7UK57BkRtyOeOV7KPTOCU//YQsmtac2dB
         +y2mtzXap2baMVmyy7VZGH3lRzdFi0tH+0Dl9+a0w9qsR1+FBPY4S1fg3//WtYcYG+Vc
         1FPvgSWe8rrsVuPtITJv1JR5JOTlnWhnKqjntLPWHM5lXMPlL6Xg80mJtyslOD45qgI9
         ppMZIxNgIVy+sAHqxqWP1hL9m6WhUwZeX8qFyRufiAIVWJfpyc4JB1JSihJdsR7I7Yw9
         Dm4f2EAfL50kK7p3atxJbpM24glloIZPUaJyopI5TDBIyv4/qdgAg5njDpdbBHABG5gV
         9cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725363820; x=1725968620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdF9MVtCXj0ldBEZbIYs+MFigsWqijFAoDRsuv3Mur4=;
        b=mi1e9yJO/j2VqL3mfl8sYx8oa2UNC3W8h4J1iE/OwkSYMXF3tWEiIlxu9DnJXPKSE7
         oW+u7tPqI1lq/S0pvuJd4vl8EOemF8Xr6oVIsEWu81VYaSHUCkzylWtPmxVm/DVixtxS
         TwkSUimWI7r7MlsrNtHjbc4Hss6t/6MgjOGFNOX+1zOR+Y9/Wv6947v8KJr6J57+rapX
         GEsvS2uvcloG0+xq0DUTotLXGtzPMsq6HQJNPqiTjDy8VS00BsRI+BR+Owbl0QY3Wu1R
         rSIkiI1v39t8TzQOHIR+QYG9tAp8VcVJORwP4WG/bIsqrRRZn5WgNtWJUXHaxoshHcsm
         GzTA==
X-Forwarded-Encrypted: i=1; AJvYcCWlJ8YJZXcrQXeAJRuCHSXip/yljLkdopjuMbT1MxlB4GzUiZD/edLodXH45AZY9K8IlvNOzx7BwxYrcsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DSOKa5hbnM5v3R9z7cMq8iSBGIbyPo5CErbRWWwik3v1toRK
	Af+/beAO1slVK6T6IgE+cux/lI5Y3qMyMNhoFx04RfuIFOZdbe9N5WkrkHRXwcU8p+DmZTM+1xn
	HTVTH3EB19g3bf+Gl6GzrKlGJDua8jx0/GuvoRg==
X-Google-Smtp-Source: AGHT+IHsDuH/TAqeHRCZZGOx6eleOYg0y+sTS5+zHNDOJ0N1S7gTa6ofslpNrt9a/ru5VN98gCbAFZhY32ZtaiDskgE=
X-Received: by 2002:a05:6902:2493:b0:e11:8088:3a5f with SMTP id
 3f1490d57ef6-e1a7a19de6emr15605038276.48.1725363820330; Tue, 03 Sep 2024
 04:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
 <20240902224815.78220-3-ulf.hansson@linaro.org> <20240903071638.bedt3gllqdacf43a@vireshk-i7>
 <CAPDyKFoqEAHns0nrXT6dJR3sRd5VWidK_rzXGHzJiZtk_p0cKw@mail.gmail.com> <20240903105321.suosbhkkkylfw4bv@vireshk-i7>
In-Reply-To: <20240903105321.suosbhkkkylfw4bv@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 13:43:04 +0200
Message-ID: <CAPDyKFrh4VASFzMxEg3Q8SrhVbt1vH8QJM0rCdfxo+-L1+CN_g@mail.gmail.com>
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

On Tue, 3 Sept 2024 at 12:53, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-09-24, 11:54, Ulf Hansson wrote:
> > Let me try to elaborate a bit more.
> >
> > In the current code, genpd_find_opp_table() tries to find an OPP table
> > for the genpd that the device is getting attached to. Then genpd
> > passes that OPP table via devm_pm_opp_set_config(), to let the OPP
> > core to hook up a required-dev for it. This was a naive approach, as
> > that OPP table may not be the one that actually corresponds to a
> > required-opps for the required-dev. Consider the below in DT.
> >
> >         opp_table_devA: opp-table-devA {
> >                 compatible = "operating-points-v2";
> >
> >                 opp-devA-50 {
> >                         opp-hz = /bits/ 64 <2500>;
> >                         required-opps = <&opp_pd_50>; //corresponds to
> > pd_perf1's OPP table
> >                 };
> >                ....
> >
> >         devA {
> >                 compatible = "foo,bar";
> >                 power-domains = <&pd_perf0>, <&pd_perf1>; //both
> > pd_perf0 and pd_perf1 has OPP tables.
> >                 power-domain-names = "perf0", "perf1";
> >                 operating-points-v2 = <&opp_table_devA>;
> >         };
>
> I think another way forward would be to send an index along with
> required-dev information (now that you do it one by one). That index
> would be the index of the genpd in the genpd-list for the device. That
> would make it work, isn't it ?

I am not sure how that index will be much helpful, but maybe I am not
fully understanding what you propose.

Please note that the index of the power-domain doesn't need to match
the index of the required-opps.

It's only the phandle of the required-opps, at some index, that can
point out to which power-domain (and thus what required-dev) it
belongs to.

>
> I would like to avoid (another) callback from the OPP core, we already
> have few of them and I don't like them a lot. Moreover, genpd should
> be able to get the right required opp, with an index. Unless I am
> mistaken and this still doesn't solve it :)

Sorry, but I couldn't figure out a better option.

>
> > To make sure we assign the correct required-dev for cases like the
> > above, we need to let the OPP core to iterate through the available
> > required-opps and see if some of them are corresponding to the OPP
> > table for the genpd the required-dev belongs too.
> >
> > To manage this in a non-genpd specific way, I added another callback
> > in struct dev_pm_opp_config. In this way, it should work for any
> > future possible required-devs types too, I think.
>
> --
> viresh

Kind regards
Uffe

