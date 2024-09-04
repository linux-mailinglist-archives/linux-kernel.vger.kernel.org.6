Return-Path: <linux-kernel+bounces-314596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C40FA96B597
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1ECBB2ABD9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC911CCB32;
	Wed,  4 Sep 2024 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mNgjL4xX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z80Zsp6N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3AB19B3C3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439902; cv=none; b=cVErhPtiIrYhknxKxYG+U94p4ru1+NwDjKO1NdFTI5YZu2tz9/K9QGztUY66Mmrfi4RN3HMJhe32uqSmmC9wjHZWxSuFpFBC7gYeczLL0XRSIHwXmAlV7FKQNFEoxxWI2SWBtigNSp7XrKn8bTXPtDBsHoqzYpht0LypPucRtm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439902; c=relaxed/simple;
	bh=xItcBebj3wGmhjdqv7kNE4ij6DE+ql5r8xq17d800AA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iWY4bhpv4YbJD9XGnfpuOD8CZFbyGmDeDdIZ+ukrMaAOvO2cpnwHDeWzEeI8cGAkNqeiZB5SvZQOgY83VmwHr6RpAN6IDAbq5/bFx3Xv7c5PMdkdtMVCF7QbujT3dcm2kzpB16+wohr8Gtf6BYuboCmoIyaflPfw5BzCBxK5t+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mNgjL4xX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z80Zsp6N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725439898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tKCdHSjhCME+F7lToIanxa7EnLXm8trg0dBMKY0LP4A=;
	b=mNgjL4xXL6AxYPjP5o83PXsU7CQweu9UvQdsDz8h0c3UoXXN8Wvg0tY46nyH0wEn1WqVeQ
	qrZL3mV/3yJu2Or5i0ZZh+PwoJB1fuN5x8rtiCltOSnavlW4nkmnxXqGztXaqPKCURGp1G
	vizVIodWkOFqxzvjHjLSqXaxR7+P+pxTSCnQE1nzcuIGBKrNg7h0BKWekTmsWOVAndfaLm
	uqlRbpNEvN7Uw9njc8lEmgwv8sbUhZis7Akhz3qO12hyrx6rmSnTCET0lWLVFrwOA95HcF
	lNpbHfT4t0j3JAzL6U+z3bg3m+ArrVB+O+bjieTuL9NUr076HZs/3R8Ptn9U+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725439898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tKCdHSjhCME+F7lToIanxa7EnLXm8trg0dBMKY0LP4A=;
	b=z80Zsp6NGa5aYKPGL6LRZP52UAMfwNvF/uQlSozOfZTIXWnypGvl9Pwign2gWWYwWqmTqI
	ayfQzr1Jm/iRRnAQ==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
In-Reply-To: <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com>
References: <87cylj7v6x.ffs@tglx>
 <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com>
Date: Wed, 04 Sep 2024 10:51:38 +0200
Message-ID: <877cbr7qed.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04 2024 at 16:03, Jinjie Ruan wrote:
> On 2024/9/4 15:08, Thomas Gleixner wrote:
>> So the check must be:
>>=20
>> 	if (!static_call_key_has_mods(key))
>>         	break;
>
> Hi, Thomas,
>
> with this patch, the issue not occurs again=EF=BC=8C
>
> but there are some memory leak here same to the following problem:

That has absolutely nothing to do with static calls and the memory
allocation failure case there.

The module passed all preparatory steps, otherwise it would not be able
to create a kmem_cache from the module init() function:

     kmem_cache_create+0x11/0x20
     do_one_initcall+0xdc/0x550
     do_init_module+0x241/0x630

amdgpu_init()

	r =3D amdgpu_sync_init();
	if (r)
		goto error_sync;

	r =3D amdgpu_fence_slab_init();
	if (r)
		goto error_fence;

        <SNIP>
=20=20=20=20=20=20=20=20
	return pci_register_driver(&amdgpu_kms_pci_driver);

error_fence:
	amdgpu_sync_fini();
error_sync:
        return r;

Can you spot the problem?

Thanks,

        tglx

