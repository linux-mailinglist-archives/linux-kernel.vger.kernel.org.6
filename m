Return-Path: <linux-kernel+bounces-360861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2685E99A0A5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C8B1F24F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1F21018B;
	Fri, 11 Oct 2024 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8ytZvPD"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9F20C462
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640916; cv=none; b=E/vvZEqVMQmtUQZAYYSRZgk7q1OZ+eU6velNQbnG1SNjfmhxOu1yJSDlXc0D0t7rO8/MxvOYulTmN4g5deW05lrY8mh4GEIhQL2RwzN3zkGUlSaVjvM35/JdJ8R8Lgo1kWCqy8xYiA8dzVyj8ZxPmCmXRddCTJlPeVClYb9xSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640916; c=relaxed/simple;
	bh=jsyNTz8SHA7nxe3/5MPyH26re/WNrInxe546jVpWsmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5tqxKhHNUPBkoDpDLRzeM9/HDhsIiHh5sNW/RsOeT121OmtT+po0e7OPvEVUf8Fl3XRnKwtPmTdxrK8Mvm8ZSxAbgwrZotxz6UlKNoFh4jBHNDRTuoMpT52wZ2kHWtDeVeZpm02eSdGQNg4DTvFehJpvfVzDVLGocvMPA+FMhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b8ytZvPD; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-37d4821e6b4so1002026f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728640913; x=1729245713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYmgZL38NDm39MG1prjLNzZFwsGRIsr31TKe+HTiJcM=;
        b=b8ytZvPDQHWDncTsKgs6aPE+yT+wIPGzwASn/ZlkG7zQeOjnCNFJRYEGkhikeAOoPq
         nEh7PGArkitFT2//+ThUjSyGqGoLwOTzYex8Mf4r0ASMW3mMo7PAOAMRWbkdPvC3A5dA
         zbFMIUITq+gqrqXWRj6aQTDu1ExHhMzg0sKXTn8n+wrsDl795v6w8deUJ0LOI5yeXQrf
         RrncudmAQKtwsbzazYKw3D6r2/DGGHzzKA7ongptobJY83oa21yIIKoLZiWWsmkLvgbo
         2gImM6v98gcsa0nC8HY5VT3ZE7ECAnCzZSiqA0qQUZPEpLms4M7XGd4gwRAJz0HKc0LP
         C2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728640913; x=1729245713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYmgZL38NDm39MG1prjLNzZFwsGRIsr31TKe+HTiJcM=;
        b=FmwNxNjZDWMPUOsiTwmUesQ9uf6FPFn0XxGmZ4aQmm3S2AMtyk6vIOMQMqkPBs/AQ3
         J+gKauvWOus3dELkFoELvM1OX13vm/zI3nW9GhqlJZCbvgIArSHNGDpzLLbk6ilo6FvJ
         L9v2DtWjLN/DURmpoZGA0IpMA6N+IMTPqaeTbwmljTWjLxg8jF454p7kY4Mklh0Gr6Yk
         ezk2pKLabDLrL7BwHXN8xTxtklPESz8XMf9mJ5aCUnLAILB6clwNGxqwhFnGmknOfcJ4
         0wMAaiE2PXkBNGVOkdp9MIQfJe99rUp7HA9NKX++nOf9hVBfeRAzwr4nLlzGOxncLrGC
         kiyg==
X-Forwarded-Encrypted: i=1; AJvYcCXJdkEdKhCFb9jOLWfwMQ/qUaz83A1fxjf7YHh4E5AUp1EQCOI/K6dgmvyyrLfctCv2gIz0rzPUW1FMaoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV25op2P51ocJyl249VbiLsxMgUT7yg7bhsjJ2sMLqEgleQEfj
	1eNnKBIeym4D7qc1Ma0tnwa+nZoqg7HJN4OhneuFmoZ/LuoPywb60pZ8gWsvGCo=
X-Google-Smtp-Source: AGHT+IF0ytwGCNwotFa0kqIscorptwHA73zjxzrHv0mhxbNPlHAg7bWkMb2p5Q+EtDwDrN6aPzUudg==
X-Received: by 2002:adf:f98a:0:b0:37c:ce58:5a1a with SMTP id ffacd0b85a97d-37d552d22efmr1416647f8f.54.1728640913296;
        Fri, 11 Oct 2024 03:01:53 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef80:63d1:4749:f717:d9e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d790fsm37618915e9.6.2024.10.11.03.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:01:53 -0700 (PDT)
Date: Fri, 11 Oct 2024 12:01:48 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Chris Lew <quic_clew@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: mark pd-mapper as broken
Message-ID: <Zwj3jDhc9fRoCCn6@linaro.org>
References: <20241010074246.15725-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010074246.15725-1-johan+linaro@kernel.org>

On Thu, Oct 10, 2024 at 09:42:46AM +0200, Johan Hovold wrote:
> When using the in-kernel pd-mapper on x1e80100, client drivers often
> fail to communicate with the firmware during boot, which specifically
> breaks battery and USB-C altmode notifications. This has been observed
> to happen on almost every second boot (41%) but likely depends on probe
> order:
> 
>     pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to send altmode request: 0x10 (-125)
>     pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to request altmode notifications: -125
> 
>     ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI read request: -125
> 
>     qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: failed to request power notifications
> 
> In the same setup audio also fails to probe albeit much more rarely:
> 
>     PDR: avs/audio get domain list txn wait failed: -110
>     PDR: service lookup for avs/audio failed: -110
> 
> Chris Lew has provided an analysis and is working on a fix for the
> ECANCELED (125) errors, but it is not yet clear whether this will also
> address the audio regression.
> 
> Even if this was first observed on x1e80100 there is currently no reason
> to believe that these issues are specific to that platform.
> 
> Disable the in-kernel pd-mapper for now, and make sure to backport this
> to stable to prevent users and distros from migrating away from the
> user-space service.
> 
> Fixes: 1ebcde047c54 ("soc: qcom: add pd-mapper implementation")
> Cc: stable@vger.kernel.org	# 6.11
> Link: https://lore.kernel.org/lkml/Zqet8iInnDhnxkT9@hovoldconsulting.com/
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> It's now been over two months since I reported this regression, and even
> if we seem to be making some progress on at least some of these issues I
> think we need disable the pd-mapper temporarily until the fixes are in
> place (e.g. to prevent distros from dropping the user-space service).
> 

This is just a random thought, but I wonder if we could insert a delay
somewhere as temporary workaround to make the in-kernel pd-mapper more
reliable. I just tried replicating the userspace pd-mapper timing on
X1E80100 CRD by:

 1. Disabling auto-loading of qcom_pd_mapper
    (modprobe.blacklist=qcom_pd_mapper)
 2. Adding a systemd service that does nothing except running
    "modprobe qcom_pd_mapper" at the same point in time where the 
    userspace pd-mapper would usually be started.

This seems to work quite well for me, I haven't seen any of the
mentioned errors anymore in a couple of boot tests. Clearly, there is no
actual bug in the in-kernel pd-mapper, only worse timing.

Thanks,
Stephan

