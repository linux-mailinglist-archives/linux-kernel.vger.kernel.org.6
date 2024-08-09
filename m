Return-Path: <linux-kernel+bounces-281612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572DD94D8CA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1324F2838B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6A416B736;
	Fri,  9 Aug 2024 22:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="a6zCSoV9"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A46C8D1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723243479; cv=none; b=m2ChlzLkimK0goo8PvweflX/gz06HSLIsyykm4zN0IhDGgZZOnoiGWvxfW4mvDBxSk7KVrXYMZfw5tiU13XxlHQhKFi2jLaqyY/HJK5P6fE1kfSW6Re8f9GjWjugrL722n7JC0t7lFlMGK0oy/SQiqvDOENhjDkN0UOuUXODr3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723243479; c=relaxed/simple;
	bh=MemLbZ6E6qzaYcNaXP9numQeCnV/KRNFJ4VRargPByU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pTlhy1OILOlTIBKvwaJnTnp9g4ojaEGrfud7WJ5BAs/oPcRiLY5HMHGrEXohyj+DaiC6LwZhrDVZJGSJWZB5gtiOUYFsgtDLz+rjX4hHqrwWZHUO9+q7e6KcHqoORygrDGHWQ4P5oSTxpRjQCYETcmaqtOsUkQNRuLkAs/J72P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=a6zCSoV9; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 479Mi0nT1930590
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 9 Aug 2024 15:44:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 479Mi0nT1930590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723243442;
	bh=MemLbZ6E6qzaYcNaXP9numQeCnV/KRNFJ4VRargPByU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=a6zCSoV9JPqXnNT3LIxo7tCiCNkCAQEcCxt2PVQJFkETeFf2b3b3JsY1Sv+TfFEgB
	 Eu9FSp3Y0yB4/hTgdymcNuBNFM7Bq7bun0umnlwuWcOEJYKs4YNEZl4N3Nz6e6KEDV
	 p0r2RfPyW5ofM67MeQIVFmvjaSNJGZsaDHO0vWmTHwJclSGyTrId/F72lipJ2G58Ix
	 493Vokhpuw0JL1/rwons4seSVU/gxYxlNRhmMZ0NGUAXe0UxdOYFXQogaMQ0JNUI2u
	 ysFCKXhFztwSDCMo4QB5vzCcKWFaxbBUBQirLDLLFaMImEJhiF9CKLwEle2Qxcb9h9
	 PPRvGLpKdBcBQ==
Date: Fri, 09 Aug 2024 15:43:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Nikolay Borisov <nik.borisov@suse.com>,
        linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, seanjc@google.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_3/3=5D_x86/entry=3A_Set_FRED_RSP0_on?=
 =?US-ASCII?Q?_return_to_userspace_instead_of_context_switch?=
User-Agent: K-9 Mail for Android
In-Reply-To: <34964ea0-dbf5-41a1-82cb-5f677afad23c@zytor.com>
References: <20240807054722.682375-1-xin@zytor.com> <20240807054722.682375-4-xin@zytor.com> <eb2ed1b4-94cf-4d3d-b726-6ee0fa13ca9e@suse.com> <34964ea0-dbf5-41a1-82cb-5f677afad23c@zytor.com>
Message-ID: <397D7CEC-F743-4155-AB54-DED1D85FADFA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 9, 2024 10:37:08 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 8/9/2024 3:45 AM, Nikolay Borisov wrote:
>>> +#define TIF_LOAD_USER_STATES=C2=A0=C2=A0=C2=A0 30=C2=A0=C2=A0=C2=A0 /=
* Load user level states */
>>=20
>> Wouldn't something along the l ines of TIF_LOAD_FRED_RSP be more descri=
ptive, or it's expected that this flag can cover more state in the future?
>
>Sean mentioned TIF_LOAD_FRED_RSP, however we also have FRED SSP0, which
>needs to be handled similarly=2E
>
>And we also want to use it to cover future states=2E

It is very likely that there will be additional uses of this beyond FRED=
=2E

