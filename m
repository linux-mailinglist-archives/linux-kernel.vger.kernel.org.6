Return-Path: <linux-kernel+bounces-171170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB08BE0AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E512871D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552811514D4;
	Tue,  7 May 2024 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGTLWUjW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D38214EC7E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080076; cv=none; b=BdWxeYkXD+f8aSUmlw75mGyjAlZsIUBMyQUTFIkThp7Ti5dRT/mYNRcO3h8oHF0302MNGOREa8uLdQ+L5XTklQ3ynCEB0Jol3TJUJv6KTtp1pgrP0NNAXDLU0BP664d+blVjnHVuj6igBNpHN/MTMo9tLFepRraLPpSeT+dg4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080076; c=relaxed/simple;
	bh=S9ifMyIc/2l0riD80uqAnf/tEvx709LrU9Nf/MYynYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4+37SddqpSdL2E/SQkb+iT1GDXnyOGJICy/6jZPEI6/ZTJbpXz3dcbazNm55XPY3/sJ3eo24ShTsiqt7V6alvu/XscvpgisSuO/ePSqZg3PG8KXWC1ej9+T9RAdRCdaa7WqNm8BayB/SSwtlYYNif7n90/qpsTBGR358S9v4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGTLWUjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03C8C2BBFC;
	Tue,  7 May 2024 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715080076;
	bh=S9ifMyIc/2l0riD80uqAnf/tEvx709LrU9Nf/MYynYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGTLWUjW0Mjcb/7e6mzoWpEdxm76Vj/2h6bM/bKlhMJ3UrBMeKASmCfZ1kXHGJRY6
	 i6mPVj9211oNXFKmfkj71WSAdo2IvypGqS86JiU6vbZHj9R8E7Uno+nQBcpvYX02os
	 zRUSvlK0VmrtLVxOqXLiX/v6206ZEkAiJHxJ372+ImhBENWgwfyUe6opxNzYphq6Fw
	 BrxDpBzVKY8UzazFL8WoOzfzpz2EugPmsJ8rl/6JxGj90NltkHtKof9CNnu91Zd0RB
	 Yl69ZQihTFE08cyf8Ztvlxg4IkXv39KuTpe6r83/QSnlNIljGkgpMEFkhKpEIkqNf3
	 uzZiN/MO0eK0w==
Date: Tue, 7 May 2024 12:07:50 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] arm64/mm: Enable userfaultfd write-protect
Message-ID: <20240507110750.GA22289@willie-the-truck>
References: <20240503144604.151095-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503144604.151095-1-ryan.roberts@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Ryan,

On Fri, May 03, 2024 at 03:45:58PM +0100, Ryan Roberts wrote:
> This series adds uffd write-protect support for arm64.
> 
> Previous attempts to add uffd-wp (and soft-dirty) have failed because of a
> perceived lack of available PTE SW bits. However it actually turns out that
> there are 2 available but they are hidden. PTE_PROT_NONE was previously
> occupying a SW bit, but can be moved, freeing up the SW bit. Bit 63 is marked as
> "IGNORED" in the Arm ARM, but it does not currently indicate "reserved for SW
> use" like it does for the other SW bits. I've confirmed with the spec owner that
> this is an oversight; the bit is intended to be reserved for SW use and the spec
> will clarify this in a future update.
> 
> So now we have two spare bits; patch 4 enables uffd-wp on arm64, using the SW
> bit freed up by moving PTE_PROT_NONE. This leaves bit 63 spare for future use
> (e.g. soft-dirty - see RFC at [4] - or some other usage).
> 
> ---
> 
> This applies on top of v6.9-rc5.

I chucked this into the CI on Friday and it looks to have survived the
long weekend, so I've gone ahead and merged it into for-next/core. Short
of any last minute failures (touch wood), this should land in 6.10.

Thanks!

Will

