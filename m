Return-Path: <linux-kernel+bounces-417255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B49D516E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E57B2556D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3B19E971;
	Thu, 21 Nov 2024 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="femW/hq3"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2860413C807
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209076; cv=none; b=C5/nbG61zfh5nvVCHCZ396yPxOiCd/VQiYxffn+XSU/x7sfx4bqv6vSzTq786rJ2rwWZXl0twpESWjePw6wWLWxwNk4eD637LPNuDJqTgk3vtu3XVBDYm2fDP0WuxSCTF6/UJntCg0O8+vJRsmEzhkNBohTgltbn9fQg36lIle4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209076; c=relaxed/simple;
	bh=+AL6wkfuA2btJisY5BliOminhIkzFmMy/zkSJfUjIhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMGpKQZovH5LIeSlzuaxE3OGbjizIdHwazn4sn0GIo1ectGzAK+5rFhVpzmjml3f28brtg7aSq2ojtEuaJppdYnHPIxNdjZXnb5fIQMCzZkfrNH7fmyssmFq6anJO3nLiXviRrCE7VcuVSWIYXQbYUiZa04F3LY9OgBNNgoxmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=femW/hq3; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so1191971e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732209073; x=1732813873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMEW165paKttKZq6OB5pufjOGDOmBneCMyuKHIOgj/g=;
        b=femW/hq3VbzTqyoU8TldxJwJB+DJpZFfdtXHY2zUEV1cBVC+y+PZy+6QdjCGsWC1tr
         lNp7XnZDG2N6qDF/IcKtE/Vll72kfJeWl64cFNtWTBWm21V4LY2lT0/XbMsdY1JOi6DE
         SNsc9csCzWxEVa2/DY1m2lRk1ge6HDlWWoeWthk2yVTyDH0aB2xKuqVTSBTCE+hQEIzz
         kg9fPjwnw8L/bPbW8UF8ccvFEJQKswFcOvg7Z5H+q2g3eZuflFQ86dsM5anfLaifVKBA
         VwtryyCQoqofwbpPNg65vQrlktHtZS7orGlN6roVirlSv0RoFtGnV7Iph2Uqdp5zvUiV
         pn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732209073; x=1732813873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMEW165paKttKZq6OB5pufjOGDOmBneCMyuKHIOgj/g=;
        b=E/HuIQeke3WyOFhLsx8PKYOIabcpcQmmP6mijZYsDVDoMXjV0gtzEnKA69SY6nvXsi
         DFV8ghAcwZv7qqcyAozF0H09rNPUOrCHcVe4SIg/rkB/jJXLa4DGwpon33i2N9AYU5KU
         QcL42Oklv3Rqkgd342crs3wsJ7mpmSuZhqc9W+7Cx42oGnzsCiDoYj/RsIptkl3b+Ein
         cT67vHnhAhc4W0wibVJviTmWZu1gv/Ua88fS65u/JkdooFKZPA9VZUq4+nWJAsBia1zI
         l+j1iWMmocC1Pw13eTiDKcTfJIpleCDfq1FGARzzRbVf8xFieV7Uk1JxgCkR964I/aIb
         dsmw==
X-Forwarded-Encrypted: i=1; AJvYcCWJEzKl/WrXMPlAodiYXFHyZVsnvnWLXxixBps3XL1dx+07nthg7GrLZTlDHqZMUzvfJ4/FEpW4IIobM9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxvkGWoN+K4Gu5MYwh4ZvQYtn5aFxfZ8QlwPc/SvkmO/XggkVl
	LCV/vIKKt1WRtZsggxcJFzZY3bHqgoRAk/6a0pgGw0TalR8Cw6T+qNd5VD4n/+g=
X-Gm-Gg: ASbGncuWrXL4o3Wky74Hm9sdHp5VWoptEe7it8ozVb/93XYQXOZiVb4+kS0yJ99lcXk
	fkC8YZrsss8g6jtnHKBzC79Zn59oQ2QWg71RZAQgCp2gwf89PyC8TZ0CQh+EJoxp0Elg6pN4EzZ
	tBhr0Xj8phhw0H3D0QqrtPRIC6QlcefWRPaiumMkHfZcKE0MrRpMuj5SkvKZcQq0KHtvylRz8US
	clT/btUX5vpM8T07H3dzYNEOc5pQNttz6DkX11HdJ0gV4j5rIVfSmBFnVO2apwvCzoCc4EefgS0
	p7Nljt+4oOL89XI+xRwvSZGBz9ol9Q==
X-Google-Smtp-Source: AGHT+IH75E9kHCeJ9hwtn+b2lfsAECcUMBrPaNYfXzIudtYhmAv7LO26flEfRN2vJp6JnpGQMZqjQw==
X-Received: by 2002:a05:6512:1051:b0:53d:d236:6f7f with SMTP id 2adb3069b0e04-53dd23670c4mr268737e87.12.1732209073257;
        Thu, 21 Nov 2024 09:11:13 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481f18sm17470e87.158.2024.11.21.09.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 09:11:11 -0800 (PST)
Date: Thu, 21 Nov 2024 19:11:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_riteshk@quicinc.com, 
	quic_vproddut@quicinc.com, quic_abhinavk@quicinc.com
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: sa8775p-ride: Enable Display
 Port
Message-ID: <uf7nk7n2ji34my5y42zz7n32aqn33vnqeg6zcxlimwcmpa75zy@stbrgjkt3jqi>
References: <20241121091401.20584-1-quic_mukhopad@quicinc.com>
 <20241121091401.20584-3-quic_mukhopad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121091401.20584-3-quic_mukhopad@quicinc.com>

On Thu, Nov 21, 2024 at 02:44:01PM +0530, Soutrik Mukhopadhyay wrote:
> The Qualcomm SA8775P platform comes with 2 DisplayPort controllers
> for each mdss. edp0 and edp1 correspond to the DP controllers of
> mdss0, whereas edp2 and edp3 correspond to the DP controllers of
> mdss1. This change enables only the DP controllers, DPTX0 and DPTX1
> alongside their corresponding PHYs of mdss0, which have been
> validated.
> 
> Signed-off-by: Soutrik Mukhopadhyay <quic_mukhopad@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

