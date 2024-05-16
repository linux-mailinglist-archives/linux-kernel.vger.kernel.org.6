Return-Path: <linux-kernel+bounces-181093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F75F8C775C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6486281DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8F1146D60;
	Thu, 16 May 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBrOEsxy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB20143862
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865343; cv=none; b=qmb9lu5SHJHHXUSshbT4H3QC5Y2UJ3Kx6jzxlodZ+6ubmm3JLfghDCmpwo5Gr4TcLftqLZ2ITFBmwsXuzmWHEBFZlieSrM/wgldCeOkSz7H48IoE3P+dlni3FYPZORIDMnhmWkGf+WnHr/3Nae0+ZRk4qejFh7QGBWSPtLPqTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865343; c=relaxed/simple;
	bh=K+T7vqOTQzoe7J10uVXZdg4De+l3xm8mWoBd5YROxc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPt61z99GsMwsmp+3+VQlarM4iWjevP9hj5/YfP+KvPA7E4vyYbbFbmRm+9uBENDmpVZP4h7WsXjvIh7ADngjepg0x5lWlkK0f4E6e+L2A0G7KVzk/89IVGfWIDNsWN8NNxGUV0KRELDk++hxNtK72a5Q7sGoSBsMqRFAszhp0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBrOEsxy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715865340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0l6u6hPd0VabUs35cq4b+ucitv/6ESbFrYjDHjfIiEE=;
	b=XBrOEsxyDLwPit529DjKUfkV91YUdrA5nsBjMJw/jvPLHO5imk/WTDerXT+EC37Wu22k0x
	aPxSJZsPfahBsPvoZ5BvvVv5+dQW19sp+vlzTYcAkfh3u4Oc1UFzGKMLMnxyiT7vDg2CX5
	OEEFn5wODttKazYKaX7yWw5+scz2aek=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-CF3WLzTKPhWdmmYFN0MxVg-1; Thu, 16 May 2024 09:15:38 -0400
X-MC-Unique: CF3WLzTKPhWdmmYFN0MxVg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a097848a56so74898646d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715865338; x=1716470138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l6u6hPd0VabUs35cq4b+ucitv/6ESbFrYjDHjfIiEE=;
        b=ha6Eu0vSF5BCPjNMGVby+dkvipG3fufNDT4LGUbkHnGdkRJHOfPCgpKCBA/e7fNkJF
         sjnPtw/1HMXK1ngWF0SwOGGp8rrpuyf2JZZw9jF4KTa/Ja9ZjRBhItu4ImcVfRBUgCw/
         YoFNr7wI8ZpX33W1QsahZBQnBHCW3TNUN7VIRChr6soH7Pl/FypFQjIAkznZPMuEeuLt
         j0BvCY/3hhRIX5BimSv99IS89dzYxeXdth2ubJV8cMEFQqCZlX4Y2kIuoEpcykHrDJKm
         bWefr7NtW4XXrl1Ws0nkDcr5Z7k8jUcm8QF1hjR4GTncIqPEIsCo6MYLZMXIQp2alpep
         WwrA==
X-Forwarded-Encrypted: i=1; AJvYcCWuytZX6pKpwO1fiWbgxHb92I5F0GvCHsoZrzDv+lmb6XOvoF43Dc5d36AOeBqQSg7XX8GGJUhD5xY9SlX/cRQlUyaTJB0a3xXBSrLf
X-Gm-Message-State: AOJu0YzY8z9F6sPfFwPF+KqL6bRDbRHdAJhttpiQriS40X9NGan1sLdX
	EQr4ZJq/H46D6VlLvSjWuMTLB8HRMe5b2dcWPUmsGk+Mi9YwaYGpkYS1qQDJQtm3b56d3RmXGfQ
	94i/7h5Of+1pbWkPGHRI3EjAsb9MwjWE+1xIEXuQcR/79pbQieOFg1Aes5gnnsg==
X-Received: by 2002:a05:6214:3d8d:b0:6a0:b9bf:3cb3 with SMTP id 6a1803df08f44-6a1681da9a9mr236654736d6.34.1715865337749;
        Thu, 16 May 2024 06:15:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5l63B/ThTFOUu+b8+mZcUqIP+JY7JfnEdLxlBSrypwCMC29xnG1Oe9RFOjzz7TJMZvMGXJg==
X-Received: by 2002:a05:6214:3d8d:b0:6a0:b9bf:3cb3 with SMTP id 6a1803df08f44-6a1681da9a9mr236654376d6.34.1715865337094;
        Thu, 16 May 2024 06:15:37 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1852fdsm75706596d6.32.2024.05.16.06.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 06:15:36 -0700 (PDT)
Date: Thu, 16 May 2024 08:15:34 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/adreno: De-spaghettify the use of memory barriers
Message-ID: <ae4a77wt3kc73ejshptldqx6ugzrqguyq7etbbu54y4avhbdlt@qyt4r6gma7ev>
References: <20240508-topic-adreno-v1-1-1babd05c119d@linaro.org>
 <20240514183849.6lpyplifero5u35r@hu-akhilpo-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514183849.6lpyplifero5u35r@hu-akhilpo-hyd.qualcomm.com>

On Wed, May 15, 2024 at 12:08:49AM GMT, Akhil P Oommen wrote:
> On Wed, May 08, 2024 at 07:46:31PM +0200, Konrad Dybcio wrote:
> > Memory barriers help ensure instruction ordering, NOT time and order
> > of actual write arrival at other observers (e.g. memory-mapped IP).
> > On architectures employing weak memory ordering, the latter can be a
> > giant pain point, and it has been as part of this driver.
> > 
> > Moreover, the gpu_/gmu_ accessors already use non-relaxed versions of
> > readl/writel, which include r/w (respectively) barriers.
> > 
> > Replace the barriers with a readback that ensures the previous writes
> > have exited the write buffer (as the CPU must flush the write to the
> > register it's trying to read back) and subsequently remove the hack
> > introduced in commit b77532803d11 ("drm/msm/a6xx: Poll for GBIF unhalt
> > status in hw_init").

For what its worth, I've been eyeing (but haven't tested) sending some
patches to clean up dsi_phy_write_udelay/ndelay(). There's no ordering
guarantee between a writel() and a delay(), so the expected "write then
delay" sequence might not be happening.. you need to write, read, delay.

memory-barriers.txt:

	5. A readX() by a CPU thread from the peripheral will complete before
	   any subsequent delay() loop can begin execution on the same thread.
	   This ensures that two MMIO register writes by the CPU to a peripheral
	   will arrive at least 1us apart if the first write is immediately read
	   back with readX() and udelay(1) is called prior to the second
	   writeX():

		writel(42, DEVICE_REGISTER_0); // Arrives at the device...
		readl(DEVICE_REGISTER_0);
		udelay(1);
		writel(42, DEVICE_REGISTER_1); // ...at least 1us before this.

> > 
> > Fixes: b77532803d11 ("drm/msm/a6xx: Poll for GBIF unhalt status in hw_init")
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  5 ++---
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 14 ++++----------
> >  2 files changed, 6 insertions(+), 13 deletions(-)
> 
> I prefer this version compared to the v2. A helper routine is
> unnecessary here because:
> 1. there are very few scenarios where we have to read back the same
> register.
> 2. we may accidently readback a write only register.
> 
> > 
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > index 0e3dfd4c2bc8..4135a53b55a7 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > @@ -466,9 +466,8 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
> >  	int ret;
> >  	u32 val;
> >  
> > -	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1 << 1);
> > -	/* Wait for the register to finish posting */
> > -	wmb();
> > +	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
> > +	gmu_read(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ);
> 
> This is unnecessary because we are polling on a register on the same port below. But I think we
> can replace "wmb()" above with "mb()" to avoid reordering between read
> and write IO instructions.

If I understand correctly, you don't need any memory barrier.
writel()/readl()'s are ordered to the same endpoint. That goes for all
the reordering/barrier comments mentioned below too.

device-io.rst:

    The read and write functions are defined to be ordered. That is the
    compiler is not permitted to reorder the I/O sequence. When the ordering
    can be compiler optimised, you can use __readb() and friends to
    indicate the relaxed ordering. Use this with care.

memory-barriers.txt:

     (*) readX(), writeX():

	    The readX() and writeX() MMIO accessors take a pointer to the
	    peripheral being accessed as an __iomem * parameter. For pointers
	    mapped with the default I/O attributes (e.g. those returned by
	    ioremap()), the ordering guarantees are as follows:

	    1. All readX() and writeX() accesses to the same peripheral are ordered
	       with respect to each other. This ensures that MMIO register accesses
	       by the same CPU thread to a particular device will arrive in program
	       order.


> 
> >  
> >  	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
> >  		val & (1 << 1), 100, 10000);
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > index 973872ad0474..0acbc38b8e70 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -1713,22 +1713,16 @@ static int hw_init(struct msm_gpu *gpu)
> >  	}
> >  
> >  	/* Clear GBIF halt in case GX domain was not collapsed */
> > +	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
> 
> We need a full barrier here to avoid reordering. Also, lets add a
> comment about why we are doing this odd looking sequence.
> 
> > +	gpu_read(gpu, REG_A6XX_GBIF_HALT);
> >  	if (adreno_is_a619_holi(adreno_gpu)) {
> > -		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
> >  		gpu_write(gpu, REG_A6XX_RBBM_GPR0_CNTL, 0);
> > -		/* Let's make extra sure that the GPU can access the memory.. */
> > -		mb();
> 
> We need a full barrier here.
> 
> > +		gpu_read(gpu, REG_A6XX_RBBM_GPR0_CNTL);
> >  	} else if (a6xx_has_gbif(adreno_gpu)) {
> > -		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
> >  		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
> > -		/* Let's make extra sure that the GPU can access the memory.. */
> > -		mb();
> 
> We need a full barrier here.
> 
> > +		gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT);
> >  	}
> >  
> > -	/* Some GPUs are stubborn and take their sweet time to unhalt GBIF! */
> > -	if (adreno_is_a7xx(adreno_gpu) && a6xx_has_gbif(adreno_gpu))
> > -		spin_until(!gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK));
> > -
> 
> Why is this removed?
> 
> -Akhil
> 
> >  	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
> >  
> >  	if (adreno_is_a619_holi(adreno_gpu))
> > 
> > ---
> > base-commit: 93a39e4766083050ca0ecd6a3548093a3b9eb60c
> > change-id: 20240508-topic-adreno-a2d199cd4152
> > 
> > Best regards,
> > -- 
> > Konrad Dybcio <konrad.dybcio@linaro.org>
> > 
> 


