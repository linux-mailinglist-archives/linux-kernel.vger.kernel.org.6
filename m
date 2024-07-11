Return-Path: <linux-kernel+bounces-249818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDBC92F04B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70481B22989
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB1D19EEAA;
	Thu, 11 Jul 2024 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="JCjoJJ4+"
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2C412B171
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729646; cv=none; b=fR4nG8AWqly4cWLSBR+P4+Del9FXDmHCc1yf69Agch4MAVHu+lfsMhkb0Xg2rEX2lO+Db3CAb/XsaV0oA4Ccwcy0i5sdseYKJRKPAI9BDydRpKt8EZJ+lj5O1b8I1JfHBvEJQfKMeCu+3jUPKu8ZEjejDfw/ad4ItDnmMjYoVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729646; c=relaxed/simple;
	bh=chDJJJWbG8wbMscp9nEe5dSFB9fITJITeU+CsbfKuXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vp60KpMRstZq4ieekspuX3nnven+CLoaSq52Cr0mN43+0Hvdfw/c+q8wokpwTwcsiQhU+bHBz+PekMhTCIb4vfXTMNlAtDEmbCUbR1gTIB+J10pWI+Lc0v7G0utUiDid+t3P0MDKKxwYD9d4G4ZiDGTGQidaJDxxfEu8sF+aiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=JCjoJJ4+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description;
	bh=chDJJJWbG8wbMscp9nEe5dSFB9fITJITeU+CsbfKuXM=; b=JCjoJJ4+S/g3rbeO00+Ps4ymIL
	UG/KHIHSPhXHf0zQepCJMqEQYa3WrOqLTZUhAR61mCRmnWiXZjcW3yMY1r6JsGz3p58CGPk1LZS9f
	53GdlmnUrf9hOM/RvFLFZCm9FHXD/x7gbRbDICuJfGBx39IqNxC6EQF9xKoVY8YPVzAeofzANVWAO
	pvmI9z4wjItOuHgX6rnYTWVfadkDua9avN90GgH3OUn13kzGqZG9PalOnK/2Uc9Ab+GeRwwAyUyp3
	jWfFsmp8YjFg70bRGVEgt5cw6wssYaaWNyURjaYFnq2z3Pg8r33gwmFCGLS1lTySrzAqA+B0z9wJ8
	4uS+lz/Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <corsac@debian.org>)
	id 1sS07R-00An92-58
	for linux-kernel@vger.kernel.org; Thu, 11 Jul 2024 20:10:21 +0000
Message-ID: <2d7bd8b2b9736d4a7d0a26169978372b5e002a62.camel@debian.org>
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32
 bit
From: Yves-Alexis Perez <corsac@debian.org>
To: Yang Shi <shy828301@gmail.com>, jirislaby@kernel.org, surenb@google.com,
  riel@surriel.com, willy@infradead.org, cl@linux.com,
 akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>, Ben
 Hutchings <ben@decadent.org.uk>
Date: Thu, 11 Jul 2024 22:10:12 +0200
In-Reply-To: <20240118133504.2910955-1-shy828301@gmail.com>
References: <20240118133504.2910955-1-shy828301@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: corsac

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Thu, 2024-01-18 at 05:35 -0800, Yang Shi wrote:
> The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") caused two issues [1] [2] reported on 32 bit system or compa=
t
> userspace.
>=20
> It doesn't make too much sense to force huge page alignment on 32 bit
> system due to the constrained virtual address space.

Hi people,

sorry for beeing so late. I've looked at this following the OpenSSH issue
(CVE-2024-6387 [1]) and especially the impact on IA-32 installations where
ASLR is apparently broken.

There was a recent thread [2] on oss-security discussing the issue.

Looking at the commit log I think the intention was to fix this both for:
- - 32 bit process running on 64 bit kernels: in_compat_syscall()
- - all processes running on 32 bit kernels: IS_ENABLED(CONFIG_32BIT)

Unfortunately, as far as I can tell, CONFIG_32BIT is not enabled on 32bit x=
86
kernels. Maybe CONFIG_X86_32 would be the right one there?

[1] https://www.openwall.com/lists/oss-security/2024/07/01/3
[2] https://www.openwall.com/lists/oss-security/2024/07/08/3
- --=20
Yves-Alexis
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAmaQPCQACgkQ3rYcyPpX
RFvSHQf/VE7td7scTTsrK7Cx0F3MmDLFgjUDbMDuyPq6lNQqnDbd2zc00JP1eeLs
/mW1uZNbR92bn6xq2sPJu7c6tB3MJuiQme+ZqnPfIgyoWc89i6V6WUXTZN077lIl
xJZxHLMei5KreHz66AYU66HdU89knMTcX362YyyI8dEZKXS3FlP0SLSoBM0UKY0G
HYM6+GetE+fINhfNSMpHgqkTQB825Vqdq5UBsBjHYMg5RJ92/fDgUo5RD7qm/HVz
SDDNSGwpVwYZ20RnnD+DOS9rsnyR4FcAP0m0dcTmQdM8GcY4SyjnEux5idvCicjy
a1jmvsSLxCMZ9mZsrsipIZoNhSHlDA=3D=3D
=3Df0Lk
-----END PGP SIGNATURE-----

