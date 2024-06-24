Return-Path: <linux-kernel+bounces-227443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CB091514A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD63B263DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3119B3DB;
	Mon, 24 Jun 2024 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsHTLzEO"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85219ADB1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241414; cv=none; b=slLR67LpqSLAG9psqR65evJ3bBGrHz6MF3BKv0rhTEY2Vk3x7wH/1DPgcB6Ke+IeaU1VKz9KXtJ/29R3Jn5YqIdLx0piI4/moPAfhcSJ13CtQf9X1RkonM4+b/FYplBT8UWQxO7rmsUGQxZQEogXDAO3z2m0OuWJxcByGtetY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241414; c=relaxed/simple;
	bh=Ex/w9v0ggVRKNBzIpeN9n70AI3dUUvfOjWRl1ppkA0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7W8e11cPoGhzncEuJcuLHYWr3I33lG6Xemu8L4Q6rZGMlh3BhimzWpPbi6Ew7+sMN3ZDkG22uH7h4XNjh7BQBFCW2/8mPiOtc0lGwvtnRBwgWjspZgTjFqTnzhyI1F1qQ9OCUvnTClUnYW1x4BwbYEwIwHhQIc1ZJbtga38Mxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UsHTLzEO; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfef5980a69so4219773276.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719241412; x=1719846212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OsE3fTT5myBrFEQHKtx08Zi/1nBt7udSIXRFFLGo1WU=;
        b=UsHTLzEOAfLzsiibJUGbXzLmcduUUcSnxobGfufnUMGou9vIAqsPXDMkpz0J82J5A9
         d7YVawuaPtQnS4zPLx4SKGW1A1B5/nar1Bn8WL+Tvyhx8djAHNkANR9SSAbOKYNHn6c1
         2I1jJk50+4CgkY0KDle+qdcR4MHckElM+OvKo+RFZWqkyiLuiZMBQmgLP/55z0wW73iu
         XRIml5ScssTFmf+DEWeMbPU2hu8DNt/26army5eXXwqTDuSckZweZZZm/lsCa8dWnXnV
         4QaOqJdb5JxfF0Se4HcJVYaVy1FuApO2RggXo+RjclKgoSESZEMM508upLkF26u6hsIJ
         O5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241412; x=1719846212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsE3fTT5myBrFEQHKtx08Zi/1nBt7udSIXRFFLGo1WU=;
        b=e3FgnYbmAnhF1OUnMQTyzSbzyxFuHFggTSDz1VZODmPiBg5k/Iw5eBCFob5b7L5I5y
         wobEGPlPGQxxx5LARDJhZXg4a+N/OHdT53Bajzfw9Cm3TJ1NDBGhXlNjrYxka7NVyvl6
         L2irSzd/mqv4Ki33Kus//oQBLnv+6PQ8gyIaHNqtf3eicgWyMXb2E582UiG6vzXDIkRv
         T3aAggqNfJQ6adQEJ2jgop5UxBPZ8VgZeaNv2OUfR3K9J1PH7dhfP5gOJwzRizHuSTMY
         smNDn9G4z418Gm74oVWU1CSoJdGMmBNW3bctj9SIzr+OuFroX4/YEviQPM+dE6O5PRiA
         vegw==
X-Forwarded-Encrypted: i=1; AJvYcCXunnQ3J7bjwz3/D3WBM+9plB3zD9a41avPUyg4wDCnvwtaiJJwQreJz5vLILaV3I8clAkjTKLRphdfvXnJ91K6WaExk9QrWx2mbsd2
X-Gm-Message-State: AOJu0YyngF8UVEpcG7nv5fTmVs+6NJWr5DvfHUoOzDTtkw0b/4N0o8yF
	Go8xXSm7+QhA9ekpwRo+RW10SE4r8oaZbvSW4pqZs05/RQYmG1QbqoKnVefEDJf6qxqxx9xmHGs
	XHUUuy+0vllGUPc3VJY0tf1vvgTURXy+/Yq6iNRZz+AGc3qLKrGQ=
X-Google-Smtp-Source: AGHT+IFgZJP9TONG6Jdr6OwJ5dbwU5KibjnajMQumI5uC2m49JmAMbhUf6jDpZqQJR81wrPLtZsJyh+DTLgw9R0rJzA=
X-Received: by 2002:a25:c789:0:b0:dfa:d056:a901 with SMTP id
 3f1490d57ef6-e03010ba58dmr4935858276.56.1719241411838; Mon, 24 Jun 2024
 08:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619140849.368580-1-ulf.hansson@linaro.org> <12b17db6-2649-4b7e-a35e-797ba2d9f2aa@linaro.org>
In-Reply-To: <12b17db6-2649-4b7e-a35e-797ba2d9f2aa@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 24 Jun 2024 17:02:55 +0200
Message-ID: <CAPDyKFpPvsEhVMpxjJt1+QmY0LsHrDZ+RkFMfYrHQnWUcaVSbQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] OPP/pmdomain: Assign required_devs for required OPPs
 through genpd
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Jun 2024 at 14:18, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 19.06.2024 4:08 PM, Ulf Hansson wrote:
> > Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer
> > drivers to hook up a device to its PM domains. This works for both a single
> > and multiple PM domains. Their corresponding virtual devices that are
> > created by genpd during attach, are later being assigned as the
> > required_devs for the corresponding required OPPs.
> >
> > In principle this works fine, but there are some problems. Especially as
> > the index for a "required-opps" may not necessarily need to match the index
> > for the "power-domain" in DT, in which case things gets screwed up.
>
> So, is this series essentially tackling a problem like this:
>
> pdp_A: power-domain-provider@aaaaaa {
>         [...]
>
>         opp-table {
>                 pdp_A_opp0: opp-0 {
>                         opp-level = <0>;
>                 };
>         };
> };
>
> pdp_B: power-domain-provider@bbbbbbb {
>         [...]
>
>         opp-table {
>                 pdp_B_opp0: opp-0 {
>                         opp-level = <0>;
>                 };
>         };
> };
>
> nice-device@ccccccc {
>         [...]
>
>         power-domains = <&pdp_A>,
>                         <&pdp_B>;
>         // order doesn't match /\
>         required-opps = <&pdp_B_opp0>,
>                         <&pdp_A_opp0>;
> };
>
>
> ?
>

Correct, this should be taken care off by $subject series.

Kind regards
Uffe

