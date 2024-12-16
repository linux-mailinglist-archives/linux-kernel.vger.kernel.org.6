Return-Path: <linux-kernel+bounces-448243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABC69F3D63
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD217188F737
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175301D63D1;
	Mon, 16 Dec 2024 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQ9zKiYU"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7691D6188
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734387817; cv=none; b=j6ciF+EErcbJG+L0KJl6sCEYLKl1hvdulk9cfyp4LXxST0q+ENBLO5asyEPu/Sgo0+uWp4VFEfF+BLcKXIsJRk36xJiOmBP39fOZlBcdj15m6yAb5K10Q1MGOefEU+P5ox3DVnqB3I17Z2+vHkmKSHcvqR6JnYusgdJZ2j214Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734387817; c=relaxed/simple;
	bh=IyLjGTGGV5KYuJOCdVICOcgo+sGhsu85+L08WCbUAIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXAUOEqH1+WYbuokmgDG23FC1/Jd2XCzFvC/fJD7Y/FdJwgqeraVge531uXzahO8IIj3JvVg3c3H3Y9LktgMbY8D4jVSPh7Lgc/nHwpoQtDKcpYhYOOSeAjy/eFlmkH2h3NtYG4xOzQ4eN5Ch/1lNvn3YgDUMykHAgwmvJ8Awy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQ9zKiYU; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3003c82c95cso38509041fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734387814; x=1734992614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mcq9gMedaNCczRwr6HjVU6c+vHbhB80maUVC1Rq2gc=;
        b=QQ9zKiYU7t7j2VNVoIkKCbaWTZsQNvy7p7LcT3F5p+d7z63QsxWOkKsdp73H72YCsv
         p0VO5Yf7GtBqaD80Tgc6blNHW4H3/kMf51SoHDR3sdOKC071GTlCTStR8s9C1n5Wn1MZ
         eEhnbjJuKlc4YA2E494Q+SagYPDY9nQcdwdM8GcAnto9DqNEE4CDO4Htqi87jUroNzI7
         EBFhNhaQI2v5/X2lH5Nl0+nS6RXelzlWJEqofZnaT/JCR/L8TaMojfb7MLAo0sTsva5g
         jQY6ZBfaomF+bXjloZRDaEIqAqoTjOQtXyabVf7pEiFJeWt6V9CP6bZWbJZ6UriXg13d
         4RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734387814; x=1734992614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Mcq9gMedaNCczRwr6HjVU6c+vHbhB80maUVC1Rq2gc=;
        b=EMqMe+AyoMUSWb6PcrD+7wHetyp6bjB6yivjIn+0du77suLprkqb55Ku0hmvMjuDhN
         OQkitRGriJXfUvu8z70iULs57zRNzj2lFkangR1JS2ZztSKXToaO+J8mNuF9WDuRJxGv
         Upt0pV76KyDzVCbHdGpEM+7EXMOqApiGhoOOYVQ21MeoiUCidGcx1aqnBh4gogvvwBp+
         ZC0IiPtJxX9ZZvOOGpUUtUqDJjzUREJUNchis1mHu+zxW1LJy0QasnBYCyAAmjYLEk3V
         AbDth4PZlg9shFhf3lJhMW6h5k6Wszzf9odTnTy00HD9aI6mNhOvOyf2qIiQHRn9OadE
         p69Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8ic2JCCIkLYu2n/XbbVHhtRdF+5l3xi51SyzWlNGJIBxZEDrRzpM5cfHD5/vAQS2Ujg44ibf/r7Ab5XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/6PcCK/lGeaUKQMK1Wi9rWuFX2Cfc/V0uZBUTbRgcdDm9+ye
	6Sr4EfSRbETbWrEinE+pmVaXLDUv6eDcLEz45HUQs0oj0lOqT/AA4O6JMBZ5Z14=
X-Gm-Gg: ASbGncuSUesj3OvR+gG59q2u3r0wFkRNbzBVm3Ip7Wiy3uMSul5B0foxVuTla8rhkjm
	0wBAY7TotpgNxU09XZTmiHSlqzt0e8d4htiGxE20rJELEgRH3OAVZxPaifwvDykJm9hm28uQFnO
	yiFslUOQoiOKp+XP8jIrQRkTyiEBXTuRqd9xosm1rbuFfPPOVajMlK01DGa8ILLmawE424xVkFd
	Nso7yeiPyY8oLo4wJWbxztR4zEa2VhKhkTtzwkeHQfZAyJq8wSbTPxY7+f5OfOgNtfrwET0qw2R
	qg+IlJDnpDsNNp+jKV4h3muTSbtJvr83VCfD
X-Google-Smtp-Source: AGHT+IFSCeRUjfR8fMtVy6j8Hm4BkcxvjiUW4q/+aff5Osc4iiR7i3258tq0eqpUXGQgHrhC+BFpsg==
X-Received: by 2002:a05:651c:19a7:b0:300:418e:768a with SMTP id 38308e7fff4ca-302544ae81dmr51479041fa.31.1734387813858;
        Mon, 16 Dec 2024 14:23:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3034406234bsm10618891fa.60.2024.12.16.14.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 14:23:32 -0800 (PST)
Date: Tue, 17 Dec 2024 00:23:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Li Liu <quic_lliu6@quicinc.com>, 
	Fange Zhang <quic_fangez@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: correct LM pairing for SM6150
Message-ID: <55dalo6ecncyceb6wmu7nm6hco4vixxox5grelykkdw5q6yjys@tac57c5nowsd>
References: <20241216-dpu-fix-sm6150-v1-1-9fd7ce2ff606@linaro.org>
 <54edef24-b27a-4d79-aff1-672d4e65b5a3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54edef24-b27a-4d79-aff1-672d4e65b5a3@quicinc.com>

On Mon, Dec 16, 2024 at 11:26:37AM -0800, Abhinav Kumar wrote:
> 
> 
> On 12/16/2024 12:20 AM, Dmitry Baryshkov wrote:
> > According to the vendor devicetree on SM6150 LM_0 is paired with LM_2
> > rather than LM_1. Correct pairing indices.
> > 
> > Fixes: cb2f9144693b ("drm/msm/dpu: Add SM6150 support")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
> > index 621a2140f675fa28b3a7fcd8573e59b306cd6832..81eb274cc7000a3b70b0f6650088ddcd24648eab 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_3_sm6150.h
> > @@ -116,20 +116,20 @@ static const struct dpu_lm_cfg sm6150_lm[] = {
> >   		.sblk = &sdm845_lm_sblk,
> >   		.pingpong = PINGPONG_0,
> >   		.dspp = DSPP_0,
> > -		.lm_pair = LM_1,
> > +		.lm_pair = LM_2,
> >   	}, {
> >   		.name = "lm_1", .id = LM_1,
> >   		.base = 0x45000, .len = 0x320,
> >   		.features = MIXER_QCM2290_MASK,
> >   		.sblk = &sdm845_lm_sblk,
> >   		.pingpong = PINGPONG_1,
> > -		.lm_pair = LM_0,
> >   	}, {
> >   		.name = "lm_2", .id = LM_2,
> >   		.base = 0x46000, .len = 0x320,
> >   		.features = MIXER_QCM2290_MASK,
> >   		.sblk = &sdm845_lm_sblk,
> >   		.pingpong = PINGPONG_2,
> > +		.lm_pair = LM_0,
> >   	},
> >   };
> 
> Have a basic question here. We check the peer only if we will have more than
> one LM needed in the topology but sm6150 does not have 3dmux, so the number
> of LMs will not go beyond one.
> 
> 318 		/* Valid primary mixer found, find matching peers */
> 319 		if (lm_count < reqs->topology.num_lm) {
> 
> It seems like this fix will be unused or does not really matter.
> 
> Downstream has a different implementation for lm_pair, its used even to
> decide the LM pair for CWB mux. Upstream has a simpler implementation of
> just doing that in the code of using ODD LMs for ODD CWB muxes and even LMs
> for even CWB muxes. So fix is okay but not needed.

So which topology is supposed to work with LM_0 / LM_2 pair?

I'd still prefer to land the fix for the sake of catalog having the
correct data.

> 
> > 
> > ---
> > base-commit: a3d570eace66b4016f2692a6f1045742ee70c6b1
> > change-id: 20241216-dpu-fix-sm6150-17f0739f8fe0
> > 
> > Best regards,

-- 
With best wishes
Dmitry

