Return-Path: <linux-kernel+bounces-380503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB80F9AEFB2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911CA283F67
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BB61FBF65;
	Thu, 24 Oct 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CapAVDcl"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E438168483
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794650; cv=none; b=c7NVOUQznm2NspjezQWlmNij1pC8duXsm52aENs8vQDnFabvSUHyqrkuuGkmfiZXq8/2wzZvRRkbpC+wEBRg4vG8bYE9wPa5p2uxTu3sSMPxoHSYtidbYu78XOm2K0NO29+0kt7xcnZe8ku3TwYnY9dmvjXu44pgsV4bFY1HVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794650; c=relaxed/simple;
	bh=yI+Y9272Bgo7aFmteeZjMbL2tyekwQZD9WYomhNosGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyF5wePEGj5AhX+dMCNuCpWlFK8+gzD4p8AeCkRB0wBmMPfSOmsgn0bJrb4zT7N49BKp3Ds7otzsEpsgTf4qwzmRwcxxtuRsA8eUZfJa/yCnHMR8fRGN6nqJSjCBMOTDKMpLBoxxX0nbZ3oArWcJjIH2TuuVlt++OFyoTQPjGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CapAVDcl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53a0c160b94so1565254e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729794645; x=1730399445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/1/sAyVSibd5hLQyAm0VwFvDlH9FogTkRBA3XUw/H7Y=;
        b=CapAVDcldXrlwG1oPgfwNT4+8yQhjpJJHKUCrivuRl1qflYk4l3Oly3MYNUXRUaIzo
         IDmivzTgDN9/L31V0cNqXOE2qhkXF+Dwmvf/Ap3DW7kzdlyVL+dcwaP/kNLVIsrIrmKV
         FSUKK5l3Tox2m8zbvbwC7M8iWfjk3yjS06lAeb18B1qF3XIlxfrULSxktrvmw2of/KRS
         F28014xKz53Rt3CNvQooRFSk+9ma6LDkFdi3my5+zkrg8DzG7Kp/FWwlTFOCfOZCoyqb
         ldYHRN8TscE9sj09cJz3VbKOmQJlkGyOrEg7bnOkd5EyBKPG6f7ttD9FIg5Shg3m4yTw
         vYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794645; x=1730399445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1/sAyVSibd5hLQyAm0VwFvDlH9FogTkRBA3XUw/H7Y=;
        b=H+CTxzJqzkjqCVyrQISpZI6302I/pOv6I9CaaEHwqFSBEf7YPQNw9ufZpp46sGyJ6b
         s7+bLIQ72TGlTvmNIrT/Oo+Sn7or/Wk590xqHUUpJmnKuC5fQHNH1IZ689pebqAChxpC
         47RNRQPFtouzF2m1GDJY5chOku+saOsTAXK4bfDHVxaNvA9pPb4PNHwv6mtC6dFammBN
         qErWaxSSJnrkCBJGI6Sl2miKyVtHMQolsrKp8GfupfkSinkMK3qRaT4qIClRysqSC2Ss
         1uNv72o4aYigsJdKpfTbWgBc5GKKm/8In0+bR2WQ4K8yXLCrVf8k0Udrrj3t36i8S//F
         XVAg==
X-Forwarded-Encrypted: i=1; AJvYcCVu/8UccTS2BCV/jYnNuUDvpFhYddf3ZL4vmgyLzKlE2Z4y7wMViu/PP1DCvw04IUjhmp8R96eYOuopscY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXbcPQIClbfpFixWc1/IGQgNgHVLYPwGuJjhbrkzjHO+3kWXv
	QE1QRKUq4Cz47Xv6cPR/F2btn8+f4AxsYawYhLWOZ6QNyfGBtGTYTSkq+JpBDlw=
X-Google-Smtp-Source: AGHT+IGrzoUBynCTOp+oNLSSYcxeqavz0ElVUXCpaD9ZGmZJS9xhP5O/rMH2mwesCuRuN19+XBvTWQ==
X-Received: by 2002:a05:6512:2254:b0:53b:1526:3a63 with SMTP id 2adb3069b0e04-53b1a373bd1mr4614519e87.56.1729794644786;
        Thu, 24 Oct 2024 11:30:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22431454sm1430864e87.212.2024.10.24.11.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:30:43 -0700 (PDT)
Date: Thu, 24 Oct 2024 21:30:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable sa8775p clock controllers
Message-ID: <amatk3cl4rayggvir732jtopirqfjzvra4dspohc3xoctonfvs@zuxbjhncu54d>
References: <20241024-defconfig_sa8775p_clock_controllers-v2-1-a9e1cdaed785@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-defconfig_sa8775p_clock_controllers-v2-1-a9e1cdaed785@quicinc.com>

On Thu, Oct 24, 2024 at 11:22:55PM +0530, Taniya Das wrote:
> Enable the SA8775P video, camera and display clock controllers to enable
> the video, camera and display functionalities on Qualcomm QCS9100 ride
> and ride rev3 boards.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
> Changes in v2:
> - Update the board names for QCS9100 [Dmitry].
> - Link to v1: https://lore.kernel.org/r/20241022-defconfig_sa8775p_clock_controllers-v1-1-cb399b0342c8@quicinc.com
> ---
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

