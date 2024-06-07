Return-Path: <linux-kernel+bounces-205877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BE49001B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC55C1C21C3F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11497187332;
	Fri,  7 Jun 2024 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n40smNOG"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56A18629A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758735; cv=none; b=o6dGgp4qSsOO3FPMRKzS2vRZoLt1/g1hxE5jX5XzQbfHGJCqZQaLYM9Y8p9N2/QlfjlrEJ0D7EZ0lBSyR2qBDr/D1KN3m7BI40TlbeKHsSa2e8AZsVJx4PwiSSR/Bff0TwsO00lxJ1HW3Qb4bI5jVH8k3rp2LE/74+6sDPOy/Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758735; c=relaxed/simple;
	bh=imAdMxEgpItJC7m2y2a8Qp3v8Ayf8lh6CfzMdKXal/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaL5mr2+bd1UnIDcF7Xh/FXPFnfSH0KPH9n4FghDbntM/87ojnoPpLiIHEto96TvBIjuKkO9kFXzP7kLaoILsU+0cfymYd3nRhoF6Jzqe6iDhRlqfk+wO4LZeF2p6P97IgvIGFsEBJsUwsBA8pyQHy47djhKIZEE44zRwqYoosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n40smNOG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52bbdc237f0so587553e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717758732; x=1718363532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LA62BcUboJ8oQKyNiD3kfMcc/f4SxzTvuzwHvOhJ4mE=;
        b=n40smNOGYQUXXk+N4vYIUp1oUlz4IynZa5tFBcJlhvSypZrpiPx4XWnfs3U+etD0jC
         MtawK/O7SdyQLPqSytAi51mOGJzcqqHHWsk8tHJ/CPpcqvczBUj9ibXiQRBmzuPoYi//
         6gySyPT1sBuKa+6bMOdTMCzTmBaoBdZFiC8UwRKUKzCeRBf7IRXWZ6le0OVJrkGlMcma
         235z6gV+cak1/Q5TyyW5ugNsFxiPFiej2mp33sC/WSP2FxQZ1l0JrmnyFuPWFkboKCpC
         xfvtaJohL8+MF3nAtJBfUgcr2DG6O8hkacHLsk2vtAdBHknPqipPl9mq6L1e491rnClV
         rdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758732; x=1718363532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LA62BcUboJ8oQKyNiD3kfMcc/f4SxzTvuzwHvOhJ4mE=;
        b=Hq6m0sKl7KEZDivifp4p0UIdwqete39xMZ3dQqv4p29UnXqJ0gRwaoUFAk0a/jJ2e/
         kp3SKj+NTF+gK6g0lnm+va/o2VLS1Uqo2tP651dtEdEXARrmtIeSS6HdPKdSs5x/ONC0
         EjNlPgApO0un1yTmX8eN6CiV0hUnRBQzEGtN744JlEINVBfdMG8FCEkOedCmRTl6N0wF
         tJIkvHcB6EGz3GvmJ58JJv1sp4NIOCwGN4c354NnhCX71+KUmq8fizjl5QIdFiiNb6mr
         EumW3x5zgnfQx8vuw7CjM0c0uQ2zx4zxpBU4XZbTwTmK3Z7p1zsVr5s+vobECUv+jawx
         xcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGAsEv7F2I5WbxnHc9cXcU5Ur0lByx6FXFNWfR/fZ8kVaYk3PMsaVhoydLIkJg2P3CHV+UR8k7LIptLbZ4II/BLRf/8RmAoSRsY+gu
X-Gm-Message-State: AOJu0Yxpx96W7y5tpaFD/4lEzPGIwMwOOjThaz804riTrecwrMoVfzRm
	eACdTpNNWSEcC2Sen5o/VscTsy7a1ZH1FiQo8MU8aKGjdXh/AJK/ld1GgHasgnI=
X-Google-Smtp-Source: AGHT+IE3Cp6vuMXDWAIPcIHNqCYov1VfYGyfxDQht/MN7zZ++gROSc2k0OFvbvjxaSVXyjIFzFWXrQ==
X-Received: by 2002:a05:6512:a95:b0:52b:8255:71d4 with SMTP id 2adb3069b0e04-52bb9f669admr2379081e87.3.1717758731835;
        Fri, 07 Jun 2024 04:12:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41e1f1fsm501872e87.46.2024.06.07.04.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:12:11 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:12:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, stable <stable@kernel.org>
Subject: Re: [PATCH v4 04/11] misc: fastrpc: Avoid updating PD type for
 capability request
Message-ID: <wn5tyo2tk4ybt5xel5leicdi5uvblmnabdh4vhfnupern5jaja@fu2d4bf5mcgp>
References: <20240606165939.12950-1-quic_ekangupt@quicinc.com>
 <20240606165939.12950-5-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606165939.12950-5-quic_ekangupt@quicinc.com>

On Thu, Jun 06, 2024 at 10:29:24PM +0530, Ekansh Gupta wrote:
> When user is requesting for DSP capability, the process pd type is
> getting updated to USER_PD which is incorrect as DSP will assume the
> process which is making the request is a user PD and this will never
> get updated back to the original value. The actual PD type should not
> be updated for capability request and it should be serviced by the
> respective PD on DSP side. Adding changes to avoid process PD type
> modification.

Nit: Imperative style, please.

Something like: 'Don't change process's PD type for this request'

> 
> Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f64781c3012f..abdd35b7c3ad 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1703,7 +1703,6 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
>  	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
>  	args[1].length = dsp_attr_buf_len * sizeof(u32);
>  	args[1].fd = -1;
> -	fl->pd = USER_PD;
>  
>  	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
>  				       FASTRPC_SCALARS(0, 1, 1), args);
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

