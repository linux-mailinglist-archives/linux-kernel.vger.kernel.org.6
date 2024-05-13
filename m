Return-Path: <linux-kernel+bounces-177808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DE08C44E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F041C22E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E17C156971;
	Mon, 13 May 2024 16:14:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8D8156863;
	Mon, 13 May 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616851; cv=none; b=BJ/S2XkLQ4P/oi8LRnd8bStrUwowu8VkdDUHEBz91BWQGfut85goQdaiBx2JKRL3yHaKUx62g5uFNqKwc2k9hgDpSxes5KmNPYu7IZG62HkJVgI7K+U+zVfXn6Z1BjOH25J+UbymHgiTPl5R/5/Pvi7gjhg3U7kj5AotjuFdjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616851; c=relaxed/simple;
	bh=tId/JdnTjdfMk77QxFfO67QzK/Kx7mUwVft12OXxf1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVNk5W7+raqH0eKWJ0l+q+ALlBGtDu/7x8KhSk9qRvXDtoK5uLMJeXQwn0A7rs7MYR++WxeJ1oc9mtQLsye38H4F5heg1cUvVQYn8q/wQkkg4LheKRugIcSDA1b+LQV6K3I6cb3ZCu4GFRNoXXj91I8KB/Mg2F0bJv6oTZTlNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3765C2BD11;
	Mon, 13 May 2024 16:14:07 +0000 (UTC)
Date: Mon, 13 May 2024 17:14:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Subject: Re: [PATCH v2 06/14] arm64: Override set_fixmap_io
Message-ID: <ZkI8TZmEKwrEKhe_@arm.com>
References: <20240412084213.1733764-1-steven.price@arm.com>
 <20240412084213.1733764-7-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412084213.1733764-7-steven.price@arm.com>

On Fri, Apr 12, 2024 at 09:42:05AM +0100, Steven Price wrote:
> Override the set_fixmap_io to set shared permission for the host
> in case of a CC guest. For now we mark it shared unconditionally.
> Future changes could filter the physical address and make the
> decision accordingly.
[...]
> +void set_fixmap_io(enum fixed_addresses idx, phys_addr_t phys)
> +{
> +	pgprot_t prot = FIXMAP_PAGE_IO;
> +
> +	/*
> +	 * For now we consider all I/O as non-secure. For future
> +	 * filter the I/O base for setting appropriate permissions.
> +	 */
> +	prot = __pgprot(pgprot_val(prot) | PROT_NS_SHARED);
> +
> +	return __set_fixmap(idx, phys, prot);
> +}

I looked through the patches and could not find any place where this
function does anything different as per the commit log suggestion. Can
we just update FIXMAP_PAGE_IO for now until you have a clear use-case?

-- 
Catalin

