Return-Path: <linux-kernel+bounces-529410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37E2A425E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E9D16F329
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777691FC7DA;
	Mon, 24 Feb 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YeMchzhu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Yhkf86Hy"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995EE192D97;
	Mon, 24 Feb 2025 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409316; cv=none; b=fDKtlvpeMYOEihGug2SBGU/t9o2geuRvQMBTjkJIsQevCuLZfjl+GtuVXiTpHhvhCX4RO+XbK+U3pejgiuZACq1IzhTtSZqccJpZ2gohmH0E9IHsf19ZsmyCES26aZYogaEAUMCOOisf6/pwnDCQPG/OtaFeS+hMSTshrHQtC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409316; c=relaxed/simple;
	bh=0vgPCjuI1eJZYbLDfgbr1Uw7fIRlLSv275jSMkiMWms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXV6o4fBxdpLaZ+xmFSlExhxMbbdOyhBRxdaq3R62FvyVZVh/bAg5Yyiw8Q28sEJ36YClA9EYGF7VoS1Xb3iwUEKUjirYx4GTjRzd4m6MYCQ5Rgu802IWURa+VofV23F8xGK6tlqHQG92V92BWAoHveHQCBULDU26835YLunZOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YeMchzhu; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Yhkf86Hy reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740409315; x=1771945315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0vgPCjuI1eJZYbLDfgbr1Uw7fIRlLSv275jSMkiMWms=;
  b=YeMchzhuFwDuPMJl4WEVtYcpo2x5ew434u67pshPlmJ/vn8AtkMzR/zJ
   nKedlKQ/IMe055FqqK3YXtPqWX8oMHaOwaf2duK7FsPr6qG/W0hIHFsK/
   TXN+dlJ4QwdRKGi7WNcRYPmNpNzfmYn64NmiOSj6fCy1Ies0nT9czWoe5
   um3sb35dBz9lfmDLCPcNuTsKa5An2EfFMt5jFPjoxLNLwY2Gga4N7Bh+c
   tKfghsa05lac/6S+t8OUUAghNb3cpnXHl7oA8q9T4d6sEsxvm7wOGgNQa
   g4lcoA7A29kdur+nXpnFCl+IAO3Iun1k4rgBNtFR2DioAO4rxIUym3rJS
   g==;
X-CSE-ConnectionGUID: 5dJT9lkORb2bXGaN9wqrRQ==
X-CSE-MsgGUID: 3M5nagRHQgO5oBudA1DgGQ==
X-IronPort-AV: E=Sophos;i="6.13,309,1732575600"; 
   d="scan'208";a="42043119"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Feb 2025 16:01:52 +0100
X-CheckPoint: {67BC89E0-16-6E0A4539-DBC44C3A}
X-MAIL-CPID: DF92074B598E4880E8D6D2A2DC4D7C0A_1
X-Control-Analysis: str=0001.0A00211E.67BC89DF.0016,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69A1416798B;
	Mon, 24 Feb 2025 16:01:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740409308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0vgPCjuI1eJZYbLDfgbr1Uw7fIRlLSv275jSMkiMWms=;
	b=Yhkf86HymiAEhVU5Mhl2xNo9I/xdvDYPOkBZ4PLhphiNHfstietFbhe4efwDFjXVTm1rRS
	cP1Rsi3BPwN2UiOdkcvd2nJOLAqgxnFiDOlxkTha5kWUSUSqcezqeYQVt9og3zj7WG+yO7
	fLI442EWMXjTKkyZfqWINo1/moo66uUHgqEMdjk1/vKz3wd9I9AXca+jtZhrbJdWd5fCij
	My3WeokGvW/Qrlo2L1Uj8kESlWqB+XK4wnj5iD40639KTwMPr6d2UtBhLYJhTF7+fTInRO
	XwgfNHNxuXqsm1e670IIOADYQ3aQV+/U8zee74frAx8elptzxeJfNDh7zLc1+g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, linux@ew.tq-group.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: mba8mx: change sound card model name
Date: Mon, 24 Feb 2025 16:01:46 +0100
Message-ID: <6132446.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Z7mUU/Rgj3Gx7g9E@dragon>
References:
 <20250120132503.556547-1-alexander.stein@ew.tq-group.com>
 <20250120132503.556547-5-alexander.stein@ew.tq-group.com>
 <Z7mUU/Rgj3Gx7g9E@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Shawn,

Am Samstag, 22. Februar 2025, 10:09:39 CET schrieb Shawn Guo:
> On Mon, Jan 20, 2025 at 02:25:02PM +0100, Alexander Stein wrote:
> > From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> >=20
> > The card name for ALSA is generated from the model name string and
> > is limited to 16 characters. Use a shorter name to prevent cutting the
> > name.
> >=20
> > Since nearly all starter kit mainboards for i.MX based SoM by TQ-Systems
> > use the same codec with the same routing on board it is a good idea to
> > use the same mode name for the sound card. This allows sharing a default
> > asound.conf in BSP over all the kits.
> >=20
> > Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>=20
> I may have missed some prerequisite ones, but #4 and #5 do not apply for
> me.

Thanks for pointing out. A local commit was silently introduced as dependen=
cy.
I removed it and pushed a v2 while also fixing a typo in the commit message
'mode' -> 'model'

Thanks
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



