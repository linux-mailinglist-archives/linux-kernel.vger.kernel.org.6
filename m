Return-Path: <linux-kernel+bounces-235173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C24A91D110
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 12:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C925D1F21519
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F75135A65;
	Sun, 30 Jun 2024 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="rrNyYJtj";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Fx7TSSIK"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBAE39AF4;
	Sun, 30 Jun 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719742963; cv=pass; b=nlyhKZLsYSRxwV3oP0jBMYzfXqCwLHBJezK0wTJw498/mT8DdT88IsZOVgzSvf9cx92N7VaPuYTqIULl8wSdy3yNOLabLDHv/zE/MPByAlDwie6fwiKSz5qZvZjX8rozAHsX2Naklo+cpKI8pz/CMEguKiTvhL9zp5PvqwbAGyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719742963; c=relaxed/simple;
	bh=R9fpC1UOjFrQKHRI6TgHz66Hbzvd1ayFN0DprYdtRq8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=VSsyqkztZec+q37ej1PJsyCBUKQAC5I3X5Eh+PJP+nE8zNm3hpNXEwTa8B4tU9UnqZWypRX761qcT/lkWTUYUlYd4pNZuRt157MYjMZpKT16LYjjaCigTfQkU31p0ptibcCRhZbIXTVLmEhZ65FeA3ImQAqeR3BFW7V80347H/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=rrNyYJtj; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=Fx7TSSIK; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1719742917; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DM7U0nYhlpqhcR7998gBwwIeNC4vzlyVQxbMCYAxIgLpE18CE7BOFt7dN5u64JPmuk
    0da9wlnU3NtkQZSzDT/8OtKBo+mXyHQ8NCWrAWg7mHHvwr76AuU5WAekWaLq2A4sRopt
    BRHuqy8zAXGxq6SqSTCeA9eEUguNFkkwmBLwtT0n716VehnHmpoI/3utoFHmr/wepAun
    fUvjBYP9SHUNyX+HD2MT8h57vbYsxoFnsoLNinFB97z031a6qbe6Mk55fdNMxHU2ds0i
    X6ymRjaHETIEZVzIF/jOXRaMkWGmI4Y5eYNSb6tTjKluNo7Df7GMAq6BQX9hAqi4fGon
    Aobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1719742917;
    s=strato-dkim-0002; d=strato.com;
    h=To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=koImhGjb7REMlZ/XmgRbFgMfDWJDeMGzhBpOSppcQCg=;
    b=Kyq5TvX6BUoJ+sS67S5L4oCBtwxb6qdAAlNGZDb3gNYWT0ScvEPStFU6Na+xZ5WBSc
    RfRMlC6ALkkUZw1W2NGXe6uBhj/0Q80EJC8Fv/A5FpL3+rpUckiB2MzhlRg5FwZ07+7V
    MocptiXQD9sngtWwVkMrFlR8ElsfIem/tyVLL3Ef97UAQ0nxaOobgAPPG+P1U9fdMGCe
    hk3N6/BID/u+xXf6HKryCDZApEIjzFRT/jDtRlVbLLMp3oTv6Xa4ViZ4ZJqnWZ8QLexy
    8WjV/delbr2TtGKtS0bWqKA1+NqgxM147ek1fuftuLIPpfmSFfBKuFbtAEtbK0lVzSBm
    JatQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1719742917;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=koImhGjb7REMlZ/XmgRbFgMfDWJDeMGzhBpOSppcQCg=;
    b=rrNyYJtjpkKmA0QcxDXpASOq7JUYgYpK8eqvuabSrMY/XKau9q0jf+L3f/to4GshVo
    PWOFU9qtStMYJocl73DgMLrfJDeoYah/I47xyL83JIbZIRE0hPVr7j9hiiKiDedT7LpN
    DV54Ozm0w+GtdsHZhVYwbZ2rfEUPn7DqvOgD4PAyRywdPnnqvXQRyt2hmzz1Xo9wMUO4
    0pPT0nU8PpmIGwRgwUZii7y1bksB+l3Hn7RjWitQp5UBgOV9KUwYk/nTcECZAoc5udIW
    FINdRvAm9wsQhvVi7HbhIUDhZp6zoP+Ge7mDFdFs05lg4HIfmpS4I60HEIAiLLq5Z1RG
    NyUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1719742917;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=koImhGjb7REMlZ/XmgRbFgMfDWJDeMGzhBpOSppcQCg=;
    b=Fx7TSSIKx2lKyTwirMmbPOP29OkpoRezklgZkMUFwV5mrLnJQRHNxIxnD5Ya6KyCyY
    aSGF+2gGrFWywueMpqCw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBfi4XXBswJY17nMJxMU7SicerhpVThcASu2X0Ag=="
Received: from [IPV6:2a02:8109:8984:5d00:8535:f3a7:32a7:65f9]
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e0838905UALuCbd
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 30 Jun 2024 12:21:56 +0200 (CEST)
Message-ID: <3ab66fab-c3f2-4bed-a04d-a10c57dcdd9b@xenosoft.de>
Date: Sun, 30 Jun 2024 12:21:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PowerPC] [PASEMI] Issue with the identification of ATA drives after
 the of/irq updates 2024-05-29
To: Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
 apatel@ventanamicro.com, DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Matthew Leaman <matthew@a-eon.biz>, Darren Stevens
 <darren@stevens-zone.net>, Christian Zigotzky <info@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

There is an issue with the identification of ATA drives with our P.A. 
Semi Nemo boards [1] after the
commit "of/irq: Factor out parsing of interrupt-map parent phandle+args 
from of_irq_parse_raw()" [2].

Error messages:

ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: qc timeout after 10000 mssecs (cmd 0xec)

Screenshots [3]

I bisected yesterday [4] and "of/irq: Factor out parsing of 
interrupt-map parent phandle+args from of_irq_parse_raw()" [2] is the 
first bad commit.

Then I created a patch for reverting this first bad commit. I also 
reverted the changes in drivers/of/property.c. [5]

The patched kernel boots with successful detection of the ATA devices.

Please check the of/irq updates.

Thanks,
Christian


[1] https://en.wikipedia.org/wiki/AmigaOne_X1000
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.10-rc5&id=935df1bd40d43c4ee91838c42a20e9af751885cc
[3]
- https://i.ibb.co/WcH8g4K/20240626-095132.jpg
- https://i.ibb.co/K7KnDxx/panic2.jpg
- https://i.ibb.co/frnbJfb/panic3.jpg

[4] https://forum.hyperion-entertainment.com/viewtopic.php?p=58585#p58585
[5] 
https://github.com/chzigotzky/kernels/blob/main/patches/X1000/of_irq_v2.patch

