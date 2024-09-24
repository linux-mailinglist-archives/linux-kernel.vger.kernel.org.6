Return-Path: <linux-kernel+bounces-336888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA8984229
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50928B29A46
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F13E15B562;
	Tue, 24 Sep 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmkJApUU"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0C482D8
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170211; cv=none; b=d4RUOh/WiXUs/YwT5fVNrkWtw8bMtdK7nJ+Mt/dTFJj8/TxLA6CigJQ0cC0cdwC0sCVR+n/pZPSm8YK74bfbJ6VYBBVzs8hzz7/HYupDcSuvSuWmi+RynvCPAg1xwZCDZ++DTClouZnL4YEb2WeyOVCHTILn+83DAlz2sEnrA1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170211; c=relaxed/simple;
	bh=D9EswOqiqhUmyazA4KSqUyleFgA9CFWsFjHCBSn5T18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGpafaLAhS6QBlbqjlofZyjG8VQUatPF3IyIabqqrkxSaZ+feFq41DDcbBYzJ/u2I2a3T6156pb00Q3Lu6POwsEyQRia6twRVJsR088CDH6cscwygWXRPTu41XduO3WszFk/1a9jNsEjVSvMApQGC3k8Vx0Ix5ZCEbgz0A8M88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OmkJApUU; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6d6891012d5so41603707b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727170209; x=1727775009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8kwPgjt8pfHw9qOZJaljveWnx3eebWOuDbIf6OHB4mQ=;
        b=OmkJApUUI4tDixiUq0zTR378PYtpZle/0QulXLWjKKO3IxCOcLjPbtQCIqaqGhKH62
         YX7Rebvo7n/poRm4cluhWiXonnL1CFI8Fed0Rh7n2DVAhgL492G1eJtOSNLC36rl3/tm
         5FmxRlbVyTPhO1vBBG1dQtt9FHwPRB8Nb+D1p5ZksnVWEG+0WGc1aDgw02d1p2TDSNo4
         z9BUXVh9BAqixKL+U/fH/A5FW+aUzssKDMNFsYek+41OMk9AGquEnuKiLXN7tWSpBB/M
         N0tm2PS0FqwLly2t+/j0r90GhlyYQcnGsy2qW8GGrUwEyrXAt/ROmb1Nk1VzYqMM3B79
         WDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727170209; x=1727775009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kwPgjt8pfHw9qOZJaljveWnx3eebWOuDbIf6OHB4mQ=;
        b=NQTNmPZnDRricVGTZYrKOmsy+sesqmLA49haNiWWfKHkdCiK7FnKTtvzlJViicwwa5
         E1K4UI/hCF2nEO5lVZE5k7u23d+Oxsu2aXyN7yo0M0BmOhc5Ve/yRTWbhssgmvgL0iVQ
         0Ai1+6QsmMtz3MoTBVBRQSGPFj6Qe10j91cH2CGiob22lLByPA5EsOWQv2B6uBgNaFxe
         O0s23ssotWCC7HbTnGZU8VP4WZP7lRq9bHuXbMMyC9A+5MHpGftGwpai+qcnkZE5KLYJ
         JRCAmvXKLwUedvepe2RDG0/kuvmQ1oIr7Q/jEHFotDSilHiG+bMV03o/ZslqK83OYOAb
         rL7g==
X-Forwarded-Encrypted: i=1; AJvYcCU5am5a576BGXg+ulPv/EG0P/HrZyPEB+GUqsOGpzoPNZavyV/VAKghlAzRAGGmDRSVJbFHa94ZFDbLYIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu1HD3o/m4kswJvxrctEWkG1DLvhF1FJ1x3PHtfFrApS11a+ZQ
	eP3hPQAdq8tjGIU4QWQ2lQwjXWDhDR7BmAmh+pYiGJ4gFvYvrn+IzT00eV6A1b5yiybNp3MFomO
	r1CszG8hzcsTJ+uFknJ1ysiCG5GVz4FbCqMheqg==
X-Google-Smtp-Source: AGHT+IGGjL0PjmJwK+q9XNzEAEcnxsNe39x0IxIT+lUqKXaanQ7OpypWTWDtEP5guxmNY23cZA1AKXRyim1O0ks/Rlw=
X-Received: by 2002:a05:690c:6f0d:b0:618:2381:2404 with SMTP id
 00721157ae682-6dff2d2ec2bmr131066837b3.44.1727170209158; Tue, 24 Sep 2024
 02:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924092033.2626-1-quic_jinlmao@quicinc.com>
In-Reply-To: <20240924092033.2626-1-quic_jinlmao@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 24 Sep 2024 11:29:58 +0200
Message-ID: <CAA8EJppugcJC8nk8C0u9D=WcO8_MVE5aHC+1nNfxWNfCAvNBYQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable Ftrace and STM configs
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 11:21, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> To make software trace sources go through STM(System Trace Module),
> need to enable STP (System Trace Protocol) protocols and stm sources.
> Refer to Documentation/trace/stm.rst. Then software trace logs can be
> captured by STM over TMC sink path. We can enable software trace(Ftrace,
> console) logs along with HW trace of coresight component. The timestamp
> of software trace logs and hw traces will be in sync which helps to
> debug.

It doesn't looks as if you've read the file that I've pointed out previously.

You must describe why your changes are to be enabled for a random user
(not just for some kernel developer or hardware enabled). Do you need
STM and FTRACE in your distro kernel running on your laptop which you
use for the daily work?

For reference, CONFIG_FTRACE is enabled only in 2 defconfig files (and
explicitly disabled in 70).

>
> Changes in v3:
> - update commit message.
>
> Changes in v2:
> - select ftrace config explicitly.
>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 4a3999eefa67..c0a56e58e554 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1554,6 +1554,12 @@ CONFIG_NVMEM_SNVS_LPGPR=y
>  CONFIG_NVMEM_SPMI_SDAM=m
>  CONFIG_NVMEM_SUNXI_SID=y
>  CONFIG_NVMEM_UNIPHIER_EFUSE=y
> +CONFIG_STM_PROTO_BASIC=m
> +CONFIG_STM_PROTO_SYS_T=m
> +CONFIG_STM_DUMMY=m
> +CONFIG_STM_SOURCE_CONSOLE=m
> +CONFIG_STM_SOURCE_HEARTBEAT=m
> +CONFIG_STM_SOURCE_FTRACE=m
>  CONFIG_FPGA=y
>  CONFIG_FPGA_MGR_ALTERA_CVP=m
>  CONFIG_FPGA_MGR_STRATIX10_SOC=m
> @@ -1663,7 +1669,7 @@ CONFIG_DEBUG_INFO_REDUCED=y
>  CONFIG_MAGIC_SYSRQ=y
>  CONFIG_DEBUG_FS=y
>  # CONFIG_SCHED_DEBUG is not set
> -# CONFIG_FTRACE is not set
> +CONFIG_FTRACE=y
>  CONFIG_CORESIGHT=m
>  CONFIG_CORESIGHT_LINK_AND_SINK_TMC=m
>  CONFIG_CORESIGHT_CATU=m
> --
> 2.46.0
>


-- 
With best wishes
Dmitry

