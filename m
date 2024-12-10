Return-Path: <linux-kernel+bounces-439679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F589EB285
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958B2286B05
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3563119DF9A;
	Tue, 10 Dec 2024 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXSG+Dbv"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F175C1A2547
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839344; cv=none; b=DiAokWOj1uyevPxCP80+iC2adSpUT/2CMkKe9MVykEVw3Wwu3MLG4WLIZ6r/kD69TBespqnWycYTq555SXpFZNfU8/ALNNuzaTSRRHf7Zqa6HDhicxXogvjbfMgfJjlYu7kToBRVDV2tp5I5VmXBGvfNjBznge1eKsUmmf1Wxo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839344; c=relaxed/simple;
	bh=hxA6gBaMkz3RlMJmyAs2nKGpJbjXZ6crp1ZPlqHZMI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2ifj8iyHtnE76aDrlyDkSSGtCdmRK5nXzdINLtf78IaiE+iKrHBM2VRqR88rcds8IIGbwjWTIEDmG+3rX52AfwaWzbX+bzzNwo/AoHeQ2se9Qyyc5ciAaaVEHs1jdcn1rReWfEFIBFNyGUSpIfzGpWM4faRJG+f3QZRmYWwGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NXSG+Dbv; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e38938a55e7so5379913276.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733839342; x=1734444142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GGDjDmjaarnv2LRhR9yI+0cQdlmEnitFOz5zg2VCDVs=;
        b=NXSG+DbvlGbeRq+cDPie+nLVsvP3HRyhJYo8MoTZAZuns8MCUZDR5DoRbN5FwSp0zL
         RIbcgeIPfqSzkuSekFpf6sX3bi/1SJr1QPekxr1IQUaRp18QbAOwXKmbgGl8ugBeJpg/
         SaQHKOhZzT197Itfh6+ruCELjbFpdLjgWgZDsss0z93dMtrPuTH44IRIoun12tyvf0qU
         zTQp3UZ+xCZhDBFrog1peDToCMI4yHZyc8na7ap4utyeXTwhn2ih+pIAdNiRYLgIOD9d
         xjX3dYOuh3paZ4ucOJwcoavlJ+iTrS5htuvaD33YlQ3sGuWALdSu5+5rJ3OE0kWfeLJO
         HBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839342; x=1734444142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGDjDmjaarnv2LRhR9yI+0cQdlmEnitFOz5zg2VCDVs=;
        b=jXmJp/A5Q205E29jnvyFu3bJ4C/PnNbNBstFxndk27DkAPAky3kyjdrMnumwZRroBQ
         MsKw+0OMVRMeZOwIxOAr8xMldt6eZkq2RQMgZ1B34gIVgnhCYYjTHSO5usfh+/SvexNQ
         nr2/vMWOOLtop1RqIEw/V1CFeQ92FTabXN1y0tfym2iCbYPwNBbfDdqUnX5aVB/QFZfu
         gVBjuUDDLS8VOrKc1+I0xiNe6QOjE2SfVA7bEQ/gk9yJ/NjR9VjjBuxU6RFxHaz1IXgR
         ZAYRMcIVI1EZ8d526EzQtOG+uAIQnTtj77TvrNV9vU7VKdwpnk0/LyQPQz5MkUx3uJ6y
         vcjw==
X-Forwarded-Encrypted: i=1; AJvYcCXSOxkt9Vpd9ONCQkZH1FqE2FFJHGR1quM0+e2l5ZiVFaIEsGBebOwjxx6tIIZbyrxsgY3KdTSGyfH1ygA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMGdFokdT2NGEae3BagJORqhMd8bLM471f4nNxrlYsAYm4gKG
	L1OEoBf910Y7pXtF4gRvErjhogcbaPCdY07oRivXXCfKoWUJ3V44jDu3neHVO4tZ/1JTnAbYV7i
	VMMmfTfIvE0G91c5VzPKVNSMSwPEiibh1UZw1Lw==
X-Gm-Gg: ASbGnctinLCC9tS2BkQxAzKqWCPcjtfwVVL3cQRD0sk7bNXPrEHFHtLA2cB9dpTDoUn
	Gt5+bpc/qtyECqmMHHI69yhFTFwsRJpVKs+ZA
X-Google-Smtp-Source: AGHT+IF8ODQGXD7UsXZFA398vKfIghJH5HEH16ZMuk46OLFWyEc2exSc7lgWOZZzJyVLz5Z9bI2L9Yz5Wky7WJz7dOY=
X-Received: by 2002:a05:6902:200b:b0:e39:82aa:45a8 with SMTP id
 3f1490d57ef6-e3a0b527cbcmr14579056276.53.1733839341586; Tue, 10 Dec 2024
 06:02:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119141827.1.I6129b16ec6b558efc1707861db87e55bf7022f62@changeid>
In-Reply-To: <20241119141827.1.I6129b16ec6b558efc1707861db87e55bf7022f62@changeid>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Dec 2024 15:01:45 +0100
Message-ID: <CAPDyKFoghwa+x0Dc8RfWWdDpP-mD4qUBZKpXjy4pK0mQwf6gGg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Activate GENPD_FLAG_ACTIVE_WAKEUP with OSI
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexandre TORGUE <alexandre.torgue@foss.st.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Nov 2024 at 14:21, Patrick Delaunay
<patrick.delaunay@foss.st.com> wrote:
>
> Set GENPD_FLAG_ACTIVE_WAKEUP flag for domain psci cpuidle when OSI
> is activated, then when a device is set as the wake-up source using
> device_set_wakeup_path, the PSCI power domain could be retained to allow
> so that the associated device can wake up the system.
>
> With this flag, for S2IDLE system-wide suspend, the wake-up path is
> managed in each device driver and is tested in the power framework:
> a PSCI domain is only turned off when GENPD_FLAG_ACTIVE_WAKEUP is enabled
> and the associated device is not in the wake-up path, so PSCI CPUIdle
> selects the lowest level in the PSCI topology according to the wake-up
> path.
>
> This patch is a preliminary step to support PSCI OSI on the STM32MP25
> platform with the D1 domain (power-domain-cluster) for the A35 cortex
> cluster and for the associated peripherals including EXTI1 which manages
> the wake-up interrupts for domain D1.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Makes perfect sense to me - so applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/cpuidle/cpuidle-psci-domain.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index 146f97068022..5fb5228f6bf1 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -72,6 +72,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>          */
>         if (use_osi) {
>                 pd->power_off = psci_pd_power_off;
> +               pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
>                 if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                         pd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
>         } else {
> --
> 2.25.1
>

