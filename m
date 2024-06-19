Return-Path: <linux-kernel+bounces-220700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ED090E584
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B950282CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BACE7E774;
	Wed, 19 Jun 2024 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ft4oiK4a"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD317A158
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785867; cv=none; b=jD5mSZ1XZl8BkLwNkkFoC91/tKXIxQsbhJpudQZAvIqk/wihP1UZ12W0cwPR81NicYmsDrUBHP8/YJrq9ULZM71NvTUaY05Ex/ZYw3ROkxu4Yp8EajDaaT9fy/XgmSGUwCQ3xR8bnoh+dGq4B7VgI7VxnFjLOLFvEl3/TqxTtwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785867; c=relaxed/simple;
	bh=77UgR2xivnvEyej3LXAy8J36h9jQCajS3QuIEZO4cMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hr8wuChXDiDyOse+adDAvCettTz8ugXVvVHeSgpkwrqhEkIRfMmESEZpqSWCyuFR0yjK/5Z6ApDDc6E8ErHLt8yjnI3V/qLQpyO0gMEFn7KEv3wCscWgmOMc5/fk4KLFiNsg73f8W9oqVVTa3UPd99Tw5UD9Mhn6NQ7zjzg+tOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ft4oiK4a; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5E82340E0219;
	Wed, 19 Jun 2024 08:31:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y76HJXVC0076; Wed, 19 Jun 2024 08:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718785856; bh=nrHGuJZQSf6Emehlq57OfsJQaGAjXLph2bW1wMyJzlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ft4oiK4aeUhblaeM8VwL8s8RdoxfkxAPhrHNYfI4XfW/pF0Z4tUeIlzfCzXh90MlK
	 cJ2ghkJLffjBK/HirIPBspxqro3+rLZYVso+9KevU6pDlu6zkg/tB/pJYoye0X3/XS
	 B9Q37pNbEPSanF/nimHrxWeRQvjiH13p+XFwNjVS75sYZlOeB8syTPkt+Jc8MIfV15
	 laIKUKwls5VJKtXAqeTkkLetxXcDKRSf/opljgdQsNo9g9zF5vcERKM/H4biEmv4jy
	 qCG+t4++sSsXQJavSlXF/6eZ9N5BOhDxmGsyiM5/82mCau/gRncHsM1M0yw+AGrN9X
	 7VQK1NPAUNKhbzR3uJfKn0u9ntmPbgWRrvBUaIwk9V39bxvklWuwFuKIxxMwkqdhcA
	 SnatbAERNpq4wFRX+0BoKQqski1vAsAVLdhux6BaEhasQJcS4MEs9103OF9qbNg+Hx
	 kWRohsrH37j3KIx8n68ejeUfX0E1H5xLR0s3TTNwEfW+eVoihiTYFw6svANr9fZyOi
	 KHq4ehUpBymZgw+NgZVTaGoy6KXFHEdGDbrmAUir5qKZVeVrDPx4SixCn6P+ltWzdH
	 4kyVK2oMryDX4oCpu8fEzigEQwyCigDU6uLkOTHVKsBZOpVPngnNvcJges68BeHSg5
	 54jd7ICAvKce4ekJxS6II0Ig=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E786E40E01F9;
	Wed, 19 Jun 2024 08:30:44 +0000 (UTC)
Date: Wed, 19 Jun 2024 10:30:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com, elver@google.com, glider@google.com,
	nogikh@google.com, tarasmadan@google.com
Subject: Re: [PATCH v2 0/4] KCOV fixes
Message-ID: <20240619083039.GAZnKXL8euon1-hHIR@fat_crate.local>
References: <cover.1718092070.git.dvyukov@google.com>
 <CACT4Y+Z=U+Y8gKBgaU76=zg=rAdq=AQ=epAq+RxDfdXsaqO_0w@mail.gmail.com>
 <CACT4Y+Zq3t2JXEbGDzYU61Rs5KH3mhCDiZ4GP9OacKuyocnYHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zq3t2JXEbGDzYU61Rs5KH3mhCDiZ4GP9OacKuyocnYHQ@mail.gmail.com>

On Wed, Jun 19, 2024 at 07:20:56AM +0200, Dmitry Vyukov wrote:
> Or is it OK to take this via mm tree (where KCOV changes usually go)?

Be patient, pls, you're on the TODO list.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

