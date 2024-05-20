Return-Path: <linux-kernel+bounces-183454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E5D8C993E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8109CB215D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770C01B59A;
	Mon, 20 May 2024 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/ihDRJb"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E41862F
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716189918; cv=none; b=NQWh0b9kWIqneS6mj9/grg9GSBNmwwMjsviHl5MIfG++rzHRN8tImhQLU6mooRlT9AaJIY2TPc1tmfNYqNZDLnwXOsUiH9GXIECXMaYjCYe7czRTXv4YtJRq9XBiO2gFRj8e7kbiZjMjvXVaYOv9YqEkqW+AtfJ+KBQsfoTUG2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716189918; c=relaxed/simple;
	bh=+fObv7pYjpDl9fdzZP147nI7QMSBzyYiYdYAVlbJC1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQDchYvRBl6htyKk6X31/atEqo+TN82heNGcyLSkms+UVCSIqzkQsjvYFkMsr60dkgFdI/UVglgkwUNbzz6Qf7baZ/8gPAXEBDzw6PX/oBejVHx53eh4omITLeEh4XnNTrfkH+1+b0j6kDcSbCjuFFgznKUN7SWK10CGJAa5UnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r/ihDRJb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ed0abbf706so62998835ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716189916; x=1716794716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SFdmcNpzRo2oo+yppr3+cUzOw6aLmc7VZ0+XNX0Zb1s=;
        b=r/ihDRJb0Z/gUar1t1tPHTiw949RFqYvJzblzQYOmyylS8U7OEAqeE30oIX7Ndg5oa
         ONWauew3GMAoeHKak8/xOvzaFRhjOD/MgGd/4RZT/X/JKKOuqhkX10Wzb1dBovFYDyMZ
         JRNt2PSpI3smbheIKWqCg6PIHEbMtM2t+HBPE2NyOp88JW6h552pMBawdggbo2U88Dv7
         8nx+iEbAUyNHpX5VJ7b1NKqcyl5uwupsidBJhSUeTO5KO4G0/fvTXsNN3mXJ9ogyGzLQ
         q1JzNTHDrhsV1w5vanWh2MMlNQoxVe2TRWu+FXcfUIgVdfH8Cp9MdMfYCMBhNWv5+hKb
         27PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716189916; x=1716794716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFdmcNpzRo2oo+yppr3+cUzOw6aLmc7VZ0+XNX0Zb1s=;
        b=MiB+tCrsxGS7CD5uo1reNhEYkqxfetNXiJ9IPARJDwr7CnI+PI9w7b78qV7CUozW+r
         fs9+lBmUjImjJkubVXSve7L3MTrpWXdfQ7V5SMgNOzTPowDdECgmQCpfDYRlgZblqV9g
         S2kyN8xg4unrY67pIvcnHCvuYkB+0Qu8HzWVCJz6kLoFN29TvhcgLYCL5ZOGKxS869GV
         rK1yKfcv7tVbcQt5tGBP1BAsYNEWOiGMEDo4DtLILGnm6gELpyso5xnCABtYZPqC8VuF
         GcDjqRisgvBL4luOyIdB/XdzcStMDa9eKUcicK1sThMMz+hFvmvHNdzx13JMW8Cxe9DQ
         iR/w==
X-Forwarded-Encrypted: i=1; AJvYcCWN7X4P19ZL8UHrN9F3I8LTHydsysoPZ98h+0qC3HYzIQKLqvpfXdvLcj+kDsuJyy8qvdXRw5SnV8pz/RH25YekhmbGYiTo4tJ4Ppkx
X-Gm-Message-State: AOJu0YzrPYrr2L17jzJUIa+tLpqLjeaXbgnVFYJJfao17fjJSWSS7jmN
	GX5HOizmJ98IYdjG+atgBtVaFX/90thFO4o72s74+tR4A9JGHPqnr/OB42ozjLQ=
X-Google-Smtp-Source: AGHT+IErwJLJcVq4YYoQHsxB+z/x6ysdEbBT7kYPibdEh7GbAAShwTr+CfGDco3v8nOOB3tK/ekTFA==
X-Received: by 2002:a17:902:c942:b0:1f2:f3dc:43ee with SMTP id d9443c01a7336-1f2f3dc4ddbmr56186065ad.3.1716189916472;
        Mon, 20 May 2024 00:25:16 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d385esm201022905ad.38.2024.05.20.00.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 00:25:15 -0700 (PDT)
Date: Mon, 20 May 2024 12:55:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: liwei <liwei728@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, Pierre.Gondois@arm.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com
Subject: Re: [PATCH v2] cpufreq/cppc: fix perf_to_khz/khz_to_perf conversion
 exception
Message-ID: <20240520072513.vtlqwjbmxugvuppj@vireshk-i7>
References: <20240506075816.1325303-1-liwei728@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506075816.1325303-1-liwei728@huawei.com>

On 06-05-24, 15:58, liwei wrote:
> When the nominal_freq recorded by the kernel is equal to the lowest_freq,
> and the frequency adjustment operation is triggered externally, there is
> a logic error in cppc_perf_to_khz()/cppc_khz_to_perf(), resulting in perf
> and khz conversion errors.
> 
> Fix this by adding the branch processing logic when nominal_freq is equal
> to lowest_freq.
> 
> Fixes: ec1c7ad47664 ("cpufreq: CPPC: Fix performance/frequency conversion")
> Signed-off-by: liwei <liwei728@huawei.com>
> ---
> v2:
>     - Fix similar issue in cppc_khz_to_perf()
> 
>  drivers/acpi/cppc_acpi.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

