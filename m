Return-Path: <linux-kernel+bounces-306552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008A0964065
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A001C2061D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F4218DF88;
	Thu, 29 Aug 2024 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9VdmNW9"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AEC18FDA7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924365; cv=none; b=jmwUoiu4LFF2PGc2glggMFPABNaS995cLprUofP4jFyCUrsWm3xQh/OBAXWVxRNC30nigznzdCUYjkno1G2BoP87sEOWaiWj2Yn/VMtjGHSyYoX3H+qyN2CbKQJ9Cb0MyxOcSX6YCzklrXpftECwGitpxe0iB+OkgMciks89buM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924365; c=relaxed/simple;
	bh=lLDOCp0JjYArDCajWCpScG2VzR6De38arrsuNVYW3wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL/PQsdYdUGiSSffzA047BNkMTBpI39jXsQbTOHXOm3FVg8yB+8Dg/i/UKSCIRsiw0DbBGrxfa661mvUEWjTXGlUyEfsnnnFQuur+QgC6BgOHv3wD9iNqO5onwCWNvSm6lbAEVE0s9YHFXoibNU1e7cdxdgzTs+k+x4/Dked9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9VdmNW9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3ffc7841dso4068371fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724924361; x=1725529161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDM7RjeAqR8mIYaGQ8a1+G3W/uE+J1ku7MSyGRa4NEk=;
        b=m9VdmNW92zGTQmV99Q9PFKPf92p6vkfVwrqGNU0MDkZ8aHjPXyp/pWTT4VFuY3B2TA
         hPTEoABuZPTgSmQCWDFUL7DALy1wlJMsTyB+d03zXLk1H8nwL1Zxc5peUSqxNiVR/A8s
         vLN+dP/UX95ZJXdSHB45SkH2N6SrGVFuhm/M1gQLyNX1y+3CiaO61RxS5bG/3FIr9zI9
         0alKjo9Lo5reSx+dPhiyNiHOY940tOQlr8wxg3MnOezHwqybmJghcTBTAX5FBah6Z6lk
         xxRoM+/sMLqiZy5QlYqdcnGfyVDgdWbu4g5FlMkNLBQsPG3/2bVdW7pftSVEa2PmzZ2W
         wDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724924361; x=1725529161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDM7RjeAqR8mIYaGQ8a1+G3W/uE+J1ku7MSyGRa4NEk=;
        b=J5SmXHsvtWDZBf47h/o0wZuT5xNowXp3btAa3UaOxqZxXZRc1HHEcoElKCyiH96iYF
         hqqm1yaJ5NGO/YcLeQcqsyWeyU0AhB64lkHeag3LhLYLkfs3+GJgMjASewKovRc39lPH
         Q5Wi+zqu6wGIsmRS8Zn+Q/L7ydN+Bbrjo4jVn2Qjclfa5BPyT3nitPvcH8mS9FChlQai
         0ZUK7+Gzv4m2KyYhMUM9A7+4YaCRTPeaL+TJFoKBmHEWMq1FIKqnII/l4/AkBglJnfa4
         Pa/mcS/nC8EhbWpGAKsl1+x9yUU1M/+3Zh9Salb2zM/bfXZbjqfv8jQbWnFHiMrf5giP
         R9+g==
X-Forwarded-Encrypted: i=1; AJvYcCWRIf+0R3ft+INpobEofDdeu8Ffd/8F7GKanpAN1hzro+jgFisTZ3+HDvHQUUOz8GFpWQ1Bc2Z0Aw9cIDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0IwyYtEV23A1wPUa15GjMLR91KTSGvuDlC7nPL4rMsftIbr2v
	obsMxvwVJgRY+tPNYtLh5Ydg7aQRXeZqMnRmnWOkXZ1Lv+nDCPR38T7Z0hXlc8c=
X-Google-Smtp-Source: AGHT+IHGfWPcdIFytjVqqncQ/oLhZH7r/07x9IdMh7vGuT2jTNq7ysgN1KBCB+fKpMokwXTbVRG6nQ==
X-Received: by 2002:a2e:6112:0:b0:2f5:806:5d00 with SMTP id 38308e7fff4ca-2f610923e1amr14910221fa.32.1724924360947;
        Thu, 29 Aug 2024 02:39:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614ed15f1sm1291921fa.4.2024.08.29.02.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 02:39:20 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:39:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	quic_mdtipton@quicinc.com, quic_okukatla@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] interconnect: qcom: icc-rpmh: probe defer incase of
 missing QoS clock dependency
Message-ID: <xny4v2twbt5sjjtc5yoffpnymryfd6da6pirlmiii5txyz7rl5@xy7wdrzi5auc>
References: <20240827172524.89-1-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827172524.89-1-quic_rlaggysh@quicinc.com>

On Tue, Aug 27, 2024 at 05:25:24PM GMT, Raviteja Laggyshetty wrote:
> Return -EPROBE_DEFER from interconnect provider incase probe defer is
> received from devm_clk_bulk_get_all(). This would help in reattempting
> the inteconnect driver probe, once the required QoS clocks are
> available.
> Rename qos_clks_required flag to qos_requires_clocks in qcom_icc_desc
> structure. This flag indicates that interconnect provider requires
> clocks for programming QoS.

Two separate commits, please.

> 
> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 10 +++++++---
>  drivers/interconnect/qcom/icc-rpmh.h |  2 +-
>  drivers/interconnect/qcom/sc7280.c   |  4 ++--
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index f49a8e0cb03c..5417abf59e28 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -311,9 +311,13 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  		}
>  
>  		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
> -		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_clks_required)) {
> -			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
> -			goto skip_qos_config;
> +		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_requires_clocks)) {
> +			if (qp->num_clks != -EPROBE_DEFER) {

if (qp->num_clks == -EPROBE_DEFER)
    return dev_err_probe(....)

if (qp->num_clks < 0 || ....)
    ....

> +				dev_info(dev, "Skipping QoS, failed to get clk: %d\n",
> +						qp->num_clks);
> +				goto skip_qos_config;
> +			}
> +			return qp->num_clks;


-- 
With best wishes
Dmitry

