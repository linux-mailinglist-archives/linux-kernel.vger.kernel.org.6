Return-Path: <linux-kernel+bounces-334070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B418C97D246
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF20C1C22631
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D597B69959;
	Fri, 20 Sep 2024 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3C7+7cn"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C1218EB1
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726819859; cv=none; b=F1v6CBjGR0s6Qb5WHJj1MgaFlUs1DooXUZaK77aqYkGKNaGUSmXvp36oZ1h6Ro6JxnL+T0CHSTzoBF4eYK6d5hxhqIK6BiiTki/MQsAp2JpbdXtCbhIKes+0AMCIn9+ckxCkD0QAvv05G6vtNt7HfaQqKlZYpsE6WXI+QmoSjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726819859; c=relaxed/simple;
	bh=uhXbFq8gdZ2ouyL/m9MKMTRJUOP96jYL2Q/O2Zi59Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsTMIM23JC8ZsGjqfhXdnNkBCpyhcVcpnMBLSVE/2Q9PuQ78juYwrDY8ECnRc3NQNvIILpmiMlKWcQyqlXn/Y9J78tx4EvTp7WGDte+ni47RorZSrhoeAcF9yDxl0xTv+M9DXJdDkSL9KZmeIaINN5GRo/nXKXRj1jylS8t4Jvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R3C7+7cn; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ddfdeed0c9so14863917b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726819856; x=1727424656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QAx74AURDGHuXTdqCWkFDBVlw9v7Z3zu5Hmc9mIJ5s8=;
        b=R3C7+7cn5FFh81up8lwqKnLBmeQusri4fMOuBIA9a6uOTCqvOxsXVHNNLAdQLqtROY
         k7ikVfDC0m91KPZhpJqRTT/GF3++SRId4PASbNLOX2ZIH0CNyXbhnE+NbutiY8lDj9RF
         BDC8hMxTIV4ACD5K5Pty5Pj+BjOVPj6EiA55gcvnn94payoCkrNj5CA5xSvq+aBwKWuk
         QyigUUMzaWAipPYWshoUGawCIhW7/4uTRSq0BdqxVQU0h7KW5C/opm02vNFB+WxUGiOm
         kXGGq1snsnJz0V3hFNA9SrsJCwx9tREeaUznZZgp4XimXUHFHe+B6aKVYIYSxZ4HIJpi
         wOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726819856; x=1727424656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAx74AURDGHuXTdqCWkFDBVlw9v7Z3zu5Hmc9mIJ5s8=;
        b=T1rlecJpna0EVY1f63ABfs8ObBdXdbCejCvnmeA4Wnj91XLOSb2YqPdaLY2MGyPjUK
         k/3HiKkaGH8c2p3MVa/L4nTVQMzvTcz7gb4g1enY/kMstmawzl9crFPIuaXQdD9x/HKi
         2R/aC3EdK9W2UUesm3L69BwEuXlv93XSeOV9s+j6I4miL1hLD/42xIoXGJkUBZjNEMEQ
         RzrNrId/ilEVOQieeZUtfbnbAYHH+jaiEcQ7BvIN9qMfRowKEowjMVjOIJTpAZAULw8G
         eO/vXmLPBRoYlhfB8dvHOtgJ/D31JHdFonnIPK9+nVZ5MvGQ8VLO2LKk/0CcKg3E7S3H
         IIow==
X-Forwarded-Encrypted: i=1; AJvYcCVp/JO/O4+wPgvbhysoJ8GiASQwmjGnRS9zSkHvxBnpkL98d45opwdag+bQiMOfMdtRG6ZOtgzy6s4ch+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIcHrLkUKjDHlClynV1XIQJ73xLKYyNn115Sy8giAy3v8DcmS
	qlEKEJMqMy0G0F3wcWTnLg32qS5c8NhXrPnfmK+C9rQWAgSUvxGeQ632dKBxdM0IUN6PGdE1fcZ
	AA35bBGLX2us0tBwAeakHL0JjVkTue4biCVjzWQ==
X-Google-Smtp-Source: AGHT+IFyUoCHJ9pKmMCbefdpFZcNBvA8xvQey5jC89NmExx2r83qi6xqdYU2QWsfTDK64HSz+UG4mwpDEY9D3DnxjpY=
X-Received: by 2002:a05:690c:6207:b0:672:8ad4:9461 with SMTP id
 00721157ae682-6dfeeeeb16cmr21388877b3.41.1726819856635; Fri, 20 Sep 2024
 01:10:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920075905.19441-1-quic_jinlmao@quicinc.com>
In-Reply-To: <20240920075905.19441-1-quic_jinlmao@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 20 Sep 2024 10:10:45 +0200
Message-ID: <CAA8EJppY4QXDWK1QsrorQM8NTOmi4cK_Fjhkzf10muRE85BQ-w@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: defconfig: Enable Ftrace and STM configs
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Sept 2024 at 09:59, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Ftrace logs can be captured by STM over TMC sink path. We can enable
> ftrace logs along with HW trace of coresight component. The timestamp
> of ftrace logs and hw traces will be in sync which helps to debug.

You are describing what can be done. Please describe why this is
necessary and what is actually being done. See
Documentation/process/submitting-patches.rst. The "why" part is the
most important.

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

