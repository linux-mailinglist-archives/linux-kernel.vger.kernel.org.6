Return-Path: <linux-kernel+bounces-173258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3AC8BFDBB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB42B24112
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1796BB4C;
	Wed,  8 May 2024 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kDzn13Qt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3WkgttlU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185036A34C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172742; cv=none; b=U2ukqCqfO14Rx5+jOvCVTdvX5tTV6ImmOz7iy5/KLOp5AUpwXGFWunLDCn76xI36xKJBRcDxTdwelKuSkSOieVhcVHCmE8ZEPYxVHivTeVeA3kEWF8jGz+HElPuMx5shT1VfsWq81Qq7QR6dM9snXLWFT0Y0RZxsEfra0JDJLLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172742; c=relaxed/simple;
	bh=J0lUDT8rrcvRsx9774q/JHRDZf7sHnEPkdm0tLi1WdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CfunKhlvbl4rCwV3gnfM9cLHDhqPnBQMMjvgebx//UnptOwBHVJijJnYrMKXYejsEryrE+BEwZ0enN24DDNclptsgEjfo3VQ7r3SkXx6mCPPKMBPM7t/KlsVODohLn8hXJfMOYHio7Ac4QoQztMTerUctGQsUvHO9cORsnVX/2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kDzn13Qt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3WkgttlU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715172739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zg6WebQLZVM/Zr+k3gM1mlCJa9IkRkbXXh8OvAx+UU=;
	b=kDzn13QtcrAMPtvVA8nuTumLTovbIvWeUaw8eAjBXuaLEtnBWP7Z0OffHnpITbMUWEqlZl
	s7Ck0C/Hxhs8kEQCfrxSYX0SQTSCslHvhbgmSo8tqSCOepAVwBhTbnZodV7NWvCrY0C2pZ
	zhWjTnoEzM+A/5LEQnfY94Kds6BqLWs8hcC4uIcdXjBmYBpf+aEkzzhFwc4NsK4XURpXok
	9EQpUioG3nOg8cTvOk2tdvHYTWhRwxR58C90CjAJk6Lu/eWoXCVZNmVg2halgl57vBbLia
	UF2tYudkdv+peNO5OH0C+gH+EouJzwqTMRiHjOb9VyJvgvwhGHlgORkmD6/39g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715172739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zg6WebQLZVM/Zr+k3gM1mlCJa9IkRkbXXh8OvAx+UU=;
	b=3WkgttlUHBuDb1OeflNpxqBJL22YSbI3qnKCsL1HPQbn4/OVajKRFSWKQGw5RyFeZrf7Uv
	rrRKR8Xu0gKjrBDw==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Keith Lucas
 <keith.lucas@oracle.com>
Subject: Re: [PATCH v3 3/4] x86/pkeys: Update PKRU to enable all pkeys
 before XSAVE
In-Reply-To: <FF998E58-D109-45B1-9BD8-FEF873E2FA7A@oracle.com>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
 <20240425180542.1042933-4-aruna.ramakrishna@oracle.com>
 <87wmo5po0i.ffs@tglx> <FF998E58-D109-45B1-9BD8-FEF873E2FA7A@oracle.com>
Date: Wed, 08 May 2024 14:52:18 +0200
Message-ID: <874jb8pit9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 07 2024 at 17:34, Aruna Ramakrishna wrote:
>> On May 7, 2024, at 9:47=E2=80=AFAM, Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>>
>> Also this lacks any justification why this enables all pkeys and how
>> that is the right thing to do instead of using init_pkru_value which
>> is what is set by fpu__clear_user_states() before going back to user
>> space. For signal handling this can be the only valid PKEY state unless
>> I'm missing something here.
>
> If the alt sig stack is protected by a different pkey (other than pkey 0)=
, then
> this flow would need to enable that, along with the pkey for the thread=
=E2=80=99s=20
> stack. Since the code has no way of knowing what pkey the altstack needs,
> it enables all for this brief window.

Again. The flow here is:

handle_signal()
  enable_access_to_altstack()

  ....

  fpu__clear_user_states()
    restore_fpregs_from_init_fpstate(XFEATURE_MASK_USER_RESTORE)
    os_xrstor(&init_fpstate, features_mask)
    pkru_write_default()
      write_pkru(init_pkru_value);  <- Loads the default PKRU value
=20=20=20=20=20=20=20=20=20=20=20
return_to_user_space()

User space resumes with the default PKRU value and the first thing user
space does when entering the signal handler is to push stuff on the
signal stack.

If the signal stack is protected by a key which is not contained in
init_pkru_value then the application segfaults in a non recoverable way,
no?

So arguably it is sufficient to ensure that PKRU has the keys in
init_pkru_value enabled:

    sigpkru =3D read_pkru() & init_pkru_value;

If user space protects the task stack or the sigalt stack with a key
which is not in init_pkru_value then it does not matter at all whether
it dies in handle_signal() or later when returning to user space, no?

I'm not fundamentaly opposed to enable all keys, but I don't buy this
without a proper explanation why this has been chosen over enabling only
the absolute minimum access rights.

Thanks,

        tglx

