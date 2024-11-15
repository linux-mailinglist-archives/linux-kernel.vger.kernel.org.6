Return-Path: <linux-kernel+bounces-410888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61849CF12D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1624B30E51
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32301D47B4;
	Fri, 15 Nov 2024 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHQxPfOg"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607A1CDA26
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684470; cv=none; b=Dox0v6BzEQRlcMW7j2FtWZo83CXlkXOAusRTdXA8A8zgB5r5P1gNofFF4i/jnja2Yza9fSDA7zOS6eDN240JwdipK1Xn7p6HnLAxLWqMK6PEJBpzQrbN6UZuuOf0BnP8eDJEwt6Ax4f3dje0xWGfXkdkx5LfxTDiZO2LEeJHTLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684470; c=relaxed/simple;
	bh=bVXjOnsWx/iYY5FZ/kXZfHu8Jl/8iTaixZb5j49sBB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWmaE3wW5qCT0LDYBQR/5RwtFoSSdqR5SvA1PdfdDXsetUzYfEwkPBbaPnbbQwI5hfDzNbLnoAGxFt1RgGSQHJmr8nukVIah8pzPXhKGxeTWl+9iSCZwuat/WI+mXfBXdUIPA1u6wTFd5mtE/cSUJac2mcNS1Q9oWzWidSU5FX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PHQxPfOg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so17403751fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731684467; x=1732289267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMXuggpYjesVA4FmUllH/mkqHpozoEMNcx85tFh/IDc=;
        b=PHQxPfOgCu3d/K2wupcKv9NYWljNv//C5GXZw7WrG7VyZBKWnxpBUEWo55schv/EEE
         DaCsv81Xkk/i1ACbTyZTE3XdZZU9uQhHFpLqS3Im6bNp2I51qq17ISDMFkl9xlWIKUc5
         amB8noXqdIKtUaoW8O7C/TkWp6X/G/0n4wNFcSEWhavRu4fJtxak4jAsEVgsq7Yw3jPG
         7Q3C4CmvzkmWkB5Ek1IKy81wPgBroQAwG3BUM3XasCCWHtgdQjgFnaCGzhMKBPp/0klw
         VW+T/XDS822rrWwJ2ot6FuDTmY7IO655cOwH5v2HuKbkBfDMvU1cc2v2n8kg/IWDfrgx
         ALCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684467; x=1732289267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMXuggpYjesVA4FmUllH/mkqHpozoEMNcx85tFh/IDc=;
        b=mNheHsWvUKPW23C2kstEEp0e5I9fLrbSrWzOhxs9vbKn9GkeYsRg+Edr0rC+vleoXu
         VOE0TriS3TejI9Ll1bJnNRp0qNosZ6ORwZdYwrjni8+ho39+5jEkedXkXmzngqFNMNoY
         CoI0Z8BORYQWs+SUpCxyrfMwUnGHXPua1SbCwiTFUBZFaoGty6DnI6OGA6FiTTD9cJo6
         OQRysK6Aym4mmjCe1F8ExRmW7ahIoDX493il3WEtK51pqabkIUWlZf6Tz4TNKorJl9vS
         jROKE51wpayPQbYHOe+UdlfjPMOAoo1VVDrnGphhMMObc6uB+wjKD0Ho+EPmcKq/1pFW
         GHDA==
X-Forwarded-Encrypted: i=1; AJvYcCX/UmjPn47qSGXXdbw1e4aWDeu/+VEqsGpfA8GOYZ8fWyS+aw/Bz6uEBbZZIRZ8wOFj/7y7zdLUuKxJmWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOa0ZQwi9AxYXc36CDKLPPW69zOSvLZRpyadmwf544K2SwZ3KR
	FEtDSrJTnh34ASt4a2lBbYxt/FyuArR3ESIPFve+s81ESIFdItPjAYk7U0kkYZY=
X-Google-Smtp-Source: AGHT+IHdzjVyEhzeFfshpDNdqomTi8OW4O+yNGDbt9rQbjkJS5VK0ycCp1yfl5ev+Ig7t+lEe2ruWQ==
X-Received: by 2002:a05:651c:2122:b0:2fb:5035:7e4 with SMTP id 38308e7fff4ca-2ff60621cf1mr17333551fa.5.1731684466569;
        Fri, 15 Nov 2024 07:27:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff59763d43sm5824821fa.9.2024.11.15.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:27:45 -0800 (PST)
Date: Fri, 15 Nov 2024 17:27:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adam Skladowski <a39.skl@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Vladimir Lypak <vladimir.lypak@gmail.com>, Danila Tikhonov <danila@jiaxyga.com>, 
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Abel Vesa <abel.vesa@linaro.org>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add interconnect provider
 driver for SM8750
Message-ID: <em4vkg4totsg435s4usu7kqn45vfqfot2j7sikzmnof2kkyidi@26b6kkpz7z4c>
References: <20241112003017.2805670-1-quic_molvera@quicinc.com>
 <20241112003017.2805670-3-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112003017.2805670-3-quic_molvera@quicinc.com>

On Mon, Nov 11, 2024 at 04:30:17PM -0800, Melody Olvera wrote:
> From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> 
> Introduce SM8750 interconnect provider driver using the interconnect
> framework.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/sm8750.c | 1585 ++++++++++++++++++++++++++++
>  drivers/interconnect/qcom/sm8750.h |  132 +++
>  4 files changed, 1728 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/sm8750.c
>  create mode 100644 drivers/interconnect/qcom/sm8750.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index 362fb9b0a198..1219f4f23d40 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -337,6 +337,15 @@ config INTERCONNECT_QCOM_SM8650
>  	  This is a driver for the Qualcomm Network-on-Chip on SM8650-based
>  	  platforms.
>  
> +config INTERCONNECT_QCOM_SM8750
> +	tristate "Qualcomm SM8750 interconnect driver"
> +	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> +	select INTERCONNECT_QCOM_RPMH
> +	select INTERCONNECT_QCOM_BCM_VOTER
> +	help
> +	  This is a driver for the Qualcomm Network-on-Chip on SM8750-based
> +	  platforms.
> +
>  config INTERCONNECT_QCOM_X1E80100
>  	tristate "Qualcomm X1E80100 interconnect driver"
>  	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 9997728c02bf..7887b1e8d69b 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -40,6 +40,7 @@ qnoc-sm8350-objs			:= sm8350.o
>  qnoc-sm8450-objs			:= sm8450.o
>  qnoc-sm8550-objs			:= sm8550.o
>  qnoc-sm8650-objs			:= sm8650.o
> +qnoc-sm8750-objs			:= sm8750.o
>  qnoc-x1e80100-objs			:= x1e80100.o
>  icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o icc-rpm-clocks.o
>  
> @@ -80,5 +81,6 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SM8350) += qnoc-sm8350.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8450) += qnoc-sm8450.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8550) += qnoc-sm8550.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8650) += qnoc-sm8650.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SM8750) += qnoc-sm8750.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_X1E80100) += qnoc-x1e80100.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> diff --git a/drivers/interconnect/qcom/sm8750.c b/drivers/interconnect/qcom/sm8750.c
> new file mode 100644
> index 000000000000..bc72954d54ff
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sm8750.c
> @@ -0,0 +1,1585 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
> +
> +#include "bcm-voter.h"
> +#include "icc-rpmh.h"
> +#include "sm8750.h"

Nit: please merge sm8750.h here, there is no need to have a separate
header, there are no other users.

Also, is there QoS support? I see no qcom_icc_qosbox entries.

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

