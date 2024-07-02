Return-Path: <linux-kernel+bounces-237413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31E491F0BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39A31C2149A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D567C14A4ED;
	Tue,  2 Jul 2024 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMhMwAIv"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72213148311
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907434; cv=none; b=llGo2qPD58jeGGRUBX26inCdHSeIYJTtMkJErcTLMEM5ZSXiygA24O1QjqhAVr1umv32c5MWhPu/OW1VT8eU4B0l56Zpg+jD6Bv1wGmi2dXRqgjhQCHlo6UuwxZqgDfjkxfBcVKMapoe5NXpZvHsRnaLscQ0iM5m0ufPCY5zQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907434; c=relaxed/simple;
	bh=b/wmykKwVxbhO5h9j19Pvj79GV8/eI9inxecTME1l/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPZcW/0cr6h4xYNbrnlAM9nmsHl1tmuubqMRZo1Z9v/WM1xnGMAecTg23QdbcGZeckcJ0EQv7qU3zPouwBJwpvgexLbW2aQ9HS4Lhs/aX3T7h2qs3mikVbu4hH3uLd6+8JXKNXRK7YdpeK5OQ7k/Ohm3zRpTYxiJeOHklVNJ8G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oMhMwAIv; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so45507281fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719907430; x=1720512230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LAM6lIuRtsvCZNgiIxZSTOFr184re6ASNS29In5f8g=;
        b=oMhMwAIvZYMh4WI7lJoFpxtiVJoYl3l5oXQSlEjPyI6et5LNARcv/6Oz3PR79Oa0EP
         6hw4TcE2PYgmdcP0ywFwm74IBEsOljmbkqhBurFMB/dW6TF5dC6vPlw6EerkpdjQqPVD
         m0EQYbWOVrgZGKqSEVdq5iidXGW1wEqNiB9WusoBX8nwu25AL/u1yLkqoAh4azDVUhJN
         blFmb5fyWymsnuX31Qs0AfTr8iOtFkl9lmOB3wCR7nCyl6BwkcYyIIVqFhmc+LOtH4Y6
         HsX44vGLVL7GXI5fa9JImeAIx6vRcJq8zH4Yb5c3RhOGKByt81s5rYeZVR74tOQ+sOvq
         XDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719907430; x=1720512230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LAM6lIuRtsvCZNgiIxZSTOFr184re6ASNS29In5f8g=;
        b=k2M0OLRsnqggMnRQ8VXf9UdevVcorhcwmbunBXppO2MSkk2mhFPV949/Vy3dAIFnC4
         p/YYTp9nlAs2JUY8D1YN9WXnYbk0BQdHG8IODXhpikNx0ach1I/14D+VnrEfQvQLYWTV
         lrfUyLrU1kiSNtBlQ24/scJ8aZ0fxvibCwCdAFcNCd3Z6EUwDN8FmEMfCgxLLrK24KzU
         cYXICsZiv5/WBTaNrg3WHLsIjKeVGbS68QVRHOY1salfvKY6c6Vq7hOg7OLKh95OCwHg
         s/ZH8H6J7XPTVrurAEYib+/or1pmM8gEMPTW0E8V/OvG9F9tnj2WflyBKZuYXQSaA1vj
         fYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsRmcvDgbFkHIxOftGetR/D/vtd0+ecTPLBWAEhZ5FxO1BQUCrMPTfS7wMxIbk5ekIp090YbrDO6vMr2L4j+MhewVL7YcBSWjKOOPZ
X-Gm-Message-State: AOJu0YzaVoBFqpfTCi53IUjl0QgA+1gQLXxBbiJd01sFCplCM8VzjRTv
	APQwltpJpsFZlAC8OeaillBKAiNVkAf2dseS+eakb01lVRVBRUr8lL9O2QAB9h8=
X-Google-Smtp-Source: AGHT+IF3ecEAZvC/pQ2gIHHNnpG1wqrG6SjuqFnUiYhmdot/hwZ/XHb/8hTTHi+H/mXFV5XzZdj6Qw==
X-Received: by 2002:a05:651c:220e:b0:2ec:174b:75bb with SMTP id 38308e7fff4ca-2ee5e38103emr57141381fa.28.1719907430551;
        Tue, 02 Jul 2024 01:03:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5160d26dsm16306991fa.25.2024.07.02.01.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 01:03:50 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:03:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sudeepgoud Patil <quic_sudeepgo@quicinc.com>
Cc: quic_bjorande@quicinc.com, andersson@kernel.org, quic_clew@quicinc.com, 
	mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org, quic_deesin@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH V3 2/2] soc: qcom: smp2p: Introduce tracepoint support
Message-ID: <sgrgxfkvqnjeaiovvt665klmse443vkmzncb4jcun6oa432chh@ogaidyok27wf>
References: <20240627104831.4176799-1-quic_sudeepgo@quicinc.com>
 <20240627104831.4176799-3-quic_sudeepgo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627104831.4176799-3-quic_sudeepgo@quicinc.com>

On Thu, Jun 27, 2024 at 04:18:31PM GMT, Sudeepgoud Patil wrote:
> This commit introduces tracepoint support for smp2p, enabling

See Documentation/process/submitting-patches.rst, "This patch".

> logging of communication between local and remote processors.
> These tracepoints include information about the remote subsystem
> name, negotiation details, supported features, bit change
> notifications, and ssr activity. These logs are useful for
> debugging issues between subsystems.
> 
> Signed-off-by: Sudeepgoud Patil <quic_sudeepgo@quicinc.com>
> ---
>  drivers/soc/qcom/Makefile      |  1 +
>  drivers/soc/qcom/smp2p.c       |  9 ++++
>  drivers/soc/qcom/trace-smp2p.h | 98 ++++++++++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 drivers/soc/qcom/trace-smp2p.h
> 


-- 
With best wishes
Dmitry

