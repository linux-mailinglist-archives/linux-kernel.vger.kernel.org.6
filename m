Return-Path: <linux-kernel+bounces-302753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 104559602D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7892282B80
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F91D19DF61;
	Tue, 27 Aug 2024 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="r4mzUSBI"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFEC19D074
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742923; cv=none; b=EonSB8WFArszgh3Nuz1zUC8ieS8QLzxYZeSKG3QIkGru8Ru5pT7MCbWAuxbDNN40DvTs/6Fmxo9Q98JzNg0fu5rt8bxWNVQYqSoEi0ySmnnBR7Rz9rPSeRRA43Nt+FqSwnTF+YJKqC38lelw1aZTuEycSaORXMdlBdWjhSC5XqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742923; c=relaxed/simple;
	bh=5Dbcg+Gp13+Cjf9y5UUNKeHqnFi6vQh23zjFHhmtPmI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DzWfQBHjONxlgdQjg3n91mf9m4sMscg4w7qMv0oAqabt+1NLOR8cTFrQ688OL/xNLgIUn/s7/qTYtNvpTR220aeYjlDUlWuq2yB8y+LZiJXVvMjMs5dH9DwvmTXGPYAqNtl5CKKUO2QORkWnr5m4Jxs1sw0yDGrJm0hROehXvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=r4mzUSBI; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724742920;
	bh=CSeHedfqR6MiSse7v/9PJWgnIs7v/GPZDhsBlXQ0e1o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r4mzUSBIh+g6lU4imkIbD0jg8Dc5fQ6CmrVAxV17sJYgp6Ga4NdlBp7guomSM+8H7
	 BbrMgRF6DGLiVIyPlo1+zDyzdPAWcFbebWTjx/fsIcGOwOzf6uwH0huXYyrmrqHYFZ
	 3VdcYiAIqd0dxFOds8oaueU6x82quhyuRvfpw9NdgUW9BrXCrJc9B6KAehfyRhCgof
	 7kApMBTBoEzDBLck+Q10Dv/9ksMJAt+vYT0Wl2Piu9/lNtY8eCJj+574wl9MFhweyG
	 wRv37801q/qCcQtHUKPXpVkvVwCjYL4Lt8nu1YXOB9Zrz/8/Sm1/NSEUbnpAY1Oz+G
	 QqrO9Maj7XKlw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WtJj413Yjz4xKW;
	Tue, 27 Aug 2024 17:15:20 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <45c3e6fc76cad05ad2cac0f5b5dfb4fae86dc9d6.1724153239.git.christophe.leroy@csgroup.eu>
References: <45c3e6fc76cad05ad2cac0f5b5dfb4fae86dc9d6.1724153239.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/vdso: Don't discard rela sections
Message-Id: <172474289343.32718.13009497655223214357.b4-ty@ellerman.id.au>
Date: Tue, 27 Aug 2024 17:14:53 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 13:28:07 +0200, Christophe Leroy wrote:
> After building the VDSO, there is a verification that it contains
> no dynamic relocation, see commit aff69273af61 ("vdso: Improve
> cmd_vdso_check to check all dynamic relocations").
> 
> This verification uses readelf -r and doesn't work if rela sections
> are discarded.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/vdso: Don't discard rela sections
      https://git.kernel.org/powerpc/c/6114139c3bdde992f4a19264e4f9bfc100d8d776

cheers

