Return-Path: <linux-kernel+bounces-318004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D9996E6FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB504286A05
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F4C1A28C;
	Fri,  6 Sep 2024 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AiPQSMK3"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390AA17991
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725583934; cv=none; b=ieVFo+hZUafsaAbrpL8fMh8Wf3FwFkEHzWh1uO8LpnMeFqZ6d1zxOK2fzLCFLC4pYBA2yV6k1sSFXF8PBSepBCxf+/90tudfOWD2NtpgSZ6YRUPw6DpBxp7tjJAfUG92ktdeihaaLbuhb92vaA9vmlQ1u7ZxqjIf9Ne41tuCTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725583934; c=relaxed/simple;
	bh=jIgbO35t0FjK78L3vHKAhnfNwuVwbXjQi1f3jtHTYhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LE8rP15/zdmY6WeKBmTcyfOJM37OXTj2d9gVsgmhq4frLWTirdEQMDLPI2sLJ09InBWB4nCqrg0lTPnOQUCpeW6psKOT+vuGrdeF0wbO+zFHQ9qKnL+OCDWLGzdHUGUZCmYwLH7f0umrwsxDLOA38TqMmuRO/YS6Big8b2v1gq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AiPQSMK3; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3f0a31ab2so17004381fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725583930; x=1726188730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k67V4d6U+a4ymIwtTxfSVTqPn5Mjm51cyPX5ZzN9RPQ=;
        b=AiPQSMK3q+Qb8+GD9oePIIoeDrrwLq4L7Oo2FkiQ2GIp83VASKDp0TX6rCBD8SIwii
         BzX0MrpcCzNnWF8HQCuGLhPU38CRJWpsXedX58/IbaNY5jgxXUMfePdoDNlt+L7u32ru
         L4axjuMwSvwTWnyMTZvi76aektq+K6vQNi/eQE1hpu57dduaAm5xoP7J9PkfhLntJOf4
         Fczin0R4fJt2H4CdXt41jct+RCwZ0TH76dPDtM+GtZ6ACVnCoMc8Cg1ggnoaP9VLX2ao
         WjXuEN3cPw/jxu3jpRqSndsmmXlz3sPMzsKSTCUedA+aiURaDlqhaZs/5vmeV2NClQsp
         NppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725583930; x=1726188730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k67V4d6U+a4ymIwtTxfSVTqPn5Mjm51cyPX5ZzN9RPQ=;
        b=XjMnV0/mLYKUAZE0Ox21TKBcOwkGOJLCvyqFCItx287iD7MIyXc7nwT0gl7Z4Nbd6i
         S1L36PoqLpc/ZXs3dpR5Sn53xapjz88eS1SCvAYYq5zasz6Sy3kpzxMg8C8UmBEy1zg+
         13vdsWEINTS7GkPMvR/85TfIxTCbfkOMHN0EGwJa5i9OG7btwaK+NUMCONW+noXydyMs
         m5b1cddKBZoXL1MGnA/Kabou7x/IAciskpd0xI68H3vuCG4viMszI0/gvqKcJu02R6Wl
         piX9TNZBqxTzrMuZMqmUwiNPHeYF8JgzzMyvGUqu2LBnuhGxrwZsU5A01W7HriGMF96+
         RfDw==
X-Forwarded-Encrypted: i=1; AJvYcCX9DY42qttCaE+penmm+fpwUN9+ioBgy2scMWw7irXGmlusMbwwDbIGLo5yeUPOmd1SlpbwGcx+PBn4fDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK+jA/SAfwYz7PmfydtulcsqQ01hZwP8yjgrVTX4alFZadZg0F
	IyqOUOmpFD0pfIAZIKqTP/6g6BKhYDLAKus0bdbjcSiWVKlrebfhXgWYEgIIncs=
X-Google-Smtp-Source: AGHT+IEo6pJRSCOhheQ4SHdYsdjC/ga3+gMi/ZowkV+pSmPbkIvf+DoWz4LWwxKdAClAIbRTj5eadg==
X-Received: by 2002:a05:651c:2226:b0:2f7:5239:5d9b with SMTP id 38308e7fff4ca-2f752395e50mr3013471fa.4.1725583929638;
        Thu, 05 Sep 2024 17:52:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614f37dc3sm29897021fa.59.2024.09.05.17.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 17:52:09 -0700 (PDT)
Date: Fri, 6 Sep 2024 03:52:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Brian Masney <bmasney@redhat.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, 
	quic_omprsing@quicinc.com, neil.armstrong@linaro.org, quic_bjorande@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ernesto.mnd.fernandez@gmail.com, quic_jhugo@quicinc.com
Subject: Re: [PATCH v3 2/2] crypto: qcom-rng: rename *_of_data to *_match_data
Message-ID: <264n2b4dwknzxs6dyce5kmhxy2i6bzybuur5n6kqp7rhwy3r5g@7gcz5f2ym2au>
References: <20240906002521.1163311-1-bmasney@redhat.com>
 <20240906002521.1163311-3-bmasney@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906002521.1163311-3-bmasney@redhat.com>

On Thu, Sep 05, 2024 at 08:25:21PM GMT, Brian Masney wrote:
> The qcom-rng driver supports both ACPI and device tree based systems.
> Let's rename all instances of *of_data to *match_data so that it's
> not implied that this driver only supports device tree-based systems.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/crypto/qcom-rng.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

