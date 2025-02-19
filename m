Return-Path: <linux-kernel+bounces-522285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78767A3C848
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50377167A59
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C65E21A952;
	Wed, 19 Feb 2025 19:10:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D821C219A9D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992241; cv=none; b=ggnBNUEFYQ5H0awK4OltLtPoTSYVPLg/sChUyh062x3vxN4plTMrp5zAsvjNVPJHNSU7FahAaOK0h+n0GOBs1qTEIsHLT9DKvXe3VSVAFGpo2uYgQcFpRePklZtswOo96U3WlYdBqsV+hDL9tvB4Yc/pQCnQ7WaVp2aR6qECIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992241; c=relaxed/simple;
	bh=Z9cLkiauDnDbGh8BMiSRBy/qw0h/KHphZE2Usp5X7OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGulx7+l5cuAFSsL/gdOicdUqV+IOes6SbAgszGkODNP4mnLJgVbtwjUCYnHTfw0fGAW3wVHRvJOsysd1jKtwEXYUFHGAi9knLIYAY6QOw1XVq59VnqIZiXBX+5T3XPYe7CNG0WclKCglix2v+V2oWATGCusDg7SzH6NgtNN53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6982CC4CED1;
	Wed, 19 Feb 2025 19:10:35 +0000 (UTC)
Date: Wed, 19 Feb 2025 19:10:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Dev Jain <dev.jain@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Fixes for hugetlb and vmalloc on arm64
Message-ID: <Z7YsqO7ykGgcBFEI@arm.com>
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217140419.1702389-1-ryan.roberts@arm.com>

Will, Ryan,

On Mon, Feb 17, 2025 at 02:04:13PM +0000, Ryan Roberts wrote:
> This series contains some fixes for hugetlb on arm64, and is split out from v1
> of a wider series at [1]. While the last patch is technically targetting core-mm
> and is not directly related to arm64, I'd like to to go via the arm64 tree so
> that the wider performance improvement series (v2 to be posted shortly) that
> depends on this series doesn't have to be robust to the fix not being present.
> 
> I've included maintainers/reviewers for all the arches that are (trivially)
> touched due to the API changes, hoping for some ACKs.

These fixes look fine to me and I think we should get them in for 6.14.
I think Andrew was ok with them going in via the arm64 tree:

https://lore.kernel.org/linux-arm-kernel/20250205235219.3c3a4b968087d1386d708b04@linux-foundation.org/

-- 
Catalin

