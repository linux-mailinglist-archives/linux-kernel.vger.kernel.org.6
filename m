Return-Path: <linux-kernel+bounces-548296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F38FA5430F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FDE16E8E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E08A1A23BC;
	Thu,  6 Mar 2025 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6ddBh2Q"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5BF19E7D1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243708; cv=none; b=TcSOiLXARnVWNxNj2a5/nycAM9vW4PWWnE/nSnZLGuVGQUP5TbXe00U6rC56y2z+lteqEAnIAe+8tCijJdMLlaz+k3hf8ojjjBA8DQ8IYMq3hlzmfIdDBPrEB2T2aijqjxajt+o5elD5zbN+cptbJtwBeXetDnQ+2tTFSWxU4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243708; c=relaxed/simple;
	bh=UA0gi6dU6GWmRwcwBxSVb+GE50ynrzzdgaRpss5hpj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCm3Jx6yrzJx1PEQRXS3dwpU/xY9vXMsb8unOwmzswh89KOkmiI/5TCXvapL7I6ZhuQaxlaX+gCGRF7Urvi5tVy376HJqHoXrKdBH7hYl+u4xM207joDwf581fPbD7CBYnLTeXZrwcK6zx5nqZ5OimYB1+ZONkVQ9jo5HzumTM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C6ddBh2Q; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5496bc2e1b7so327020e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 22:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741243703; x=1741848503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1tgevcrO1W0sGqnA4Y17aruM3TaIseJYV5OzYAAywA=;
        b=C6ddBh2QxhQxk+P85gEIKgonqGoMppbsVssh7rJWuOKX9gxmfr6zcK7nIn4o1U8pgZ
         22nUZtZ0iO46ps42/XBv1qJaB8IlOyjFYvD3QhlX7x0RmmhJQYYyQBHOpBo13H3XuMaQ
         4B5misdN/5I2E/NAQxBHB6vCbIeYHoaK+zQkwTO9EQLnXicy7aWdDRgo1orr6mI8fX8Y
         0zUPPbCXVrs8qsFvoCNMk/PmPZlb466Jq3N6NsPVLkdF8KcLkr0QZiSe//+6UBcZqOTd
         43QfAJC34LD8hE3EcBZeX+NiHdam5Z85d2/Geki9jN1w96uVDd+gutVgLnd73FTh+9ey
         JGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741243703; x=1741848503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1tgevcrO1W0sGqnA4Y17aruM3TaIseJYV5OzYAAywA=;
        b=mS5ND4A2uWUoDL1V7y86yNPlvdg22Ud56G4hzlzaKc4dalNB4I9qrMXwXR29bzIOyv
         iqv5KixEUIS65ttioqguRIK3+a3Wv5xfnaekZX8n+sQ8m3T3Wmi5RGdu9lpgoF1sQaQr
         ORJtDyB28/pINenxq3A4uO3W6TGG9QpFtF9VT/E5N9EegL+0znPSwmkiKZlIr9EXKhGs
         QQmgghCchmAsMvTli7tqY1t3UJzxpN99QCbu2XCFwX7uASUdhVHgJDGIGNpLoQvc3IOO
         7w7QPmP7ZVvGzTBm7Yn6rbV3FyaVI8pZMXFsXvEBtHLrNrFbqMrc4flfPYb22BtMuq9d
         4CEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZdpCI66OgWwrlG9vgpU/eLY4QmC7fR1Z8faMt7kd3fll9e2K1W5u+PsVsJSehXTvn/bXfKf2KCUwa4KU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UPw6fcT7gL5XP+/x0l6TU0JcHrWlcgl/lx4R+ioXuTdj4eit
	AT4GqlNO/XxoYTglvD2UQ8SCmSz87uNerGsD9e3MSH76JRwM/emregWgpEh+4vw=
X-Gm-Gg: ASbGnctvxbNdPuZAMcThS5VRNb1KoJF+5/04Znmj4GLj/90oOGp8w7CF1cW6ij7lPtM
	BuxfSfU+kiKSCw4Vy1N7tokZPrRbrR/E9LLNJfstTXpiyBJugFfgu0FhWT/TRBa5Xx4zUiK30p3
	sp3v9pVzn9ev7kd5WsTZZenvv2ov3ayHg9Q1i+gPXaD2q5OrFdoBk/3Y7DiK1CCABqs7jMqc3JL
	e+PjVoCq/4EuGRtJmuLQ1OYl4fQffFlOGDInjZ7Mt8qPcz0NRJCzef1sphs2+2j5pTXLZfnqe7n
	T+9ov2/Qcu0QRu5KexSwbnpCcX1TwrmN0gLEt6UYWwPNocnQOzEbRZ6K0TSas5LvpzY6UUNmoDv
	jLYfedsfP5g6Fx6ni/yeP49yO
X-Google-Smtp-Source: AGHT+IH0hkV0iX6P252sfEzSP5tCD+8r0VAB5ZE45IACRvNYvn/oK9vSvfMyEF7y7x1OJNcNv0ajeQ==
X-Received: by 2002:a05:6512:234f:b0:545:2550:7d67 with SMTP id 2adb3069b0e04-5497d376d53mr2072687e87.36.1741243703464;
        Wed, 05 Mar 2025 22:48:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae46137sm84341e87.9.2025.03.05.22.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 22:48:22 -0800 (PST)
Date: Thu, 6 Mar 2025 08:48:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Clear perf params before calculating bw
Message-ID: <mzkarsq7qljikfe3ef3hhasouee6hjmf4goqxmgbh2l4nsap7g@tachus6mob2y>
References: <20250305-perf-calc-fix-v1-1-d57f356caf59@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-perf-calc-fix-v1-1-d57f356caf59@quicinc.com>

On Wed, Mar 05, 2025 at 07:46:44PM -0800, Jessica Zhang wrote:
> To prevent incorrect BW calculation, zero out dpu_core_perf_params
> before it is passed into dpu_core_perf_aggregate().
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

