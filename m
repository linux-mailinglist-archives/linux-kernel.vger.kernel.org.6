Return-Path: <linux-kernel+bounces-216686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CE490A309
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91861C21285
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5526C17C7B3;
	Mon, 17 Jun 2024 04:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mNwvb+GZ"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1996510A2A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718597654; cv=none; b=Sxg26dqeIuLcEPdWQjD0h/WuR/riCtm2P+Df08wNnbdhboRC3g5WA601zzFHAn+e0CHVwX26DmUiFqVx0M1HMumZSdkF899jnt80hBBKdm/i8DV3/XxIOlIJcdE3lWO5c9Hr3i/3ZOG3UKqTw7K3A/G6EWkdD/D/rpAGo7FuIdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718597654; c=relaxed/simple;
	bh=1RuUYRVEo2TW3uv1NQ1XR3wba8cpg5dcXcDlfoCsgK8=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=G5tDGwhUMBHGMy8ZymLXFY7vsx6zs55BOjrrN52/lZwd4EF0DAs8PRM/poVmg8XttHX7Fg2sUG10hK3f6lKD1Z/MDwLfKd6dnlK3DCKHuKUXQkEtJRwEYXdPmOuI7rwfpb66wKZtoUTu0haB6FMNhiOW0W0KXf54ePaU+bBHRhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mNwvb+GZ; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718597648; bh=WLuBvzPzs9880RmsTEuF2wkZmJzMU1EtiXxCBZNBcSU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=mNwvb+GZBmEfzYnytqbJ5y+2/NT9/CDOYJBc0JVukwo35ARqnuYqhcrnIMCIzZ4nw
	 HFBrUHLOqRc3MomAf+JLycQZejFy6SIVxYagz3NMo0UgIWIq0IxDghceyGs3nLYsYh
	 9Gl+D8cr9cXLzG4+gw+dabycJP1uQtEdU8uhuOx8=
Received: from smtpclient.apple ([2409:8929:821:8f06:b09c:7026:3108:2c0d])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 373B8C89; Mon, 17 Jun 2024 12:13:51 +0800
X-QQ-mid: xmsmtpt1718597631tbx1uelq5
Message-ID: <tencent_4419DAC48EBDB803316521148D887C8D8208@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvT9rbrqOsVAj9/aRWrSEBe9NhraLBupeBo8FMpWpnaWvqqDzxPwM
	 osFFzaj1HJgUOB86x9ovrMAWJ9DvXLCKRDp4i/mMsgfhvqIl72amL0kRoP3+3CRT1hkjfVj0t1wF
	 ORUwuZeUDoDJm1OxYSt9MdipEXMoFVO0qRcOvf3F7BVNQe9SJwfK7vxuQ68hNh3SxfdVUaEBAAfe
	 6maOe28NWX9MHE4F80TNuCgKpzAqGId54Zx+eJQUJ3KHI1hx2gAHcljEBep0jNydq5vTEjn7HAqf
	 cafm1AXGP5b4UnQbODUCfzp83pjM8dUR7r0bEaCIDsmUvfrLF5bxrClkc6SY0uxfbc5EVcxWuM7n
	 bzl+xHgq1j5thLpk1glY0qgHNCEMc88/Dwe3jzTKcG5Kmx/KXxeg0PLKsGAXD+eMIrImvsIv11Mv
	 efrNYuAlHlthKMImPW0TIcPI55sK5HqGNpDMCjNrQzNq66qc0ivsQsM9rDJ3gOXJYfIJKQrTAFJr
	 Va4m9Vvid29aavZKlG27X19iotGcE2zcKze7HqsGFeSdgo0X0V+M95npRLmI7/kJ8Pb3qI2OIQy2
	 5q4Qv9V4m8Tjf2TOFgH+8ptcpACZ+uIK4Iip+k4xBag9KMcVSpGnmpKABJx8iR3SBdcyhUlW4D6a
	 84O2dKvrpjeRoyxzrRY+ivBnR0zckefW+8RldTl3R4OHE4UWEDQuvxRJskdbYkCmt17NiFtOHdTl
	 vwvCaBoZX6oUsWaoTff/ievkDvR9/jH/WtZ73JDFW0haaehEAyISt58mfkiHo3tEnA6np3R+xK1H
	 ootg9E9XGCpihbxXYlR0pLMOEwpKnCKvm0N26fGU7lTJZL2CRXs1q8Q7xmXLirdv/wndW21zknSE
	 1fID546Ad8Tk9IFK2LdMkWK6TV5FUhz0mNJJRpUEVMF+KiEItJf6Yohsf0+bsWt18MEFyNEekfa0
	 HCVs3tUZ2x5G16lIrjYJ9h2sWJ+bS1AqRMZcnRBGk2aAfebDzXYdWj4bzVKMjB
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1 8/9] riscv: dts: spacemit: add Banana Pi BPI-F3 board
 device tree
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240616223149.GB3983622@ofsar>
Date: Mon, 17 Jun 2024 10:16:29 +0800
Cc: linux-riscv@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Anup Patel <anup.patel@wdc.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <D2594566-12B8-4E81-9FA4-CA217ECE54CD@cyyself.name>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_904B1050FBC0B10A172C263924BD518F8F05@qq.com>
 <20240616223149.GB3983622@ofsar>
To: Yixun Lan <dlan@gentoo.org>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jun 17, 2024, at 06:31, Yixun Lan <dlan@gentoo.org> wrote:
>=20
> Hi
>=20
> On 01:20 Mon 17 Jun     , Yangyu Chen wrote:
>> Banana Pi BPI-F3 [1] is a industrial grade RISC-V development board, =
it
>> design with SpacemiT K1 8 core RISC-V chip [2].
>>=20
>> Currently only support booting into console with only uart enabled,
>> other features will be added soon later.
>>=20
>> [1] https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3
>> [2] https://www.spacemit.com/en/spacemit-key-stone-2/
>>=20
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>> ---
>> arch/riscv/boot/dts/Makefile                 |  1 +
>> arch/riscv/boot/dts/spacemit/Makefile        |  2 ++
>> arch/riscv/boot/dts/spacemit/bananapi-f3.dts | 19 +++++++++++++++++++
>> 3 files changed, 22 insertions(+)
>> create mode 100644 arch/riscv/boot/dts/spacemit/Makefile
>> create mode 100644 arch/riscv/boot/dts/spacemit/bananapi-f3.dts
>>=20
>> diff --git a/arch/riscv/boot/dts/Makefile =
b/arch/riscv/boot/dts/Makefile
>> index fdae05bbf556..bff887d38abe 100644
>> --- a/arch/riscv/boot/dts/Makefile
>> +++ b/arch/riscv/boot/dts/Makefile
>> @@ -5,6 +5,7 @@ subdir-y +=3D microchip
>> subdir-y +=3D renesas
>> subdir-y +=3D sifive
>> subdir-y +=3D sophgo
>> +subdir-y +=3D spacemit
>> subdir-y +=3D starfive
>> subdir-y +=3D thead
>>=20
>> diff --git a/arch/riscv/boot/dts/spacemit/Makefile =
b/arch/riscv/boot/dts/spacemit/Makefile
>> new file mode 100644
>> index 000000000000..5c512f4e297d
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/spacemit/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +dtb-$(CONFIG_ARCH_SPACEMIT) +=3D bananapi-f3.dtb
> Can we have "k1" prefix at least? so k1-bananapi-f3.dtb
> it's much clear to let people know the board has k1 SoC,
> in case vendor has more chip series..
>=20

Sounds like a good idea. I searched other references to "Banana Pi"
in Kernel dts and found they have the prefix of soc name.

>> diff --git a/arch/riscv/boot/dts/spacemit/bananapi-f3.dts =
b/arch/riscv/boot/dts/spacemit/bananapi-f3.dts
>> new file mode 100644
>> index 000000000000..023274189b49
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/spacemit/bananapi-f3.dts
>> @@ -0,0 +1,19 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
>> + */
>> +
>> +#include "k1.dtsi"
>> +
>> +/ {
>> + model =3D "Banana Pi BPI-F3";
>> + compatible =3D "bananapi,bpi-f3", "spacemit,k1";
>> +
>> + chosen {
>> + stdout-path =3D "serial0";
>> + };
>> +};
>> +
>> +&uart0 {
>> + status =3D "okay";
>> +};
>> --=20
>> 2.45.1
>>=20
>=20
> --=20
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55


