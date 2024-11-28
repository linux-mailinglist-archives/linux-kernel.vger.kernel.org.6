Return-Path: <linux-kernel+bounces-424723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD79DB886
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689EFB22495
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32E1A9B30;
	Thu, 28 Nov 2024 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x8qCv6f2"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB61A01B3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800300; cv=none; b=i4E8KQiFXV4h/kVBUpIItltSqinhk7mOm3iuCGafwYTqdLWtewC4/V9/YI+L8GvqTpyvgt/C76dOlEs2JEFlBOqD8aQSEQF+0VxtxZFqGjM9AnnwmKcOsZXcyKQ3+ikRaaWJiFWOTUpOKgaD7shFwfeF915xk4eYf5RGDOVDaUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800300; c=relaxed/simple;
	bh=TJHCUr65Fx9nI0lYWVGuUksq2Eus8GiVaUverXhwu7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1pnkIxGCYQ1BLqh1htNDPlW1TE/iAK93KrbIWGwPb9kC9BLOOOG5L2r+p+daNzofsn50HfNmHMRP/XWLrCrpRNHsJpn5bAcWus2XE22yMv/UUmBiHzgurWsnKmS0+/16eOzqYYSB0mkUvfA79KHqZDIy4rkBlP6Q5qHKPTBlF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x8qCv6f2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df63230d0so801167e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732800296; x=1733405096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu+TtrzBU++n85lMLAMaz83aPvmp/GtLgt6yR9tcsxk=;
        b=x8qCv6f2g15tGWULR74XizIesy3u9PNUaoXsJTDaYOOkU6bz4qIZPlX1KJOpiqH2wq
         aPe4DId55Z3tvCHoIjDmoiOYZKTPgAn1L29EJHFmmfqA0t3JWRdtDnW/CzKoYLZlzU9r
         vKYRnJXEZb/bIffKGg06ZsRVaXNepgj1N38LAhkJYcfZdFZ2CnkpWBXLdZqp9l+13NHE
         A2anRj9u8uMhujJHTKYEB3CvfOWTKAJF+xfEopNyCrUMHMlx9VeJ9yAANn7D9Nd/Sflo
         aYb+GM7WryQ3Aepp5QqJ285vk35m5Vre2fuLKf0wqsfWfcOnr+hCuphTTkV2MEbpsTP7
         /HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800296; x=1733405096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu+TtrzBU++n85lMLAMaz83aPvmp/GtLgt6yR9tcsxk=;
        b=rLRAHEHVu19UwF2Rxfn3d5WXnhwYxxLBEIOnseh0/gHTdeXgS/igWda3S1iHtdU3FI
         b2hH6s81SVNgKnc3rW3RwDV06vnElxqsAe/SjhTx7RuGHedzB9uQfK5oSjKAS+FXOOyV
         IhkD1UkhmtzZbCM/GRpwBrHKSHS2eXR86H+b3JijZ57yC6U8Cagg0fI/3scUG+nOWNch
         c7jXfbW4B6wdp1dfPAnUwVfS21CXPRNivfmKtDYKoh/fVYvUyqY6Nq6+Wp9x5ti6eAva
         BlPBUm1bt77Y1+poF36F1Wi8Sg4AaYk0KXio5/BIL0M5uOhK2sQ3I5Un7b2PvWaekZeS
         +KGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdVVhZSAYA7bSe6EFhsUnrasFOBDUmjfeXLz2r/u7PVf6zRT30PKVXwq0a46SnXbIziSq6WlcezeDF93k=@vger.kernel.org
X-Gm-Message-State: AOJu0YztD3hkgY1c9eJv1OThf0rjfBz5/FpB5qWzlqBTHVey2i0x6G84
	OKjXbo8AoTWNR5khPii21lSMfnfEEn6FIRWeTWGwS2XZucDK1tFhTwJyPXL3at4=
X-Gm-Gg: ASbGnctAGde9CxF9VLZ9S1I60MDxCOhbvqopxva7dMNXXCa4fwBumiRjqD11iCRiUgZ
	F3tJpTJCSf3XGNmUwaJTMMvzxj75b7NZF4YR2Q/dfSLN95XFET6J52v4FgDpF5Re0JQCEXPLMKe
	ti6AsFlquk17vZj+dvNc2KvrmI1HRpb9QvbGcDFDIr0T4YUN4M9PcAaduHqi+JKE/Q6GxH5hkJO
	xJsYrDVPfxK/KPQaA1xAbeFWflySsnQ0lEiAIm1/Zbka4/95XL9jjynzAr/BG2DTEOFrEH4ThkV
	Rz/EuAHrPQL0J/jgwgt5QV5rxF2KXA==
X-Google-Smtp-Source: AGHT+IEpZe9yoi47jMikkocK38/MKcOL4vKUAWk7lAfQh1r/azAfrCwMc0oz7RX7DyOhdOTWypto/Q==
X-Received: by 2002:a05:6512:a90:b0:53d:ef49:5b5a with SMTP id 2adb3069b0e04-53df00c6057mr4150533e87.1.1732800296195;
        Thu, 28 Nov 2024 05:24:56 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644313bsm175297e87.69.2024.11.28.05.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:24:55 -0800 (PST)
Date: Thu, 28 Nov 2024 15:24:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/7] drm/msm: adreno: add defines for gpu & gmu
 frequency table sizes
Message-ID: <emsraqtyxkanfzafej45dt47hdx37okvngomqgou35a47uly6k@5w6iwq6xfjul>
References: <20241128-topic-sm8x50-gpu-bw-vote-v3-0-81d60c10fb73@linaro.org>
 <20241128-topic-sm8x50-gpu-bw-vote-v3-1-81d60c10fb73@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-topic-sm8x50-gpu-bw-vote-v3-1-81d60c10fb73@linaro.org>

On Thu, Nov 28, 2024 at 11:25:41AM +0100, Neil Armstrong wrote:
> Even if the code uses ARRAY_SIZE() to fill those tables,
> it's still a best practice to not use magic values for
> tables in structs.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

