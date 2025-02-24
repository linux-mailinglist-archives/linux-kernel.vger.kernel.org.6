Return-Path: <linux-kernel+bounces-529191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC33A420C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41267A5069
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DE424889F;
	Mon, 24 Feb 2025 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8RxMg5+"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB7D245038
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404141; cv=none; b=QERAYCEkSOr6nuAZnDOz5/t3/W5kq+tnqJwz6FLhZOfXQhEnO5ZzgsR0jHUHZzeWchVMaZS/wAVLbXqFgo0bunlargMyWw+e14PIthM0YE7Q2FJZrncqrEGvmbWyUz7bXO//n7jsygFza9KZ4CI/6n0Pr/ZKViJJ4BbuTULzh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404141; c=relaxed/simple;
	bh=zWHzNIB0GWgHIOSdqToYcOBzbAIzm5yAyEtvDrKVoMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWfRrmTBwcKvTOS1ZtQXS9jqPYKX7HGofmaVdlPrkg38lIb0toU329+41EsLFgzlw08LIj50ogfA1elKPLo2zxaYEG5KOFFyrNE/EtHSChPAEm/fg2k4cCAVpxn6SK6CmzXp38xEUiQ1LjrXAKBvgJwn1sav8jg5raYTo8VltlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8RxMg5+; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30a303a656aso45214361fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740404137; x=1741008937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zWHzNIB0GWgHIOSdqToYcOBzbAIzm5yAyEtvDrKVoMI=;
        b=u8RxMg5+snEmhnZnBJsqVStT+qknxgxKP8Qr5dr7Olrxj/ach1bMlBMI0It9/gPdrv
         rRQsTW9t9jtpVkgSWZQSQwYg48V/kswA4rZSLsh3bOKFUCAoX3yK29OysiH3VusNj9pf
         ohR2qqUBaMMBczXzLQNyJY+wcNMIBPNm4cttOnfc0fK6dX9ORXJUqy9FQshAYqQ+wgeg
         mmVYxRPrGWCHjYzWKliO6rKDYS0U8z58uj5u1c+btLVbaftQCcvCm/rkuBMJm66XfpYA
         TZ/SyjqmJQyTDEfJ9vY6RABgHITgCR27VRGuuc4UmY9zu81VigBLaIDd+jqRXEJz828r
         EHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404137; x=1741008937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWHzNIB0GWgHIOSdqToYcOBzbAIzm5yAyEtvDrKVoMI=;
        b=SEE1JdzwY63t2/2CU2oSV/uS2e3Sq0D6A8+N8XstI1825D9w83qL2fIUJ8TiZWfpPp
         gA3KSaBKybXAXwU28e2rJCG0zXoc47LpTkd34BfbxATA30DIADRvXeJFSJx0VlgoOPCZ
         /AYAROJ4gEONV6/vT5lIJ8W4OEzGpu6MVkLFtaa+GG4Cw5d7S5/5XClquvQmSQNwsxiO
         6dpPtgx7Qe22jTSVj7Y9pve1rTvnRIl/69rkKvLpLWdZVKhJ3PUrXvfUG3/blWkfCuqI
         X/o7/o/Ww4uDVhVEpA9pJeo0vH03apxp+LcMJIghRxjqmotSJLF9IDICwVTBdyRwBr1s
         JCBA==
X-Forwarded-Encrypted: i=1; AJvYcCUtQ5Vpj9+7JXJDkB84uaK/4svfZsDtYQacUBY/8/eDvy4TzXG6AYoDXqg8s7y5NjTDEf/7kpgypJHYGjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh4Ucj8+yA38gLOsL+pYUf8CzjLWbNv+X5ErjIXgnX/qgAlUAI
	YXPsl8fuZb7sxlygWYJDNqoTTQGrZs99dDkXodlWz9HDxFOSW7AZxPjZp5kqy8AzQfCLtlmU7Vj
	ZlMjEWz3Uhc2KjbgLhn3HdpL1bCj8bW8XNjwM
X-Gm-Gg: ASbGncskEIrXrK31Xlmi14lUiACEzj5gcEDnuWy0wGjha7ZFP00hvV0YQ6BM+DIDiOd
	RlvHRaw7dIdNuvLRzHIQhCdQkAeqPZ1ySm1aBPG8G5Ltopb75vum4vPNwF2/JQEgme8U6znttbp
	6TnN7aybM/BY1fkZLv/zqt1a7wbQjmrhQHt975
X-Google-Smtp-Source: AGHT+IERHuTdp/n0R8ZFCMQf0WgBb3ClnlRkiDGs5X+fXe+jvSx9bl+/A/shNbvzpbc3OKLUZ1NfSr9+pXqA0+d1C/w=
X-Received: by 2002:a2e:91c9:0:b0:309:1e89:8518 with SMTP id
 38308e7fff4ca-30a5b2046e3mr40964671fa.27.1740404136962; Mon, 24 Feb 2025
 05:35:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com> <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <81d94ec3-16af-45a7-87c6-ef76570953f8@intel.com> <6ada635e-973d-4e32-ab47-1fda12ee7ce7@efficios.com>
 <90a36a64-8ea5-4ea1-965f-bcec604c7d5b@intel.com> <6ad30642-c3b5-4ab8-9ed6-1fa8c56a8995@efficios.com>
 <c793e1d0-e508-4cf5-a18b-29d30d5e401f@intel.com> <eb087edd-4ff5-40f8-afcb-e4d94fb2a7ba@efficios.com>
 <470ee918-59fb-4af8-b5c7-93077963b437@efficios.com> <7d830f4f-dccb-4055-8539-e97432e178eb@intel.com>
In-Reply-To: <7d830f4f-dccb-4055-8539-e97432e178eb@intel.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 24 Feb 2025 14:35:24 +0100
X-Gm-Features: AWEUYZm00ECcG9lyHKNgyYgZjvnvtYiJmeRGL08QENJArMfFjNe_PeXPxgyB30s
Message-ID: <CACT4Y+Z=q8CX5x01o2vZA3n+VjuQD2uUKsd-osCEf8LziDUZ1Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Dave Hansen <dave.hansen@intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, peterz@infradead.org, 
	boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 22:45, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/21/25 13:36, Mathieu Desnoyers wrote:
> >>>
> >>
> >> Because the rseq return to userspace handler is called on every return
> >> to userspace after a task is scheduled back after preemption, I am
> >> concerned about the overhead that would be added by a WRPKRU on the
> >> fast-path, given that it acts as as barrier against speculation. Issuing
> >> WRPKRU only after checking that pkey-0 is not accessible appears to be
> >> moving the overhead to a much less common case.
> >
> > Actually, we should distinguish between two accesses here:
> >
> > A) loads/stores from/to struct rseq
> >
> > B) loads from struct rseq_cs (only happens on rseq abort)
> >
> > (A) is a fast-path executed on return to userspace after a preemption.
> > In order to make it fast, we could require that struct rseq is pkey-0
> > and typically skip any WRPKRU for this access when pkey-0 is already
> > accessible. We can add a check on rseq registration to make sure that
> > struct rseq is indeed pkey-0, and reject it with an error if not. This
> > should help make the ABI robust and less error-prone.
> >
> > Now for (B), it's a slow path. When we observe that rseq->rseq_cs is
> > not NULL, we can simply override with a permissive pkey to make sure
> > the rseq_cs access will work.
> >
> > Thoughts ?
> I think this will be the first ABI which is explicitly pkey-0-only. I
> suspect there are a few more of these that are implicit but we just
> haven't found them yet.
>
> I wouldn't have any objections about doing this, especially given
> sanity checking at rseq registration.


Thanks for the thoughtful review.

I've tried to incorporate all suggestions in v4:
https://lore.kernel.org/all/68427864e0ca38af06482c96728216c3e0973418.1740403209.git.dvyukov@google.com/T/#m431c13b6140e447d41d228fb942d9e4b8a89874a

Yes, the intention for doing the switch only on the error path was to
avoid WRPKRU on the hot path.

For my current use case (at least how I currently have it implemented)
struct rseq and altstack are indeed protected with pkey 0. So I added
a new enable_zero_pkey_val() function that lazily enables only pkey 0.

Also added Fixes tag (for everything except for signal.c refactoring).
The "fixed" commit seems to be the original rseq patch d7822b1e24f2
("rseq: Introduce restartable sequences system call") b/c PKEYs
introduction is older.

I also had to significantly rework the test to make it work with rseq
protected by pkey 0 (which means we need to revoke access to pkey 0,
which means stack/tls/errno also become inaccessible).

Please take another look at v4.

I don't have preference as to how this should get into the Linus tree.
Hopefully the changes are not too pervasive for all subsystems to
cause massive conflicts when merging.

