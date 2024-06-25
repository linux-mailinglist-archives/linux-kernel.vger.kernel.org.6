Return-Path: <linux-kernel+bounces-229247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C488F916D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03D91C21BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858016F8ED;
	Tue, 25 Jun 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHVM0hI4"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BCD16F29C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330126; cv=none; b=ZZyu6WYF4Hiu1xbplM5TJDU/aIPAAi5cLMWzx3CEiAhEJ2iU9leKc4rCBLwj4Shi56tQAsbY9NkcuPxmirBmUzb5anYpYZZ4zjQNKkH34f6mrGCtBp+7SvOvyxd4/up1hUiitmVEN2DF7lvQu4+WS5dPdPshXLYmi1hOm4+NXq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330126; c=relaxed/simple;
	bh=ywTSmI1rN04Q5ybrsMmQDMBK0EbrVLfbTfL/6R5ySSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uBbejs1PJ+EDX9JL78yAXSY3TohHa/PEAMJ9e2Gsw0owUx41DMVUJJ+LpQ82pJdtY2ybyYLl7MDSJoK4k/estMDkjl1UzPIc77TdV5ABiYg7myy7r7aVNa0K+RUnSk58morEnd1A+r2A/dQyA+4ZQpDZv40rxxqhd3beDHZxMmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHVM0hI4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f9ae0b12f3so63549875ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719330124; x=1719934924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxxKgmeDgVKqFMmEwgOuCwbtERgNHDGH29QFhnmfwTc=;
        b=GHVM0hI4ZLp3CA0D07FNSOYxRPsDQ7buGwfJIv9pwI+tARTA6WM1i5INgOQsTNgeNf
         kMOzQR/x9sI2IH9q/GAjXBpIjc4W+kn1cTXNR3U1eJQ7WgQks7lGla9RantWyizHbMqm
         08UAJg6ZUTlIcE6QyzkFD5j0K+IC1NBkShzWU1DhZJqzqObrEnrVC8cJGwGnICmNNHUe
         b5Si+BGPiE0n3bPKOYytsVhoPUVQeCPZMOnzGK9eN58/Wycm3pWuJcbRtw+H9ZR5A5iF
         FA4IwbKCOBnC8omrLmFTYcfkbNU17IQJsvuqEi+752aRPJqQesdKJgKZgiOXdCc+f1M6
         eSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719330124; x=1719934924;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RxxKgmeDgVKqFMmEwgOuCwbtERgNHDGH29QFhnmfwTc=;
        b=PLm28oC+qbvLWwWjQAVzGUq7fbc1RkSJlY4w+7AknCwiCyWzLBV9GytdRMdDjAXB/V
         5D8O0v4TAKjTL0a+JT2jOcN340OsYYn/G/QDhtZunzB+Q9yDU8Jz35xIN+S+PwPqTz7H
         Q+c7a1ptguLAn/6CTopuGTeTYqKpZX8dKudGMHUhZLrlpDpcHSsfRnNr8nlXb5hAw0WF
         UL1Zo6cOEhjcfDec98ssJ99TeFYec9U9yk6QMDqzP4UPxmJWCw3U4JMigj1h2EJFPjER
         5+L1R/oItUxemCJjIl2sw97oUu2iqHL76wBcYP3L6VANZkvX4wWJFn+VCMKSwOzE4wAE
         KvLQ==
X-Gm-Message-State: AOJu0YzVQZijp1d0cP8WqEwyCr0unoOqyEnOzWo6+YGZKMFr2gYFvDwM
	5CKbQt21l5QHeeiz3bbHU6xBzBHZEU2GK6VYfRdYysRXB8kDUvA7uqCGBYYNX/vigYeCXXnldmS
	Dag==
X-Google-Smtp-Source: AGHT+IFhgyKRWxYoop/sbDVEXMPn9+FnqK9mKH4shC/uBXK1i+8WbjRze/tcfgrhQ4mXRR9/220//c0nN/I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d492:b0:1f6:8033:f361 with SMTP id
 d9443c01a7336-1fa158de75cmr11068635ad.6.1719330124301; Tue, 25 Jun 2024
 08:42:04 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:42:02 -0700
In-Reply-To: <20240625112056.GDZnqoGDXgYuWBDUwu@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <171878639288.10875.12927337921927674667.tip-bot2@tip-bot2>
 <20240620084853.GAZnPs9Q94aakywkUn@fat_crate.local> <20240625112056.GDZnqoGDXgYuWBDUwu@fat_crate.local>
Message-ID: <ZnrlShoW12JqWmUl@google.com>
Subject: Re: [PATCH -v2] x86/alternatives, kvm: Fix a couple of CALLs without
 a frame pointer
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, x86@kernel.org, Michael Matz <matz@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024, Borislav Petkov wrote:
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 18 Jun 2024 21:57:27 +0200
> Subject: [PATCH] x86/alternatives, kvm: Fix a couple of CALLs without a f=
rame pointer
>=20
> objtool complains:
>=20
>   arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call =
without frame pointer save/setup
>   vmlinux.o: warning: objtool: .altinstr_replacement+0x2eb: call without =
frame pointer save/setup
>=20
> Make sure %rSP is an output operand to the respective asm() statements.
>=20
> The test_cc() hunk and ALT_OUTPUT_SP() courtesy of peterz. Also from him
> add some helpful debugging info to the documentation.
>=20
> Now on to the explanations:
>=20
> tl;dr: The alternatives macros are pretty fragile.
>=20
> If I do ALT_OUTPUT_SP(output) in order to be able to package in a %rsp
> reference for objtool so that a stack frame gets properly generated, the
> inline asm input operand with positional argument 0 in clear_page():
>=20
> 	"0" (page)
>=20
> gets "renumbered" due to the added
>=20
> 	: "+r" (current_stack_pointer), "=3DD" (page)
>=20
> and then gcc says:
>=20
>   ./arch/x86/include/asm/page_64.h:53:9: error: inconsistent operand cons=
traints in an =E2=80=98asm=E2=80=99
>=20
> The fix is to use an explicit "D" constraint which points to a singleton
> register class (gcc terminology) which ends up doing what is expected
> here: the page pointer - input and output - should be in the same %rdi
> register.
>=20
> Other register classes have more than one register in them - example:
> "r" and "=3Dr" or "A":
>=20
>   =E2=80=98A=E2=80=99
> 	The =E2=80=98a=E2=80=99 and =E2=80=98d=E2=80=99 registers.  This class i=
s used for
> 	instructions that return double word results in the =E2=80=98ax:dx=E2=80=
=99
> 	register pair.  Single word values will be allocated either in
> 	=E2=80=98ax=E2=80=99 or =E2=80=98dx=E2=80=99.
>=20
> so using "D" and "=3DD" just works in this particular case.
>=20
> And yes, one would say, sure, why don't you do "+D" but then:
>=20
>         : "+r" (current_stack_pointer), "+D" (page)
>         : [old] "i" (clear_page_orig), [new1] "i" (clear_page_rep), [new2=
] "i" (clear_page_erms),
>         : "cc", "memory", "rax", "rcx")
>=20
> now find the Waldo^Wcomma which throws a wrench into all this.
>=20
> Because that silly macro has an "input..." consume-all last macro arg
> and in it, one is supposed to supply input *and* clobbers, leading to
> silly syntax snafus.
>=20
> Yap, they need to be cleaned up, one fine day...
>=20
> Cc: Michael Matz <matz@suse.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406141648.jO9qNGLa-lkp@i=
ntel.com/
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

