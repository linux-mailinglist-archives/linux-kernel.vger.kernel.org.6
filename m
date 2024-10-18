Return-Path: <linux-kernel+bounces-371583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B129A3CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539CF281323
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85706203705;
	Fri, 18 Oct 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FH1LdWY9"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507121F12F0
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249770; cv=none; b=revSUwRa4b1f+vIl8ShkV9tC3LCiekRu93GkOwW+7tMHhm5sJtuhSGSkm0Qd9ijErgFJ8yGdXMnjyJ7n5Bn7pvsg8/NcEQD8ptBL+JD0EADJ99BNfmKnfodAujUdH/nXOLKEc1gHcXvlvaevdOQzFW/9MO/414qxttKWf7kcOxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249770; c=relaxed/simple;
	bh=hIRhsvJSIxKZNH+0yh8CMfYQrQrPteNJdkQamPRSlyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMABSToiSbfJBN6Bxl1vQ9WWJmBrMMvOtO8BLNW/MB/xH+ZblxnGDNb7+H2WLvBHObTdjwOHG5y7mIBUrwDC4UpRWGJ+vXJgG6fs+ksdGgB0saNsf50UtUvJlWtqdKnee0ju+uZmdp/YGJt0R4Gt6iWdweC6q9Sf47rbJUSxpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FH1LdWY9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539eb97f26aso2374904e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729249767; x=1729854567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XIt2ZgCz6/2u04try8W/s+t9Roe8RkNgbgiZjheFS+w=;
        b=FH1LdWY9YLpTuXCq7TfzDZZcykgIwMOGrzwa98+sU0/yhfJKlOrqnt9YQZH5OJF2JI
         m1xVdqAehwL1RS+VwR2rp+0l4F+gUeCPVMtUYKsJxtlqtgLsC8KQnxiOUjP3LHGxZhDe
         He7Yq8lR0NtrXjbnxQwfyZuLGouxhmb0dtLVQyPDC22vzqtQWD7bKz3cU2C5PWiZ29rL
         9jZtXM2G2QUlpTsTi68Eyjr9RPpIET9a2TKRLZ6L5x1Ecn8AKd0goNARxBPxGfdA3qo/
         bgCIUgQ2HFIQwkxHYUsGnFmvGwG7V3cXIhls2X/OAor5u3MTsvXytBoMPTRge+nVYl79
         8IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729249767; x=1729854567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIt2ZgCz6/2u04try8W/s+t9Roe8RkNgbgiZjheFS+w=;
        b=e5DNzwisHsFybYMb+T4qb81BZqxWQALRiErBE57jKQ9lnb1Jb2WrmPnIEYZnyD4cHl
         /ShV5/+RTfXsJQvjRd/rsc+Ub5brjid5nXeZZ9xvJz7AMB7vU3o1gOWpngVNN1S9O6hs
         nwmUjFTQJLXF672ih59dgOaaleJHOdB5umYZnCU77oGdJggZJoPywvG3l0bfbJ4UzRvU
         YENR8Dws6xZrgh0BA2EJLj7qKXV9wmRXf93ytXKTR93S1TY5mn/yo8NYN4Ezq1UTkof1
         x9ysZwRtlRvGCEBZzVoFRvBkaRN+mRZhLQC3DfnMsOUw7nN+VxpYsd+CMiGcSuwDSLXt
         t7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCX6PxJiHeBK81L3wq8uSU1pbet773A2nrOJRU/so30MjftDuvABbiP2dFrDa+FzNGYH/qmS8VaRMmiuYrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrWv5EQtaZiRKRiMWXwcTv/W2IKtTpPd775st3kWjv/oqMVfrl
	liOzci046VDvLEamT3MUfu/Uv7su5xN4Xt2kLIjZB1FCkfO91xy0vmAaNO7LyzW0iIX132ZIZYG
	7SBw=
X-Google-Smtp-Source: AGHT+IGQcoRjkME8sB/QzR808hEBcFeX1bRQ7Ps+vQJxPs0k7IOBUWWNJ5veYpKKDLhJoGJiAwODNg==
X-Received: by 2002:ac2:4c48:0:b0:539:f699:4954 with SMTP id 2adb3069b0e04-53a1546ca04mr1270371e87.58.1729249767449;
        Fri, 18 Oct 2024 04:09:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15214e7esm190571e87.259.2024.10.18.04.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 04:09:26 -0700 (PDT)
Date: Fri, 18 Oct 2024 14:09:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Balaji Pothunoori <quic_bpothuno@quicinc.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ath11k@lists.infradead.org, kvalo@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] remoteproc: qcom_q6v5_pas: disable auto boot for wpss
Message-ID: <ho24wc35ssaecs4hqqbyuqizfamr6fffrzp62v6eevprzbjmx5@qx7urvuaptqq>
References: <20241018105911.165415-1-quic_bpothuno@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018105911.165415-1-quic_bpothuno@quicinc.com>

On Fri, Oct 18, 2024 at 04:29:11PM +0530, Balaji Pothunoori wrote:
> Currently, the rproc "atomic_t power" variable is incremented during:
> a. WPSS rproc auto boot.
> b. AHB power on for ath11k.
> 
> During AHB power off (rmmod ath11k_ahb.ko), rproc_shutdown fails
> to unload the WPSS firmware because the rproc->power value is '2',
> causing the atomic_dec_and_test(&rproc->power) condition to fail.
> 
> Consequently, during AHB power on (insmod ath11k_ahb.ko),
> QMI_WLANFW_HOST_CAP_REQ_V01 fails due to the host and firmware QMI
> states being out of sync.
> 
> Fixes: 300ed425dfa9 ("remoteproc: qcom_q6v5_pas: Add SC7280 ADSP, CDSP & WPSS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
> ---
> v2: updated commit text.
>     added Fixes/cc:stable tags.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

