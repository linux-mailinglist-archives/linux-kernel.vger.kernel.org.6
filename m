Return-Path: <linux-kernel+bounces-189384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2238CEF55
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E499EB210F3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFD4537E7;
	Sat, 25 May 2024 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dHm2H7Jf"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7143AD1
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716647988; cv=none; b=lOxlclQc8edgsayNkg6xj14UHMnF8zw49x/4H9OKejMwCHMSIhHxfoTuXm/ARrqGndENuFeNCPKxl5RD8nFNS0BmKaiccJ4llK+Mz2ix5lbUF5/QTV3PqGENbZtKCxjFvRHD1jurQ8qdZ/ozQIIEPHcg+gWNrWqa0H1B5Wp4zeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716647988; c=relaxed/simple;
	bh=Y4T7pbQtADwH/bbaTgPIAdUqhjKHFrElhzFanucHHOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUCYYtfNukufE5+SYKNJcTEo5+Sj4WQE3jWf70Opguze+TTkRsc5hopedFqe6rnvgc6RYJpduv4W8bUs3rIYqxpYyWv+RmmdBJsXLI2M82buyrnwCoNtQqWpSvynkOTTZdJsm9IGU+1ny3dxmGELeuhNYxVP+cwVLLsUlzTvdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dHm2H7Jf; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vml170C44z6Cnk9X;
	Sat, 25 May 2024 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:reply-to
	:message-id:subject:subject:from:from:date:date:received
	:received; s=mr01; t=1716647976; x=1719239977; bh=wzdGIvVeas6cfl
	W4dzZNIQbq57bEwr0qOTTzIb9+4Co=; b=dHm2H7JftcP93Qm48MqeBtHr8OZzbY
	f6yobsQTgkeNL9N1mx8RRfAq0UrFClkjI7RueqPRrxQ2gq+oQtdBVeq5+CLIkK8G
	29feyF/I7vUluRFB+1pjkOiTdkCSEoguVjgLORU74uB8Wpsychq+nBnSmm79YKkl
	C+nMTirjKRVqxFIg1q76m7JcMQCXmdZwUJQ0Mr/v/2FgYWflzud8ymGo/1JxcFY0
	1FbjEf+1N4ycPFOTSVgxxEoHw6EDQ7K+eJe41E1/vd16p4YBZArA+6vvl+8DgTQi
	GKfPNkJBeUtvn9PFBX5SqroiF5U2zUPUpwAhLNF8cp2JNt+4ZAFhEnHA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dxHjxwqORrP9; Sat, 25 May 2024 14:39:36 +0000 (UTC)
Received: from mail.minyard.net (unknown [47.184.136.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: minyard@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vml136788z6Cnk9W;
	Sat, 25 May 2024 14:39:35 +0000 (UTC)
Date: Sat, 25 May 2024 09:39:33 -0500
From: Corey Minyard <minyard@acm.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	openipmi-developer@lists.sourceforge.net
Cc: Jani Rantanen <jrantanen@mvista.com>
Subject: Re: [GIT PULL] IPMI bug fixes for 6.10
Message-ID: <ZlH4JYGpbVd1CW8P@mail.minyard.net>
Reply-To: minyard@acm.org
References: <ZkJhmhatRHeKuIfE@mail.minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkJhmhatRHeKuIfE@mail.minyard.net>
Content-Transfer-Encoding: quoted-printable

Hi Linus,

These haven't hit the kernel yet, were the missed?

Thank you,

-corey

On Mon, May 13, 2024 at 01:53:15PM -0500, Corey Minyard wrote:
> The following changes since commit 8d025e2092e29bfd13e56c78e22af25fac83=
c8ec:
>=20
>   Merge tag 'erofs-for-6.9-rc2-fixes' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/xiang/erofs (2024-03-27 20:24:09 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.10-1
>=20
> for you to fetch changes up to 999dff3c13930ad77a7070a5fb4473b1fafdcecc=
:
>=20
>   ipmi: kcs_bmc_npcm7xx: Convert to platform remove callback returning =
void (2024-04-17 14:55:04 -0500)
>=20
> ----------------------------------------------------------------
> ipmi: Mostly updates for deprecated interfaces
>=20
> These changes are mostly updates for deprecated interfaces,
> platform.remove and converting from a tasklet to a BH workqueue.  Also
> use HAS_IOPORT for disabling inb()/outb().
>=20
> -corey
>=20
> ----------------------------------------------------------------
> Allen Pais (1):
>       ipmi: Convert from tasklet to BH workqueue
>=20
> Niklas Schnelle (1):
>       char: ipmi: handle HAS_IOPORT dependencies
>=20
> Uwe Kleine-K=C3=B6nig (6):
>       ipmi: bt-bmc: Convert to platform remove callback returning void
>       ipmi: ipmi_powernv: Convert to platform remove callback returning=
 void
>       ipmi: ipmi_si_platform: Convert to platform remove callback retur=
ning void
>       ipmi: ipmi_ssif: Convert to platform remove callback returning vo=
id
>       ipmi: kcs_bmc_aspeed: Convert to platform remove callback returni=
ng void
>       ipmi: kcs_bmc_npcm7xx: Convert to platform remove callback return=
ing void
>=20
>  drivers/char/ipmi/Makefile           | 11 ++++-------
>  drivers/char/ipmi/bt-bmc.c           |  5 ++---
>  drivers/char/ipmi/ipmi_msghandler.c  | 29 ++++++++++++++--------------=
-
>  drivers/char/ipmi/ipmi_powernv.c     |  6 ++----
>  drivers/char/ipmi/ipmi_si_intf.c     |  3 ++-
>  drivers/char/ipmi/ipmi_si_pci.c      |  3 +++
>  drivers/char/ipmi/ipmi_si_platform.c |  6 ++----
>  drivers/char/ipmi/ipmi_ssif.c        |  5 ++---
>  drivers/char/ipmi/kcs_bmc_aspeed.c   |  6 ++----
>  drivers/char/ipmi/kcs_bmc_npcm7xx.c  |  6 ++----
>  10 files changed, 35 insertions(+), 45 deletions(-)
>=20

