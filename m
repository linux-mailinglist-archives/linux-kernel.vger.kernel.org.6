Return-Path: <linux-kernel+bounces-399657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F17B39C026B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C36B221C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F521EC014;
	Thu,  7 Nov 2024 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4vfC4J5"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88231EABB4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975568; cv=none; b=cBMBYBxNKzJ6PtX1gKrIutfa1jymNEsRYVESiSyZCs3jclz9kH8cIiZtBubG2W9irbAewVVX6WMLiHoyCD8vg23r5+E6t1VuSBznhh16UV/lGPe5p/4Jm1BOZCnCowndMD5S3DaYQvGpvssiKfUJyE0ExpgafEUmZhA/Ggq6BzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975568; c=relaxed/simple;
	bh=6j/q5jZeNYIJaSJBIbNYp8UldWBNDl1RRgHXzxLCPuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS2JFNO4LcM5GmXeBaH4jimB4dAEQvxAW6QPcgjAPSinFGQUa3MpbmTONo4ZqUy66s+/4ZM+saRAN3jIWOCKqBY4KthxjMLJys1kuYj9iS9GuBu958fWkc0UqbYXKCtIwtUSB6XqrurU5LPSMu9rQHxFAMhyHPWYhryLQYlIsrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4vfC4J5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86e9db75b9so118430266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 02:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730975565; x=1731580365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+Td2/TyRkFUos1mmxN0m9Ig3oWF9OrCgQ+Z1MZuehQ=;
        b=G4vfC4J50DNrK8SRygqKM3Uk8KOFeiiYRAEnfNg3/xBZ7uDEk6hJSpXaf1/RcnfhzI
         kKeIJ90AgA4++eg5eRKZ8xOxaBTPs10U0UyUyvPE7CR1M1nHFaOlXdc+GVmWK2FvT/Cj
         WSZl0SiYpaD3gENmeTgozIacU4DMWkRA7xnlhTOuuNeeg/xkkGAhrlq+ub/WZevGCYBm
         Cz8kLkwwZFiL2yWIji/vr1+fN0CsjRTxTClxDZudZWZwX7C9f0A0dfFMNCbsmpvYm5pd
         P5BSjbiM/qTH7Jz6qMu8TkYb1JLfOZGzmUWLWkJY1Fe2bW3f6YrRI8fzJMUi4X2b6vUX
         Z++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730975565; x=1731580365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+Td2/TyRkFUos1mmxN0m9Ig3oWF9OrCgQ+Z1MZuehQ=;
        b=QzW27E1s2ovFLUzU3/2Fcm7WRVFIkiNZm5ylDujj2RqAOuIe4tBds3M69+gtht5shH
         o/SRUHH8CIoGpDcG7OBLEPXHX3J5hiXl4dGD46jregc9cQXtWZUuT21E5D7xLUSuJJNw
         fGtq/zfwHxR/w0oML5PIY+UjLTdBpVdmcQM4xE21+UaY49aH36Ny2AgRG3LVmy0gvZQM
         ZdIN6bnDPYKvWEdgSUtNvHSDEWXAwUjn5U5UXNVrKPqC2OyTo5ng/osK/qJc3q4WBGZc
         ssqJ4Xydb3bzHcS1Ldffl7sb+RL4xRImpvzB4JBCx2qplP1dN9vH4Msn03IBg3GZlC1l
         kUbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl2xzlboBgpBEKsLmjtILQuS0pZWl5Y/dC+FewKRab6/vqgge+lWMCucHRUqsSQqV4+aeKs6ScKzHyD1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRUtJfsa/efZl+UPtgiHM6EaeIba7I6/Xa8LewdBzaxIZXeEB
	qDbqJC++0tO7MMLROZsFzrLSP5wwAV99JgeWNxg3xTCzkjhke8wNkfNnSBrf8bXZnXx5zHx4jIM
	UWZs=
X-Google-Smtp-Source: AGHT+IFvw+FygKnAy8Ch/kBDfr35WGGevKEtvuhSueC9z6MRjETciD3o758OcY1MT1zwUgt49IrSQw==
X-Received: by 2002:a17:906:7952:b0:a9a:123d:3f1a with SMTP id a640c23a62f3a-a9ee74a204fmr42451966b.17.1730975565240;
        Thu, 07 Nov 2024 02:32:45 -0800 (PST)
Received: from localhost ([89.101.241.141])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7c455sm612174a12.73.2024.11.07.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:32:44 -0800 (PST)
Date: Thu, 7 Nov 2024 13:32:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, daniel.baluta@intel.com,
	shubhrajyoti@ti.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com
Subject: Re: [PATCH v2 1/2] staging: iio: ad9834: Correct phase range check
Message-ID: <333c54f3-3d4b-4038-94a9-ce8396b452ce@suswa.mountain>
References: <20241105140359.2465656-1-quzicheng@huawei.com>
 <20241107011015.2472600-1-quzicheng@huawei.com>
 <20241107011015.2472600-2-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107011015.2472600-2-quzicheng@huawei.com>

On Thu, Nov 07, 2024 at 01:10:14AM +0000, Zicheng Qu wrote:
> User Perspective:
> When a user sets the phase value, the ad9834_write_phase() is called.
> The phase register has a 12-bit resolution, so the valid range is 0 to
> 4095. If the phase offset value of 4096 is input, it effectively exactly
> equals 0 in the lower 12 bits, meaning no offset.
> 
> Reasons for the Change:
> 1) Original Condition (phase > BIT(AD9834_PHASE_BITS)):
> This condition allows a phase value equal to 2^12, which is 4096.
> However, this value exceeds the valid 12-bit range, as the maximum valid
> phase value should be 4095.
> 2) Modified Condition (phase >= BIT(AD9834_PHASE_BITS)):
> Ensures that the phase value is within the valid range, preventing
> invalid datafrom being written.
> 
> Impact on Subsequent Logic: st->data = cpu_to_be16(addr | phase):
> If the phase value is 2^12, i.e., 4096 (0001 0000 0000 0000), and addr
> is AD9834_REG_PHASE0 (1100 0000 0000 0000), then addr | phase results in
> 1101 0000 0000 0000, occupying DB12. According to the section of WRITING
> TO A PHASE REGISTER in the datasheet, the MSB 12 PHASE0 bits should be
> DB11. The original condition leads to incorrect DB12 usage, which
> contradicts the datasheet and could pose potential issues for future
> updates if DB12 is used in such related cases.
> 
> Fixes: 12b9d5bf76bf ("Staging: IIO: DDS: AD9833 / AD9834 driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---

Fair enough.  Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


