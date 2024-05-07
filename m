Return-Path: <linux-kernel+bounces-171795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C57E8BE8CF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3226528285F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186516C444;
	Tue,  7 May 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gb6zl6WF"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0D51649C8
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099147; cv=none; b=fON6rX9i1DQqT2xmXEmlHb/w3MaYX4N/rhIeuTbhMctI6SXu5DcNAK6oY2aWYK7MRpEoLUUiHzi4HMc+VCGbqLvUWLBxcvOK4JfQgDabZnAso1485lEE8LiimxPOQ7tq/37rC4QY425y45UUxxYkF6R2l0o/fXxcUoWP45SJzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099147; c=relaxed/simple;
	bh=O4KOfR7xsWkA69yvh0fmrqzX+jfoibH/wxjze2sjgyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN4WVZKAmDARpGTUNU/CsynpJwZCIzgnwTaTp2Q5knXZAXCa2cLAmweDNzBvjq4fbnfiLf0Dgl2auCVzt81HLj5/sxQSuSZLYn5FJ1bBKfP08pcj/TTJTJY8frCTeVGLOKol8HcS0jTZ/CBE0mn61mekw6WcPi7VcR76IMakV18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gb6zl6WF; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7928c5cb63fso240931785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715099144; x=1715703944; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4A1sFCToC52p1ydCgtQ7NIaPSTbzbS+T5dDjpm7wNJk=;
        b=gb6zl6WFbKNAFcmkvfzgpgxl0XKO9pE+VR9a36+DZIObMUXNKHsMJ8ZOgODpNEg3Ns
         fVchQss9SV4d84JleEtoY75aVZuYtcwa+Un1iUD99R75aykvZtu9MMeRmpf/P7WtyUqR
         /pLq8e0HzWAYP9bpp2LKYKv5KkQGpO3oExb3GtkM/h0QRVjVaTqydGDWvchO7zmC17hM
         Y741JNAwW5ka/s2laXd4e4DOKa7dNLeQdo3DmVHec+79Hq0iJlDGntHw6vu1GNqZ9Okm
         PXgoMVNR9ipmJxXX38urwYGYTa7/lzgUhzEfM7z6sFEHBAnS6bVjz5AnrnjZtMne/7ec
         rC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099144; x=1715703944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4A1sFCToC52p1ydCgtQ7NIaPSTbzbS+T5dDjpm7wNJk=;
        b=b3YS+MQHMTywjXoGR7mFIlqKHp5sxgjBzpSe3EtJWSZe5PoSkwJ8tQ0+8hfd9OZze6
         XSm8EtynTn+vPOhmtq5VkCewaIA28WBaSpLQjvngTsAQu/gy0arehOtAOUHELwE+IzX1
         6DkT/2uRbMqMOCUTlFFoZZv90WdSWsP5pVBqFXhLTMc+UtH54yWIt4FOyv8V71mfnNAT
         02loTk7JnossrgZyoqQ607jAtTMdxiDV2F1Zyr2H4tTm6mpBZyijuXAvYBbG8Nt15GjI
         12ecyrpt+5cYLft5xyq/ib82N80EQtwYPFb0aQu26/4VfUHF1dX1/q/+H9boQKK5gvCk
         7hpA==
X-Forwarded-Encrypted: i=1; AJvYcCX6j1zVgC4fs0xFj3qHwSClVb/lhYAtrqLfAAsrY+MkQNFVHR6YeDbwY8K98LYPsrhC8NfjazLjQZUGAUn5q8eXDVgZtECx72CfRe1w
X-Gm-Message-State: AOJu0YzdgP7NQ37fMDK4pBdWQb/2HtlOmvYer4IChKx/Myz/A2bCaQYG
	szQpDr/7Z/RB/+aGWF8la5EzOr1HhE0bVEeDhvFxVI2rSx7JH/K2TAYx3xvGtdc=
X-Google-Smtp-Source: AGHT+IHR3MbTAXPGdjRNf/QL+MFD2IJBEm9Y6V3orFfaoZDzq3rR0+g0I0blT1MsQ9Ixtyj6g+KxiA==
X-Received: by 2002:a05:620a:e85:b0:790:9e84:9b75 with SMTP id af79cd13be357-792b247fbdcmr40342785a.12.1715099143771;
        Tue, 07 May 2024 09:25:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id vr25-20020a05620a55b900b0079291bf9505sm2963899qkn.41.2024.05.07.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:25:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4NdO-0001Rh-8Y;
	Tue, 07 May 2024 13:25:42 -0300
Date: Tue, 7 May 2024 13:25:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC RESEND 3/6] iommu/riscv: support GSCID
Message-ID: <20240507162542.GB4718@ziepe.ca>
References: <20240507142600.23844-1-zong.li@sifive.com>
 <20240507142600.23844-4-zong.li@sifive.com>
 <20240507151516.GK901876@ziepe.ca>
 <CANXhq0qLbC2RgW04C5DcuzR-kSmT3hA9rWW=w3e3PKHr+QsyzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0qLbC2RgW04C5DcuzR-kSmT3hA9rWW=w3e3PKHr+QsyzQ@mail.gmail.com>

On Tue, May 07, 2024 at 11:52:15PM +0800, Zong Li wrote:
> On Tue, May 7, 2024 at 11:15 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, May 07, 2024 at 10:25:57PM +0800, Zong Li wrote:
> > > @@ -919,29 +924,43 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
> > >       rcu_read_lock();
> > >
> > >       prev = NULL;
> > > -     list_for_each_entry_rcu(bond, &domain->bonds, list) {
> > > -             iommu = dev_to_iommu(bond->dev);
> > >
> > > -             /*
> > > -              * IOTLB invalidation request can be safely omitted if already sent
> > > -              * to the IOMMU for the same PSCID, and with domain->bonds list
> > > -              * arranged based on the device's IOMMU, it's sufficient to check
> > > -              * last device the invalidation was sent to.
> > > -              */
> > > -             if (iommu == prev)
> > > -                     continue;
> > > -
> > > -             riscv_iommu_cmd_inval_vma(&cmd);
> > > -             riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
> > > -             if (len && len >= RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
> > > -                     for (iova = start; iova < end; iova += PAGE_SIZE) {
> > > -                             riscv_iommu_cmd_inval_set_addr(&cmd, iova);
> > > +     /*
> > > +      * Host domain needs to flush entries in stage-2 for MSI mapping.
> > > +      * However, device is bound to s1 domain instead of s2 domain.
> > > +      * We need to flush mapping without looping devices of s2 domain
> > > +      */
> > > +     if (domain->gscid) {
> > > +             riscv_iommu_cmd_inval_gvma(&cmd);
> > > +             riscv_iommu_cmd_inval_set_gscid(&cmd, domain->gscid);
> > > +             riscv_iommu_cmd_send(iommu, &cmd, 0);
> > > +             riscv_iommu_cmd_iofence(&cmd);
> > > +             riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEOUT);
> >
> > Is iommu null here? Where did it come from?
> >
> > This looks wrong too. The "bonds" list is sort of misnamed, it is
> > really a list of invalidation instructions. If you need a special
> > invalidation instruction for this case then you should allocate a
> > memory and add it to the bond list when the attach is done.
> >
> > Invalidation should simply iterate over the bond list and do the
> > instructions it contains, always.
> 
> I messed up this piece of code while cleaning it. I will fix it in the
> next version. However, after your tips, it seems to me that we should
> allocate a new bond entry in the s2 domain's list. 

Yes, when the nest is attached the S2's bond should get a GSCID
invalidation instruction and the S1's bond should get no invalidation
instruction. Bond is better understood as "paging domain invalidation
instructions".

(also if you follow this advice, then again, I don't see why the idr
allocators are global)

You have to make a decision on the user invalidation flow, and some of
that depends on what you plan to do for ATS invalidation.

It is OK to make the nested domain locked to a single iommu, enforced
at attach time, but don't use the bond list to do it.

For single iommu you'd just de-virtualize the PSCID and the ATS vRID
and stuff the commands into the single iommu. But this shouldn't
interact with the bond. The bond list is about invalidation
instructions for the paging domain. Just loosely store the owning
instace in the nesting domain struct.

Also please be careful that you don't advertise ATS support to the
guest before the kernel driver understands how to support it. You
should probably put a note to that effect in the uapi struct for the
get info patch.

Jason

