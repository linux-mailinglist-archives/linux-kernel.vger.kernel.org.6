Return-Path: <linux-kernel+bounces-260965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2A593B104
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C2FB22D00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4002D1581FD;
	Wed, 24 Jul 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="j7+6wc+o"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6F6A039;
	Wed, 24 Jul 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825060; cv=none; b=LVPz2eTWtr3VfLkWuWaQhoSr+0wMFYH0q4B1bhtVnusXu+ftUcaSDz8Ut4swX1roHJtPZJrUG06D+hCWbS3qGz9xZcwCydPGz//qs9opQ35dGetLfJ58+wji5mHUVQzS4AG2E56VNy0FX9pJ7LiIZh0YIl/9xVYxtkCYRMEg5v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825060; c=relaxed/simple;
	bh=PqvZ44tvj3p31YMwQcFF+FFz38rl5gmSflhNBduG30s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FHFHVEPphYEWEx8AEmtNfiWGMINaoiWWWEFo56hUArY9Xwlc7SIW9kQwPvIm89t/w7s1cwsxp+6OnlVqb/s9j8IgcuRa8No4Fsjvp0jtfa9P1VUh6BSEbh3IUJJ+J8xuj2A0sDDBZ7UELAZlpGkiX4AjmrfHwrJPUe6hL1A0agg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=j7+6wc+o; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721825054;
	bh=axqxpBEodghaFEC84iaFxG1Fg6FcJm7D5vj0S1d76bc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=j7+6wc+o2TsweX3Z5PfOS6gaprPUl8dm68CUZZ0KGwcd+w/QGQAZeI8cUJnIHFFD5
	 ZMd6ju08+StXclLUSRcxlRhZ12+3dbPUmopVG4qtt6J3JczC3zhCp/+38NAgSGoTt2
	 CApJVdT29LtWidDz2DDJNbg41Gn4UZgA0fomm5OJrVzn0Ex4t4PsZr1mlgxYVsshxe
	 y6jYvqfWTiKhdullHOD/x/H/ZLOoUrrWUTzKbhdxW4hHdFeVVtbPwllNVIz5Rvdv+F
	 lxEeRdXsJ3N/9oQvjaDOSdcTEPas3kShC9LIDyDAnKsHovrnaHTwjJzKX5TY7ieyM+
	 k5vQbagJjdRIg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WTYcC2QHnz4wc2;
	Wed, 24 Jul 2024 22:44:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Lasse Collin <lasse.collin@tukaani.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>, Sam James <sam@gentoo.org>,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 17/16] xz: Remove XZ_EXTERN and extern from functions
In-Reply-To: <20240724110544.16430-1-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
 <20240724110544.16430-1-lasse.collin@tukaani.org>
Date: Wed, 24 Jul 2024 22:44:10 +1000
Message-ID: <8734nzvu1x.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lasse Collin <lasse.collin@tukaani.org> writes:
> XZ_EXTERN was used to make internal functions static in the preboot code.
> However, in other decompressors this hasn't been done. On x86-64, this
> makes no difference to the kernel image size.
>
> Omit XZ_EXTERN and let some of the internal functions be extern in the
> preboot code. Omitting XZ_EXTERN from include/linux/xz.h fixes warnings
> in "make htmldocs" and makes the intradocument links to xz_dec functions
> work in Documentation/staging/xz.rst. The alternative would have been to
> add "XZ_EXTERN" to c_id_attributes in Documentation/conf.py but omitting
> XZ_EXTERN seemed cleaner.
>
> Link: https://lore.kernel.org/lkml/20240723205437.3c0664b0@kaneli/
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
> ---
>
> Notes:
>     This touches xz_config.h in PowerPC boot code. I haven't tested it but
>     zlib's functions are extern in the same context, thus this should be
>     a safe change on PowerPC.
     
I gave it a quick build and boot, seems fine.

Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

