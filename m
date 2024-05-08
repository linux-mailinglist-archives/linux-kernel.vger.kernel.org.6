Return-Path: <linux-kernel+bounces-173260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF968BFDCD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5CB1C2101E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7B95823F;
	Wed,  8 May 2024 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tR6UcB+B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="osvqMyCn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1FB5577E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172944; cv=none; b=KemnzieZJMm+Lw7ETH2uDkWuJCJPSpg/YHDmm8iBA4zeMP7qkozwmnWx2lpeaUPVgNJ2wRwSftgtaxryLDpBps53okXBpcaFp/PnJhMzR8t+6v0HQDFoxZBuKJPuHmlwtWbVdFh9MWHpMhMTlfOI3KRihxzbMO5iMCJxXXwfXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172944; c=relaxed/simple;
	bh=IYnsbmpTR6cnRSujkJZKUy4h1ir9xr/M2xb08D0UwSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cpbT5pextBtjgHzZsBH/a3Aa3lEdACeq8XZKUlAsnE9EP8aTHMP4dRJun4hN+qXguz7/xndK5e8y0rmPMUI4hqf6vb6iWISoUvzKk2FND21Nn5z1Q8tcp9xn2rfBX39QX+7LKDhZTgbVTP3+yXXmI0M4vCunDBKg8H8F+GsQH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tR6UcB+B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=osvqMyCn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715172941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/VdW/OUy8BOKKtOS6C9yl1uJrbefrtspylP/hZYugI=;
	b=tR6UcB+BXAcKL8KvRrpc+4q0hl2vmSeNa6zsfKz5iBVtmTPNo1oidG2aSyL78uZiklI1vj
	Nc500xPzEgjczcjCRvM4c3vSgDmI2E5P/97sUSwKT8wZEycVEcwrjD7pFOvQIZ3xL2OZqg
	kBzhEDlv6Po3MA5qKpeaGMJmAD3VChEFh3vg2Qs2dLZLxxsNOhxbBOjXQNrMFVKuHETUZ5
	RK3kfACUEDDOPL4jQbKTXQoBgMjcILee8TNu6PwPZU/O0yD/CdPfHd2iofvgjxhvUI67ey
	SHJLOvmxo6ZIFxYuPqZqj/d0AlF+FwWgiu8S38w9bHANHyU3tz3QhAW7PAhD0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715172941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/VdW/OUy8BOKKtOS6C9yl1uJrbefrtspylP/hZYugI=;
	b=osvqMyCnD/fIH8rPz6VisNEVD7HHuhnAuiG2uJewyqsCjLrxfB7c/TmZOOD/z2p0zFA5aa
	5tj2yOcWFoWoUIAw==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Keith Lucas
 <keith.lucas@oracle.com>
Subject: Re: [PATCH v3 4/4] selftests/mm: Add new testcases for pkeys
In-Reply-To: <C91DA697-0483-4AF0-A29D-FBAA1669E845@oracle.com>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
 <20240425180542.1042933-5-aruna.ramakrishna@oracle.com>
 <875xvprfnm.ffs@tglx> <87ttj9pnm8.ffs@tglx>
 <C91DA697-0483-4AF0-A29D-FBAA1669E845@oracle.com>
Date: Wed, 08 May 2024 14:55:40 +0200
Message-ID: <871q6cpinn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 07 2024 at 18:04, Aruna Ramakrishna wrote:
>> On May 7, 2024, at 9:56=E2=80=AFAM, Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>>=20
>> On Tue, May 07 2024 at 14:05, Thomas Gleixner wrote:
>>> On Thu, Apr 25 2024 at 18:05, Aruna Ramakrishna wrote:
>>>> especially with pkey 0 disabled.
>>>>=20
>>>> Signed-off-by: Keith Lucas <keith.lucas@oracle.com>
>>>> Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
>>=20
>> Forgot to mention that this Signed-off-by chain is invalid.
>
> Apologies for what is probably an obvious question.
>
> Keith Lucas developed the testcases in the new file pkey_sighandler_tests=
c.
>
> I added them to tools/testing/selftests/mm (i.e. just the changes
> to Makefile, protection_keys.c and some comments etc.).
>
> So should I change this to:
>
> Co-developed-by: Keith Lucas <keith.lucas@oracle.com>
> Signed-off-by: Keith Lucas <keith.lucas@oracle.com>
> Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>

If Keith developed them, then you probably want to credit him as author.

[ aruna: Adopted to upstream ]

Signed-off-by: Keith Lucas <keith.lucas@oracle.com>
Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>

Or split out the pkey helper changes into a separate patch which is
authored by you.

Either way works just fine.

Thanks,

        tglx

