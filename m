Return-Path: <linux-kernel+bounces-234730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B720791C9E0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA781F22FB6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9649BEC7;
	Sat, 29 Jun 2024 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SRF5M711"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4C964C
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623506; cv=none; b=Ju3rgORCx92YgZjFNQkTxw1HL0UPaJJ8J39NkjjqGt1aghKG1ds8oGcr6HolvckFJC87nrfLB/cP0z4s4JVZ9DGBRAyiszJ+9Hk2ukYxzR8Iy8Sh2MtpJMBl7UzeO4wg3/RIhK3b3DI5o+rUxjODWY6NdWTPCJoHJBsfEKAkHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623506; c=relaxed/simple;
	bh=0pwjsTBXu5vUAsTUcdG/YYnH05yQf7NBN6ieRkQ1bpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMt2A3uCMnOMy0VMRQp2fMiZrDwu547uc8UglVIP4wnDCKu1XnipGE3oVS925dwemfX2fmHRofl9w0C98qn54QyEX1/qIgiteyqli/WGxyrM6rjMSSehTQpkL3d2mgPYITFmb0jcUkscpWCGNsTPSTtHEbg2rX3Cf1YlrjO0gcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SRF5M711; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-702052976f7so47263a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623504; x=1720228304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=18khvwf4h1DwFim0s+8NOwCXvsGKrMBWRxVL6/hqfpk=;
        b=SRF5M7117L8nXrIaEpeqix5jZnjE1mR/WMLzqbUi3icy7/S2CIMD8VAZmFJBRmEfuP
         igp2Ly9i/U+f1Rz8/gkXUlScasv2UkmzrmmnCYN24n9EWo3SPzsBk/vgFKOHgT7dQYmG
         NKvUEvzxMAOGs1pxuyBkjRH+00K+UDQ2vCth4AMmvo5JUQ3hMkJZTPnWfUv/BY7jkKS2
         m1boHJfq5fg3FAAvb68+YXNavrEWk0kdCoArVTquAf6MJEuZg+YIP+hS15I+bp1sNWob
         jIZGmCZkyE0hhJZYRvUkGh+xajFGGMy8woEJg6K/cbnLjrkFlQPRRSTMkCW4vA+1NdRp
         CFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623504; x=1720228304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18khvwf4h1DwFim0s+8NOwCXvsGKrMBWRxVL6/hqfpk=;
        b=qZA1Wyy1TG4wZf/qps02U2mkbHgovvMDCKfYMh0ansrTV09EHR8XYmdZCFrGpuTS8F
         JJGvSB5U+8xvWh24W6Tn5+GSdKPIvcpKyWcxh/DPUx9mDbFPWau5Knny3fC2HKPOkVKk
         f0k8sj2DaCkSqMESxzjoNbb+7VCon5ZWwUJd/V2v72BuBr1T3YJel+K8MRTPupjMd/MO
         pq9VY13l4KVlZlugKOKif2ib50qofiLA2NxKFAiG+pfhwot1nCDuOc0WbrbgDI3ssLf6
         OlDEFei2nBIDlTf1bXNdlClRSl0EkRIv8QDjUtTUPTYk6XELoM5flj8LEt7G2lifIRWE
         ohbg==
X-Forwarded-Encrypted: i=1; AJvYcCVtayI9h8ly9P18lNkZgWM6HcudiKgXia8E2BPg/D39MP01Yiov71UAj+l6Wlhj40gOcjE8nbXEgIH0jpWDKv9xV67p5sUsKImbJ5qX
X-Gm-Message-State: AOJu0YwmTxCnbCpM9wV9tAd13otYJsrHpD82ybSy3vO/4FZDZvzMUWmt
	Si5mW/a95NWV3d4Hf1V0CoUDKX0TyfX5uxXisFcUjLoCPQxxsk1nICNhaAAinDw=
X-Google-Smtp-Source: AGHT+IGyyW5KndiFNz+epN7jJRTXH3ZBYGRiXtHZ+r8Fe0tboO3Y2/PcZ2TNfI9i03f3ztbYgwYyLg==
X-Received: by 2002:a05:6870:3294:b0:24f:cd06:c811 with SMTP id 586e51a60fabf-25d06eddeebmr18624565fac.54.1719623504024;
        Fri, 28 Jun 2024 18:11:44 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:43 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNK8e-0004rF-Jn;
	Fri, 28 Jun 2024 19:32:16 -0300
Date: Fri, 28 Jun 2024 19:32:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 07/10] iommu/riscv: support nested iommu for
 creating domains owned by userspace
Message-ID: <Zn858MB9/t1qltV2@ziepe.ca>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-8-zong.li@sifive.com>
 <20240619160211.GO1091770@ziepe.ca>
 <CANXhq0qqrU8xbTecFOcRNLqm2=DbTYsN2YBX5K_O1ha530bu_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0qqrU8xbTecFOcRNLqm2=DbTYsN2YBX5K_O1ha530bu_A@mail.gmail.com>

On Fri, Jun 28, 2024 at 05:03:41PM +0800, Zong Li wrote:
> > > +
> > > +             if (!dc.fsc || dc.iohgatp) {
> > > +                     dev_dbg(dev, "Wrong page table from user data\n");
> > > +                     if (copy_to_user(event_user, &event, event_len))
> > > +                             return -EFAULT;
> > > +             }
> > > +
> > > +             /* Save DC of stage-1 from user data */
> > > +             memcpy(&info->dc_user,
> > > +                    riscv_iommu_get_dc(iommu, fwspec->ids[i]),
> >
> > This does not seem right, the fwspec shouldn't be part of domain
> > allocation, even arguably for nesting. The nesting domain should
> > represent the user_dc only. Any customization of kernel controlled bits
> > should be done during attach only, nor do I really understand why this
> > is looping over all the fwspecs but only memcpying the last one..
> >
> 
> The fwspec is used to get the value of current dc, because we want to
> also back up the address of second stage table (i.e. iohgatp), The
> reason is that this value will be cleaned when device is attached to
> the blocking domain, before the device attaches to s1 domain, we can't
> get the original value of iohgatp anymore when attach device to s1
> domain.

This is wrong, you get the value of iohgatp from the S2 domain the
nest knows directly. You must never make assumptions about domain
attach order or rely on the current value of the HW tables to
construct any attachment.

Follow the design like ARM has now where the value of the device table
entry is computed wholly from scratch using only the contents of the
domain pointer, including combining the S1 and S2 domain information.

And then you need to refactor and use the programmer I wrote for ARM
to be able to do the correct hitless transitions without a V=0
step. It is not too hard but will clean this all up.

> > > +/**
> > > + * struct iommu_hwpt_riscv_iommu - RISCV IOMMU stage-1 device context table
> > > + *                                 info (IOMMU_HWPT_TYPE_RISCV_IOMMU)
> > > + * @dc_len: Length of device context
> > > + * @dc_uptr: User pointer to the address of device context
> > > + * @event_len: Length of an event record
> > > + * @out_event_uptr: User pointer to the address of event record
> > > + */
> > > +struct iommu_hwpt_riscv_iommu {
> > > +     __aligned_u64 dc_len;
> > > +     __aligned_u64 dc_uptr;
> >
> > Do we really want this to be a pointer? ARM just inlined it in the
> > struct, why not do that?
> >
> > > +     __aligned_u64 event_len;
> > > +     __aligned_u64 out_event_uptr;
> > > +};
> >
> > Similar here too, why not just inline the response memory?
> 
> I think we can just inline them, just like what we do in the
> 'iommu_hwpt_riscv_iommu_invalidate'. does I understand correctly?

Yeah I think so

Jason

