Return-Path: <linux-kernel+bounces-427406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD6F9E0095
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A165C286583
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24E9209F54;
	Mon,  2 Dec 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c87NugaE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5ED1FE46C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138528; cv=none; b=B+stOaeQY2cEc274BvO5vGPmvl9kPOpm4XrFRiCW2KrFdEn5mr3kEca094bx90P4DM81CxVkfFrB4TcdjEfYzrChXVb0QJ71W8+diRZeOGixUpo1pgRQ1Imzjp1rUMo/FwvzYySkhfK6fQTosqGmeGOYfmjIla5jnbXpkisQB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138528; c=relaxed/simple;
	bh=aKC5m8Te3KxTEdZNz2E/rO1mlGWhjourLbO6QpI5uH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIsHdWU2rd59WOOzAAneq+qxlTBjoMU6zZ7B0/3o+CJDR9R5/ldXrXHd+TPymHgck6v4e1VPE3fzn7pRgWTEef4jwFfMZDlw0VpFSmkD49XDZBZUgAQoIwdQkRhcSuRKPDU10QApgropHtEgIVpHLIpkFPcg6FC833RqfHr6WjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c87NugaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4627C4CED1;
	Mon,  2 Dec 2024 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733138527;
	bh=aKC5m8Te3KxTEdZNz2E/rO1mlGWhjourLbO6QpI5uH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c87NugaEjNKKTPM/z0lz9VdoOrDqtpqOTBEC8jUCWTMoK0S2qJsJP3NzuKbW5TJsC
	 D1Glbqrc0nYR1ID+fmI1ciPx7PUfvYtOzPiTytdAE/fBqYv7Qr2VGTxfbzEWnsVChY
	 HxrwOPGLYFP1wmPJx/JyYAFewQbBX63RfFltsEWNT8gNe4w7bqfsv8RiVi1iQwMgw+
	 CrLk7qGQTP+ujusSnnzVEL6tisVVYR/g7TzMsWGhPoNWNK2uqgWPlEpQJwdxhjHcUc
	 b2ZLoQj5Y+aOG2kxU+t9jNZDHV42G2fSaswlIs7ImaMGxwKV+NB0l8PMwKA+ChL2Y/
	 RqTMYKQuWq54A==
Date: Mon, 2 Dec 2024 11:22:02 +0000
From: Conor Dooley <conor@kernel.org>
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, bjorn@rivosinc.com,
	leobras@redhat.com, peterz@infradead.org, parri.andrea@gmail.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	arnd@arndb.de, alexghiti@rivosinc.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RESEND PATCH] riscv: Fixup boot failure when
 CONFIG_DEBUG_RT_MUTEXES=y
Message-ID: <20241202-vertigo-dreamboat-4bf6b61a4ef6@spud>
References: <20241130153310.3349484-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PNVedD9oKqNR10oc"
Content-Disposition: inline
In-Reply-To: <20241130153310.3349484-1-guoren@kernel.org>


--PNVedD9oKqNR10oc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 10:33:10AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> When CONFIG_DEBUG_RT_MUTEXES=3Dy, mutex_lock->rt_mutex_try_acquire
> would change from rt_mutex_cmpxchg_acquire to
> rt_mutex_slowtrylock():
> 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
> 	ret =3D __rt_mutex_slowtrylock(lock);
> 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>=20
> Because queued_spin_#ops to ticket_#ops is changed one by one by
> jump_label, raw_spin_lock/unlock would cause a deadlock during the
> changing.
>=20
> That means in arch/riscv/kernel/jump_label.c:
> 1.
> arch_jump_label_transform_queue() ->
> mutex_lock(&text_mutex); +-> raw_spin_lock  -> queued_spin_lock
> 			 |-> raw_spin_unlock -> queued_spin_unlock
> patch_insn_write -> change the raw_spin_lock to ticket_lock
> mutex_unlock(&text_mutex);
> ...
>=20
> 2. /* Dirty the lock value */
> arch_jump_label_transform_queue() ->
> mutex_lock(&text_mutex); +-> raw_spin_lock -> *ticket_lock*
>                          |-> raw_spin_unlock -> *queued_spin_unlock*
> 			  /* BUG: ticket_lock with queued_spin_unlock */
> patch_insn_write  ->  change the raw_spin_unlock to ticket_unlock
> mutex_unlock(&text_mutex);
> ...
>=20
> 3. /* Dead lock */
> arch_jump_label_transform_queue() ->
> mutex_lock(&text_mutex); +-> raw_spin_lock -> ticket_lock /* deadlock! */
>                          |-> raw_spin_unlock -> ticket_unlock
> patch_insn_write -> change other raw_spin_#op -> ticket_#op
> mutex_unlock(&text_mutex);
>=20
> So, the solution is to disable mutex usage of
> arch_jump_label_transform_queue() during early_boot_irqs_disabled, just
> like we have done for stop_machine.
>=20
> Reported-by: Conor Dooley <conor@kernel.org>

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--PNVedD9oKqNR10oc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ02YOAAKCRB4tDGHoIJi
0u4tAQD6SZZZiL32ZYOosf6OYXIcB58LwhhQx8q9rpkdOJ83MwEAz5fGQp47QqnL
p4h17qAfQMMQncnXded5i6hV9r39kQo=
=MpJM
-----END PGP SIGNATURE-----

--PNVedD9oKqNR10oc--

