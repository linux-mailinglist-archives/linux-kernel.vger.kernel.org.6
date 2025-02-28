Return-Path: <linux-kernel+bounces-537635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39106A48E70
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5264A7A4BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2687F347B4;
	Fri, 28 Feb 2025 02:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CV5G+uwU"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07092E628
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709097; cv=none; b=VQEr52trZ9dCNitS3DHG8QqaJFQvyQovJki5ojieyYhhBDoncP40Lpb5zt+jvM0U2JTOgOEdkns8/bp85lqesOKHZBh/8lIcKHNthCxWCqQxQIzp5oc+yHIgBRDBcEtTOwBwN5Kow44gw0WwTxud86tgvtemUZhtJPA8SdLY6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709097; c=relaxed/simple;
	bh=9I2BO1z48IQWxNX0txc+oqBikBJBOzio/TgbiFEkiPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/NmSDmTQwZWFDPAwJcs2G8xkJj4nAbXyYQerJ6Psq2owpdDU+YPnMAt2/HLgM5624l9I0WDT0l3Vxh3GwXYB9GXJx1NZx59W7Hu78YWpEkm6xMNiz2HVdFGly22+Ah3bE9/eVjgJaCEFXpia21lnWWd0rEVRTnMmgtCYG/MSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CV5G+uwU; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2b1a9cbfc8dso491058fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740709095; x=1741313895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9I2BO1z48IQWxNX0txc+oqBikBJBOzio/TgbiFEkiPI=;
        b=CV5G+uwUfST9AYOMQ1JoxkzaT3P7gPlwVQr3PtaoOckIA+5nKEUhCGH0JupvHzxS/C
         VbQ1wggslQH14efRB+157LUEDR8wGRUk9o23gwvppCpTo6KZY16HhmNH3kC6QhVl47Pp
         ELyWx0/GwAMt0O2ZyektOIm7ByvmziXs2nfPxZAeBB8wRRHUIfltUM4EVlA1AlIKkM50
         vhe3Vp/Ey86bBjSkRhZGdOgJ2w6lwd+LeGcPQ6DOo+wbMCFOQUxXDIdTmBbCG9JWd6aW
         aopDe7GcRbhq2puNphZOVfOrOedaPC+2/QkP+kMJ8TX18gb4osgmQnQV74rprWHbJXHt
         +w8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740709095; x=1741313895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9I2BO1z48IQWxNX0txc+oqBikBJBOzio/TgbiFEkiPI=;
        b=aSMyDbLd1KY6lY0x/uHr9p5tSLMeT1xR8gkR0SQAVjVdSCWqYul6uPEOQMKBnYqqbX
         OeUVpfzGgX5iCF8wFCu1BT/NSzdEv8jizDUn6ONx+2L/XQobfpXBUQN5CPz3v4bPJKMj
         jI8lqXfODbA0Ixf1boWiAe+64miMtB1vuuirSFAgRN/qornwtw1l4iIPvqBvRoaRIYV9
         gUgtnGkLeEvmX/BQ9DZs6EC4APNVKxpoFswCDLfaxAYZONlZkvXNnAkKuc+TTKW43+JB
         xSM35+MQyrFiUjXkXmCpNq3PX6aXFMQ9HDF91o61mn3ve6ZRpFW+0yXDbu5EmVJASRNK
         dXuA==
X-Forwarded-Encrypted: i=1; AJvYcCWf1HOB9JkR42hLH+bg/cp0CZsQEwEHFTmWFPHWEE8ZXcFPAc8hVuoX42QCx79U9nXvmUrBUSYKqdDXtnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK3dqXDNEKjsU4ERRfrBiYLd7H0jd+841H4twj3kZKe+35moMt
	riiNL+bm5ChXZTvE6kHoV431PKlNMHwmC8LKcQB7Qt8n/N7eaHhr6eh+eyv7kexxCEJECnPwBbU
	ygyGz96v7+kRV7SlBwmlSHbyOy2pr5qCMpVXGaw==
X-Gm-Gg: ASbGncuUL2/rhysVctNUID4HzpWaYZSlb87cfciANVmcD3KRWcDkr8cQdbs2kE+MrbL
	PM09mOV77Hl2CM3PWf7mSbGlzPcPq6u+chZMKX3CNitl+h/jgkvnObVS9NLzsfVp6VGSgSDsPpF
	fSrK6qGDGZQIGFNpmwUxW6
X-Google-Smtp-Source: AGHT+IFT/QnwoDQvtYuT7m4lvtyEAzFxYBM3HOFpWcJkIVa+DG02d0v1yu8bwqEDMtcanFsHk2vuA7kNme21ha5fMks=
X-Received: by 2002:a05:6870:793:b0:29e:2caf:8cc with SMTP id
 586e51a60fabf-2c1787befc0mr744505fac.37.1740709094796; Thu, 27 Feb 2025
 18:18:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com> <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca> <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
 <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com> <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>
 <20250226130423.GF5011@ziepe.ca> <f29818dc-a0a7-46c4-b541-1b469a6b3304@gmail.com>
 <20250227203855.GI5011@ziepe.ca> <7bafd132-6a82-4313-b25f-92fc16faf917@gmail.com>
In-Reply-To: <7bafd132-6a82-4313-b25f-92fc16faf917@gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 28 Feb 2025 10:18:03 +0800
X-Gm-Features: AQ5f1JpaPQbUQXoxOSSLzPZKwS5b9QorWs5Qrw6FpWVvDUtkbOCPSMcOEeJSFoQ
Message-ID: <CAEEQ3w=1H7o7G56hYmwEGErfuFX-2nG=wesJYL7p0dDqLv_rpw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Ethan Zhao <haifeng.zhao@linux.intel.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, dwmw2@infradead.org, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

On Fri, Feb 28, 2025 at 8:51=E2=80=AFAM Ethan Zhao <etzhao1900@gmail.com> w=
rote:
>
>
> On 2/28/2025 4:38 AM, Jason Gunthorpe wrote:
> > On Thu, Feb 27, 2025 at 08:40:31AM +0800, Ethan Zhao wrote:
> >> On 2/26/2025 9:04 PM, Jason Gunthorpe wrote:
> >>> On Wed, Feb 26, 2025 at 01:55:28PM +0800, Ethan Zhao wrote:
> >>>>> Provided the system does not respond to those events when this func=
tion
> >>>>> is called, it's fine to remove the lock.
> >>>> I agree.
> >>> I think it is running the destruction of the iommu far too late in th=
e
> >>> process. IMHO it should be done after all the drivers have been
> >>> shutdown, before the CPUs go single threaded.
> >> Hmm... so far it is fine, the iommu_shutdown only has a little work to
> >> do, disable the translation, the PMR disabling is just backward compat=
ible,
> >> was deprecated already. if we move it to one position where all CPUs a=
re
> >> cycling, we don't know what kind of user-land tasks left there (i.e. r=
eboot -f
> >> case), it would be hard to full-fill the requirement of Intel VT-d, no=
 ongoing
> >> transaction there on hardware when issue the translation disabling com=
mand.
> > There is no guarentee device dma is halted anyhow at this point either.
>
> The -f option to reboot command, suggests data corruption possibility.alt=
hough
>
> the IOMMU strives not to cross the transaction boundaries of its address
> translation.
>
> over all, we should make the reboot -f function works. not to hang
> there. meanwhile
>
> it doesn't break anything else so far.

patch v1:
if (!down_write_trylock(&dmar_global_lock))
return;

 patch v3:
/* All other CPUs were brought down, hotplug interrupts were disabled,
no lock and RCU checking needed anymore*/
list_for_each_entry(drhd, &dmar_drhd_units, list) {
iommu =3D drhd->iommu;
/* Disable PMRs explicitly here. */
iommu_disable_protect_mem_regions(iommu);
iommu_disable_translation(iommu);
}

Since we can remove down_write/up_write, it indicates that during the
IOMMU shutdown process, we are not particularly concerned about
whether others are accessing the critical section. Therefore, it can
be understood that Patch v1 can successfully acquire the lock and
proceed with subsequent operations. From this perspective, Patch v1 is
reasonable and can prevent situations where there is an actual owner
of dmar_global_lock, even though it does not perform a real IOMMU
shutdown.

However, if the IOMMU shutdown truly fails, IOMMU_WAIT_OP will trigger
a panic(). Removing down_write/up_write offers better maintainability
than Patch v1 (as we can retrieve the cause from the vmcore). But this
might not be significant, since the reboot could have been completed
successfully, and the occurrence of panic() might instead cause
confusion.

In summary, it is essential to complete the reboot action here rather
than causing the system to hang. So, which do you prefer, v1 or v3?


>
> Thanks,
>
> Ethan
>
> >
> > Jason

Thanks,
Yunhui

