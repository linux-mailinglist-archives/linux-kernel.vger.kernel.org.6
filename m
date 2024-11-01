Return-Path: <linux-kernel+bounces-392896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351E59B9960
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB6A1C213BD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1691E2306;
	Fri,  1 Nov 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMqTJxHN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0711D89E9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492596; cv=none; b=WnGbc1xn5ZO8l5s3/avJHO4sTtu7gFnFZSQMOYFlUdmneV65clvnHXYMfMOCB+8F6xDb2RKH/OzjxoaIBqGzcUCxq5jdkvYg+BwE+15VO+sIoJdCthAJPVTGpwKRKIa6Hn9pTscDs2SOea0TxGGjd4n5QOKSpN6dO5br5vcdTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492596; c=relaxed/simple;
	bh=WZhkCcdsofu4QIHz3gE1Rnefl/2DkGbEznDbjjYDYc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaO0G53ci2h8o659qZpMzm84VBNOh81iMlHsZFf2G/NW+FemlWaKHmR6f2Go1aLbR6ScdN5rzd0YcZVf6f6hZr7o0wjJb+F8z2NwSKQ8yqAK3kZx2gJWUO9tn0fX/+W8A5ncmZ+0mtBQwYuyTXBZUKJPD4sG0viVXhNACUVcADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMqTJxHN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730492594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ANub1/K4e3v/MYOsC1JtMcjz48WvDQab142m5XRSVWc=;
	b=bMqTJxHNyPILM360uhqi5JqzOByYffbXjGvxNQtR9vDhf/dWjOQEuYfyAV5zxjE+hpVqBo
	rcG1ROoFoXPZqgxKz1HfEwZZNcT65nyDvdfYY9goJsvt2AWFVoRjooEk1yHXigfF4gbely
	ESO7hW73apOemMRkpVwlVDd9F2tq9Fc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-jc-qUOeNOv2yrmaSgl3POw-1; Fri, 01 Nov 2024 16:23:12 -0400
X-MC-Unique: jc-qUOeNOv2yrmaSgl3POw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b155c120daso320255485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730492592; x=1731097392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANub1/K4e3v/MYOsC1JtMcjz48WvDQab142m5XRSVWc=;
        b=KBoQM+p+YaaOvcQ3H3HLmFuoNsrhhlCvnGfVk5hBIaO95xduDqORjMJk9iucD7+wCV
         0fFSAGRmgtyIKyGAMIAlHYHNAsg9ofDHnGtEx2gzLzkBw4uldcM0Q8lCkAyHfs/KMrs6
         zpB0O45buoJY/tV+WrDYf1zgDTX4J4h3FJPLoGhQHazHJoLcgyJ10Uw/A9976N00HSx8
         zFWZr3Smm/HYxZQBuJiuixaLphzVL9VWGrUhD3xTILzDyJVb+kE9Tc1XZ3jwNjK8eGX4
         VdXsVn7vXjIC67zWHuzG8KXIj/EvRMIBmQerqekYGX98OTiDtWQOor3RrzLuz9blXtFF
         Uwcw==
X-Forwarded-Encrypted: i=1; AJvYcCXtFCDfyyK0RpIwDLwKD2cTiInMLIxg9bZIQdby911PEYn1R3AdcA74mEZtufZGeK7b2SMQZ8XTMp799SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHxDS7RF4OvDZpGABbiZ/lw0UVb3zPzKD1KDwgsY5xYsnje406
	Mf5c7pcDKRrWjdI2LWNJF3J0Hzd7NUWRXWnCq/j9hoNu1lfylYN22i0YeE3Vhe9a7cgisXzzfA+
	uzVZpg2jwqi6Hjqkdo5Hw6oLFZq+iKFiucMFNg5GObkyiWxCsNv0LHkNNIMPC5w==
X-Received: by 2002:a05:620a:458e:b0:7af:cf07:905b with SMTP id af79cd13be357-7b193ee16efmr3456684685a.2.1730492592273;
        Fri, 01 Nov 2024 13:23:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9xVNPcq1jmK7aJ5QBENQFMna7+p8sUgLMxELKbukLjbWMZ4mTiKOGmCsnmG43Hqb4mVdQ6A==
X-Received: by 2002:a05:620a:458e:b0:7af:cf07:905b with SMTP id af79cd13be357-7b193ee16efmr3456681685a.2.1730492591925;
        Fri, 01 Nov 2024 13:23:11 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a10a39sm203788285a.66.2024.11.01.13.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:23:11 -0700 (PDT)
Date: Fri, 1 Nov 2024 13:23:09 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	stable@vger.kernel.org, Mike Seo <mikeseohyungjin@gmail.com>, 
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tpm: Lock TPM chip in tpm_pm_suspend() first
Message-ID: <ke4tjq5p43g7z3dy4wowagwsf6tzfhecexkdmgkizvqu6n5tvl@op3zhjmplntw>
References: <20241101002157.645874-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101002157.645874-1-jarkko@kernel.org>

On Fri, Nov 01, 2024 at 02:21:56AM +0200, Jarkko Sakkinen wrote:
> Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
> according, as this leaves window for tpm_hwrng_read() to be called while
> the operation is in progress. The recent bug report gives also evidence of
> this behaviour.
> 
> Aadress this by locking the TPM chip before checking any chip->flags both
> in tpm_pm_suspend() and tpm_hwrng_read(). Move TPM_CHIP_FLAG_SUSPENDED
> check inside tpm_get_random() so that it will be always checked only when
> the lock is reserved.
> 
> Cc: stable@vger.kernel.org # v6.4+
> Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
> Reported-by: Mike Seo <mikeseohyungjin@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219383
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v3:
> - Check TPM_CHIP_FLAG_SUSPENDED inside tpm_get_random() so that it is
>   also done under the lock (suggested by Jerry Snitselaar).
> v2:
> - Addressed my own remark:
>   https://lore.kernel.org/linux-integrity/D59JAI6RR2CD.G5E5T4ZCZ49W@kernel.org/
> ---
>  drivers/char/tpm/tpm-chip.c      |  4 ----
>  drivers/char/tpm/tpm-interface.c | 32 ++++++++++++++++++++++----------
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 1ff99a7091bb..7df7abaf3e52 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -525,10 +525,6 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>  {
>  	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
>  
> -	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
> -	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
> -		return 0;
> -
>  	return tpm_get_random(chip, data, max);
>  }
>  
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 8134f002b121..b1daa0d7b341 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -370,6 +370,13 @@ int tpm_pm_suspend(struct device *dev)
>  	if (!chip)
>  		return -ENODEV;
>  
> +	rc = tpm_try_get_ops(chip);
> +	if (rc) {
> +		/* Can be safely set out of locks, as no action cannot race: */
> +		chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> +		goto out;
> +	}
> +
>  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
>  		goto suspended;
>  
> @@ -377,21 +384,19 @@ int tpm_pm_suspend(struct device *dev)
>  	    !pm_suspend_via_firmware())
>  		goto suspended;
>  
> -	rc = tpm_try_get_ops(chip);
> -	if (!rc) {
> -		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -			tpm2_end_auth_session(chip);
> -			tpm2_shutdown(chip, TPM2_SU_STATE);
> -		} else {
> -			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> -		}
> -
> -		tpm_put_ops(chip);
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		tpm2_end_auth_session(chip);
> +		tpm2_shutdown(chip, TPM2_SU_STATE);
> +		goto suspended;
>  	}
>  
> +	rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
> +


I imagine the above still be wrapped in an else with the if (chip->flags & TPM_CHIP_FLAG_TPM2)
otherwise it will call tpm1_pm_suspend for both tpm1 and tpm2 devices, yes?

So:

	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
		tpm2_end_auth_session(chip);
		tpm2_shutdown(chip, TPM2_SU_STATE);
		goto suspended;
	} else {
		rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
	}


Other than that I think it looks good.


>  suspended:
>  	chip->flags |= TPM_CHIP_FLAG_SUSPENDED;
> +	tpm_put_ops(chip);
>  
> +out:
>  	if (rc)
>  		dev_err(dev, "Ignoring error %d while suspending\n", rc);
>  	return 0;
> @@ -440,11 +445,18 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
>  	if (!chip)
>  		return -ENODEV;
>  
> +	/* Give back zero bytes, as TPM chip has not yet fully resumed: */
> +	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED) {
> +		rc = 0;
> +		goto out;
> +	}
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		rc = tpm2_get_random(chip, out, max);
>  	else
>  		rc = tpm1_get_random(chip, out, max);
>  
> +out:
>  	tpm_put_ops(chip);
>  	return rc;
>  }
> -- 
> 2.47.0
> 


