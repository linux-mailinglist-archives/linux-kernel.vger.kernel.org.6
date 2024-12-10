Return-Path: <linux-kernel+bounces-438712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FCE9EA4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386BF166C48
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C44B136326;
	Tue, 10 Dec 2024 02:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKPiEQDe"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ECD233129;
	Tue, 10 Dec 2024 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796415; cv=none; b=SU8TdYozLuPYcf3ipxNapKXKMtv57yqSXhNMdzZVgBKBNSafvZ34Fc3zDmGFFLETZOs/cUuI3NnPOOt457y5/IGyj76/d5EsvN4vqdfqe8SRDAUw4PAtS6PLdQZdcIx8YU5+ENh/+iS9VSh9ewHFn+2ybmQs7/rOEqbFpKx9OkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796415; c=relaxed/simple;
	bh=cgmafluFZlv4GbkSveoxLKrE94PUY8hpmRVSIcm0r5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4LybkKF91jKj7maHJ15eXNkC4/PTUTmVBQyOUSa8cTmNvRHPKqdnOCWNeojGbreBO+DcIHqnRmNEcBH8WP4L6A+m4apaI657qNIwWFtNy75LsDKjRj9lIP/3+DQUmEgS5nCMXHfD8Cc1WkyuT29oFTAiIOxG9QrgWkLLwaJwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKPiEQDe; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725dbdf380aso1778933b3a.3;
        Mon, 09 Dec 2024 18:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733796413; x=1734401213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFFoOVv6RWfbMMJyWo8grqya93jLFLYBfyNkKFEN5gs=;
        b=KKPiEQDeowX//qvHyFvHO7j2As40Wy0M6MJLYpod/b/f6/0xhS9/PGHcYEqxXFAfRb
         qCJF74Nmn7OpKI1JG5Tji4m2baxlR2O8afFlgZtZ23qtDFvUzVyHZKvKuT924YxaRzCx
         2/E/CMjXXu00bZdZn04MWjSy3PawibwFb7IZ4FwSUh3AtY7/UNdETac0KpFDjNOIFH7x
         kjzFiM0vBziEglI2SoFT0L1YeMmbl5Bgu9ByCuzdrO1wQcdu2Sa5laCJcVEGx0OMyIpo
         2+MSrLeOXiguCvhjigUEJ0R1vkfNaHUHSpZznBay6iS81/xEX59t/GYJAER19GI3DZYS
         8Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733796413; x=1734401213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFFoOVv6RWfbMMJyWo8grqya93jLFLYBfyNkKFEN5gs=;
        b=hcLgOSj+z+YzKFB3eetvVn7VIGOxjpVqOam9AIvfAOKpUP542ShEiPWrCfA6vF0BhP
         wPRAEvbgCrCQHqJLuUMV5cxewEfuqUDz+EURGE9yhH/5j8pcCmeNWF3Lab60a5phiP60
         Bn/39VvtNnHZN67rXaNxG6NTT1G04BauLv6eGdL3OytcQpztrBbH7W8NhCZy87sCLLci
         pnF0YrPW/h5WaYodGczn1RGxTLgSwOyPJ99zN1wK2Q4pZEYDkPvxJ8k64LUbUb+8r7z6
         576ZBqQ8y0koaiSPuJZ/t3x8r9M/ZzxtWw+db2R/CL9TNJs7/ZskduT0z1YvNvJfWtGr
         TwvA==
X-Forwarded-Encrypted: i=1; AJvYcCXVucan7cdMffsYabx5TVVqFgsXnNK88Kj8jDYo7gwMS8cm+mKYMnEld+M+Gf/ReLzQ6A1TbpIh6EKl3exgj2Ia1hOyzg==@vger.kernel.org, AJvYcCXcpZCqdPw1E4i3h0wJ7zEpKZZCIrzeW/Sj1b9P84Xi9ATpA9iTb4+eu9AgNWl9tZsuSwijwFXAvtHSnFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmXvuoL+okNrSMK5a7K0JXXBb1RAY3IoYVFT127tM/q7o+lWQ
	Iu3hCVqpjFZc4LckLB0WMAeoxB5YEn5klFz+1/Cu50medn24WwQX
X-Gm-Gg: ASbGncv9T5vVAB4DP//5X2NGw1sD6gC+iMy+rcF+vcBrWt9tSkNPSREP0RnLAzVmSs0
	QsAK/uLpyUEb4kyJxcip5rJsFcFzrGiZXFWeAqx0G0TMWwZfsqDn20v6xulP0pAOyXebc3xkqjl
	k0jUNq8oFniBEeG/yjfxfIPz37csDaJtCxG4qSNuy5TNY32KAIROdAJAq5Sz41V3nrfjutWu5mH
	bfE63HpNoTWYQkMUT1TE6BfIzz1frkIZ/Tcz6tbCHsCtL4RuCGf3JYJqw4IdcRlrk2S//jdQ8bP
	4snElTZczypL
X-Google-Smtp-Source: AGHT+IHTiTyq5GRaSOJWq0P3dNR9nIw/0WMy7E1tpHjwT1LqS3PI3UsEFR6Ze9u5g/mezf9sjxfO+w==
X-Received: by 2002:a05:6a00:10d5:b0:71e:16b3:e5dc with SMTP id d2e1a72fcca58-7273cb8561bmr3887066b3a.19.1733796413232;
        Mon, 09 Dec 2024 18:06:53 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5ad8sm8246388b3a.8.2024.12.09.18.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 18:06:52 -0800 (PST)
Date: Mon, 9 Dec 2024 23:06:49 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] platform/x86: acer-wmi: Improve error handling
 when reading gaming system information
Message-ID: <i4jcyhqxfugfykbtvrwba4udln4l2cgk7zgj3sy7iqncf47a4q@exk6jk7rmmvk>
References: <20241210001657.3362-1-W_Armin@gmx.de>
 <20241210001657.3362-4-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210001657.3362-4-W_Armin@gmx.de>

On Tue, Dec 10, 2024 at 01:16:55AM +0100, Armin Wolf wrote:
> If a call to ACER_WMID_GET_GAMING_SYS_INFO_METHODID fails, the lower
> 8 bits will be non-zero. Introduce a helper function to check this and
> use it when reading gaming system information.
> 
> Tested-by: Rayan Margham <rayanmargham4@gmail.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/acer-wmi.c | 55 +++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index dd57787466b9..ac4500f33b8c 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -70,6 +70,7 @@ MODULE_LICENSE("GPL");
> 
>  #define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54
> 
> +#define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK_ULL(7, 0)
>  #define ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK GENMASK(20, 8)
> 
>  /*
> @@ -1513,6 +1514,24 @@ static acpi_status WMID_gaming_get_u64(u64 *value, u32 cap)
>  	return status;
>  }
> 
> +static int WMID_gaming_get_sys_info(u32 command, u64 *out)
> +{
> +	acpi_status status;
> +	u64 result;
> +
> +	status = WMI_gaming_execute_u64(ACER_WMID_GET_GAMING_SYS_INFO_METHODID, command, &result);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	/* The return status must be zero for the operation to have succeeded */
> +	if (FIELD_GET(ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK, result))
> +		return -EIO;
> +
> +	*out = result;
> +
> +	return 0;
> +}
> +
>  static void WMID_gaming_set_fan_mode(u8 fan_mode)
>  {
>  	/* fan_mode = 1 is used for auto, fan_mode = 2 used for turbo*/
> @@ -1762,22 +1781,23 @@ static int acer_gsensor_event(void)
> 
>  static int acer_get_fan_speed(int fan)
>  {
> -	if (quirks->predator_v4) {
> -		acpi_status status;
> -		u64 fanspeed;
> +	u64 fanspeed;
> +	u32 command;
> +	int ret;
> 
> -		status = WMI_gaming_execute_u64(
> -			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
> -			fan == 0 ? ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED :
> -				   ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED,
> -			&fanspeed);
> +	if (!quirks->predator_v4)
> +		return -EOPNOTSUPP;
> 
> -		if (ACPI_FAILURE(status))
> -			return -EIO;
> +	if (fan == 0)
> +		command = ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED;
> +	else
> +		command = ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED;
> 
> -		return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
> -	}
> -	return -EOPNOTSUPP;
> +	ret = WMID_gaming_get_sys_info(command, &fanspeed);
> +	if (ret < 0)
> +		return ret;
> +
> +	return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
>  }

I wonder if it's necessary to refactor this function if you are going to
drop it on Patch 4.

> 
>  /*
> @@ -1942,12 +1962,9 @@ static int acer_thermal_profile_change(void)
>  			return err;
> 
>  		/* Check power source */
> -		status = WMI_gaming_execute_u64(
> -			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
> -			ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS, &on_AC);
> -
> -		if (ACPI_FAILURE(status))
> -			return -EIO;
> +		err = WMID_gaming_get_sys_info(ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS, &on_AC);
> +		if (err < 0)
> +			return err;
> 
>  		switch (current_tp) {
>  		case ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO:
> --
> 2.39.5
> 

