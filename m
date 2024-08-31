Return-Path: <linux-kernel+bounces-309950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE21967254
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AFE1C21429
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655CA200AE;
	Sat, 31 Aug 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuxS35sw"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE11CD35
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725117298; cv=none; b=SuVucZBSURuLVUkJu02CuSKij8dt5bCFKRNLMkmoFWDPFRs9YwLoUEClgT1qRu1SD6dn8vsyMAVlUhRFyjcNf0gA6zAs6JSpQ2pLZl32fYi90Jgnw4m+IWN0KRulf+9YaIWxvrFCe9g1v1WALyRRI7XSs3zOLf9rexL7KMOW+SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725117298; c=relaxed/simple;
	bh=saKvXiognHN416c0tT5z+j8zjWYoZxcHW+xZ2aPmimY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/pwtPrdEijcwqPYmmaWgteb8Qn3tlJO4UAtMa10TRzKqWxWofqnlkwu0FtpwD21HK4So53fsRbPTlDpl4Bm1JtUXgMMI/91Ga4TegYfc2wb14OAVegTN+B49XBUbLdu7xvIM0mTIlMQgCmqYaHjBjShawJ3l00xWUb/M82docg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JuxS35sw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso1401213a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 08:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725117295; x=1725722095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qi3kzU3YDe4nX5yvSDNe+Qy0wXh+WxwhX/ktLbD9mng=;
        b=JuxS35swsFuQQO5QCiBsl99iLlNw+GA9pziNLcUdaIYqQ5L0W1N4QfdyOqFL75XORt
         r0UaIUbOIWEX4Vb4jVXKVIsHmKcMlhak5bI2YXR7gV4kyC/ubgM7Dvx+z5kDUD+cnmET
         Wf5HsUXDLoTTMXYSOI13HLB8dRMj6Sc1jkhaytKl41cAqW2gAvDjF958TPEuykHF7uiV
         43FVcsR3bfI6RTNcuQUaH11GWhgxDLehbm8dXV3mCWIs8y8ZMBRphmQGI/09w5VnwEzf
         khxoVfA/9ES8wBkMVK6atjxOmgs82Y0CMcdnprkrcVr11+9B6mlB5EM8AbHjzcd0autu
         p+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725117295; x=1725722095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi3kzU3YDe4nX5yvSDNe+Qy0wXh+WxwhX/ktLbD9mng=;
        b=pSsDpwUlCO9/XGfaV58+eMeg1mJu+WhAXdvXRZxY3zWfZ72NWE4Ii36dx0FNc1GoOy
         KQqIMEnIrFHWzkSXRjguJFScgrTohtLprWWJEF2cpyPXhzoodeAE3XskLtddp2MjryCX
         vCXDEc40Q8dxFh/ArG+vrz5TXs80ututsQ3P/gu/1sx6L6K1QGyzx3kHeu9MwNIu7sdD
         U7aD7tpBdDGEcLEJNAzbJomr4kKIlQA16ZMeB18l20RnhjxbnjHIrRGjb1qIEfz6gGpx
         KxEXUfzQ0Y+gTyYNtHuCkqIYEV4ZB1NHsP+Cj0iZs6ZBx52Otxewc4bUYu8ruSW38mH8
         elnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFOfROUmU8EKbl5LGHbasW/QsEAZmi3nZarhamDquLWd7bZWQeQokcvJmkINKDiEskcm12iUrbt0GmEgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71pg6UonapMa3tPvATLntrGR3q+G+R6H8iP6Tuc8UFHU3OONc
	xPlxbhKHonoKmJCtTZDXE/zphMOMgn8xokvpmuR+puE+p9uom1BD55UcM9IfGsc=
X-Google-Smtp-Source: AGHT+IE1k1GBPOl6jSTP3xbPCfYXvG3LbzPFeKFTrR4LnNzsitM75p3HhU1SYkyXZEAlrF0d+w7EFw==
X-Received: by 2002:a05:6402:5290:b0:5bf:1974:2ba5 with SMTP id 4fb4d7f45d1cf-5c2201d25ecmr9220208a12.19.1725117295272;
        Sat, 31 Aug 2024 08:14:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c2455908eesm874070a12.55.2024.08.31.08.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 08:14:54 -0700 (PDT)
Date: Sat, 31 Aug 2024 18:14:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8192e: Rename variable eRFPath
Message-ID: <225c7675-3526-40a3-ae9d-877ff8e4f250@stanley.mountain>
References: <20240831145932.37744-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831145932.37744-1-riyandhiman14@gmail.com>

On Sat, Aug 31, 2024 at 08:29:32PM +0530, Riyan Dhiman wrote:
> Rename variable eRFPath to erf_path to fix checkpatch
> warning.
> 
> Issue reported in checkpatch:
> -CHECK: Avoid CamelCase: <eRFPath>
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
>  .../staging/rtl8192e/rtl8192e/r8190P_rtl8256.c   | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
> index 7061f1cf4d3a..256c19739ad1 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
> @@ -12,7 +12,7 @@
>  void rtl92e_set_bandwidth(struct net_device *dev,
>  			  enum ht_channel_width bandwidth)
>  {
> -	u8	eRFPath;
> +	u8	erf_path;

e stands for enum.  We don't like this kind of name.  Just call it rf_path.

regards,
dan carpenter


