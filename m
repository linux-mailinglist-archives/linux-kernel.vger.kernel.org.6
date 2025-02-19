Return-Path: <linux-kernel+bounces-522112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E928DA3C634
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8579A3B3CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E292144D1;
	Wed, 19 Feb 2025 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMIIVk5X"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131741F61C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986084; cv=none; b=flSk9IvrVX1c+aAjjcZvxnrIqmUb+bc1vEo8gZBhjeREqDULk9Xp2eVw3R2ot9EEA6i3QvNy+zMRrTU12+rFxUFM/doB1cG6W2QTRflnE4fOR+w3y8nbRwr9CMs1hLGLHpJ6GBHTqY/UmoS+3DVu2Vo5gkPCM4jB8HfOr7G9uyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986084; c=relaxed/simple;
	bh=A2+HN4X0kozADOMd8HPrxpMBAxhu8YWTaMSPkwDk7qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q25Geu2LWnqKExmGM06prZYOc5kQAKlKE90dz+k3zliqZgDXeLmZ7VzdUjhIQSzgh8p+CbnmDV5mrXxCVgBbrO8FX7q6/A//Ujvu6d/RW72SrgrtqxLzj5T4ffa/YVa0n033qv97wv6JxYzAK1yzMoqV8G5ghpDIZhO+NSkl1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WMIIVk5X; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fbf5c2f72dso69232a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739986081; x=1740590881; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6NzngaP+OJcFLsyG7y1oBQVz797WX/iYaGWrcxV/1GA=;
        b=WMIIVk5X/P+UcTpYed8sUaeBw6DrbuXb7SgnrczGTSV8LecrH+o+PyTU3QQcdj+E15
         Y2LPES0UK3byQR0gsU5DLnrE1Q9hVq4H/FSpF3HnSQ7VboN5lyJieC0B9SSKcDZmqtut
         OpzXX2/Od0w9rDn82DN8c/Nz0YNoMn9V2jxYorO9EPqhN5z69JpHX4HvwyT3Y0fqGcRp
         u5uHrVKTf7EbafgQtPj6pXS4LEjLpshA3no4C9tKoTF+q/nvI4OxiOoMGQH20tdrOBeS
         mN1h9gbNSiqN2oI5RKT5DtO0WDDZNSsQDViQYbIzMBX3v+fHq3pv//8vQ64/iQR41Ijc
         IzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739986081; x=1740590881;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NzngaP+OJcFLsyG7y1oBQVz797WX/iYaGWrcxV/1GA=;
        b=wPWWVhSF6IAgIKUCPjwhKLLGHUnlWcTdwnlBzMtW/dUDchtaHA7lLCSO6KmHT7VY7V
         bL0ZX9X0ug9NvMquFDd+6upYolvv/HlYUrTvYQWH17r8T3PDvLrphAsOln3dO6RJsKr4
         gZXW3oK1ZPJTQmJk8hifXR2dUkJJTJRviWkrncL2zhlKsXUXsB8WNj82ZqANLqb2V4p6
         rPOENeGXwxq0bo5vPwKorpowbG6IxxkxSKyWQQgv3POqZfweUAYUgGwoQIzsCWdd9Jun
         4OBVTA2WrpJYVKVc0D0BktWd10IdKTg9eB1EByPWyafCDu9ZSd3bhXQR1krO/gJYT/j4
         e1sA==
X-Forwarded-Encrypted: i=1; AJvYcCVtS5BLYzpiD3hU9lgKEqQa1mK3Cq/Zp7FFyZjdLEgA2gASM4evZ4dtSdvdbojTuXYTnKtc6+qTe6fFiwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4pRhkNfK0qEfrvYnJv+q9BagfseVN5ltfhCJxA42gtSwVUEZ
	1glUc++2d9NV9ghiPEtUjvm8tmSuGyFSpGVKuQEaTrGN5DrT6OMZbVsVQq2iQg==
X-Gm-Gg: ASbGncvzXEGrZYE9XOFYZ8kv4aRJBQrCqtY6HjzUGdrl3SNMtkbuRytalJd6Ptr46MQ
	IrnKGPF48zxhBKhNSMnjgGYOjbGon8sr94aTVSDCF+O+QeR+bC39uPbtR06JfAr6izgFSJ3QtYH
	oD1984QQ8XhPTzIf4kNxCco7glU1EmKneP3sFw1EhkscyJLj7EvJP3xNJIevsJQwcNvKbimqDE2
	Fvuk+ElnYWSXcjbt0Izf539/cPwtnl7Q1g5j/Nz5RgkJ4nOihtYOEJ/lxLE08ypQKaBPKF1BAG7
	vY/9fazRqH6R9BZySC4D23pWCw==
X-Google-Smtp-Source: AGHT+IHOShpnSsF84pZmQWIv/xBAmLajjHNqHii8bXec9NnuKW9M7BOSWjuz/fRYPwl+0byTPs9X6w==
X-Received: by 2002:a17:90b:1b06:b0:2ea:2a8d:dd2a with SMTP id 98e67ed59e1d1-2fcb5a996cdmr6581509a91.27.1739986081323;
        Wed, 19 Feb 2025 09:28:01 -0800 (PST)
Received: from thinkpad ([120.60.141.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b5b4sm15735500a91.30.2025.02.19.09.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:28:01 -0800 (PST)
Date: Wed, 19 Feb 2025 22:57:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Cc: quic_cang@quicinc.com, quic_nitirawa@quicinc.com, bvanassche@acm.org,
	avri.altman@wdc.com, peter.wang@mediatek.com, minwoo.im@samsung.com,
	adrian.hunter@intel.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." <linux-arm-msm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] scsi: ufs: qcom: Remove dead code in
 ufs_qcom_cfg_timers()
Message-ID: <20250219172755.b2jq5joh7nrrf6rr@thinkpad>
References: <547c484ce80fe3624ee746954b84cae28bd38a09.1739985266.git.quic_nguyenb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <547c484ce80fe3624ee746954b84cae28bd38a09.1739985266.git.quic_nguyenb@quicinc.com>

On Wed, Feb 19, 2025 at 09:16:06AM -0800, Bao D. Nguyen wrote:
> Since 'commit 104cd58d9af8 ("scsi: ufs: qcom:
> Remove support for host controllers older than v2.0")',
> some of the parameters passed into the ufs_qcom_cfg_timers()
> function have become dead code. Clean up ufs_qcom_cfg_timers()
> function to improve the readability.
> 
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 23b9f6e..d89faf6 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -509,16 +509,10 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
>   * ufs_qcom_cfg_timers - Configure ufs qcom cfg timers
>   *
>   * @hba: host controller instance
> - * @gear: Current operating gear
> - * @hs: current power mode
> - * @rate: current operating rate (A or B)
> - * @update_link_startup_timer: indicate if link_start ongoing
>   * @is_pre_scale_up: flag to check if pre scale up condition.
>   * Return: zero for success and non-zero in case of a failure.
>   */
> -static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
> -			       u32 hs, u32 rate, bool update_link_startup_timer,
> -			       bool is_pre_scale_up)
> +static int ufs_qcom_cfg_timers(struct ufs_hba *hba, bool is_pre_scale_up)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>  	struct ufs_clk_info *clki;
> @@ -534,11 +528,6 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
>  	if (host->hw_ver.major < 4 && !ufshcd_is_intr_aggr_allowed(hba))
>  		return 0;
>  
> -	if (gear == 0) {
> -		dev_err(hba->dev, "%s: invalid gear = %d\n", __func__, gear);
> -		return -EINVAL;
> -	}
> -
>  	list_for_each_entry(clki, &hba->clk_list_head, list) {
>  		if (!strcmp(clki->name, "core_clk")) {
>  			if (is_pre_scale_up)
> @@ -574,8 +563,7 @@ static int ufs_qcom_link_startup_notify(struct ufs_hba *hba,
>  
>  	switch (status) {
>  	case PRE_CHANGE:
> -		if (ufs_qcom_cfg_timers(hba, UFS_PWM_G1, SLOWAUTO_MODE,
> -					0, true, false)) {
> +		if (ufs_qcom_cfg_timers(hba, false)) {
>  			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
>  				__func__);
>  			return -EINVAL;
> @@ -831,9 +819,7 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
>  		}
>  		break;
>  	case POST_CHANGE:
> -		if (ufs_qcom_cfg_timers(hba, dev_req_params->gear_rx,
> -					dev_req_params->pwr_rx,
> -					dev_req_params->hs_rate, false, false)) {
> +		if (ufs_qcom_cfg_timers(hba, false)) {
>  			dev_err(hba->dev, "%s: ufs_qcom_cfg_timers() failed\n",
>  				__func__);
>  			/*
> @@ -1348,12 +1334,9 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up)
>  
>  static int ufs_qcom_clk_scale_up_pre_change(struct ufs_hba *hba)
>  {
> -	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> -	struct ufs_pa_layer_attr *attr = &host->dev_req_params;
>  	int ret;
>  
> -	ret = ufs_qcom_cfg_timers(hba, attr->gear_rx, attr->pwr_rx,
> -				  attr->hs_rate, false, true);
> +	ret = ufs_qcom_cfg_timers(hba, true);
>  	if (ret) {
>  		dev_err(hba->dev, "%s ufs cfg timer failed\n", __func__);
>  		return ret;
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

