Return-Path: <linux-kernel+bounces-366362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7F899F453
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F7F1C229AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B781E6311;
	Tue, 15 Oct 2024 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxNZH6Rd"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20117335C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014346; cv=none; b=hVOjJm+O1AcE7GY2O0t2nE18OcB9pF/GXe8LIyfqpiVsktKFG+ShVjt8GKhDK030L9LvAIWT3AYMR+Jz476wRnetdFd5ltmQfJdWNnuKhj1QN+6xRzRSh+spgOl/U+Dz7iBzCmQf8A5LYaZXDg6ZUcPk//XcmOe5pls66HkCYu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014346; c=relaxed/simple;
	bh=BRwYGtJfD2ZMxkQGQfTMrxkT3kcPBYxzJBdsN1CZfRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V60+qps7r0dPO//dDq3ssubEKdBW/r6Q9rEYdKPajKQbEM8V1EoAc4UV3il3/A2dTbqWK6cjR+r2IVrVsoEayxZ8jvVhfXOXmPXgOWuVio5EF0xS2FP06QFvuxdM4eRQCEUnmiuLXCmGe4C7JPfA6jkCzCgk1+bE7KnI6hR+LKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xxNZH6Rd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-207115e3056so46722525ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729014345; x=1729619145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2pnrAdC2C0BE3RK2dDE2ExUA2qwhyaMBrQ9ZLRFBKLc=;
        b=xxNZH6Rd/c5o6Kd9B9tqg9LxdR6xkRXaxGZVzTAMb3Obucl8uNdAYZDiQPLmoakvsL
         oWhZUEi+niznkx2XjFBVHCe8xbe6yopkkRKS4ocA33EFigxHm4YhzrIP02pr3otqOX33
         2DoyFccU9m2tklaP804u8n5m7H8z5iAxHIK52n6q1AiXM6korLxfGzYX7ddnygmR5SAq
         fEK8rZBhebBkgwabn9wlezv7sH6dRPBmJgMQ+QkF15WKTnGAt03U3OPVO7Hl5rq4EEQ8
         EOZsyTxwQI52rvc63pfvRq2M9gqgCYQ/825bGF2TzqNaNlDwq49kO+rZiWb3x5QG8MYW
         7T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729014345; x=1729619145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pnrAdC2C0BE3RK2dDE2ExUA2qwhyaMBrQ9ZLRFBKLc=;
        b=Uo3TxKDIUDKwP2atyWz43TbxBMyqjT+CqaVdqk7XBWbsAu2XnYlWZGeoEiH0J06GoT
         fsXYBJcsOfbmUfxogcAq+ZasIjzdgTjMMMg/jhAqHn+3hzZIk1ONhNe6gLoCVb6iWrxP
         7CWT4HtjnvEt1ZuG5GgW9vd+XhVF8SlwRRKpTE/VAn7YUfp9la7E7JncFl3hg3wh1dx6
         1pKYg5UTrrngh1VnRlKnQlWJWMBwb4UFy/P8lw44uQfOsde4R3hKu2Jrv2hpGzaMKoqM
         8WxY0RQOLKwFz9gq1UDozdPoDrCdHdmCcLJ30rdCBsNvt/yN/X+YJY0piJ5occi71EjF
         sk7A==
X-Forwarded-Encrypted: i=1; AJvYcCU+ivfiPd3PO5qGxrG5YZO2VvieYKgu4gd+nHX78+PArVxMFNTxbWxPdHzJ3oy8/6txCL9OAJQPVJlkGdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGMe8PAPIDqCrDiaXECdg6nQp9Kp3Vn699AuqDu17Xb/Ub/Trw
	JxErcIGoN9Btn7HkJKFRSkp+ZajgZm9jkXewKD2t1poTANa7noImm7EjLz+k3tQ=
X-Google-Smtp-Source: AGHT+IFhFlnB95Ly37ttoU7wxg7jYWU0jGICSaOt6TVzXP7QvyFQFyJ0aAZUuFEN2D5AjSEVAGmsgg==
X-Received: by 2002:a17:902:f60c:b0:20c:b0c7:7f0d with SMTP id d9443c01a7336-20d27ecadd6mr11986115ad.25.1729014344626;
        Tue, 15 Oct 2024 10:45:44 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3f26:e29e:2634:fca0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d180367bcsm14592775ad.145.2024.10.15.10.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 10:45:44 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:45:41 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 00/10] remoteproc: few dev_err_probe() and other
 cleanups/improvements
Message-ID: <Zw6qRdLSkp1PT0lD@p14s>
References: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>

On Fri, Oct 11, 2024 at 03:09:08PM +0200, Krzysztof Kozlowski wrote:
> Simplify drivers in few places around probe function.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (10):
>       remoteproc: da8xx: Handle deferred probe
>       remoteproc: da8xx: Simplify with dev_err_probe()
>       remoteproc: ti_k3_r5: Simplify with dev_err_probe()
>       remoteproc: ti_k3_r5: Simplify with scoped for each OF child loop

I have applied patches 1 to 4.  I will let Bjorn do the QC ones.

Thanks,
Mathieu

>       remoteproc: qcom_q6v5_adsp: Simplify with dev_err_probe()
>       remoteproc: qcom_q6v5_mss: Simplify with dev_err_probe()
>       remoteproc: qcom_q6v5_mss: Drop redundant error printks in probe
>       remoteproc: qcom_q6v5_pas: Simplify with dev_err_probe()
>       remoteproc: qcom_q6v5_wcss: Simplify with dev_err_probe()
>       remoteproc: qcom_wcnss_iris: Simplify with dev_err_probe()
> 
>  drivers/remoteproc/da8xx_remoteproc.c    | 29 +++-------
>  drivers/remoteproc/qcom_q6v5_adsp.c      | 17 +++---
>  drivers/remoteproc/qcom_q6v5_mss.c       | 48 +++++------------
>  drivers/remoteproc/qcom_q6v5_pas.c       | 22 +++-----
>  drivers/remoteproc/qcom_q6v5_wcss.c      | 92 +++++++++++---------------------
>  drivers/remoteproc/qcom_wcnss_iris.c     |  5 +-
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 74 +++++++++----------------
>  7 files changed, 92 insertions(+), 195 deletions(-)
> ---
> base-commit: 0cca97bf23640ff68a6e8a74e9b6659fdc27f48c
> change-id: 20241011-remote-proc-dev-err-probe-c986de9e93de
> 
> Best regards,
> -- 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

