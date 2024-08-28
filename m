Return-Path: <linux-kernel+bounces-305646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5530D9631AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACDE1F227F5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2191AC456;
	Wed, 28 Aug 2024 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xDFnR12P"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC48E17C223
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876493; cv=none; b=Gd10LGfZQFsSeGRFz4No3BCBgI3xgEtsbM07f8VcSXGX/WtapbGokjGuHc7RdEfDUlruouW5kZTMykUdlHSP+OdL5rWwk/q8ID6uWtUfqU1bipQ4WvQzRRpqGbbI6IJ3zGffQjuYkdSGMWG9wxCsNdVPo4KxxzXElVQSXsVFRiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876493; c=relaxed/simple;
	bh=rhazEJ18zxL7GKKEYCY2DhRXiQx3Zo44AezMhmDRL+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRYB+vLttDpLNSvhpaqX4wJ3B8gt+xEeEP1vDDzPPayqMDO2nS2XzmLL0x+gW3je1pKXmnYnvJD0JHRO1S32MCutXyL5svGcYNFFaL6VtyFGIFel6//AQ350z+kcggj0iNK+fVTG6fA9G39/LbvD4MgoQKsY59jxezye+mgRIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xDFnR12P; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Aug 2024 20:21:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724876489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3Xm/6To/0+QIxO47lLdLDJqf3M7/P3VQuUcWXRAtwM=;
	b=xDFnR12P4UZuPbFMRnDS1mOuh500SWCcLTF1T1+dfD+1CiLSGfknLgUYsNMQlyj7Y+Vp5x
	I0KbpElMYEbGqnYg1eQUS5XhOAUycQDMSTvzW9pyH4Lx6Ot/QSdqjxDLNWwp1dZvtbA/50
	OgYG+Fs0RH1ZsZTl7D1K96hckCmICrM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: D Scott Phillips <scott@os.amperecomputing.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Rob Herring <robh@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-kernel@vger.kernel.org, patches@amperecomputing.com,
	Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2] arm64: errata: Enable the AC03_CPU_38 workaround for
 ampere1a
Message-ID: <Zs-GwkIMauATQ16A@linux.dev>
References: <20240827211701.2216719-1-scott@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827211701.2216719-1-scott@os.amperecomputing.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 27, 2024 at 02:17:01PM -0700, D Scott Phillips wrote:
> The ampere1a cpu is affected by erratum AC04_CPU_10 which is the same
> bug as AC03_CPU_38. Add ampere1a to the AC03_CPU_38 workaround midr list.
> 
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>

You'll probably want to cc this to stable, that can be handled when the
patch is applied though.

Acked-by: Oliver Upton <oliver.upton@linux.dev>

-- 
Thanks,
Oliver

