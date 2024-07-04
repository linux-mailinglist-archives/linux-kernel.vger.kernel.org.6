Return-Path: <linux-kernel+bounces-241637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DFD927D67
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585AA283BEB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC4713664A;
	Thu,  4 Jul 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="pr4IL2r7";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="xOLsMFvL"
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8536CDA1;
	Thu,  4 Jul 2024 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119615; cv=pass; b=YGZdkQ/SJc7C41N/HM7hqk/DFGS74J31y+X2ZnCJYW/h50GCt14LLXoZP4YswUMFm0ucB/p6jcQEe/VWRRjPi7gDKmiG5dCtVw38AvltWggNHzMQydIdITFjROvVnkfsSS6DcJa7VVp1aUdPt6Icz6wkW/wZJdIt1r54NoYh550=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119615; c=relaxed/simple;
	bh=IC9p+MRoRRz0HKEpCsqwAaN92/sAl5jhuLFVRzE8XLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPctpJba3gOfOacEwgIxL4QLHkm0zO/sY+FMrwqzgyd0l7x4caxfPmExT0mCYw08D2Hxn5fzk/hqYkZ7u1ZaHikD18+pZpMpg1zbhlFuX1aShgFpg/zWFlNXYHUzVW4q4ZBlBzosBn+bxLq2bgaDD/4PXQNGm4wz3/mD/Am7nsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=pr4IL2r7; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=xOLsMFvL; arc=pass smtp.client-ip=85.215.255.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1720119248; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Mc3stmrwc7ESbeLm9P4wa4lqI1JK1TgJLetRde4RCCKGaBgLN0fNz0PFR3vlVyzhH+
    bdynQ6h1o6peu5YWLh5FKbadmN61rXksjIuDaKQnGLs41X5CbZRuBdcNj9KTkZIbdwuT
    D5iropfjGOCLEqmmY5DnYd7nnqYJUYNqau1a+rkDgULH753bA1YUKl0r+z167gnskLOD
    Fkc1+qkboWcRJmWclAloGWwOdwqwTZyjeIiofvXpXMC6QnPqjVUAoNXxdY691MuwPTX1
    +EkIili3qDaIPz3i7WsEC1lIlZrQfn/RS8M5OWobYcCm0jwcYIm/WI3yWuW+AeJvgfk+
    1ZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720119248;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=apTDHF46wlKCwkzD7joD6xmv+z0R4Z2m/26qnRUS808=;
    b=EpN/XM31U3/fqJJppaIY2ljQ8JDFvChPox/QxxrtaCNygzfvEDgbGvyuiWnDxTrq8R
    DmyP1SVVwT4c4XNjMJgnT/x+zSkNfPeGnZhgwdtxI82CNZCLWGI8BtsvDmosS2yad1C6
    mg8MduTl8EHopSimDZOsg81XYYBD84JAei5TGtLa8756fwS8JQCxusjDqH6+9fa1Bre3
    F1/Tb8FbwN/WJAFOJdcJ+NVBm8oYNgEE60rP9l2TuKi9kzGFJJ9cxcjyEDrtiBS/+50/
    HelHQ3fzmp9ukG+XOW4q3VusVCxudNlhpzfq1xjAhS3w4qN/AHIL/dlX75j5Zq09nTTY
    Hw2A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720119248;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=apTDHF46wlKCwkzD7joD6xmv+z0R4Z2m/26qnRUS808=;
    b=pr4IL2r70nT8nSo8PciLwb9V135tbNHG4OiTDxHMh0OIwlv9RMMJKjcgZY/r0LJy6B
    of5wWpKSlL8kLIPqTOPLS8U6vVmts4V74IUnSpXwJbZR6/Pc811+EXBdWkRRWBHud0Cs
    wro1AR1GU/2nGEuU3NiDnFOmQcBpnm5SrAd7e+tHRKrnLPugqiaurx/g7jxDuaqJQxKT
    9nTIBP+qnpZ92vE+hGWgXmi5q23BYjBKk16R4K+hkfr90/Ll4PQNFcc2szUXmXdD3xIH
    G0oQmFWzdrI418ZwjjMBVZXdvky8+qzKMJ3SgQXRd5EETRqwmXlD9kG2mdaWr/o5LP8B
    x7VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720119248;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=apTDHF46wlKCwkzD7joD6xmv+z0R4Z2m/26qnRUS808=;
    b=xOLsMFvLt329BiX+R1cOs7xrsvzYlgnMKSFQj7dKC3jAL1jrgpW+OA49yjRxF4WTVY
    2xBcV9hEimqrLEd7RuDQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHvJzedR43JwnbXz/kFsuSUCat82PJROdEuWUwpcR8HY5"
Received: from [IPV6:2a01:599:806:6955:6d1:546c:8e64:4d8]
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e08389064Is7UAd
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 4 Jul 2024 20:54:07 +0200 (CEST)
Message-ID: <3c045b0e-70da-48af-9196-2f4225477a32@xenosoft.de>
Date: Thu, 4 Jul 2024 20:54:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives
 after the of/irq updates 2024-05-29
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
 <ccf14173-9818-44ef-8610-db2900c67ae8@xenosoft.de>
 <86ed894l48.wl-maz@kernel.org>
Content-Language: en-US
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <86ed894l48.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.24 10:28, Marc Zyngier wrote:
> On Thu, 04 Jul 2024 05:10:46 +0100,
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>> On 02.07.24 18:54, Marc Zyngier wrote:
>>> On Sun, 30 Jun 2024 11:21:55 +0100,
>>> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>>>> Hello,
>>>>
>>>> There is an issue with the identification of ATA drives with our
>>>> P.A. Semi Nemo boards [1] after the
>>>> commit "of/irq: Factor out parsing of interrupt-map parent
>>>> phandle+args from of_irq_parse_raw()" [2].
>>> [snip]
>>>
>>> My earlier request for valuable debug information still stands. But
>>> while you're at it, can you please give the following hack a go?
>>>
>>> 	M.
>>>
>>> --- a/drivers/of/irq.c
>>> +++ b/drivers/of/irq.c
>>> @@ -282,8 +282,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>>>      			oldimap = imap;
>>>    			imap = of_irq_parse_imap_parent(oldimap, imaplen, out_irq);
>>> -			if (!imap)
>>> -				goto fail;
>>> +			if (!imap) {
>>> +				match = 0;
>>> +				break;
>>> +			}
>>>      			match &= of_device_is_available(out_irq->np);
>>>    			if (match)
>>>
>>> This may not be the final workaround even if it solves your boot
>>> problem, but will at least give us a hint at what is going wrong.
>>>
>>> I have the fuzzy feeling that we may be able to lob this broken system
>>> as part of the of_irq_imap_abusers[] array, which would solve things
>>> pretty "neatly".
>>>
>>> 	M.
>>>
>> We tested this patch yesterday and it solves the boot problem.
> How about the other patch[1], which would be far preferable?
>
> 	M.
>
> [1] https://lore.kernel.org/all/86ed8ba2sp.wl-maz@kernel.org
>
Marc,

We will test the patch as soon as possible.

Christian

