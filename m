Return-Path: <linux-kernel+bounces-577366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E72A71C21
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29997166AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06A1F5850;
	Wed, 26 Mar 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnP60zG4"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7543D1F7075
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007506; cv=none; b=HXMbSARAMCmMwu9pZFxJCgYYuLIcyUp0DmgYxUbmPN8FcgoKKDdcMzGBcbtOl8K5kQFZAg/j+zHxqMFkf1acr2QvQ0/P+DWRNhotaf5PBeDyeN3Ddmjaz5nEpiT9fvXMqOP/RX4NxtZDHoKwWqTSrue8ByMqnRNZ9YqaU6kcNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007506; c=relaxed/simple;
	bh=+Vg7qfjngvUxeC9pBRayk4qvu/QCUzrPfdR/PUAsoHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRwPItnrew/j8GK6txOqx8CpbUOZX4AM2/2ROlV73Hf3RrYbsGDT4PcDUVlhIsCzbvIa6OHTy7I80C6+G1uVzbCtVhSARJfSycgYi8rcjdyLXvDq8NKWVfW04ijubz3LaHlr49XBOfHy1couBEybL7M/fHyAbP2UAFoJxzIJwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QnP60zG4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abbb12bea54so6085966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743007503; x=1743612303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TJcS26LBUOhpjAbenzEObokE4HdnvqfrqILTFguP4A8=;
        b=QnP60zG4whwVYRk/uZiAv98SjFv4TfLMdfojvhTFVdPXwJ7jcnlGRlkn4WKPQGsG9s
         3eYeYQ+BNofiIjT6u9giG1lSiHIwgTiydiP3zorVCRM/fwocYxS/se/uDDZPBRjaybq+
         JcyVOYxzXmpM/bNOMD8wLAB5I8po0HqcQrDDmzFVumwsnSP1y1smHgjOe/7BI/Ju52OU
         g8JWiSnWTDC4G40Qa9JIayDn1Hv25LkfUFrcbG99Zp7A5rM8di5k7oiZUgEsHWKdzPwx
         6aKS+f6g8DJtmdOD1rBsJtEQmZfwYV8c7zxucEn0Bfjb3QK9wm2i/3cDkR9WEtuv9eia
         U7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007503; x=1743612303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJcS26LBUOhpjAbenzEObokE4HdnvqfrqILTFguP4A8=;
        b=djsarEJ7nAdIpy5KP7mkrroC7H5wmsAjWy0BP1HCN9He1Dt8fZ0LAXR6dZMHb2+V1R
         Uqh1pkbNz3tdliP36EbjVnHHq9xjWIYEDuiVuhMj6q95vp8yYz9fbhbJF9PtcS0ghMQN
         oogrprpyQKqvvwa8Pnv11wcU6NySx0GfPORQvgnggXDRkNdlpATIWfvs/CewicuqyIZw
         TTIYVS2tjKedklg6Ntnuy5585GVYEpAm1V2yW7S9QCnL6ul2IoBFReDDcGK1StUQP9hd
         vrP3aHiCa69U3fTZPm+2Az2AJU65zBHxajkNsks0ujSNthSlF0MHNIfX/ajtMAeUrxQ/
         kIiw==
X-Forwarded-Encrypted: i=1; AJvYcCXn6ppg7y3625cbcpcwI6MIgwBNbFpVeZ2/eLyV+Ahcmk0bOZZL1XhqOMIcnvwrvd8zhDpnTuEfTqsNrgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQVAXutRaEYds7gQXOAtwevnNtNsd1PvCrGwkJ3uvmGcxZ22Xo
	ytd2nFoFkj8trTKhNXoxJIFEoxIveDuNQvrgIw9GBg//0KTHGk9GsGtY6Tmfag==
X-Gm-Gg: ASbGncs15vrqfJLe4yj8lDPXH35I7VQNZP+xcL3meMSGqlvNuVifgFGWex37sMPyra9
	vOg60trufgpIYkI5Fcq8JK/699hn/LFDBI635TGqzPWs0vWlDLjm18AYX9Sgj7sX96ZM5rmZn8b
	fbyDhmgPDlvYkEisVSTkONggEi+Gcp1vNbW7Fe2byMSY9ZecwVDGZDOnNy/yvH91XCFItBNOQEc
	LZbPs56iUyRvPzAgoLL+qP7FdM7duCbmEcb6pHKDrkE5PrvbshI0m58Pnehuky3XXADKu4cg7C3
	wCHp9/rrrHp/EPdHzTwkq6cQPTiYdCo1JNTyLuUOwc1V6EgZzi8QMdeioL/h02vWefgC60l+b1m
	vagk=
X-Google-Smtp-Source: AGHT+IGOVJHC73PxBi8VOaVjs2DbOvsUBkfBcTBTYm45C4g3UAljCGATrWdzKXaReM4hH2C/WCgTfg==
X-Received: by 2002:a17:907:1b10:b0:ac4:3d0:8bc8 with SMTP id a640c23a62f3a-ac6fb0fcd76mr8333166b.35.1743007502398;
        Wed, 26 Mar 2025 09:45:02 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb52279sm1052173966b.116.2025.03.26.09.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:45:01 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:44:58 +0000
From: Quentin Perret <qperret@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, snehalreddy@google.com,
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com,
	will@kernel.org, yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v4 2/3] firmware: arm_ffa: Move the ffa_to_linux
 definition to the ffa header
Message-ID: <Z-QvCvGBCtkxNG-e@google.com>
References: <20250326113901.3308804-1-sebastianene@google.com>
 <20250326113901.3308804-3-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326113901.3308804-3-sebastianene@google.com>

On Wednesday 26 Mar 2025 at 11:39:00 (+0000), Sebastian Ene wrote:
> Keep the ffa_to_linux error map in the header and move it away
> from the arm ffa driver to make it accessible for other components.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Quentin Perret <qperret@google.com>

> ---
>  drivers/firmware/arm_ffa/driver.c | 26 --------------------------
>  include/linux/arm_ffa.h           | 27 +++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 2c2ec3c35f15..3f88509a15b7 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -61,30 +61,6 @@
>  
>  static ffa_fn *invoke_ffa_fn;
>  
> -static const int ffa_linux_errmap[] = {
> -	/* better than switch case as long as return value is continuous */
> -	0,		/* FFA_RET_SUCCESS */
> -	-EOPNOTSUPP,	/* FFA_RET_NOT_SUPPORTED */
> -	-EINVAL,	/* FFA_RET_INVALID_PARAMETERS */
> -	-ENOMEM,	/* FFA_RET_NO_MEMORY */
> -	-EBUSY,		/* FFA_RET_BUSY */
> -	-EINTR,		/* FFA_RET_INTERRUPTED */
> -	-EACCES,	/* FFA_RET_DENIED */
> -	-EAGAIN,	/* FFA_RET_RETRY */
> -	-ECANCELED,	/* FFA_RET_ABORTED */
> -	-ENODATA,	/* FFA_RET_NO_DATA */
> -	-EAGAIN,	/* FFA_RET_NOT_READY */
> -};
> -
> -static inline int ffa_to_linux_errno(int errno)
> -{
> -	int err_idx = -errno;
> -
> -	if (err_idx >= 0 && err_idx < ARRAY_SIZE(ffa_linux_errmap))
> -		return ffa_linux_errmap[err_idx];
> -	return -EINVAL;
> -}
> -
>  struct ffa_pcpu_irq {
>  	struct ffa_drv_info *info;
>  };
> @@ -238,8 +214,6 @@ static int ffa_features(u32 func_feat_id, u32 input_props,
>  	return 0;
>  }
>  
> -#define PARTITION_INFO_GET_RETURN_COUNT_ONLY	BIT(0)
> -
>  /* buffer must be sizeof(struct ffa_partition_info) * num_partitions */
>  static int
>  __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index 74169dd0f659..cdaa162060f4 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -223,6 +223,9 @@ extern const struct bus_type ffa_bus_type;
>  /* The FF-A 1.0 partition structure lacks the uuid[4] */
>  #define FFA_1_0_PARTITON_INFO_SZ	(8)
>  
> +/* Return the count of partitions deployed in the system */
> +#define PARTITION_INFO_GET_RETURN_COUNT_ONLY	BIT(0)
> +
>  /* FFA transport related */
>  struct ffa_partition_info {
>  	u16 id;
> @@ -475,4 +478,28 @@ struct ffa_ops {
>  	const struct ffa_notifier_ops *notifier_ops;
>  };
>  
> +static const int ffa_linux_errmap[] = {
> +	/* better than switch case as long as return value is continuous */
> +	0,		/* FFA_RET_SUCCESS */
> +	-EOPNOTSUPP,	/* FFA_RET_NOT_SUPPORTED */
> +	-EINVAL,	/* FFA_RET_INVALID_PARAMETERS */
> +	-ENOMEM,	/* FFA_RET_NO_MEMORY */
> +	-EBUSY,		/* FFA_RET_BUSY */
> +	-EINTR,		/* FFA_RET_INTERRUPTED */
> +	-EACCES,	/* FFA_RET_DENIED */
> +	-EAGAIN,	/* FFA_RET_RETRY */
> +	-ECANCELED,	/* FFA_RET_ABORTED */
> +	-ENODATA,	/* FFA_RET_NO_DATA */
> +	-EAGAIN,	/* FFA_RET_NOT_READY */
> +};
> +
> +static inline int ffa_to_linux_errno(int errno)
> +{
> +	int err_idx = -errno;
> +
> +	if (err_idx >= 0 && err_idx < ARRAY_SIZE(ffa_linux_errmap))
> +		return ffa_linux_errmap[err_idx];
> +	return -EINVAL;
> +}
> +
>  #endif /* _LINUX_ARM_FFA_H */
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

