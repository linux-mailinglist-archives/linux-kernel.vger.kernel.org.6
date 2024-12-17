Return-Path: <linux-kernel+bounces-448892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C07F9F46E6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DCD188E99C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AC31DE4C0;
	Tue, 17 Dec 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yqd1k7Hn"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA5F1DE2C3
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426572; cv=none; b=pGj5rakDYGwh56DeosTbHn6RlQi7oUIFMXJetmYRv7EIHWYX/0XV6RL3FjyvBS5/vGZcxcYECDWLDdWl0qfHviox/ZWIUsMwZUrE9Nhv9Sn+pTIj4L5PjywgyRhi+0BCD+TokhoO2X9N1Fmz9zWS2wzWcjAgBthwkRwDk2mXmGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426572; c=relaxed/simple;
	bh=ApEhb33uCE8yBRHsse69NJsbjohMokRhjRb2vxI8iFA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mkuMkYEwTwIj++oF9d7m0cNMqYHSaG61nbFx+4S5EpMy2FyDhqU0D/riNLAdqNvre2xs/awzboTKBsvo29OJMl/WE9BdhCCKZPQfH7FSuDZrNhPlkeUugpuLcLRIbXkXUwoocHdDYs5+d76YeEzUR+Nh6WEYKNXOjq2Yzrq11kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yqd1k7Hn; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa6869e15ebso633831766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734426568; x=1735031368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdTUhvict8QP95ODVq3VBD/97IqwhvwNQQSLRxy9C2k=;
        b=yqd1k7Hn7dBHYVqBiwJ5KytpJ4e9SzbUFOI8tU8VIz4jzFEVJo9BHK4YVLw9tAm8xr
         hmFNK9gySXMdwO9TSE3+v0YZmawmdr/ik9+8nd5vJkoq9CqHiuyOudcfyUk3uHzTM3OI
         1c/5tFEeXNXUD16Wk+XiZ4i7FB6lQ67Nbcn63Jc3st0VCeb/3TGVkNJm43AMfsKZZEp+
         jaGGDdQYTSVOEEhfSkRzitJrGpKwAKNwbKJG3CS5mb1D/n7WdiJzAYyh7Kxdb2mC2LyW
         btyfspASSQJOyw2WvJ4LBckpMBNxVpECMD3JbHUoFFm66N7hiEGlzQJIr8/WiXSlvp6H
         2R6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734426568; x=1735031368;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GdTUhvict8QP95ODVq3VBD/97IqwhvwNQQSLRxy9C2k=;
        b=his10b0glc3PG6UR0bh8TRqfDO7eZWh4bvAMtxaUS3orb6tqKLPNGzox91l5XO7oeU
         sn1NRKs4h9wf3OTbTMvK3WzVYY3WSD+sNmiWOch817vp3U1LoS88mex1j+OKi0qK/c3+
         loq5SZlLyexz5V6Z13X+QHHyUlMMbVJTWCsm8PHd71KF1gLg1Jrw7v4g1etjg0nMXIga
         e2r1qHcM0YDAY0K03zbL52bqFQgVmqdTdiXLxsu3eNKx5ctDBz98xhuiQmdyjN74H2dw
         RweJizNy1IjebCLkeuZxLJoAWNBxBmomtziJZF8IsXt7Fu5WeWZuHGNG2QHjFtnEkiux
         bW5g==
X-Forwarded-Encrypted: i=1; AJvYcCUeXCcNNSIEXVzDQ4cQDNBLXx6Fl/9d42DHQB/b9qujptTgdaqjDX06A/jZneffeKqPN9DNmp/lKlnTLrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp0/grwSaJRuTBcyVLVseJUrHt6nxhuEemc8irUEc1nM4p3m2z
	pcFNyIjZVSW7XetjJmDnWNQeBGxLSuq0wDNAZ4lrNH/I/Tgt4B0tRuQegFVMS3zgt6WC+CAfPZp
	ySQ==
X-Google-Smtp-Source: AGHT+IGU20kqjTEH0qg2wrBjRVFipLJ0Ib95VwwIZLvzOerjf4VO//KSgFZw06uw+rufZ3TdiJ2B2NpM5Qs=
X-Received: from edyd21.prod.google.com ([2002:a05:6402:795:b0:5d0:821b:cd59])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2755:b0:5d0:7a0b:b45f
 with SMTP id 4fb4d7f45d1cf-5d7d559404emr2416074a12.10.1734426568415; Tue, 17
 Dec 2024 01:09:28 -0800 (PST)
Date: Tue, 17 Dec 2024 10:09:26 +0100
In-Reply-To: <20241216150722.4079213-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024121418-blazer-valiant-c51a@gregkh> <20241216150722.4079213-2-gnoack@google.com>
Message-ID: <Z2E_tqgqXIwi5j4C@google.com>
Subject: Re: [PATCH] tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jann Horn <jannh@google.com>, "Hanno =?utf-8?B?QsO2Y2s=?=" <hanno@hboeck.de>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

FYI, I have tested this locally - it makes the mouse curser show up again i=
n
Emacs.  (I do also believe that is it fine security-wise, but will also ver=
y
happily add a Reviewed-By or Tested-By from Hanno or others in the next
iteration :))

=E2=80=94G=C3=BCnther

On Mon, Dec 16, 2024 at 03:07:23PM +0000, G=C3=BCnther Noack wrote:
> With this, processes without CAP_SYS_ADMIN are able to use TIOCLINUX with
> subcode TIOCL_SETSEL, in the selection modes TIOCL_SETPOINTER,
> TIOCL_SELCLEAR and TIOCL_SELMOUSEREPORT.
>=20
> TIOCL_SETSEL was previously changed to require CAP_SYS_ADMIN, as this IOC=
TL
> let callers change the selection buffer and could be used to simulate
> keypresses.  These three TIOCL_SETSEL selection modes, however, are safe =
to
> use, as they do not modify the selection buffer.
>=20
> This fixes a mouse support regression that affected Emacs (invisible mous=
e
> cursor).
>=20
> Link: https://lore.kernel.org/r/ee3ec63269b43b34e1c90dd8c9743bf8@finder.o=
rg
> Fixes: 8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-paste s=
ubcommands")
> Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> ---
>  drivers/tty/vt/selection.c | 14 ++++++++++++++
>  drivers/tty/vt/vt.c        |  3 +--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index 564341f1a74f..0bd6544e30a6 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
> @@ -192,6 +192,20 @@ int set_selection_user(const struct tiocl_selection =
__user *sel,
>  	if (copy_from_user(&v, sel, sizeof(*sel)))
>  		return -EFAULT;
> =20
> +	/*
> +	 * TIOCL_SELCLEAR, TIOCL_SELPOINTER and TIOCL_SELMOUSEREPORT are OK to
> +	 * use without CAP_SYS_ADMIN as they do not modify the selection.
> +	 */
> +	switch (v.sel_mode) {
> +	case TIOCL_SELCLEAR:
> +	case TIOCL_SELPOINTER:
> +	case TIOCL_SELMOUSEREPORT:
> +		break;
> +	default:
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +	}
> +
>  	return set_selection_kernel(&v, tty);
>  }
> =20
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 96842ce817af..ed65b3b80fbd 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3345,8 +3345,7 @@ int tioclinux(struct tty_struct *tty, unsigned long=
 arg)
> =20
>  	switch (type) {
>  	case TIOCL_SETSEL:
> -		if (!capable(CAP_SYS_ADMIN))
> -			return -EPERM;
> +		/* CAP_SYS_ADMIN check happens in set_selection_user(). */
>  		return set_selection_user(param, tty);
>  	case TIOCL_PASTESEL:
>  		if (!capable(CAP_SYS_ADMIN))
> --=20
> 2.47.1.613.gc27f4b7a9f-goog
>=20

