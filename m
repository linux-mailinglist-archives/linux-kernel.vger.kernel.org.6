Return-Path: <linux-kernel+bounces-428771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB129E1333
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8C8282D37
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7FA184523;
	Tue,  3 Dec 2024 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cSwl/WAm"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BEF166F1A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733206057; cv=none; b=Ve7DcS6WDqwfp6kFe0xaSf37ZSHJ4gF5qpZCheiGExdT1OAJc+Oo8i8pmU5oZbHQ5Nk/yYzIGjMgmy0wVGMmUypNR/gZJPxFlUjT1LLNulrQNnuWOyi7iAp8nrnh6QEMwcE9AMYYPVYNe8+cBqcG+/8IduZ88dPXjyIk1BA7aoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733206057; c=relaxed/simple;
	bh=XTMjpzNWKejatR9aU+wGwokeQDdvLo3LzXj/1w8ByAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdwddhH9x2oypRCStjcHi73zqtlsiCzmhuSlkF+eDqPzKC1917BOHukLWL2aF/k5uZaWuOrCLmGE3Qnftc1VBxYS5mK1RnzoIP4OaCBHkuXhz81AY0Ex7uOq1XA9E1qwoiseuJOB8SmxCvtzz5yKNnEf06+b52saSBUY4/eXNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cSwl/WAm; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1008F3FB94
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 06:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733206052;
	bh=jCtgw2Ihe5Nvdj9+Mzfo2xLL7QLo2yfIO/28sKt7Lnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=cSwl/WAmEa9qIm2iBzXS07W9UvPamodx/TNqgeuZt7C229E9NFa0CSRZB3o1yz/Be
	 wB62Qv9SQWJi6hiztqFNLGys9XjPRCYQp09xOWz612VDmEigoX/WvZJ91apvPZkkzH
	 DK0eTr+p1yjs/eKTOZ7JMlZ+26WmNq3dNZ++us9wOe8H9WrRdmhVTmITTYaY2Ew519
	 ktcgjG+MGLz70GjrKpClPI4FahcEcKI/j2I5UKPg1T8lYojmaoAhGj4BgN7F6u1BFJ
	 dPKIUgE/OdPh0unR7HRoxY4FawLo89GJknB2o3i0N66+b+0rkO4G7vuO6bVxiSeKEX
	 jafDIPNgz9DIQ==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7254237c888so4742842b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 22:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733206050; x=1733810850;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCtgw2Ihe5Nvdj9+Mzfo2xLL7QLo2yfIO/28sKt7Lnk=;
        b=WMadbcb7iI3YjqEVOzVkHSODlPE9MH2gv/pNl99FWEzCh0V5mGhecJXpqMFBOfXaEO
         F3CjpMQJcYKiTegPRudt4pz3o3Y5P6ASbQpBu2xR9PgkyCpmS60UyOqagoIoBwCnZ8VE
         Va92Y/1cv1E8xpIouZOMPWhP6ANP71f2YKeEEdqPYIOJd1ueJqYchg33wQP+poTFXJjp
         7FviHAmpJN8VSi2MyF5BkCzdT8COFU/Gr4zv68CyyU7YF/C2qxy0JlQ2Xy0y9NBd9YtV
         pU7EHQ5jGBjpTstkicJsE404hKWtOENF1/wX8Vqu2Olks1wpDU7zznObtaq7yCX4P+Yz
         lkTw==
X-Forwarded-Encrypted: i=1; AJvYcCWtN5SEwyWXY3IUHyhgbCtLfm+4dl0YTAINDEY7KSIoAe7YiFsWR/klDXO8hyZuiuFlAGlE5Ae86RDnhBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPB0Oo0cC8SAKLvExjVR2bwenSBpwVvLerkllLUOn3HSlkYR5
	tC6bKxrBCtvhc/FP0crHnJEgWAuvuYEUqC9ny+hwDEeEvCn3GdzNzot4ruCQbMj8UeZa78T2qml
	mo01XfaDW4xj4lzCCHb8l84d4XaaHZ6FRN1J6RHjLpx6BsqudAwzn4awK8HV0yOaG7rXGm+P7Er
	XLtw==
X-Gm-Gg: ASbGncvKYKpkekWIMY5P7GAe8yl3mgH6Htre3PACL49exFhuIWzq0STi6/KW5cp7+kF
	Y076hHsSqjDuLtQvqyYHgf5um9V8JkEZwteae9UJU6bITAaqbu/1cDcvsqGvzQUyRqqf4lYN/8V
	9JcddHTFJu5c02a+HebhanpAAJeltt9dZzttoNAzUtsHg6OD1lZY1WNrPulaOVvUUgz6VHAAeAi
	VDmRcfMQLFChcC+cDwSLkwRZQ1FXEnmLz76PZqHf9nJc9GSJNZqOWFjZuyeOPj2uvi8wSFT1fq1
	Pwgr9Sg1HigCGOj/dAT1jOXLVwtq
X-Received: by 2002:a17:903:234a:b0:215:b74c:d7af with SMTP id d9443c01a7336-215bd17de5emr14884265ad.45.1733206050612;
        Mon, 02 Dec 2024 22:07:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC8D5e8BfKWktG4VoLbdhTvV/bP/E6zxFyvhL3/tDowqT8G1RZWW0FHv2N7M/SU8+1ikADoA==
X-Received: by 2002:a17:903:234a:b0:215:b74c:d7af with SMTP id d9443c01a7336-215bd17de5emr14884165ad.45.1733206050262;
        Mon, 02 Dec 2024 22:07:30 -0800 (PST)
Received: from acelan-precision5470 (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2153d61aabfsm71869015ad.136.2024.12.02.22.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 22:07:29 -0800 (PST)
Date: Tue, 3 Dec 2024 14:07:23 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Carol Soto <csoto@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Chris Chiu <chris.chiu@canonical.com>, 
	"Matthew R . Ochs" <mochs@nvidia.com>, Koba Ko <kobak@nvidia.com>
Subject: Re: [PATCH] PCI: Use downstream bridges for distributing resources
Message-ID: <kl2wzk5gwhp3s35cznsyelmkep2ch3rm6gbhsh3oehq4ojmbe6@zte6xclilmfv>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Carol Soto <csoto@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Chris Chiu <chris.chiu@canonical.com>, "Matthew R . Ochs" <mochs@nvidia.com>, 
	Koba Ko <kobak@nvidia.com>
References: <20241128084039.54972-1-kaihengf@nvidia.com>
 <20241128094529.GT4065732@black.fi.intel.com>
 <4a88159f-b0f7-43ae-b379-d64c25f417bb@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a88159f-b0f7-43ae-b379-d64c25f417bb@nvidia.com>

On Thu, Nov 28, 2024 at 07:11:31PM +0800, Kai-Heng Feng wrote:
> 
> 
> On 2024/11/28 5:45 PM, Mika Westerberg wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, Nov 28, 2024 at 04:40:39PM +0800, Kai-Heng Feng wrote:
> > > Commit 7180c1d08639 ("PCI: Distribute available resources for root
> > > buses, too") breaks BAR assignment on some devcies:
> > > [   10.021193] pci 0006:03:00.0: BAR 0 [mem 0x6300c0000000-0x6300c1ffffff 64bit pref]: assigned
> > > [   10.029880] pci 0006:03:00.1: BAR 0 [mem 0x6300c2000000-0x6300c3ffffff 64bit pref]: assigned
> > > [   10.038561] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: can't assign; no space
> > > [   10.047191] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: failed to assign
> > > [   10.055285] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
> > > [   10.064180] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: failed to assign
> > > [   10.072543] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
> > > [   10.081437] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: failed to assign
> > > 
> > > The apertures of domain 0006 before the commit:
> > > 6300c0000000-63ffffffffff : PCI Bus 0006:00
> > >    6300c0000000-6300c9ffffff : PCI Bus 0006:01
> > >      6300c0000000-6300c9ffffff : PCI Bus 0006:02
> > >        6300c0000000-6300c8ffffff : PCI Bus 0006:03
> > >          6300c0000000-6300c1ffffff : 0006:03:00.0
> > >            6300c0000000-6300c1ffffff : mlx5_core
> > >          6300c2000000-6300c3ffffff : 0006:03:00.1
> > >            6300c2000000-6300c3ffffff : mlx5_core
> > >          6300c4000000-6300c47fffff : 0006:03:00.2
> > >          6300c4800000-6300c67fffff : 0006:03:00.0
> > >          6300c6800000-6300c87fffff : 0006:03:00.1
> > >        6300c9000000-6300c9bfffff : PCI Bus 0006:04
> > >          6300c9000000-6300c9bfffff : PCI Bus 0006:05
> > >            6300c9000000-6300c91fffff : PCI Bus 0006:06
> > >            6300c9200000-6300c93fffff : PCI Bus 0006:07
> > >            6300c9400000-6300c95fffff : PCI Bus 0006:08
> > >            6300c9600000-6300c97fffff : PCI Bus 0006:09
> > > 
> > > After the commit:
> > > 6300c0000000-63ffffffffff : PCI Bus 0006:00
> > >    6300c0000000-6300c9ffffff : PCI Bus 0006:01
> > >      6300c0000000-6300c9ffffff : PCI Bus 0006:02
> > >        6300c0000000-6300c43fffff : PCI Bus 0006:03
> > >          6300c0000000-6300c1ffffff : 0006:03:00.0
> > >            6300c0000000-6300c1ffffff : mlx5_core
> > >          6300c2000000-6300c3ffffff : 0006:03:00.1
> > >            6300c2000000-6300c3ffffff : mlx5_core
> > >        6300c4400000-6300c4dfffff : PCI Bus 0006:04
> > >          6300c4400000-6300c4dfffff : PCI Bus 0006:05
> > >            6300c4400000-6300c45fffff : PCI Bus 0006:06
> > >            6300c4600000-6300c47fffff : PCI Bus 0006:07
> > >            6300c4800000-6300c49fffff : PCI Bus 0006:08
> > >            6300c4a00000-6300c4bfffff : PCI Bus 0006:09
> > > 
> > > We can see that the window of 0006:03 gets shrunken too much and 0006:04
> > > eats away the window for 0006:03:00.2.
> > > 
> > > The offending commit distributes the upstream bridge's resources
> > > multiple times to every downstream bridges, hence makes the aperture
> > > smaller than desired because calculation of io_per_b, mmio_per_b and
> > > mmio_pref_per_b becomes incorrect.
> > > 
> > > Instead, distributing downstream bridges' own resources to resolve the
> > > issue.
> > > 
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=219540
> > > Cc: Carol Soto <csoto@nvidia.com>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Chris Chiu <chris.chiu@canonical.com>
> > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> > > Reviewed-by: Koba Ko <kobak@nvidia.com>
> > > Fixes: 7180c1d08639 ("PCI: Distribute available resources for root buses, too")
> > > Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > > ---
> > >   drivers/pci/setup-bus.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 23082bc0ca37..2db19c17e824 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -2105,7 +2105,7 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
> > >                 * in case of root bukjijs.
> > >                 */
> > >                if (bridge && pci_bridge_resources_not_assigned(dev))
> > > -                     pci_bridge_distribute_available_resources(bridge,
> > > +                     pci_bridge_distribute_available_resources(dev,
> > >                                                                  add_list);
> > 
> > I think it looks better if you put this into one line instead:
> > 
> >                          pci_bridge_distribute_available_resources(dev, add_list);
> 
> Sure, will do.
> 
> > 
> > 
> > Otherwise looks good. I wonder if you checked that this still works with
> > the cases 7180c1d08639 tried to solve? ;-)
> 
> That's why Chris is Cc'ed.
> Chris, is it possible to give this patch a try to make sure this doesn't
> break what 7180c1d08639 solved?
Verified this fix doesn't break 7180c1d08639.
DUT <-TBT-> Dock <-TBT-> storage hotplug works
DUT <-TBT-> Dock <-TBT-> monitor <-TBT-> storage hotplug works

Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

> 
> Will send v2 after your test result.
> 
> Kai-Heng
> 
> > >                else
> > >                        pci_root_bus_distribute_available_resources(b, add_list);
> > > --
> > > 2.47.0
> 

