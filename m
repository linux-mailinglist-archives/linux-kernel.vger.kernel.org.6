Return-Path: <linux-kernel+bounces-343234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DD698986F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F661C20DC0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7917E473;
	Sun, 29 Sep 2024 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZdMRbD+a"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703718EB0;
	Sun, 29 Sep 2024 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727653464; cv=none; b=M+qe+6lgOyKSGM/ZSW8I6OEtdfQGssjmYu7OweydFQ3KKocAKFC4Mjel+zQl2qz7U93cGRoGPJXPjbwQWXLO59qYJgRL1Zq3+PTc3ON+tgbm/uKW3npJVm70VG1S1zvTYL0Uk9M/o08Vs/Z+X89CWPZdteHEQovEe5+49XZbWvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727653464; c=relaxed/simple;
	bh=DUHSA+H0FzMEJ1EbxCc6fKlUtQOM8ce4G5R8tqRAodk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hjM64+HpWWfHxysQzvNRqe2Z24WAm5tMH1dJGm3XjYbsdqMmcteEJ3UO8956Kmn6TuAok+47pneYjXP1eGVASsRt3lxLvWYW3UfSdJbCju3BWmiDBHnYLLsNq+Tvs652G4rPr4ZS8++/rMvGidYLZmXksRxx72giCiwMRb/Q8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZdMRbD+a; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727653460;
	bh=JwDoGKRxS+YXAWQHk5KGk+HoFswK8C94/IS1YdzMkug=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZdMRbD+aBX0vD0MMmOVvIhJ45cVbGYHTPtdoqZoiAopSOUIOd7Uywyj6nYWafm6Bh
	 OEQz5fh95u5j/n8evDnrJfXc1mN38YJO+lf8Ag8Oqd/KYkSzruTEUzRgxkbhyepB5s
	 25ShunBzKpjCZFbXoFUSYa3JsbKzr0WYhWA4fz88UCKMRyAZEM0GsOzws+F3rclQIs
	 dAVKEn3NCLuVjCEUcMZWRhrNY4vazqRrUcKa0CiwClHMCX8Rsow5DJIyonWCm4g78F
	 u8bqJO17C55rGlE/O6mwVqN8DuQcBLyNNAlkpDuZ7FCJ96j3FqZ6S4ubIH/z8xHRO5
	 XjAKRHjiaamGw==
Received: from [192.168.68.112] (ppp118-210-187-56.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.56])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8B57765866;
	Mon, 30 Sep 2024 07:44:18 +0800 (AWST)
Message-ID: <16c89a7b9b85d21f1f23aa0d67742c6bde94a295.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD
 IOE on Spider Board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Patrick Williams <patrick@stwcx.xyz>, Delphine_CC_Chiu/WYHQ/Wiwynn
	 <Delphine_CC_Chiu@wiwynn.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ricky
 CX Wu <ricky.cx.wu.wiwynn@gmail.com>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Mon, 30 Sep 2024 09:14:17 +0930
In-Reply-To: <Zvdq7o6NFXRVCJqX@heinlein.vulture-banana.ts.net>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
	 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
	 <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <Zvdq7o6NFXRVCJqX@heinlein.vulture-banana.ts.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ricky, Patrick,

On Fri, 2024-09-27 at 22:33 -0400, Patrick Williams wrote:
> On Fri, Sep 27, 2024 at 09:24:11AM +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wr=
ote:
>=20
> > Would like to ask should I base on the openbmc/linux repo to create the
> > remaining patches that have context dependencies and add the lore link
> > of the those patches that I've sent in the cover letter?
>=20
> I believe you're trying to get the patches applied onto the upstream
> tree, so no you should not base on the openbmc/linux repo.  That repo is
> a 6.6 branch.  You need to base the commits on torvalds/linux.
>=20

In my previous email[1] I requested:

> Please assess the remaining yosemite4 devicetree patches (those you
> haven't received a thank-you email for) and send an appropriately
> constructed series so they can all be applied together, based on the
> tree here:
>=20
> https://github.com/amboar/linux/tree/for/bmc/dt

So I'm not sure why there's confusion and speculation as to which tree
should be used :( Note that the for/bmc/dt branch above is currently
based on v6.12-rc1.

[1]: https://lore.kernel.org/all/fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.c=
amel@codeconstruct.com.au/

Anyway, I asked that because I have already applied one of the
Yosemite4 patches there, and developing the remaining patches against
any other tree will again cause conflicts (due to the lack of that
patch).

More broadly though, Patrick is right: If you're sending your patches
upstream, it is required that you develop and test your patches against
an appropriate upstream tree. Usually this is the most recent -rc1 tag,
unless there are reasons otherwise (such as conflicts). The OpenBMC
kernel fork is not an appropriate tree on which to base work you intend
to send upstream.

Thanks,

Andrew

