Return-Path: <linux-kernel+bounces-334176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C2397D37F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A42E2861A2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C813A26F;
	Fri, 20 Sep 2024 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="BC58+kQU"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352CE555
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726823799; cv=none; b=KAWHkSzei5FwLo2SDfodJ3rwyE1PG40gulLGJ30FjVhYbfFjvJ81L1s9zNaVwUj8v90WeSbSToiyaN9RuREQ5yGWOtCoj226krYHGJEW3LCggx4zBfmNKRVETyE0Dz9x/P9JDBPUOdI7Plpbu5MaJdHFQuv9j22iZjcnx0XID74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726823799; c=relaxed/simple;
	bh=+OK2RN/HhGbe98BfImomkLcmPOI63V3fyL3D/3hJWYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ge29yFzY7tNDVKFbHlHGirB79eUxkzqTMGO9vVdfC6csLxSH8VF32qF8bX+HsZ/P7K//8MNzRJMkN790WRFD9qMQXbKZzD3Bt+JTEt8/GDPRCR+R3/YyJ707A79Uerq7PTKiNM2Gn0DMwAVn/ORoqn3Ft0mC8LLMu6atahr5nEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=BC58+kQU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726823795;
	bh=IA6yN3inZfKzjRZ8fVnZb2zPyxLvv/G18bjmPkyeAS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BC58+kQUHYvhPZ1Al97xWzc5nlJVz9/kxlqWQ924vHUxqa9sNhzS5x4DvnsSOTazK
	 8cVdXcJL0b+IS/S4JY4VlkXGb3ORVwG1f6IhEnKAwmaRIzy0ex3LXbEueEZ+M9WkCo
	 /FuLjdvknPC0BGbvi50t9qU+tXQdQjcUEHJyws1oaNZ2O8R4oje6s+SFl6TeOLKB5B
	 LHZBreNeDVCJ0XtkKwv6ed7nhSBQOINmpmLaFMKijRepN9KbjvAdtLt5tkJ2GtPO75
	 xMVvDtzTGPoxaWAjCE/SoEleQDPnItf9b5amX2MMNZYdihXcBOMEp2x6cqq2SU1kZb
	 Z1kBDIQ/HCyGw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X96Ft01KDz4x7B;
	Fri, 20 Sep 2024 19:16:33 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <aded2b257018fe654db759fdfa4ab1a0b5426b1b.1726772140.git.christophe.leroy@csgroup.eu>
References: <aded2b257018fe654db759fdfa4ab1a0b5426b1b.1726772140.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/vdso32: Fix use of crtsavres for PPC64
Message-Id: <172682376257.64942.9485115063969411360.b4-ty@ellerman.id.au>
Date: Fri, 20 Sep 2024 19:16:02 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 20:55:57 +0200, Christophe Leroy wrote:
> crtsavres.S content is encloded by a #ifndef CONFIG_PPC64
> 
> To be used on VDSO32 on PPC64 it's content must available on PPC64 as
> well.
> 
> Replace #ifndef CONFIG_PPC64 by #ifndef __powerpc64__ as __powerpc64__
> is not set when building VDSO32 on PPC64.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/vdso32: Fix use of crtsavres for PPC64
      https://git.kernel.org/powerpc/c/699d53f04829d6b8855ff458f86e4b75ef3e5f0c

cheers

