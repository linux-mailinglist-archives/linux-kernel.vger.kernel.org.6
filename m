Return-Path: <linux-kernel+bounces-195281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E58A8D49F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFDA1F2291F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C22716EC02;
	Thu, 30 May 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="msmmZocF"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5101078B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717066832; cv=none; b=p/9dR4xfd3pZxLkwATy356YLtEYAIBarYNT/Z7OTPMYq+AaQ6sJX6Oh5rRr2MVyzS0N33WQika+VJqUmEl1Ma4sJPjnHZF6xZ88vQFC3NZ4v1xfHqfM/F+akqySHwnMd1Be2O9tNvi5UmkvDBfklWkUiYB9JkVvzaKS+CxSgFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717066832; c=relaxed/simple;
	bh=rEI9DBa1j4BnVdoajTpb+tL8h1oh0Y6i4rM4cqp3UDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUGuFGy9J62m7G1KrTYWpzGo8UCZ94S+PvupiUVms5GeOOzeIk+27CObmqT84rMBd1QYz4YmLSjoI2sJGzi2jLMSy2WZlPOI/6z8hcJw6hAkhHKI+H50kjpXqlFCVGCEEJbMV14hW4ecepi5IA/N49XjeNjDgk/UKWGCVCWi5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=msmmZocF; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so7281341fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717066828; x=1717671628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLmMfTZOf1ncPAiMphJf/hzLTXpE5zXvNOVM9cB3vug=;
        b=msmmZocFtCm4QUEwY3pq9rrdLwHWZ/lOvoPZEpTGW+7BXtH66JjgRl6BtmNO/7sqQv
         nboy/tYqLqoWELVsz9YVLXfoPQf+RQGssuUF+dWMmRXCet1VbAjC3cE94FMFQrZGM0Wt
         MQUXP04AKwYt9kOh+OyKYWOmmZrknujCP8P3DAiez2qdCpOnwei1RY3VLGcO2Y0OTqNw
         WnKdI12qVQ+TlKGcS6vHw8/1V3XPGjrpa777HvmDZ4haZjsi78FT2NoibW+nweork3UZ
         4Dfql/azY+F7D2RzjU5ogp7FfXVhjpa35rjet7hAh3ZKrxtLh7NB0vWGwbOu6o42yf5W
         5qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717066828; x=1717671628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLmMfTZOf1ncPAiMphJf/hzLTXpE5zXvNOVM9cB3vug=;
        b=vvB074e6U8hH6llUzpv2C3M2MZV68VeAn9vx44mgvgIFH5x9KdMkLbhm05w4bpODC8
         1IgxCHxSrT0G76ffYOjdeGW4VBOcnDHvqnTmqnA2XHMDhNDK/cOHhahhkLpx0ihaAwDc
         rLFWs6m+qYxG1ZeVovz7poyeQ8wZwqmaI1hU03eKB6gPzW62kyNE9leqJMkWMkIb5goI
         QzBNck7yNDJ/6inGSJnNWVx2tCY+2UF8qbk1jrJMs34TbhsCvrdI73QyEx2bCngMrnBN
         WaMRx55Dj+4D7PFwC6kJC4he/TGMRSJ5U9Xp4zCffrnf30m77e/GQ4uVSq9zeS8JbeLE
         UMCA==
X-Forwarded-Encrypted: i=1; AJvYcCVxzFb/ayMlVqpeglo/jlIzYruPAWquSJ19FHtne7ZHTdc+GytXEGFkww7J8pczhANMEZzd+oQxRhV1U5dOJMc9ilI62CR9jKxp2J05
X-Gm-Message-State: AOJu0Yw1Mzcojvde4GY4yuRxvtb0F5AwxDTfafpPQuj3MvIpfNawgnMk
	1K5SXgFG7Q+LWtQ2szVobODPX9ePmseO+bH97v4uA8ruLyT3KM7WCmKsBK7rNZU=
X-Google-Smtp-Source: AGHT+IEQgmHnz5CqUIVafRMF5L11GfhlU9KNug91AV4hAUh1JmfKZgmX1wOk45hkWxayLZUnKC3/xA==
X-Received: by 2002:a2e:9e44:0:b0:2df:907e:6de3 with SMTP id 38308e7fff4ca-2ea848844d3mr9698541fa.35.1717066827745;
        Thu, 30 May 2024 04:00:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea803cc73asm3191881fa.8.2024.05.30.04.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:00:27 -0700 (PDT)
Date: Thu, 30 May 2024 14:00:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, stable <stable@kernel.org>
Subject: Re: [PATCH v3 3/9] misc: fastrpc: Fix memory corruption in DSP
 capabilities
Message-ID: <o5zjxqgt4z3uypa3ucoark7auiik7k7jvzpnrnn3psnwvhc2tw@jpvgzga7ruod>
References: <20240530102032.27179-1-quic_ekangupt@quicinc.com>
 <20240530102032.27179-4-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530102032.27179-4-quic_ekangupt@quicinc.com>

On Thu, May 30, 2024 at 03:50:21PM +0530, Ekansh Gupta wrote:
> DSP capabilities request is sending bad size to utilities skel
> call which is resulting in memory corruption. Pass proper size
> to avoid the corruption.
> 
> Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>

Should be squashed to the previous commit.

> ---
>  drivers/misc/fastrpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 61389795f498..3e1ab58038ed 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1695,6 +1695,7 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
>  
>  	/* Capability filled in userspace */
>  	dsp_attr_buf[0] = 0;
> +	dsp_attr_buf_len -= 1;
>  
>  	args[0].ptr = (u64)(uintptr_t)&dsp_attr_buf_len;
>  	args[0].length = sizeof(dsp_attr_buf_len);
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

