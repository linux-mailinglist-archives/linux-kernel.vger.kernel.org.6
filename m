Return-Path: <linux-kernel+bounces-358706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD989982A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5318F281B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AA51BC9E3;
	Thu, 10 Oct 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zcm1tPcF"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A857B1BC074
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553398; cv=none; b=tQLQKbgzxxZH/6WLXKI98ffLKEjMtUXjfIC3Ap3NZsZ69sPhv6yknzinD3J+18RvR+RrhPv0I2ufB5Rur5p30LrMCH+vAj8P/otl/mi+JAR24NGRhYJ25LzeWkFVwNBuLQdOaOCdKtNkVDo7cA807U6gLp7WdBiwXufMV/IKuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553398; c=relaxed/simple;
	bh=elWr+mwVd6CkzzyfYaNrNJXReGKDX69I0EyQe95hjNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8pivyfEy/SqyY3OITJMOaMrnFI7lTL1ui96qenF+Dd5MocogaXz3f0+eCCPiyNdZIhldI/fX1l3S+BDrd3q4ciDsrIMm2YjvcqwXo6CxfBtz2ggl+g61J+BbElsYaiLdGaeRXp9WK+G4LiZpF1sC/njAg7DWbDfkancQGnYzlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zcm1tPcF; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e2e3e4f65dso7643067b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728553395; x=1729158195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1CATrtMWn6F5QT6eZk/r0oyiPtlYTjTAFuFuazZn49I=;
        b=zcm1tPcFhNbPRyjBETgidGqkgeU7dCb5xHc6ETN8hr6cN3tNy+rNNNDhpFLAJowRJf
         FgvpjxPFPce7Q9WNpevKPyjMVK2eLDqVG32PvS4yP/m88BykYddjkeu1hdYlzXawf2tl
         jiemOa9AtdfX+edncu0HrHRUeFby6vYIe8OoGoCHvhyxqtM204cGehpGYQIEJcBrnKJc
         z4tk5XxCPPIzHLz7jboFPcXwF2HENDmL7eJq+wWHyw7H22BpdurQC03M1J3dhU00tic2
         y7Yfq8zbO8TRq3KLC87aGMoJqSV7DrS10iM5HpcOgjN+UQanelmGurvUBeZDW/2gQ+M+
         q+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728553395; x=1729158195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CATrtMWn6F5QT6eZk/r0oyiPtlYTjTAFuFuazZn49I=;
        b=WkGwDcljLHlj6rx2U1kccFb9gj62cQbm/1a8paw3fiMDmvbRdb9YNeahWZOPhdPZsW
         4Th1/HH1XJScfkvPLEcPd+zcskGN8XCis7fPbmSTDbKWwDunm9hHSuFCM1Sy6TnkQ/WM
         ON8sreVCoAHFiE1Ywxt1q80EBT/nFQ4QO756lK4+i+ZRtM0xy3nDKJGFUcv6yb1SPGje
         gYTyEWirYbXxxvPZpxCinvSB1thnXE8fS0mw+O7VuQPUncT17Vp6Z+cFxcbBQjnPYjis
         ZFSJDHCT8+X2NnghGCuDe7gzVfNk3hZifBkzmnZrfYzBoArucoQRZxXWDvH9k0yWRC1i
         jSpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9UGECZqaYqVPiFugajkGCxadh8Exa097+mVVCy92h3OrPBNyYITToxL6vmUDWU9g5TO2DPXiQfNrXbN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/8Vrufe3waJuE5Re8w9mKLPz854A0G9W+l64UMR15XJEtXGyF
	7fUSG/SMZJu2F7VGS+ju0WyoZPWujOhopZTIRl1GKJ301LwA3Vw7otKUBV5BTXu4JFqypHhCjOj
	Q3S7zZit9ZGwJrbmLoaXLqUfz28+STfHdiMuqfw==
X-Google-Smtp-Source: AGHT+IGQsfLmiQXBMuj7PPXTmXpl+pQHwqsX8qRdNSbosQyMcl6gJbMDDqLIOVBG7FvEH8rByhIg4jNfV7DhdN8whp8=
X-Received: by 2002:a05:690c:6507:b0:6dc:c105:6d84 with SMTP id
 00721157ae682-6e3221d4ec1mr58123967b3.12.1728553395610; Thu, 10 Oct 2024
 02:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-merge3d-fix-v1-1-0d0b6f5c244e@quicinc.com>
In-Reply-To: <20241009-merge3d-fix-v1-1-0d0b6f5c244e@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 10 Oct 2024 12:43:04 +0300
Message-ID: <CAA8EJprWLOX+TcByO_UFx77HxBX2Gi5y5QComvdRb_Jcyyv_pA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: don't always program merge_3d block
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, quic_abhinavk@quicinc.com, 
	Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 06:46, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
> Only program the merge_3d block for the video phys encoder when the 3d
> blend mode is not NONE

Please describe why, not what.

>
> Fixes: 3e79527a33a8 ("drm/msm/dpu: enable merge_3d support on sm8150/sm8250")
> Suggested-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> index ba8878d21cf0e1945a393cca806cb64f03b16640..c5e27eeaff0423a69fad98122ffef7e041fbc68e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> @@ -302,7 +302,7 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
>         intf_cfg.stream_sel = 0; /* Don't care value for video mode */
>         intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
>         intf_cfg.dsc = dpu_encoder_helper_get_dsc(phys_enc);
> -       if (phys_enc->hw_pp->merge_3d)
> +       if (intf_cfg.mode_3d && phys_enc->hw_pp->merge_3d)
>                 intf_cfg.merge_3d = phys_enc->hw_pp->merge_3d->idx;
>
>         spin_lock_irqsave(phys_enc->enc_spinlock, lock_flags);
>
> ---
> base-commit: a20a91fb1bfac5d05ec5bcf9afe0c9363f6c8c93
> change-id: 20240828-merge3d-fix-1a8d005e3277
>
> Best regards,
> --
> Jessica Zhang <quic_jesszhan@quicinc.com>
>


-- 
With best wishes
Dmitry

