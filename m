Return-Path: <linux-kernel+bounces-522423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66A6A3CA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82CD18898FA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2323F295;
	Wed, 19 Feb 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3Vs6FZ2"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C711F8BA5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997727; cv=none; b=BThgc46+mElVi4dVD3/vfhwgDv3LGkVCZ0qrzzaTK6W7sc3XQRoJA8qB444PFun6zIOITeHTbLCUg37na9ZY6RlPOY2XXLkHKNr8cDfje600qE/7I6hUHPU2Lx/OD6Yjhi+jECji4d+cQCrnHmtcVv5/2zySP9SViEDvzLgK55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997727; c=relaxed/simple;
	bh=oGFH9gjtels+xMBADqC9C7inQemNOF9SL3MjxANpjE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1V8BKDDYjvvmRspGdb32kHBtgEjQGKRZvnvyBnPtUmGDnltXDbuYmxruUEz00oiFvxIvYx2Fyd+8CA686RH8AuYOxuEFTwmC0GorS5nY6XeG1Yi9U5EBskUdoVgl01XHtIyNEPYv6GtnS15c/5GLpiggYM0pe1/T5QYukUhguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f3Vs6FZ2; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5461a485aa2so231023e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739997724; x=1740602524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWfn2QE048JAogGjdO/HN/1zhXyyFXLbFj0VStJXPXI=;
        b=f3Vs6FZ2vzfyF2Z/DD550YgLJ0lt4e8cPYloO33PkLD8ZDwwin4ytiWUexmHNbeudl
         KMspWXpAsEsDOfwnkBFKjqsPMhrkNS7IiimgeR8BU6LCQXjXdgA9JTBOOnGmIwNWLD2t
         DUKT/GG84e/5Qgmsa4wK+XRqoJNREezaide4XVR1FKxbABJxu+8lUGxhSh5w5+24diRe
         +zHAlAE/FzRwakTZaGm4Dk4hzIz49zpFmADwSCY6Fd1hHCGv77NLrzCLyjOJmhrWYgZa
         cmHNk+tRdEGlykqTjAxm5TaAFI/yS8LfpHTyLhghi8iBWgXFKnwNex9Ary3Gb7hNZgE2
         kjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997724; x=1740602524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWfn2QE048JAogGjdO/HN/1zhXyyFXLbFj0VStJXPXI=;
        b=ZzNGV969EAJHBYHHVVziWZGFWMJhAgnHUnbvyi0M6bHGr+TnPZRBMY4Gjh7XbfwYzn
         gU+Ric4u1A8KV05yM6/BpWZJH6KLH1KWe12UFQ0Y+ZKASVg7GWH9zqJt3tH0iCYekGXX
         NPeYUCtVazO81Ce9z5d4t1Ti2R42tHNRNjkRjzT8KYqtV1WAhco79VXUPJJ+svlFGEGy
         sWc0iWGffUq/S3gmEHmpIRnapniWIr6N5VbNN/GXNmWBNmNxL6jSWLNWjAFtpZmKE4JD
         X4trNNcCGa8eZQW/DQJagX0nGftYxPYx4wT3Yrv7d1zXeFJpgl3/U0+JqjEkQV3qbM1i
         vHNw==
X-Forwarded-Encrypted: i=1; AJvYcCV1RRJeH3Mu3Cj9J/CFPeCKg3Jnrn2pQ/tA+VkRCHvSw1NcbisWZuKnJsdJ7PppsjAItw3NBXbhEx835cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmXb2VQB9dQzgkdGwm5LSgOXtkZLGLD56gEzOPfdjjRmG01g17
	aGwBOmuDYWFzlav0T5OGm+0bcoBr4Y5lGrNlxbOdPAHqNKUAuhotKYgDJ9ukuZI=
X-Gm-Gg: ASbGnctdpL7VWkV/zbTMhBRhxAgz/aLzQUOOCFVaNXlx7GLei7BdJSkgNBVaLiJdjgm
	KG1yfcoFeTkk1ZcJUzqWZylRQx/A9IzuqOFA3m9SInZdyNcO7DHcmH7oEYjexLJM4u6VeyzZLwQ
	1VVkexYTHw36BPG7+bBxAy5NW0iHnqY0lJBissjOdjoDTwd/pFmdA6uKevoRvfbYTn4IKXihQsB
	2iBxO6Vx54DefpXEtleuMlQir3q7wL46EVliRBo2ZgrYGi4kr4r7CXcX906CqvBomcDv35wl62V
	Dx8zMSh1ABU5aH8kpyNsEZoSMGOy6FuQdffJubYeDQaPNHfIjJ86brtWmhWypPjoS0Jp6Xs=
X-Google-Smtp-Source: AGHT+IGXMalRxphojh9Kz/mE/PFLZuuLeouSpCzsm5nqbBL2KU5Od7qqkelGjB8u41IdiGOmFC8W3A==
X-Received: by 2002:a05:6512:e94:b0:545:d54:2ec6 with SMTP id 2adb3069b0e04-5462eedb519mr1875009e87.2.1739997723749;
        Wed, 19 Feb 2025 12:42:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452871ead0sm1907991e87.193.2025.02.19.12.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:42:02 -0800 (PST)
Date: Wed, 19 Feb 2025 22:41:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] drm/msm/dpu: rate limit snapshot capture for mmu
 faults
Message-ID: <h5i5wegkurgmujrkx35qpyjmkbjv3z4re53dx5i4ly4ghzpek6@hgsdbmfmgxe3>
References: <20250219-abhinavk-smmu-fault-handler-v3-0-aa3f0bf4434a@quicinc.com>
 <20250219-abhinavk-smmu-fault-handler-v3-5-aa3f0bf4434a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-abhinavk-smmu-fault-handler-v3-5-aa3f0bf4434a@quicinc.com>

On Wed, Feb 19, 2025 at 11:49:21AM -0800, Jessica Zhang wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> There is no recovery mechanism in place yet to recover from mmu
> faults for DPU. We can only prevent the faults by making sure there
> is no misconfiguration.
> 
> Rate-limit the snapshot capture for mmu faults to once per
> msm_atomic_commit_tail() as that should be sufficient to capture
> the snapshot for debugging otherwise there will be a lot of DPU
> snapshots getting captured for the same fault which is redundant
> and also might affect capturing even one snapshot accurately.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
> Changes in v3:
> - Clear fault_snapshot_capture before calling prepare_commit() (Dmitry)
> - Make fault_snapshot_capture an atomic variable (Dmitry, Abhinav)
> ---
>  drivers/gpu/drm/msm/msm_atomic.c | 2 ++
>  drivers/gpu/drm/msm/msm_kms.c    | 5 ++++-
>  drivers/gpu/drm/msm/msm_kms.h    | 3 +++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

