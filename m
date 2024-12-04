Return-Path: <linux-kernel+bounces-431595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 523E29E40A5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8FEB28893
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1A81FAC30;
	Wed,  4 Dec 2024 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZAH1Hpc"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3651F7099
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328353; cv=none; b=A0YBT9fs5c1tWhpuXAlR/vAu4FN7q8Y8nBVwMIXBa4hzXu65gGLUFmbCGF0Jod848rsp+Xm4OwYVz2I3xr33gavv3408UvsZTVDvKvhbCFuBaw75JIjW9+sjFfQBaZmZ2GiA847nUmFK2GCjKuBJZsQ2k02yA+D32BwHl8lyGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328353; c=relaxed/simple;
	bh=wd/eY6phlvlnKp9dl486zt0nJnh+efyg1sis2+V6M3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRRCLZWVqPzJb+CFGm2mOoBqTGzFdOw2870yyuJXu36jh5pY3fG1rnrsvptiLBnuVwI3+cIbAeXtFJ/CHB6GVZxcsBrdxuO6Qfrr+dTx6zFzQwbtt8Kutt4r/ZDbWwqjuAH1Jrjcp86HkOWgLAXIzp4o66uV7qxI8O9Pr09tMhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eZAH1Hpc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df1e063d8so9075247e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733328350; x=1733933150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+tRejvXUxMNCLgTlAPgfWHyqlQiv1kzmjvxRvEB55ZU=;
        b=eZAH1HpczE+3C158tbrTqGk5Pqensrsq3juWPmbS++ssDp05UX36kYELogn3kH0hTx
         HnoA4qkSDGwdlLr97T35ZqKubxMImnpT0Rsak3QPdL52LnFPyYR+DjAigvmcDuYDdIRM
         8Mo8qzARZZGKFoVuUvwxpg/8O2Sm+X2jaNkj0lGz0/CCurP43BRkCAs5eDiXXK86PEST
         0rgogH+4uZ0bRZ3X3fCdt8QsREsLp3R9ISkrdfwfNwZzFtDvQgDfTGp4xBssqUKQqyHq
         1y0lPJ9wjT5ft91TPt1fwI/Q7nVFs3EMDtfg3Q/IHrFP0EaKt8wyN9RDYdk5Y4TWgTx0
         Zwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733328350; x=1733933150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tRejvXUxMNCLgTlAPgfWHyqlQiv1kzmjvxRvEB55ZU=;
        b=APc4Qt69Qw9yGXSxsqPAQOh0lD/jWe5XQNoN8kQCnTn4HnufFJwvPvmJz1ymTf6/eZ
         2zlf7tRxkQ33Jfz5O6rE+15HzSK5VCQz4J3xH0uwPUIM4lZsJA7ikd6U8E+J1HTkgD+R
         4OTAPni7gXXDYxMnrRA3efyZ8X1Z1RUVRhrLNVAvac0gL2jjk0CXkUeBOj+t8IwZhVMC
         wKXr1gK/6GQPDhoiia0ajILaHRhhFTV2HnXEX3OA2pENBR4E2Ys43PtAHAihRiFG6QHE
         UZZaph+wPc5FtLrq638gvZDpK+tUnTUwtLgQV4MxAd2AD887hEZtTFMsrcLS1RJw7JcY
         +aVA==
X-Forwarded-Encrypted: i=1; AJvYcCXjVvIt5dhZFY6vjDbNO3Ooq2EbbQtL5Or4P6KnSJ/cZX18s2OW/Y4DQsuwnI36DiMfxtiKjutPLLGXKtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyopadFxMoISz5unIHp6R4Q2fJt8e1Ne5gn1ADEq34i8HOClTzn
	+vYf1sCD7BH0x8QZyLakCPP/uM55684v2Hd6yssqPp70yTVcKTfH61qsxfaGt2Y=
X-Gm-Gg: ASbGncsqjFEDeEQAMmGtX1sXZTJzms104Ylr3c+dCBX7prXHmmb1X875UQwnez9i+/L
	DP4iWK31thUH/ylqkrc74fef26nZxnviIgU3T01+oGGWWrWzA3qW+WS4sd7KwjzJPARu0Nm8zGW
	fAeJIXAMyo41igihddBwzi5bJiyidnw+Wk5NPFJLmWaT5CpxT9xVvquufHjH0o5sTpJW1FT5YW5
	zgmTjg+zO0wvWI5moXm3QBxCAP0LZag8A12fzz7ofP4u+3ZWOSzLZ9jA9BDTc33Qd0cchkEmw==
X-Google-Smtp-Source: AGHT+IGVMkIZj30kVvAf36Q6fe+cEPTr02QBVfzgeQHxUvaYCIvIXkRxggrpjHDjlMn9DSOZZc5/CA==
X-Received: by 2002:a05:6512:3052:b0:53d:f09e:99b0 with SMTP id 2adb3069b0e04-53e12961f1fmr4259889e87.0.1733328348299;
        Wed, 04 Dec 2024 08:05:48 -0800 (PST)
Received: from localhost (hdeb.n1.ips.mtn.co.ug. [41.210.141.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599957594sm742833166b.197.2024.12.04.08.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:05:47 -0800 (PST)
Date: Wed, 4 Dec 2024 19:05:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Marcello Carla' <marcello.carla@gmx.com>
Subject: Re: [PATCH 3/4] staging: gpib: Fix erroneous removal of blank before
 newline
Message-ID: <83d08acd-3195-41a0-9708-ad17aaa15b5d@stanley.mountain>
References: <20241204145713.11889-1-dpenkler@gmail.com>
 <20241204145713.11889-4-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204145713.11889-4-dpenkler@gmail.com>

You're going to need to resend this.  Run checkpatch.pl etc.

On Wed, Dec 04, 2024 at 03:57:12PM +0100, Dave Penkler wrote:
> Replace original blanks with "."
> 

Take a look at how this look like on lore:
https://lore.kernel.org/all/20241204145713.11889-4-dpenkler@gmail.com/
The subject is hard to see.  It's better to think of it as the title
instead of the first sentence.

To be honest, I don't really understand this commit.  Presumably this
gets printed out or something?  Can you cut a paste a few lines of
before and after text to show us how it looks like?

regards,
dan carpenter


