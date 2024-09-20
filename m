Return-Path: <linux-kernel+bounces-334506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D2197D823
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9DC8B24601
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF7517DFE3;
	Fri, 20 Sep 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqTVtOxo"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDBB665
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726848994; cv=none; b=ZQxfr0BeGosI/b/eH+50NgUqtdkwbX/wV38S/vSQ7Wht8phYKV6Nm9Bi+sXFokZ6WQ1tW+CHlsjBWHQ6v6MgrUs+2neVTzp5Nu9S5WGaYR4a3Qfvmha9JKqiEjq2pRxNP4v+UyZAQR6v9XhlRGKljY+WSEx7bgupvpQLm30Hen8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726848994; c=relaxed/simple;
	bh=bxaccqvfXd2RGuRsrng8Sp8ALCQi/k1NgrYH4uDmUdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJhXgG2ZEEFrfxL61HsVeXsv43zcqpd4z8wpOobwEPV8xGfpX9mAcRunkOZKCnz7/kih3oiMWqwyy7GOR117OMLl+Js+U1/pEP6lNXrRCyk8OUBJbUpqE0UhcTD+6kqCImRQ7NlDTCMbwwoTKNsMERN7aMIFMNk8ijZmCWiK0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lqTVtOxo; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso29662951fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726848990; x=1727453790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojs9bHvGaP56hqKEftt/MxT/xOMPbuiutorXXfIZh6g=;
        b=lqTVtOxoK56EYtXLe7+RyFlm1zXfKEsaXJeBYGQTKztiolqdtk2DR0gQDssMvrQc/M
         eJbbfiOe3g99/uNVG1wmVUeNA0JFQkOHBtsmGh4ZW3f/XRLaMfpyY9gPw9kTs5BgNMzb
         GhVp25vea1uz3hTBIL06IrN3fd9Z7rO5bZclEgehrv4RoAJ7OZBzIFlHKHV9BNGiAFO9
         wbi59M/wfxy+QtxtGlc3+ERdRCammpIGFbGh7dwYeC+8DXJPBHxoak+oPdey3oPemCw+
         naLoSV0XKSFyzODdqF8DlqBRycOqNTHHmNWYuPhFX+5v6oU4wClwRsP0J2w2cnjDSoOV
         1DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726848990; x=1727453790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojs9bHvGaP56hqKEftt/MxT/xOMPbuiutorXXfIZh6g=;
        b=VlXHf4BYot/WmondF5FlUUaFzgBW0cRhQhOhihRhQBt68x7HBzNhl3O+oK9QSZlJ0D
         b6BuN5ibgTVnYP7z1AewXqbWDZTDsxrOfF6Le4aTXYRXAxdfS2XRFUD3rFtUueVF7V0C
         qg/6Doew4fITHBpxcuhfaa4PzgU/tK7FRDkbAzRAq4rCt4CPdqj5n99Ia0IWN4KJeXOI
         RIHP7sSNR/9ZBEACzvMBM/kq3qPvWa4j15XJwO/ml1CHX3+IXU/7wJePXOR6F6lI2Eaa
         UsEt+Qf8Umh/Dzs92/VBFoI1J286v9jzd8rBZjKJGhyX+MnaB28cFiOp2yJmgFjIK93M
         ItHg==
X-Forwarded-Encrypted: i=1; AJvYcCXeQUas9QBngMkv/2oQpJdS7y8IVcpCqSyb/mXw5dT0snJBK+zLD2X0cVMN4mMunqVj3yu4ZSmbFQnzY9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym51VXxmRrMgrdWVdtJ6ppwdmLGpILgWGTsDqCw5DJhtAVWVEJ
	jgr3Ed1LcJfabGZBjrZVGeu7h/7lsdfWjyTW4ldvss2CcIKYlD2MrpWOKFNqvFs=
X-Google-Smtp-Source: AGHT+IFjuJHBz3zyYZgiHeBiTX9aOszMyNS+dBaoStFCzARqh43splESYieVEXve8IE/eEpFlXFarA==
X-Received: by 2002:a05:651c:4ca:b0:2f7:58bc:f49d with SMTP id 38308e7fff4ca-2f7cb238066mr19201831fa.0.1726848990184;
        Fri, 20 Sep 2024 09:16:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d2e1ca7sm19564801fa.24.2024.09.20.09.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 09:16:26 -0700 (PDT)
Date: Fri, 20 Sep 2024 19:16:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: stefan@agner.ch, alison.wang@nxp.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/fsl-dcu: Remove redundant dev_err()
Message-ID: <2es6xy5o4j7kciop75lturl6n6k5yykcibgkv5r6tjf7ap3ek3@ia7a4dozi2kl>
References: <20240918074841.2221210-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918074841.2221210-1-nichen@iscas.ac.cn>

On Wed, Sep 18, 2024 at 03:48:41PM GMT, Chen Ni wrote:
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from platform_get_irq() function
> as it is going to display an appropriate error message in case of a
> failure.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

