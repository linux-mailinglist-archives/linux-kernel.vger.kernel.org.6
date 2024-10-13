Return-Path: <linux-kernel+bounces-362692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DDA99B81B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 05:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C6C7B21B02
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1BF126C04;
	Sun, 13 Oct 2024 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b="kSbK428M"
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418484A32
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728789062; cv=none; b=QbtPBdW7fT5mOhXNF1KadzNEVSef67oxc7zITr18+oagmtvZzOFYlnmoh20WD/oZEAp21xUdmTKmudpWHUkHwJ8fW5HD98CcU58ohvpl3H+BH2OtJheuObx1g11u15HUuSWZpM9TUBEVg8uYVsK2S9GEQWkwnskkuK2pZG+uP7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728789062; c=relaxed/simple;
	bh=3uUsZnu+kUSo0575nwsgs4mgiOiIAeWCazvu/yyBgcw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ToTYpVBNF1YK5y09TKQzNcNHMg4iTnLib3CBpugIxsNMRhDmcc3T/IGBHCILIrCAEpYQdRWvooWN8lKyjiXKFeUxo7oDBWczxViQeHLQ1FEeursgtEcEPiUF9lOprRngdPGR6XlWXAVwjcnBxS5+QZCqx2g0MofgtJFAfLoAN8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus; spf=pass smtp.mailfrom=bens.haus; dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b=kSbK428M; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bens.haus
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id F16A72C4ACB0;
	Sun, 13 Oct 2024 05:01:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728788509;
	s=s1; d=bens.haus;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=3uUsZnu+kUSo0575nwsgs4mgiOiIAeWCazvu/yyBgcw=;
	b=kSbK428MyEt+ItkvvzTO3/SwZWcRFiCNGjtOGA2Yk3kNQOtAQO8HUPpNG1imMtXu
	CvhRs9gsvQzGyyTrcTNFz5KsNT3dRrh/aBT0MzOqjbJf9PIvV5/APOXNGApkEXHmrEf
	NP9YlKL69ImYR6chM/3p7XwYPGgUffeTW2CkuBU8f8lVhWQaVWPLbggJpnqTf40/Wxd
	A37maJBAZ/FxryQESRiUIfCaN7mVXbGVlcyOblrikK3Jd9xEdAYk3ESKk69Ldx2FK65
	A6YyBKVgEPa17dBpLqnqBFDVyuS69TDGP++9LrsyQ5q5VoNF7Koak/ImhIYajAYYrcB
	SjrAKhLwlg==
Date: Sun, 13 Oct 2024 05:01:49 +0200 (CEST)
From: Ben Schneider <ben@bens.haus>
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
	Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <O92omtT--B-9@bens.haus>
In-Reply-To: <87ed7tlnxj.fsf@BLaptop.bootlin.com>
References: <20240603012804.122215-1-ben@bens.haus> <20240603012804.122215-2-ben@bens.haus> <20240605194422.klxtxgyljrrllkzy@pali> <dce98e50-6b50-4d4e-abe2-8419a675d25e@lunn.ch> <O1XjBTq--3-9@bens.haus> <87ed7tlnxj.fsf@BLaptop.bootlin.com>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jul 16, 2024, 01:51 by gregory.clement@bootlin.com:

> Hello Ben,
>
>> Jun 5, 2024, 16:44 by >> andrew@lunn.ch>> :
>>
>>> On Wed, Jun 05, 2024 at 09:44:22PM +0200, Pali Roh=C3=A1r wrote:
>>>
>>>> So, go ahead with this change with my
>>>> Reviewed-by: Pali Roh=C3=A1r <>>>> pali@kernel.org>>>> >
>>>>
>>> I defer to your knowledge in this matter.
>>> Reviewed-by: Andrew Lunn <>>> andrew@lunn.ch>>> >
>>>
> Acked-by: Gregory CLEMENT <> gregory.clement@bootlin.com> >
>

Hi maintainers, I don't believe there are any outstanding concerns with thi=
s patch. Would one of you please merge or let me know next steps? Marvell a=
ccepted the patch to fix the bootloader instability in May, and I've since =
had two devices running stably with frequency scaling enabled up to 1.2Ghz.=
 I've kept track of my work here:=C2=A0https://github.com/bschnei/ebu-bootl=
oader

Thank you!

Ben

