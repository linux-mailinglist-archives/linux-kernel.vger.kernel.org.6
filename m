Return-Path: <linux-kernel+bounces-338166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EFC985436
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A565B20BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B810155335;
	Wed, 25 Sep 2024 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=milecki.pl header.i=@milecki.pl header.b="Ovl4kHSG"
Received: from 5.mo576.mail-out.ovh.net (5.mo576.mail-out.ovh.net [46.105.43.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9CB132114
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.43.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249567; cv=none; b=Uuto3tCM2FawgjM+mztDbWbjG86QehHzkLK8I5+9j3ijPO0tZkJm9XozFLTp+xihleb5EfoH+L0i7NjD0jLEaNVUUDftgRauVDSErJ3Y12mTf3PJx3ZhPnrNdTpOuTsEgV//sOXTw3N9Iyl87MgsfSImaz7eD5dF71vGkicZeIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249567; c=relaxed/simple;
	bh=FyQ+PaSDOc52BM9gnVH3xSMvP/hTE2Dzz/PW17DJve8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eSoPqFsQJ9pL/zbvsLQK8dJ+ty7fFTccq+MdvP+ssoQB83w61vNe8v41KBsW696Hf82b7hQg36TqsZDS21etm4HWJb2JS0+NsGtdxvK/tf5RHXc16VGkLEifc8XRldPT9KMRpBbptKU8otA6gGGBufykKFuuqc4Ei50ZH+BXMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl; spf=pass smtp.mailfrom=milecki.pl; dkim=pass (2048-bit key) header.d=milecki.pl header.i=@milecki.pl header.b=Ovl4kHSG; arc=none smtp.client-ip=46.105.43.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=milecki.pl
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.139.3])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4XD7WR6nJ2z1q0F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:23:47 +0000 (UTC)
Received: from ghost-submission-55b549bf7b-64cjv (unknown [10.110.118.154])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 4775F1FE3C;
	Wed, 25 Sep 2024 07:23:45 +0000 (UTC)
Received: from milecki.pl ([37.59.142.103])
	by ghost-submission-55b549bf7b-64cjv with ESMTPSA
	id mUbACYG682ZBNAAAyTvjrg
	(envelope-from <rafal@milecki.pl>); Wed, 25 Sep 2024 07:23:45 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-103G00530c11656-fd2d-4e51-b038-3339ee5f64f8,
                    9DD8DC6CF38314E8515C70E4989C69D14BB97D32) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp:176.31.235.81
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Sep 2024 09:23:44 +0200
From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To: Sandie Cao <sandie.cao@deepcomputing.io>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Michael Zhu
 <michael.zhu@starfivetech.com>, Drew Fustini <drew@beagleboard.org>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dhs@frame.work, ams@frame.work,
 gregkh@linuxfoundation.org, yuning.liang@deepcomputing.io,
 huiming.qiu@deepcomputing.io, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor: add deepcomputing
In-Reply-To: <20240925053123.1364574-2-sandie.cao@deepcomputing.io>
References: <20240925053123.1364574-2-sandie.cao@deepcomputing.io>
Message-ID: <9e32cc30b1c9923f985aa6786d1f9d62@milecki.pl>
X-Sender: rafal@milecki.pl
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13439585716663266069
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtgedguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhfkgihitgfgsehtkehjtddttdejnecuhfhrohhmpeftrghfrghlucfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeejjeekkeegjedtffffveffieevtdeuieefueffgeekheekleeiudfgleefuddtueenucfkphepuddvjedrtddrtddruddpfedurdduuddrvddukedruddtiedpudejiedrfedurddvfeehrdekuddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=oItKQ7Un4VVtOguEdJMdsbTrZ/zvp+itPGogkzlkK3Y=;
 c=relaxed/relaxed; d=milecki.pl; h=From; s=ovhmo3028686-selector1;
 t=1727249028; v=1;
 b=Ovl4kHSGTKMErUPsh99wFV9ywc1NXhkv4W4b/wxPhu+8OY/PTRr7RVL/1a3rSQ0+zjGtZsCX
 sBn6acYwUaURTOmlLCHj1xYZjb+yeb/elRftToCNh26hE2BoWnBgAIez5SyHszscWcLwCyt5I3u
 M4VgZhlwnLHLgIjwUJxrPtqZ4/nCv+OtjjSEgTjQJmCF0BVYhxE5kYM4/S6O0ngtzu4TOf6NBHW
 K+xThf2JP6f+2J/2QPuEhF8pfvDk6sKz3863KeZynfrARAwpOB+SFKHEWiewOuRkmPzbCwrWodI
 +Plooid2MqWS9co3Y1LSMvlCwFMD35DuuJQIpzZ82Hh7g==

On 2024-09-25 07:31, Sandie Cao wrote:
> Add deepcomputing into vendor list.
> 
> Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

This "PATCH" is empty. Please verify what's your about to send :)

-- 
Rafał Miłecki

