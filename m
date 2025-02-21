Return-Path: <linux-kernel+bounces-526037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17B8A3F90C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F91701E27
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9EA1A23B7;
	Fri, 21 Feb 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJgfNl3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC058632E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152112; cv=none; b=YrOko3DSVpII3wgRUGj2dIhh2Bfz7+dkj7y4lJ6WUVm7W7vNkep8KI53bLO7l6BUhuneQ2O3j0/trxRA8oK0Btn31fSMyAEuWXgureLeOEMQ2HgGh+FNPDzPsku7WOWc+Pwv3nYWyv+RVo7IMi+v9AFqbvibP/U46uRS9q+jwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152112; c=relaxed/simple;
	bh=HFbveIpxBrHCezKac0bPWSUzZSYqbqkw6nidRl1Irxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvExM2GP5T3fU4qZ7GSSH+lQiOnM5SYTlxFOlQYkxBS52gQ6tSqZzhIm5NQZ7zWkjg9EPX2LVJPsaOeXA/8q3C+4XVPQDIcZNJPrhLul7vIDjyKTt3za9rBL93LrMPCesDZRFdK+xpsW+0lp7jc/YIF/KUZT8qhZmHybwh4KdWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJgfNl3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23FBC4CEE2;
	Fri, 21 Feb 2025 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740152112;
	bh=HFbveIpxBrHCezKac0bPWSUzZSYqbqkw6nidRl1Irxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJgfNl3Sv/k0lydbFfAJYgv48UkwUsory7TtVR7CJC2KaUy1qnINNOVZQNyroUwIo
	 4gCbF80U7wG3xjOoA3a1x0W/aaCPasW6C15q+rv2vkLFXGQH0Jzc7R80BrLAkfil4g
	 bAlfxN3obgLbfIXOYbxTU31OZYYfTXK23XDduDlCRAlEDywHoSsO80l97q2axSx/5v
	 Gk9K9uj/rYb/+c2amOJzh9MoOnkEWIyXezml8hqnqxtzH6JYiyraS0sY9KukmdnohL
	 vq6LFXxcDtuPVqarCPx8m2IKzBaHcDfxVxJ1eloXdL/smXMkl4LII1kc0fSgYGSASY
	 5WeNkluJ8/1xA==
Date: Fri, 21 Feb 2025 15:35:02 +0000
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
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
Message-ID: <20250221153501.GD20567@willie-the-truck>
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <Z7YsqO7ykGgcBFEI@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7YsqO7ykGgcBFEI@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 19, 2025 at 07:10:32PM +0000, Catalin Marinas wrote:
> Will, Ryan,
> 
> On Mon, Feb 17, 2025 at 02:04:13PM +0000, Ryan Roberts wrote:
> > This series contains some fixes for hugetlb on arm64, and is split out from v1
> > of a wider series at [1]. While the last patch is technically targetting core-mm
> > and is not directly related to arm64, I'd like to to go via the arm64 tree so
> > that the wider performance improvement series (v2 to be posted shortly) that
> > depends on this series doesn't have to be robust to the fix not being present.
> > 
> > I've included maintainers/reviewers for all the arches that are (trivially)
> > touched due to the API changes, hoping for some ACKs.
> 
> These fixes look fine to me and I think we should get them in for 6.14.
> I think Andrew was ok with them going in via the arm64 tree:
> 
> https://lore.kernel.org/linux-arm-kernel/20250205235219.3c3a4b968087d1386d708b04@linux-foundation.org/

I think the diffstat looks worse than it really is, as the arch changes
are reasonably mechanical. I'd like to let it sit in next for a few days
though, so I'll pick this up once we've resolved my comment on patch #2.

Ryan -- did you find all of these issues by inspection, or are you aware
of anybody hitting them in practice?

Will

