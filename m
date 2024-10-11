Return-Path: <linux-kernel+bounces-361392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DFF99A795
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DC41C24D45
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A737194A73;
	Fri, 11 Oct 2024 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LaZhdkB/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TAp6DsOO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LaZhdkB/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TAp6DsOO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A580603
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660449; cv=none; b=eGPUzM6f5zZJydS/hJj5HmAUiYfqiFY6D4nUFJe3F3k3hB4Ue6ReAMLbxYAg721cfYrANKQ9Yi07n3EhXQ7T+6dtLoSfvNJo0xNJ8gSbn8FnW9KiC3VOekqEP8FMsQSBfjaYTHCw891FnRYiYrG85HDLOOOPMvAYQsMiYo1aGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660449; c=relaxed/simple;
	bh=Wdf4pQx6sgTL14SeiHdfA7Sqi1GVrtNVK7Zo+s2gNsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9me7sB8auuE85NiFOyqI30iylkD3MMLbNbxK9Yd6ABaRfznrZBFdYRE8Wn8UjSjpxcn9fnnmovGZhLbV3kANRjjVg4yUVIYLcZJcoaADE0RoddeAT/Jbo4+2ys3kpzqCIfnK0iFHmiLDibgY+I0mpG/YUC9BBA7NH0UtXOzgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LaZhdkB/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TAp6DsOO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LaZhdkB/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TAp6DsOO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3488F21ED0;
	Fri, 11 Oct 2024 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728660446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wdf4pQx6sgTL14SeiHdfA7Sqi1GVrtNVK7Zo+s2gNsY=;
	b=LaZhdkB/ZbMYkK2NfAf+JRdfa9TjmriamKNF8GIi8ziqtOf0UGFfkQhkvGHRZoGKJPO0QM
	s86wOZDXILAuUZrGkQp9Mauc6hhZ+e27fxFGDsljwYKBnTgKdgbAcPQCM4s4a12kyyv4QM
	dDpoFTyB4cJE6deKyEwXtOvSI8xLXSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728660446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wdf4pQx6sgTL14SeiHdfA7Sqi1GVrtNVK7Zo+s2gNsY=;
	b=TAp6DsOOM3/XTvSXSYvuWq8K2H7ARFjE9ic0LN19pZGeusFNjpGl17nI/qWZKagezkIYvs
	LodQr0IENLRDn8Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728660446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wdf4pQx6sgTL14SeiHdfA7Sqi1GVrtNVK7Zo+s2gNsY=;
	b=LaZhdkB/ZbMYkK2NfAf+JRdfa9TjmriamKNF8GIi8ziqtOf0UGFfkQhkvGHRZoGKJPO0QM
	s86wOZDXILAuUZrGkQp9Mauc6hhZ+e27fxFGDsljwYKBnTgKdgbAcPQCM4s4a12kyyv4QM
	dDpoFTyB4cJE6deKyEwXtOvSI8xLXSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728660446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wdf4pQx6sgTL14SeiHdfA7Sqi1GVrtNVK7Zo+s2gNsY=;
	b=TAp6DsOOM3/XTvSXSYvuWq8K2H7ARFjE9ic0LN19pZGeusFNjpGl17nI/qWZKagezkIYvs
	LodQr0IENLRDn8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 034951370C;
	Fri, 11 Oct 2024 15:27:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WoQNOt1DCWe1JwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Fri, 11 Oct 2024 15:27:25 +0000
Date: Fri, 11 Oct 2024 17:27:23 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-38630: watchdog: cpu5wdt.c: Fix use-after-free bug
 caused by cpu5wdt_trigger
Message-ID: <20241011172723.46827821@endymion.delvare>
In-Reply-To: <2024101130-underfoot-hungrily-f432@gregkh>
References: <2024062141-CVE-2024-38630-3640@gregkh>
	<efc8ab85e02b95ab4db09eb9142f62129a51f08c.camel@suse.de>
	<2024101130-underfoot-hungrily-f432@gregkh>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Greg,

On Fri, 11 Oct 2024 15:34:18 +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 11, 2024 at 12:16:40PM +0200, Jean Delvare wrote:
> > On Fri, 2024-06-21 at 12:19 +0200, Greg Kroah-Hartman wrote: =20
> > > Description
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > In the Linux kernel, the following vulnerability has been resolved:
> > >=20
> > > watchdog: cpu5wdt.c: Fix use-after-free bug caused by cpu5wdt_trigger
> > >=20
> > > When the cpu5wdt module is removing, the origin code uses del_timer()=
 to
> > > de-activate the timer. If the timer handler is running, del_timer() c=
ould
> > > not stop it and will return directly. If the port region is released =
by
> > > release_region() and then the timer handler cpu5wdt_trigger() calls o=
utb()
> > > to write into the region that is released, the use-after-free bug will
> > > happen.
> > >=20
> > > Change del_timer() to timer_shutdown_sync() in order that the timer h=
andler
> > > could be finished before the port region is released.
> > >=20
> > > The Linux kernel CVE team has assigned CVE-2024-38630 to this issue.
> > >=20
> > >=20
> > > Affected and fixed versions
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Issue introduced in 3=
.8 with commit e09d9c3e9f85 and fixed in 6.6.33 with commit 9b1c063ffc07
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Issue introduced in 3=
.8 with commit e09d9c3e9f85 and fixed in 6.9.4 with commit f19686d61650
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Issue introduced in 3=
.8 with commit e09d9c3e9f85 and fixed in 6.10-rc1 with commit 573601521277 =
=20
> >=20
> > For the record, this is incorrect. The Fixes tag is misleading. The
> > commit being "fixed" was adding a missing del_timer() call, so the
> > situation was even worst before that, as the race window on module
> > removal was even larger.
> >=20
> > The bug is present since kernel v2.5.61 when the cpu5wdt driver was
> > added to the kernel tree. =20
>=20
> So should I change the "vulnerable" commit to be the root of git, commit
> 1da177e4c3f4 ("Linux-2.6.12-rc2"), instead?

Yes.

--=20
Jean Delvare
SUSE L3 Support

