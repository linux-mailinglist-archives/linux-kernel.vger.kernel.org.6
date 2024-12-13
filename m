Return-Path: <linux-kernel+bounces-445156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524429F1213
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A06028353F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1201E3DED;
	Fri, 13 Dec 2024 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HFDpKVjy"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A041E379B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734107302; cv=none; b=f2oQVWYoY3mdH/SbH4MnzT29SqR0xyT/2QpyNyf9FfOvOeGP4GzlL2H+qH76WHFKXSCjyXD53EsGRFLo6J/I8cRPRRBR4aPj18wXK3aZ+qAidh6U+e/kdQof3GHYkeqBrsUne2KeGD7EXCU22fPiT51ldRqck4EhZmsQOu3oC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734107302; c=relaxed/simple;
	bh=Kqh/N7dctfb6yjgMfoH2Bl7LG1gFmDipJeF7A7hHmrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3nkFL/Ih1/MHKDCTkCymlfHpdvnpAdPjS7Bb89EFc6412dLiFeZRYxWICDjBv/FtTm13Oy+14cZSWuGVpy7UpT5yqHoAwOB8tfX1UhhuaTSOElwA0w8ZCO/kDFRc4GNmE/VWPr1D4f0i/fxIkk0Yq3sDGmZTXhYG9zecI5zlLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HFDpKVjy; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467a37a2a53so12403791cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1734107298; x=1734712098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HkpUMdpT1bOGFdhaxI+95tgENUX+xpDF8wyAC3G/e8=;
        b=HFDpKVjyFU2rd1aRv+B/qx/o+HSZpAwtgtnF0bNm1Kf4sCGSPf/nTWBnUWWv0tn3hw
         M/ybGjWiiLLe7qmTpNPyRTOFLYT3h1YLfc8mVkxMY4AyLSV4SW9jnaylBUVVRzFJzd6j
         oOlXERLaVUAvPWbxhOQdVOZznw/pQ9O1yyy7eyvjfrYHGveFfXd/WSPAoi5KENRHHbr8
         81FPuxw29WNhzPIpy1UoQsRbpMZsvbXMswmPgQyqcVz9yXdK+IAMQDNOTAxyyOHQN5DO
         Xzw9XM+I6wWhAwazped0PI15rx5vLnpMXxeJ4wKC9kwMkeUzdeckH/pQ+RVRgCl2SNQY
         JvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734107298; x=1734712098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HkpUMdpT1bOGFdhaxI+95tgENUX+xpDF8wyAC3G/e8=;
        b=qpSoBtrabL6NB1lqqE5befhxT2B7zK8ch+bE48xgqNyqCUCyzlicvM8Q0Jsq04Wnpq
         eQ3EASt7Aw7dsl8JtuN12znviEiHctm7fiWks9Ezsfe3/rQg3gI3g6J5GpwNdlfp/YTV
         FA0u0NJjSlNuqB0NqfMewPCWWNVXuue2nvPceZnsninKlX9JFZA4/S1K6mR2OKKLRhK0
         s9hAVhD0kXvo0t2YPBtd47jVpxyFbTiM8vFiZmXb27J+YxSCNYMfjHn+0j+MCxawBgAH
         0ziru8n8N0ECVJjlum2T36ebTq7T2E8rEuqRrI1jM1quIqom2wqzsNqQthRb6WP78Ycm
         u8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX1szVP+OyP5aCV4UhG0HG6BUTRMlaXXcUug2jcRySOxskVUR2JCEibN3gb98TCNH4vxWcoU66t3Xzz1AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTLF/k7RYyqfv9aGWS/ucei5KGhlefOGsjZeRW9peLI3BS+nXU
	qnt2GceIsqEezZkoc2ICscpd5kiiaEKobCIBW7+6aEFW7EinKfHhDuwpxyBP7xE=
X-Gm-Gg: ASbGncsffRWxd2gI1wAqjtJaWiI1zgs+lZnflVaQ53sbQT4vtYaBUplEvHWWtYtQzou
	eDzraL6yRF1I9bF9JfoVi3iH0IM3w+AQa4hD+v5YQ0e0gPBzDTA9vyWeJ3ExbL9LNyDJXFDBFnv
	Wx1WTAEdA9++vufCfAnBb/O0oRq+cEdcnlrpszZ3tpWFdk/830RypY1siGWkdanQUahDGRpfFjQ
	+W5fIjh/2FJK5/pulYPHwDZ78UPTIVbJZGGlSCBqH1OU9YC+1NKky5MnXi4+BuapH4x3cx0FEb9
	KcEk+vZVxTvqwhIqa0v2zXoJ9Yu/w3Hg6gjOnombjQ==
X-Google-Smtp-Source: AGHT+IHEbODzADsorYd+LpJC068MW4TXFz13cw2XglTXpEdo0jaL87bcR5cQpr16MMrGC5XroMk8Hg==
X-Received: by 2002:ac8:5a93:0:b0:466:a983:a15a with SMTP id d75a77b69052e-467a581d253mr49010891cf.42.1734107298364;
        Fri, 13 Dec 2024 08:28:18 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4676e091d95sm49623571cf.12.2024.12.13.08.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 08:28:16 -0800 (PST)
Date: Fri, 13 Dec 2024 11:28:05 -0500
From: Gregory Price <gourry@gourry.net>
To: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, kernel_team@skhynix.com,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	=?utf-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKQ==?= System SW <honggyu.kim@sk.com>,
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
	=?utf-8?B?6rmA65296riwKEtJTSBSQUtJRSk=?= System SW <rakie.kim@sk.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horen.chuang@linux.dev" <horen.chuang@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [External Mail] [RFC PATCH] mm/mempolicy: Weighted interleave
 auto-tuning
Message-ID: <Z1xglcL7wb_2IwnS@PC2K9PVX.TheFacebook.com>
References: <20241210215439.94819-1-joshua.hahnjy@gmail.com>
 <4ddfa283-eb64-4032-880b-c19b07e407e1@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ddfa283-eb64-4032-880b-c19b07e407e1@sk.com>

On Fri, Dec 13, 2024 at 03:19:20PM +0900, Hyeonggon Yoo wrote:
> On 2024-12-11 06:54 AM, Joshua Hahn wrote:
> > This patch introduces an auto-configuration for the interleave weights
> > that aims to balance the two goals of setting node weights to be
> > proportional to their bandwidths and keeping the weight values low.
> > This balance is controlled by a value max_node_weight, which defines the
> > maximum weight a single node can take.
> 
> Hi Joshua,
> 
> I am wondering how this is going to work for host memory + CXL memory
> interleaving. I guess by "the ACPI table" you mean the ACPI HMAT or CXL
> CDAT, both of which does not provide the bandwidth of host memory.

Then your BIOS vendor needs to fix their ACPI table generation, because
HMAT can absolutely contain that information.

[078h 0120   2]               Structure Type : 0001 [System Locality Latency and Bandwidth Information]
[07Ah 0122   2]                     Reserved : 0000
[07Ch 0124   4]                       Length : 00000030
[080h 0128   1]        Flags (decoded below) : 00
                            Memory Hierarchy : 0
                   Use Minimum Transfer Size : 0
                    Non-sequential Transfers : 0
[081h 0129   1]                    Data Type : 00
[082h 0130   1]        Minimum Transfer Size : 00
[083h 0131   1]                    Reserved1 : 00
[084h 0132   4] Initiator Proximity Domains # : 00000001
[088h 0136   4]   Target Proximity Domains # : 00000002
[08Ch 0140   4]                    Reserved2 : 00000000
[090h 0144   8]              Entry Base Unit : 00000000000003E8
[098h 0152   4] Initiator Proximity Domain List : 00000000
[09Ch 0156   4] Target Proximity Domain List : 00000000
[0A0h 0160   4] Target Proximity Domain List : 00000001
[0A4h 0164   2]                        Entry : 006E
[0A6h 0166   2]                        Entry : 01FE

[0A8h 0168   2]               Structure Type : 0001 [System Locality Latency and Bandwidth Information]
[0AAh 0170   2]                     Reserved : 0000
[0ACh 0172   4]                       Length : 00000030
[0B0h 0176   1]        Flags (decoded below) : 00
                            Memory Hierarchy : 0
                   Use Minimum Transfer Size : 0
                    Non-sequential Transfers : 0
[0B1h 0177   1]                    Data Type : 03
[0B2h 0178   1]        Minimum Transfer Size : 00
[0B3h 0179   1]                    Reserved1 : 00
[0B4h 0180   4] Initiator Proximity Domains # : 00000001
[0B8h 0184   4]   Target Proximity Domains # : 00000002
[0BCh 0188   4]                    Reserved2 : 00000000
[0C0h 0192   8]              Entry Base Unit : 0000000000000064
[0C8h 0200   4] Initiator Proximity Domain List : 00000000
[0CCh 0204   4] Target Proximity Domain List : 00000000
[0D0h 0208   4] Target Proximity Domain List : 00000001
[0D4h 0212   2]                        Entry : 1200
[0D6h 0214   2]                        Entry : 0064

Obviously if information is missing, then manual is the only way forward.

> > +		The maximum interleave weight for a memory node. When it is
> > +		updated, any previous changes to interleave weights (i.e. via
> > +		the nodeN sysfs interfaces) are ignored, and new weights are
> > +		calculated using ACPI-reported bandwidths and scaled.
> > +
> 
> At first this paragraph sounded like "previously stored weights are
> discarded after setting max_node_weight", but I think you mean
> "User can override the default values, but defaults values are calculated
> regardless of the values set by the user". Right?
> 

Agree that these comments need clarification, we'll workshop it.

~Gregory

