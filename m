Return-Path: <linux-kernel+bounces-520217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D6EA3A720
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FD316DBE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EAA1EB5C1;
	Tue, 18 Feb 2025 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQ8+PFAY"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A41EFF8B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905758; cv=none; b=vFjq75u+Mw+9uf2yrfg0Bgudv6hc8XdP+9WieiT1hlKTugBUSNoVPrxND/irSXTGNKSirO+lvjBqOcWlwm1xq71D3bOH6ihYDH+PfNwIeqloLSvpvZa9y2VKXmJ/9YFf191KAwyzEz9uxEl4QP7cgsJ8LYaooghnF48NfjDA6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905758; c=relaxed/simple;
	bh=vtkAZPDRpeVOssKKtc3/ZBtyBpcNLoSSRXvVxehsrIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDYZDBOK+94ADU6NzWGuYICzV/W7SVft3giqf8wYdKmjs6osZZ06nfxyQe4tk6vUrUSYeyWd01E12Fg2+g1MYjDiow8Hamn5qsQaZPzvJods3a9iOQwatUVPCaA13/y3bx2CLWgen5dZpVg6XMnom+CveICewX9UtfTamuFBLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yQ8+PFAY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abbae92be71so198598966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739905753; x=1740510553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsPSNeOLOsrs5K++JmVDCL05j90mUH/WwZrpY1dTXqk=;
        b=yQ8+PFAYU3EoFFe1afTQxcs9M5Tm46BhjXE+Ni49exR70aDh5k8D1+468WlAofxgzc
         l199bW8uI7z8hMSdXZxfu063NSXKygNu5eeMQagj8PDwFHH7pFXjhN1b614X1NsVr4tY
         zaseVLNxi50yxk2Hxwc7+xBmHj6ZLGoEDW2ggNcB/yhAZ65f/qoENuHZh5mzUmbIGMMN
         tlYi9U/4YcMOEfcaVSQQ9VAUOp8xrij9kMmiipdhe5aJaN2YLO50v6pZHDDc+UB1K5We
         IYim5GOOnK6Bj0aNEGrRC6m1s3fyAUYcn4Dca1GWWioP8LwcN1xqxbwGfv+ubXm4cAlt
         HrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905753; x=1740510553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsPSNeOLOsrs5K++JmVDCL05j90mUH/WwZrpY1dTXqk=;
        b=KK8qAVd1BEExo85qOACxrPXSVvn7Zqmc5Kow3IBJfsLRGtfxf/YW133qCKE3J33wMG
         o8bwaXk+Dk+4OovFq3ukp0ePna47vNGJfsN69+9h9OHkCbeAZr5AnEbCU5ER5LpFp3pU
         s7EWK6TLB44i/0x/HVTp19O2JP/H9bVNNO3PB9BrIfl2oWhwbWZHUYGuD+a6eNexCYkO
         kVtsEUmC5YCUc3ZymBTfVIqDlZ1MsYD1P9n8gjOaNtfydz+0+xyDdQ0TNU9XxCXtIZF9
         lSCL6+OABM2KGgLHbGw7LmTLikso7Br31nXyni/NmemczpqHJhmr6TIzwNGaOZd/azA1
         7jNw==
X-Forwarded-Encrypted: i=1; AJvYcCUNHG40xyKYfQA0KxHt5hWXKbULEfAqzyYgbgpKzhwo3UlfjWdzTJ2JOyOQAD7+rbwJilH/nl3swEKdJWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfp0Epfvv/IAvAWvN/r956vLfKRLVmAR5rdiGMHprlaYiqh8Dw
	vhr6sgf+3gD9kcSLHbAxPh6K05hLICWgwEng0CJB3BMs9/9F1S66tdcrQxRJOjg=
X-Gm-Gg: ASbGncsGGDpF4BJ6zpi7/KmHJ1zaMLxWaoRRSc2tAReOc1sIJlDAP5y5tEn7Ls8l8t/
	HPNq8mtPvzmRjI1nRk9Z76Gv2QYmVq6J1m23882gAexU1GVRVbpTcG8sgFSMM5TQn5WUrft7XYK
	XtlFzuQBd2B/4ubsrDPW5wnVdA78ye/gIXMNruS5P5DuAXQKYoKu9p+nH/65miSZ2LrYSk07X6D
	TLQ9y4E5+07AR5PUkSDccuZb/NdaFWrajIwP87Q5s9cJwPT9k5jlfy2hUkT7Or0Wo1f6GRyI92i
	aeohiS1V8KbBmrEJXT22
X-Google-Smtp-Source: AGHT+IECzgx+wcz5EbHNUv+RuNV/8qTPAQ4z0nfTNLzDceNq6d1mjgLqh6ZvP2PHnq3FwjFOEYPEyw==
X-Received: by 2002:a05:6402:42cc:b0:5de:4a8b:4c9c with SMTP id 4fb4d7f45d1cf-5e03618aa7emr37791483a12.32.1739905752903;
        Tue, 18 Feb 2025 11:09:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece1d369esm9063291a12.37.2025.02.18.11.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:09:12 -0800 (PST)
Date: Tue, 18 Feb 2025 22:09:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: sm750fb: Remove unnecessary volatile
 qualifiers from the file
Message-ID: <fc80577a-2dfc-467f-bb92-db9e0cc7151c@stanley.mountain>
References: <20250218185749.22144-3-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218185749.22144-3-madhurkumar004@gmail.com>

On Wed, Feb 19, 2025 at 12:27:48AM +0530, Madhur Kumar wrote:
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---

No commit message.  No v2.  Etc.

regards,
dan carpenter


