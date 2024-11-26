Return-Path: <linux-kernel+bounces-421866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7509A9D911F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16533B24D11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6565146D40;
	Tue, 26 Nov 2024 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H01l5V74"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D020F513
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732596734; cv=none; b=muf3qD+bfegjAUw4M3u77Ln+GN7af7Y7pqDod60YNWFkW+sJ0XbmAA2sdJWfj1wfoLyszAOZUKIKkX6h4jWM2jripp7mgHwGz3e6XmEfYaLtsVOMiB8ssM+uAGsWc0zkgu6k1Ubu//GJwt6CQpr3QfAMAn69iAUG3F4CoU4LN1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732596734; c=relaxed/simple;
	bh=UMaGgDkF1T2aYUdiWAaQKUuv145YTS1tpH7aMLKiQmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enzm5E6OROWCQxkOT5TrgxyTLypuWItTMbvWhIAeg1XXH9NEVsmXJwVj9X3LGQCWk/ISw5j+43ZH1/3UPfyENCW2I2ddblsXEtUNSJ+AEwqvtuRZHk8b5nQ9EYbzVgeI5J1wszhnPBLzuETR58UQQmKP7DnNt8V+EyiV0v+CqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H01l5V74; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fbd70f79f2so3177028a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732596732; x=1733201532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rem8LGZXdVnZ/PI5gsaQii+kftUkAG4f3mUtkM8OBis=;
        b=H01l5V742yTAVdomk5Oc2AXbgCIGX8hmkHGgtDtxdFR3qig/sVzN8Dye5uD9TGoCt6
         xsWI6DGv5o6vgr6HsZjLS3X5MxTj5OB1VPL3taGiYoa2XY0HLu7UNbzH/bxHlRTb57M4
         8Qj0ee6yX8WmH/tDcbov0Bnp7PwHpIBnNUIDkd9aKOK7R0ECC0QNboRJSHXlyQdU1twH
         VOM2EYD+0AV1dckpnpTubuI21OrL1cO6K3jLhAjzO7hzvFD4ZBXYM8sCIZhQz1DqrJgv
         I6bf9GUkfxEaDcyUHMlEmeMP+tQXFgS6K29tOh0z5hDWd1Hn3hEPgOVgrwZ+SXYwlGAm
         C1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732596732; x=1733201532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rem8LGZXdVnZ/PI5gsaQii+kftUkAG4f3mUtkM8OBis=;
        b=QN+3OnLhdoxxEUv8GE57ncig84o/di+VLCoei8WpKzAfE9CU5WLXsubH5+i9NB+Gq9
         UNmMIeCRMWXuUCRV+nxTBZ4vBxBPferKjlGpH+zy1fmfeXaNnwqS3S2+ziHk1LqpEf4w
         2ubQBVZN7FCkTFqUfcEzWJYvgvZ95VWfz4FUglOxB/ysl7J8HKAfYDry5yH8ldcx3377
         K2xcoGEgNEjOMZ12CAYgMCJA2fRosYZfdWHrE5HVnaM3PTBn45zUONTywtak2zczXL57
         SwiKdJMSKrbPMhjgmqXwPoTgiY7EtjLC4Lv5YND4MWAiAwC/TQk+gWnowA2Xg2vayNJt
         AzsA==
X-Forwarded-Encrypted: i=1; AJvYcCUSjjxikUHhTcN77d/+pk89lzI7wvg1tBSJEosIp7Erq+Nx6Ew5bbMmvnxm9sOPDTqSlcE8bZNqrIqgAzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5pQidszXdcxNaW3jvOFVYdpaJlb6RYGhKg3oHhHFGXrINxBEk
	mcSsvOaN0jzKXx4db1Y8iTx3kAxSIQDWflLEcol5JP18SLKGO6T+k/PIASpGMg==
X-Gm-Gg: ASbGncua/yBl+3HkUcQaDYEc8LixyeVbGpwhMYlC5S7VFBBQEgZ6O5/3mubGPo6zwWM
	mPi8GTCYSXFFvowtiaG56b2J/AdwPe+B9G5wzTsFO0GDnHeW44R1AtLd3DhXa3PEZ28Ld8HugDM
	FSN69zALeSC1eUYYmYDQzgsRKZgVAo6D2C18l+UR6ehyECjMO3SL9oQvXa/A6K5NTYt/UdNvVQo
	1hDRIJDwaTZvG3OVOH5wnWAAlLFG9XV3Hv6UWmzNiIzpv/iH6cT6WRVeYNDFAo=
X-Google-Smtp-Source: AGHT+IFLS2CiMe6uFsk3VjOrgamDEQHKYFhaEEUWVyLY/IZqdSO4oF/zkuEQngAEkYwNRZrt7cVwfA==
X-Received: by 2002:a05:6a21:3389:b0:1db:dfe4:daa4 with SMTP id adf61e73a8af0-1e09e40644fmr23624442637.9.1732596731951;
        Mon, 25 Nov 2024 20:52:11 -0800 (PST)
Received: from thinkpad ([220.158.156.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2c5fcsm72746705ad.280.2024.11.25.20.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 20:52:11 -0800 (PST)
Date: Tue, 26 Nov 2024 10:22:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vamshi Gajjela <vamshigajjela@google.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Fix link_startup_again on success
Message-ID: <20241126045206.v64iypeiyt22lcei@thinkpad>
References: <20241125125338.905146-1-vamshigajjela@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241125125338.905146-1-vamshigajjela@google.com>

On Mon, Nov 25, 2024 at 06:23:37PM +0530, Vamshi Gajjela wrote:
> Set link_startup_again to false after a successful
> ufshcd_dme_link_startup operation and confirmation of device presence.
> Prevents unnecessary link startup attempts when the previous operation
> has succeeded.
> 
> Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> Fixes: 7caf489b99a4 ("scsi: ufs: issue link starup 2 times if device isn't active")
> Cc: stable@vger.kernel.org
> ---
>  drivers/ufs/core/ufshcd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index abbe7135a977..cc1d15002ab5 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -4994,6 +4994,10 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
>  			goto out;
>  		}
>  
> +		/* link_startup success and device is present */
> +		if (!ret && ufshcd_is_device_present(hba))
> +			link_startup_again = false;
> +

Using 'link_startup_again' flag looks messy. Can't we just check the device
state after first link startup and if it is still not active, then try link
startup one more time? (Assuming that the device state won't be active after
first link startup).

Also, we should move the link startup and its associated check to a helper
function and call them instead of (ab)using the goto label.

Like,

	ret = __ufshcd_link_startup()
	if (ret)
		goto fail

	/* try link startup one more time if the device is not active */
	if (!ufshcd_is_ufs_dev_active()) {
		ret = __ufshcd_link_startup()
		if (ret)
			goto fail
	}

- Mani

>  		/*
>  		 * DME link lost indication is only received when link is up,
>  		 * but we can't be sure if the link is up until link startup
> -- 
> 2.47.0.371.ga323438b13-goog
> 

-- 
மணிவண்ணன் சதாசிவம்

