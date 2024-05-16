Return-Path: <linux-kernel+bounces-180644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 039A38C7138
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68ADC1F22E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247E11426F;
	Thu, 16 May 2024 04:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="OUNZLTRh"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8195107A6;
	Thu, 16 May 2024 04:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715835241; cv=none; b=Cpo4YOuFQLREW8BQ/eIqD/atPp+iWpY+wb6dt9Fx46jATB1tYBE0SGB7cGOKGJzawGzgpH9TlFBbJDcyZn8zgmzhApslN8ibE8hukdajZmeOvw80L39pB3acsfesj7IM6M3pzzFl+qjcS5gwwFRU3R1ww6kYUzdDiO8BMY1TJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715835241; c=relaxed/simple;
	bh=aDNJiFP0Fer0QH+I23pdQYOry2ONz/yZIcmZJgn3HTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=busoSFxzkr6F/6RB7XDp5/LRN64w74z+iR0oqmRuOOLVpOLS2waD3gNboREG/lqFzOxMd+RDl9FX72AkfX9CaDMFzTbcn5O2V+lzj4Wjmrcy/LW3C9zDWuuBL5sIcsahY4iZvl+H5LaPFTFm4RxKS7Tp6RMplVY4UOGI1aQ8Gro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=OUNZLTRh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1715835235;
	bh=m3B6pGxVJXAV9NrNGs8JIZ52KN55fQeOYZ6IyLFS/7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OUNZLTRhwGC6IkMsHHS1uFhQRNsV3kBp5lTXh/utKzcmhIrlDNQwFVNrU+6dboVEP
	 JAzjsl4aQBPZX+og2Jq+XI1ZJgFDZaY7WhC5C/ZIXn/taSzMeTFdaZIP6JUwEoYHSt
	 2AVdJFyuONp2EfXjPo9eKZtz6rkXnrLm28algrYaqPsotuRLoEqAM5fGmGg3D5v0Z9
	 fqVbyh9LPYtSBa2ZYp2tYmL0ccBazO+uTpZ5LuhaDWHcr/91bY4P7dtiIpJRBq0uBu
	 6Su/HpNL3xEc3sf+P4fDzmUkjNjpo68JpsmW9iqsARA/3JpndVNq0FrfT3gQa9fbsQ
	 1kyZOFMmRFtjg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VfyRR1dqQz4wby;
	Thu, 16 May 2024 14:53:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, leitao@debian.org, nayna@linux.ibm.com,
 appro@cryptogams.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ltcgcw@linux.vnet.ibm.com,
 dtsen@us.ibm.com, Danny Tsen <dtsen@linux.ibm.com>
Subject: Re: [PATCH 1/3] crypto: X25519 low-level primitives for ppc64le.
In-Reply-To: <20240514173835.4814-2-dtsen@linux.ibm.com>
References: <20240514173835.4814-1-dtsen@linux.ibm.com>
 <20240514173835.4814-2-dtsen@linux.ibm.com>
Date: Thu, 16 May 2024 14:53:54 +1000
Message-ID: <87a5kqwe59.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Danny,

Danny Tsen <dtsen@linux.ibm.com> writes:
> Use the perl output of x25519-ppc64.pl from CRYPTOGAMs and added three
> supporting functions, x25519_fe51_sqr_times, x25519_fe51_frombytes
> and x25519_fe51_tobytes.

For other algorithms we have checked-in the perl script and generated
the code at runtime. Is there a reason you've done it differently this time?

> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
> ---
>  arch/powerpc/crypto/curve25519-ppc64le_asm.S | 648 +++++++++++++++++++
>  1 file changed, 648 insertions(+)
>  create mode 100644 arch/powerpc/crypto/curve25519-ppc64le_asm.S
>
> diff --git a/arch/powerpc/crypto/curve25519-ppc64le_asm.S b/arch/powerpc/crypto/curve25519-ppc64le_asm.S
> new file mode 100644
> index 000000000000..8a018104838a
> --- /dev/null
> +++ b/arch/powerpc/crypto/curve25519-ppc64le_asm.S
> @@ -0,0 +1,648 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#
> +# Copyright 2024- IBM Corp.  All Rights Reserved.
 
I'm not a lawyer, but AFAIK "All Rights Reserved" is not required and
can be confusing - because we are not reserving all rights, we are
granting some rights under the GPL.

I also think the IBM copyright should be down below where your
modifications are described.

> +# This code is taken from CRYPTOGAMs[1] and is included here using the option
> +# in the license to distribute the code under the GPL. Therefore this program
> +# is free software; you can redistribute it and/or modify it under the terms of
> +# the GNU General Public License version 2 as published by the Free Software
> +# Foundation.
> +#
> +# [1] https://www.openssl.org/~appro/cryptogams/
> +
> +# Copyright (c) 2006-2017, CRYPTOGAMS by <appro@openssl.org>
> +# All rights reserved.
> +#
> +# Redistribution and use in source and binary forms, with or without
> +# modification, are permitted provided that the following conditions
> +# are met:
> +#
> +#       * Redistributions of source code must retain copyright notices,
> +#         this list of conditions and the following disclaimer.
> +#
> +#       * Redistributions in binary form must reproduce the above
> +#         copyright notice, this list of conditions and the following
> +#         disclaimer in the documentation and/or other materials
> +#         provided with the distribution.
> +#
> +#       * Neither the name of the CRYPTOGAMS nor the names of its
> +#         copyright holder and contributors may be used to endorse or
> +#         promote products derived from this software without specific
> +#         prior written permission.
> +#
> +# ALTERNATIVELY, provided that this notice is retained in full, this
> +# product may be distributed under the terms of the GNU General Public
> +# License (GPL), in which case the provisions of the GPL apply INSTEAD OF
> +# those given above.
> +#
> +# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER AND CONTRIBUTORS
> +# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> +# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> +# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> +# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> +# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> +# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> +# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> +# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> +# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> +# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> +
> +# ====================================================================
> +# Written by Andy Polyakov <appro@openssl.org> for the OpenSSL
> +# project. The module is, however, dual licensed under OpenSSL and
> +# CRYPTOGAMS licenses depending on where you obtain it. For further
> +# details see https://www.openssl.org/~appro/cryptogams/.
> +# ====================================================================
> +
> +#
> +# ====================================================================
> +# Written and Modified by Danny Tsen <dtsen@us.ibm.com>
> +# - Added x25519_fe51_sqr_times, x25519_fe51_frombytes, x25519_fe51_tobytes

ie. here.

> +# X25519 lower-level primitives for PPC64.
> +#
> +
> +#include <linux/linkage.h>
> +
> +.machine "any"
 
Please don't add new .machine directives unless they are required.

> +.abiversion	2

I'd prefer that was left to the compiler flags.

cheers

