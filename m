Return-Path: <linux-kernel+bounces-182415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0858C8B05
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C70A1C20ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F913DDC1;
	Fri, 17 May 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JtFMb3r/"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0813DDA0
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967053; cv=none; b=srvHz3CXWhzOGXTQVJDlDH5mkF3dKAPOt7wQLzGD7dL0DMEsG7dlqnFwQ7GsqgrOO2ChhO2Vy41Gc9/JdzvXCTBxtoqXvTxe/keASnycMdi6ucJ2eSxXud3BQT4QxIoKJMV83JYL5kxryLKlLGkuU6Bse2Y73rz9qEhMZy1MTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967053; c=relaxed/simple;
	bh=c2QtSZdCkA5RFZOYVJWDhlgUfVfylInXYEoMha5QZYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogwQTLM9Uc2r0WzEAUXaiCuXtiMKezi39lDmH/eL1HTnmlG9zEQurRtD59UHtofmab+b6Tr5/gVql3S+IyMuVwyzdzJHah198KkV1bcYMpBaCXnovTpNyAxltW5fgD87XZyg2CS3mjHwiQV2NvIu970BMVRo54+ww9yaivvI9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JtFMb3r/; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6a0ffaa079dso7411976d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715967050; x=1716571850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4G1AoFSIpqiKBdHTLG/UG3KtMvn8GSyLhR2c4jHS3UM=;
        b=JtFMb3r/IWgBydXEXsMo+KkL09GnZn6UTWU4leMB/1jYSI76vDBnTTWzsvcwis1qYA
         BX5TrmI+9X7OTa8s6Q8pfSCNUqVLsavwh+kdLO7rv3l36QUPMvR5c0ytfnkJ7KiAbRkF
         AHMy56JBvJ4K/AeV8JeXKewXcCpBE1x+DrDqmQNwrUwhUbE4RUR9WauZ6G7LcbSjD/SR
         b4ULMu8KZdnvidq88tzyjoMqTu8wo8ONiHpFsrhb/HE12Is2h3Kr1GrQuPjudIKcr3hr
         mofLy/YNB5QOiVfnMH1utgQuBWKHWfgP2wlqOgB1W7Ao36TTG8S7H/pVRgQm5eIAqqKz
         2pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967050; x=1716571850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4G1AoFSIpqiKBdHTLG/UG3KtMvn8GSyLhR2c4jHS3UM=;
        b=c3++ELNGb39PdGx8tECPv0PuJ81ftiL0qh811fVVbM8Eg4FcefcnZ2EiYCr7GmaOGd
         65KRbFm4xHA8pkFmiJoNLL6HCUMaQmZJVBj7i1MyLNqqbll1bOfMvVASUgDUbtFzelPB
         qVBqA5mGM+Dr0xoeHD6Gwu8fDZX+nDv6CCiqWRnYE2/6UB9azdqgQ2WgajhVmU6UHmyN
         ymajYJckL+lY3sWsjbrIHPbwD/8+IbAOA4RBhmHbp6y+a6EcngOs9GiFrqGW2SqwUvP/
         FlJCyk4NWOp8mcT897QQaL6b5idtZOUMd3XcMH1DrAkcY3C+758GfF52CbTjmMy0kyNg
         SuQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrk3LVGqFDazRH89k/tQkneC7J33ZZ4e6kOrFiylwCST73GBzqeSFKM+8so71ZLnbSvbhHJmFYQhv2ZitpzaJ0FGGfJ28MpcB2LlBm
X-Gm-Message-State: AOJu0YzsEYKDWqCyDjEkshunGQDTBLLYL2IbwjGLCCnCBF8RNzerPSDb
	l/NfXiwcX3vBzbS96SgUVZ/Vx+3sLw3JJsZAqshAA9F3zW327QNGmvFHHtYJdU8=
X-Google-Smtp-Source: AGHT+IGXKdXJA0lkwUcO26Y+9UlF6kGxU18scjw4rEAVIldCihU6dVWbhtXLf3Gbw+DaS0FLrN4qtw==
X-Received: by 2002:a0c:f889:0:b0:6a0:9607:a441 with SMTP id 6a1803df08f44-6a15cc965f2mr477287196d6.28.1715967050326;
        Fri, 17 May 2024 10:30:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a465aed09bsm10136526d6.29.2024.05.17.10.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:30:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s81Ps-000Ixn-JM;
	Fri, 17 May 2024 14:30:48 -0300
Date: Fri, 17 May 2024 14:30:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH 0/6] rds: rdma: Add ability to force GFP_NOIO
Message-ID: <20240517173048.GA69273@ziepe.ca>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
 <ZkKcOogJpI0PU2l3@ziepe.ca>
 <72BE64EC-3CB8-469C-85CB-F97671C0E867@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72BE64EC-3CB8-469C-85CB-F97671C0E867@oracle.com>

On Tue, May 14, 2024 at 06:19:53PM +0000, Haakon Bugge wrote:
> Hi Jason,
> 
> 
> > On 14 May 2024, at 01:03, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Mon, May 13, 2024 at 02:53:40PM +0200, Håkon Bugge wrote:
> >> This series enables RDS and the RDMA stack to be used as a block I/O
> >> device. This to support a filesystem on top of a raw block device
> >> which uses RDS and the RDMA stack as the network transport layer.
> >> 
> >> Under intense memory pressure, we get memory reclaims. Assume the
> >> filesystem reclaims memory, goes to the raw block device, which calls
> >> into RDS, which calls the RDMA stack. Now, if regular GFP_KERNEL
> >> allocations in RDS or the RDMA stack require reclaims to be fulfilled,
> >> we end up in a circular dependency.
> >> 
> >> We break this circular dependency by:
> >> 
> >> 1. Force all allocations in RDS and the relevant RDMA stack to use
> >>   GFP_NOIO, by means of a parenthetic use of
> >>   memalloc_noio_{save,restore} on all relevant entry points.
> > 
> > I didn't see an obvious explanation why each of these changes was
> > necessary. I expected this:
> > 
> >> 2. Make sure work-queues inherits current->flags
> >>   wrt. PF_MEMALLOC_{NOIO,NOFS}, such that work executed on the
> >>   work-queue inherits the same flag(s).
> 
> When the modules initialize, it does not help to have 2., unless
> PF_MEMALLOC_NOIO is set in current->flags. That is most probably not
> set, e.g. considering modprobe. That is why we have these steps in
> all the five modules. During module initialization, work queues are
> allocated in all mentioned modules. Therefore, the module
> initialization functions need the paranthetic use of
> memalloc_noio_{save,restore}.

And why would I need these work queues to have noio? they are never
called under a filesystem.

You need to explain in every single case how something in a NOIO
context becomes entangled with the unrelated thing you are taggin NIO.

Historically when we've tried to do this we gave up because the entire
subsystem end up being NOIO.

> > And further, is there any validation of this? There is some lockdep
> > tracking of reclaim, I feel like it should be more robustly hooked up
> > in RDMA if we expect this to really work..
> 
> Oracle is about to launch a product using this series, so the
> techniques used have been thoroughly validated, allthough on an
> older kernel version.

That doesn't really help keep it working. I want to see some kind of
lockdep scheme to enforce this that can validate without ever
triggering reclaim.

Jason

