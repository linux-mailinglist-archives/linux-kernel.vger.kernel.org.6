Return-Path: <linux-kernel+bounces-341796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5DC98865B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7200B21496
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF17B282FA;
	Fri, 27 Sep 2024 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxFDqsb7"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E39189F58
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727444268; cv=none; b=WlHqKkS4L7O6B998nZTagPTKsaKgCw4QhutBfow2EREG/zNNKicoUgR7HPVe7lRfFbjMi6Nb+03mTC3N+Mxbl3aln1glYexwr9FVRT+iwOsaZ4tHNzxbgMLXPhRg8IsUMpV1XTWK5hwdEbW/vOCRISAHfIX8HVRACbox8Mk9Xrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727444268; c=relaxed/simple;
	bh=8+XrPKqnUh52/WEs6iih8orIABMrXolWdtJgG75l2U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7Sz7WG08hNqmjBfL+KVCUJbSb8j5FuRogUxt84F+RCNJqOYn9Ub9IFPtQ/YgsqL3dlm1nezt/jmfbu1uFFkAPd00qZ3jLBcSZso+n973ECkHRhv7GWmotsJaNv2LmtoE6Qc80EIgBo4z20dTHthPnl0fCpsA/sz+Mfe6sM7FYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GxFDqsb7; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f7528f4658so20932091fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 06:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727444265; x=1728049065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HTH6ZrGkkYMdX3NtmPgD5++jH73M4Mz7K2Vca6gurDE=;
        b=GxFDqsb7E7AHG9p0HrirzKJCKN8zlNeJtZSmscHi5QdglvtPV392kfRH795vs4pJaQ
         sXPfsGhU8UtuuY+mHAjvCL70c+y/IVTLAdUHosFiHs6trB3cKXQyMx5ITR7VVzYQUMst
         bqdom+Pfqvgicsk6ft2qukqWXMOYz60XWigOClL1BoPZAbR4MT5qiW4ids94i06IMUBn
         1q1fmGXqPeGUBHigmd3T5J0emLbFxZrBN1VPY0FJWt/MGFBXFbXvdEicTZtuhAKOGqmj
         iRpu+2XG8kKzFVk9IarqYBjn4m8sJJnbS/Bes3qiWqbh3+PjlH5eYF2TMr6EJTRfOb5H
         iqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727444265; x=1728049065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTH6ZrGkkYMdX3NtmPgD5++jH73M4Mz7K2Vca6gurDE=;
        b=sJPITpVw2s6sn9utXfYSK6SFt3FR+gdKoFZwJjzUnHlzff2KTSMxdvMuIpU4VfuNv+
         +zGK7FWpZTww9aMy4AFfkP1hu7a7JrgU1U4z/1O0lclWSUnYMpyLidrfV8qMawSYNl0V
         fYBVYSRMj4tle1OIpRcnQg0zrg52tmHDYAUPGwyKKTrw0GS2CwYCLRbWePBxZTDsG51j
         N1gM30w29eIDMG76yRVZjTswRXNYtZLY2+hCcfSb5XX08H/fC2GA56eznW679Q+Mtssj
         6IUcNvVzpRZBEfHi5BjgTlDefOjcR2vYAOkNDVKCQbbPpyv4WpSMnOZppSj3TWxNEI4J
         eFzg==
X-Forwarded-Encrypted: i=1; AJvYcCWO/RezVYuHHkE7JBidHl7qmvJhXjexkaYofx8PQkx3gF5480L1o5wA93m/VtDzqQVVed3LxjeTlCMvdmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJKkWd2PAV/G9Nmgpj4wLXL4RNjwBfj+9GEHROUhChJzwHcNfu
	BrenElHAs9dl0/ugarACWoXrSSosWxt9EfKzyqB+TZEUS5a3kWMRvDvwEB9QI0s=
X-Google-Smtp-Source: AGHT+IEUIoPYdTceER1rVfUCySlMutIai3Lqj3bSsJ9h+h/0Pde7BjN6J15KYzNhMNUKFuRKodedsg==
X-Received: by 2002:a05:651c:1508:b0:2f9:d327:c7d2 with SMTP id 38308e7fff4ca-2f9d3e6ab01mr20849791fa.27.1727444264807;
        Fri, 27 Sep 2024 06:37:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5764c50sm2491326f8f.112.2024.09.27.06.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 06:37:44 -0700 (PDT)
Date: Fri, 27 Sep 2024 16:37:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: andi.shyti@kernel.org, shyam-sundar.s-k@amd.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: amd-asf: Fix uninitialized variables issue in
 amd_asf_process_target
Message-ID: <f5335fe6-ac72-4223-8acb-5be3e9c89cf8@stanley.mountain>
References: <20240926151348.71206-1-qianqiang.liu@163.com>
 <cc527d62-7d0b-42f8-b14c-6448d3665989@stanley.mountain>
 <Zva0dBAZWpd1e4as@iZbp1asjb3cy8ks0srf007Z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zva0dBAZWpd1e4as@iZbp1asjb3cy8ks0srf007Z>

On Fri, Sep 27, 2024 at 09:34:44PM +0800, Qianqiang Liu wrote:
> The len variable is not initialized, which may cause the for loop to
> behave unexpectedly.
> 
> Fixes: 20c3cc299218 ("i2c: amd-asf: Add routine to handle the ASF slave process")
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


