Return-Path: <linux-kernel+bounces-216628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E57F590A262
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73245B22014
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C503F335C0;
	Mon, 17 Jun 2024 02:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ybi2rvG1"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8DF23A9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590537; cv=none; b=KT6XftNx+ATPlgrFBDDVLfplAPB6jj8K6VJEoxUEdOiJCyetAseKDApGD3R9M4JZqj7edGPMaGNy3pJ5VD72ZEheixFvG0ST6+vbrbDfClcMwnw2kijO/J8+UmIjBmrwmHSt50R0Yk4aUNJm9ETpYtEKxHwlHmSHnBkWD0hoDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590537; c=relaxed/simple;
	bh=06y7uD0gc+2AJ8gJXT1wG7IwLh1KThFLTytLLt0Ovc4=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=HDH/vtavBPHiAucr5xjmu6p+A4QVTsEg1YJCTILgS7u6yeFBS53/TfuPHnrn+LmuhtyVo8xPi1nEzJzFuyspYl4bLskLPwae5/rilITwYNysop7wN+UfngfISmoAaXbffFOZ3DuZcCKPerd7MADP4PLuSaqLnF7TcYmqGhbHgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ybi2rvG1; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718590531; bh=wYPINtl6Cq1OWFhozKYqXsEZounQyWRAl4uSdZTPhs0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=ybi2rvG1gMQLf4GkOKO2yOMo2Qqb/Xorgms4+ba8A12rQ5VDBT21no8AlHCV9LcoB
	 zqh4Jc2j487JAROAyIQ321EmUUCxtANikJ/RGTsnp2A8NvbtN+9SWaTYPy+tqP1mwJ
	 Qa/N42RlAqOPjHH8ZyGEI5MaFwtzd8o+EPciZD2k=
Received: from smtpclient.apple ([2409:8929:843:88d1:dc81:b668:28ec:a360])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 30E2CC18; Mon, 17 Jun 2024 10:12:14 +0800
X-QQ-mid: xmsmtpt1718590334tj3cjhxrz
Message-ID: <tencent_EC71217B8D3E7CC0826EDA6F8E9CB83F3108@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No7r52JV2vD3MVDcSHlznYLGhiW8RzPidqXTeotJ2IFBz5csnQxA
	 0uleeF7s5bZX8WMib3AriTuIMD0dV3AQSADndULeSTG9REAnjhIuDAE+iiDtS1EKYHZ+dK08w/8f
	 9wUqJqDXUnn61dVR0G1jIW4N+iyfNtQfavVlRqAy3dABZvhXKTNwwUYUEtyNv7Xxi9CZfVP3aPr4
	 GgmRANQ1iFDuPQ6s2AutI+SKoW6xorsZd6+SfstODAGd8cbBBKr4SYXdEmjp+nrB4BotiDQpslJS
	 9DJTMho9T160x3w/t6SDEbRN5WUFfagnct3HIN0D0dn6NjdE7Khi27DvoAy+rux7WMmv25/qM4rk
	 lHeg3nG1DxyYqAnAED7125rTZ/S/g1Rag2k81/0joC4FCbuVTs/EYCJH1R3wwdBn3YtwhBOaZKtn
	 8RrpJ03GMN7T2NI0VkneqpM4ml19U2xiObRiwxntn2E3XXfHr0M7T1PsKffXbBxjPulNJYVjno19
	 AnGXb/pDT79b1fRHO53A7LkbimTrCjh0tRQ2qHC8/uEUDiymDAfpQxG6npYTcP/zpfomMh66mt9v
	 hUwWNby+01i5VEfLul0e5+3ZjmvDToOM0RmBd7EiJr1MJarO1qMXw12L2z3CeXxD6n/rCfYlUeNG
	 5mP96qU9Aa8v0XXFinWmERXi+k58m1y5dCbAGtZ7v+mXG/XHf6DSX6ipNBOWeWeISZ/EFMn6ZNh9
	 ow1UUXZEb9tHWjI3Gyb9sF4Hfzyt5Qoj03Ce03VAGwxt9Wh3LcTrN2E+nhy9Dss0qA7mvZ8Ra6ax
	 sdKbjOHf8FFur8KB7je75MmNGs+ueG5jAoeyUgr/QnRppOAOvaVCs0/YuhLTaEO1+4YKT2ApWILz
	 KYLoET9Ocfeiyr+tbirAGkfdbVK5seJoDhqFHqv0F3WA+fTXTKGEAEV/EEbS3lXWbv4iwiLKd6Hb
	 bViK2kZFpVwjJcVK1bQcaFo2MXDpD0YeEDXrjs5Wp9u7MtAnw/19Bn2iLbtTg2Nsqa9EtVHsNhpa
	 hJfOU2wrlfytQglni7021vz+/5/iY=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1 6/9] riscv: add SpacemiT SOC family Kconfig support
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240616230633.GB3988639@ofsar>
Date: Mon, 17 Jun 2024 10:12:04 +0800
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
X-OQ-MSGID: <36EE528B-4CAE-40BC-9710-54ABE0D96B7D@cyyself.name>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_D935633C42BE1A7BF8C80553B5571C737009@qq.com>
 <20240616230633.GB3988639@ofsar>
To: Yixun Lan <dlan@gentoo.org>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jun 17, 2024, at 07:06, Yixun Lan <dlan@gentoo.org> wrote:
>=20
> On 01:20 Mon 17 Jun     , Yangyu Chen wrote:
>=20
>> The first SoC in the SpacemiT series is K1, which contains 8 RISC-V
>> cores with RISC-V Vector v1.0 support.
>>=20
>> Link: https://www.spacemit.com/en/spacemit-key-stone-2/
>>=20
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>> ---
>> arch/riscv/Kconfig.socs | 5 +++++
>> 1 file changed, 5 insertions(+)
>>=20
>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>> index f51bb24bc84c..8a5775586845 100644
>> --- a/arch/riscv/Kconfig.socs
>> +++ b/arch/riscv/Kconfig.socs
>> @@ -24,6 +24,11 @@ config ARCH_SOPHGO
>> help
>>  This enables support for Sophgo SoC platform hardware.
>>=20
>> +config ARCH_SPACEMIT
>=20
> should this be SOC_SPACEMIT? as it contradict with patch [9/9]

Oh. It=E2=80=99s my fault. It should be ARCH_SPACEMIT on patch [9/9].

>> + bool "Sophgo SoCs"
>> + help
>> +  This enables support for SpacemiT SoC platform hardware.
>> +
>> config ARCH_STARFIVE
>> def_bool SOC_STARFIVE
>>=20
>> --=20
>> 2.45.1
>>=20
>=20
> --=20
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55


