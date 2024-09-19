Return-Path: <linux-kernel+bounces-333276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1206397C63D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA4AB20DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DEA1991AD;
	Thu, 19 Sep 2024 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzd1oxp9"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1A198E84
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735881; cv=none; b=NsDYygquiKwwygFiSVm3j0iBiC2diqIaLfKY/eFj3dTKsZ+v5ZlHwnmmG9ezQ19DnkzzsJP7+1nhvJEF0/YnMzWiLoNTx+jA1PY1UQKQNT+pkFyZz+Nk728pZV+UxEEVKz/146iYpCdKn2lrHFp3IITKE6VWaW8eCX4ZNU53NvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735881; c=relaxed/simple;
	bh=AnH2+fDMdJDfT2wT7eStlGQyoxprTA7rE2T3QoCF3LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfxTrcpYuk1J9rDSJasorgqIIcuzHQRwrfcpUpU9UM3af3BcUEgiT29FIfKokj1qVkRyaVjSSXUMZAUzO/jZ5HbGeTbWyUHmQqpeDnFq3pzb6O9ItH5LtdEP5vcRX90KA90aYG9wNuRtpjHVxbfF81HY0dHjLUVpACC/1QTTmdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mzd1oxp9; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f7528f4658so4852591fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726735877; x=1727340677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFHiL3BgzhxbZK16C89HqTbhSA1DEHRKJHHzop0uZPs=;
        b=mzd1oxp9ele05k6dGl5bOp+7I6TPbO3tp3tyAGz/icDreMz2QDT/qlkPL7S5Uic2wM
         CPcYZO3f+YgpE3A2wfxU8K+0OEhDSlkjEJ4UXppEgLX6Ivdqqq7CJ8MUWTmuL40vgAeV
         T5UNr2Tei77zk/9sylZw0HIKjLEKmCbPp4AlC0c6nNp1mjLY3S5Vcojh2Q3cYfadYh7u
         dpMGRMjPmmb1vZ5w1z1nv8PstPFcBUD8KWCSk75OUCi2LNvmYh2Ed+BP0ir01NGRmVU2
         DaeUSFYxHmsBOFAAqvXR4RqgnRz8+IhTP/5HmkDkUfUavnLeIs2eOb4NZXDdVCj9e1FE
         xsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735877; x=1727340677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFHiL3BgzhxbZK16C89HqTbhSA1DEHRKJHHzop0uZPs=;
        b=TnSBBFHPQMGM6d+uqVDMvp6Ufuo1HmF0IZkobPplLNdp0zPES/n14dyeO/9QNazc+B
         oMBVVqu7VDElIggSJwg6ZWDplxhx3hzaAoAArfcb0dPLl/7BhlJ+Jj11rVenRqxm/C2O
         fWPDCblQ3Wos2/Sl6fJzt1RmeSHlLxbPoV4isX/uTbpJ9iNQxmd/JX4rVYVWMtlOZSjy
         OR4w3TZt/YaIQdGGbPhXx3PhCzQCBlztknMsJxXgnshjgGyj1JyYMPKRGvVyEEoK8/FX
         152Rwcxrp44875zTLAEvMVu6WTG2qODF3r3DR+fTQA9uKOJ+O1zwiiyDKO4x0L8bsxO+
         wmQA==
X-Forwarded-Encrypted: i=1; AJvYcCWBg/tzKd5oQ5go3tJ1IejroTPSEACo2NJBCxh08vs0MdQpixXxiO7hyswmO65+htslmqrfe96T8gDAW7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlOe6D1R9EA3ucn+/0aUyF1rjUGxl50VuCGst5pQigcCnENRdI
	unIIqR7GglEpYEnx24hpsSAy2A7MYqJf2i3WJTODrGG+0jxRJEcU5oq2ND2nqyQ=
X-Google-Smtp-Source: AGHT+IGf49cI4YyHpgiDrXf1LO6sQkn/+x4wD+WKELy6/BrsBTPxz3H1KWGaL+L8fLNfM/X9ym14hg==
X-Received: by 2002:a05:651c:2206:b0:2f7:4ccd:891e with SMTP id 38308e7fff4ca-2f791b4d3dfmr125869561fa.34.1726735877460;
        Thu, 19 Sep 2024 01:51:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d37fb34sm16211381fa.86.2024.09.19.01.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 01:51:15 -0700 (PDT)
Date: Thu, 19 Sep 2024 11:51:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, 
	badhri@google.com, kyletso@google.com, rdbabiera@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: Fix arg check for
 usb_power_delivery_unregister_capabilities
Message-ID: <rqnfzpe6hsvsjznbvnr4woso7i33lfye7sqnzkvh7ejnfzgwu5@zbbzsu57w7cv>
References: <20240919075815.332017-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919075815.332017-1-amitsd@google.com>

On Thu, Sep 19, 2024 at 12:58:12AM GMT, Amit Sunil Dhamne wrote:
> usb_power_delivery_register_capabilities() returns ERR_PTR in case of
> failure. usb_power_delivery_unregister_capabilities() we only check
> argument ("cap") for NULL. A more robust check would be checking for
> ERR_PTR as well.

No. The calling drivers are not supposed to pass ERR_PTR to
usb_power_delivery_unregister_capabilities(). If you check the TCPM and
UCSI driver code, they check return value of the register function
before saving it internally.

> Cc: stable@vger.kernel.org
> Fixes: 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB Type-C")
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/pd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
> index d78c04a421bc..761fe4dddf1b 100644
> --- a/drivers/usb/typec/pd.c
> +++ b/drivers/usb/typec/pd.c
> @@ -519,7 +519,7 @@ EXPORT_SYMBOL_GPL(usb_power_delivery_register_capabilities);
>   */
>  void usb_power_delivery_unregister_capabilities(struct usb_power_delivery_capabilities *cap)
>  {
> -	if (!cap)
> +	if (IS_ERR_OR_NULL(cap))
>  		return;
>  
>  	device_for_each_child(&cap->dev, NULL, remove_pdo);
> 
> base-commit: 68d4209158f43a558c5553ea95ab0c8975eab18c
> -- 
> 2.46.0.792.g87dc391469-goog
> 

-- 
With best wishes
Dmitry

