Return-Path: <linux-kernel+bounces-247842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D9192D563
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2253D1C21346
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203A1194A5D;
	Wed, 10 Jul 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="mB0b2hv2";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="s9tWOi+0"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4E17B05F;
	Wed, 10 Jul 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626840; cv=pass; b=anWmviys5VB05Z7hDaqk0Msz63js2M8XTavZSKI6r0oLHCCtuGk1ACzZlhz9cG4+ZyX6BVSdxrSUHpS6Vz6X2GCAWHGS/352P2YpYzOp5kTF/EngLWXKjFA1dvZQLRqoKc+Rw2iiozr1h8PDXBONsu91mvoaA3hiTeh7hXsT7lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626840; c=relaxed/simple;
	bh=PfucqSUYS+2Wqh2OLAbjFuyLzje/ymDp4Oy7t2u0uA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UO5ENjaOyAGyAvT58QKUezvVqB7fpsT1UFrxpXAHSI6sbVsADP7htxFBZO4Yb/xUfZ12kDlD1G57tk9E/NN6Le9WPmBHog0cfB4uIP84Xbg5z6a4sjDI+SlQE04jq4LiJhNfMazz9pqdNsGVdBH+Q71drL1A3K8CLNvyBIRL4Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=mB0b2hv2; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=s9tWOi+0; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1720626794; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dhyLrJQzKZA7DetdcIkoUYtZlOXNv9rpWJSMJ1R8xg3HZ17NsO/MiB7gNWrRq4AQsR
    Yjo4Hzoa8yiHhcXYa7fHcMvPFMWY1iWzcWhPF6PrUb7VupUhq/i6AYU7xayzNk6Jusmn
    YCRMg2FnwtEZQGQSa7gCBiWh+XRSNll2h4TLtx3SR5Mt+f7Hag30zFNzQl6D49eJOxMM
    8ftPOku0iqPE4mt+7mIPMHaxPBE6HtS6MFGlR2J3Kfnil/Rj7nKMDpaCYP2iVMQ2tTDW
    TJJW6WAnAG3dBTyFXR9rFjzFhn3vPZ3zOBMudrqGC/+1/1YxnLkn5HmJfSPlp/Za4hgz
    lO5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720626794;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PfucqSUYS+2Wqh2OLAbjFuyLzje/ymDp4Oy7t2u0uA0=;
    b=lBpxtWNEWFrbQreyJFuFetyh8+Xzg2YZmlmdGeJv+GadRZTKuQ1oPXMvJF5fSPriun
    9U+Qmx9GEVKBm+GYdAZVAqy9cAo636MY57EyiFTEFOWifdHBS46CK1IyfVR/61hxFY0Q
    yPWma5hStpR8ZB0/5e+CrdW2/GPip0UVTk5JttHnwWbEeAnHnbqD21p1Z2eqy7hkRGeM
    BIXCwlOvDuPPsSI8xg/VGbm7sR8JPJJ4OZQO+hrPd2wFVEWTF4gBCfDfkuyssOKzVlOp
    dCi0GzrKehgSNexdBlrYu5ckQ0OVlj2xS3DUoOkOL2RORjnxuFOXdwZjIodGs1GVUwQF
    apAg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720626794;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PfucqSUYS+2Wqh2OLAbjFuyLzje/ymDp4Oy7t2u0uA0=;
    b=mB0b2hv2DF7m2tJU8+UeYYjmV1OWNT3FOg7UskOUsY9kG5UD+YRN6a/NbDuqV6lnJe
    EAsLJTOZB5MOQ/g0SUx4GScLEWFIyjOK81hHuaIFjek46OXtoivmxnZ9x9m7+yPAIjeO
    3X+aSnN9XzBB67BG4AkJXnzuA6NFigknCWsx2aoNz5umCnkBBNNJwVw0QUoX8b7uVvIA
    YfafM+btmLzLMmYMZNe7+zpJ7x8neS2tvUUR+DzA9R1u3pVckp+3PgwNTNhkIKCtc4qd
    c/Xwjx4LzBj0bkGlqug+4ySGweA1Yr7EwU9yvM/mYNfB9ltJYMMgyx6h0d+Dwbwet1Dq
    3aEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720626794;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PfucqSUYS+2Wqh2OLAbjFuyLzje/ymDp4Oy7t2u0uA0=;
    b=s9tWOi+05jDhMZ4ulq0O7cTH5q6ijzd2PTvo/v6DMvg9kuaq2O0DEE8bJuHkTmJtcJ
    IN8tv3s9q3j0NQSg4tAw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHvJzedR43JwmbXmfCciixhc6PQvMamQd/ks6Pmy/QEdWPbg="
Received: from [IPV6:2a01:599:807:3814:9744:3840:d777:9185]
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e0838906AFrClkR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Jul 2024 17:53:12 +0200 (CEST)
Message-ID: <56b743eb-7d21-4432-b44d-909a5ce0f259@xenosoft.de>
Date: Wed, 10 Jul 2024 17:53:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives
 after the of/irq updates 2024-05-29
To: Rob Herring <robh@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Marc Zyngier <maz@kernel.org>,
 apatel@ventanamicro.com, DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Matthew Leaman <matthew@a-eon.biz>, Darren Stevens
 <darren@stevens-zone.net>, Christian Zigotzky <info@xenosoft.de>,
 hypexed@yahoo.com.au
References: <aeaa9b78-5853-473e-b985-b10241e88e0d@xenosoft.de>
 <8FDD860C-4DA4-46EF-BAD6-8F68837DA993@xenosoft.de>
 <c8010a06-9d8d-466a-9a83-ee25950f1885@xenosoft.de>
 <CAL_JsqJE+YZY3h+MZ0wzT2SZ5dLq_zR1iteNcdLUOoVPwKkxRw@mail.gmail.com>
Content-Language: en-US
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <CAL_JsqJE+YZY3h+MZ0wzT2SZ5dLq_zR1iteNcdLUOoVPwKkxRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.07.24 17:05, Rob Herring wrote:
> On Tue, Jul 9, 2024 at 9:53 PM Christian Zigotzky
> <chzigotzky@xenosoft.de> wrote:
>> Hi All,
>>
>> The RC7 of kernel 6.10 boots without any problems [1] if we use the
>> second irq patch [2]. Is it possible to add this patch to the mainline
>> kernel?
> Yes, sent it to Linus yesterday.
>
> Rob
Great! Thank you very much! :-)

Christian

