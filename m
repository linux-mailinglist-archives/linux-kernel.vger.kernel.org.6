Return-Path: <linux-kernel+bounces-318478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B49296EE89
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893A61C216E4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EE28BFF;
	Fri,  6 Sep 2024 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="thfqbTkw"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2813A3F4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612596; cv=none; b=IjTc8Drb+kw0KCz35Zwn36uroTxiOOs+e2NhChqtEyuIyOpuGlZSKlE1nf6rzI8wxNGvpllFb7LHOyBSFG1/TWbxPrg/KApfiIdTbNgJngFnLpk/h4W/CpxDPZ4VtwS/BFzEUC7i0dKRoCi958izvcbVemAuZDpmuGEvlzEzZqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612596; c=relaxed/simple;
	bh=4j+xA8Np1vhYYDzwctbUrNK37qB7oXmgVzMqNnvoab0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTWRLYdYitm96+hobr0aXM6zifUdocem9UgUFt/KdXnNW9nuK5N4tWmrb/tk9rEepoc6GJRkep+8nLXmP6bb2HcEW6ZC8pft3o/1Q2XDrX66sfOQN8lTLhdXg8CxTriMQjhy/qCz4/vZWzRQd2mRDhLQvaoWu86DTBz9J3kuwsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=thfqbTkw; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso1854814276.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725612594; x=1726217394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f1BzqdqQe6y9gQJcPLLSM3ZzX5+39rivWVxZta/SdSo=;
        b=thfqbTkwKkKtGIjFzV3xjinogeh9vRP4T1mfy0igCaoZQxqZJzGjiCJFmTWVYQbJg3
         IOiQTtwHiWUv4oohbCOFOBhyZQa4826luEMuzKhJKp7IMWNlfxZC7ejKlylUQ++JGj1C
         TsP7U2/JfJbvrZDx3hmqbJ2tpnqS0qKMsXCo1e4/Qj0pDCRC8su663hoOpVixewXD3HP
         uYh50HvzdfFxYkXo9lPlgi1DqyuVR/S/jly1dyY4HI4vUG+g4arRwfhtBHahDB5p3pnh
         imUFciiihyqiwMCOREtqbSufqmNvYokchi48mMozpJRvriES6o+IlcaFSzSXZmcru/Qz
         wX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725612594; x=1726217394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1BzqdqQe6y9gQJcPLLSM3ZzX5+39rivWVxZta/SdSo=;
        b=ubH1vw09tzRDdZ4qVekGQij9kx+q8LEc/48RbpJcQ6QsP9bNL9xg0IXA+ah0BxKGZ+
         xg3utIuGo5HzQEsUeL6WVkjtdnA744x2oZE2abI6mObDNQ9dC3se6ZOGaNICEmgTDxaZ
         SSmccnyn2359HgGzWfMqO0ss5bwjWDLT5QVl9CxH8O1Z9K7mnPIgWf0fYVvS6Q+DVVdv
         H+3EVS6es+SjE7TjLfAFx72aJi/Aop3TW2SW+ZNYG1Bto275DljCAFSWUx4qMIBOpLWH
         PtZbnS7LbZ9idyDjzno5xtLssA75Ek8ZrA4CsIXp9RRbkoCZKRN7ltbn38LhkPjA1fRh
         9H2A==
X-Forwarded-Encrypted: i=1; AJvYcCUAQqhQXzpbqdfb5E6eDLDC9eXRWtTKv1bjOGl+4qAaMM420gCcrDhd9qunRPxgMY3kR7SSAy3vd+DS9OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvLtke5B+GdI9j9PzqhuOklhlmoBRFMfDejonyEgHzziEpny4S
	RyXu+wlNXXz57ndHVvI0+so/W4gEpQ8yTf19QDkROxVFWIKhbHIyHt/35ZFy98Ap6FbZbYhVmiL
	8SbDsPuUbXwe89D+JsAE3N3znBSGocFg56dwuxA==
X-Google-Smtp-Source: AGHT+IHGxSbE/NE5PDqLxc5pXTVylIfDPFOzzeODSdvXFNuUYnR4N34XJw+Tr2XTBa+Gby93rK8fgt7N+kyqrZ6A0+o=
X-Received: by 2002:a05:6902:1245:b0:e1a:b102:4802 with SMTP id
 3f1490d57ef6-e1d349f20f5mr2581521276.35.1725612593745; Fri, 06 Sep 2024
 01:49:53 -0700 (PDT)
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
 <20240906061405.bz7y3erlz4v5fvvd@vireshk-i7>
In-Reply-To: <20240906061405.bz7y3erlz4v5fvvd@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 6 Sep 2024 10:49:17 +0200
Message-ID: <CAPDyKFpbA-fopq11Lc0j9hgM86DjveNh+Q=w=nEn2fvcFyp93w@mail.gmail.com>
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

On Fri, 6 Sept 2024 at 08:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 04-09-24, 14:57, Ulf Hansson wrote:
> > > Yeah, I missed that, it doesn't happen via DT but by platform code. I
> > > do see problems where situation would be a bit ambiguous. Your example
> > > with a minor change to your code:
> > >
> > >         opp_table_devA: opp-table-devA {
> > >                 compatible = "operating-points-v2";
> > >
> > >                 opp-devA-50 {
> > >                         opp-hz = /bits/ 64 <2500>;
> > >                         required-opps = <&opp_pd_50, &opp_pd_51>; //corresponds to pd_perf1 and pd_perf0 (in reverse order)
> > >                 };
> > >                ....
> > >
> > >         devA {
> > >                 compatible = "foo,bar";
> > >                 power-domains = <&pd_perf0>, <&pd_perf1>; //both
> > > pd_perf0 and pd_perf1 has OPP tables.
> > >                 power-domain-names = "perf0", "perf1";
> > >                 operating-points-v2 = <&opp_table_devA>;
> > >         };
> > >
> > > Here, I don't think there is a way for us to know which genpd does
> > > opp_pd_50 belongs to and to which one opp_pd_51 does.
> > >
> > > We solve this by sending clock_names and regulator_names in OPP
> > > config structure. That gives the ordering in which required_opps are
> > > present. The same needs to be done for genpd, and then genpd core
> > > would be able to attach the right genpd with right required opp.
> >
> > No, we don't need this for gend as $subject patch is addressing this
> > problem too. Let me elaborate.
> >
> > The OPP core holds the information about the devA's required-opps and
> > to what OPP table each required-opps belongs to
> > (opp_table->required_opp_tables[n]).
> >
> > The genpd core holds the information about the allocated virtual
> > devices that it creates when it attached devA to its power-domains.
> > The virtual device(s) gets a genpd attached to it and that genpd also
> > has an OPP table associated with it (genpd->opp_table).
> >
> > By asking the OPP core to walk through the array of allocated
> > required-opps for devA and to match it against a *one* of the virtual
> > devices' genpd->opp_table, we can figure out at what index we should
> > assign the virtual device to in the opp_table->required_devs[index].
>
> How do we differentiate between two cases where the required-opps can
> be defined as either of these:
>
> required-opps = <&opp_pd_50, &opp_pd_51>; //corresponds to pd_perf1 and pd_perf0 (in reverse order)
>
> OR
>
> required-opps = <&opp_pd_51, &opp_pd_50>; //corresponds to pd_perf0 and pd_perf1
>
> I thought this can't be fixed without some platform code telling how
> the DT is really configured, i.e. order of the power domains in the
> required-opps.

I don't think we need platform code for this.

When registering a genpd provider, an OPP table gets assigned to it.
When hooking up a device to one of its genpd providers, that virtual
device then also gets a handle to its genpd's OPP table.

Each of the phandles in the required-opps points to another OPP table,
which OPP table should be associated with a specific genpd.

In other words, the information is there, we should not need anything
additional in DT.

Kind regards
Uffe

