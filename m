Return-Path: <linux-kernel+bounces-184325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8012F8CA572
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D70B22276
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F735C83;
	Tue, 21 May 2024 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="X5NRwOCp"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7B81E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 00:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716252507; cv=none; b=A2VxNwFSGjZkIXxABuOnnre22AVTVAv6FBv8Ha1Ne4L/wWvhbNCfIET/8nCD9RTW9T9fdIMZj0JL4Xu5hG0YkU8rJwBH9Uz8OsBZMsDRO69THRfMZN37P/oXifi/8BiIp/ifdqn2XFzZ8g3BUbeb/NtIBRVA15IVDzt/veVoT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716252507; c=relaxed/simple;
	bh=YLA3mOlhQu9l5RqU75xfAtJgMMySlJsqBiBjGwoY8Fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fD+WkZpb3M5iwnRn310XpvfI3jGCid53Fa+7RSR04/U0qJ91ZXzMZ+deV84vzKZNGcmV3WTAzlKOli2ompW9FfARD7/5t858WRvFRPB1XqNRptljyzgB2WN/zEXC8zs/msaWx9uF5ZJeTDcAxUMEiJ29HOgtXx0Oc9Q/iaimqk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=X5NRwOCp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716252502;
	bh=YLA3mOlhQu9l5RqU75xfAtJgMMySlJsqBiBjGwoY8Fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=X5NRwOCpFcBotgjRna13dxvT/o7xnf+Qgsg7NLp8c5A5cJz4rwMGdkHkS5s2nEst7
	 zZS3eFvoplEpepU32h45RjftKksRrdyYsQPgjDhaXdvsS71vnBI/seSpC0RP8Iw32f
	 udgFlZzlIi4FsxYS7hlqq9vKbhVbrLCzvAMIM8s9aYXk162otscAuQcVwFj1uT98WF
	 QUpdduIflhhd+BYm+bfn61BmCMxbgWxFaozRgF5a3NlcAfFJ1GQmPDwmfXMboL94Qg
	 ukh2cf8tz/B4A+ccwPbAIuoNWFg2J2g+ZUwW9SBlGkSh++THJRNvQ2mVP8AZxgLO4J
	 H8Xzu0Nu12FkQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vjwln66Mgz4wjF;
	Tue, 21 May 2024 10:48:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Oscar Salvador
 <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v2 06/20] powerpc/8xx: Fix size given to
 set_huge_pte_at()
In-Reply-To: <f26807dd-bbd2-405d-9a88-c0654c525a5c@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <04f4e737608ea0b177b88057db138fbf0d6ab138.1715971869.git.christophe.leroy@csgroup.eu>
 <ZksUiwNaKx2n1fJO@localhost.localdomain>
 <f26807dd-bbd2-405d-9a88-c0654c525a5c@csgroup.eu>
Date: Tue, 21 May 2024 10:48:21 +1000
Message-ID: <87zfsk2dnu.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Hi Oscar, hi Michael,
>
> Le 20/05/2024 =C3=A0 11:14, Oscar Salvador a =C3=A9crit=C2=A0:
>> On Fri, May 17, 2024 at 09:00:00PM +0200, Christophe Leroy wrote:
>>> set_huge_pte_at() expects the real page size, not the psize which is
>>=20
>> "expects the size of the huge page" sounds bettter?
>
> Parameter 'pzize' already provides the size of the hugepage, but not in=20
> the way set_huge_pte_at() expects it.
>
> psize has one of the values defined by MMU_PAGE_XXX macros defined in=20
> arch/powerpc/include/asm/mmu.h while set_huge_pte_at() expects the size=20
> as a value.
>
>>=20
>>> the index of the page definition in table mmu_psize_defs[]
>>>
>>> Fixes: 935d4f0c6dc8 ("mm: hugetlb: add huge page size param to set_huge=
_pte_at()")
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>=20
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>>=20
>> AFAICS, this fixup is not related to the series, right? (yes, you will
>> the parameter later)
>> I would have it at the very beginning of the series.
>
> You are right, I should have submitted it separately.
>
> Michael can you take it as a fix for 6.10 ?

Yeah I can. Does it actually cause a bug at runtime (I assume so)?

cheers

