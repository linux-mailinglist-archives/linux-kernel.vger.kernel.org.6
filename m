Return-Path: <linux-kernel+bounces-331690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B297B011
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8552B24625
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BEA16A95B;
	Tue, 17 Sep 2024 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="mPPjWi5w"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E795672
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726575798; cv=none; b=I9YR78FnKt39SPHoIxNrvJk1mDsktQpDjg8eA58F/zP6fww7mfQkLbTBSJIY3N6AhJdxLVVHNqAT2ilVzvb0yrGf2m0mi1p6DgSIml+/XimrL68h7IiwMaFBRFO5kvQMeXThI1j3RRX9UeTmEZIBkSnhYYp3fV9VCemLfhD2Wj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726575798; c=relaxed/simple;
	bh=49eDhuRr0xDx9AYny2lLaP9VUQaGVE0OcXvSHBe6f7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ISq0yeJVmC4jsHdJ9rT1z2VoxZP/ACckFyj5BSVBgUCYNifemcELjau2bm6cDm38OfYmwQwLpz7D/Vjn/pSeph4+JxlXfS0Ly9rE4KvrPnwgzCOdbsoMly84e7+XZNwG4Oz2ZNnjTZFYoBUKX5PLaFa8mZLOvOLKm4yK3UCzjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=mPPjWi5w; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726575793;
	bh=0bi3sJBjfynW3WRvY/YGmOO8QFbRlU3vuAc8jYbMyEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mPPjWi5wVA+k+8lSVo+2j+RhsB6zuSt6/ZF1HThWEveQsbr9FbAUpIIqkIPO7nrVT
	 i6FS3RKhMTvyYsGcwvYkUhVE9hD9IsbFk7/qYhdhB8fuNh8PmfyX7GrL8XiI4oimyn
	 FckbwCUMSfdD3WyWaCa5aXO/77DJwa6k4fpwTYdftSHoAVKUBsLEAq53RodwskOZNK
	 /SwRsyXz70TQrEPuZfZqHTp245LG+oIiD7ryJ+F92hXgJI8S6yw/COom0qgz0BksXZ
	 cAjwZGLfqo4EGuLPjsY5Ngsfoedib00BBnp2hXRe6+sW4erpYIAHF+VbLazsOJsg/C
	 bAyHLjT+pA73g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X7LXd07qVz4wd0;
	Tue, 17 Sep 2024 22:23:12 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240827063651.28985-1-mpe@ellerman.id.au>
References: <20240827063651.28985-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] MAINTAINERS: powerpc: Add Maddy
Message-Id: <172657576220.2195991.5150370893686687282.b4-ty@ellerman.id.au>
Date: Tue, 17 Sep 2024 22:22:42 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 16:36:51 +1000, Michael Ellerman wrote:
> Maddy will be helping out with upstream maintenance, add him as a
> reviewer.
> 
> 

Applied to powerpc/next.

[1/1] MAINTAINERS: powerpc: Add Maddy
      https://git.kernel.org/powerpc/c/b77d36bb9a3de774950ba712a0e47f9d33c6f6d7

cheers

