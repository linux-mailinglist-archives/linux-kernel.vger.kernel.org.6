Return-Path: <linux-kernel+bounces-271832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49A29453AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 22:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708D91F243A2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD18E14A4DE;
	Thu,  1 Aug 2024 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="46SWz0n/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/SWkC2PP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54DA15AF6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722543538; cv=none; b=L4+1PZkUKypHWxUnQ0OQM1QgCjKkYRB5pH/dRUNnwH/ahNGJfm7Y8oZSBTv6TN4o4ZSFHB1lYeAsbi+PGt2Ft8+gF36TT2WY0sj0TlLTt7NmDxLTq3LwgeY5w1AZOeMyFJoSyJBa3TFr0U3OigItV9NXsYEiI+vatCsTrSRHC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722543538; c=relaxed/simple;
	bh=7wv5ErQ8JikJgjkcsWWbnT7qIFDEAArMo7mHCIX/rso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vAneea2B8JhvaAeQORXtAG2UAaENJsmmLWFqk88xPlNrfjbJOEXPnJ5U12nUXCBBmb6WnAI2LfEX536f5gvNx0GHpwPq5A1xJkVZu8WcTOmpSFVNSyXBIeWgDd1C2YmNqtp7FKVkWJvVpZqQwqb2NFJRmXDd8i9dUZEassZEcF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=46SWz0n/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/SWkC2PP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722543535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9brb0g5cHyHLjZZ88SgjMpAtNZQfiLpqo2Zn3LJIxJA=;
	b=46SWz0n/qHoheH1igvZp3Fk8J8jwjtMUmW9lT4ZM6n5ISglwvNQEDy1AZDiyxyhvhVWUPU
	owQylw3oMGYO4P1icQzlQPYSVHSvcLk3KOE31TZqy3ayEHeeDzAIfXIuVYZCb8J6ffqg8C
	EguK+Y9elgpt459sC3z0iMKIdPBDk1PqYG7S7h7syn4N8659AdAHoRt13mbydMBHJXthW4
	eJdnvQ4+e3cUFpmdqbS5vfG2VY3+qIyPRD2/s3epMOeWVKr2rYVtqETb5t9/+19Z9UiCn8
	zOARgEHdcL7IIzMfi0zwtlupmbdJCPS0RDSTDkjSbEqbHT+Bk8OdXutH/7jQ/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722543535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9brb0g5cHyHLjZZ88SgjMpAtNZQfiLpqo2Zn3LJIxJA=;
	b=/SWkC2PP+lnx4oMKJ5VMvEwhp559g29hFh+kIsSydpZphym7c6R/12X8nK7R1UwhJb2grm
	KRYDdQUJmNQaUCBw==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Keith Lucas
 <keith.lucas@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, Jorge Lucangeli
 Obes <jorgelo@chromium.org>, Kees Cook <keescook@chromium.org>,
 "sroettger@google.com" <sroettger@google.com>, "jannh@google.com"
 <jannh@google.com>
Subject: Re: [PATCH  v7 2/5] x86/pkeys: Add helper functions to update PKRU
 on the sigframe
In-Reply-To: <BB4AA839-1CF6-4C48-B3ED-24F9E425837D@oracle.com>
References: <20240801065116.2088582-1-aruna.ramakrishna@oracle.com>
 <20240801065116.2088582-3-aruna.ramakrishna@oracle.com>
 <874j844o3q.ffs@tglx> <BB4AA839-1CF6-4C48-B3ED-24F9E425837D@oracle.com>
Date: Thu, 01 Aug 2024 22:18:54 +0200
Message-ID: <877cd02dzl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01 2024 at 20:14, Aruna Ramakrishna wrote:
>> On Aug 1, 2024, at 1:57=E2=80=AFAM, Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>> On Thu, Aug 01 2024 at 06:51, Aruna Ramakrishna wrote:
>>>=20
>>> +extern void __user *get_xsave_addr_user(struct xregs_state *xsave, int=
 xfeature_nr);
>>=20
>>  *xsave lacks __user
>>=20
> Did you get a chance to review the rest of the patchset? If you have any
> additional comments/suggestions, I can batch those fixes into v8.

I did not find anything problematic.

If you spin up a V8 you could polish your changelogs a bit and give them
some structure. They mostly consist of one big lump. See:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#change=
log

for some examples.

Thanks,

        tglx

