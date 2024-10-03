Return-Path: <linux-kernel+bounces-348833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD67498EC60
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6561C21F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232661465B1;
	Thu,  3 Oct 2024 09:41:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB742AB3
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948477; cv=none; b=fz4dI1XOGO2EJnnu/Co1XML9zAGXAkltfGn+6/LFwgCZ6Neux1wp0aQXNAWEDIsLln8iFOGueYRz8ChX7JJmb8SeyXGNlOCd3cxa5ak4om1DRWIaepwa0UBcT3I5TOq+S4wChZMKP3YMkuauWbBaxlIIXtyjFUCaho6L26oCarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948477; c=relaxed/simple;
	bh=GVKSjbYO1p+/9JJ2RToFePT6oevgjVeFv16AuDDZRLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqNH0U+VMqMA8XhDy3bmM9NK2Bo0MLCcHc6JQYwVdfuex2Hfvgkp8ZTREb8ioePQHwwKPyKEknCauZmkqSfQXDKkrQVqKvtoEv12RYtlTTQK1j2Qy+QSnxLuy1hiBF4/sTsKk3hUj6RrL7OgStfau4ZLv4PsBkRNupIfhu2JS/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CA6C4CEC7;
	Thu,  3 Oct 2024 09:41:15 +0000 (UTC)
Date: Thu, 3 Oct 2024 10:41:13 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2 1/2] irqchip/gic-v3-its: Share ITS tables with a
 non-trusted hypervisor
Message-ID: <Zv5muTP61TRzPfJ9@arm.com>
References: <20241002141630.433502-1-steven.price@arm.com>
 <20241002141630.433502-2-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002141630.433502-2-steven.price@arm.com>

On Wed, Oct 02, 2024 at 03:16:29PM +0100, Steven Price wrote:
> Within a realm guest the ITS is emulated by the host. This means the
> allocations must have been made available to the host by a call to
> set_memory_decrypted(). Introduce an allocation function which performs
> this extra call.
> 
> For the ITT use a custom genpool-based allocator that calls
> set_memory_decrypted() for each page allocated, but then suballocates
> the size needed for each ITT. Note that there is no mechanism
> implemented to return pages from the genpool, but it is unlikely the
> peak number of devices will so much larger than the normal level - so
> this isn't expected to be an issue.
> 
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Tested-by: Will Deacon <will@kernel.org>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Steven Price <steven.price@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

