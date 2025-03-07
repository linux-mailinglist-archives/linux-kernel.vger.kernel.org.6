Return-Path: <linux-kernel+bounces-550409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D938DA55F0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58263B3510
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F7F1632D7;
	Fri,  7 Mar 2025 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vbWXsk3L"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6316DDC1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741319891; cv=none; b=H21tKXrSmRXQEBR+fP60Pk6NljkgMDDO1CJNtxjwaSyU4EyU/IssJksIsWjFBtyaKnR8+/3j4EIp9ssiS175zHNCsJepjPIXIYkqIhjX77WUA1NkKEN9IJvc4DE+Yw2bpBOZSsyw1l//JkA+HrzOQX90JpEIF34Ar/hyU3jLVNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741319891; c=relaxed/simple;
	bh=+RleQoGymkd13ThubWy655TdvbAZQ4Bn5KStcAnaXtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5xvGfgnHFPCovjN6MC+cn+RopLd/wjL3KDQEbcnGHsyao2wKn5Q0hVRgwilBEYqKkloOM2mzClNDnowBZoZMe45Va52c4DtQWO5DkRE1R1vmFEhOKI4QKckNvKSV8b2Klul9P3+fPme1QB/sB9xLISDfWTiz4qWuxkiyWJmxtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vbWXsk3L; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-548430564d9so1535101e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 19:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741319887; x=1741924687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uEBF7q7djaNS5nAjrGOiMY9ClFLfelskzs9woxu33aM=;
        b=vbWXsk3LTvM0FnxEWn/MsaIbrXxUMO6qDLDkuIEeQ5/vJYyHdXiF9+6ER+HYVUKPn5
         jJIeaGKze6dXFmqHaJ60iQeh4g9IpJNxvr7H+cBAHI3E8CVEXJIJjMyJS5IwrOKvnzLH
         vp16w+DJnN5E1TW1m9NGrJI1unJO3XKPGI+ca2afi8Q4GckliAKQIkQJGGJv4wK0wKhZ
         XFnz1iDZpD+OHrSsEIK8i2H77UVR96JBFkU27bVSGpSsSo/07TXvqUD4sIi9t6mfMfXW
         kU+pwy6xLldu//HPdKLi/EGsztE1H35NECk4vTaToYJr4QxmCPqe2xlNKkFi6JD/nRP8
         kOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741319887; x=1741924687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEBF7q7djaNS5nAjrGOiMY9ClFLfelskzs9woxu33aM=;
        b=uqOaFhTpMtR+diSNMDvGG8E6KrJ+py0FpKTwCC9sAVMZrff0RHMgEo7F8ohjkdEAzf
         TgToEcJHCz4rsY0XUxORZEvYa7T9t5lM8uNhDr72FC3oQWaa7WdIlntr45C6XVkJeczR
         2waBo+gzGjVE5+onJ5wi+LqxMSFsfx7jnoV/iWBHeQeu4Q7RlbDIMcLYJtwXGDrigUkA
         AoaJHpGx0MTsZSwnd0vqN23Ys04PD8dMHgXzOHIls2ZDFNNmBcJ6ONdmrGPSbeIyMK6f
         5Rh9coZzgsrDB1wxQAa35i1B2IsRK1wWXsq1QO8OfP9UNQXLxNFX+h2EA/0ntRbTErso
         9W8g==
X-Forwarded-Encrypted: i=1; AJvYcCVxnDSddcveAfwhsA+I27eeCd44grAsNZVfILpzbb4K3ofyEQ4WDYlRt9r3IyJP/91oMtpJXQygQSwK5Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0J/IQ9aeJA8t79Pdk3zTDb+1pS1AAfvYClxwgX8CPxvkjGla
	3gDHlLAh8raEXxqSMQOOESzk1A6sXduN2qpEB9j4Yhwj2N1NEPEPh3sfjBij4ls=
X-Gm-Gg: ASbGncunasBUtW0Ehk7OoA+O2dicJZd8GsQTYVwa994hmVWAdKdgFKGuQOa0EBAAN0q
	iKd4Bhb0NBr/fc4AkCDpcCBwUnrIR2Ew45KrnfDk8d7uoaPNufmOz15Q9rPjt7qcWUOBtuunyPS
	rlW522Z32qfsWcZ5FokvIZ3CqqJvAWIHtlXtfKOB9cifWUrfvFtFxhfkOaAjIFq8iWfJkgM2UtE
	37qgtwXkkj7vNTICg5fqnT9UgpR7L11wGZCOyBo62Q3sgYt7Ns0KzeYzUYRpbyVRX0CLOkD8Z8a
	Y8zi10rkXH6SU9bCLssEEw+3Q+0OwaU4EcNiziPqKAFtIIn0sKU3WI+gVqlesse+yEHkeRT4xtC
	SfT0aGjGeICSM9D/PZgQK4KwY
X-Google-Smtp-Source: AGHT+IGOFCkKLZ1UQh2TRUPs+Eu6QCFBBW9AoVDPv1C752stT+7E5xh4IuWYrNCXRm/wPrkUfsK6hg==
X-Received: by 2002:a05:6512:118a:b0:549:6759:3982 with SMTP id 2adb3069b0e04-54990eac875mr558887e87.37.1741319887522;
        Thu, 06 Mar 2025 19:58:07 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bd0absm365580e87.157.2025.03.06.19.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:58:06 -0800 (PST)
Date: Fri, 7 Mar 2025 05:58:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Adjust CDM_MUX to support CWB PINGPONG
Message-ID: <7wqtrfc24j7irouintg3h3fh337maziqjxcxcvxuvltdohqc7c@ai6zm6tidqgo>
References: <20250305-cdm-cwb-mux-fix-v1-1-16148ca6e4d2@quicinc.com>
 <vjufkcrkungrwy7w4pxzsac57ilzk2dt3eeypzy6pna2z5ocxg@uf237ixu6kqq>
 <b125d75f-eb71-469b-808e-3078f2f7e266@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b125d75f-eb71-469b-808e-3078f2f7e266@quicinc.com>

On Thu, Mar 06, 2025 at 11:33:46AM -0800, Abhinav Kumar wrote:
> 
> 
> On 3/5/2025 10:44 PM, Dmitry Baryshkov wrote:
> > On Wed, Mar 05, 2025 at 07:16:51PM -0800, Jessica Zhang wrote:
> > > Similar to WB_MUX, CDM_MUX also needs to be adjusted to support
> > > dedicated CWB PINGPONGs
> > > 
> > > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > > ---
> > >   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
> > > index ae1534c49ae0..3f88c3641d4a 100644
> > > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
> > > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_cdm.c
> > > @@ -214,7 +214,9 @@ static void dpu_hw_cdm_bind_pingpong_blk(struct dpu_hw_cdm *ctx, const enum dpu_
> > >   	mux_cfg = DPU_REG_READ(c, CDM_MUX);
> > >   	mux_cfg &= ~0xf;
> > > -	if (pp)
> > > +	if (pp >= PINGPONG_CWB_0)
> > > +		mux_cfg |= 0xd;
> > 
> > Shouldn't it be 0xb for PINGPONG_CWB_2 and 3?
> > 
> 
> No, this register CDM_MUX can take only 0xd for CWB PPs.
> 
> 0xb is not listed as a valid value at all.

Thanks for the confirmation.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> > > +	else if (pp)
> > >   		mux_cfg |= (pp - PINGPONG_0) & 0x7;
> > >   	else
> > >   		mux_cfg |= 0xf;
> > > 
> > > ---
> > > base-commit: 6d3175a72cc07e90f81fb35841048a8a9b5134cb
> > > change-id: 20250305-cdm-cwb-mux-fix-69ed5297d4f7
> > > 
> > > Best regards,
> > > -- 
> > > Jessica Zhang <quic_jesszhan@quicinc.com>
> > > 
> > 
> 

-- 
With best wishes
Dmitry

