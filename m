Return-Path: <linux-kernel+bounces-560105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB52BA5FDCC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974FE189DBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A87814386D;
	Thu, 13 Mar 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Bxu/CBGh"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404FAD5E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887065; cv=none; b=pCVprxa5BQ41ThglpusLl5Hi0EbLUlhZay9fKRRZaTQupNmy4R7HawsdYuJ7jqLtpslNjoKQiElP3T6hiETn1+pQktlhn61WekGaaD5w6vjuV/hOMautwjn9ELZTY5xYO4srgRQcUEwr3OK9y/ENHRhQ3DdW/La6VsRa83LSi9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887065; c=relaxed/simple;
	bh=6NuaKrlJwzqSDKDjBHf+Cx4W/xW2kBVGqK/Gow+UQ3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsIMwRQ7QeztqijeY1twIDHkG0Fel9663o38hg01sqDxBol/McbsSbO2tz9CpgXXokx/SJB3PqnHnP8rxT3vKmaGDjW/0PPtiABDOTmOmmL8FPU6AYrJkNJ1luSgQev10/P3vrAj6MCvFB8oKGjJQIqMz0I3fEmNNA6Yxynyf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Bxu/CBGh; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8fb83e137so11254386d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741887061; x=1742491861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O83EJQJInxOlaXTG5L5nMhpQUXrgmfAXio9XKQcNg+E=;
        b=Bxu/CBGh1pVH5fT0NdtdDxQhTO/pJDlrkGJbdAIvv8FvPP/bvdScXcnGaLIsDMAvQs
         yuyS+90g3Q2E+9ZmAmDmeHAy0imuT/3I3n650YVGnggUbZ6IBgpFwr8YFhE0mIWsyOrp
         hAs548NQtxzVcwVdu7T8AAQEpYajbhMXyoxoy7DO0S5dEXqkdQvCuVJpuz7BI4j5nUw8
         /9hsiplD/eX2Xlp0l1p119LtByn6QTY5LT1p0e8WUa//zzS4CqHoNFOYZg4bpTJOnH9G
         n9KJnQrbpO3sBxisoNkowHb+n22z1V8VcH/TozRwoWWmofq53D8vKCcXARMzRIr+tmYh
         HGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887061; x=1742491861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O83EJQJInxOlaXTG5L5nMhpQUXrgmfAXio9XKQcNg+E=;
        b=scxove4aHIUumMzhVJCHOFhLl9Qzux/Ttj0ShIcj0hZnEo0y77Z72y0lEF5G3WUO+w
         xKU3HE9DQXRw4CDW4ynmqM250j39m6gnlHoQ9Gic5dd2qMwKdITa0QsWyTQAcjMIXEIf
         sTKpbCMTrtrzQ0HKRHCcw1+A3dta4Q1u0lbc7i8yGBRzVLfhxO77Hei9ZfbVggFZawsx
         u07juKT+niTkuMKuEGRdvAj8EtET5004wnKjLymFo/tdTUMhtGeCm/WgwCBFMTe8CV7p
         nVh7TyI08D2EPa+1ZUi84uk9r95Moe/5De1AjefmMZGffoN0HzvsNWKqQdVmLOrtkKvS
         Gf8A==
X-Forwarded-Encrypted: i=1; AJvYcCX0k/vLh/Qz/a92Zg3dioCExBirfHuBnNXHCcMS2k8esJE6UQxuA5aSIsPV/LH+ld7LcVFUYWclxBtydV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXKWPLtu+C/z2sA1hDpbhqUmC4M7xrjRfeiI9uGgs+3p35tta0
	fnFSYCuwiiOK17rpDGr6zbnvIdLfunlWRS1Ij4WKGildkRzX91el+H0a6uPhir4=
X-Gm-Gg: ASbGncu6PfJ8sX09Oh0Y0UOD8s6u4o8WK5CH8mEbmMHGYi2jQB4p1YciiiD96DkJpAo
	/QKzL4smtMtxeKueTUn4P22M+21Y/D9JUnUwfe9I7r1EB1ioiVQqO1ubzBPJg4vdKaLYkFHYiwy
	PvoJC4A45EDZy7CiOdWYlBJblO8VveWWJzdZhYfku+ptl3SGaDaQ/6L/l9BjDEA/Jfk7Mp/MHPZ
	jHS1EAqigYIkLmoTi2Ws1YQjc5zUvtWFnWvXuctpKsseTfuXl5MKup4BJEg6fUpohIltQVvLPUc
	cxjbMm6/43rpK9nNz9hmsmvqmajxvFTyRozxsekem0r1RtWmNqDlVBHKnVQQDzwrQ2HVVn2Lgpp
	BaHcRDwL3pcuONVQTnUp79gZVeXC6uDthw+cAMg==
X-Google-Smtp-Source: AGHT+IHuylmJfYk7wLLXX/2M7mKuROyvy47bvGrvCnuvmNFtINIICBzR6GpKU9pV+TBfiu9Nbi1ktg==
X-Received: by 2002:ad4:4ee9:0:b0:6e4:4484:f35b with SMTP id 6a1803df08f44-6eae7aa22d7mr6914286d6.30.1741887061046;
        Thu, 13 Mar 2025 10:31:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb663603sm11829221cf.43.2025.03.13.10.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:31:00 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:30:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z9MWUhHmZ5ND0b_e@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <20250313165539.000001f4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313165539.000001f4@huawei.com>

On Thu, Mar 13, 2025 at 04:55:39PM +0000, Jonathan Cameron wrote:
> 
> Maybe ignore Generic Initiators for this doc.  They are relevant for
> CXL but in the fabric they only matter for type 1 / 2 devices not
> memory and only if the BIOS wants to do HMAT for end to end.  Gets
> more fun when they are in the host side of the root bridge.
>

Fair, I wanted to reference the proposals but I personally don't have a
strong understanding of this yet. Dave Jiang mentioned wanting to write
some info on CDAT with some reference to the Generic Port work as well.

Some help understanding this a little better would be very much
appreciated, but I like your summary below. Noted for updated version.

> # Generic Port
> 
> In the scenario where CXL memory devices are not present at boot, or
> not configured by the BIOS or he BIOS has not provided full HMAT
> descriptions for the configured memory, we may still want to
> generate proximity domain configurations for those devices.
> The Generic Port structures are intended to fill this gap, so
> that performance information can still be utilized when the
> devices are available at runtime by combining host information
> with that discovered from devices.
> 
> Or just 
> # Generic Ports
> 
> These are fun ;)
>

> > 
> > ====
> > HMAT
> > ====
> > The Heterogeneous Memory Attributes Table contains information such as
> > cache attributes and bandwidth and latency details for memory proximity
> > domains.  For the purpose of this document, we will only discuss the
> > SSLIB entry.
> 
> No fun. You miss Intel's extensions to memory-side caches ;)
> (which is wise!)
> 

Yes yes, but I'm trying to be nice. I'm debating on writing the Section
4 interleave addendum on Zen5 too :P

> > ==================
> > NUMA node creation
> > ===================
> > NUMA nodes are *NOT* hot-pluggable.  All *POSSIBLE* NUMA nodes are
> > identified at `__init` time, more specifically during `mm_init`.
> > 
> > What this means is that the CEDT and SRAT must contain sufficient
> > `proximity domain` information for linux to identify how many NUMA
> > nodes are required (and what memory regions to associate with them).
> 
> Is it worth talking about what is effectively a constraint of the spec
> and what is a Linux current constraint?
> 
> SRAT is only ACPI defined way of getting Proximity nodes. Linux chooses
> to at most map those 1:1 with NUMA nodes. 
> CEDT adds on description of SPA ranges where there might be memory that Linux
> might want to map to 1 or more NUMA nodes
>

Rather than asking if it's worth talking about, I'll spin that around
and ask what value the distinction adds.  The source of the constraint
seems less relevant than "All nodes must be defined during mm_init by
something - be it ACPI or CXL source data".

Maybe if this turns into a book, it's worth breaking it out for
referential purposes (pointing to each point in each spec).

> > 
> > Basically, the heuristic is as follows:
> > 1) Add one NUMA node per Proximity Domain described in SRAT
> 
>     if it contains, memory, CPU or generic initiator. 
> 

noted

> > 2) If the SRAT describes all memory described by all CFMWS
> >    - do not create nodes for CFMWS
> > 3) If SRAT does not describe all memory described by CFMWS
> >    - create a node for that CFMWS
> > 
> > Generally speaking, you will see one NUMA node per Host bridge, unless
> > inter-host-bridge interleave is in use (see Section 4 - Interleave).
> 
> I just love corners: QoS concerns might mean multiple CFMWS and hence
> multiple nodes per host bridge (feel free to ignore this one - has
> anyone seen this in the wild yet?)  Similar mess for properties such
> as persistence, sharing etc.

This actually come up as a result of me writing this - this does exist
in the wild and is causing all kinds of fun on the weighted_interleave
functionality.

I plan to come back and add this as an addendum, but probably not until
after LSF.

We'll probably want to expand this into a library of case studies that
cover these different choices - in hopes of getting some set of
*suggested* configurations for platform vendors to help play nice with
linux (especially for things that actually consume these blasted nodes).

~Gregory

