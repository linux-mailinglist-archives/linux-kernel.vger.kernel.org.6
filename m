Return-Path: <linux-kernel+bounces-326325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C5B976690
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EAB1F22763
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3976019F404;
	Thu, 12 Sep 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqiFBwbt"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE619F113
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136068; cv=none; b=bkz2lfuPcnwc+v3Ya5cS4HUg9gUQKOQkGIr8dBHQqjOgrNjgU5VL4VpVcsG7FSSEced/IVPhMQa8R99IKSf7R3SflB+LvIsd0IcmFLL2RVLSOs/pSXelT+bBNFGp3sxr3QVOWiuvYhJVzTDrStViBl9Llau/MNZ34hiDn+/I2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136068; c=relaxed/simple;
	bh=cN6EFJn/s8Y9mkYp85bQ4DeKYSqzeskgWhENHeFf2Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBHsPr/sjDTA6N1jsj2IISedlll1XceltZOr/NgLwXnRpHrZPhsmNea41YumAcpqKf8NQAdDCp9U6Ut0tmjxgoCJGk3n/kbPt6epl+FdZQgCnnslGG8bo5qtS6ekZUPM8RQk2k3PzuETa3CJksU7WknVKxVoOhhpqshqmlKoYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mqiFBwbt; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so790089276.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726136066; x=1726740866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cN6EFJn/s8Y9mkYp85bQ4DeKYSqzeskgWhENHeFf2Ew=;
        b=mqiFBwbt6bLhh8SWFBtc2tfEi5DLwEOzkFkQUXXODuuGe+uKhgKttH+g7V6PtzR7Z7
         qI5V6/xoZ/b7bWCE2f3YF7l3fuvXYa9rnKAD5Op/ecp84Y0wzt82+alyGNh4x9v4fFIj
         kU0TXg5cycfAax0+X86O+xJrCXQYM8SiT2HmaW5SN/I+XfLW0pH9mqaQrJjq1JKxA0pI
         x1odZSMnVVH/n6DVdS1JPcESBfxWS+GdAReRZtBMPj1ksrilD3LgN/pw3Bi/7JgmPgzl
         Vt9ofqkB61FVrbFzNTA2Gmph9OR5XA8vheq0S6gClB3uJo03wY7dyhHHWuaRHjvK7Plw
         rwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726136066; x=1726740866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cN6EFJn/s8Y9mkYp85bQ4DeKYSqzeskgWhENHeFf2Ew=;
        b=u6SgWsWjNH2cc+tqAj5pogbYY0H+1SJaR0cbFGaT71zr8eXJVonlCFkBvS1aJQsBE0
         v9QDIViZ11FTEQ6ySpnz0f9rOroMJ3dkgNPH55PG3W6L3sZ7Ok2BrJqv0EEUQOcVYVws
         f+S5KgUn1WiUgUZP/qS/FRqd4dMNA/l057daqzMFOK04mIlIvKGYQZ/r38cJjpJjCunq
         bQ6EToiSvuKtEm3RBa6ZrS7Z2VpMAdxc/gfahQXnXqO7fLZYs9f3hV+Mh/aBFbcopfo4
         5JTjI4qjFYqECPKyXIb4BFRlbxHnwlYGKob38+ko1cp58LD8cM8HazO80R+Y4Psnr+Ya
         UA5A==
X-Forwarded-Encrypted: i=1; AJvYcCWPGCT6GtzvQMsrCtWK1SJOLKmJGKYnurE1MBgbfNo43iaKXiltO5nREZoJC+lhWi7DU4y1BgZxpAucvlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpOfZzkLgkEfACt5bULMmQxLVCA7rjnZi74cco6Pq4e+MRxey
	dPa7SFn0NsOa0pigPMVl+0RHuooGchazMNZc6idkv5ugDV7l5SN0YbWGxswJxNr0WOwPWXYw/3S
	pIs58KzkHRsuh/RjJgl1THC6vyZ2F6Gq7781A3g==
X-Google-Smtp-Source: AGHT+IG06vztCwLGif/dMu8sDhD7TqfZ7MOUniEezADPLz0slQoy/6BZntcdSO4iDJ7Mg0k+WekmhUsHyGqyQrYK7Uw=
X-Received: by 2002:a05:6902:144d:b0:e1c:f22c:87f0 with SMTP id
 3f1490d57ef6-e1d9dbbbf1fmr1915348276.14.1726136065697; Thu, 12 Sep 2024
 03:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
 <20240902224815.78220-3-ulf.hansson@linaro.org> <20240903071638.bedt3gllqdacf43a@vireshk-i7>
 <CAPDyKFoqEAHns0nrXT6dJR3sRd5VWidK_rzXGHzJiZtk_p0cKw@mail.gmail.com>
 <20240903105321.suosbhkkkylfw4bv@vireshk-i7> <CAPDyKFrh4VASFzMxEg3Q8SrhVbt1vH8QJM0rCdfxo+-L1+CN_g@mail.gmail.com>
 <20240904064004.7hwfom4nrqzfkvlo@vireshk-i7> <CAPDyKFqZiX=F4oNa3H+fUCO9cRzapxMaAphdx+JFXuR-Tgv3Cw@mail.gmail.com>
 <20240906061405.bz7y3erlz4v5fvvd@vireshk-i7> <CAPDyKFpbA-fopq11Lc0j9hgM86DjveNh+Q=w=nEn2fvcFyp93w@mail.gmail.com>
 <CAKohponJsqOYAvQqU2qrBCXv_P0+0zKAm7-5gkKGPsF_kT7L0w@mail.gmail.com> <CAPDyKFpHYv1eEy==bHhCg6cX9MYdZr_VDoFKBnucZseQVkQWDw@mail.gmail.com>
In-Reply-To: <CAPDyKFpHYv1eEy==bHhCg6cX9MYdZr_VDoFKBnucZseQVkQWDw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 12 Sep 2024 12:13:49 +0200
Message-ID: <CAPDyKFp2s4mPtdU6pMzPbBqqLFxZa1esrXyqXL6UJO-gU-PsVw@mail.gmail.com>
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

On Wed, 11 Sept 2024 at 16:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 11 Sept 2024 at 08:03, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > FYI, I am on holidays now :)
>
> Oh, nice! Enjoy!
>
> >
> > On Fri, 6 Sept 2024 at 14:19, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > How do we differentiate between two cases where the required-opps can
> > > > be defined as either of these:
> > > >
> > > > required-opps = <&opp_pd_50, &opp_pd_51>; //corresponds to pd_perf1 and pd_perf0 (in reverse order)
> > > >
> > > > OR
> > > >
> > > > required-opps = <&opp_pd_51, &opp_pd_50>; //corresponds to pd_perf0 and pd_perf1
> > > >
> > > > I thought this can't be fixed without some platform code telling how
> > > > the DT is really configured, i.e. order of the power domains in the
> > > > required-opps.
> > >
> > > I don't think we need platform code for this.
> > >
> > > When registering a genpd provider, an OPP table gets assigned to it.
> >
> > So we will create a real OPP table in code, which will point to the common
> > OPP table in DT. Fine.
> >
> > > When hooking up a device to one of its genpd providers, that virtual
> > > device then also gets a handle to its genpd's OPP table.
> >
> > Right.
> >
> > If there are two genpds required for a device from the same genpd provider, the
> > picture isn't very clear at this point. i.e. which required OPP
> > belongs to which genpd,
> > as both have same table in DT.
>
> I agree that it's not very clear.
>
> But to me, this seems like an orthogonal problem that really should
> not be managed by platform specific code in consumer drivers.
> Moreover, unless I am mistaken, I believe this isn't really a problem
> for the currently supported use cases we have for required-opps. Or is
> it?

Answering my own question. After some further investigation, I am
afraid that your concern was correct.

One sm8250, venus is using three power-domains,"venus", "vcodec0",
"mx", but there is only one phandle in the required-opp.
"venus" and "vcodec0" correspond to the "videocc" power-domain, which
has a parent-domain that is the "rpmhpd".
"mx" corresponds to the "rpmhpd".
The rpmhpd power-domain has one shared OPP table used for all the
power-domains it provides. :-(

Because we also need to look for a matching OPP table for the
required-opp by walking the power-domain parents (needed on Tegra), we
simply can't tell what power-domain the required-opp belongs to.

>
> That said, we already have two methods that helps us to deal with this issue:
>
> 1)
> For a genpd OF provider that provides multiple genpds, the genpd/OPP
> core tries to assign an OPP table for each genpd, based on the
> power-domain index. In other words, if corresponding OPP-tables are
> specified in the operating-points-v2 list, those would get assigned
> accordingly.
>
> 2)
> The genpd OF provider can control on a per genpd basis, whether there
> should be an OPP table assigned to it. This is managed by assigning
> the ->set_performance_state() callback for the genpd or leaving it
> unassigned. Typically this works well, when there is one OPP-table
> specified in the operating-points-v2 list for the provider - and only
> one of the genpds that should use it.
>
> If it turns out that we need something more flexible, I think we need
> to look at extending the OPP/power-domain DT bindings. We would
> probably need a "by-names" DT property, allowing us to specify the
> mapping between the OPP-tables and the power-domains.
>
> >
> > > Each of the phandles in the required-opps points to another OPP table,
> > > which OPP table should be associated with a specific genpd.
> >
> > Yes, but a simple order reversal in DT (which I sent in my last
> > email), will not be picked
> > by code at all. i.e. DT doesn't give the order in which required OPPs
> > are present.
>
> Assuming genpd OF providers are following 1) or 2), I don't think this
> should be an issue.

It looks like I was wrong.

This whole problem boils down to that we are allowing the OPP table to
be shared for a genpd OF provider for multiple power-domains. We could
consider adding some new DT property to point out at what power-domain
the required-opps belongs to, but it doesn't really matter as we need
to keep supporting the current DTS.

Oh well, back to the drawing table to re-work this again. It looks
like we need to make it possible for consumer drivers to provide
additional information to dev_pm_domain_attach_list(), allowing it to
understand how the required-devs should be assigned.

Unless you have some better ideas?

[...]

Kind regards
Uffe

