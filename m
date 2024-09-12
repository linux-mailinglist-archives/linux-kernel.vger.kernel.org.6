Return-Path: <linux-kernel+bounces-326450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A24497688A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3CF1C23358
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23F1A0BCE;
	Thu, 12 Sep 2024 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="W0Smut2v"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A069918BBB0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142538; cv=none; b=LuSyFPlZcSdG5Y1FmLrpV8UlJHfAiE5wGQtKVC3ReEXI2v9Y7RCo2XUOOt37PsaikBs9+5ajYbCGDtogCSKrDcw9WleQOxNhNY93Cm8fXkV9fY1hGRSkI/MuRUDaClIQmGL+zwZlIhWq24108/9WHvrxQWlsGIQ/hbt2faGsO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142538; c=relaxed/simple;
	bh=2Nng5uEHxNc9C6QzCCi4XNFoEeYvhgGJZmWp7og2LDA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sYwlEZp6F6QIzJOyGUnHiJ+Xezswl3kEw/mzUVuXf3hy93UW77i3G2ZmiyaSo8/MPtPDtVDEu/a4YzyTdUXtUFmB76KCfsq9ognfVtjOQ+D+ZbtfrtFrUHUW73ZtcfiFO4AAUnhtBHN/XS+4d8RuM89WccY3+sFkoDnZ+lvY5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=W0Smut2v; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726142533;
	bh=6g+RS/ylqdCqbB1Q2c6Fgvs+SDVVzoZ5Xt7vtRMzVfY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W0Smut2vTkBBqPUdcFdkT86zl744E6yyGywYsoAUv0jqhYF7DpI3Mk5KtlpvnIR0t
	 JunMv7VZXkbNGgVuneCJUdb/O2WRYba6Cmi9Xfs7BgigeNAgQ3Lr8anSfxYhENH9Wd
	 Cg5F6mFF7whMzzN74iTupN3Cw/D3t9w9+2NfYmOqmlMvqNB0wOE5CJC97H/4cCXXbN
	 c8iHUHmLCcenCJ2xdUUVW/AKRioUryfPhudk74WzDloUfUqb326NcuXjUeGZEXNkpx
	 TKWG3xdT73wEoj4xMxsTC3QNQGM7SEaY+StyS2egFI73M3ix0H105h/gTyUGY42Zdg
	 49BGDjHZqla3A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X4GJj5WrHz4x5M;
	Thu, 12 Sep 2024 22:02:13 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, vaibhav@linux.ibm.com, ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
In-Reply-To: <20240909140220.529333-1-nnmlinux@linux.ibm.com>
References: <20240909140220.529333-1-nnmlinux@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/pseries/eeh: Fix pseries_eeh_err_inject
Message-Id: <172614240960.1297852.3298377330545085248.b4-ty@ellerman.id.au>
Date: Thu, 12 Sep 2024 22:00:09 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 09 Sep 2024 09:02:20 -0500, Narayana Murty N wrote:
> VFIO_EEH_PE_INJECT_ERR ioctl is currently failing on pseries
> due to missing implementation of err_inject eeh_ops for pseries.
> This patch implements pseries_eeh_err_inject in eeh_ops/pseries
> eeh_ops. Implements support for injecting MMIO load/store error
> for testing from user space.
> 
> The check on PCI error type (bus type) code is moved to platform
> code, since the eeh_pe_inject_err can be allowed to more error
> types depending on platform requirement. Removal of the check for
> 'type' in eeh_pe_inject_err() doesn't impact PowerNV as
> pnv_eeh_err_inject() already has an equivalent check in place.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/eeh: Fix pseries_eeh_err_inject
      https://git.kernel.org/powerpc/c/b0e2b828dfca645a228f8c89d12fbc2baecfb7ea

cheers

