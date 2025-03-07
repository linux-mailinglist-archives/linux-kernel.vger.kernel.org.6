Return-Path: <linux-kernel+bounces-550411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D3A55F1E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC6E1893EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955D818E02A;
	Fri,  7 Mar 2025 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scdHHOoO"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A236157A48
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741320237; cv=none; b=LcP8Zq1Kh6k9CZR3uGDUWs4wwwzWsbuo+5WjSTFVLr54XtYzi6sNPSCV7paXj75RkEhK9hkFpBmmeSEzsi5VSAr5L6gnP82oIFDCBdagh3dUrThXxFUHGfLeOMZViUdvQMaT4KrWYY1zz372jK0jUpfaFApgvCPdohPBRUBbDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741320237; c=relaxed/simple;
	bh=IB0b27UAz8bwJMlHSb6ikfeP9mwsthfyQDSwmR3e5BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0By+wQ3sVEDMiQ6GwpTlIorQsfPmPsROuyxuw/uc+1nr/vP2wgAe4fKRS0jw+pgcqQ9eQBpS5T/AttnqD/0a0Q/qTzt599LJ0TGAfw38nCaa9f6szd9ULhf5lkJcpxeuNY/jgE2LbTYydm+jSKHw1ioaJK7zsXXDdHZn5RyYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=scdHHOoO; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30beedb99c9so10612481fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 20:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741320233; x=1741925033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q559lQVO0eqbcaMdE1cepZ7h+gw822oPb1VcWyT+D3k=;
        b=scdHHOoOTnqIusmPxjXSEq/TEvuK2fKlP88lP9wMgyu3IhKLApALt+kfhgypJOub6f
         VynUcRSwJ9UfXXXLWLTexIOOQkV7craFixtEskid2ZgibB6VlA+nRRrzsZCbbT8QVXn8
         teUlEk5A4yKkIXMxkNO8vor3jeWhKQtf9qqVFO2e0pHziugWcMYIW0HZMy9tY6xSkXfN
         7qJHkS2BK9fcBHHcQjJDN658KZOa6lEayXtLvQ+9DQjD/R9YDZuHYu1JphIdK0Kx8lR4
         BWc1Tcy9ol/Mv5lA1HGrdpwNxtryJejwWfzvSlpxY+yFVoaja5jgl6+ZszJjRmp0Qi7u
         sEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741320233; x=1741925033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q559lQVO0eqbcaMdE1cepZ7h+gw822oPb1VcWyT+D3k=;
        b=W9ePxtNgPEQjNPElmACwadsK2Hie2ndavuQBAUbvNPmDE2XM6N82ngKG6703pG7FY0
         5IO5So0GWf7LqO7qIsf58fEAGjazhECPawW9GJvYj36oltHWN6mOeUaUNTdCGymWMAkF
         TmSI0xMwusH9OeRVkxKYPt5zsPH20zY1ikAEtQ5Ml9NgCeKOqiZeh1STVlcqjHadRD7a
         yR2vfQNEWtUQ0wJtfU5Ni3HpmxbhY6C+mnJubWg4Js0+6RE5iYCAWc2IWyHW+6EEDGUy
         5wN0q8D43m+2P6BktQZkgrG2KnUnHByk4bc+AOb2igJaTr/ZRLiJRx6Vz/mPR9UTTHvk
         brWg==
X-Forwarded-Encrypted: i=1; AJvYcCUI2asiZeVVPazXU/EYgIVjFxdMMX7fR1Vgkw0OxA6sguijGw4Pr6S0TVByp1m8fD+m11qpA0Czg3ij8Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTTiIB52Ob/CiGKacSr6b36ot4eRWH+/5vXUf2uG5Ud5QlnNIm
	I30aCuSKluwbkAC8L8UKRibXPlQd4HOa38fZ9eybvdgVUeFJhS3gvuWEKIH9FkU=
X-Gm-Gg: ASbGncutCAcANvCaYPBXwu95fM4T3lb+yJ0ZOQjHlSyhjDz4lUbgnhqgwTH2AmDJRYI
	GCqwXNQNQwMyJGtG7FLXhMTMPMzFflvsM3VwiLLbA8qRRqDT69rq7Se2XURyFmldzQvN66Qy+yF
	ndUHBsSnBl+cdWfMQ0twYuFmUSMB/Go5PPvuNlFXym+9zMZyKDjGvmRSOR20zP3JlOi7j2RPo3Z
	QweD1yo8mcXlYPPwV8VlB1Z0pah8C8TxZDhw5atpN5gKJn79o2t0HjZRZXR1qvQYyaqE4IKcC4Q
	fCZTeNwPlSrQ8ViT10CzMQx3LXII05wLURFzItkdaRazwaZbOKcTU5KEDw+J/Gb8IfBAJxMGJdX
	E6sPZWHBxhxvC2rNPhnMoYz7u
X-Google-Smtp-Source: AGHT+IFkU/H2JgQ+KzgwwZXcDnVmGrvz6WNb4Dvni6Bmcn4jgovRKWXORNDJCk42rS/+awsQtmG+NA==
X-Received: by 2002:a05:6512:3b14:b0:545:2c2c:5802 with SMTP id 2adb3069b0e04-54990ec1da0mr569205e87.48.1741320233311;
        Thu, 06 Mar 2025 20:03:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae461edsm362946e87.38.2025.03.06.20.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 20:03:52 -0800 (PST)
Date: Fri, 7 Mar 2025 06:03:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] drm/msm/dpu: Remove duplicate dpu_hw_cwb.h header
Message-ID: <gs6zemh276kxuphyedsv445ujroazok6jq66mdljkrkd2f5fzf@zjumlvcebaix>
References: <20250307015030.86282-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307015030.86282-1-jiapeng.chong@linux.alibaba.com>

On Fri, Mar 07, 2025 at 09:50:30AM +0800, Jiapeng Chong wrote:
> ./drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c: dpu_hw_cwb.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19239
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Also

Fixes: dd331404ac7c ("drm/msm/dpu: Configure CWB in writeback encoder")


-- 
With best wishes
Dmitry

