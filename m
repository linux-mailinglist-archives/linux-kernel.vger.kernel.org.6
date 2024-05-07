Return-Path: <linux-kernel+bounces-171869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B0E8BE9A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F05928E571
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DF03D0C6;
	Tue,  7 May 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sUwWyeo3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7lwznpI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD516D335
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100465; cv=none; b=ctIXeGtW/QgGStg+LzbWYAce7czAy1NnnX+b06JzFTev4xHBi+kucjdOYlULvqlgd1G9WqavbSECym9rhwLIhvpykC7Jw+31kQoz+aYRgZGp872KBa0+wg1OAarWPkXAAqmOxWcAW06H07DMB/8YYOcm5dIaEw7S+UdugTTXx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100465; c=relaxed/simple;
	bh=fP2GCYF+FDS7X9Bv3XJNq1xxDbxj+LAyqNnb1fWIkSg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W1kSv0XVtGse5ah0YNE/ISW21MD/xFeESWALRgArXf7qmX/jABjGgUt+dcEWXS5EA+Hg1yWeGInlLpjDNagpfsuu2QNYtsLEXVcMIqT8bJIBNFk8PfeTjl2LbBsU4rQPjiyvbmQlDrFkvUVPb2PsWwcg3YBO4ycvXsLmKvfi0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sUwWyeo3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7lwznpI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715100461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4IUfD+588mwXZn+RZJgS5vVWrP+JIRKvO+BCDvrvXE=;
	b=sUwWyeo3C5n0l4tONE4v3+HRznDwt0nhGYweFQqNRjswZV6wrfMTxTcIJrldE1WPvpmQGV
	aIWKeUugQwhb6/Cf7fqtGwG0JopD9wBMPE1dM6Xmm6iet2CNCKVMIurO47jHhsO/RuSkb+
	WCOu/5mUNKbsChG6Sao8nlVy/pFU1Ek+8QUuSk8WZBTxgsTDNloeNPMjMSSO1wTqiFzUw7
	xthpCu8XM9OA/Xum3iD11j4Y8XLVN2Qw6ixqtizVlNssOEohpDliKH95rIljwC+aOQEiz1
	vamDXNP43fWlUi3jSrtmu6io0ehG4hBipyQJw/F24VYKHEpPQV1rYKZC/EIuSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715100461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4IUfD+588mwXZn+RZJgS5vVWrP+JIRKvO+BCDvrvXE=;
	b=z7lwznpIf0NRDoP1zk3pqwnKk4fWkp0b3xSo921pPhrSstrO7e4O7rSwd+QCA/Wya01JYZ
	+jKqiJ0LcgKRQCAw==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
 keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: Re: [PATCH v3 3/4] x86/pkeys: Update PKRU to enable all pkeys
 before XSAVE
In-Reply-To: <20240425180542.1042933-4-aruna.ramakrishna@oracle.com>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
 <20240425180542.1042933-4-aruna.ramakrishna@oracle.com>
Date: Tue, 07 May 2024 18:47:41 +0200
Message-ID: <87wmo5po0i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 25 2024 at 18:05, Aruna Ramakrishna wrote:

> If the alternate signal stack is protected by a different pkey than the
> current execution stack, copying xsave data to the altsigstack will fail
> if its pkey is not enabled. This commit enables all pkeys before
> xsave,

This commit (patch) ....

Also this lacks any justification why this enables all pkeys and how
that is the right thing to do instead of using init_pkru_value which
is what is set by fpu__clear_user_states() before going back to user
space. For signal handling this can be the only valid PKEY state unless
I'm missing something here.

>  static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf,
>  					  u32 pkru)
>  {
> -	if (use_xsave())
> -		return xsave_to_user_sigframe(buf);
> +	int err = 0;
> +
> +	if (use_xsave()) {
> +		err = xsave_to_user_sigframe(buf);
> +		if (!err && cpu_feature_enabled(X86_FEATURE_OSPKE))

The CPU feature check really wants to be in update_pkru_in_sigframe()

> @@ -278,6 +278,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>  	if (stepping)
>  		user_disable_single_step(current);
>  
> +	pkru = sig_prepare_pkru();

pkru is defined in the first patch:

> +       u32 pkru = read_pkru();

Why do we need a read and then another read in sig_prepare_pkru()?

Also this lacks a comment what the sig_prepare_pkru() invocation is for ...

>  	failed = (setup_rt_frame(ksig, regs, pkru) < 0);
>  	if (!failed) {
>  		/*
> @@ -295,6 +296,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>  		 * Ensure the signal handler starts with the new fpu state.
>  		 */
>  		fpu__clear_user_states(fpu);
> +	} else {
> +		write_pkru(pkru);

.. and a corresponding comment why this needs to be restored here.

>  	}
>  	signal_setup_done(failed, ksig, stepping);
>  }

Thanks,

        tglx

