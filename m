Return-Path: <linux-kernel+bounces-327339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D213197745F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AB81C21954
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ED41C2DC8;
	Thu, 12 Sep 2024 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YiLBIrPs"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4517DFF5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180409; cv=none; b=cIxN0Q9339Dr8ka7nsHYujZFdT7XwoqNmimqHj+nhda2+0b/UwYTdWBNNN4E6OB4TaUFEiWRVK7awD2ZHDBBL759FOAV/7zhsElfpqwLP6hqx8dQ7F7HvUq/b1ejV8YsLOWCELKsAwoJ+nmT7xof8Icj7fukXtxAVNtFP/bdGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180409; c=relaxed/simple;
	bh=oiAYyKBKR7wzcekJ+NG2T4KqRVaZPZH786D8kFaGuM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYaNN1unbJDRndCDVu+Woi+MprBY/k8gC/QTpuaWJrw9KLNdlVELGxIbaEXM5GkkG9Rz5Q0mUpBmvo4YmePtaRoOOFOizjv7bI8rSJkYYT3gy09iMSyzraW5hIqCLi4/VUGx/oy6iYf6c/VKxKZFKn28Oi8VwGsNcLISn7mMelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YiLBIrPs; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e1a7d43a226so387134276.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726180407; x=1726785207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f3OpCrcF+SbicG9ADVdKvnUsA/2LlehvNo4t5Jv4vXs=;
        b=YiLBIrPsM/SV9oY2XFgRzlU+u5ZQes3mRtgAjK/pSpRNyR9U7/069aT2J8nkwfgjL+
         FQ+kRIgs7O0HpqsOYuSUjRp9H+DUF3JqNjBfQ3A5nsctRMuOGCCq1hF6YBhsed1/KncJ
         krEBcrKyb5dar7h1b8L3WcYes4laiupyQWqv3PkEK+7W5+c5rtZoS66PX4sjYnfNVnQc
         M7UiDN9vSkJ7twh4rzPStW6kGA5RAmqN2uy6bI1I6cldnocDrzt16L9CzqSweW0tt4G/
         tA4XC+2G/DXqPQhcFPwUYUq1T5Q3nEU13XMZNTK7HiAb8HnrLNHtDGVhCCBz6HkHT9Cv
         Nv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726180407; x=1726785207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3OpCrcF+SbicG9ADVdKvnUsA/2LlehvNo4t5Jv4vXs=;
        b=WWtcntb/7++Kjx3rX5Hn479jczBFNpzDV90bTrtTP0AqNRFINTgRc66Ta9TuwShV0R
         PTemYyPG08GMA7IJAi3ytbOIQx7X7ee7eKVEVlI60vdYNJtaKshbgtuYoJ05sdK7s1NJ
         gSmvdzwqVOytAYtRuxSEE5IUp/lgb6PPLtsGku9onvRrmRnxHF5dTTi4tIDTCilOkM7M
         KDYNFq0Y3013T5duhRWPBDIGgCfn1WihrHXsO9NpkHO1qtUZe26duvuJWXIuj+Vn+Byd
         QIoi5FQ7h/UHYLXeaW7ortoX7OqB0OxLsEl+4bcvKzpC2D2bKuVfAy4JWwvRFS2Uox1h
         0jmg==
X-Forwarded-Encrypted: i=1; AJvYcCUpH6bQD6VkzkZBw40fgHLIINxhSc0GZydScuLErqcndf4CLmBO4wm7iMjm1dvO+fZm8n9wubrFWzSrF/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3+6OHH17nwV5BjTVWHzmKGkdEW8rp8+48AZTmjDKg4/rcE0+
	hwomuBPvd4hOU9/Ns/3N7Mjg7cb3C9oK5kc0s++PXpoQMVyCzMB1UZUnbfaPF6tER/WJtQiQWhZ
	wZTWs5VyhxYGbQbTa03MtFdhD9QK0z7KNBu4x2A==
X-Google-Smtp-Source: AGHT+IGD9f57jUl9Isy6GGo2oa4ljYOdYvzqkIlK9dwzng9HFl4xwo4CIsOuAn2odj0OogZk6ewJ4tjVYa+BsWhBzrA=
X-Received: by 2002:a05:6902:168e:b0:e1a:3d54:bd87 with SMTP id
 3f1490d57ef6-e1daff94cd3mr696954276.30.1726180406916; Thu, 12 Sep 2024
 15:33:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822224547.385095-1-ulf.hansson@linaro.org>
In-Reply-To: <20240822224547.385095-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Sep 2024 00:32:51 +0200
Message-ID: <CAPDyKFqCjw+=u+zGSc1aNKMyGcdz8ovzv9==YN8W6i3fOzYsbQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] OPP/pmdomain: Assign required_devs for required
 OPPs through genpd
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <quic_kdybcio@quicinc.com>, 
	Nikunj Kela <nkela@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Stephan Gerhold <stephan@gerhold.net>, 
	Ilia Lin <ilia.lin@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 00:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v3:
>         - Combine the two series [1] and [2] into one.
>         - A few minor changes to consumer drivers.
>         - Clarification in commit messages.
>
> Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer
> drivers to attach a device to its PM domains. Their corresponding virtual
> devices that are created by genpd during attach, are later being assigned
> as the required_devs for the corresponding required OPPs. In principle,
> using dev_pm_opp_set_config() for this works fine.
>
> However, attaching a device to its PM domains is in general better done
> with dev_pm_domain_attach|detach_list(). To avoid having two different ways
> to manage this, this series prepare for the removal of _opp_attach_genpd().
>
> Moreover, it converts the few existing users of the _opp_attach_genpd() into
> dev|devm__pm_domain_attach(), allowing the final patch to drop the redundant
> code that becomes redundant.
>
> To test this, I have used a QEMU setup, with local PM test-drivers to try to
> test all various combinations of single/multi power/performance PM domains for
> a device. Hopefully I have covered it all, but I would certainly appreciate if
> someone could help to run a slew of tests on some HWs.
>
> Note, due to dependencies I think this whole series is best funneled together
> through my pmdomain tree. If you think there may be issues with this approach,
> please let me know so we can figure out the best merging strategy.
>
> Kind regards
> Ulf Hansson

FYI

This series has been cooking in linux-next via my pmdomain tree for a
while - and lately we have received some bug reports.

Rather than rushing to fix the issues on top, because the merge window
is getting closer, I decided that it was better to drop the whole
series from my next branch for now. I will continue to work on a new
version of the series and post it as soon as I can..

[...]

Kind regards
Uffe

