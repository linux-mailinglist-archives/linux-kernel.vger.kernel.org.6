Return-Path: <linux-kernel+bounces-258655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18B3938B42
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D8E28155C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AE6166301;
	Mon, 22 Jul 2024 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpFyYqaM"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213DB14A90
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721637183; cv=none; b=VIlNU4Cf1Xt5gqG/93R0ChTAAwR7SVO3VEimZpf93w70R3w1rrMsdqIZ/MwmQEvixGfv91vbI4AeAEImLtMF4wVNMmoT6B/t9tLYA2zr0ktWULoBxL1T7mPJ2q5MfFt/8lhiz7fm0Q7FhBq5J9ildgayW702sqy3Ew28dLj8cEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721637183; c=relaxed/simple;
	bh=g4wD0Ler+IKJdwaaFfmTC6uHj2G72zSZDhKxHujKEec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCzPao4Xw0uiDUCpTpY4jKysLWrDrbsxVe5DSz5X8m6yQTl0/hf+jXCEUouOhRKzZoUzfYkxwCYEwWJjGzOzMVCORkszPTL4gVjYVmYS2cp0TZuzejJCTZuNcgbcVBkhsRanmH4NMTztXRER7uwJc5+R0K/FGBW7fJpalEd+8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpFyYqaM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so69112401fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721637179; x=1722241979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8sNrx4VreOw/LgPBLnoWulqquEYUzh0E/7dzJx6llQ=;
        b=tpFyYqaMroM5rSASaXRZ63pHJNRexP3r/lci0cqvEXlNS/N4RfPq2bwM7oY4r7nHfA
         wrhWfQHpor20+VTEu/iu7EEjaKIZcTRujyrSTXtF9jDwwf5TprgN66P4UAbb9WG50cak
         2fCJFgHmH499r+Fx67oQPa15XQ2D4xF8cl8Bf0x8EjdeiVxQtaur8Lq5TyFPcs9FrmIf
         xWVYbcLgVZYQ1IQH/8A1DALs1R3z9D8JmybEBiKRu2sQl4T/37VTTWHX/bDMnddxa4qz
         7/oyarubk9JGDqbwnFY9w9uQv0PPBmDFhUeOy+k7eg1QlFyoZpEh3YbxRyJ7/Qf7Ms5c
         LrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721637179; x=1722241979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8sNrx4VreOw/LgPBLnoWulqquEYUzh0E/7dzJx6llQ=;
        b=AGDy26UaK8Y1WBOgcaVKN0ILP04F07ugDpYqW3frtNAS5oLWJIrYhGV0uBDHRA1kSc
         Cu9eUMdeUthHWBiskSlw/UFsGyBIYoszWWbDEnuxmeqLCwHrSlCx2n0se1x3i6hGSGVP
         eugcRQRh4zYpe7ksY1phs+wgiE8XgqpXDhbktEZzjX+0lHPUge4l2pCWL9ZRRasSGjAe
         4P7y2VTDKiJWqToStf/OrGLETHNcomuCvnuSmKC335zInecvROS1kiQPmXq/h8HAZ+7G
         kng4rW9f2YUPkD7uHd6IBvJ6Tk3FEjJPddzqDr19X6Xsf2tw3rmWcK87QrceHeCZ40wg
         L1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCULTUUV7C2swFqZVbNwTc2lQqqJWlSFF3+1tfhKAo7bNEZwl82I2YLdvJL0PAUZDuBW7RH/1AGX+ZDrmC9MaslgCgIvmzAKWoKdnrAs
X-Gm-Message-State: AOJu0Yx3yWXfVEdI0pMZguXTV0T/gh8twetNjLVkyrUZ+oDf8tq11OSS
	rRRU5W2usksWbJqrJjfsmDiSDQHI4fIzpORWWMDXfRWgXOM2Em4YhVWoICR7Qrk=
X-Google-Smtp-Source: AGHT+IGUVxNFBkmLm7Caxhwg1z9pIP1ZJJmKfA9dUPMTeOS6qsRdqa8z5TuJ7r3mhAByJG5dV2LBng==
X-Received: by 2002:a2e:3609:0:b0:2ef:2e3f:35d9 with SMTP id 38308e7fff4ca-2ef2e3f368amr24399581fa.33.1721637179187;
        Mon, 22 Jul 2024 01:32:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef28807aaesm6517221fa.43.2024.07.22.01.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 01:32:58 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:32:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de, 
	stable <stable@kernel.org>
Subject: Re: [PATCH v6 1/2] misc: fastrpc: Define a new initmem size for user
 PD
Message-ID: <ydp5ntlresenovs6qaqt7wdaleuruubem5hajbfadkratfsiam@wjn33ymp4gyc>
References: <20240722080200.3530850-1-quic_ekangupt@quicinc.com>
 <20240722080200.3530850-2-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722080200.3530850-2-quic_ekangupt@quicinc.com>

On Mon, Jul 22, 2024 at 01:31:59PM GMT, Ekansh Gupta wrote:
> For user PD initialization, initmem is allocated and sent to DSP for
> initial memory requirements like shell loading. The size of this memory
> is decided based on the shell size that is passed by the user space.
> With the current implementation, a minimum of 2MB is always allocated
> for initmem even if the size passed by user is less than that. For this
> a MACRO is being used which is intended for shell size bound check.
> This minimum size of 2MB is not recommended as the PD will have very
> less memory for heap and will have to request HLOS again for memory.
> Define a new macro for initmem minimum length of 3MB.
> 
> Fixes: d73f71c7c6ee ("misc: fastrpc: Add support for create remote init process")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a7a2bcedb37e..a3a5b745936e 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -39,6 +39,7 @@
>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
>  #define FASTRPC_CTXID_MASK (0xFF0)
>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
> +#define FASTRPC_INITLEN_MIN (3 * 1024 * 1024)

So, what is the difference between INIT_FILELEN_MAX and
FASTRPC_INITLEN_MIN?

>  #define INIT_FILE_NAMELEN_MAX (128)
>  #define FASTRPC_DEVICE_NAME	"fastrpc"
>  
> @@ -1410,7 +1411,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>  			goto err;
>  	}
>  
> -	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
> +	memlen = ALIGN(max(FASTRPC_INITLEN_MIN, (int)init.filelen * 4),

BTW: why is the code multiplying filelen by 4? Nothing in the source
code suggests that filelen is in u32 words, so I'd assume it's measured
in bytes.

>  		       1024 * 1024);
>  	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
>  				&imem);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

