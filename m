Return-Path: <linux-kernel+bounces-564811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9C0A65B25
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C043AAAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6001AF0C1;
	Mon, 17 Mar 2025 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e+Q6h+Rc"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF08189F57
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233378; cv=none; b=Ad5y80xi5ntaViX7lxOjB73EXP3sLNsvJdPfADYSatLWhZH0m8z3yamRzBtRDKtcSLboiH7n5ysDBcjrmVk0S8RcFSuMPcGbwhG7VSXOQgSZ3ACiTveUh/zCH1IxXcwOWQNgxECuMsvmvuLLBXfHtZBxX0CCCESqblKS94NadCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233378; c=relaxed/simple;
	bh=O4nrPLyamLCCyaWqQW+fu+1xgvE7CNsXjO1kMscMvWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBZYAqw+p1OwGWSuFLJ0N3vk4+aw+bHRw/p43miplstnxr/nMF1YpeC/zeP+Vzf6MenI03sUng/xPJhc7Zj8FR2p9VQEAiAVXjhI4CNzmTmljavJmTOcxi0rGvkI3sFVS81xZPrWIqReDmIGLVqgKeKQLFhuFzuezo5saoxW3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e+Q6h+Rc; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5568355ffso385981285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742233374; x=1742838174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qIumjbP5J/FNsIgd6eSQrbmNGbx4a2Nt6O2c+0OlOIE=;
        b=e+Q6h+RcAu5181PwlIGxPaYPbd+h+gSbp3Eu9VN0nxLtZF58QieRKwy0XPDFk+/iKP
         8Sqm8p1y1TvIoIP+/CbF46oLh4TxNtyARFU9PpBkPzzs0AvbMqraevnkWosVfYRiud6y
         Z8GMpCCbTp4pq16XMeGOi+ebxVzIcxpb9X3zLf4v5AqxkI7dUjyfsgReJFCGwU92CqsN
         CZvQo8CN1fiXEcqaiQK67ia+cIf9LM/8XzWK3qOH9ufKfszb+nPnRLFaYy82zdKBWemf
         MNATikiL6r0Y7ionfiJlhGzWxt3psbAGmxUcXH128ORI1ckSY6iGusUZuR1WGINvNfAM
         2rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233374; x=1742838174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIumjbP5J/FNsIgd6eSQrbmNGbx4a2Nt6O2c+0OlOIE=;
        b=LavboN15rgn64i+Dpdt1SPzAxmRQqDEwFUq4LyCsPW+HvfvobSqePVE9YfjHTYP7+z
         /bL53pKk5SVywxVzUq0RUxo2usCZ/TbVCr9Xnt98gJoI5ZIVU5saj9zf6j5G8sqMiwt3
         4Yu8QzDbCPnSKxukC5gdLbqqR6Hr4N5FJPe7IYWlj2pafwoUopjM0AYx7Ivxr1bpj7Gw
         aGwBAoZqCArNDR8Bvi4rl20Y41ZvRl8vjbL3DECY9c4rd48p+PezGhDeplTw/WWmb+S2
         2F3lU54e+fjoclDlWN3v5USmkEoUGyPtkXW0USjUC0BE5UqfBDRWIc4nVftzf3TkEYv1
         q98A==
X-Forwarded-Encrypted: i=1; AJvYcCX2TRnzs1hFyOn5VvUNNvvPHZyOKDQtyMm8+KTYhtrOFnkwT08z88wR+Z6qrrTn20dYtgFqJ1QgCkm5R3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2L7qgm+whP1wiHu4IguxaRshMsW6xEdDvB/WEsH90fk1fiLz
	DMW0N0ar3VAzqhsfNmpD/rOxNwd2s+GUfRwpjzkUfi1f3l6CMJMax06YxZ2QP2I=
X-Gm-Gg: ASbGnctDPQx1yKcCK8nRs6wFYZsiCv/rMW2CNdeijub4eKDOp2X2M2P0Gl2ycDzf1Rh
	LEkt4du2rICQU3b9rtKnE+xk8KyOx2/TXFWoTDaDFV7gfEZnnT65sO7UZX5CqPRTUyX/jryclsP
	5aBcbDJTcf16qIbbFMjG4I08WoTidmbNVlbi5sj9z6bpBYk0KFPb5vvSPVEkSpb0iLj4UgNSmOm
	wiqaVaV1SIaDq1Ye3rDotJF39gP95KQd9mAWWBoZ1C7chGUfCdTfWWUSZFI8FNP/5cvk3bXmf3X
	zKJAYiZsYLpke8tNu0pYBZZ5vGRk1eCff0OX2+pqAd8zcRcNDnjeGkZgC5COP8T2ob/Ceh2K3/a
	ucKxxWNKyii81UVgKqUv6d34WoPY5
X-Google-Smtp-Source: AGHT+IFm3m+TIvLp/42d+oS0NNodx96Bmh/ApjXOVi7XJ1ehRoz7URv6NoETqpy3pqWkCuIfw+AQPg==
X-Received: by 2002:a05:620a:4411:b0:7c5:3c0a:ab7e with SMTP id af79cd13be357-7c57c79bd5amr1536349285a.5.1742233374449;
        Mon, 17 Mar 2025 10:42:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9d641sm611346385a.65.2025.03.17.10.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:42:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tuEUG-000000006co-3Ai2;
	Mon, 17 Mar 2025 14:42:52 -0300
Date: Mon, 17 Mar 2025 14:42:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>, Arnd Bergmann <arnd@arndb.de>,
	Robert Richter <rrichter@amd.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: fix FWCTL dependency
Message-ID: <20250317174252.GA10600@ziepe.ca>
References: <20250310135119.4168933-1-arnd@kernel.org>
 <0c2a1f2f-539f-4a94-82f4-57406421a3b8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2a1f2f-539f-4a94-82f4-57406421a3b8@intel.com>

On Mon, Mar 10, 2025 at 08:24:44AM -0700, Dave Jiang wrote:
> 
> 
> On 3/10/25 6:51 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The 'FWCTL' subsystem is selected by CXL_FEATURES, which is a 'bool' symbol
> > with a dependency on CXL_PCI, but referenced by the cxl_core.ko.
> > When cxl_core is built-in, but the cxl_pci.ko driver is a loadable mdoule,
> > this results in a link failure:
> > 
> > ld.lld-21: error: undefined symbol: _fwctl_alloc_device
> >>>> referenced by features.c:695 (/home/arnd/arm-soc/drivers/cxl/core/features.c:695)
> > ld.lld-21: error: undefined symbol: fwctl_register
> >>>> referenced by features.c:699 (/home/arnd/arm-soc/drivers/cxl/core/features.c:699)
> > ld.lld-21: error: undefined symbol: fwctl_unregister
> >>>> referenced by features.c:676 (/home/arnd/arm-soc/drivers/cxl/core/features.c:676)
> > 
> > Move the 'select' into the symbol that controls the core module instead.
> > 
> > Fixes: a53a6004e7a5 ("cxl: Add FWCTL support to CXL")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> 
> Thanks for the fix Arnd. Jason can you please append this fix to your latest branch? Thanks!

I folded it into the Fixes commit thanks

Jason

