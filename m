Return-Path: <linux-kernel+bounces-356074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343C8995BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7781F25413
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81612178FF;
	Tue,  8 Oct 2024 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="c3dX1mZS"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16F21500E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728431859; cv=none; b=hWtp36nYhHpCzDaa1kiYJHGoDzvlmZTP1UMi+RrjgN7tzdgjKB9xD1zRJLxBvNF/SaeX6nSCNdzB48YrNyGHVJs86MoPrqPwpqngC/fqPd1/c4aX0IxNfZJrITtRuTS3245aEd/cHcgFknzCourNkgvYbzKjW+IlZKH3LdeU5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728431859; c=relaxed/simple;
	bh=wkYyI+7P7q+nQ2cApyIkUjkv9vU8ISBvNslypndah/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7sLCXYCEC82tjfF6LiQoaDoCB52QJ5cZCp77L67ntBDeM8s6xw6h6OOLVL/baA+NMh8jl9N0E1w5EKcS7AzjSPD0yics6d+eLbfstYlJ2u6ZdbjYtTlfXSnAABV3Fhra+XgJNfpCcb1BXqSPtGe0DM9Fn7sCnFLD3HRbG9J8N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=c3dX1mZS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20bb610be6aso68535565ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728431857; x=1729036657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c19tm1/ulriUOxUtp+1KF6yWn7MZIHQum8iAnB5kETc=;
        b=c3dX1mZSnpvbdCOjOEsSgBmTJsepurG/rwYrK7/SccyPSrFeBbiia31fc2EtnSOkNk
         TrhG/rqBSSiO0Svu4KCCRk19AHj8/ThS+a3CvxoMcWCCPH+GmMiKat+XXKxMwAYLTkyw
         gMUda9Q8FhQDbA+HOL6n6KW9OfCURaHc6HXw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728431857; x=1729036657;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c19tm1/ulriUOxUtp+1KF6yWn7MZIHQum8iAnB5kETc=;
        b=th2MxUasyThdS6rkhbcLhqGGSgyEvn2yysI7PaPRRlnp5gkbfKA3SVCLWnPKo6icWf
         U9optBuQnL3fqyhXUZ2pnKpSLFQOtiZqG+OSN2I7XMst6XqTO7oBzynwCttkxeMfufUp
         XlNS15G5yRbAvNq+4BrMLs5N78cRljoETwjfbBixITveybqYUWoGG75FwRnjtYQJZFGs
         u+4rVV10H0JTjdrcBkABAxclwc+rZtrK0/HhAezcdbfMNZB2LcdP5krd54ojJJAxkGp3
         qhZjmUst8LK8KZpu+7kAvh4jDrxZKxxG7KEx6DtqqPtOX49jFbKdqih247IsQBSs0ydr
         9wAg==
X-Forwarded-Encrypted: i=1; AJvYcCUCL9yFNPZyPy+iBM+1K5SI1j6LAVXLC/plWTkFndJg85gASor2flf8VvTsHMcwY5WcGDJLimccmJNzBnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL2FZC/JmqG+IZaOMeqLpn4DQTGa1tj8q5iju1XosynTEU2yTV
	MTYdcpRnJ5c14Z673F9wjqlhdHvHffELqRv3nDEUzjyvDTkVZmRCVSz4h2kiD5c=
X-Google-Smtp-Source: AGHT+IHbV+0H4iy6eE1X6j0y8uM5f0jWSo+gbKVRrevrMsBPAXhSjBpUky4USCxrKWoquXDaGGeo8g==
X-Received: by 2002:a17:903:2343:b0:20b:937e:ca34 with SMTP id d9443c01a7336-20c63755237mr9889775ad.34.1728431856843;
        Tue, 08 Oct 2024 16:57:36 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1398a767sm60429475ad.273.2024.10.08.16.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 16:57:36 -0700 (PDT)
Date: Tue, 8 Oct 2024 16:57:33 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v4 6/9] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <ZwXG7Un2jF6HVNQ8@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241001235302.57609-1-jdamato@fastly.com>
 <20241001235302.57609-7-jdamato@fastly.com>
 <ZwV3_3K_ID1Va6rT@LQ3V64L9R2>
 <20241008151934.58f124f1@kernel.org>
 <ZwW5md5SlrxBeVCN@LQ3V64L9R2>
 <20241008161919.026488d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008161919.026488d9@kernel.org>

On Tue, Oct 08, 2024 at 04:19:19PM -0700, Jakub Kicinski wrote:
> On Tue, 8 Oct 2024 16:00:41 -0700 Joe Damato wrote:
> > > Make sure you edit the spec, not the output. Looks like there may be 
> > > a problem here (napi-id vs id in the attributes).  
> > 
> > I'm not sure I follow this part, sorry if I'm just missing something
> > here.
> > 
> > I was referring to NETDEV_A_NAPI_DEFER_HARD_IRQS which in RFCv4 is
> > listed as NLA_S32 (in this patch):
> > 
> > static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT + 1] = {
> >      [NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
> >      [NETDEV_A_NAPI_DEFER_HARD_IRQS] = { .type = NLA_S32 },
> > 
> > However, in the yaml spec (patch 2/9):
> > 
> > +      -
> > +        name: defer-hard-irqs
> > +        doc: The number of consecutive empty polls before IRQ deferral ends
> > +             and hardware IRQs are re-enabled.
> > +        type: u32
> > +        checks:
> > +          max: s32-max
> > 
> > So the type is u32 but with a "checks" to match what happens now in
> > sysfs.
> > 
> > That's why I mentioned changing NLA_S32 to NLA_U32.
> > 
> > Am I missing something?
> 
> YNL will generate the correct code for your - the right type
> and the right range validation. Run the command below to see.
> 
> > Not sure what you meant by "napi-id vs id" ?
> 
> I can't apply the series now, but when it was posted the YNL code
> generation failed here complaining about napi-id not existing in
> the attribute set in which it is used. In the napi attribute set
> the NAPI ID is called just "id", not "napi-id".

Ah, I see what you mean now. It should have been obvious, but the
-gen* files are, uh, auto-generated ;)

And yes, I see now that the attribute set names it "id", so I've
fixed it and the command runs clean and I'll include the generated
output this time in the v5.

