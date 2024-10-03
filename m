Return-Path: <linux-kernel+bounces-348903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027498ED71
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E3BB2295A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E0315099D;
	Thu,  3 Oct 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFcOa2P+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428715098A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952951; cv=none; b=lYSiyj0xStcTug7NU8MSej1EJP0xfvfh/f8MhUzi8nlQHPiLawJk4Am9w+jwPnF2Bdtf5FNPO5Ab5B80u/wjPatpZA93bD62phDy1oEojQ3mK76UF+AF4jwvg+Sb0CPRraNkIisiTsK9+f+pOQQaxO6G+mlcVdiW8S42jkt0F5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952951; c=relaxed/simple;
	bh=bl1J9uHL1t+SxYiDrslfTGhb7ZWw75hcSPtQ9oEB1o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUgYJ8zo/UWDkpHNxEs8q8pr4hAdDMcsBLRMiEc1v/fl0RIkYsb2rmdx8UOqAXRFPj7PkhCRvPub4zciBMG0e8HrUOt7BMUyzjsUzOYW/udjx5XtCfsKK+IpnpRbObE8m5Le9N5C7lXT4PKXLcOOsHZZhKWCWcr0dVh57V0RyoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YFcOa2P+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so8254835e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727952947; x=1728557747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIJ29ZZmbuiCOz/H02yJqh7NW6JNH11aYozskl/CpkY=;
        b=YFcOa2P+bivYLBnCVO70jaIXwBZUAdJIH79rOJfnk+ndAw/q049ZTSqCXQ5JUuK9Vr
         qTRm9XkjOYRTtaH54S34wRPY9uq505hoCVVnu5QJ1YiZUWQ5Fe955rraAisOBnXkVJIX
         lDIf9UGcswXojpeXHSQN287/IbgQP3ShyhSSZiuKrlZft0tXHTmurEawe0vPrhsmijH8
         Fm0IgtBzejARYFk6IUuXHmRZujWtNL/P5A1d0gX2mvGDkNWfE0uI2qW01uky6CKEtuz3
         PN2h/1va/4tu988lpPeKag95O+2AUnkXznhquA006AlvoIX/ZsPelVOU8G/dl/bzGa7s
         JSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727952947; x=1728557747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIJ29ZZmbuiCOz/H02yJqh7NW6JNH11aYozskl/CpkY=;
        b=DJXFoK2oMNXTSe1pYeL+2YPdE/BiX+vHu13Mqcdok9m4a4LbsOxtnBk6lRPgDtsn1S
         Du47vcRv8Xqcv497YShB7Y6/8gKnMAq4yqYMvKyC1aybI1cyIkhwCBW0UgK02q6LHGAt
         fa4MJXSmMLwgb2Ii/xxWEuAMuZPW5RLSa4LCUTileHhb2e9HZC3oJ2D6a+0cJhn+tM+Y
         OBQ5NllnlqeYFfOhu2q4lzgu7SLIklhmLRvwVNyvSEHq7aIBzpHHlP7wHMku00lz+hqJ
         FKpBUCcNwjdbS4ohl0OZCpPu1y7LW8pwM9BsqLbPcZ7c7BPqJp6ua0FW1/8L527sE/hX
         CAcw==
X-Forwarded-Encrypted: i=1; AJvYcCWnGPG+km88iDfJKSRaEB5C/aNSkVFHnRUPh44qdHr937mjFoYItRMyjJ++hfAzGo8T8GgZJpe7pQkPbaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU16+wIWL6klvrX8H7UzCC/GUD0mIwyCESowbQ2r8Do017K8vH
	CsQ4jWrtQ3EYV5+uR2EyIEyG5dpXk7eZ8eULHfqddk/+VjssPN2TYCR5khigGXg=
X-Google-Smtp-Source: AGHT+IHseLyKrntM/k8lPBcSYPGxSnth29/1KsSzPhnElZMTWDE1jxRrCCO1LeVe4WcDE8gvczpQNg==
X-Received: by 2002:a05:600c:3504:b0:42c:af06:718 with SMTP id 5b1f17b1804b1-42f778f3619mr44325955e9.28.1727952947074;
        Thu, 03 Oct 2024 03:55:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79d8d2fcsm41802035e9.9.2024.10.03.03.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 03:55:46 -0700 (PDT)
Date: Thu, 3 Oct 2024 13:55:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] media: platform: ti: omap: fix a typo
Message-ID: <9a0c9644-cbd7-4d9c-9a73-d5b37380fd70@stanley.mountain>
References: <20241003105158.15702-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003105158.15702-1-algonell@gmail.com>

On Thu, Oct 03, 2024 at 01:51:58PM +0300, Andrew Kreimer wrote:
> Fix a typo in comments "tobe -> to be".
> 
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
> v2:
>   - Add driver name to subject.
>   - Elaborate on the change.

Thanks!

regards,
dan carpenter


