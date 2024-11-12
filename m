Return-Path: <linux-kernel+bounces-406483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38809C5FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AD21F269DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6BF218594;
	Tue, 12 Nov 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSE7KSem"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4D218585
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434490; cv=none; b=YqouKsFY7jNb55olK2Xh9rmoTg2nXmSHiLE9bJsQ5nF7NCLl/pq5nCb4AhzprZt6JhtjUcI5iFqW/lWUFyB0D6A/ukiokYa8weuzmRxJnnXiyhlaMjO7TxzVhcabHepXITULG1mLM1BHp6tebkWbrWoDl6J/F/a0sKILsMmfwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434490; c=relaxed/simple;
	bh=nOVKKuvXUcR25DPN3l1wOkt2GU1wHgzTIanXM7meNTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTt7W1tO6VGLqAE+TEaq8Q3lbTA+lqKRvxtjAI8z+p79V9QQfDwFjONz2+qJDQoZBsy5MgIedgXyzLcFyUqbNT26lHT7IZP1SuQf28Yn6sjl15XAUaEnJ0NFxoQoDbTFkrtlbHQH0czz/XO9wI7KPRuVxp+AL3LUm/TYCpa2Jbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PSE7KSem; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so4774511a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731434488; x=1732039288; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lbAitaWBPhoWxH4bj4NOaD1/IoLABk7tVUOSRiI/Nhw=;
        b=PSE7KSemIU1JkTh6CD+6WI+1pP7AeQWo/02O6PMdO28HR2m42z3ImBJM0H5qCFqEUr
         fyUcsrW2plnv0cRchCwL1Ea/FowMBZoHBYe0m9RLtGLaIeYCneJy916ejCl8v1u0u0ZP
         Gs5TpE+zbAoQOZnJEC4lxtLzHl/pmmU6vFvOy9BmC5sWcUMw2ZBvthqd1qxO6y62CkO3
         qc5umQKnjTFhdR9vCQ7M9xbqt0AhePNOyOXAo54yTjkukXpqSjVGzIWgbo4Muap4rTyk
         8p4/AtVR406MTvq7rTR5IoJ6I9S07SjvJHm8sY9cLTR9b2q7feOYnol9kJU0M/nd4ruv
         opjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434488; x=1732039288;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbAitaWBPhoWxH4bj4NOaD1/IoLABk7tVUOSRiI/Nhw=;
        b=wPT4PUDpGSq/uYnGhqmlAKAyIAvOC0jR0NH610rNlLEPycKgsMSWpj5dlJdIDhOjes
         FmByiDVOZO8Vol+dDHfmR+E61soLxRPNPVNbc/mUwSIqrwd1xazLZD2bD289YZaS4ZqT
         1iBgVpyFxDbodDrh8W9qvtbw4GChKtmzV4C3rXD8pNDWhkLIpApuS6jn8eF7zNxheIsI
         JWhNnpDVJClm9kfRqASzAXZrIwkZIzSzAiE3mh84U89c6hhykBbPwEqNqEhwq9S+Hmtp
         bOzIRJLoG1I/fatYzFAFaQyooGEMneZqxOvE0S+CbtBIeY2S7JQHtrWc8Ig05PIt8TiI
         vKFw==
X-Forwarded-Encrypted: i=1; AJvYcCXYfirgSL+j6Dc7C6Jd3+Qptrqno4V5qUIQ8lbfL6IybqcMsWJcEAG3tYwjEvPyIbO9R/fft84Tm0I3IGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3s47CAbHxFqIT3E+c4+69AGHOZxbmm7Rsoqp3HM3WpUv0OyqC
	45UnBnTAvDrNQ+8LIee6q0sDunTgG4ao3BQWLap0VO8/J1ttt8e37OLZ/gOLmQ==
X-Google-Smtp-Source: AGHT+IGca3hgSODbdD3FEl5POWQHtDbW0nz1PIxvyp10V1YZFiQ1NdV6ppvh4sdUZbzacBs0F6PQjg==
X-Received: by 2002:a17:90b:4d0f:b0:2e2:e91b:f0d3 with SMTP id 98e67ed59e1d1-2e9b17730f0mr22453864a91.29.1731434486819;
        Tue, 12 Nov 2024 10:01:26 -0800 (PST)
Received: from thinkpad ([117.213.103.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a4f6cacsm12941914a91.10.2024.11.12.10.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:01:26 -0800 (PST)
Date: Tue, 12 Nov 2024 23:31:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/3] Allow specifying an S2RAM sleep on
 pre-SYSTEM_SUSPEND PSCI impls
Message-ID: <20241112180118.pcn7sf6r3mswwwxf@thinkpad>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>

On Mon, Oct 28, 2024 at 03:22:56PM +0100, Konrad Dybcio wrote:
> Certain firmwares expose exactly what PSCI_SYSTEM_SUSPEND does through
> CPU_SUSPEND instead. Inform Linux about that.
> Please see the commit messages for a more detailed explanation.
> 

It is still not PSCI_SYSTEM_SUSPEND though...

> This is effectively a more educated follow-up to [1].
> 
> The ultimate goal is to stop making Linux think that certain states
> only concern cores/clusters, and consequently setting
> pm_set_suspend/resume_via_firmware(), so that client drivers (such as
> NVMe, see related discussion over at [2]) can make informed decisions
> about assuming the power state of the device they govern.
> 
> If this series gets green light, I'll push a follow-up one that wires
> up said sleep state on Qualcomm SoCs across the board.
> 

Sorry. I don't think PSCI is the right place for this. Qcom SoCs have a common
firmware across all segments (mostly), so there is no S2R involved and only
S2Idle. If you use PSCI to implement suspend_via_firmware(), then all the SoCs
making use of the PSCI implementation will have the same behavior. I don't think
we would want that.

For instance, if a Qcom SoC is used in an android tablet with the same firmware,
then this would allow the NVMe device to be turned off during system suspend all
the time when user presses the lock button. And this will cause NVMe device to
wear out faster. The said approach will work fine for non-android usecases
though.

I have a couple of ideas in mind that I will post to NVMe list itself.

- Mani

> [1] https://lore.kernel.org/linux-arm-kernel/20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org/
> [2] https://lore.kernel.org/linux-nvme/20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com/
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Konrad Dybcio (3):
>       dt-bindings: arm,psci: Allow S2RAM power_state parameter description
>       firmware/psci: Set pm_set_resume/suspend_via_firmware() for SYSTEM_SUSPEND
>       firmware/psci: Allow specifying an S2RAM state through CPU_SUSPEND
> 
>  Documentation/devicetree/bindings/arm/psci.yaml |  6 ++++
>  drivers/firmware/psci/psci.c                    | 44 ++++++++++++++++++++++---
>  2 files changed, 46 insertions(+), 4 deletions(-)
> ---
> base-commit: a39230ecf6b3057f5897bc4744a790070cfbe7a8
> change-id: 20241028-topic-cpu_suspend_s2ram-28fc095d0aa4
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

