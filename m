Return-Path: <linux-kernel+bounces-374089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C75999A62D3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B21B24EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D4A1E47D3;
	Mon, 21 Oct 2024 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ooVn4SRr"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921816F27E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506413; cv=none; b=ihLefaw84di/k4CcvwslFQAiTCx6Z2Vca4fQHZflDU16m3Ep7E3R3SmsaygRGxOnqPVsL/G0/7TqkKofNz9rE3RrIvaVD8r4h99XABADJTrVh4AreNw9H+oHvCmk7xj0m910FKd+d5LvZExsntBxjDCunDg6+p0n+fMxbzrK8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506413; c=relaxed/simple;
	bh=ldeRxmVxesBWJgkdZ2wLQ3QBzgC/wXtoI3dkl178Rls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V3KXb47pmFMEVcOO6tnAx/ya16KZ8LjIuIB2HlcxKX50C8pzkag+mNQMy5loWdIoOhh49pp2SCdHSmjuERf69aUzKECewPxV3KrkocCVrqs5R/nOy75PVrSvJQWta7i6/sIQqUoy6Ime6RmaXqYo87NPo8oHc2EfovyJGxMezms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ooVn4SRr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ldeRxmVxesBWJgkdZ2wLQ3QBzgC/wXtoI3dkl178Rls=;
	t=1729506411; x=1730716011; b=ooVn4SRrGHbey0+QUMsnOP5+Q/xopu97eVgCgW1/HOGdrW4
	Uz7ggReA6ng9iVeZCx4geiMPEQaujSjccddjAJXgnjR3kDasM8WRhM8w6Bi9QtgJoM28JVaz54cRE
	nKyz2/lS4++USwtJKMQoG6QmnDWBfoi9JI9y2fsDn1C//A5+JN2qIaBz1MtM7QsBHJZehxYFYATul
	tPdtf6FT1+jZmY3XYdzwlksSOh6AjcuTJ6HqQXaxykEeXPCVELiHr7jG0AutxrA2fjQu6ColRoqyw
	6NM1r9uTFA7AiRKiUmjoW0bWd+xF558wV5PCQ4zWriBpnbWGouF9vrFhO+ERfjqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t2pcd-00000000k3e-1scN;
	Mon, 21 Oct 2024 12:26:47 +0200
Message-ID: <43f56c9d5bbbc93193b3e08622490e176bc915d9.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Fix misaligned stack in stub_exe
From: Johannes Berg <johannes@sipsolutions.net>
To: David Gow <davidgow@google.com>, Benjamin Berg <benjamin.berg@intel.com>
Cc: linux-um@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Date: Mon, 21 Oct 2024 12:26:46 +0200
In-Reply-To: <CABVgOSntH-uoOFMP5HwMXjx_f1osMnVdhgKRKm4uz6DFm2Lb8Q@mail.gmail.com>
References: <20241017231007.1500497-2-davidgow@google.com>
	 <CABVgOSntH-uoOFMP5HwMXjx_f1osMnVdhgKRKm4uz6DFm2Lb8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2024-10-19 at 13:54 +0800, David Gow wrote:
>=20
> Okay, it turns out this breaks clang:
> arch/um/kernel/skas/stub_exe.c:84:2: error: non-ASM statement in naked
> function is not supported

Fun :)

Interesting too, I've _definitely_ got some code elsewhere, that's
usually compiled with clang, using __attribute__((naked,noinline)). With
a quite old clang version, I believe. Oh well, whatever.

> And, looking into it, gcc's docs are not encouraging here either:
> https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html
>=20
> This attribute allows the compiler to construct the requisite function
> declaration, while allowing the body of the function to be assembly
> code. The specified function will not have prologue/epilogue sequences
> generated by the compiler. Only basic asm statements can safely be
> included in naked functions (see Basic Asm =E2=80=94 Assembler Instructio=
ns
> Without Operands). While using extended asm or a mixture of basic asm
> and C code may appear to work, they cannot be depended upon to work
> reliably and are not supported.

Right ...

> My gut feeling is that the "correct" way of doing this is to use an
> actual crt implementation for __start. I managed to get it working
> with nolibc on x86_54, but the sheer amount of hackery involved was
> not exactly encouraging. There are a lot of conflicts between the
> different headers for a start.

Yeah, that doesn't seem like a lot of fun.

> The other "correct" way would be to rewrite __start in assembly, which
> is annoying as it'd be architecture specific, so need a separate
> 32-bit version.

That'd probably be less bad than it sounds, since all the syscall magic
macros etc. in there are already architecture specific.

> The less-correct-but-working-here way, which I'm tempted by for now,
> is to get rid of __attribute__((naked)) and just use
> __attribute__((force_arg_align_pointer)). That's probably the best way
> of fixing the stack issue, but obviously won't fix any other issues
> which could arise from __start playing loose with the rules.
>=20
> My current plan is to send out a v2 with force_arg_align_pointer next
> week, unless someone has a more brilliant idea.

Sounds good to me. We'll find out if we have to iterate more ;)

johannes

