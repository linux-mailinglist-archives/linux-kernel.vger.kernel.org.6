Return-Path: <linux-kernel+bounces-343279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B54D98990E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 03:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FEB1F211FB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2278A8F45;
	Mon, 30 Sep 2024 01:56:18 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86685684;
	Mon, 30 Sep 2024 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727661377; cv=none; b=n5wlmRdpShQg8DN5bkIy2p39QiXTIcJm9vuggqJ/usf7ygxteyw3CwnCt1FzYzh5mphLI7NZ21wNtrdvhmRGflEusF6JKK42kGMByXFom1c1o0L4+yxZJ5IKnF+UkvT8UWWEIOaLkrIMmuiaCA/o6LbUVQOHF3g0ikWTB55idcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727661377; c=relaxed/simple;
	bh=gGsFD+AZhQFZxsdoLEWaRSU1CeWly8c8qiggoTeF2ck=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J9vihXvO7C6ml7b/eJX+/teSb3kTaf18ecgJ6/kY2snipjdZYGM/lm8vWZqzRuseO5adSn3kLR1YvpGzD7/kSWX9YOlMQULIZmvjqLS6UUv25e/naRjEMWeJwuXCGioqVgM7usmJbL7KUvpSEJZnI1v3ihmyHVYnUZTPlrhwhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XH3wc376Rz1HKR6;
	Mon, 30 Sep 2024 09:52:16 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id F1B76140360;
	Mon, 30 Sep 2024 09:56:11 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 09:56:10 +0800
Subject: Re: [PATCH RFC 2/2] mtd: ubi: add support for protecting critical
 volumes
To: Richard Weinberger <richard@nod.at>, Daniel Golle <daniel@makrotopia.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, robh <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, John Crispin
	<john@phrozen.org>, linux-mtd <linux-mtd@lists.infradead.org>, devicetree
	<devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org>
 <b43a7155f80995c3986893951c092291caf3a5f4.1727527457.git.daniel@makrotopia.org>
 <251386789.117942.1727612762462.JavaMail.zimbra@nod.at>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ed98871a-b41a-9755-4eed-18ad9e00869c@huawei.com>
Date: Mon, 30 Sep 2024 09:56:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <251386789.117942.1727612762462.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2024/9/29 20:26, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "Daniel Golle" <daniel@makrotopia.org>
>> Allow the boot firmware to define volumes which are critical for the
>> system to boot, such as the bootloader itself if stored inside a UBI
>> volume. Protect critical volumes by preventing the user from removing,
>> resizing or writing to them, and also prevent the UBI device from
>> being detached if a critical volume is present.
> 
> I agree with the doubts raised in patch 1/2, if userspace is so hostile
> to delete system partitions, there is little hope.
> But I'm still open for discussion.

Yes, I agree that it is meaningful to prevent user from operating 
volumes accidently. How about doing that by some existing methods? Eg. 
selinux(Design sepolicy for ioctl cmd).
> 
> What I veto is preventing detach.
> This makes a clean tear down of the system impossible.
> It becomes more and more common that advanced userspace shuts down
> everything it setup during boot. e.g. while reboot switching back
> to an initramfs, umounting root, shutting down all storage, etc...
> 
> Thanks,
> //richard
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 


