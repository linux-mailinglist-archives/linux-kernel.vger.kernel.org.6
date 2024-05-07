Return-Path: <linux-kernel+bounces-171778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A93E8BE886
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC08E1C21E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A92016ABCD;
	Tue,  7 May 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AVLUXAvN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="762/2gCu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45E168B19
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098598; cv=none; b=Cbqjd2CIIar9nQ9NCAOu5TK4CSWqDYpy3LRM6UB+5PnJRSuZZOeR8h5arKXOpRYXljZsuWRADUyxJmmyd/eapPbU63aUHepcdZb6XywROduW6cq1ZuqibiFvKBDer2wwpRYruuPDuIHyPXaPKub0MdloypVrnWmPquGXVruZ4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098598; c=relaxed/simple;
	bh=diftbWAtEake/auuRRkWComXeatVo2PCzmGadHUO5m8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mfk1cC8JkxsaBeQn+08Z+J8n/Eoj7qB9HpOK+iT3qmPtmJ/M+TH/QofLuSHs6QjWbV68/RCHz2DhAjex8CpfULSqMya1xww3q7C1f0L0J9HUtWUeMj86gUMEf1jFd8AuKVxTcPl6vIGnk44EMg1BQ/Tmk9G2RYHAX3yBvY14+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AVLUXAvN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=762/2gCu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715098594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8yRaINXb+2y+Yk0tF4WrmeylaPP4n6KW+waUEEZ/kU=;
	b=AVLUXAvNUxqkqragrMixC29QZDPC0JoI+53MzzeCtHA9hI3DMLTprc4qDvCPhv9KzyqbaO
	siHtCws6oRH2JjA8Wi82oC4hprJm2XjCnSN3/fX1maa7r9hKE2Wwn47oUqBcjoW7qNMWnH
	lf+GZ2Y1u4m3I55Lat5PQkQvUtImH1/aoXmZI/Ri5SA6ZEZcP7eOjzdAgRzGQKpy2GMUrr
	IiC2rectKeoQI5c8D9gfT/AynU9aihsN1On2prs4XelP8vHl4dQypGZaTEVkF+nS3OdNyC
	MJsE92PonjvTMXV4vQFvaP3Dlst8ZpERT15qrKfKjGOPPBdjLzfMYmQL6VFLcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715098594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8yRaINXb+2y+Yk0tF4WrmeylaPP4n6KW+waUEEZ/kU=;
	b=762/2gCucT3McZ6Lf33umlP4j3V1SeZPhrmq4pdmpz6bMeZeche2A/rSLzzJ6NYfmOjEzU
	V5mlhXW+2JnqsTAg==
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
 keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: Re: [PATCH v3 2/4] x86/pkeys: Add helper functions to update PKRU
 on sigframe
In-Reply-To: <20240425180542.1042933-3-aruna.ramakrishna@oracle.com>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
 <20240425180542.1042933-3-aruna.ramakrishna@oracle.com>
Date: Tue, 07 May 2024 18:16:34 +0200
Message-ID: <87zft1ppgd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 25 2024 at 18:05, Aruna Ramakrishna wrote:
> This patch adds helper functions that will update PKRU value on the

git grep 'This patch' Documentation/process/

Also please explain WHY this is needed and not just what.

> sigframe after XSAVE.

..

> +/*
> + * Update the value of PKRU register that was already pushed
> + * onto the signal frame.
> + */
> +static inline int
> +__update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)

No line break and why does this need two underscores in the function name?

> +{
> +	int err = -EFAULT;
> +	struct _fpx_sw_bytes fx_sw;
> +	struct pkru_state *pk = NULL;

Why assign NULL to pk?

Also this wants to have a

	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
     		return 0;

Instead of doing it at the call site.

> +	if (unlikely(!check_xstate_in_sigframe((void __user *) buf, &fx_sw)))

What is this check for?

More interesting: How is this check supposed to succeed at all?

copy_fpstate_to_sigframe()
  ....
  copy_fpregs_to_sigframe()
    xsave_to_user_sigframe();
    __update_pkru_in_sigframe();
  save_xstate_epilog();

check_xstate_in_sigframe() validates the full frame including what
save_xstate_epilog() writes afterwards. So this clearly cannot work.

> +		goto out;

What's wrong with 'return -EFAULT;'?

> +	pk = get_xsave_addr_user(buf, XFEATURE_PKRU);
> +	if (!pk || !user_write_access_begin(buf, sizeof(struct xregs_state)))
> +		goto out;

Why user_write_access_begin()?

    1) The access to the FPU frame on the stack has been validated
       already in copy_fpstate_to_sigframe() _before_
       copy_fpregs_to_sigframe() is invoked.

    2) This does not require the nospec_barrier() as this is not a user
       controlled potentially malicious access.

> +	unsafe_put_user(pkru, (unsigned int __user *) pk, uaccess_end);

This type case would need __force to be valid for make C=1.

But that's not required at all because get_xsave_addr_user() should
return a user pointer in the first place.

> +
> +	err = 0;
> +uaccess_end:
> +	user_access_end();
> +out:
> +	return err;

So none of the above voodoo is required at all.

       return __put_user(pkru, get_xsave_addr_user(buf, XFEATURE_PKRU));

Is all what's needed, no?

> +/*
> + * Given an xstate feature nr, calculate where in the xsave
> + * buffer the state is. The xsave buffer should be in standard
> + * format, not compacted (e.g. user mode signal frames).
> + */
> +void *get_xsave_addr_user(struct xregs_state __user *xsave, int xfeature_nr)

void __user *

> +{
> +	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
> +		return NULL;
> +
> +	return (void *)xsave + xstate_offsets[xfeature_nr];

  return (void __user *)....

Thanks,

        tglx

