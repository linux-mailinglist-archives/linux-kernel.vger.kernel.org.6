Return-Path: <linux-kernel+bounces-337779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7673F984ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D94A1F23125
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F7C146D78;
	Tue, 24 Sep 2024 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgPI6o6o"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC1F1C32
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727219856; cv=none; b=glSFQHDdSWECkU+YQ6jH1plgxjX+Ag7jRsIQFbM7FVu3pr/CVvIPiWNEBPxLcjg13KPZqjDDPzXUrec1XwnHQaS9wvTSx+U5Pk4aJtK9agyxkI45meAWayGekRmLc4K0FA7De5Wx/iJwvNxoxwkKfFsvHKI2DPNFiWaB9IMpeYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727219856; c=relaxed/simple;
	bh=G63j1DY8HlwU4Tu1xMylD5RZKaHo6qN0VNLoEGsZKfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tovsgZkB549GC3qItX4t34wpo62SWo5pGACzk7S2EZFERLxD9s5SfnI+NHXeqRYQmPse5J8XH/AjWkL9NI7t1a8XytePDDu9t9BVqfFSHqZz45SAonMGQuHAwfhPCMQix8MYuHdIxxCu1BrmmmDgu6EubSzNjLMu2PFdEDHVITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GgPI6o6o; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f6580c2bbfso2961141fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727219853; x=1727824653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kbz0tfiyQQErgbHsvyLtv8eq56ZM6ZrFXgSGtiFWYMA=;
        b=GgPI6o6o555ZHP0gu7H1gPxejg204q6xkrLJ/NpVs3WsLfCNr00+Iseyn6fMItjLlq
         0guTLWyFIt+OFdJh5S8hfiDhJQH0Js9bnVm6Wn1AReOITmBFLUc+nGiXJnN6IL5SDGei
         x49z5TlHmDbq8ZteoOyfciIBC9R5YbDGJTK0V5b/1XpNCDebCdNj5tW4btLGcnYWUtmx
         NS4qmI1D2m77v1N7Vx4q5okWCCO4CLTecBvDymSMkgpJ7FK/epuUEGriF5jZYfCWOgjL
         PSVY7KTSC9ZpAhTH4Mxb7K6WcSVqtrlcfL0HuIXJB9CKiML4r32o4oTSOTOgLGFNftzi
         SoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727219853; x=1727824653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kbz0tfiyQQErgbHsvyLtv8eq56ZM6ZrFXgSGtiFWYMA=;
        b=EDPAcDV+AtngKMoD7mlAq03YeSsPmGD6vYMFfkALGkJag0EvlCsZps5MvMI6JSrEX6
         tS1wfh0cyHrTrjcGUL87s2Ad2Z0/5Xl6Rc8ByfdoYWaEd8DKI3Xw/6/+x2rp31LsUxRW
         aTZxgH75aUWyJ2X1F4g2lnnQGO3LeDrl5BloOsz33mR0wm2aCkC2T8UOj9AE3UvIBax3
         GbCCvweqSi89sexKzLtxKXEBZ9EERr2kex6UEHSFf81EHK6xYD8fKgAuoHP3m6sWPtPe
         Img16R3Mh1XBv0I5weTnEMC0NmkRABKzy1gzGv0aIocHmqG/bVMg6Z/4evm9ra3Fzb3u
         qGuw==
X-Forwarded-Encrypted: i=1; AJvYcCUc7WOC/FY15nNHDHtgEdann2CPrq38NMWjnAWSi6rDywVrqzZWMBxl/YimtOX2ofpDwFcPh8nEXKDLMFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgFHozvkJr7UmTlzZm66NPgScMAmPd3SSbeVmwFyeLtFAGJKEL
	9xy53aTrBYqcVmJGKBlH6giEtusKIqaFbqZV8jtuCLLVNFZ5LDsyAqFHbJYXrA8=
X-Google-Smtp-Source: AGHT+IEsDQBs1xHo+RHBnCa4F/NIYf+HbT4i9F6SK/oR1mhFSOVGTHMoA9OotkQDZtlvONDTI/XaLA==
X-Received: by 2002:a2e:f11:0:b0:2f3:f1cf:5314 with SMTP id 38308e7fff4ca-2f94d763343mr2025561fa.10.1727219852780;
        Tue, 24 Sep 2024 16:17:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d289ef2dsm3436881fa.124.2024.09.24.16.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:17:31 -0700 (PDT)
Date: Wed, 25 Sep 2024 02:17:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 08/22] drm/msm/dpu: Specify dedicated CWB pingpong
 blocks
Message-ID: <l5lfx7psxi3xmkgu3woea55txan4ib7kmvaix3h5b7q3fz43nl@r7umftxolsgq>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-8-7849f900e863@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924-concurrent-wb-v2-8-7849f900e863@quicinc.com>

On Tue, Sep 24, 2024 at 03:59:24PM GMT, Jessica Zhang wrote:
> Change pingpong index and names to distinguish between general use
> pingpong blocks and pingpong blocks dedicated for concurrent writeback
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_10_0_sm8650.h  | 8 ++++----
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h   | 4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h   | 4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h | 4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h              | 8 ++++----
>  5 files changed, 14 insertions(+), 14 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

