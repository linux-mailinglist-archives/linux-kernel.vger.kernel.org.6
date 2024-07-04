Return-Path: <linux-kernel+bounces-241601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C90C927D05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1E2286A69
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD16B136E28;
	Thu,  4 Jul 2024 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="l5Si8M9U";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="qBMcCXzG"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D872B13D250;
	Thu,  4 Jul 2024 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117686; cv=pass; b=jj6oh2INDP3zM0CtvAxK5k4aabQpAabUiVjkqWVbM2IbtSlVw+psm83X+3l5HoBc3XA0Vxy+0CC0iLuMGyvl/nP4oSyhoStyje+/uxS0cP/PPscVj/g52wgaAqmJgez5FgrEP6JD4St7TnmYj2IryXwjbAGdH/uPiQs7S9GZnpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117686; c=relaxed/simple;
	bh=6NFNT1aliQ0mk/TC71IaMfgcjYB9X2hKt+teOtKS05c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYFBMNYkbPJ2VXNUdGPynivGMY7e/ix4r9zPXWTR/cMXJHT96pf80pPpdcm44zPJFA9/oD1S3DP4BlESVu6cUEXam3i6OOM3ve7Uuy5y0Qj0FhxV6odRb2ccXbX4Ee4AYMoa+9xE9Z6xCOm92TM9CHurnsrxYnXo2MuIxYB719Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=l5Si8M9U; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=qBMcCXzG; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1720117643; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Fy80Yhj0x290kYEKrd1RQq5Ma4YrsvEuYkpH3LYU9DoorwUkKSLbMWAvJixniXyf5g
    yVC4srGT7gF1k+RLkH9bW3YN6L5wNbkjSEp9fzCOwqTCH4VJtr4otCsKv5epcDFCbOmC
    uI7Ntpymsr6rOrlXg/q0Con21LOV8yaMA1SfenfbFiDHQBX18wmyYDlCgtTdpd8qAoj2
    SMNKyehlaFcgbSy369A+C5icUBoE/w9pPV0QFmNjw7Bi+BeHBxocimWkNImqMF4Wp/pk
    w/GNQKJmEaAPEiorZmrAiAKUinkZrpdp4RqJrpOrNaFPffpX7PUCSxemxIfkGYRCLTR/
    fgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720117643;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MF0O/2pT9UmMWAClfRsttShUZ9knD0aIZeQYuAUw6dU=;
    b=EHC56Dpn2gs6Skqy1ifHEIIlFMQaQI9TfG1ICcGuahMdnAon0fBmAmSqUe/ogSu9JB
    cElXLbZfbSiWIY6Yyn8W7lS7ojbTf4vx7qjAjbPIFjHMIrI8xHoYwPH7VClf0scPN2UO
    yzaPaqy6YTt25/IjANSsYlsSzcu8QsaOWnQWjU+4lW2MXwH3qTKOWs+vMeg7olTDzdQt
    2pYUo+mjowSdEGnCsKOHvgQw863GszbGGz5G7mpEFfNwLrvzGv2JAMVXORhIdlH1mwm6
    KzYTWoj/xDprxISEgXnqYUiJ9d0khPVrp+llDDh/v3zFTnCHNqqeLX4S0b+b66hs511s
    chMQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720117643;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MF0O/2pT9UmMWAClfRsttShUZ9knD0aIZeQYuAUw6dU=;
    b=l5Si8M9UJxarFg/qgHvJFHeU7jTArtd5tKBk45N+PGvKPPeTbhOZWRLQ4OB7DCUPfc
    X+80A8ms55gD0Fb41YnWnJl1WN+cz030p5gzUvY2QaH+LqaL1lVTSJYMVw1+g5cGprO/
    4/qYGjuB5RJmWj/l3Dyra/k5LI1T4rCDxzpMhqeRIZQnGyEpjFsVDEdBQSdQI8CkFJa3
    djf5MYuSPZM2HgIQKAD1U6CBeDyfXQCchwWPnCLOYyrLRYwss6b4C6X2qqLLO8Rj/5ZL
    3vAG+lYfPuGayKYv/4phOz3m8H0fc09XNNFfXqR5RqrSLWlOTQJGYeUM65HNA1c+LDMk
    Y/Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720117643;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=MF0O/2pT9UmMWAClfRsttShUZ9knD0aIZeQYuAUw6dU=;
    b=qBMcCXzGHDJUBfTeFFb6gqTp2Nv7XFgLfH/4PCluveo1Sc4a7mTdMpfYKnUq3gXI2E
    eEtys1FZvCwUm2s8XsDA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHvJzedR43JwnbXz/kFsuSUCat82PJROdEuWUwpcR8HY5"
Received: from [IPV6:2a01:599:806:6955:6d1:546c:8e64:4d8]
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e08389064IRLU8S
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 4 Jul 2024 20:27:21 +0200 (CEST)
Message-ID: <3baff554-e8f6-42b0-b931-207175a4d8fd@xenosoft.de>
Date: Thu, 4 Jul 2024 20:27:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives
 after the of/irq updates 2024-05-29
To: Michael Ellerman <mpe@ellerman.id.au>, Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>, apatel@ventanamicro.com,
 DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Matthew Leaman <matthew@a-eon.biz>, Darren Stevens
 <darren@stevens-zone.net>, Christian Zigotzky <info@xenosoft.de>
References: <3ab66fab-c3f2-4bed-a04d-a10c57dcdd9b@xenosoft.de>
 <86zfqzhgys.wl-maz@kernel.org>
 <ccf14173-9818-44ef-8610-db2900c67ae8@xenosoft.de>
 <874j95jrur.fsf@mail.lhotse>
Content-Language: en-US
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <874j95jrur.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.24 13:53, Michael Ellerman wrote:
> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>> On 02.07.24 18:54, Marc Zyngier wrote:
>>> On Sun, 30 Jun 2024 11:21:55 +0100,
>>> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>>> Hello,
>>>>
>>>> There is an issue with the identification of ATA drives with our
>>>> P.A. Semi Nemo boards [1] after the
>>>> commit "of/irq: Factor out parsing of interrupt-map parent
>>>> phandle+args from of_irq_parse_raw()" [2].
> ...
>>> --- a/drivers/of/irq.c
>>> +++ b/drivers/of/irq.c
>>> @@ -282,8 +282,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>>>    
>>>    			oldimap = imap;
>>>    			imap = of_irq_parse_imap_parent(oldimap, imaplen, out_irq);
>>> -			if (!imap)
>>> -				goto fail;
>>> +			if (!imap) {
>>> +				match = 0;
>>> +				break;
>>> +			}
>>>    
>>>    			match &= of_device_is_available(out_irq->np);
>>>    			if (match)
>>>
>>>
>> We tested this patch yesterday and it solves the boot problem.
> Hi Christian,
>
> Instead of that patch, can you try the one below. AFAICS the device tree
> fixups done in early boot mean the interrupt-map is not needed, and also
> has the wrong content, so if we can remove it entirely that might avoid
> the problems in the parsing code.
>
> I don't know if your firmware actually implements those methods, I
> couldn't find anything online to confirm or deny it. Seems the only
> option is to test it.
>
> cheers
>
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index fbb68fc28ed3..28fe082ede57 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -3138,6 +3138,14 @@ static void __init fixup_device_tree_pasemi(void)
>   
>   	prom_setprop(iob, name, "interrupt-controller", &val, 0);
>   
> +	prom_printf("nemo: deleting interrupt-map properties\n");
> +	rc = call_prom("interpret", 1, 1,
> +		      " s\" /pxp@0,e0000000\" find-device"
> +		      " s\" interrupt-map\" delete-property"
> +		      " s\" interrupt-map-mask\" delete-property"
> +		      " device-end");
> +	prom_printf("nemo: interpret returned %d\n", rc);
> +
>   	pci_name = "/pxp@0,e0000000/pci@11";
>   	node = call_prom("finddevice", 1, 1, ADDR(pci_name));
>   	parent = ADDR(iob);
Hi Michael,

Many thanks for your patch. We will test it as soon as possible.

Christian

