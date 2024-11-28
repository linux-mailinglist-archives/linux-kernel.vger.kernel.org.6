Return-Path: <linux-kernel+bounces-424250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B09DB215
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CB6282245
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F0D13A24D;
	Thu, 28 Nov 2024 04:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="g+JpXJrX"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100551384BF;
	Thu, 28 Nov 2024 04:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732767321; cv=none; b=mA54gY/ZVCHUf4jz36Rh328OHzq7qq10O17qzEtJeWrz6MAGB9YjZ4mWgHUphQ4JAuqRfHTjZ6LDndwCcozm8KlRZupMXJLliLOcti4mtOUtteb+swJEvI5vQBeUhzQ+csWqGzcwycknn8dJaI1dY+XhW8T6sQwhMYXSa0sGIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732767321; c=relaxed/simple;
	bh=mNaSoyg8rQjFcmzgjnICJX12PuJHAOpIWl8+zrkralg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l2O8oAcaveSys4mLwum/EjD4MHyPD7Lz8tjmV+3vYZVH10lkKq8QAlkh+phROoAWOGdliHKyX/Qfg+MGv5ARoNgxshQXa5uF8/+3rJvsnGLMFTE4N7uYS9dJMlyj7ny9z5bBch6FEc50DKOpDDhgYf3S65JlNXaBpnhp4k7MIuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=g+JpXJrX; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1732767306;
	bh=7b6Glp5SLr2N7UsM03np/8ULjbfU4Ri7NW0RKWdI/Z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g+JpXJrXNqlmjqYVNDJ3R/P2uxDj59PhRmtxqpO6WVujyJefvb8wwxsiscR3svFjw
	 6eecPF9jaF3p+fizPt4Fde/26O+i/2GoaKtRXx6jscMT0CMD1i8jMqGOPoXk/otTJE
	 Qga4yWfmpjhNrN9x3FmkaUuapVhcgNcbQEI7qNJW1RlV1dk8GX3MkrBwfLvEAQR6At
	 eUNm3mPuvVy+lXdDVSn6VqtkLfCq/XYurVFKJ/9gJqOAIE4y2x7aOh/0dhiezwuOds
	 QYSBwdb4Hxy3UeAnw3hTa4wqiYIl2FteruSDYAxRxIAQ6SUkFWNFnrPo44p0mq5mTh
	 f5Vxo9KaedIPg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XzNJB2BHcz4x0G;
	Thu, 28 Nov 2024 15:15:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, saravanak@google.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] powerpc/prom_init: Fixup missing powermac #size-cells
In-Reply-To: <CAL_JsqKJzAoxFQ30rJbH7D7zmGtZ+jNpw2BL45dqjOUe2fFbwA@mail.gmail.com>
References: <20241126025710.591683-1-mpe@ellerman.id.au>
 <CAL_JsqKJzAoxFQ30rJbH7D7zmGtZ+jNpw2BL45dqjOUe2fFbwA@mail.gmail.com>
Date: Thu, 28 Nov 2024 15:15:06 +1100
Message-ID: <87iks86lkl.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rob Herring <robh@kernel.org> writes:
> On Mon, Nov 25, 2024 at 8:57=E2=80=AFPM Michael Ellerman <mpe@ellerman.id=
.au> wrote:
>>
>> On some powermacs `escc` nodes are missing `#size-cells` properties,
>> which is deprecated and now triggers a warning at boot since commit
>> 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells
>> handling").
>>
>> For example:
>>
>>   Missing '#size-cells' in /pci@f2000000/mac-io@c/escc@13000
>>   WARNING: CPU: 0 PID: 0 at drivers/of/base.c:133 of_bus_n_size_cells+0x=
98/0x108
>>   Hardware name: PowerMac3,1 7400 0xc0209 PowerMac
>>   ...
>>   Call Trace:
>>     of_bus_n_size_cells+0x98/0x108 (unreliable)
>>     of_bus_default_count_cells+0x40/0x60
>>     __of_get_address+0xc8/0x21c
>>     __of_address_to_resource+0x5c/0x228
>>     pmz_init_port+0x5c/0x2ec
>>     pmz_probe.isra.0+0x144/0x1e4
>>     pmz_console_init+0x10/0x48
>>     console_init+0xcc/0x138
>>     start_kernel+0x5c4/0x694
>>
>> As powermacs boot via prom_init it's possible to add the missing
>> properties to the device tree during boot, avoiding the warning. Note
>> that `escc-legacy` nodes are also missing `#size-cells` properties, but
>> they are skipped by the macio driver, so leave them alone.
>>
>> Depends-on: 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-c=
ells handling")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/kernel/prom_init.c | 29 +++++++++++++++++++++++++++--
>>  1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_=
init.c
>> index 73210e5bcfa7..8e776ba39497 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -2848,7 +2848,7 @@ static void __init fixup_device_tree_chrp(void)
>>  #endif
>>
>>  #if defined(CONFIG_PPC64) && defined(CONFIG_PPC_PMAC)
>> -static void __init fixup_device_tree_pmac(void)
>> +static void __init fixup_device_tree_pmac64(void)
>>  {
>>         phandle u3, i2c, mpic;
>>         u32 u3_rev;
>> @@ -2888,7 +2888,31 @@ static void __init fixup_device_tree_pmac(void)
>>                      &parent, sizeof(parent));
>>  }
>>  #else
>> -#define fixup_device_tree_pmac()
>> +#define fixup_device_tree_pmac64()
>> +#endif
>> +
>> +#ifdef CONFIG_PPC_PMAC
>> +static void __init fixup_device_tree_pmac(void)
>> +{
>> +       __be32 val =3D 1;
>> +       char type[8];
>> +       phandle node;
>
> I suppose you are keeping the existing style, but you could use
> IS_ENABLED() here instead of #ifdef.

Yeah true. I'll do that as a follow-up and convert them all.

> Either way,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks.

cheers

