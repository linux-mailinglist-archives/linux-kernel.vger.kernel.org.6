Return-Path: <linux-kernel+bounces-313397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BAD96A4F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B511C237B9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EF018BC07;
	Tue,  3 Sep 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=milecki.pl header.i=@milecki.pl header.b="gS2Wt6Hy"
Received: from 3.mo561.mail-out.ovh.net (3.mo561.mail-out.ovh.net [46.105.44.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC01C14
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.44.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382939; cv=none; b=FYTdcHfWDK1O5Fcmt5haj8G7pRdQRMSO0yNi1t4crRfLiS0hDr+bRippuhxfb+kwdg690tXIzKy3DFkC4kDITA2AIAAlkPWGGVRMBj31wOzFhIf3uBuHEYgxdVEZXt6COm1wH1DnL/RcAtxstDcKcB9crFEk+Xyu53pY7UkQKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382939; c=relaxed/simple;
	bh=XJWsN49MKuwfqhUmsYeBNb3/CGm+AL947KnsCvqSJXU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cak16P+wKZY1PPs4wB9cWOLjW6xPCErPGVtBPY+7MNZxJjLYy5f+FlYhFXBH6k2RxrgyGD7OZF5Lp60HxvtAVt+57zCB8c+61/sv6EhtHhEQerfzCFdje1rF8YIUmKJfo4+jO6J0+nHpUJDT1jZCbzqgJdLmI0QxZbtCciBVVm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl; spf=pass smtp.mailfrom=milecki.pl; dkim=pass (2048-bit key) header.d=milecki.pl header.i=@milecki.pl header.b=gS2Wt6Hy; arc=none smtp.client-ip=46.105.44.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=milecki.pl
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.17.174])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4WyjS51Jddz1R66
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:04:21 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-vfzqd (unknown [10.108.42.28])
	by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id D0F9B1FE8D;
	Tue,  3 Sep 2024 11:04:20 +0000 (UTC)
Received: from milecki.pl ([37.59.142.102])
	by ghost-submission-6684bf9d7b-vfzqd with ESMTPSA
	id OKakMDTt1maMTQEA6n6LAA
	(envelope-from <rafal@milecki.pl>); Tue, 03 Sep 2024 11:04:20 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-102R004b1da4c13-023e-4a9b-8ea6-35da4fbbdb49,
                    58277AE186FD25B235DEA53DD7F3636C045A473A) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp:51.255.71.60
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Sep 2024 13:04:20 +0200
From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org, Miquel
 Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/9] nvmem: layouts: add U-Boot env layout
In-Reply-To: <2024090308-smasher-craftwork-0db5@gregkh>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
 <20240902142952.71639-5-srinivas.kandagatla@linaro.org>
 <2024090308-smasher-craftwork-0db5@gregkh>
Message-ID: <ef6d4f332224bd7a8c1c4244047bf0ea@milecki.pl>
X-Sender: rafal@milecki.pl
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17092567962599598884
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghfkfigihgtgfesthekjhdttddtjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepjeejkeekgeejtdffffevffeivedtueeifeeuffegkeehkeeliedugfelfedutdeunecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipdehuddrvdehhedrjedurdeitddpfeejrdehledrudegvddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedupdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=cBsEzXBwS1oJ7/X0qvaQ23UYEd73W8BGXOUmsSkLpO0=;
 c=relaxed/relaxed; d=milecki.pl; h=From; s=ovhmo3028686-selector1;
 t=1725361461; v=1;
 b=gS2Wt6Hyjz2SK6nn6+hdbmwabuV4JURnzNMOtDf5VgMT0OorKvY/mSwGLbsSDAwDmEhr3M+K
 S0opF9ijPKl2r66ojgoPdhAAe1510VLu7rrlCQXZNRiT/hU58guhnC1sij3He3tu+bvHn/tRzta
 kZGBtU/IG3mhxLg2qVQwOKlYBPMjugCLxQSYNVmNHJ1QXKkaxo1pYL4BnA5t6Oq0+5DHrTI8uWv
 2BSv3D/7dy9wWKAoi5BqxLwhkxhXAc1ySGOal45IG4JQTTKvljg6G6Hxgu7OGD40noILw8SJZyS
 9n7cAPiGE/MqTVsT/Gtatvdsj8JCoEzxOlgMgaU56WnjA==

Hi Greg,

On 2024-09-03 12:12, Greg KH wrote:
> On Mon, Sep 02, 2024 at 03:29:47PM +0100, 
> srinivas.kandagatla@linaro.org wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>> 
>> U-Boot environment variables are stored in a specific format. Actual
>> data can be placed in various storage sources (MTD, UBI volume, 
>> EEPROM,
>> NVRAM, etc.).
>> 
>> Move all generic (NVMEM device independent) code from NVMEM device
>> driver to an NVMEM layout driver. Then add a simple NVMEM layout code 
>> on
>> top of it.
>> 
>> This allows using NVMEM layout for parsing U-Boot env data stored in 
>> any
>> kind of NVMEM device.
>> 
>> The old NVMEM glue driver stays in place for handling bindings in the
>> MTD context. To avoid code duplication it uses exported layout parsing
>> function. Please note that handling MTD & NVMEM layout bindings may be
>> refactored in the future.
>> 
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>  MAINTAINERS                        |   1 +
>>  drivers/nvmem/Kconfig              |   3 +-
>>  drivers/nvmem/layouts/Kconfig      |  11 ++
>>  drivers/nvmem/layouts/Makefile     |   1 +
>>  drivers/nvmem/layouts/u-boot-env.c | 211 
>> +++++++++++++++++++++++++++++
>>  drivers/nvmem/layouts/u-boot-env.h |  15 ++
>>  drivers/nvmem/u-boot-env.c         | 165 +---------------------
>>  7 files changed, 242 insertions(+), 165 deletions(-)
>>  create mode 100644 drivers/nvmem/layouts/u-boot-env.c
>>  create mode 100644 drivers/nvmem/layouts/u-boot-env.h
> 
> This patch doesn't apply to my tree :(
> 
> Also, if you generate patches with 'git format-patch -M' you can see
> when files move easier (if that's what happened here, hard to tell..)

It's because it was developed on top of "nvmem: u-boot-env: error if 
NVMEM device is too small" which you applied to the "char-misc-linus" 
branch. Perhaps you could push that fix ("error if...") to your both 
branches somehow?

-- 
Rafał Miłecki

