Return-Path: <linux-kernel+bounces-181487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B258C7CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7781F2195A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B75156F43;
	Thu, 16 May 2024 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lyp2inpZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF06156F28
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885735; cv=none; b=sQXLTPl/vV2x+ipMXSbkYVGbwmX0czpj3KnuCzsCZRG2PdrHQP4iuakXGRooqSwCSKE7aQGQlsIiAtePlGRMj1kv1lS0MDJTxrjThH+ljPMJQCU8eg4yREC+3La7gs4vnJSA8lE/tVFUK8HiwrctqOhzKW7V6jRBmJTedvCCzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885735; c=relaxed/simple;
	bh=/tmkgM7KaC3CGulU3Fzx6rVAfGehu9zopbIqQeteXNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoakE/08tP8errkJDjo1Tttk4PUYV7W/UsspwVRUynkIHdT82LrVfZJzrDq5He7ufrWUf+hedjALOEXAJY9aSs+jdGwkPmvJaOQcbhLGonSWfFrILmSt4L1/rQELEL2AWYzzqCt/2FST6MtL3chQFp3K8+ctLNDYV8kogEIBMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lyp2inpZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715885731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmAY6zq6VIlTkGG6Cuhy+C5anov3S7tUmGwPS9mMo4A=;
	b=Lyp2inpZ4H9uDj9lFmv8qEhAh+N6x0v7aeVUJfXPYAWT61xmNwTueNh/GGDhV28MXgfaN8
	ZEvVY1Da47fxWBZqdXDVj6ja8poi70rQPMTd/fcJTy7XoI90GM05c1S7COr70B4WpifoGG
	PF9D2EOsrZAVrceyPW6GC/Xi8jg/sKY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-RcPkgV6-P4CAWyTJr0YpAg-1; Thu, 16 May 2024 14:55:30 -0400
X-MC-Unique: RcPkgV6-P4CAWyTJr0YpAg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-62079696c58so148030367b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715885730; x=1716490530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmAY6zq6VIlTkGG6Cuhy+C5anov3S7tUmGwPS9mMo4A=;
        b=W5SJ0sfOwsKWpX3qhEOsfAffXVp7bYrcnL7QyS5yTrQdNPihr8xB6eVxog7gkpcaFF
         kYYaltYS3M8iUfi+mC70Zs9cKAaKdEXQ9wp58vs850/x7G6jiSdbEzKlXyKV5J01X99A
         Mpl2OPrhL6fKPV61Lez6tlS0Qgsv5hskhkzPDK8nkmOVdBjReDUdOAA3Q82hCzmtMYFc
         tmQsby7Dqk2Rtq6jPDTz5MAYTYEAEHxm1yqWNNZB6eLfPyAYlkuCtr0di1kwv1CTa7VG
         PoxTKaCUr/4ub46ki6IB6G8rKRyIHlqtlWpmUR1obMdiJipMaeQvHaAIM+CiBgoPVAR+
         yyPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcfW8q5snXbzmxl6vwowHeRU+dc/tXM3ICEZVsJKAh7nZeaSdcjeRo4wtDe9ZzNftNX9IsmV6DAEToVYdo47RPHcldaSSvQy4aftCt
X-Gm-Message-State: AOJu0Yx7rP2U9+LM/RRVXjoiit2f/IaeuJcOBhqHBzAhu7vgeM5ZTk8C
	ElfOIIodkOkx536O5vyDIkNewEikZYqDc9M1bX0lr3xUbVxggjxgNff3Up55B7dnCnfcxr0LqFb
	DsGAcHWW84gX1nWnKTW7IodBHBKE08X4b+RCBtDzdONvvlkjYRhXmCQI3AoCV9Q==
X-Received: by 2002:a81:7255:0:b0:61b:748:55a1 with SMTP id 00721157ae682-622b7fc3cc6mr192057867b3.13.1715885729574;
        Thu, 16 May 2024 11:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8TupsclJxzsHmIxJ4Zn15yFfg0CAESxaQctdScpMnMdlxWZgL6tCJ8+eO1hMiO56rfRpr+A==
X-Received: by 2002:a81:7255:0:b0:61b:748:55a1 with SMTP id 00721157ae682-622b7fc3cc6mr192057767b3.13.1715885729063;
        Thu, 16 May 2024 11:55:29 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e184af783sm58780211cf.17.2024.05.16.11.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 11:55:28 -0700 (PDT)
Date: Thu, 16 May 2024 13:55:26 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Will Deacon <will@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/adreno: De-spaghettify the use of memory barriers
Message-ID: <5vyrmxvkurdstqfiatxfqcqljwyiswda2vpkea27ighb2eqbav@n24yzdykbc23>
References: <20240508-topic-adreno-v1-1-1babd05c119d@linaro.org>
 <20240514183849.6lpyplifero5u35r@hu-akhilpo-hyd.qualcomm.com>
 <ae4a77wt3kc73ejshptldqx6ugzrqguyq7etbbu54y4avhbdlt@qyt4r6gma7ev>
 <20240516145005.gdksmvxp35m45ifh@hu-akhilpo-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516145005.gdksmvxp35m45ifh@hu-akhilpo-hyd.qualcomm.com>

On Thu, May 16, 2024 at 08:20:05PM GMT, Akhil P Oommen wrote:
> On Thu, May 16, 2024 at 08:15:34AM -0500, Andrew Halaney wrote:
> > On Wed, May 15, 2024 at 12:08:49AM GMT, Akhil P Oommen wrote:
> > > On Wed, May 08, 2024 at 07:46:31PM +0200, Konrad Dybcio wrote:
> > > > Memory barriers help ensure instruction ordering, NOT time and order
> > > > of actual write arrival at other observers (e.g. memory-mapped IP).
> > > > On architectures employing weak memory ordering, the latter can be a
> > > > giant pain point, and it has been as part of this driver.
> > > > 
> > > > Moreover, the gpu_/gmu_ accessors already use non-relaxed versions of
> > > > readl/writel, which include r/w (respectively) barriers.
> > > > 
> > > > Replace the barriers with a readback that ensures the previous writes
> > > > have exited the write buffer (as the CPU must flush the write to the
> > > > register it's trying to read back) and subsequently remove the hack
> > > > introduced in commit b77532803d11 ("drm/msm/a6xx: Poll for GBIF unhalt
> > > > status in hw_init").
> > 
> > For what its worth, I've been eyeing (but haven't tested) sending some
> > patches to clean up dsi_phy_write_udelay/ndelay(). There's no ordering
> > guarantee between a writel() and a delay(), so the expected "write then
> > delay" sequence might not be happening.. you need to write, read, delay.
> > 
> > memory-barriers.txt:
> > 
> > 	5. A readX() by a CPU thread from the peripheral will complete before
> > 	   any subsequent delay() loop can begin execution on the same thread.
> > 	   This ensures that two MMIO register writes by the CPU to a peripheral
> > 	   will arrive at least 1us apart if the first write is immediately read
> > 	   back with readX() and udelay(1) is called prior to the second
> > 	   writeX():
> > 
> > 		writel(42, DEVICE_REGISTER_0); // Arrives at the device...
> > 		readl(DEVICE_REGISTER_0);
> > 		udelay(1);
> > 		writel(42, DEVICE_REGISTER_1); // ...at least 1us before this.
> 
> Yes, udelay orders only with readl(). I saw a patch from Will Deacon
> which fixes this for arm64 few years back:
> https://lore.kernel.org/all/1543251228-30001-1-git-send-email-will.deacon@arm.com/T/
> 
> But this is needed only when you write io and do cpuside wait , not when
> you poll io to check status.

Sure, I'm just highlighting the bug in dsi_phy_write_*delay() functions
here, which match the udelay case you mention.

> 
> > 
> > > > 
> > > > Fixes: b77532803d11 ("drm/msm/a6xx: Poll for GBIF unhalt status in hw_init")
> > > > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > ---
> > > >  drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  5 ++---
> > > >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 14 ++++----------
> > > >  2 files changed, 6 insertions(+), 13 deletions(-)
> > > 
> > > I prefer this version compared to the v2. A helper routine is
> > > unnecessary here because:
> > > 1. there are very few scenarios where we have to read back the same
> > > register.
> > > 2. we may accidently readback a write only register.
> > > 
> > > > 
> > > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > > > index 0e3dfd4c2bc8..4135a53b55a7 100644
> > > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > > > @@ -466,9 +466,8 @@ static int a6xx_rpmh_start(struct a6xx_gmu *gmu)
> > > >  	int ret;
> > > >  	u32 val;
> > > >  
> > > > -	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1 << 1);
> > > > -	/* Wait for the register to finish posting */
> > > > -	wmb();
> > > > +	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, BIT(1));
> > > > +	gmu_read(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ);
> > > 
> > > This is unnecessary because we are polling on a register on the same port below. But I think we
> > > can replace "wmb()" above with "mb()" to avoid reordering between read
> > > and write IO instructions.
> > 
> > If I understand correctly, you don't need any memory barrier.
> > writel()/readl()'s are ordered to the same endpoint. That goes for all
> > the reordering/barrier comments mentioned below too.
> > 
> > device-io.rst:
> > 
> >     The read and write functions are defined to be ordered. That is the
> >     compiler is not permitted to reorder the I/O sequence. When the ordering
> >     can be compiler optimised, you can use __readb() and friends to
> >     indicate the relaxed ordering. Use this with care.
> > 
> > memory-barriers.txt:
> > 
> >      (*) readX(), writeX():
> > 
> > 	    The readX() and writeX() MMIO accessors take a pointer to the
> > 	    peripheral being accessed as an __iomem * parameter. For pointers
> > 	    mapped with the default I/O attributes (e.g. those returned by
> > 	    ioremap()), the ordering guarantees are as follows:
> > 
> > 	    1. All readX() and writeX() accesses to the same peripheral are ordered
> > 	       with respect to each other. This ensures that MMIO register accesses
> > 	       by the same CPU thread to a particular device will arrive in program
> > 	       order.
> > 
> 
> In arm64, a writel followed by readl translates to roughly the following
> sequence: dmb_wmb(), __raw_writel(), __raw_readl(), dmb_rmb(). I am not
> sure what is stopping compiler from reordering  __raw_writel() and __raw_readl()
> above? I am assuming iomem cookie is ignored during compilation.

It seems to me that is due to some usage of volatile there in
__raw_writel() etc, but to be honest after reading about volatile and
some threads from gcc mailing lists, I don't have a confident answer :)

> 
> Added Will to this thread if he can throw some light on this.

Hopefully Will can school us.

> 
> -Akhil
> 
> > 
> > > 
> > > >  
> > > >  	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_RSCC_CONTROL_ACK, val,
> > > >  		val & (1 << 1), 100, 10000);
> > > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > > index 973872ad0474..0acbc38b8e70 100644
> > > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > > > @@ -1713,22 +1713,16 @@ static int hw_init(struct msm_gpu *gpu)
> > > >  	}
> > > >  
> > > >  	/* Clear GBIF halt in case GX domain was not collapsed */
> > > > +	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
> > > 
> > > We need a full barrier here to avoid reordering. Also, lets add a
> > > comment about why we are doing this odd looking sequence.
> > > 
> > > > +	gpu_read(gpu, REG_A6XX_GBIF_HALT);
> > > >  	if (adreno_is_a619_holi(adreno_gpu)) {
> > > > -		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
> > > >  		gpu_write(gpu, REG_A6XX_RBBM_GPR0_CNTL, 0);
> > > > -		/* Let's make extra sure that the GPU can access the memory.. */
> > > > -		mb();
> > > 
> > > We need a full barrier here.
> > > 
> > > > +		gpu_read(gpu, REG_A6XX_RBBM_GPR0_CNTL);
> > > >  	} else if (a6xx_has_gbif(adreno_gpu)) {
> > > > -		gpu_write(gpu, REG_A6XX_GBIF_HALT, 0);
> > > >  		gpu_write(gpu, REG_A6XX_RBBM_GBIF_HALT, 0);
> > > > -		/* Let's make extra sure that the GPU can access the memory.. */
> > > > -		mb();
> > > 
> > > We need a full barrier here.
> > > 
> > > > +		gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT);
> > > >  	}
> > > >  
> > > > -	/* Some GPUs are stubborn and take their sweet time to unhalt GBIF! */
> > > > -	if (adreno_is_a7xx(adreno_gpu) && a6xx_has_gbif(adreno_gpu))
> > > > -		spin_until(!gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK));
> > > > -
> > > 
> > > Why is this removed?
> > > 
> > > -Akhil
> > > 
> > > >  	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
> > > >  
> > > >  	if (adreno_is_a619_holi(adreno_gpu))
> > > > 
> > > > ---
> > > > base-commit: 93a39e4766083050ca0ecd6a3548093a3b9eb60c
> > > > change-id: 20240508-topic-adreno-a2d199cd4152
> > > > 
> > > > Best regards,
> > > > -- 
> > > > Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > 
> > > 
> > 
> 


