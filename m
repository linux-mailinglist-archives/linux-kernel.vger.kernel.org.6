Return-Path: <linux-kernel+bounces-441035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC739EC876
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D1E282B68
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157B02210D9;
	Wed, 11 Dec 2024 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdy1xN+b"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3F2210C0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908131; cv=none; b=o5tz04IuuSpjbYId/4PjITNHMQyiO027DLYNg0pnhNvAdp5ybKXCNqflXgavJHXnfqIMYYVeT3EUNWFPJlg0Ucexdb6LNR7deTCOuR2aLsmsuVNFAQx5eg4FvbAiKCtuJlCm3gFp1+QR5auCgnaeksuR3yLdyee4hpVbolTyd44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908131; c=relaxed/simple;
	bh=/LIgJnzCbqzJuTqbvSMCFhlSCDOqqbcZpQ7MPJ4mhdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDbwv1taqKg2zYBhxwab1zL5KCpQ9qXyS1WWFLEQaELpO1SU0/xvBkEJn2LVRzUah3YZrCDpeEyMo3CbYgzKD4NXh+IyB9vPfKIVHITVQkCOvYnIyF94W4NOnasOJaINeCqfp1lUkEjGpLZqHxXr4gYQcj7JgPiiip1Up4QkNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fdy1xN+b; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361f664af5so2571225e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733908128; x=1734512928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vEtBjFWv0oJ9eIaHpJrX0BFB+4qp8phO4ofGzRE0Nw=;
        b=fdy1xN+bGV4jtA9pu0Ud3SNvpXAzDudKrRRYlqzfLCVFXhcrzBK+As9/u9gexAMjpS
         JtEXtsvWjZPfWzhdjLELVisLIxQnQUjU5xQTQUlrPWjefpaJfwrdDVrlGiPf74pgBOEW
         p5lhNPngzsD5BY4m+1uFTTPfhsx3+VQB3wWPJlMrNaHnWxytvnkkWUHCvvlvUnUOmOly
         ImfcNl5ee98uc1WMghMQeMr4Ig8tYNFtkoNErADC7+cOVmVPRm3PXBw22jJv0dCtoERu
         cEHBdVVULbh7WfEwmR0aH3Ed6rZ7703mqDz82AIHtBd/zbO/z1xpr6zr35gBPziRWcnS
         pcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908128; x=1734512928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vEtBjFWv0oJ9eIaHpJrX0BFB+4qp8phO4ofGzRE0Nw=;
        b=RvG4uAy1N3sE+4tkap2g8pM7Xup6+ow0O0MxhYT3uHN3oWPyLF13t78V8GnFwaYOPO
         aVgfSfO2X58etIeEzhdpMIOlrlYNlvAOBJ+kH0IiYFVUCO+igIehe/QdfuSBeARVgygZ
         SQwhYb25yye88D2j6W+Bs8UBSjnwBgSxlciCaFlSMvYKFqaldTMVVxonk390YeFOZUfc
         SpSNM7lt9+CQo1J85GHjpEuAvVzttQQScPf258tUz+Scbj2CikphNRyI4ULaxQf+nLQ2
         JCelzoJpHU4ZpNUx2+99wWMB2AcnmT0gErlX/QS3LCwFA0vYzmRk5bwH7MK0lmhYBrZY
         LOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3uvsvprCZrI7o+3jRwHvfu5xfIGuJS1I1yIjOuX5qbdyGwczE9pI/s3+/6B+tO4T11IveFsQf9InsLrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg5taq00USv/oQije8TtZfDP0UOSkEN6rGIyjq5Xe7FPcxP0Ie
	zz9EMk39negMBt+rD3IMi9yanc1yBZlKa7fkOTCFL/nvFWxH3n0n9kCYaW7iN8Q=
X-Gm-Gg: ASbGncvrto1R6W4tPmUp7XgBYxhg4oaXOsP6E2kjoSQMQcPKndIqWnJq07kFGgv6aa7
	KSJYDfbDQy5hT4LjgIa88SIHdgB2oaRvRcsJJt3K81k8ZnPZSINXQjh/nX7I1gB2Y3ahh4wyxgZ
	NDBq2IcG/wtroYOGbDlTS1j99NIjQb3sn2DUJL1L06bEYiN1LnPqOc+Dl69JVbkxtkfUKFWEA2D
	3JkSZb8eZx2dV4OyjWZlAiN0x4tJbOXczEjnwgPfbrazTbD2qci
X-Google-Smtp-Source: AGHT+IGD0J/JRFizsjyOq9cq12J2ujkcAmyNKzRhsrMcAI97nrwbSWWcCwaN8qi6JkWUTmtl0C7NHQ==
X-Received: by 2002:a5d:64cf:0:b0:385:ec8d:8ca9 with SMTP id ffacd0b85a97d-3864cec5b76mr1446900f8f.42.1733908127884;
        Wed, 11 Dec 2024 01:08:47 -0800 (PST)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4815sm807610f8f.26.2024.12.11.01.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:08:47 -0800 (PST)
Date: Wed, 11 Dec 2024 11:08:45 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 2/4] drm/nouveau/dp: Use the generic helper to
 control LTTPR transparent mode
Message-ID: <Z1lWnY+TxSptkBiY@linaro.org>
References: <20241031-drm-dp-msm-add-lttpr-transparent-mode-set-v1-0-cafbb9855f40@linaro.org>
 <20241031-drm-dp-msm-add-lttpr-transparent-mode-set-v1-2-cafbb9855f40@linaro.org>
 <hh26gzyjhygphlrmhh2zkskoz7vezkgdepbx7fnzgfch75simf@hmr5ezp4khwi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hh26gzyjhygphlrmhh2zkskoz7vezkgdepbx7fnzgfch75simf@hmr5ezp4khwi>

On 24-10-31 18:44:55, Dmitry Baryshkov wrote:
> On Thu, Oct 31, 2024 at 05:12:46PM +0200, Abel Vesa wrote:
> > LTTPRs operating modes are defined by the DisplayPort standard and the
> > generic framework now provides a helper to switch between them.
> > So use the drm generic helper instead as it makes the code a bit cleaner.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_dp.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
> > index bcda0105160f1450df855281e0d932606a5095dd..80264e6186246903fa037861fe37493646de0c6e 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> > @@ -80,15 +80,12 @@ nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
> >  		int nr = drm_dp_lttpr_count(outp->dp.lttpr.caps);
> >  
> >  		if (nr) {
> > -			drm_dp_dpcd_writeb(aux, DP_PHY_REPEATER_MODE,
> > -						DP_PHY_REPEATER_MODE_TRANSPARENT);
> > +			drm_dp_lttpr_set_transparent_mode(aux, true);
> >  
> >  			if (nr > 0) {
> > -				ret = drm_dp_dpcd_writeb(aux, DP_PHY_REPEATER_MODE,
> > -							      DP_PHY_REPEATER_MODE_NON_TRANSPARENT);
> > +				ret = drm_dp_lttpr_set_transparent_mode(aux, false);
> >  				if (ret != 1) {
> > -					drm_dp_dpcd_writeb(aux, DP_PHY_REPEATER_MODE,
> > -								DP_PHY_REPEATER_MODE_TRANSPARENT);
> > +					drm_dp_lttpr_set_transparent_mode(aux, true);
> >  				} else {
> >  					outp->dp.lttpr.nr = nr;
> >  				}
> 
> Could you please extract this true-false-true dance to a new helper too?
> This way Intel driver can use the simple helper, the rest of the drivers
> can benefit having the common code.

Will be part of the new version.

> 
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry

