Return-Path: <linux-kernel+bounces-256272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3605934BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC3B1C21B51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FCB12C470;
	Thu, 18 Jul 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOktE1dT"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7BC757FD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299145; cv=none; b=ewJ0S36qjuWPLar5P4VrmAEz+BJP6ExPU+S0g/vCq3cpD4UmmqRolqKwPAaBoDPZv0GLlyccfkIRuxfYcy4xJLDpViNwOqdWfUS6T7lqmtzhKXOo6n5gWw4ubm37E4/RnSInz/V0nNBvFyAyxc51dGGBFzsmSmpIMtRNT7V0t2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299145; c=relaxed/simple;
	bh=m4LDLFOl8l/a5mtKOKFxzS9JuC3DNmVRoncGb9gKmNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shrUYHLa32qgSeVP9Dcy1RCE872vFI/iNQwYu8pNVXWKbnz9S+QDbq13ELkKPg1GJWNDsmx3ERxYM1G3N1cyCV4S6bxlGp1ST8nY9wYrTq1se551qjzWYoejOo9kXHmTJbrsbcMibShI2lrs3oXEtKVUo8J2l+6fOXYZXexSX/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XOktE1dT; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-65faa0614dbso6253897b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721299143; x=1721903943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m4LDLFOl8l/a5mtKOKFxzS9JuC3DNmVRoncGb9gKmNg=;
        b=XOktE1dTaOUPLr6/+55//gzALsjDbhLAY2fQGgHetNnwewT+v+fPiSeUlxrfANRVdV
         vs1fbS5faT+x155gQeN/3UbHYeiompu0gTWpCFOWux1/Z1FeLwGC2Xev/Y2Awf7CBU1n
         UIpGkPFJxfznT2MbtUG3+sGM2sugrCsmqeqoE5Cwt6CgqTIunkP1xgLVquzG2DLdSlVo
         L9c3bVYx21js3i74pPMJWjN4D/fiTewsZ/0sHPpREaysLwN92hAs/2zlmOVAbeaMxlqp
         EAdSRWgyCI4RkN2qBD0T4KTKVwzXewYKWtL8Kqgbuza9clYHWimzmex9EU8rr1uFRRld
         yHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721299143; x=1721903943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4LDLFOl8l/a5mtKOKFxzS9JuC3DNmVRoncGb9gKmNg=;
        b=CPNsidZIfODTtb9lPtnL6YyfriEx8V0T1xWztWGaQrVSHvWcNmlQZjwhfWECKL7kPd
         Z/FtjGacVbEpWcpNvLIiFh0uibyFI8VfVueqH+YU+MHIJ7ISp5FTfIKCFq42tvFmkUNj
         qWNxJBmNVa4kDI/8PeRIk1kMfy6Y+TOTPHOURthxUjAw6srwO5LP+M32yDhgOScYmDYb
         yprRL3ZONvCoK66JJlIA+U2DoBsdxQO0pYFN5cAx61aYbSjJasOhbRed+dKWgS4jTOeM
         2JjwLd6udAgSbmerY1rkmcQTuzikXUCpmBGiXk1ZAI635g/HXQW6hVcGxEN5zssxVR0j
         /Xgg==
X-Forwarded-Encrypted: i=1; AJvYcCUtSgoPGUHtv0BSK/3jnGPwshkFnd+GNqgEwX2O/qc87S2ysCc4VemNBqC4PJuctG9cl8w9V/T+D+s+X779ljVvslATD+qIyJ7JyrgI
X-Gm-Message-State: AOJu0YzctdB7bs2yyF9PxeUryirB+ZNT3OxwYkZ8zQzA5MW+xcqvwXtp
	H39y42CY/1r4IaA9GNjYaEpCshwplrc4Vn0REn7rVV/q8CZVPZl9o5ZNNA7XgLaVguqx0DxoWbU
	BNOcoAazj+cIcggexGm0VIKurcjCZKU6f8o2Zcw==
X-Google-Smtp-Source: AGHT+IHNg8DrykyY2P3tA2MPU5TPB6/XmyE7fm2kYggHiVcUTiboVflJDbP+FqCaRFWkD4Ysgbp3lvEg9XsAEqNaGAI=
X-Received: by 2002:a05:6902:2402:b0:e03:601a:1a83 with SMTP id
 3f1490d57ef6-e05ed79a0f9mr5163423276.39.1721299142849; Thu, 18 Jul 2024
 03:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625105425.pkociumt4biv4j36@vireshk-i7> <CAPDyKFpLfBjozpcOzKp4jngkYenqSdpmejvCK37XvE1-WbBY2g@mail.gmail.com>
 <20240701114748.hodf6pngk7opx373@vireshk-i7> <20240702051526.hyqhvmxnywofsjp2@vireshk-i7>
 <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com>
 <20240711031356.rl2j6fqxrykmqfoy@vireshk-i7> <CAPDyKFocjOt+JyzcAqOfCnmTxBMZmPjMerSh6RZ-hSMajRhzEA@mail.gmail.com>
 <CAPDyKFoWgX=r1QtrcpEF-Y4BkiOtVnz4jaztL9zggo-=uiKsUg@mail.gmail.com>
 <20240711131637.opzrayksfadimgq4@vireshk-i7> <CAPDyKFqczrJzHApBOYRSg=MXzzd1_nSgQQ3QwKYLWzgZ+XY32A@mail.gmail.com>
 <20240718030556.dmgzs24d2bk3hmpb@vireshk-i7>
In-Reply-To: <20240718030556.dmgzs24d2bk3hmpb@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Jul 2024 12:38:26 +0200
Message-ID: <CAPDyKFqCqDqSz2AGrNvkoWzn8-oYnS2fT1dyiMC8ZP1yqYvLKg@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 05:06, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-07-24, 17:25, Ulf Hansson wrote:
> > Right, I get your point.
> >
> > Although, it seems to me that just limiting required-opps to
> > performance-levels, could avoid us from having to enforce the OPPs for
> > genpd. In other words, doing something along the lines of $subject
> > patch should work fine.
>
> I really don't want to design the code that way. Required OPPs don't
> have anything to do with a genpd. Genpd is just one of the possible
> use cases and I would like the code to reflect it, even if we don't
> have any other users for this kind of stuff for now, but we surely
> can. Just that those problems are solved differently for now. For
> example, cache DVFS along with CPUs, etc.
>
> And as I said earlier, it is entirely possible that the genpd OPP
> table wants to configure few more things apart from just level, and
> hence a full fledged set-opp is a better design choice.

I understand your point, but we don't need to call
dev_pm_opp_set_opp() from _set_required_opps() to accomplish this. In
fact, I have realized that calling dev_pm_opp_set_opp() from there
doesn't work the way we expected.

More precisely, at each recursive call to dev_pm_opp_set_opp() we are
changing the OPP for a genpd's OPP table for a device that has been
attached to it. The problem with this, is that we may have several
devices being attached to the same genpd, thus sharing the same
OPP-table that is being used for their required OPPs. So, we may have
several active requests for different OPPs for a genpd's OPP table
simultaneously. It seems wrong from the OPP library point of view. To
me, it's would be better to leave any kind of aggregation to be
managed by genpd itself.

For the reason explained above, it still looks correct to call
_set_opp_level() from _set_required_opps(), as $subject patch proposes
(but clarifications of why is certainly needed in the commit message).
Moreover, when/if we see a need for additonal resourses but the level,
to be managed through a genpd's OPP table, we can extend
_set_required_opps() to cover that too.

>
> > In fact, it looks to me that the required-opps handling for the
> > *single* PM domain case, is already limited to solely
> > performance-levels (opp-level), as there are no required_devs being
> > assigned for it. Or did I get that wrong?
>
> That's why the API for setting required-opps was introduced, to make
> it a central point of entry for all use cases where we want to attach
> a device.

The API as such isn't the problem, but rather that we are recursivly
calling dev_pm_opp_set_opp() for the required-devs.

In the single PM domain case, this would simply not work, as there is
not a separate virtual device we can assign to the required-dev to.

Kind regards
Uffe

