Return-Path: <linux-kernel+bounces-442449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0769EDCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151B1166AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D252E400;
	Thu, 12 Dec 2024 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXXgCV+X"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B71CABA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733965776; cv=none; b=JrV9GpmzaMv47pXL8d0FrldHz07pryqYUt6+5PC/EAbNfiCtUrOsslrgRqnsZ2TdrcN4VI2qbqs12hSQmrYiYGadvmQNHzcZ775Gc1cw9q1Bdt3qLbOUrH+TL5thskBLPNcSZDcrw3NiyUfqura8Tu+fSHUeHS3YZINdIgjgTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733965776; c=relaxed/simple;
	bh=qv6OvIXWsYjVmNDnmi27QYO7K3Ldrx/3qmudjTkRhOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQ3Jo2FY6lPmoSmJb/wUOSImtaPG5/gvDYDgGyrLhIe7DpHx+kpz8EJvlIZSt5hqa79K4+mUAKzocsCnsaMf+c03Dam07zgcBc/JpSNjFGDACbUhP5wqp01HhMU/2kGAP1w+L51XFMsUysxjBYo9+3mRU4e40RLjjEe2yM0opa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXXgCV+X; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53e2ed7d951so12260e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733965772; x=1734570572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gn9/HJ6VMzSGcGaxW/y8OLh9unHBkAJxM422iTplG24=;
        b=OXXgCV+XyDKtnMBAUy67lAsg+jul86ow4DOlxcLS/FMXKnZ7i+I/HwGf20cNrf39FV
         v4DJDy5CYG181Z/J1sAN9MsbyebJPfsorHlpsGWLyZ+Sp7NSXaaesQ3comF2vj84MWz0
         JchqiFBkRp1v3tKi0Hg6sDkaxGxRMNN8N7JrhV1qNNe4Hqs2nJ4LM1uUzjFKfm14JJir
         qc8uQGvPYsgVwp0yrUTIZaESYjruWk7eB4VnecGkMTQJ1GP/eA+uzWQ3/jC/j1/H/kE9
         vmaoe1EDNy/b+X7nPJOHCK9AEOIuPbmw+MnU2bDzVanFt3s/omSfFfyHX8F0o19BUvUi
         +jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733965772; x=1734570572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn9/HJ6VMzSGcGaxW/y8OLh9unHBkAJxM422iTplG24=;
        b=DjoRVnspLCypQidOlphP83Sw/YPQl8mLlWpOQGLUe/SlwRrt9+VRkwWHEPGuD12wjk
         eJw3ozclC4NVrkFuCZM6Zg4gDKh2gGXeqi7493r1TC02AWoQbhZQsFabgaRxqpa1bJvF
         ygDjQMhElz9wsQof2MbsmEhS6JOdfGEUab0pVBNziCkaoHN9nZhEyW9HMEzr86w0Dm38
         93nndNyOeJoq19QPrnInaO72Gz7UKp2zO2bWjE3LdOlHUCGXBGTJlyXnw5OXmlmVjvQE
         4IoydEFfpgD6kPGzLe9ujlFS1W8Hyph9/sG6DsYnfP29Yi1pUGdjlYBbEBVaCpsx5eHv
         Afww==
X-Forwarded-Encrypted: i=1; AJvYcCU+sPkU2aFegecbbv6F4W31i2h+vaX6gIKZlw9nszS8Amjy6agpB6aeunijT5vJxmbv9HPGiu5+Ms/bqBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0Yklhf+oKWalvZm7fvgBVHrbYyg+wItLBAzfbxUQMjUDC8Sp
	yEb8po2T6D2+n4PgzG0tSzsBpFwMM+eVpLxOAetSowlFkrSIp3UDwpKOkS92w78=
X-Gm-Gg: ASbGncs7P643xnUcBRBb7uxq38rPvetYilcelyLYoaVdtMO9dij+gf1gSwxXgYb4N3v
	CDIJi/l/l9qVwkIosXBtMsx0w5Ry6PFxUOlOltN+DBChwO6qaVnYpx4nq82wlm6gP7l0VBB1NdD
	/6qbShk2GaYY1xy54U3/tCD4HizN2/cikecTn/+tpiRP0NqaB8U5fqvIOGeHwuL6MhdKE7F/fTD
	v9wuPaKKEId8+5MeOf2cCDxgqjQME+vlCfTmLRf0AbhXKfn1/Gp65OwB6jvyI4TQSLvxmhTfgwh
	qT7u4qnS9zSyMw/NKNcAgQWWRok8eJT26BE=
X-Google-Smtp-Source: AGHT+IHRJbCRF9Jm0y8nQsEY/6+MzdeRL4pBScxOAhsjaPVS6Xq51uBxkCQytZMf4/xdGli7wFb9qQ==
X-Received: by 2002:a05:651c:b28:b0:302:27c6:fc7b with SMTP id 38308e7fff4ca-30249e053bcmr1830891fa.6.1733965772467;
        Wed, 11 Dec 2024 17:09:32 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30231594b18sm7330921fa.16.2024.12.11.17.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 17:09:31 -0800 (PST)
Message-ID: <1ac23fa1-fc35-45fb-9338-d5f304c869ba@linaro.org>
Date: Thu, 12 Dec 2024 03:09:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] media: qcom: camss: Add callback API for RUP update
 and buf done
Content-Language: ru-RU
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
 <20241211140738.3835588-10-quic_depengs@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241211140738.3835588-10-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Depeng and Bryan.

On 12/11/24 16:07, Depeng Shao wrote:
> The RUP registers and buf done irq are moved from the IFE to CSID register
> block on recent CAMSS implementations. Add callbacks structure to wrapper
> the location change with minimum logic disruption.
> 
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

It's unexpected to see two your Signed-off-by: tags, either one is invalid
or the authorship of the change shall be changed appropriately.

> ---
>   .../media/platform/qcom/camss/camss-csid.h    |  9 ++++++++
>   drivers/media/platform/qcom/camss/camss.c     | 22 +++++++++++++++++++
>   drivers/media/platform/qcom/camss/camss.h     |  3 +++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
> index f52209b96583..1369e7ea7219 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.h
> +++ b/drivers/media/platform/qcom/camss/camss-csid.h
> @@ -152,6 +152,14 @@ struct csid_hw_ops {
>   	 * @csid: CSID device
>   	 */
>   	void (*subdev_init)(struct csid_device *csid);
> +
> +	/*
> +	 * reg_update - receive message from other sub device
> +	 * @csid: CSID device
> +	 * @port_id: Port id
> +	 * @is_clear: Indicate if it is clearing reg update or setting reg update
> +	 */
> +	void (*reg_update)(struct csid_device *csid, int port_id, bool is_clear);
>   };
>   
>   struct csid_subdev_resources {
> @@ -168,6 +176,7 @@ struct csid_device {
>   	struct media_pad pads[MSM_CSID_PADS_NUM];
>   	void __iomem *base;
>   	u32 irq;
> +	u32 reg_update;
>   	char irq_name[30];
>   	struct camss_clock *clock;
>   	int nclocks;
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 9fb31f4c18ad..e24084ff88de 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -2087,6 +2087,28 @@ static int camss_link_entities(struct camss *camss)
>   	return 0;
>   }
>   
> +void camss_reg_update(struct camss *camss, int hw_id, int port_id, bool is_clear)
> +{
> +	struct csid_device *csid;
> +
> +	if (hw_id < camss->res->csid_num) {
> +		csid = &camss->csid[hw_id];
> +
> +		csid->res->hw_ops->reg_update(csid, port_id, is_clear);
> +	}
> +}
> +
> +void camss_buf_done(struct camss *camss, int hw_id, int port_id)
> +{
> +	struct vfe_device *vfe;
> +
> +	if (hw_id < camss->res->vfe_num) {
> +		vfe = &camss->vfe[hw_id];
> +
> +		vfe->res->hw_ops->vfe_buf_done(vfe, port_id);
> +	}
> +}
> +
>   /*
>    * camss_register_entities - Register subdev nodes and create links
>    * @camss: CAMSS device
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
> index 9da7f48f5dd7..6dceff8ce319 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -161,5 +161,8 @@ void camss_pm_domain_off(struct camss *camss, int id);
>   int camss_vfe_get(struct camss *camss, int id);
>   void camss_vfe_put(struct camss *camss, int id);
>   void camss_delete(struct camss *camss);
> +void camss_buf_done(struct camss *camss, int hw_id, int port_id);
> +void camss_reg_update(struct camss *camss, int hw_id,
> +		      int port_id, bool is_clear);
>   
>   #endif /* QC_MSM_CAMSS_H */

--
Best wishes,
Vladimir

