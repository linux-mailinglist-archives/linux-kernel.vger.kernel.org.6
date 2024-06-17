Return-Path: <linux-kernel+bounces-216851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17C190A76D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50CE1C24302
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844318F2C3;
	Mon, 17 Jun 2024 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="DqKmAZzN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="flsj+zTA"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C3A18754D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609826; cv=none; b=TqX16STAdRimXZOXBtyIweBObRkihr49fpcaCOaWJbkYDjdzbVteAs8+DAHu6E4GSdlvEpHfIiXPnIFYbTeRw21854DK6ZmyEWUqc2Uu0nndLbHt4kMwn9aWsVxziOUJ9gf24ZsTBTym54fcWcW82EcZk/BZn3LpMc75OdkTdmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609826; c=relaxed/simple;
	bh=Q/WSJU/Acv1z2whrZLO6cLrUyK6/M2W4/Xf9GQVSL88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nmn+v8LchOaR8kEZpos3ftgjgsSMDyz4bktDnj9h3rkcR6j5BUzjH+1sCHFauYpLvaJRSfWLHV+53xtxhiL+T304tDCTVC64DjMvAF7BrABdCWcI6j0Uav7Da/OW/xI0Y/a+d5VQWYOQHbrpCuQMTtm8eq7VfX4Hk1aj4JNrVRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=DqKmAZzN; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=flsj+zTA reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718609823; x=1750145823;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FTMbcUVKASWLqE0jEH4hIejFLqCbH8Mx8pZbr9RiJgE=;
  b=DqKmAZzNQLTnB2eKF3ia5qCLAdImoEt/CqTlBSA3UFtYLFPnb6EFGfOl
   h+Bm9SntwVKFs5N6vDLnK61rWxq25pBkUxqtBG5oISdaRQtQ6uGV4iHI0
   VlcgJuQFkAeAj2JPKo5qo/m+ogdByBvPAUEdWgvgQ6WWqHhMhLEqRHS/I
   aVMc7SsnYu3ixmbD74PK9vf4AHGsAO4+sAk5lvtvCK2ga/yHf3BHz8ckP
   RFT7oSD7aqsuv6Gw7oEW31Ez8XaTURgE3jIgYhydImEjFAkbPA87lQauc
   qd3uGssTwbf99lbIkqebvl+uLHdC5Euvq3bwFegiqLACYj7FyXA+cPqgw
   A==;
X-CSE-ConnectionGUID: igTvgi1xRFugJvm0erxacA==
X-CSE-MsgGUID: H2rpsFy6Rt6kFW9scmMM6Q==
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208";a="37419069"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jun 2024 09:36:55 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A2B3162E93;
	Mon, 17 Jun 2024 09:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718609811;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FTMbcUVKASWLqE0jEH4hIejFLqCbH8Mx8pZbr9RiJgE=;
	b=flsj+zTA+p1OhyKtA+OpxeEnKM/QvN6jin/J7nK+8KO+xuNOIuAQMGmlPp3jdwv68oS/4+
	P71+c/Kqf/Wt2rp2EqzSAEQNhHNtNu6y2zxoCFu1wPTSHWhw96HE8PsgNDcq+IVt2W4S0c
	dHHgmWuonhhbSTF6YKT+vgKupt8AhuElccmlPL/5UDj8KCglF5/pMnbG+i3qzL3arhMjB8
	hoEDVR7AZCeuLpvPg7goPupI391VYQzBFFNFnxkzrSFXnyJyx8PkXaCSyxmyforuFhJN3u
	CSu8u9s2BJfIslqpsA949k1W282DVwAmFe8MWpboV6jVG3DeboUDAGE3NBsnvA==
Message-ID: <4843378eed12ec48996c431db0659a0e8a99bb32.camel@ew.tq-group.com>
Subject: Re: [PATCH 4/4] mfd: tqmx86: add I2C IRQ support
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux@ew.tq-group.com, Gregor Herburger
	 <gregor.herburger@ew.tq-group.com>
Date: Mon, 17 Jun 2024 09:36:50 +0200
In-Reply-To: <20240614094939.GG3029315@google.com>
References: <cover.1717499766.git.matthias.schiffer@ew.tq-group.com>
	 <18d0348f2f7b70329e44f7759bad7e6fe231dba0.1717499766.git.matthias.schiffer@ew.tq-group.com>
	 <20240613154234.GJ2561462@google.com> <ZmwQkHvCdB3rPGEw@herburgerg-w2>
	 <20240614094939.GG3029315@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 2024-06-14 at 10:49 +0100, Lee Jones wrote:
>=20
>=20
> Note: Careful not to cut away too much context when replying.
>=20
> On Fri, 14 Jun 2024, Gregor Herburger wrote:
>=20
> > On Thu, Jun 13, 2024 at 04:42:34PM +0100, Lee Jones wrote:
> > > Just one question; what is (7, 9, 12)?
> > >=20
> > > And why is it the same as the GPIO one?  Copy/paste error?
> > >=20
> > Those are the IRQ numbers of the PLD. Both blocks, GPIO and I2C, can be
> > configured to use IRQ12, IRQ9 or IRQ7.
>=20
> Might I suggest we make that super clear in the help?
>=20
> (IRQ7, IRQ9 {and,or} IRQ12)

Well, 7, 9 and 12 are the values you would pass as the module parameter (an=
d we don't want to change
this, as it would be a breaking change). Maybe the following?

"GPIO IRQ number (possible values: 7, 9, 12)"


>=20
> Or similar.
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

