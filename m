Return-Path: <linux-kernel+bounces-385413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCFA9B36E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64F4281B15
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5EB1DF278;
	Mon, 28 Oct 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fAbfWwJA"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C71DEFE7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133787; cv=none; b=Q7ZU6GB2UrttY4/lh3dHG4zHMH/mJ09X6x1f/d7ryVvTkgphSkyTbOqkCNicjTem0ddD9Pm+BP+JU+EwIxpbFAF6etJejod5DTTaqj+G5FUOgFuOFdJ8lDPku9cQwb6EiIoUBpO4vTKh3GFfh4jeu6dYmdmutNel40n5QFMteAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133787; c=relaxed/simple;
	bh=JNJOKl46jLJGslGf5ErGbfwDYIGBl5tbyg7Z4INFYnE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BIPueNbAbVSIRBDCOOGEI0zUJeonBgAgUdomvP+8NA1CiCice9fbt+T76dVRurrwRj02diqecdsV8jUmg02bMH3RQsdgBRVmB4WzxEJj7MvzTE84juXXux9Fb6oJseZGtoP5+5s74/g89Sb8YAxbt38Dm1aTTuU0b3rR5YCezw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fAbfWwJA; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730133782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4O8OJBMmnm9/5Y9Az0M1fjT/ZmToxjWCi2Zmw5OLgU4=;
	b=fAbfWwJAKII7zSjhj2Ie8iww6pzvSWrpog9UAo7EosWHY2MI9W4RTI4KYFiybWs6NtduNI
	nmogNGZgJXsxQY5382OFMNyl8/ixOCKC+PeJDWRQXR77aMNNj6qlkGCZDnl5/5xiwS8pUn
	SrCHRMUe/mUTG16FX1WPA0MHFrB+Pbc=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH net-next] ieee802154: Replace BOOL_TO_STR() with
 str_true_false()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <173013100436.1993507.7802081149320563849.b4-ty@datenfreihafen.org>
Date: Mon, 28 Oct 2024 17:42:47 +0100
Cc: Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B24A2C8-B684-4A86-AEC7-198891897F56@linux.dev>
References: <20241020112313.53174-2-thorsten.blum@linux.dev>
 <173013100436.1993507.7802081149320563849.b4-ty@datenfreihafen.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
X-Migadu-Flow: FLOW_OUT

Hi Stefan,

> On 28. Oct 2024, at 16:57, Stefan Schmidt wrote:
>=20
> Hello Thorsten Blum.
>=20
> On Sun, 20 Oct 2024 13:23:13 +0200, Thorsten Blum wrote:
>> Replace the custom BOOL_TO_STR() macro with the str_true_false() =
helper
>> function and remove the macro.
>>=20
>>=20
>=20
> Applied to wpan/wpan-next.git, thanks!
>=20
> [1/1] ieee802154: Replace BOOL_TO_STR() with str_true_false()
>     https://git.kernel.org/wpan/wpan-next/c/299875256571

I'm actually not sure this works after getting feedback on a similar
patch [1].

I'd probably revert it to be safe.

Thanks,
Thorsten

[1] =
https://lore.kernel.org/linux-kernel/afe1839843d8d4dd38dd9368b2e30f0aa6864=
b9a.camel@sipsolutions.net/=

