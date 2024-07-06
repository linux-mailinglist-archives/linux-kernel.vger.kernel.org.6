Return-Path: <linux-kernel+bounces-243400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924ED9295CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 01:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31DA1C21062
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC8213C697;
	Sat,  6 Jul 2024 23:13:09 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827C4D9E3;
	Sat,  6 Jul 2024 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720307589; cv=none; b=ruVNxASkZTLRBzHNl2rwnL6g000VFqVYermSjTVnVxNSiZe/KkQvSGiVlrPi5KisHASLwqONYDHmhe2/G+mtf96oB2IBsqfP4Zqiqpy6TmYE/Ctu2C2WYuS4SKC4kRrLuMee4L2SgbMnIB5ARn3adAEbM6oKDctZxMF1HXWh3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720307589; c=relaxed/simple;
	bh=544ZRQ1vobRwkWvYQwOUHCUhgftqjA6qesBSXj73EaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rOvxdpWkhj7FX2RVW+XI5BuRuabDy9eYCvZYTx+OSs0O/D+IyE7hOnIkrRvWBLECj8MT4UVG+hWagS0kdoMOF2UlxT6UG3BbZwjpdAv9XnD5yKD1MbmXAOMUTGZGh+FI2oelg20SC0xNzaaI+GsqDoCqH+tCJEbgv+5RCklZXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WGmQ41lL0z4xPf;
	Sun,  7 Jul 2024 09:13:00 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Scott Wood <oss@buserror.net>, Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240615-md-powerpc-arch-powerpc-v1-1-ba4956bea47a@quicinc.com>
References: <20240615-md-powerpc-arch-powerpc-v1-1-ba4956bea47a@quicinc.com>
Subject: Re: [PATCH] powerpc: add missing MODULE_DESCRIPTION() macros
Message-Id: <172030740426.964765.16456298836722102264.b4-ty@ellerman.id.au>
Date: Sun, 07 Jul 2024 09:10:04 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sat, 15 Jun 2024 10:06:18 -0700, Jeff Johnson wrote:
> With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/kernel/rtas_flash.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/sysdev/rtc_cmos_setup.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/platforms/pseries/papr_scm.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/platforms/cell/spufs/spufs.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/platforms/cell/cbe_thermal.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/platforms/cell/cpufreq_spudemand.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/platforms/cell/cbe_powerbutton.o
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: add missing MODULE_DESCRIPTION() macros
      https://git.kernel.org/powerpc/c/9c5f64734f895528128605e2f3b170d220be086d

cheers

