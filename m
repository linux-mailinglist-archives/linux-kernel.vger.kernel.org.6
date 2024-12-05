Return-Path: <linux-kernel+bounces-432787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0619E5052
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCCE169CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64791D5145;
	Thu,  5 Dec 2024 08:54:06 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDFD1B4F3E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388846; cv=none; b=J0QgojTaBeR6NyKJmtmMTyGW6EcsjiisfR0qZRUwK4Yc6iIzX3qytGN3+LRlU+16bPVW74mU8eatshXYikUqZpyEw7JtIsEuuG9MbOkdiY8c5gb1LHhyLqm9wB3oYgPw9F/detqK2r7AyF08dUNfotWtPS0+8ChRfx2XFG1Wttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388846; c=relaxed/simple;
	bh=h/YGaeMoa++vPH8ptdZ9aSxp1dQaKqRTCt4+Bc1ILms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DFyswK0mkMw3JzYiDyxhK6orq92PTI/RT5PCpm6PfP4kBGnvCqZRFZa7ZONVDZ8qGAFY0oP8+r94eMMgFH0slaXb6hmf99m8Y3wtCLkLoAZu4fgvYqHGMkHsmTvZKYcQ6s9XE4WSRJbaYzohvHS4s0kK1SCDj2X2181YtZ7GKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y3p6n16b7z21mbq;
	Thu,  5 Dec 2024 16:52:17 +0800 (CST)
Received: from kwepemf200002.china.huawei.com (unknown [7.202.181.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DB01180043;
	Thu,  5 Dec 2024 16:53:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 kwepemf200002.china.huawei.com (7.202.181.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Dec 2024 16:53:54 +0800
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 5 Dec 2024 09:53:52 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Vitaly Chikunov <vt@altlinux.org>, Marc Zyngier <maz@kernel.org>
CC: Will Deacon <will@kernel.org>, "james.morse@arm.com"
	<james.morse@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Catalin Marinas
	<catalin.marinas@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>, Gleb Fotengauer-Malinovskiy
	<glebfm@altlinux.org>, wanghuiqiang <wanghuiqiang@huawei.com>
Subject: RE: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Thread-Topic: v6.13-rc1: Internal error: Oops - Undefined instruction:
 0000000002000000 [#1] SMP
Thread-Index: AQHbRHc1pIGPV7SGf0u8eV81r8P21rLTBiuAgAAE74CAAAGXAIAAAhCAgABrXYCAALdLgIAAGCGAgAC+UYCAALHaAIAAowSAgAD/uVA=
Date: Thu, 5 Dec 2024 08:53:52 +0000
Message-ID: <156521fbdabb428a805e38c99f8f57c2@huawei.com>
References: <20241202045830.e4yy3nkvxtzaybxk@altlinux.org>
 <20241202153618.GA6834@willie-the-truck> <86ttbmt71k.wl-maz@kernel.org>
 <20241202155940.p267a3tz5ypj4sog@altlinux.org> <86ser6t6fs.wl-maz@kernel.org>
 <20241202223119.k3uod4ksnlf7gqh2@altlinux.org>
 <20241203092721.j473dthkbq6wzez7@altlinux.org>
 <1847e34fa7724d28aeb22d93752f64f2@huawei.com>
 <20241203221453.mwh6sozyczi4ec2k@altlinux.org> <87jzcfsuep.wl-maz@kernel.org>
 <20241204182231.ovvj6rpvcs2f5gv7@altlinux.org>
In-Reply-To: <20241204182231.ovvj6rpvcs2f5gv7@altlinux.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Vitaly Chikunov <vt@altlinux.org>
> Sent: Wednesday, December 4, 2024 6:35 PM
> To: Marc Zyngier <maz@kernel.org>
> Cc: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>; Will Deacon
> <will@kernel.org>; james.morse@arm.com; linux-arm-
> kernel@lists.infradead.org; Catalin Marinas <catalin.marinas@arm.com>;
> linux-kernel@vger.kernel.org; oliver.upton@linux.dev;
> mark.rutland@arm.com; Wangzhou (B) <wangzhou1@hisilicon.com>; Gleb
> Fotengauer-Malinovskiy <glebfm@altlinux.org>
> Subject: Re: v6.13-rc1: Internal error: Oops - Undefined instruction:
> 0000000002000000 [#1] SMP
>=20


> > > > Is there a way you can find out the BIOS version on that board?
> > >
> > > Unfortunately, admins of the server do not provide me with this
> > > info.
> >
> > This doesn't really help, I'm afraid.
>=20
> They provided me with this dmicedcode output:
>=20
>   Handle 0x0000, DMI type 0, 26 bytes
>   BIOS Information
> 	  Vendor: Huawei Corp.
> 	  Version: 1.25

The information I have from our BIOS team is that you need version 1.70 or =
above to
support MPAM.=20

Thanks,
Shameer

