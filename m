Return-Path: <linux-kernel+bounces-418718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065D9D64AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1A0283B29
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C5F1DFDAF;
	Fri, 22 Nov 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uVOoXuTZ"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C635016131A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732304804; cv=none; b=P7iedKy/Iuf+BAV9fIjvu/ZEk8cAD5ZnQltez39WJKOZEQdbp152RVcrznZGygfdXF0OiziU3f4A12M1WP0wzFfUunNcj9lgO0VKacOXQ/c+oXs1h3j5sj/eiGR+evVaSY8IsqA3fQbvM72v7iTrJ23ZHRFpdf8Zu0dXnCBjfS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732304804; c=relaxed/simple;
	bh=BuqKwIhhlq640Tjm6f+46BvN+qD9+ruWJktqKdOD9Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl3ONAm2p1bKPdqDyBrc8p18NUQ+uCQq7cy1je98Iai5p2mJXDRiYtR42rzo42AET0seAWAeI2wNPiM4mhmhkPILH7mlR+4IxdeVcpNCM8f0ybP4sSc2tyNCPLzQyFINx7YBmeMXnl6h7AVJA7UKjqrkhZlZtJmiEkVZMC7FhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uVOoXuTZ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d4531d1309so6805496d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1732304801; x=1732909601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MO/NjeTFX3gMP5INkTmGbgV+SuU4fgpwtR/cceOFgRQ=;
        b=uVOoXuTZpCBlkOfih97Sew01pR0pbWEYLQSpDgvwFJQO/TdHgi4BeRPyY1yXeFY6ut
         yJ1F41CoRQZeTHdSs29+mQsgWY1whZz+JpjcyW2dLVTLhORxTsk/gD2AYiRBxSz21cpX
         DxmVHmQPDcLrV749cF+12BblPTAnjauEu41SeGfpNM6hRo/tA3L8tJPzcnQ6a3jiMHyA
         QJQFWcSgBGph2uSPXQoaBMsdrq41j2nKILjySbz0ErWhjip46Cf4SWR1R+EFWa756BRr
         uIGaXt49R+C1PDNeqoxSM/eNepyoSyYEkfMjypOuMUieabOihmEYHTnf4G68JjWP3sVN
         Owag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732304801; x=1732909601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO/NjeTFX3gMP5INkTmGbgV+SuU4fgpwtR/cceOFgRQ=;
        b=rff++i0OpPpSXRAb71naj2F9FBAB64bnYmGJ9RNEua/+qTuLMj7k3Tj5W/gW7eBwtJ
         PZuxFN7RVGKomVkaA4Z40vsTNWGEKZvGqmUezXAM7fwt3fUNg6/TfKvhnz/HGKtjVLUX
         MeplOcNUFu1XgO9E0qKU+T6BafOuWoqUEA75PCZbMGqgusS2X7Cyj599HRdO6wpF2Ci2
         4cj9k4Xp2wyZbbuiL2aF0LsaJ6eFj88Iw3oZxQmtM+SvBwictVParoxnhyui92M6kIiF
         osjrJcLPVT6XjgZvW4KN1sS4a6O5dLG/mWCFbZsuGQ6qxKNUeYfqAIwHc/N82Lb2X7eD
         bCeA==
X-Forwarded-Encrypted: i=1; AJvYcCWC1+botaHYJhxtg1GtLPrUX9+7AvMcoDpam8StDufylVpka7LzEY9MOYPmbLG78BOvh4yfA76dZaCI8Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8k1Nn4+nkV8McL8PLc5lSRe1X7MKLPjHwXWvWqQU7CoQ62I4
	9+7MiK+wGkFUOUg/o2xvd+EUGFm0l7qZglJH219He+Uq+YWvDVVr8337TN5KYTA=
X-Gm-Gg: ASbGncsG8WDanAyXt8FX6JQhyXA0Cembgb4RIrHNeBRdlpjXth9VhHW0wp2EFPHwSdY
	/msFYFx0CfmUfwvTtHR4jU41kajnXsqneOXiH0vowL6HZMpQ3e9ZGx1F3KZXdlrVf92j70EY/nb
	2j3H30Sum0Rsyw695SdOyPyzCpYPUSPOiE9t2eDZ4rPBjUiFerrFocx0QAYHtLG/J0deMqlsxKJ
	tuAAl9+8QN/D1yH/RANX8oLneJLPTXjiY1rleM415WSauNIHojBxQUXsU5toEXC0Go4qOrADuA3
	PwnDnVhghNMyTvrPoxXXo9V8IdvZ6GGE30I=
X-Google-Smtp-Source: AGHT+IFnOTk8hem7XuBaxt0wRk0+67VdCNaogvAT2Yq0WpVnlSL3hP+LBgLBSZ1Yf6goAOlisWVnBQ==
X-Received: by 2002:a05:6214:4111:b0:6d4:1a1b:f839 with SMTP id 6a1803df08f44-6d45136320dmr57414576d6.49.1732304801650;
        Fri, 22 Nov 2024 11:46:41 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b244fdsm13515096d6.77.2024.11.22.11.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 11:46:41 -0800 (PST)
Date: Fri, 22 Nov 2024 14:46:31 -0500
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming <ming4.li@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	rrichter@amd.com, terry.bowman@amd.com
Subject: Re: [PATCH 0/3] cxl/core: Enable Region creation on x86 with Low Mem
 Hole
Message-ID: <Z0Dfl76DIsrmWEZ1@PC2K9PVX.TheFacebook.com>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>

On Fri, Nov 22, 2024 at 04:51:51PM +0100, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. On those systems, BIOS
> publishes CFMWS which communicate the active System Physical Address (SPA)
> ranges that map to a subset of the Host Physical Address (HPA) ranges. The
> SPA range trims out the hole, and capacity in the endpoint is lost with no
> SPA to map to CXL HPA in that hole.
> 
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, the driver fails and returns an error because it
> expects that the CXL Endpoint Decoder range is a subset of the Root
> Decoder's.
> 
> Then detect SPA/HPA misalignment and allow CXL Regions construction and 
> attach if and only if the misalignment is due to x86 Low Memory Holes.

+cc Robert Richter and Terry Bowman

This is not the only memory-hole possibility. We may need something
more robust, rather than optimizing for a single memory hole solution.

Robert and Terry may have some additional context here.

~Gregory

> 
> - Patch 1/3 changes the calling conventions of three match_*_by_range()
>   helpers in preparation of 2/3.
> - Patch 2/3 detects x86 LMH and enables CXL Regions construction and
>   attach by trimming HPA by SPA.
> - Patch 3/3 simulates a LMH for running the CXL tests on patched driver.
> 
> Many thanks to Alison, Dan, and Ira for their help and for their reviews
> of my RFC on Intel's internal ML.
> 
> Fabio M. De Francesco (3):
>   cxl/core: Change match_*_by_range() calling convention
>   cxl/core: Enable Region creation on x86 with Low Memory Hole
>   cxl/test: Simulate an x86 Low Memory Hole for tests
> 
>  drivers/cxl/Kconfig          |  5 +++
>  drivers/cxl/core/Makefile    |  1 +
>  drivers/cxl/core/lmh.c       | 58 ++++++++++++++++++++++++++
>  drivers/cxl/core/region.c    | 80 ++++++++++++++++++++++++++++--------
>  drivers/cxl/cxl.h            | 32 +++++++++++++++
>  tools/testing/cxl/Kbuild     |  1 +
>  tools/testing/cxl/test/cxl.c |  4 +-
>  7 files changed, 161 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/cxl/core/lmh.c
> 
> -- 
> 2.46.2
> 

