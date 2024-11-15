Return-Path: <linux-kernel+bounces-410247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3327B9CD6E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2D6283318
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B91D17C22A;
	Fri, 15 Nov 2024 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpbKaeQ9"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EDD17ADF0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650859; cv=none; b=lcx4DikG+nZxru8PV/yJDfIvPxU3KW8zAVOuJnJJukvAn74t0fHMqjIOxeD0i1g0QiT8uHFvIPr12ockbhTk28qKODihya3FdC4metO+77tfFKOsXy6EuU9wNtju3Lvue5f+C8xNwW9QpqtJVJFZyhxHB3HiQzcgx2ko42MOrK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650859; c=relaxed/simple;
	bh=fH3ZtRPVn3Kbkew7RanxmH7dVJaPr442hqNLjoGorZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOSKv28Kfen4mDCKjfl7AeCOwgzLhB6d25sGmMyFIo+/agJKPQCkSYlTuGN0sePZS4t9ypeC9vD86gMPQlaOQ708vvxrTcouQ2UV2h1L8Knq3DLdvcM42slZiqKqO1Mit5vHvMd4Ajy+Bp7h33y0wbE31cCe/NNFYdz6GvTZ3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mpbKaeQ9; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e619057165so729910b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731650857; x=1732255657; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=So54qbrgSAVoomcFHWWM9if0MekC+bKwIj6DJ1OKqGk=;
        b=mpbKaeQ9Kiq3DCMZAOh88LYO2/miUc2b7pjSsBNdo+pa2fTH2+s6YoGrlIJJWjhgxT
         Ggx+aqQHShQhWQ/y2TBeW4ByPUuh+6htjWwA3NflkobdvGohS1dQWuVPMnKymye95zB5
         JPb3rJOoqqzzj5Q0dkYRIdPv7QNTnJ/bWnUsVRHQ0uai2Pv+kme7xDrzlPxIRWSNAkhy
         5NxFcSfIn3zoJWTaycNa0WN0JKDqxyel1IU8ZUBm99iBOqng0tIpSU0tG3wX7sa7RE+F
         DHLducYExDn3xiRIYSvn9OFaPRMz8D7RaIbuWr5oALuZGOqcy6nvZRFWEgEPa/WJhuo5
         UPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731650857; x=1732255657;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=So54qbrgSAVoomcFHWWM9if0MekC+bKwIj6DJ1OKqGk=;
        b=QQ3x339BdJT9QlVrRKMadNgXo1XnbYI3wBzD9aJt/3QJGqaBx8t8uPFKVl/B3nhFyw
         fx0PvuLbRAlfXbciU7LZNhDRvPNQkRRjmKJEdCn7XrJF5qN7kIqkoXIxskfM/MpNgWll
         M3Gsi8G8xmf8zID+T4Uk3J3qmzOpjfnLh6W35d345414TtlGrWlpLrw4YDNwW43QxSQv
         E7qVnXR3/5x3e1oMMkRzhV+PjN2tKH+2TaGfQIsiW3YWn1I/0/Y+Nv7CCR68r2pdYy2t
         xGdPTk4fOMFh7DoaqKUWGx/vKPU6RM2kagqNALewV7ZEeuCbpst93o3Q6uTGQNSFeQp1
         PskA==
X-Forwarded-Encrypted: i=1; AJvYcCWyqwlLpYIUG/+jQ1rtE3rbbID8uLJW8VH9ZL5ibk17D/RKntRk/wZbuNvwx59R+PCmEfdSvUVQTgQtiZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDjOjuiBMgUqzQeof09gj5DVgHk11wPXsDv5As5Il8UowRYz9G
	24Ly1fBHzVO4QhuCyL7IslaCyNcAPI8bdGkjzyvE6jfj8VvZWrkOMpIkH9QHDQ==
X-Google-Smtp-Source: AGHT+IEY7/bxXGzU/MjOHA4C1CQe4QcOcyhYXEIsUZBCGugTGycfUNtjiaXy8AIwgP846Dmr7DaPkA==
X-Received: by 2002:a05:6808:1408:b0:3e6:206:e3d9 with SMTP id 5614622812f47-3e7bc86df53mr1794369b6e.40.1731650857276;
        Thu, 14 Nov 2024 22:07:37 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dada4bsm462310a12.56.2024.11.14.22.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:07:36 -0800 (PST)
Date: Fri, 15 Nov 2024 11:37:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Youssef Samir <quic_yabdulra@quicinc.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: [PATCH] bus: mhi: host: Free mhi_buf vector inside
 mhi_alloc_bhie_table()
Message-ID: <20241115060731.345c2nx53bpluxjx@thinkpad>
References: <20241024214715.1208940-1-quic_yabdulra@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024214715.1208940-1-quic_yabdulra@quicinc.com>

On Thu, Oct 24, 2024 at 11:47:15PM +0200, Youssef Samir wrote:
> mhi_alloc_bhie_table() starts by allocating a vector of struct mhi_buf
> then it allocates a DMA buffer for each element. If allocation fails,
> it will free the allocated DMA buffers, but it neglects freeing the
> mhi_buf vector.
> 
> Avoid memory leaks by freeing the mhi_buf vector on error.
> 
> Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
> Signed-off-by: Youssef Samir <quic_yabdulra@quicinc.com>

Applied to mhi-next!

- Mani

> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  drivers/bus/mhi/host/boot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index 21bf042db9be..2e9ef55a566a 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -415,6 +415,7 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
>  	for (--i, --mhi_buf; i >= 0; i--, mhi_buf--)
>  		dma_free_coherent(mhi_cntrl->cntrl_dev, mhi_buf->len,
>  				  mhi_buf->buf, mhi_buf->dma_addr);
> +	kfree(img_info->mhi_buf);
>  
>  error_alloc_mhi_buf:
>  	kfree(img_info);
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

