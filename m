Return-Path: <linux-kernel+bounces-514346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44531A355DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD5416D5CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952F415FA7B;
	Fri, 14 Feb 2025 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsObSJu7"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC9478F35
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508637; cv=none; b=Hl5IR0AfeUZI8PRDdpCEk3Eb/FFdo3VtbN4wtFQ7lt5a13LAN47vuz3lmUBMVr/Tu7D198j/loBhgSMnjeDIlbQNboUUBkOiPpPJhDWz79z6oMgYzS8r5dsSmiA1xmHX1oN2+uSk00LyP1J2aByk34Z2MQt6XvObCLpMjGhJ7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508637; c=relaxed/simple;
	bh=JVnrdPXmM4Po3IZZ63TAb9eYXX/XHDNGrSNlcEf2wPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZQc+Im9l+R+5jAcrdY0MIUh0bWyC9VM2ougaH+hogGcX0CX7pE+SSRC57kV0iGflr5tlZKoFgvBGVPkBH+Z6rHzyOlE4RakEnnPiZCf8tygm9S6tUkGuUuT7PRP5K9AMcQ76StAgTWVZkU+8oQ3jXaHBcMDSIlIBlXuy5W11UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vsObSJu7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fc1f410186so1793512a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739508633; x=1740113433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QO+zu628e71NdcN+8zZrldfWoYIRQKoPd1ObPN5VIh0=;
        b=vsObSJu7BCpIqb6yF2nOaf/kl4E0+sRksLooZACn0O23G9UHtVO5z5XHLBrNhMlsz7
         ormfTApd72ijnfhm9tZsxxAZbW5g2ZSWfro5fde+zL8h0sNfjcMAvys5d/fe2Vl7pEtS
         0IpNVVqNi2GLty5hY0Vl/mtWQ6VZUWW61AhMazZMojseJfkrFjDEVN2bKoKxTd+JN7U4
         Hk7ETXOR0Dli//9rJGI/4gDkmneDKNJzjRwfJ3a5Wr4odnt1ywCBhYT+6hSYcc8rVvaW
         byjdsQdki3crhIFflo8/BtneA4xfNMHqO/jHptPLK1Wpd41H1BJiqPb/dWQJOkOXpgL7
         PhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508633; x=1740113433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QO+zu628e71NdcN+8zZrldfWoYIRQKoPd1ObPN5VIh0=;
        b=MDK57Vyj8hS8aHZsR/cZwX1FQAj4eXgZ7G3/2qyPGMb3EnHOy3xtB03S7EilPckiCh
         A5Bo1SaTRSoKc+kPuCp3e4KeCQYjtd3juOFvckotPk+ZSjjJppSH0frv8al++LPQxWfn
         JHBkUP63rpIHcFYjoIIvlclTjRV0oz7QOxuSE2Jde9xrqyww7ZuVBh/T4HnKNkG0OrF+
         Dq8oGf0aUnjNWwcHhggKvUJl7uITcajr75XADxK2fqe8yfDXby4yS5iTno2K3Wpb1OzK
         pYQVxCa721ZH1unclqn2Lg0Ef32gOh9hlcL8VQdgZTy1dbK3G338thIA6dlFRIp5IY/G
         fVRA==
X-Forwarded-Encrypted: i=1; AJvYcCUivziKs2jetDToBycDvjvZQVVdQcOwYyGdrTEwmrCKx+/JXZhj/YVXnUsfYRwghWAyKLi7SUM00no6848=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSp8MLDZm3eAd3Q/y0nk2XwN17kTyiwmJO/rKZ14B2mdgJ3uQI
	619ZdVkQ/sQUWkUNUMf71zsgGUUw3pAmNOXmGW0R5qonHw6WJt3tnKoKMOmUpEI=
X-Gm-Gg: ASbGncvgAhLeMYYJz8iKIuqb/sfs2I8l4Y4EZNXvryXNvyassdED/SaKDnDb40lD1qU
	MSk/hswmrt6wpbgNXfUJX1pr/y0EsRN5Fj/tNatmm9LM9hihL4jbL+rP5k9+ZDTOS/rhwmH0kB8
	5LEYD4oc8e1+F359wvUSPXzAm63ZgupS82xyZJAT1EKvzciinQi5wp4YYAsIGUDrwjLnARUqI2r
	wbSEqoeJVK4iMOADWTGpzmMoYaE2BbRPI1B2Y7IfyK5Kn+C4I6101jn7EbzO/mv7NL4VJQrP/GQ
	3hUcNhJZ+Gu30b0XiQ==
X-Google-Smtp-Source: AGHT+IEu0lDtclxbef6UwbmqEzWYZeKYwYx7xgSjvSbLYwRCBVDhhxMCDEy15vcZ987LsGRPTI7VuA==
X-Received: by 2002:a05:6a00:3e0b:b0:730:940f:4fbf with SMTP id d2e1a72fcca58-7323c8dd0cdmr9141926b3a.2.1739508633461;
        Thu, 13 Feb 2025 20:50:33 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324d5d4608sm728338b3a.129.2025.02.13.20.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:50:33 -0800 (PST)
Date: Fri, 14 Feb 2025 10:20:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/18] firmware: arm_ffa: Refactor addition of
 partition information into XArray
Message-ID: <20250214045030.mfegbypq27gdl6sg@vireshk-i7>
References: <20250131-ffa_updates-v2-0-544ba4e35387@arm.com>
 <20250131-ffa_updates-v2-6-544ba4e35387@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131-ffa_updates-v2-6-544ba4e35387@arm.com>

On 31-01-25, 11:24, Sudeep Holla wrote:
> @@ -1461,39 +1480,18 @@ static int ffa_setup_partitions(void)
>  		    !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC))
>  			ffa_mode_32bit_set(ffa_dev);
>  
> -		info = kzalloc(sizeof(*info), GFP_KERNEL);
> -		if (!info) {
> +		if (ffa_xa_add_partition_info(ffa_dev->vm_id)) {
>  			ffa_device_unregister(ffa_dev);
>  			continue;
>  		}
> -		rwlock_init(&info->rw_lock);
> -		ret = xa_insert(&drv_info->partition_info, tpbuf->id,
> -				info, GFP_KERNEL);
> -		if (ret) {
> -			pr_err("%s: failed to save partition ID 0x%x - ret:%d\n",
> -			       __func__, tpbuf->id, ret);
> -			ffa_device_unregister(ffa_dev);
> -			kfree(info);
> -		}
> +

Why extra blank line here ?

>  	}

-- 
viresh

