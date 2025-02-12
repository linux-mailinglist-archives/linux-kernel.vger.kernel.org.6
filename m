Return-Path: <linux-kernel+bounces-510249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BED9A31A41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2011883111
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FD629A1;
	Wed, 12 Feb 2025 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tS4P5P3r"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891604A05
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319246; cv=none; b=X9ivDJSfL0e2+nwG3B8Fb87IDAtf1YOv6ZbuJzDYsyQmUbFhJZVlqOHwxsD6YiyAM/GJBXx4XY8TvJXyvfu/hXdmmeo5hQZg2VKxcrIDCw4KjbdxPEMe5lPSM+mclnx7A3eTKkg4AvcQrGgqll12LYH5TVtBFbHGyB9X84ODr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319246; c=relaxed/simple;
	bh=h2Pmuf7NB5Asy0O/Q6i3f+ho5B9g1fnPw+zYjgxb/uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7SIfk/SyBU3dUfiB33AtRx5EPaF0uWuH8oqY8eYSBEy8v2jPhEVq+kSE3VSYUoHzkVuuHZIch5nq0jCBcjLfr16fcAPjQQERND/6pyGsVLr+4oSUy5O4BcngPGkVX4lIiDs79T0sc0uQvuWVEMXChr/ByiH2v5Lp9miSNSjKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tS4P5P3r; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5450475df18so4062957e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739319242; x=1739924042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MoiH9kTaTXxwiGqw7nJMhKvn68BG/QNvASYw2+68Zak=;
        b=tS4P5P3rQnSm/Xhdpym4TQp09/07MTM+CJ1TnDdxK3nPCdwkz/cJfrjeMguMc2B41I
         k40ttzkdqax8XVRqRH6/dZ3ePMyXAdZ50QILT3NhYjVkI/HFxvNrCLkk4UoYTQ9UQTsD
         UmpKTHJvlpP7whQS+uOm7wp9E700Txe+evIRd+oHbMvnDZXO5PS5xJH2j5a0YBKI0F1V
         VKhVFxKZbFhXa8PLl54v8RnMDdR7Kr60+vFP5DkOGmmh41ET4z4IdbMSZjArLeTtCGOj
         550U8cmFvL7emalLruUOv5LT8/8VqlC63o2PywjnczVIhRvYRXIb/l/S+P3n6Bf/6zWt
         TbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319242; x=1739924042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoiH9kTaTXxwiGqw7nJMhKvn68BG/QNvASYw2+68Zak=;
        b=hCZZVyBuVvmF72AXjzImlQ5Cqvt+fHBRfLk0ffteUtYOd9byDw7muIbFTwhzx+dOCI
         R3uO6lJLnN9x2vcAFudrI0eyPEz1FxRRitFYLdLShd8givBwBNCJjJfCrYdWS+7at9cY
         w30lzkPYT2wqAcV6c8ClNC3ulXA4yUg7UHD3S/CadUiNbIMuXoUpR3LIYyoyYkeaobbI
         xq3jJ7gyCL2tQJu1mc5kdmt0/TI0xREMaBh7qToHVFMRtWKlXmlLZk11G2Xbjsv747o8
         F35BKT5Oh+HVGWAzJsoOYt08PVn36jNkNTZ72KFELM3Ljoamorq8HBKxuZCwTJ/i5czL
         Z71g==
X-Forwarded-Encrypted: i=1; AJvYcCXG+QF9zzjZcZ5ClqLGQq0lfBDOR2ay//JgJQfEQbWqSNFCYzsDdk2akNTnRhhs2XMORf+gPNAkvI6wBqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZrdDRZQeGyrMTu3hsGRNgm5SXmYdhcl3KK8Y4bmI/zWOQFYgZ
	7SaL59TV/Pc/AsPu726SnO3jcXaDjwBMpCZjuEMp1YTPIEo3q7N6VIa+pl7IHlMxZL1YY2YWd7+
	fxyQ=
X-Gm-Gg: ASbGncvLbjnqy1ZjB96jW1O68iSkK5Oct9zcOk5sUqyK19s5ehJL59mfCrB2aUTqb3O
	5y6MO4B+abVUu/zArOGw6LsoI0hANUPVUozVNqIpT69dL2n9esPg2ZZGpSHNP5hf+MfUawCrQgO
	/REoccsPjnCHlpv1VQ7OeK4C6B9OUH2GCiBAgCQE8cp+i5mxZCLY6CTY7iIlbvu1DSk2ZVyndc/
	s8w+REgI6qM6srDzdyAg2JGlsEXQ24lohLwLrEGdAAIhB9QSuXXjqA/EKi1gw/F88yHVin1kCL8
	3o51mPHYHRaio7i6CK5qsGCheiF5FATzPlEw0vu5cnsptU1moopkTGbCtZerN4DpZ8ev5EI=
X-Google-Smtp-Source: AGHT+IH4K/97rcyNCdtxvfzfnC07ftBx9dEMBnJK66j+zVmsXTMBTzg8TyBPDt/3qMe65yIbgIUqGQ==
X-Received: by 2002:a05:6512:3e07:b0:545:76e:319 with SMTP id 2adb3069b0e04-545180e5dc7mr263463e87.4.1739319242534;
        Tue, 11 Feb 2025 16:14:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450cf9b64bsm742565e87.9.2025.02.11.16.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:14:01 -0800 (PST)
Date: Wed, 12 Feb 2025 02:13:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Ethan Carter Edwards <ethan@ethancedwards.com>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: Fix uninitialized variable
Message-ID: <nllxmdfk4wwm2bbrg5jc4tt7la65rwqdtt4tqjp36j6dr4hgmx@ukszi5llldup>
References: <20250209-dpu-v2-1-114dfd4ebefd@ethancedwards.com>
 <8e40c1bf-6da7-46b1-925c-53d1fa25f3ce@quicinc.com>
 <zj7sqsg3ruev4akl5paedsg65qyh53iddqvssrye2pjtfofs3q@u4g3kevpl2jn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zj7sqsg3ruev4akl5paedsg65qyh53iddqvssrye2pjtfofs3q@u4g3kevpl2jn>

On Tue, Feb 11, 2025 at 10:23:54AM +0100, Marijn Suijten wrote:
> On 2025-02-10 14:14:14, Abhinav Kumar wrote:
> > 
> > 
> > On 2/9/2025 7:51 PM, Ethan Carter Edwards wrote:
> > > There is a possibility for an uninitialized *ret* variable to be
> > > returned in some code paths.
> > > 
> > > Fix this by initializing *ret* to 0.
> > > 
> > > Addresses-Coverity-ID: 1642546 ("Uninitialized scalar variable")
> > > Fixes: 774bcfb731765d ("drm/msm/dpu: add support for virtual planes")
> > > Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> > > ---
> > > Changes in v2:
> > > - Return explicit 0 when no error occurs
> > > - Add hardening mailing lists
> > > - Link to v1: https://lore.kernel.org/r/20250209-dpu-v1-1-0db666884f70@ethancedwards.com
> > > ---
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 7 +++----
> > >   1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > 
> > Thanks for your patch, this was addressed with
> > 
> > https://patchwork.freedesktop.org/patch/631567/ but since this is better 
> > I am fine with this, will pick this one up
> 
> The `return 0;` in this patch should certainly fix this issue entirely and we
> don't need to inline the `int ret` for that, which I think is against mixed
> declaration rules anyway?
> 
> As far as I understand that's what Dmitry suggested in v1, but he r-b'd it in
> this form.  Dmitry, was that intended?

I think it should be fine, if the gcc doesn't warn against it.

> 
> - Marijn
> 
> > Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > 
> > 
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > > index 098abc2c0003cde90ce6219c97ee18fa055a92a5..af3e541f60c303eb5212524e877129359b5ca98c 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> > > @@ -1164,7 +1164,6 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
> > >   			       unsigned int num_planes)
> > >   {
> > >   	unsigned int i;
> > > -	int ret;
> > >   
> > >   	for (i = 0; i < num_planes; i++) {
> > >   		struct drm_plane_state *plane_state = states[i];
> > > @@ -1173,13 +1172,13 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
> > >   		    !plane_state->visible)
> > >   			continue;
> > >   
> > > -		ret = dpu_plane_virtual_assign_resources(crtc, global_state,
> > > +		int ret = dpu_plane_virtual_assign_resources(crtc, global_state,
> > >   							 state, plane_state);
> > >   		if (ret)
> > > -			break;
> > > +			return ret;
> > >   	}
> > >   
> > > -	return ret;
> > > +	return 0;
> > >   }
> > >   
> > >   static void dpu_plane_flush_csc(struct dpu_plane *pdpu, struct dpu_sw_pipe *pipe)
> > > 
> > > ---
> > > base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> > > change-id: 20250209-dpu-c3fac78fc617
> > > 
> > > Best regards,
> > 

-- 
With best wishes
Dmitry

