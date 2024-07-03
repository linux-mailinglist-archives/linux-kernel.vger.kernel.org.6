Return-Path: <linux-kernel+bounces-239851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A93926611
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C701C240F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA641822D8;
	Wed,  3 Jul 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Gy2Siy32";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="XNCTpZau"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0533185093;
	Wed,  3 Jul 2024 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023793; cv=pass; b=HYFlADwqcPOhvqGDgVb8N/4g3LTNef+Sx5s8oWknqjWVNI+VBS0h1k84+jciqDSt27sQVOeOO+i5ZCIMT+j41R2E5LXMZXsVu+wn8NhYszI9deFsZWtsX9aVySDxHYcMNUnX3TUmxTQ0MifQPVEXEwN1t7O1grFWtqS2pqvOkho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023793; c=relaxed/simple;
	bh=kHVkSU9bSnZ7p8Z0PSj2JpXNxtfluYvXtkY+97pv/OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djOj8yf9tb/P2+AUWfq4gzGlXGRguQz5HlIE6ho1qjgndnwlqUE3HZUC6Yv0pAwnjkPya1w1wTGr0CeEro2q3j0F5pld5e3IdCJicU2hwfizdxp7c33eCYxkG6Ne0RNNwVOR/KyhObMM0RGJyEc73pj2Tegdt0ig4UsHAS+MQYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=Gy2Siy32; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=XNCTpZau; arc=pass smtp.client-ip=85.215.255.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1720023757; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VVORDbf2msCtWnL/pUXyiHuHFrAdVWz4sP9G4CxWWlzj1zgWlyQZcgZsNLKgRfHDgB
    iUIaBCEtFlaRTlkKP6cHPtxGZqApiIdEpTrgM6PqY4XvqSvuG1FYbVoEWroNtlDfLyvk
    XjaR831cZttF7l+SJ+l2HxyGa1Gm7SZKTchFp41+Vwsqn1z0K4+ltswfthwdDUVcA0u0
    tE5TLbnFT6DmLOB+UrVCxLOVz3Da6m3hSWQFz0igCsTXcai/UDbrweCZGt7upjEXlOlM
    zSetek/bJ2ZPtEUUn7QxO+lh+Iqml/rk6lid1dD7rGlRIz9HusaMDY1Ih77qauRi6dsZ
    strg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720023757;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Xefpm7kp1QKwRcK53B/u3dUPROD/z4fSpwFfZlUnT+g=;
    b=Rk+2LGsv65JAMuSX49Rsm5StceZtRGYDQphIByXVtrzj3Chft+nhQYfFV+yBH6NJzH
    zRUhRTGAfUqaD4m5BH1yw/wkgbnuYq0s3OqqdKh1DinQ/G8MgBhC5Ot8fXxFQg+V0stx
    8y+vQQPmurrZDCFDwfmUe2nR2fZbD3mptY7fbeGGT7sXyJbv3jGMfSYLks0677f9e5Yj
    WaHiFNmmQyRPkyzcVTHJphl6KNKtMtpFxo8QX+c1O6NFhjj/x3xpSBuxcQx/YLAB3MXI
    pV4eUcwTJWT0howC366TUYEWWg5Xx9w87FJGwukXn62mz7XQO806ZO6ohL+kPStmXEV2
    YwYQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720023757;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Xefpm7kp1QKwRcK53B/u3dUPROD/z4fSpwFfZlUnT+g=;
    b=Gy2Siy32RcwgdZf5tB5Uj9bQMnetV5Sl2cX2/66Ss8FEXnqx5987dyz/oC31uhM+bI
    dLLYN5VN8CdH2QQspkpypOWky7u4KrJH6qz/Dyau0dnyc/s9C412IrgwdAkb2OYU2Igs
    eHCZk8/lSviFmAls+HGQ21LL0y+VsZKlunOTMEkwFzxxNhmqKSX8De84owH9dsraGS7p
    MLhpdhD5tdybUBT1fX35u3Cj8XWZq6z3Q/0G7F3etYebt19IopXWHsR/M9+EgqAb7+px
    8VehuSuapGUlAgf2fXZvdUtjxprmsShnY0DTjSWYOqwFS0WnzqoIxvEbF2SlNA6hUiMG
    yn8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720023757;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Xefpm7kp1QKwRcK53B/u3dUPROD/z4fSpwFfZlUnT+g=;
    b=XNCTpZauLp8RFotnyZ1DbdXYQFNrHQ2YuynthNSaK3ibX4zCBTn4kpSyMKYocsfTnv
    HE5EQqHZe1stoIy6kWBQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHvJzedR43J0mbSkY7T0LO5Dgwl/5WHn9PRLvYVKAUYGE"
Received: from [IPV6:2a01:599:817:c09:f2fd:d497:aff:32c3]
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e08389063GMZQ2I
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 3 Jul 2024 18:22:35 +0200 (CEST)
Message-ID: <de910b52-4f46-47a5-896d-d60af85ae293@xenosoft.de>
Date: Wed, 3 Jul 2024 18:23:12 +0200
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
References: <86cynv9dx7.wl-maz@kernel.org>
 <B550D4C4-6F82-409E-B5A8-E7D123ACB93D@xenosoft.de>
 <86a5iyahbc.wl-maz@kernel.org>
Content-Language: en-US
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <86a5iyahbc.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.07.24 12:41, Marc Zyngier wrote:
> On Wed, 03 Jul 2024 11:26:17 +0100,
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
>> On 3. Jul 2024, at 08:40, Marc Zyngier <maz@kernel.org> wrote:
>>
>> This isn't a DTS. This is a listing of all the nodes, not something I
>> can use to feed the kernel. I explained how to generate it.
>>
>> Download the compiled device tree for the Nemo board:
>> http://www.xenosoft.de/fdt-nemo-board.zip
>>
>> No, thank you.
>>
>> ————————
>>
>> You know already the device tree: https://lists.ozlabs.org/pipermail/linuxppc-dev/2021-November/236587.html
> Do you think I keep this sort of things from almost three years ago? I
> have better things to do.
>
> Now, either you provide the required information in the required form
> or you don't. Either you test the proposed patches or you don't.
>
> If you do, great, and I'll do my best to help you. If you don't, also
> great, because I can go back to the stuff I'm actually interested in
> (i.e. not your machine).
>
> This is your call, and only yours.
>
> 	M.
>
OK, here is the dts file: 
https://github.com/chzigotzky/kernels/blob/main/dtb_src/X1000/nemo.dts

Thanks for your help.


