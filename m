Return-Path: <linux-kernel+bounces-378798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF99AD598
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294E91C22573
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9218E1E2309;
	Wed, 23 Oct 2024 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aRCwCFVt"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE88F1C9EAF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715779; cv=none; b=tRU/5X/DVSzL90aX7VOiDRPP98J2KZvElElmzNYJ/wnlmAckuDPU5Ox+kAW0FsMbV5pmWf8ejLvtU0sWu5sdpT8UqckVY6XUZyv0TqWnZ48fDcjqL1bZa9m/za9/b2r1dUswdmM14sQ0fbga9+xCmUwSmZdnmZlHUyAb6htMqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715779; c=relaxed/simple;
	bh=ImpcvNwf9+ua7BFJtbBufY2KH5qLmceGY0AN2fY093Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qNbcB2eZ4XhoVNIn6RlIlK8nARAhFVph4Hed5slYgwNxs1ejh+MCJ8aDLvq0DVAAvPXQGgvuBPxXZMOTYytJu5FGSm3TVDDg4q6ITZ5XxkoOK1TblT40969xodXMZOql3C+jwGsOBLrNUyva9/ifJjIQZtRDK/TH6dp/gvWvElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aRCwCFVt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso1949525e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729715775; x=1730320575; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RbvnKbX4jWcPN4YvQIkbquOW0N0DaIfS55eb9txkjhM=;
        b=aRCwCFVtAT1kGGOzXnAqvxSp4CMAsToTMczGLdN0d/+jIKN+biboXDcAHqHalKgqFF
         UQlgDtm8Xo0ZDdCo9t4T6kuLnDxVgPBPLJa33p61jpjqiGJOrqXLXcDc+MKeBqjk9UWx
         gYp5oH2WvZKWNrtqYTPl+oea+5MZel+8JXe0tTfNey6M1AFM/83J7GNmWLBeBHzkRkop
         gSLGsLQNC9XAnLsweeSCzLnQOnIzEh6ylTEHsNfsJGzkfljdITmJ4yfia6+8gfT20IUi
         0fuxwQn1EMEyA6NDykiepBXnpks1joRyrdZptuBDyu31U2CMyZOmwrJtOptBc8tduotA
         dyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715775; x=1730320575;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbvnKbX4jWcPN4YvQIkbquOW0N0DaIfS55eb9txkjhM=;
        b=RtlNVQD0LlU8E7jsrjDl6B2HcN70uAouoxaeuSiWX4TpMCT3AB/v6VBHbPniU5aSzF
         5cUbpOzX14eAnYSE6hI783Sl6IMO3UbYh3wrMSpRF1hFmaMBh4fM5O120CYwBODwwJ2X
         VH4mS+HTrse/Csz8WVHEENi3NQUDsZIlH0Qfrxet91UlY4dIrBmhKb5v742ES9RGCMLx
         HXihJ6m7hZyP4C9EykwT7btZqDO3RKampQ74pwg78X6ImC2HcwF3iOmv8hvqAoMDCAqp
         viL9/rfORMeMtg67SE+f6BB0avvB95nc+MINn3OsWmqeAw41xQ5cmF1Gszvl+E8KkwRq
         /AdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz9mcDj/6/DeJ0gIMznD0SHJavP2MphDyu92zckBij9zcUy9/hvpQRoef+TuGiDYdoPnbWipafbZMsOzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoTIpu/l08IEntsfL6PVrfjnc3bH6mN/gaLquNnWhMHGxCEuGb
	DF5ySN/qf6hbdzjcr3MKp9AHMMSh8M/dGNhcRlE8aloCSlaQDg/zwn0suACYIpk=
X-Google-Smtp-Source: AGHT+IF0ep2UZrcetqT7EJ6Rh54IsLdUp+XzoEyg+qHkYl1gK0DR2Sna4p2w0BcP02uf0tBGVgzDrA==
X-Received: by 2002:a5d:56d2:0:b0:37c:d162:8297 with SMTP id ffacd0b85a97d-37efcf8ec62mr2440958f8f.47.1729715774871;
        Wed, 23 Oct 2024 13:36:14 -0700 (PDT)
Received: from ?IPv6:2804:5078:817:9d00:58f2:fc97:371f:2? ([2804:5078:817:9d00:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76e084b61sm1914443a91.52.2024.10.23.13.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:36:14 -0700 (PDT)
Message-ID: <533f6a578d8489c1107ba83ce1e49b6e2d5c84ce.camel@suse.com>
Subject: Re: [PATCH 1/2] printk: Introduce LOUD_CON flag
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky	
 <senozhatsky@chromium.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jiri Slaby <jirislaby@kernel.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Date: Wed, 23 Oct 2024 17:36:04 -0300
In-Reply-To: <8434kpfsvr.fsf@jogness.linutronix.de>
References: <20241016-printk-loud-con-v1-0-065e4dad6632@suse.com>
	 <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
	 <84plnz29zv.fsf@jogness.linutronix.de> <ZxDl-VcVAI8DGM40@pathway.suse.cz>
	 <847ca5rigk.fsf@jogness.linutronix.de> <ZxZYKe0t7jWX-_1K@pathway.suse.cz>
	 <8434kpfsvr.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-21 at 16:17 +0206, John Ogness wrote:
> On 2024-10-21, Petr Mladek <pmladek@suse.com> wrote:
> > > That will not work because migrate_enable() can only be called
> > > from
> > > can_sleep context. Instead, the migrate_disable()/enable() should
> > > be at
> > > the few (one?) call sites where
> > > printk_loud_console_enter()/exit() is
> > > used from task context.
> >=20
> > Hmm, if I get it correctly, we could not use migrate_disable() in
> > __handle_sysrq() because it can be called also in atomic context,
>=20
> I am talking about callers of __handle_sysrq() and/or their callers.
>=20
> For example write_sysrq_trigger() could do:
>=20
> 	migrate_disable();
> 	__handle_sysrq(c, false);
> 	migrate_enable();
>=20
> Or a new wrapper could be introduced for this purpose:
>=20
> static inline void wrapper handle_sysrq_task(u8 key, bool check_mask)
> {
> 	migrate_disable();
> 	__handle_sysrq(key, check_mask);
> 	migrate_enable();
> }
>=20
> A quick grep shows about 25 call sites to check.
>=20
> > I do not see any easy way how to distinguish whether it was called
> > in
> > an atomic context or not.
>=20
> There is no clean way to do that. If this information is needed, it
> must
> be tracked by the call chain.
>=20
> > So, I see three possibilities:
> >=20
> > =C2=A0 1. Explicitly call preempt_disable() in __handle_sysrq().
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 It would be just around the the single line or=
 the help. But
> > still,
> > =C2=A0=C2=A0=C2=A0=C2=A0 I do not like it much.
>=20
> Not acceptable for PREEMPT_RT since sysrq is exposed to external
> inputs.
>=20
> > =C2=A0 2. Avoid the per-CPU variable. Force adding the
> > LOUD_CON/FORCE_CON
> > =C2=A0=C2=A0=C2=A0=C2=A0 flag using a global variable, e.g. printk_forc=
e_console.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 The problem is that it might affect also messa=
ges printed by
> > =C2=A0=C2=A0=C2=A0=C2=A0 other CPUs. And there might be many.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 Well, console_loglevel is a global variable. T=
he original code
> > =C2=A0=C2=A0=C2=A0=C2=A0 had a similar problem.
>=20
> If disabling migration is not an option for you, this would be my
> second
> choice. I assume tagging too many messages is better than not tagging
> enough. And, as you say, this is effectively what the current code is
> trying to do.

Thanks for your input John. I talked with Petr and he suggested to
follow this option. I'll prepare the changes and send them after
reviewing them with Petr.

Thanks,
  Marcos

>=20
> > =C2=A0 3. Add the LOUD_CON/FLUSH_CON flag via a parameter. For example,
> > =C2=A0=C2=A0=C2=A0=C2=A0 by a special LOGLEVEL_FORCE_CON, similar to LO=
GLEVEL_SCHED.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 I might work well for __handle_sysrq() which c=
alls the
> > affected
> > =C2=A0=C2=A0=C2=A0=C2=A0 printk() directly.
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 But it won't work, for example, for kdb_show_s=
tack(). It wants
> > =C2=A0=C2=A0=C2=A0=C2=A0 to show messages printed by a nested functions=
.
>=20
> Right, this has limited usefulness and might miss the important
> things,
> which tend to be within helper functions.
>=20
> John


