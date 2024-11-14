Return-Path: <linux-kernel+bounces-409548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EF39C8FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A38B376C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA0B188735;
	Thu, 14 Nov 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfFoGmhK"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C115FA7B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598267; cv=none; b=X/qh/A2ozhtl3PVj0BQ2ms6vMC2lYShecWGkgd2c4/alxF9Ld+hRb/gytrdWzKsfatUFL1TAPRd/5JDIsOx5MfeeTKrTi1xDiMZkb7gH8BJBhozMKKx5ETEO+IQJum9Q+u2sitFFO28WwN0hn6Gs0+nFyRHHl+7g2eX2K0ZzysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598267; c=relaxed/simple;
	bh=70gJ5zQHC0Lse0UD4fjwb/7l60pwtmkagRtu7goaz6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ci7acGbY8vvFJjmC4GbQytWFbviJcVBVscYgFumBmYlPcGgHVJewCFUrLbqaZTlLvKue2Yo+gLUfNw4cyFIAzJqFbklXs7ctJkAZEH985kHq6u0hl6H5e3SP60vtDZOJatbJ/IZfp1aLO7w1mH388EDmnb2aV3QxwGUpxjwjt3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hfFoGmhK; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e380e4825a9so645648276.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731598265; x=1732203065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=70gJ5zQHC0Lse0UD4fjwb/7l60pwtmkagRtu7goaz6M=;
        b=hfFoGmhKL91W7vDovOmnY9tdxrF+aAi75Owxppae4oxRHCdwdEiyZqISeg7qNxMPWZ
         oyFxlhwNM1o0Xb9FBUrRxsch1ugBCD14lmVb6Nb/CQsU/AzBmAoFfVtR/w7mE2i9g3si
         QCZ+2bwI4ziFeGNleWubtHXQT32xPFqzbfxU6n5+rCtgfuIr1E2/3mtjpmxrc5NWf6xk
         COQnQL8pn6147fMf5mpi23da/62Y3pMr+qXckrQtxyXKunu8961+gGkQYx8HI8WD38QC
         hL6v6N7OXo5DS/d3BLSBm+Mce5gjuMv0Q5a29dWbJi4p9j6tIx/eQLsONqHMVZIZOZjw
         yHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598265; x=1732203065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70gJ5zQHC0Lse0UD4fjwb/7l60pwtmkagRtu7goaz6M=;
        b=gKFIYZk9SUEBwVpQpDGoDux12DoaDthEkvX5DgbcJ254UjxlLkZr9oR2I41rofutci
         WkUZBOvrjz+ET1WyD+i3R94YmnBd1f18BYVGWPK3HvKf7DLj7sT5orviFl9CnNxkg9Lt
         LVtPir+lY7hMZwEC35Sr2OGUrjdVe73rG97I/w8ovTkBLN7US4KwZdhXiH4Aa61Hw8K9
         5rmVqd+at9kF+dDFg6BMTY2JkwSUCBDXGeu2XvvPZWh9mKU2aciZpbA7pJNnrGbGGKHD
         S2A6EciHaUcBvuCtNcSZ3/93Cy2UUTZ8ZDkwoGFQSzDAt3VJEcuyoDZ6qIIhldA4fLa2
         hAdg==
X-Forwarded-Encrypted: i=1; AJvYcCU52PWmtTtm3V2RpFGwrDYkFo93/rkwzz9yKCnbznqokWz6sQboiQhrL47/OSSFVgYQRUu3cRea6eQlQbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvcm/c/lpsMK9sYxXQBqI+4wA8DPEAYuxuBrbDoiajIJKAmho5
	dOuT6Oz9t1YoqrUQtO3/kuSnobwC1S7WcE/4MswswiXupWNyOqlufj9ri8KHYSuXK54cG2rsdru
	0OEGrkZXl99Byi9KyXcf1xkVhiAK8p7jZApiZOw==
X-Google-Smtp-Source: AGHT+IEp1jiyHz9AVjBAYLpqzeU34jEuIl4ZH89aHk/oBWMuPpm3ufftnmd3RZZtkAwQhhPDaHc5iByLDBclaPuDYYw=
X-Received: by 2002:a05:6902:c11:b0:e29:1def:1032 with SMTP id
 3f1490d57ef6-e337f8c7023mr22843700276.41.1731598264542; Thu, 14 Nov 2024
 07:31:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
In-Reply-To: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 14 Nov 2024 16:30:27 +0100
Message-ID: <CAPDyKFpGrw+vOs=-TxfChBeORjzkpaL_iVB08MtmaC4sFNKzcg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Allow specifying an S2RAM sleep on pre-SYSTEM_SUSPEND
 PSCI impls
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 15:24, Konrad Dybcio <konradybcio@kernel.org> wrote:
>
> Certain firmwares expose exactly what PSCI_SYSTEM_SUSPEND does through
> CPU_SUSPEND instead. Inform Linux about that.
> Please see the commit messages for a more detailed explanation.
>
> This is effectively a more educated follow-up to [1].
>
> The ultimate goal is to stop making Linux think that certain states
> only concern cores/clusters, and consequently setting
> pm_set_suspend/resume_via_firmware(), so that client drivers (such as
> NVMe, see related discussion over at [2]) can make informed decisions
> about assuming the power state of the device they govern.

In my opinion, this is not really the correct way to do it. Using
pm_set_suspend/resume_via_firmware() works fine for x86/ACPI, but not
for PSCI like this. Let me elaborate. If the NVMe storage device is
sharing the same power-rail as the CPU cluster, then yes we should use
PSCI to control it. But is that really the case? If so, there are in
principle two ways forward to deal with this correctly.

1) If PSCI OSI mode is being used, the corresponding NVMe storage
device should be hooked up to the CPU PM cluster domain via genpd and
controlled as any other devices sharing the cluster-rail. In this way,
genpd together with the cpuidle-psci-domain can decide whether it's
okay to turn off the cluster. I believe this is the preferred way, but
2) would work fine too.

2) If PSCI PC mode is being used, a separate channel/interface to the
FW (like SCMI or rpmh in the QC case), should inform the FW whether
NVMe needs the power to it. This information should then be taken into
account by the PSCI FW when it decides what low-power-state to enter,
which ultimately means whether the cluster-rail can be turned off or
not.

Assuming PSCI OSI mode is used here. Then if 1) doesn't work for you,
please elaborate on why, so we can help to make it work, as it should.

[...]

Kind regards
Uffe

