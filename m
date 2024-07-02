Return-Path: <linux-kernel+bounces-238205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD3C9246C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24855B22017
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FCE1C2309;
	Tue,  2 Jul 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="mvSgJCG5";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="2L5SkDMM"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22173D978;
	Tue,  2 Jul 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943097; cv=pass; b=aRF1ScxhQuu+mrjdjYKLpCtFpdctRohzTkSy2AyVBJ5t5sHRolxFbJHGxY4OzxkE928FoUGhYKVsm2QrBUVoUiX6myjHBFatUkiCqmsDplLxkZB2EYAjCLf+6OsNnze4cDh7xyK0DKN4ozV8RIBkWDWxKN4l8S+QJrkIqpg7rjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943097; c=relaxed/simple;
	bh=VgXk2zt+QB/efFlmObn3xHqoyoyWSNvmihof4cPuzzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nx6CdOPDdyn0WuLxFmkrqCCndlcSGo02WBrweMP8mHCXW6nuR2kpoUUoahMDBSElJP0xgw9UcsA+9nCUgcH6xq0+PsVfKvFFQIwS+lL+ohNJDcUD+v+h2zexARsUoFDQrI1NDg6OPxtfyv88B0+4QGmqn7qSVLA6YGmHb8QAGZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=mvSgJCG5; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=2L5SkDMM; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1719942903; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DWGnEPQ9ll4FHGnZdCzyUt/27cf3QCHSLL2H6N7j1y9I8/5t/QSLfLhciIdaMGC42Y
    ZGbsO4EyECz9Xn5dMA71o8YI7a5GqseVXqZVop6T/IzVSQWEAYfqkJRUhOAG4Y6lLE5q
    oo/HTc5mRaEMlpT0auXnXLco6/rcwQyRI8Ifl0zecAArrKEf5BuPVP7EMqBZObEY2pjz
    8O4EcY7onRtxeJyX5gVtjPSiQNsZlG+AwF4kFtyIl52PEB0d0m/oR6ddqLAzV/mW3awJ
    1k3p9lH+TC68Jurp6Pqj6cK+sHN8mKox01s7A6P3yGk4Wgx6l/tXAEpUeGIjdC5HpggJ
    H+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1719942903;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=E673tN2YQj+8YdDOgypEUonLvv3SNH0/z/xJh5Re/DY=;
    b=TUH8DlAnzXLMbDaA3ihEWSXBi0VQHbeMnvhQgaiEWRjHbluLzIqYjTG0W1Fc+vMAzW
    6qrH5pNpyrNE4iz1yucvS/iJCFZkatQacxjOdufZQQ7T1QBkcVjRcQmUZ5hTJCRqNEnV
    7kVnJvar/aWp9C3+WYz5sS38Q41UQJYMq4iJkZvEqeJ1WO9G4BbUkcNDvMLI1Z0+E52R
    p16OMXLEglADqukqNzFp8bUTRVoNov8rrP6TUJHsoX8wdqBCvCAR1QJEVGUFBSJJf12z
    rUS8/WX4tAL/fMg8SGFPeTNZiAG/yRSmob8qoS0421Z3348yOOQzy4tvqGURq3jSJvUb
    V0aA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1719942903;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=E673tN2YQj+8YdDOgypEUonLvv3SNH0/z/xJh5Re/DY=;
    b=mvSgJCG5rSIq5dPPNijVjlXgWwhiola37MFtb1m9skjSHrEwcRhKFw/ZcTO6ifc2/j
    pc4T1yNBPdQzycn+0ygstbXGz2axwqCpcExcrz8XrXX9eswR++lMGY93b9M1Ae6cF8HC
    petAvBZi2jHzkmgwOGjA14GAKa/hTw4eywvEf05JrKNd680jgimHJ7tT//YlvzjC0Uy5
    rcW/gQJgAf2lCgz7ut9YKi4HsoGOJmKU2sI5ZBJtXd9VMK1VTAlDkYbRULcr5DfqH6OO
    aeNMdV2zsMVVFzpYCyxMTqcR4wnyuxFuJi8IwHjGNolp9q61vUNOO1qSpKiMo7H3r2e0
    FMyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1719942903;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=E673tN2YQj+8YdDOgypEUonLvv3SNH0/z/xJh5Re/DY=;
    b=2L5SkDMMJPrUnN6/0MOrNysN60u+4JYcWSxBecqkr/iZwN1FF+8LF70umCGJRvJDoJ
    2NmsXx+urSXr+XIM6BAg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHvJzedR43JwibS68C57Gui33iwqCo/HyxjBt/hV5IkL4zA=="
Received: from [IPV6:2a01:599:803:d861:d64a:638:126b:586e]
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e08389062Ht2M9R
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 2 Jul 2024 19:55:02 +0200 (CEST)
Message-ID: <68b7988d-eaaa-4713-99c3-525a34c5b322@xenosoft.de>
Date: Tue, 2 Jul 2024 19:55:38 +0200
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
 <861q4bizxc.wl-maz@kernel.org>
Content-Language: en-US
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <861q4bizxc.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc,

Thank you for your reply.

On 02.07.24 17:19, Marc Zyngier wrote:
> Christian,
>
> On Sun, 30 Jun 2024 11:21:55 +0100,
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>> Hello,
>>
>> There is an issue with the identification of ATA drives with our
>> P.A. Semi Nemo boards [1] after the
>> commit "of/irq: Factor out parsing of interrupt-map parent
>> phandle+args from of_irq_parse_raw()" [2].
>>
>> Error messages:
>>
>> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>> ata2.00: qc timeout after 10000 mssecs (cmd 0xec)
>>
>> Screenshots [3]
>>
>> I bisected yesterday [4] and "of/irq: Factor out parsing of
>> interrupt-map parent phandle+args from of_irq_parse_raw()" [2] is the
>> first bad commit.
>>
>> Then I created a patch for reverting this first bad commit. I also
>> reverted the changes in drivers/of/property.c. [5]
>>
>> The patched kernel boots with successful detection of the ATA devices.
>>
>> Please check the of/irq updates.
> It is hard to understand what is going on with so little information.
>
> Please provide the device tree for your platform. It isn't possible to
> debug this without it, no matter how many pictures you provide. If it
> doesn't exist in source form, you can dump it using:
>
> # dtc -I dtb /sys/firmware/fdt
>
> and posting the full output.
>
> Additionally, a full dmesg of both working and non working boots would
> be useful.
>
> Thanks,
>
> 	M.
>
The device tree of the Nemo board and further information: 
https://forum.hyperion-entertainment.com/viewtopic.php?p=54406#p54406

Cheers,
Christian

