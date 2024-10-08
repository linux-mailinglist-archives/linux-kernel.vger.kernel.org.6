Return-Path: <linux-kernel+bounces-354405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D704993D1A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2401C2141A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88292AE90;
	Tue,  8 Oct 2024 02:55:39 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86CD1DA5F;
	Tue,  8 Oct 2024 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356139; cv=none; b=ihaguOpgXDtjerWAqmMTmWUeZbFpxpiF54WSuTIV/Ui1gNizeX7Q5o6EWB/MnoEq+iRmTTiGj4McVp9WNhmps7OwBhHMuyjg/Xr+m37dtESY1o0BvUkIqBhY31l/WJ0FPsOAhBk6soYbr9v3A3cDs7lD0Y89cJCo1hW5xFKHLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356139; c=relaxed/simple;
	bh=mtdqC2y8+NQf1nFSyK17ySVlXRAwGhQxpFJnEQgp5Jo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GNSLjUcoFSnbORzBk+MrmtjCNwudk4NinCq3DqguaJK9jZm0fRs+O5th51EkJQ1S5ilVUxR6M5nOt0bLqAhY0z8sPGegtvA6Y1LceK8vQF/Ot7oWJaUEPH1Zf6kAmnBe0VaqAWKIqK4u3/+hh91b5EfnB4BrbomqdFqyNwVpabo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XN0sG0DTLz1HKQj;
	Tue,  8 Oct 2024 10:51:30 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F1E6140392;
	Tue,  8 Oct 2024 10:55:34 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 10:55:33 +0800
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
 <ed98871a-b41a-9755-4eed-18ad9e00869c@huawei.com>
 <364911897.123906.1727721820227.JavaMail.zimbra@nod.at>
 <Zvr-hOM2DfveaqeC@makrotopia.org>
 <1249604143.124110.1727726047386.JavaMail.zimbra@nod.at>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <131bb6bc-1cb3-ead7-12d9-89beba9408ca@huawei.com>
Date: Tue, 8 Oct 2024 10:55:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1249604143.124110.1727726047386.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2024/10/1 3:54, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "Daniel Golle" <daniel@makrotopia.org>
>>> like a ubirmvol ... --i-know-what-im-doing.
>>

Sorry for the delay reply, caused by my holiday.
>> True, enforcement doesn't need to happen in kernel (though I think it's
>> nicer, but really just a matter of taste, I guess). ubi-tools would still
>> need to be able to recognize critical volumes somehow, and that could be
>> done by checking if the 'volume-is-critical' property is present in
>> /sys/class/ubi/ubi*_*/of_node/
> 
> Exactly.
> I also don't mind adding a in-memory 'volume-is-critical' property to
> UBI directly. I'm just a little hesitated to change the UAPI or the on-disk
> data structures for this features.

Add a new interface under the sysfs is fine.
>   
>> If you prefer going down that road instead I will work on patches for
>> git.infradead.org/mtd-utils.git instead.
> 
> Yes. When done in userspace, it's also much easier to offer the --i-know-what-im-doing
> flag to still remove a critical volume.

Looks good, I like it.

