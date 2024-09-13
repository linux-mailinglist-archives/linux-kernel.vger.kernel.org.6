Return-Path: <linux-kernel+bounces-327940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BDB977CDF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 659ACB2A0DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F91D7E48;
	Fri, 13 Sep 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="g8A9plyT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dbBs//JG"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37D51D7991;
	Fri, 13 Sep 2024 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221921; cv=none; b=TvH6+2kFb9O2/SINX733hUq8gv0cgFU7z2geSPrApxhabJyubmMrn8pLXMmvnDa7sUoBtRtcH9V0m/Jdff4FKF0gnBPBkholwNTtpGS8S+u4CwzcqZOUE3ttnWxB2pSpO1cty0y7Ya48KgTu4WoF0sm+6xvfwVa3ACC2H9mvsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221921; c=relaxed/simple;
	bh=iUwICgjRJY7EChP4Mk7u9O13h+fgwLzpT/CTu01MYg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukhVFvsWU+JREXpfpAcJZLCQAxi5tEV21zSCd029VffEzx9gveYxNXoB+0IRaVWjqq86AknYOau5ODeSSX9ugddi2g31ZE7/2Av4yob6AYqMkaentZZGQz7aJ4uptD13pvCo2kc8B+0AP8GpWVtRbG5scAvbkORSeRD6fwG56fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=g8A9plyT; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dbBs//JG reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726221918; x=1757757918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iUwICgjRJY7EChP4Mk7u9O13h+fgwLzpT/CTu01MYg8=;
  b=g8A9plyTPjI6tswesVHrACiGvH+FKcvJm5maASrohyMon4wBfEWOuCkS
   EXbrezue3OpWBziT9F066UXtsddaNK9KMYIiYYeO0VYcNEJ6OgWkil9CX
   aXOzGUDTza/XKznxx+Wekq6xSaUjsKgrutb6aNB1Rnw2myU+CNpoCBihE
   A9ZLiVH8s7xQkspXRqXi5ET8V6chWmDguJd8iiB7cw5ODrKkDQDcITJDE
   GcbvFpBuO+SM305is9soaaWXfKu7ZfynZWrVbUDb6+vpOtzTtQdG2hus8
   Yyb8dRQ7N4soxZKfc8VRgM6r1h6C8e8k1THUAOWUqozt4jcS3cqC3ECvk
   Q==;
X-CSE-ConnectionGUID: jMYiFZVGR9K5JwinR1reSg==
X-CSE-MsgGUID: MT4M9Ws7QyKseA9HON+ZiA==
X-IronPort-AV: E=Sophos;i="6.10,225,1719871200"; 
   d="scan'208";a="38931165"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Sep 2024 12:05:15 +0200
X-CheckPoint: {66E40E5B-0-22BB8E18-F5F6D0B4}
X-MAIL-CPID: 7046A3EE398502D92DFD192A872BB005_5
X-Control-Analysis: str=0001.0A782F22.66E40E5B.008B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6ED34167CDC;
	Fri, 13 Sep 2024 12:05:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726221910;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iUwICgjRJY7EChP4Mk7u9O13h+fgwLzpT/CTu01MYg8=;
	b=dbBs//JGN/w93yZCVs4TJ3y3UYZdyf0g/eX4ejgS/awaNJqgg98KpIkbLg9mLg/pq6YqDo
	6aThuJnvYtKm322fowoWEfu/wy7xExwKBoTLC9PVB4XZlTLLKPqnnebyZZBqfbPT0qPsA6
	xYtCSS4Q3SkaeWRofThVh29okMzwYz67jOeDjlRcNOzGPfdWl46wB4NtoUTyXi97tgyGil
	QtAPefzNRS4WounJKHxtKfVVnbeD6dmIg3+04DLNl8uvRxRVcVcAvK+e8x7WqqiwhzGm0+
	G2ZGfHDhULE2YpQEXSHhrFWByL2nPjxiTrC8lRWPZnpsy9HG79uzRfZoMw/a/Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org, jkridner@beagleboard.org, robertcnelson@beagleboard.org, Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Ayush Singh <ayush@beagleboard.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ayush Singh <ayush@beagleboard.org>
Subject: Re: [PATCH 0/8] Add generic overlay for MikroBUS addon boards
Date: Fri, 13 Sep 2024 12:05:05 +0200
Message-ID: <8428068.T7Z3S40VBb@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Mittwoch, 11. September 2024, 16:27:17 CEST schrieb Ayush Singh:
> Hello all,
>=20
> This is an attempt to add MikroBUS addon support using the approach
> described by Grove connector patch series [0].
>=20
> The patch series tests out 2 addon boards + pwm and GPIO on the MikroBUS
> connector. The boards used are GPS3 Click (for UART) [1] and Weather
> Click (for I2C) [2]. Additionally, I have tested relative GPIO numbering
> using devicetree nexus nodes [3].
>=20
> The patch series does not attempt to do any dynamic discovery for 1-wire
> eeprom MikroBUS addon boards, nor does it provide any sysfs entry for
> board addition/removal. The connector driver might include them after
> the basic support is ironed out, but the existing patches for dynamic
> overlays work fine.
> [sniip]

To put it in a more abstract perspective, aren't you "just" defining some
kind of connector with a fixed layout of pins and features?
It's not really different to Arduino Shields and Raspberry Pi hats, no?
Ignoring multi-purpose pins for GPIO or e.g. I2C, this is about matching
the plugin module's pins to platform-specific on-board peripherals.

Sticking the name to MikroBUS might be misleading, because this is AFAICT
just a trademark for a specific connector pin layout.
This concept could be applied for any kind of connector, where e.g.
the I2C interface is mapped to i2c0 on one platform and to lpi2c5
on a different platform.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



