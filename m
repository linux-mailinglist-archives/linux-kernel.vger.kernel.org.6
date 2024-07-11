Return-Path: <linux-kernel+bounces-248595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937D592DF76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B435283F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FCD6EB7C;
	Thu, 11 Jul 2024 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZOXrs43I";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CSwpWI6L"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E142042;
	Thu, 11 Jul 2024 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675667; cv=none; b=lm/wZbEOu5HRixZLHXQPaVnTb9Kf4NOs1lQB7o2aKX4/6ONaYwc/Sc1kHg6ymyGhKN35wPi3I7SyAgiPpl6hxWxudzO1S1GgYD88sScVRfaNJTBjcZSAAoiqXOHHUautucGrZVcxDYT/BXcqzH5/VUWUwp/VDSE2qymxYW7q4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675667; c=relaxed/simple;
	bh=HSsX0RnRuDFdjgHKzOQtBjgv2nX0He6FmULrIZgV2do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mi5md1nnfk3nCvfIsOTX1BRlNGkUnUtiw6ugn3koiLVrOe1mk/sywHm1hfL3Mcr+GLZLLMkRfpg9hjoPSzBSrhCzhKX24NL86RfUD1O8wk8kwsjocaLS5/a0ilUl0uA8pMsLrsEYZ78MrNs2/6vcFmPkCcgmuwWENkIg3AsOhYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZOXrs43I; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=CSwpWI6L reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1720675664; x=1752211664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSsX0RnRuDFdjgHKzOQtBjgv2nX0He6FmULrIZgV2do=;
  b=ZOXrs43ISmbjEKXnExZdRQfpw/PvqOwc5L5J3d2g76O7m45M5zFMSn/8
   FKco8rFUHGOwZRFy+VQqPpJzNJYopbpoddA44j61JrP2CUQdVv10AMzj0
   bl01lb6a74ui400RoGqQI4Qph96MCx+/i8ivFzmzpuBhgBXLNmrnviecU
   C/kvsi/EZ/LOlkc9psUPHx4QADTxxlS14LZ/ah/9BVZrOux71s+DE6pTB
   mSUDNerO5qgbZ+9VvWQGyl/3eVimDrqzOYPwfzyk/JkWN+iS0NPQbPXLD
   AHvM0JbaW7f2tSAE/mO7mkdWl1sZyXY993yD0NsEgrxKjGPj0+nKX490n
   A==;
X-CSE-ConnectionGUID: 4R+YyxF4TvuAdyuF6HKwhg==
X-CSE-MsgGUID: Fn3IlePpQkWP6bFs1b+N/A==
X-IronPort-AV: E=Sophos;i="6.09,199,1716242400"; 
   d="scan'208";a="37850448"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Jul 2024 07:27:40 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A54FD16337A;
	Thu, 11 Jul 2024 07:27:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1720675656;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HSsX0RnRuDFdjgHKzOQtBjgv2nX0He6FmULrIZgV2do=;
	b=CSwpWI6Lf4xrqzWYv5+Hmj2pkBU90Gz5eSk8N1mrQhjPh9iid9DEuc3WNe/CBO2vvRCExT
	hjwwRzC+dNFp3HjXY1mfa1T4re9x2giweXhnmJhZTtfGmzLUZIRf7NdRIoxcLlIfRFGzE0
	ejAQfvXWaP1AWJ5im+lmoYtF4QDEU3kuUJZdBcfY3L2gJPWXUgJh3qBIAI02iTxLQHL1mT
	RBAQi/t5pPQONzWEOqokoAVFyiLLeCUIx3R0QESg0Z1SQ70S5oweDGm22Ibw6H/xQaVuIC
	sztdr1U8B/GpEW3FoKO8JmKS146OS9hgGNJ2Udwkn35e9BV3xH+AqJ7iGjfaCw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, mturquette@baylibre.com, Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: clocks: add binding for generic clock-generators
Date: Thu, 11 Jul 2024 07:27:40 +0200
Message-ID: <1899010.tdWV9SEqCh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <68f6dc44a8202fd83792e58aea137632.sboyd@kernel.org>
References: <20240709123121.1452394-1-heiko@sntech.de> <21244242.0c2gjJ1VT2@diego> <68f6dc44a8202fd83792e58aea137632.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Donnerstag, 11. Juli 2024, 01:21:15 CEST schrieb Stephen Boyd:
> Quoting Heiko St=FCbner (2024-07-10 00:45:17)
> > Am Mittwoch, 10. Juli 2024, 09:02:34 CEST schrieb Alexander Stein:
> > >=20
> > > So essentially only enable-gpios and vdd-supply is added in compariso=
n to
> > > fixed-clock. Does it make sense to add that to the fixed-clocks inste=
ad?
> > > Similar to fixed-regulator.
> >=20
> > I wasn't that sure which way to go in the first place.
> > The deciding point was reading that line about the fixed clock not
> > being gateable, so I opted to not touch the fixed-clock.
> >=20
> > But you're definitly right, this _could_ live inside the fixed-clock
> > as well, if we decide to get rid of the not-gateable thing above.
>=20
> It's probably more complicated to combine it with the fixed-clock
> binding after making properties required like vdd-supply. I'd just make
> a new binding and look at combining later.

Maybe I am missing something IMHO adding optional vdd-supply and
enable-gpios doesn't seem a big deal.
Anyway I don't have a hard opinion here. To me fixed-clocks still
seems very appropriate for having a controlling GPIO and power supply.
I just would get rid of the (comment only) hint they are ungatable.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



