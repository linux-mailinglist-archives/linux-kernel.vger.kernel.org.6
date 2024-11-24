Return-Path: <linux-kernel+bounces-419314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486999D6C57
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 01:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C237281726
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 00:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983C91362;
	Sun, 24 Nov 2024 00:31:46 +0000 (UTC)
Received: from yyz.mikelr.com (yyz.mikelr.com [170.75.163.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE433F3
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.75.163.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732408306; cv=none; b=oT+jrjdERuS23l2zZU7/Q5q+Vg4/4QuOij0D6JRn16IaNV0YNj1ATgNWYaMnjGtU2R4hvFhpjSbTlOn4bnOQBwZksOwrnBN+2FD11+ppSaSjCKUIYRBnGyFMMVuhpFoEAOpjK3/+U8LJfIhr3sB/Qzw4KlVAlCdi9+6+1HHCn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732408306; c=relaxed/simple;
	bh=W0imqc3zm0tJZ3hdHAEZ+g2oSsHPsbnQXSSNbOC/ln8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pM1pDFa1V/JwQwxbRpJdHayMnYTCg/hSgSCnnk9ZrFoWo5Sh1uHk9PZAzTPNu5GaTEKaca0jfvz2XdUOxpP3xtsFKm1kOc27WA2firjNF5Pm222Mxv0lteJP0vVOY50VfoNvVnHfZ4HIK7LWivYurz1aCuwg/ge8uPzitMzthtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com; spf=pass smtp.mailfrom=mikelr.com; arc=none smtp.client-ip=170.75.163.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikelr.com
Received: from basin.localnet (unknown [IPv6:2607:f2c0:e554:1200:4b8f:795f:f483:85bf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by yyz.mikelr.com (Postfix) with ESMTPSA id AE6F872FEC;
	Sat, 23 Nov 2024 19:24:21 -0500 (EST)
From: Mikel Rychliski <mikel@mikelr.com>
To: David Laight <David.Laight@aculab.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, "bp@alien8.de" <bp@alien8.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: Allow user accesses to the base of the guard page
Date: Sat, 23 Nov 2024 19:24:21 -0500
Message-ID: <2195976.7Z3S40VBb9@basin>
In-Reply-To:
 <CAHk-=whsUQMM-FszR-D+myn9-B2pDidXG9DQWGKfAhU3azX==g@mail.gmail.com>
References:
 <680c14b5af9d43d6bc70d2c1e9321e01@AcuMS.aculab.com>
 <e92823fee58d44b6a50a83fd27206857@AcuMS.aculab.com>
 <CAHk-=whsUQMM-FszR-D+myn9-B2pDidXG9DQWGKfAhU3azX==g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, November 23, 2024 6:44:34=E2=80=AFP.M. EST you wrote:
> There's a difference between "valid" and "we care".
>=20
> This is way past that case. The only possible reason for that
> zero-byte thing at the end of the address space is somebody actively
> looking for some edge case, not a real use.

access_ok() for x86_64 checks the validity of the byte one past the end of =
the=20
requested buffer, even if that buffer is non-zero.

I ran into this in kernels that include 86e6b1547b3d0 with a BPF program th=
at=20
grabs the bottom of the user stack in PAGE_SIZE chunks. Reading the final p=
age=20
of user space returns -EFAULT now because the access_ok() check fails.

I've been working around with this:
https://lore.kernel.org/lkml/20241109210313.440495-1-mikel@mikelr.com/



