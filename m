Return-Path: <linux-kernel+bounces-530350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D462A4325F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380B61687B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5781804A;
	Tue, 25 Feb 2025 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+cWg46f"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360C57C9F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740446293; cv=none; b=H0aF0RqD0TuInMh4+MQpTHfiTrjR8G0Kuwu+t6FEXPBJAFJ/MkIgF0d0HD0abH2+6reWcYKsUssvDSoqDYYQukWytsJKW11nwdvwL8gJ69+2dNImFlF1ZQeEmjuA/A4ueMNrAmwUQnF0KkyBT0S7QhUy9uo0PGaNnL4J6R1BlcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740446293; c=relaxed/simple;
	bh=k7RxcH2w6BLVcDkvvfbxCz8aU3QD7i5OIMJK4UUqP34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTP3jnnIu63ac20hDSmnoNjaEpwh1SKYpRQsPWFxl80oVjMutyoNvbZQAxE7jQWVI8G8KL4s5s1rFVISwxVpHB2rWcGUykrKvjXyk1BpaFcMaZaBtPdpHwtT5YjGIkpKKyOZvkmLaVXBSt9ewgNcxDSvMUTF1X63b5wxx0heoMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+cWg46f; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-221050f3f00so114153835ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740446291; x=1741051091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HrkUpGxkfweDpfOc7IojBxbKtQVwxTf19v4lwy5uqNA=;
        b=r+cWg46fSBP1YfTBfhm9cx9ROU8vMNycaOToNKj8UZokdwJslGV7ST2c5H8bTFxRwI
         9BHhgNd/z88BR7hWour38s0/G/PAQyQvUCJe1WFgj6CnXhNF2IUapFfFE8vYsywyHzQA
         b5KsP30kXqGupxHVTQcFiV/fK92xFRkdpG9k8qnF6KmjZnVxbBQb8F9Wm9d3nsVoEL5M
         ydMTi1ZuhrMuFnYUcKPLhTziUYgw0wCHS+xJsd9n1ZoXzcZJm01ZuPeeDr/swb4Ari0o
         gVRetM8FWkWgPZc3FLy1xTY/tOOIFJjDhoXFE00iUCbE90bmt2YFZzRiBVsbD9+dxOVx
         Jwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740446291; x=1741051091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrkUpGxkfweDpfOc7IojBxbKtQVwxTf19v4lwy5uqNA=;
        b=g1jD0pHQJFT8CSQpEv3k2cVSGA/W4TLFifRsUFYRWuUzdSyu/NJykdVSx7QglT2+em
         OjkVdCJrDREF9rC3ETurbRUGbvEyvWZKk9Tdvi620WY5YN4ntHhmNqAUnNdQO/W5wJGp
         BPrSJMWx29CANVNBpmrZt6fbYbrD4SkPGmUCO967+sFYOzr8tB800mUzcszpo9LQrhkE
         HY/OEpkz9ZBCOMm/FkwR03L4L6cZRtOduYBdMR4CtUtmvMGIafQ71h/Dunl8yt/RX6Gk
         /j4AV0I3FAYwLbxnNXPgYrV5jsH8+C1AH4izW67cfqDm9ePs2/bM+Ik7fnXyJZIFrhF0
         cTVg==
X-Forwarded-Encrypted: i=1; AJvYcCUt/GXT+f0bh8PFrbeohots5KU2ESX4+ehIivb1xlaeZ5v3F8KtqmfLbhtFDu6bpz8KkBy8YZAip0QQEsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvW5KrQkereSeRP1toVjJG79gOPvwWuWAWqeWb5O5BNnUUd3uf
	s+iFOLSP9jRclhuGn8bcR6RRXgUgC1TFcxtGYY68h1wN2hJGsa8VwHPKfQlzcPGqvae91bRReVT
	JkQ==
X-Gm-Gg: ASbGncuOUiMsni0q52AKzYSXm2r1bi/S7Ng72ZkQphs6BtPyqb7i9XZFXrb7PVZPxI2
	4JcJCYt8d5nc8AbPcfLnmhm+hp0FCHZp51A+XhcTSo2y8aOTr/2fObSzrVHbOWS+lgPLrQ830Ip
	sDKWnmcp04HKfVm36HsbsHamdXg44/Wx2KQvFnjEumUeWsEh4eVDJazMjd0+T7FU8wswoYtUBmm
	8Utze0W0Y1P2uoHS65Ge1ubKBiQM3tfWRq9PYc3mXMY/LnHHTkjr0nOJo3J0kLhXwgnrKoN8F1+
	JsLDPzNYE7MPJzy0aT/ElO0mqKODbnti6q0IpUeP7+iDYd/0+xDHGSiwy00CZQ512Jbhtc4a
X-Google-Smtp-Source: AGHT+IGC+5UuIMA2luvrb/xdZ77BEUaeWoPZIqYpskI9rBAFjELx2efx+n+6aJmTxIlE6O1zhZ1gWg==
X-Received: by 2002:a17:90b:4a41:b0:2ee:4b8f:a5b1 with SMTP id 98e67ed59e1d1-2fe68cf3fc4mr2256107a91.24.1740446291241;
        Mon, 24 Feb 2025 17:18:11 -0800 (PST)
Received: from google.com (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceae302e7sm7350586a91.0.2025.02.24.17.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 17:18:10 -0800 (PST)
Date: Mon, 24 Feb 2025 17:18:07 -0800
From: William McVicker <willmcvicker@google.com>
To: Rob Herring <robh@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, Saravana Kannan <saravanak@google.com>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Marc Zyngier <maz@kernel.org>,
	Andreas Herrmann <andreas.herrmann@calxeda.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v4 09/14] of: reserved-memory: Fix using wrong number of
 cells to get property 'alignment'
Message-ID: <Z70aTw45KMqTUpBm@google.com>
References: <20250109-of_core_fix-v4-0-db8a72415b8c@quicinc.com>
 <20250109-of_core_fix-v4-9-db8a72415b8c@quicinc.com>
 <20250113232551.GB1983895-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113232551.GB1983895-robh@kernel.org>

Hi Zijun and Rob,

On 01/13/2025, Rob Herring wrote:
> On Thu, Jan 09, 2025 at 09:27:00PM +0800, Zijun Hu wrote:
> > From: Zijun Hu <quic_zijuhu@quicinc.com>
> > 
> > According to DT spec, size of property 'alignment' is based on parent
> > node’s #size-cells property.
> > 
> > But __reserved_mem_alloc_size() wrongly uses @dt_root_addr_cells to get
> > the property obviously.
> > 
> > Fix by using @dt_root_size_cells instead of @dt_root_addr_cells.
> 
> I wonder if changing this might break someone. It's been this way for 
> a long time. It might be better to change the spec or just read 
> 'alignment' as whatever size it happens to be (len / 4). It's not really 
> the kernel's job to validate the DT. We should first have some 
> validation in place to *know* if there are any current .dts files that 
> would break. That would probably be easier to implement in dtc than 
> dtschema. Cases of #address-cells != #size-cells should be pretty rare, 
> but that was the default for OpenFirmware.
> 
> As the alignment is the base address alignment, it can be argued that 
> "#address-cells" makes more sense to use than "#size-cells". So maybe 
> the spec was a copy-n-paste error.

Yes, this breaks our Pixel downstream DT :( Also, the upstream Pixel 6 device
tree has cases where #address-cells != #size-cells.

I would prefer to not have this change, but if that's not possible, could we
not backport it to all the stable branches? That way we can just force new
devices to fix this instead of existing devices on older LTS kernels?

Thanks,
Will

> 
> > 
> > Fixes: 3f0c82066448 ("drivers: of: add initialization code for dynamic reserved memory")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> > ---
> >  drivers/of/of_reserved_mem.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> > index 45517b9e57b1add36bdf2109227ebbf7df631a66..d2753756d7c30adcbd52f57338e281c16d821488 100644
> > --- a/drivers/of/of_reserved_mem.c
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -409,12 +409,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
> >  
> >  	prop = of_get_flat_dt_prop(node, "alignment", &len);
> >  	if (prop) {
> > -		if (len != dt_root_addr_cells * sizeof(__be32)) {
> > +		if (len != dt_root_size_cells * sizeof(__be32)) {
> >  			pr_err("invalid alignment property in '%s' node.\n",
> >  				uname);
> >  			return -EINVAL;
> >  		}
> > -		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
> > +		align = dt_mem_next_cell(dt_root_size_cells, &prop);
> >  	}
> >  
> >  	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
> > 
> > -- 
> > 2.34.1
> > 

