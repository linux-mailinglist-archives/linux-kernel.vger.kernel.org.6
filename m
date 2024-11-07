Return-Path: <linux-kernel+bounces-400815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C06CA9C12B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760171F23B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758ED1E261C;
	Thu,  7 Nov 2024 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="IC7u/7nf"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF41D86ED
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023389; cv=none; b=eRkYU/RuF2JMkVSOnGSvioHWYL947Waw02gbLyWJCV8fmjBEHszpduSZLWT16kJ4xNdAPgWCRYW+Q6ifF+69lwv8E6qN43Q+Dnz0i0inPQ+0axGUHamStBzwbr708BitQyO48ZEFpW4ut+cmteUq7VaE0ejSpPLu+ahcHEKUahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023389; c=relaxed/simple;
	bh=+0QGC7AO2xC55eYvmU6ATMdGROQHT7rW3f1yPRmxEeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sZ6iEXLoMdXEbT9qbVHwyZ0UgbhEzWE/3A4WZR/dLfh/BlF3/YHBaf0ZD6jLdbwK+vm5hQJfQrOTH7QgIqu8EzWmKqfz8NyWZ8VLWhFZehilRdLmf0XIAQ5rdLy1Ag3Obk9mGxLlFNsMqpiRpZhhdpX3Ov2vHvw1zHcdQwEZmrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=IC7u/7nf; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731023382;
	bh=1UjGmzJI5YomK2L9/tQso2d7SjKdXqaBlKYPlkpu4U8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IC7u/7nfsujlFq9JdHYwNOAsjCDXS0JEsT3nczJyq/0VVUy6teXkspmcTP1OmwKjp
	 Z13MzhjyMX4WT9pPqKP6WvFIHZnC1sybMGcq1wso3Z700NL8/0CsaI25aKVMJQH3Zr
	 n4Q5+qlMOxXpmCI/f4/AbDLDzDktWiyRA6SKKtpr/7lWGgWkUOuZmQAftBK/wshZG/
	 SPFE1zxNGwRS+K+0ugYB5zu1KVrvDEXB2s1ZWV7hnv1y38S+GW4cvmWCnqXgdD0cCo
	 tXHGqAQXScCLaY5i6c5jDKDsH4TztJbCcPDGu8fmaeOmBao1E20jCqfaWw8bH7PI5m
	 U6mmSa55RCtTw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XkzMB1xXbz4x6n;
	Fri,  8 Nov 2024 10:49:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Yang Li
 <yang.lee@linux.alibaba.com>, npiggin@gmail.com, naveen@kernel.org,
 maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Abaci Robot
 <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] powerpc/machdep: Remove duplicated include in svm.c
In-Reply-To: <ed3a5d53-af06-498f-a8fe-0fe1e3a293bc@csgroup.eu>
References: <20241107010259.46308-1-yang.lee@linux.alibaba.com>
 <87msibcmeb.fsf@mpe.ellerman.id.au>
 <ed3a5d53-af06-498f-a8fe-0fe1e3a293bc@csgroup.eu>
Date: Fri, 08 Nov 2024 10:49:44 +1100
Message-ID: <878qtud2p3.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 07/11/2024 =C3=A0 12:29, Michael Ellerman a =C3=A9crit=C2=A0:
>> Yang Li <yang.lee@linux.alibaba.com> writes:
>>> The header files linux/mem_encrypt.h is included twice in svm.c,
>>> so one inclusion of each can be removed.
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D11750
>>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>>> ---
>>>   arch/powerpc/platforms/pseries/svm.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>=20
>> The two includes only appear in linux-next, and they both come from
>> different trees. They are required in each tree to avoid breaking the
>> build.
>>=20
>> So no one can merge this patch until the two trees are merged into mainl=
ine.
>
> But can't those two trees coordinate the patches so that the include=20
> goes at the same place avoiding duplication at merge ?

Yes that would work.

Except that in this case it's too late because the commits have already
been applied to both trees for over a week - neither maintainer is going
to want to rebase for something trivial like a duplicated header.

I could apply a patch to my tree to move the include to the same line as
the commit in the DMA tree, but even that seems like overkill for a
duplicated header.

I'll try and remember to apply this once the trees are merged in
mainline. But if not the bot that detected it in the first place can
just detect it again and repost.

cheers

