Return-Path: <linux-kernel+bounces-549424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA91A55284
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F44C18871AB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E6A25A33B;
	Thu,  6 Mar 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fS5Df75Q"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8C210F4D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280937; cv=none; b=PGUJ7ORd9gB1AKKcFs0O3THDBTe1U3wKD0vWgrroN6toPphFBnRmk87B/rGh54Ktar+s7x5oCd2yTPsWIGyy1WSOWHS8i19EySfAUSBZ+4f5yx1Ar3PW5NDEuBiZ/aXsWauf+bqpi9qRp8XtgEApbIt8plYdhq8Ymye9ClYIZWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280937; c=relaxed/simple;
	bh=RUEhFfWhM5UlQ2uov74uy48HBJc5JClctmAaFgriwI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uom/m3iuRqc4oEVgNYSoAgW1r+l/QCdcWxD5k/rMRi/X5UuUNwTNifjK3V4CAoMYICjNE7MPGc2XXai2fsu4Dw/qoWobrLVk4DhoddetENuXqL6+GMZPzE1TvSvQgvba6ifC6egDqPkXO8t0MBOz8DMXa+dr4OfzMbqSti180HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fS5Df75Q; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c3d3147b81so103886185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741280934; x=1741885734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1wNyXxcCEsmV3rMjIVb7Etw5fSJV7UEopsGd2j/hR1s=;
        b=fS5Df75QuIH6V1NtwQfhY3gI1AGXkZgDYKU3TWbo9wvxTgPt6+hROtfoopNLJvkDXP
         Mrh1crW1CoQqR3DPB0eFN8P+1XYQdHqf7Xm03r0uvUk6Zg4XD27SWkmWovW8FXobEMwg
         2z0bjXX8yqXhgvROywDk6eDLjas4Rk/HEje+hDZTp/bwkJ/WXw06LZJfurnm8ARq7fWw
         8yf3RVIFo11lsQq3N3QcNIS4smPiPetodYzP4x4vNJx8L1PS4N6CEVJHmsLsea7XSO3u
         wJP0Yh7BpABFQ50Z3xCLIx1gz+P07hh6NS8l8rxL+a//dssZpyZu+/9mch4/YIdPAXS5
         u4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741280934; x=1741885734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wNyXxcCEsmV3rMjIVb7Etw5fSJV7UEopsGd2j/hR1s=;
        b=c9gi+M1bycIAaOjoOLL2Ypj6RS2CEhMr9zRB5Hko75S2t2guf6j6cz0DuqqWPxCUFb
         ydtf29l0Sv7wjNJh3dMmhOMxF1C6huK0QN5dAPAxn4xGroUGC5VisLFpfhb5SG0xIIPv
         YGvICaNHtVLQHcg/DanATtw163bXt+pLV26aASNv+jXFiBArxtXwEg3A7A/PuQYdD1cN
         tf+98UQxfCBGjTmb2eQ/g3c/HLeRy8aUc1dd58qP9+0/6dSYPhpJoanr0uCBuTJrpXPu
         P9tW3hu6/YSkt2bekuCCpYD7wISmW0cED7/HQkaMv7xKS8VZx7V4BSNO1i+rwuupb526
         8kYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSNhnzQmTPRLhQ16Eq2/H3bRdNKgKcOw7eeMVI1wPoF/dtlI4SnDwcjPvr5uCOJKbPNyBuPtnyjwpAmYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZytiPE+XnY1N2qVxT9AU0p0l1qA09SGJP0jHFxv2zgT09lJZ
	KnaUtvNeDJrvIU0IKmeOe1WhgKJo73g0qxuqS276N4xJwAUqqoJze6i+OvIBEKA=
X-Gm-Gg: ASbGnctqTV/Ph14jD9y8NeeVSEx3agQB4yaK4jQ/BQa7msJlh1VxPfiwfygFVwNln1t
	tRLkFQBN9R7Xr1m/kS45BXF9QlLgIxZ1R5Qcv58finxwi+BIVmx6RxyHA6bRgDotIxSIFjMgQF8
	Sp94TarlUgrjt+beZD9dbbmfpdsNi1s1fNk6THsdZ7URJX/kHjQVNqgcvs5VfebhqtyiHOBrvC8
	Amcx2KGmAKhtyRzAAK8j34E2Iy33XNTIifvDAXZMvFxjyynxLJzvTzYT1fIAJfHpG+kNxEfGjAF
	qkE/yE8ROSscl2qlU11ZeHrHk+Zerm2SO3k7K3nkVRYIW+dcAf5IyTQK32HgQ9x75kRAsQNoq+U
	vaPmble6roXLcpD725zCdH1+kcsc=
X-Google-Smtp-Source: AGHT+IGzXdo+ayTPw4Ob64P9xw3wnYIZAQKLG2XeMD/1+CZlCiHLJrym6jweO9Vd+DG+fYhwPqgi2w==
X-Received: by 2002:a05:620a:8806:b0:7c0:a357:fe62 with SMTP id af79cd13be357-7c3d8e65564mr986859185a.19.1741280932574;
        Thu, 06 Mar 2025 09:08:52 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e55116a5sm111483085a.106.2025.03.06.09.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:08:51 -0800 (PST)
Date: Thu, 6 Mar 2025 12:08:49 -0500
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z8nWobZXQwhtE1nK@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <Z8j8bZ5TS+gDV8+M@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8j8bZ5TS+gDV8+M@phytium.com.cn>

On Thu, Mar 06, 2025 at 09:37:49AM +0800, Yuquan Wang wrote:
> On Wed, Mar 05, 2025 at 05:20:52PM -0500, Gregory Price wrote:

First, thank you for bringing this up, this is exactly the type of
ambiguiuty i was hoping others would contribute.  It's difficult to
figure out if the ACPI tables are "Correct", if there's unimplemented
features, or we're doing something wrong - because some of this is
undocumented theory of operation.

> > ==================
> > NUMA node creation
> > ===================
> > NUMA nodes are *NOT* hot-pluggable.  All *POSSIBLE* NUMA nodes are
> > identified at `__init` time, more specifically during `mm_init`.
> > 
> > What this means is that the CEDT and SRAT must contain sufficient
> > `proximity domain` information for linux to identify how many NUMA
> > nodes are required (and what memory regions to associate with them).
> > 
> Condition:
> 1) A UMA/NUMA system that SRAT is absence, but it keeps CEDT.CFMWS
> 2）Enable CONFIG_ACPI_NUMA
> 
> Results:
> 1) acpi_numa_init: the fake_pxm will be 0 and send to acpi_parse_cfmws()
> 2）If dynamically create cxl ram region, the cxl memory would be assigned
> to node0 rather than a fake new node.
>

This is very interesting.  Can I ask a few questions:

1) is this real hardware or a VM?
2) By `dynamic creation` you mean leveraging cxl-cli (ndctl)?
2a) Is the BIOS programming decoders, or are you programming the
    decoder after boot?


> Confusions:
> 1) Does CXL memory usage require a numa system with SRAT? As you
> mentioned in SRAT section: 
> 
> "This table is technically optional, but for performance information
> to be enumerated by linux it must be present."
> 
> Hence, as I understand it, it seems a bug in kernel.
>

It's hard to say if this is a bug yet.  It's either a bug, or your
system should have an SRAT to describe what the BIOS has done.

> 2) If it is a bug, could  we forbid this situation by adding fake_pxm
> check and returning error in acpi_numa_init()?
> 

> 3）If not,  maybe we can add some kernel logic to allow create these fake
> nodes on a system without SRAT?
> 

I think we should at least provide a warning (if the SRAT is expected
but missing) - but lets get some more information first.

~Gregory

