Return-Path: <linux-kernel+bounces-238750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E69924F84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC9C1C210F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98FD134B6;
	Wed,  3 Jul 2024 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="ZmBgDEjr";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Dc/RA1aj"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6F749A;
	Wed,  3 Jul 2024 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977255; cv=pass; b=Tbu6LKvZEDgIirdUnS6kakv7+C4aw26h0ZsnixVT9qedWSwawJ3j1zT2bZTsTG34LwCmSGuDsZc9gTHNRCozLf/LTiLF0THjy9I5exy6B5MEJXu2KXtB2AsbbGk01unu8ZTP+T0d2XxKSgp5xZIA5scIrXqMPuy6557UgRYYa2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977255; c=relaxed/simple;
	bh=RQNQaZZqQWhhS3Urnra1y+ytGxYJhWhtuy+j7yUoQ74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szoftb5wknKHETUA2GA2VvMWGEOdqPzJeuVOKf1QaVHIrtuaf/HP4SvsmLca3zYyYaslUGUCVjfw8UPNV2lfhU0sqnagDWBOlfoksYKK1widrmsog4jstRLOZxIEUptha2H06ZcQ9wHcXf4aBXUDtT3S/iIODzjm9EaRQ1MrcaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=ZmBgDEjr; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=Dc/RA1aj; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1719977222; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rpAoQxXRn6t9vOdO0wp4FpxkDyY6ZEl5vrtBSHEeiQSQeAHNZyo0jwFjTB2gEfX0Va
    ljAWHUsjqBqf2PvfeB5JXqgnprYpmWeAYjrTJrXIaKK5QExwCFBuFis1jrB5uTCvkIVg
    FgG/Nx4V9jxkf7wBepmNLV/5Sniz5uDNu+QouwtGwOMQHc7sOBPWxyR9WcjVAivNFxPM
    ZG715mfEHTq1mPrXzqXw/ifd0HslqEqWb4UyjeaBtaxYrnctsIiTqDGlHtrQcnUIsPGS
    Ut18ezHvkuINRWnNlrVCLaxcoW9egXyS5ldEP7xGx5lj3K1ABjjO+sywhR7NRVjgEo7e
    zNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1719977222;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4SP5h5Do7JPIQ+0cy5j+pVKxqlNOrxXKcSxL9POMDto=;
    b=Ke9J2fL2PntphxYJSJw70i/Y8AdJ4RZqGhVBZZPDG55vo6UDbdzS+oe8gKw+VgS0MS
    zTNqAT+XON52EA0Z8+Noe3JLnM7J0R70gVF8rjAG/W6dRj8N+935sUCBdlz6RrHNAgEy
    Bo5Hd7uKy4qUl5JadWrydCqx/6iJF4PEbj/DuxLZaSI+YxnM8W1bY5F60c2IXgjoYbny
    Zaac7Y7YxVRVGyyTqysMeNlMJAJ+gX26d9A6sFIWI3naHkFmf+a7vGXvQs8lpFIh/dw3
    K6cZXR166/pGRSrwW6pMUx/jWfgQjrIS/gPKvj+CjIyUqORg9yeDP55RCJNF0YO9xoky
    kTzA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1719977222;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4SP5h5Do7JPIQ+0cy5j+pVKxqlNOrxXKcSxL9POMDto=;
    b=ZmBgDEjroGl5Thkv00h9sjj2HTUFCjpAIEUeiiaV3ViNLohCGnDfW5FsyFzuTlIE5l
    oaJWo7K2fyTr/FbGQohlK4jxnsbE+J3zhb8cFRZFMWC73QE+lyK+iogpqLUNgNesdNay
    aI1PdBSazld3vVqyg4EVazBhcvq80RDuYbBXoGADsUVDmMT1VyymKJD41JblYT0cEOQ9
    Mw/EmQCRJlNq92oI0INJeo52speN+Pg3scdwiYn5OLeV1oJEIWB89GxpnO5xa8FRdtMZ
    KrXU25A6E7sd7MhvcAng8TKWErGSg0uqvUs+2u+Dn2B/AHb8drv1TO5HRyuALeFFLqSa
    t0wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1719977222;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=4SP5h5Do7JPIQ+0cy5j+pVKxqlNOrxXKcSxL9POMDto=;
    b=Dc/RA1ajfn2nhMk1LNDqqP3Ye6P9115kx3TGG5pF5FN29MvIG3uASqsoyC0Idz2fRA
    qpnHI+PLR2lB4IU3j3AA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHvJzedR43JwnbX6uY2qFStl/aCni1Nc81TAvUiF9uCdWDcE="
Received: from [IPV6:2a01:599:806:4825:5b9f:b248:3889:7da0]
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e083890633R1MpB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 3 Jul 2024 05:27:01 +0200 (CEST)
Message-ID: <5e44f1be-f626-4bcb-b1b0-583462c1a930@xenosoft.de>
Date: Wed, 3 Jul 2024 05:27:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives
 after the of/irq updates 2024-05-29
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>, apatel@ventanamicro.com,
 DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Matthew Leaman <matthew@a-eon.biz>, Darren Stevens
 <darren@stevens-zone.net>, Christian Zigotzky <info@xenosoft.de>
References: <3ab66fab-c3f2-4bed-a04d-a10c57dcdd9b@xenosoft.de>
 <86zfqzhgys.wl-maz@kernel.org>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <86zfqzhgys.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc,

On 02.07.24 18:54, Marc Zyngier wrote:
> On Sun, 30 Jun 2024 11:21:55 +0100,
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>> Hello,
>>
>> There is an issue with the identification of ATA drives with our
>> P.A. Semi Nemo boards [1] after the
>> commit "of/irq: Factor out parsing of interrupt-map parent
>> phandle+args from of_irq_parse_raw()" [2].
> [snip]
>
> My earlier request for valuable debug information still stands. But
> while you're at it, can you please give the following hack a go?
>
> 	M.
>
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -282,8 +282,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>   
>   			oldimap = imap;
>   			imap = of_irq_parse_imap_parent(oldimap, imaplen, out_irq);
> -			if (!imap)
> -				goto fail;
> +			if (!imap) {
> +				match = 0;
> +				break;
> +			}
>   
>   			match &= of_device_is_available(out_irq->np);
>   			if (match)
>
> This may not be the final workaround even if it solves your boot
> problem, but will at least give us a hint at what is going wrong.
>
> I have the fuzzy feeling that we may be able to lob this broken system
> as part of the of_irq_imap_abusers[] array, which would solve things
> pretty "neatly".
>
> 	M.
>
I saw that you may already have a solution. Do you still need the test 
with this patch?

Cheers,
Christian

