Return-Path: <linux-kernel+bounces-396714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0489BD125
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA1E1F23CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6E1531E8;
	Tue,  5 Nov 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tytZ95Uk"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9313E04B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822099; cv=none; b=kWODnWLLLpksZELFoAQRsS4iG3r73tfgXtt3Osdrx9mNEJk1Owlzma33sByeLDl0rOGOeOqT/nN1zoNkknTxxUBuskhQNDb4YL5QGqRxmEjy90fgvLE0VlYoO563x07kQJX26j1OU2YklG0QPRZVSroPD/xXvlpsWR3LvOD2/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822099; c=relaxed/simple;
	bh=hyWtsIgGDAniL3p39e/pGqovDCo9zE+kY2920F3jbl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWZCHMdl0dJeCOn5FzTnbjMLgxtwGYDAMnoH7MW6/YR0JFvZHEHlOnAtU7jT29/JVeZysLjLCjAmSh9I2CVX1q+1cddXygUYs5PbYr9aaMn/xXfLBXLykCH0uMz4jfsQisEc8HEMaM3YGxHkxmd3XUGFItE5Fnzv7rYlhzX9+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tytZ95Uk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d462c91a9so3315752f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730822096; x=1731426896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3njGTXhIv0MvCjh27pJAW/MEoJztiS2FVGTmfPZr0ck=;
        b=tytZ95UkcLxm3LnVpQcAafGv7w2v2sodsBCAsc5RwzD8ga/sokXv/31OnVPSXAc7d1
         fj65cssnh/f2NX6Qg6LBTLh/S3fxjJAxZmbVIB1oXjMF4cd+QC0j7N0REOoFhPalcbXf
         x+aximUVMmzECOTFAejYyOosaUvCnFYXZVzWUw2lx6lfGK9HQySJRaSqyk8vCXLtnnn0
         vnBNSvWd/awy3K06Vg5LqlXyqMgFIlXM6PSh/tDXDKX+19THnf25KCrbMk/r89IuXBFt
         tGOWpr0624gziUs5gXfuQaM8SyfuPLUj07WdlybCoG7yYIHPRDAmi6PoHDx+DUbMBcYl
         xg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822096; x=1731426896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3njGTXhIv0MvCjh27pJAW/MEoJztiS2FVGTmfPZr0ck=;
        b=rdyXBttWpgpAhjiRiNuBEj7bhzRN3lLJpY7+Bz9Bm1aj56i7f/fXeJMwyVjQ8u82Lp
         QpPHzEezr9EJTXtf3bl0qYQV+1sVph1mh3rzsXW3JeDWJCyFUrSVFXFqqmVEtbxgTLcj
         mAI98Pyo34Mculj3JTF0Iay8Ijo6nRt/RwbFuJgynvXd3Hs/ghq5ycoGplocqosZRdCb
         +PS1vq3KLDdd1OzcllpORb8NJbIlNx5Koc4d6SDOL46vl+HMmI7S4PUpIoq5NjHfuOQK
         rYfIEZ8Ze7jFW9Tj/IV6P1Eq0GioPFvbBRSCvNaEzPR04UolxpJkA9KTKDQhWnsuKpfA
         OHZw==
X-Forwarded-Encrypted: i=1; AJvYcCXbAaiK0ag/y/57/rbEAUdXYYCTCh+ME0YJe5DwIHjgDS5NXq9dCepDxXoWaOS4tmR5aQ/Hv6ePfarzbzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYDeV8nj8X3YAkdHEgMcJ3uEz7fDy9GFhwDDgNTrtT/jdujEfg
	RZjFuo3g9TyxiMfv/GpcLKZZoMZCbYWbE44V9eWu9bfgLM0D2HQxLU2Fpe3D2Ko=
X-Google-Smtp-Source: AGHT+IF7rnb/L+HIkfYfKE4/bBO2tPxiKGqEVY92wIDxONH0zhaa6XG02B8P6pUs+dM/p/GLFXJvgQ==
X-Received: by 2002:a05:6000:118c:b0:374:c4c2:fc23 with SMTP id ffacd0b85a97d-381b710f70bmr16642600f8f.56.1730822095676;
        Tue, 05 Nov 2024 07:54:55 -0800 (PST)
Received: from localhost ([89.101.241.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d40casm16558370f8f.27.2024.11.05.07.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:54:55 -0800 (PST)
Date: Tue, 5 Nov 2024 18:54:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, cristina.opriceana@gmail.com,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com
Subject: Re: [PATCH 1/2] staging: iio: ad9834: Correct phase range check
Message-ID: <1405e340-db97-47f8-aa56-5f507ccd821a@suswa.mountain>
References: <20241105140359.2465656-1-quzicheng@huawei.com>
 <20241105140359.2465656-2-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105140359.2465656-2-quzicheng@huawei.com>

On Tue, Nov 05, 2024 at 02:03:58PM +0000, Zicheng Qu wrote:
> The phase register for the AD9834 is 12 bits, which means the valid
> phase values range from 0 to 4095 (2^12 - 1). The current check uses a
> greater-than condition with BIT(12), which equals 4096. This allows an
> invalid phase value of 4096 to pass.
> 

I tried to figure out how this looks like to the user but I didn't
figure it out right away.  Please add this information to the commit
message.

> This patch corrects the check to use greater-than-or-equal-to, ensuring
> that only phase values within the valid range are accepted.
> 
> Fixes: f1d05b5f68cb ("Staging: iio: Prefer using the BIT macro")

The Fixes tag is wrong.  It should be:

Fixes: 12b9d5bf76bf ("Staging: IIO: DDS: AD9833 / AD9834 driver")

regards,
dan carpenter


