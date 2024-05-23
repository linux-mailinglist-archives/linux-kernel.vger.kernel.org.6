Return-Path: <linux-kernel+bounces-187621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37658CD560
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9F7283D59
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF20F14A627;
	Thu, 23 May 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YSNGNko7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08017FBD2
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473256; cv=none; b=Hsjm77I63oqXQfZQ77X09elJo239NcgFuegL9MNmvtDLw8u9SMS5gb3nSGJrK4bxSBiy1BYbL+fwvYwdQwtw2AzhzoKudkmCjYCD3rkUNQyW8ZiUZsO3B2tE8CnfYIAm8npz71XNs+QJyr6L9sv/SY6a6Ee/Dw4e5ZXgeSX92cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473256; c=relaxed/simple;
	bh=GXB683gQC5Qzq9ZnXze9zXEmAPftWpNWotP7t/rMGxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNvRnewIeXcLw/fiXQPQ9cYHXmzaZvo3gBqzmQ9I5RxavS6XNtC4XzZvq6qzDvWGDnkiD67yteg9B4pZ+2HB/Degco23GEeMOf73iUoLJ242zDZ0sCo4QLc0XbrvqGMKkwoP+lWQghgx5sjZ0beslgzFcdREYp1vWyE5GdXJ8wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YSNGNko7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6B13F40E01E8;
	Thu, 23 May 2024 14:07:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ReU00yeVSuf2; Thu, 23 May 2024 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716473247; bh=qXfYRFhu2JIkgeWZDMQpdFw4OPOQczwivSNHPDfIb/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSNGNko7IGS7Iwb/IMz2WbftiPUUZsi34JmWbuw9cF/vczn/vm8XBrBYzd6pGPT2M
	 YImW1p8FG3vlC1Xf8Z0cAABBywLWdX/JZ6ifMWLyrZrqXdipCloCgH4/n7/Z+zJqx4
	 UJaErATL0eF+Bb6HgUvhb+eu4VQRo2HlYojKzDft1zg/G7qyF96rsQPPl4R4+6EmfH
	 uBS1RN18X2g3c+JjqpriuHArvNtLTQn74JpORYMQLt3tKeOBdT5n/RLRLzKE3olxs3
	 aJb+Kvk8kYDR81MPiy2BeAYDNhvrEKT1av9ldoDuH52sEWXph7eF6YL3LGkKyFveS2
	 Ixa4To0Xlvhl2pl3zYtXQtasJ9WRkrgsP5Z6PFp4wK55hSDZN61O/GOGIpIn4Bs2yr
	 JNhWhu3mWTgxs8UDrqDpr+8PbI3wgwdRv2MeyjqQrm/rzWiTtJBuV5MtK3WtJa1A42
	 OhOok4/xSvpXMkf7BtAcnC8cO/rc+7FoxnISTGFW/yNTGFs8ZNC+58U8dlKVwLc8Sz
	 vREojVz6bstwAcDS2ethJ3b3l88VaIiiaUEL379iIhGqpWLz/Zwj5ZtDRWwcVGb8NO
	 xwnUOieenhIbgNYvzp5mnmKKAshjRISXS9kqdHTYT3gO9NY8qxzyes9RIWg55k5ykZ
	 5DYZCdF6z0lxJDYgeeYl8iZw=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 03FCC40E0177;
	Thu, 23 May 2024 14:07:13 +0000 (UTC)
Date: Thu, 23 May 2024 16:07:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Andryuk <jason.andryuk@amd.com>, Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] x86/kernel: Move page table macros to new header
Message-ID: <20240523140709.GCZk9NjWBeJQ4Yqa9P@fat_crate.local>
References: <20240410194850.39994-1-jason.andryuk@amd.com>
 <20240410194850.39994-5-jason.andryuk@amd.com>
 <87pltcfx2o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pltcfx2o.ffs@tglx>

On Thu, May 23, 2024 at 03:59:43PM +0200, Thomas Gleixner wrote:
> On Wed, Apr 10 2024 at 15:48, Jason Andryuk wrote:
> > ---
> >  arch/x86/kernel/head_64.S            | 22 ++--------------------
> >  arch/x86/kernel/pgtable_64_helpers.h | 28 ++++++++++++++++++++++++++++
> 
> That's the wrong place as you want to include it from arch/x86/platform.
> 
> arch/x86/include/asm/....

.. and there already is a header waiting:

arch/x86/include/asm/pgtable_64.h

so no need for a new one.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

