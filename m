Return-Path: <linux-kernel+bounces-397668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD649BDED3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525BF1F23731
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D9192581;
	Wed,  6 Nov 2024 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="coTNmeJm"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A699191F8C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874306; cv=none; b=OOJ+aPuJpN206rqapIVP0KEFROUcAZb0bsSCU7cy8EdLNnxPx1pTuFrlQOA3gx5IyWMlC4iYqES2uIaT9i5NSY6flpQeF867GkVaWWH/RUEELeJ+FHeHApH2rf76Dl+5SMzQF6OYLui/VWj1O4jYaNVXcEbghxzRylpGMg1CKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874306; c=relaxed/simple;
	bh=pd1RPbDvyKAdutsoHyIAPw2O4/BwDyOwjfZO5fZ1cPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roY4qkPwKgled2PPlDi1ZdjsaBkaOPYRmZ/3/WBtbpVk1HQ+TBdSMzNGqx7daZHh4hrGxS5ketDa6TlghIPepIdISDmpmZ+8JrYUUddVwLKmzM4jJNufZPUQE8vdko1BYTZkNZ4pKfBoAVB72gDByCxy7YRAaxJHpraH32FZgXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=coTNmeJm; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e3f35268so7661559e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 22:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730874303; x=1731479103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxFZHhfOgUAesJdJAQ8LrwzR6K+3waeqdGRbUpVHTOk=;
        b=coTNmeJmKtY8QriIHJSdjWfIVDCuyDp2mgdAKjolcG19xRI8l19i0gGqcIgyOgnsff
         +azkeJR266IOtwsewXQcM8qB3sWgwF2vJjqRDUR6Gi/RN55A8PFGw7SusOLgqbNkMZr8
         pKDKnC3iBnc2vBfAy6zP9LUJz5NlUQ4J7xVqAyXJEtcipEb3w5y0C/ja0gvMH0k8QBDs
         SCQFnS9HCwQzo/xDB2cyjO/MstJtXYkB4Gg4TMlBhud626BFSM3oWRR1l3nm1ZMjTtbv
         /1lgh0sVHN5fA696sMAh86yrb8n2E9lKYTbMLJh8Fbl+zD0x21DtFOvZXOLMehQwi4eh
         K/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730874303; x=1731479103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxFZHhfOgUAesJdJAQ8LrwzR6K+3waeqdGRbUpVHTOk=;
        b=tDx3vVXvZyFSk2WFGCnBYNuuxpLsi4uZQNgtzneyqQKCeYXmT4a1plDjcECiBpzS2/
         lG42QjCAii8o28MeQbhckCK2nAZXgPSkdLpwwRPFdb50DVipt3k/HLSqX1W7LaoYXS55
         qnHCKniZrWZYgB3PQEav5lbdqB0wuPYPC+EJDz+UJ/mZUSYq8415xDVK0BO6qYO0HA6a
         uJ9GJccuqAGWqsYCUNU9OYSlmQpvq2fp5J8T/HzcdhqT/FzZ+VttGZuP70VauPqAxS+J
         jGGjCMnRdfNMWjDNghfXK9MKFso+oXGKOLvyR/zXVVbuNtzoMTLn3SsnB5IIEWo5bCYl
         E6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8xFJaJwt6cCaO4RnP/41HO1lWmRenImw34KB36NLYa+n45uYTuLgiIFrnQqW9cuINpzSYSYalO/zOfEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBMPFRDfUSmBc9xViOjlufDE+BRhsHFlctnZRtVgDMuNxfE1Hf
	h/O0SuVrdq4XCdw9TAuMvAhBgU7Uf+EKwx3ECHDVjqtCDB1PqLmdDr70J5M3pRM=
X-Google-Smtp-Source: AGHT+IFZXdHjp1TRKU7+ynZpQK+grMmwldqqRbucDzcuIXGOlLftDdZVpl2Qy+OT1fZCuEwFdee2DQ==
X-Received: by 2002:a2e:a904:0:b0:2fb:510c:7236 with SMTP id 38308e7fff4ca-2fedb831551mr96576041fa.40.1730874303379;
        Tue, 05 Nov 2024 22:25:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a6611sm23414431fa.90.2024.11.05.22.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 22:25:02 -0800 (PST)
Date: Wed, 6 Nov 2024 08:24:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, andersson@kernel.org, 
	konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com
Subject: Re: [PATCH v6 3/7] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
Message-ID: <tputkypwyu6hvekawcfyywunzxxkwig6ydycry5t224ubh7sym@ynftehi7yxki>
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
 <20241104124413.2012794-4-quic_mmanikan@quicinc.com>
 <ni4y5yf5uymum4rinlr35tnko6bgxscmchw236h2c7dxxojxci@upzwx4xvh2st>
 <441eb5ca-dfae-4f35-8026-61b70c23c4c0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441eb5ca-dfae-4f35-8026-61b70c23c4c0@quicinc.com>

On Wed, Nov 06, 2024 at 11:46:26AM +0530, Manikanta Mylavarapu wrote:
> 
> 
> On 11/5/2024 1:12 AM, Dmitry Baryshkov wrote:
> > On Mon, Nov 04, 2024 at 06:14:09PM +0530, Manikanta Mylavarapu wrote:

> >> +static int tsens_v2_calibration(struct tsens_priv *priv)
> >> +{
> >> +	struct device *dev = priv->dev;
> >> +	u32 mode, base0, base1;
> >> +	int i, ret;
> >> +
> >> +	if (priv->num_sensors > MAX_SENSORS)
> >> +		return -EINVAL;
> >> +
> >> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
> >> +	if (ret == -ENOENT)
> >> +		dev_warn(priv->dev, "Calibration data not present in DT\n");
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> >> +
> >> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base0", &base0);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
> > 
> > Is this actually base0 / base1 or rather base1 / base2 as used by the
> > tsens v0.1 / v1 ?
> > 
> 
> As per qualcomm internal register guide, these registers are named as base0 and base1.

Ack

> 
> Thanks & Regards,
> Manikanta.

-- 
With best wishes
Dmitry

