Return-Path: <linux-kernel+bounces-240486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C98A926E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B651C21A43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80D91C68D;
	Thu,  4 Jul 2024 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="e7MMSlim";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="8+5L3yiC"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F291210EE;
	Thu,  4 Jul 2024 04:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720066257; cv=pass; b=YPHc+B26k+U0EADykiVFgigNyvfxK6PCINViOzihm7TZdQmI6oPpwUbx7FTTQzv4f9fEE2yyPSLjtQgr/rWC7exkMIprGRMk/pnuZvjHzrE900JMvK1yVisedO09d646AxwFOJdMitgmdFlxHNw23SOkhcwTIhocsU8qod1GkOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720066257; c=relaxed/simple;
	bh=+O2eMUKa8rcdWwn6dYod5eFPVDqCBWyvGbD2DE3l8JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kc6T3aMONQUcYdIl0gl27UzBFkZaDXE1mH8JcFY6RTsWHaNatCHCNJT2h7kUlqoE1B/LEP8GOJyHUnpZxcYSmvQWmPV9FV9IIJcNrUgLzlMw5/UOApHawvDPkphwkEDff1/dUk0k+1uobze5yiiXRrFH1glFECnVmCZVSt6gQb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=e7MMSlim; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=8+5L3yiC; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1720066211; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qkyJygzzQDFPPD8O1Ywk9+fUQD/egWVt7y1Tlt5r4H2umAGSTAZtFwaE4Eq0TeKC2C
    YZZu30DPTTi+vCfX95KbHLX1Xextg/unk2hxUV4O/qsUToWXOoWQFhjTuPYtdJ/KYvCQ
    NQGLkyeE1qxlg9CJThEXl8YQ24TIYEOyOh2CgexLOo6f3+IUTEn9lwiSMysOgCT0BykH
    MimqIsMwRfb/jgoKm+IAja5Na0/kEQ46KLJC229balKUlflVsIqMlUD96zqK20FJUE7Q
    dU4M3x3qJgFuYcJCjcEKPxBQOnaUn7vW5DjlvmymACy27YftghLjU9Z3OhIt1CZNtYhB
    z1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720066211;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=waNYzVh47/kMBZcFAwbpFzTIdIRmPW6TiXgS9tOC80M=;
    b=P4RCcPkrP6xjSNAyYAT3YtfUrfNCdKQeslOCqb5mk+xnu7jpijhvuJQHDaK6XcodQL
    FoQOkMwE6Nxpvpp5XIMRqAqAdrNyEp2++u0NGHAPpUxos+VleDu+zdIWz0jy4GdCTJVQ
    m4BioGurLrFNYEeP8kW10naFxSKDSxDZrMuX8eNgN4MmQEJnoPA+2XuYYTAQxngiwbyl
    9nNYfp6q6mFcXUit0frfJhrnR4ot9yST2Ca4l1QtIZhfnll+pzEJJseZFisknVsqffKU
    E/t2U1fbPAHbxX1wxmBC6s8u+hZajywkOPmcf77COXnR7OgnCLHvk5pjdkXOVyX5Cgtp
    XjYQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720066211;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=waNYzVh47/kMBZcFAwbpFzTIdIRmPW6TiXgS9tOC80M=;
    b=e7MMSlim9DkMjN8BFpaF13MbZkqpPDSdqlvpb6DjSKfGVDUjqRU3aj/i23ivhNSS+B
    L1Q2tN/NtNoQ4sGUddX8bdo+qTRb37wa0ydVf+vBY13HoWZUtI7wCC1KDZs/iM98N7ow
    Lu8MQDlXJN9dOfd6D1oiwno+YtVzL21mJmpbQ0DPRec9PqVXgSxmDkOQyU6uDJu3LXfv
    e+siN6ELOPulKQ+tTkiG1sgCcEl+gQdAdFN8UnUv9tNunSZqi7gj+7WjMFlQTc23h7Gz
    8dY+dJcrzLeqfr3RJOImvSeAANd/+APJ972AMe1gE0qA7mxEb0EHIO0j1nAcjJ/g/vMk
    XKBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720066211;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=waNYzVh47/kMBZcFAwbpFzTIdIRmPW6TiXgS9tOC80M=;
    b=8+5L3yiCGaW9qoCPHg4wmxYcjm6J1H0SqqKjk8KyvbOcdaj3c/DpDDKKYYcAvySupO
    ryzhiomdAj1ftkDZ5sAA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHvJzedR43J1zbS8JqJTXDk2ePuRj/Ii+5Yjqee1PRe9v5N8="
Received: from [IPV6:2a01:599:81b:e76c:5d34:e38e:a378:4532]
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e083890644AAQnu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 4 Jul 2024 06:10:10 +0200 (CEST)
Message-ID: <ccf14173-9818-44ef-8610-db2900c67ae8@xenosoft.de>
Date: Thu, 4 Jul 2024 06:10:46 +0200
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
We tested this patch yesterday and it solves the boot problem.

Thanks

