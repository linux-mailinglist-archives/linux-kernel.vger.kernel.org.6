Return-Path: <linux-kernel+bounces-205915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBEE900222
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24B52850D7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3D4188CD1;
	Fri,  7 Jun 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsjD4WBd"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045A15B127
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759706; cv=none; b=O7+nv+QRSQ+/+/lSiVqxh1xCcKgfyHK4ib//OxLGJvWzqqJtRyQEjjyDOyZBOsaxAZPEiw7vYXUXcw5X8p/wGEOPnTOdoPp958yqFyDu4M/q4XzeBPNhbL9pNPR3O3MjSjwncnZBhwnYkD8LLyKy/FQ0TsgGfFeYxLW2teW0H1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759706; c=relaxed/simple;
	bh=dZ6b6A2luUvZV67iXhQecHg7bz8xrdgE5UK/eMldfuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeRuQc/Al6PR4tMnzrYFb3bvTuHGurF/iipTfCaNuYK5qZVi/cGd7TxjljTyesBGR8M5VyGIMPZvQu+F+OUzkTJhfH9Sr+mKaf5WX7f/odbSP8tny627FCqTInP+tEw5Sy2TE20s29AqSG9Z8Y1SzEfeIx5tQTx+pkYmJ7ol1bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AsjD4WBd; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eacd7e7b38so21695211fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717759703; x=1718364503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LrDPy3jinFU4PA9lezpiE+mXjjHX9CRj3Z0eKF+mJU=;
        b=AsjD4WBdSW/x/MjeNQjggpiY1haToAQPa6Q4xD2Em6dX2aylvm+g8vzTUczs+eRlJz
         /AHX90owP1jBa/zqZq/8oMmU7gpkfK6ZDmainUOidrWSQuAfIoGSyT96DBo0gyibyVCE
         KIMm576iLlSc740FUQi0jf/g1YfMZcvmS96QqqdtjbbWDHYUO11QeIAlvHDSkFBb/oJE
         ynBn3UOsJigIuhdYj+BPCzjV84lyK0Lxh6zJebuk12vk+8/AtaqNbEpPZQhJ3BJjNHRd
         xa2jyAOjeVdk0N4mVo7TPa9DNIZ2GMgeAHrmAf3ygZElx629xmRJ5ayPlHginTJIf6ba
         wtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759703; x=1718364503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LrDPy3jinFU4PA9lezpiE+mXjjHX9CRj3Z0eKF+mJU=;
        b=R7ejX6dIfB7F4XR7tTv93vJIA+Wo3ag5hEqnrGK1sN3VHU3sjgCgGJ0VIrnSaUIGn0
         m/qQLhJX28AuTOLNWRBHbJsEKwEbkhbRqW9THCE+vL3XYn80EKhVFKHrCWBm97CgXM0U
         I1AQrJt1B8Tk1yCCWUCGinPpZtRCRg+vxXKBGw9ahzWwfhlaOwY9kdEaeFOpKH6Z25WG
         QDuxyx9ThA3gvQ9gccjOiiUrB97aXqhmzGR0pCdD1RFidroNdJ1LtM1Vu6uMvepaDM8q
         75aEiP4UVJVG/etvnsv3ENlJuIiKu7uHOm+E6TwkY8SphD8KJgepWOw+M35kUCMzvuUK
         Sb2w==
X-Forwarded-Encrypted: i=1; AJvYcCW7ych6ww3WJjExTKuDLeNNhSkjvbFtxXA/0DKBAzqZBbDDwEhwW7JUz/0S0RkY1S45pfzD1iu4zp8ossfG+dINNQo4ZZ3BRidhbwf/
X-Gm-Message-State: AOJu0YzAn15TwtgNv/evLS3njQYt1NvMHOw6fQqjAfFI98C7WU1S+xCn
	S2u8OrSOyAthDdSlN0g+pMTU/V5Nt0c92hzDQCNaAP8jKK0DROjciVRPFyUZuWHlyKOVSP7MWhh
	N
X-Google-Smtp-Source: AGHT+IHPupGPuAnubE2Mmx9X/g7MX3SpQWcBUkEwjG7/TpU9QrByZj7BXnenEURz/lHQtWGvGKJMcw==
X-Received: by 2002:a05:651c:2220:b0:2ea:89f6:258f with SMTP id 38308e7fff4ca-2eadcb8dd58mr25219721fa.0.1717759702584;
        Fri, 07 Jun 2024 04:28:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ead41b059bsm5083421fa.96.2024.06.07.04.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:28:21 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:28:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, stable <stable@kernel.org>
Subject: Re: [PATCH v4 06/11] misc: fastrpc: Fix memory leak in audio daemon
 attach operation
Message-ID: <dkbyszjmah5swomq2b3nlk24mik5epiwfeey7c4khp2p74dxgm@4ccxtjnasyoc>
References: <20240606165939.12950-1-quic_ekangupt@quicinc.com>
 <20240606165939.12950-7-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606165939.12950-7-quic_ekangupt@quicinc.com>

On Thu, Jun 06, 2024 at 10:29:26PM +0530, Ekansh Gupta wrote:
> Audio PD daemon send the name as part of the init IOCTL call. This
> mane needs to be copied to kernel for which memory is allocated.
> This memory is never freed which might result in memory leak. Add
> changes to free the memory when it is not needed.
> 
> Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>

Fixes go before the non-fixes patches.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/misc/fastrpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 13e368279765..7ee8bb3a9a6f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1380,6 +1380,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  		goto err_invoke;
>  

A comment that the remote_heap persists would be helpful.

>  	kfree(args);
> +	kfree(name);
>  
>  	return 0;
>  err_invoke:
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

