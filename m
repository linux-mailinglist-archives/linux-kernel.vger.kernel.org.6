Return-Path: <linux-kernel+bounces-356843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFED4996795
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E41B2573A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407CD18FC80;
	Wed,  9 Oct 2024 10:46:50 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6A45948
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470809; cv=none; b=MHvJyuuOXzmLGVL0Sw+ro4MoH+wnPSAuoQ7bgSf1/6OLxOKyR24rJjNNWKKCaq5pxO2FMmZ772JI0564QvFAZYzjY+juu3HNYgOjPIl22xW4cr3+f+VnuH3y1NIZy9SLvRT8T5owYoDNNt4gLU0zwczI4kQaVA100MFaQUMZN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470809; c=relaxed/simple;
	bh=cFN5IwcjLh+7h05skhckaLYhTNaSKkYk1e8sSJjgxmw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=s4805y/L50TGCpnPD0jVOa398xDZMxb9dSVbAYexk6qtvjG6mC/QhOFBIWlPGNw8Bam3Yxr8WXHcnBXGZsx5mXsrcmcL8Tb9DhyxcWd1RpTy9PMhZvHY3FG/ZHwu0UtyrwB9rGQDcwyCL5qRxnnOh9yEpLsl4eRNG7HsGYuY8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XNqK91XlHz1T8Rj;
	Wed,  9 Oct 2024 18:45:01 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 85C53140360;
	Wed,  9 Oct 2024 18:46:44 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Oct 2024 18:46:43 +0800
Subject: Re: [PATCH 1/1] ubifs: Try to recover from missing znode
To: Richard Weinberger <richard@nod.at>
CC: Benedikt Spranger <b.spranger@linutronix.de>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>
References: <20241008133342.1937674-1-b.spranger@linutronix.de>
 <0840be30-63bc-449d-a9a4-c4e6b54c8885@huawei.com>
 <883601802.30668.1728453832223.JavaMail.zimbra@nod.at>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <351bdd98-98ac-036f-4685-56e88a102cf3@huawei.com>
Date: Wed, 9 Oct 2024 18:46:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <883601802.30668.1728453832223.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2024/10/9 14:03, Richard Weinberger 写道:
> ----- Ursprüngliche Mail -----
>> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>> An: "Benedikt Spranger" <b.spranger@linutronix.de>, "linux-kernel" <linux-kernel@vger.kernel.org>
>> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "richard" <richard@nod.at>
>> Gesendet: Mittwoch, 9. Oktober 2024 04:23:02
>> Betreff: Re: [PATCH 1/1] ubifs: Try to recover from missing znode
> 
>> 在 2024/10/8 21:33, Benedikt Spranger 写道:
>>> After powercut on a system using ubifs mounting failed:
>>>
>>> 2024-09-30T12:38:26.880487+02:00 sonja kernel: UBIFS error (ubi0:0 pid 2178):
>>> ubifs_read_node [ubifs]: bad node type (255 but expected 9)
>>> 2024-09-30T12:38:26.880506+02:00 sonja kernel: UBIFS error (ubi0:0 pid 2178):
>>> ubifs_read_node [ubifs]: bad node at LEB 103:46920, LEB mapping status 0
>>> 2024-09-30T12:38:26.880509+02:00 sonja kernel: Not a node, first 24 bytes:
>>> 2024-09-30T12:38:26.880510+02:00 sonja kernel: 00000000: ff ff ff ff ff ff ff ff
>>> ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>> ........................
>>>
>>> While traversing over zbranches during the journal replay one zbranch
>>> points to a znode, which was not written to the flash and therefore the
>>> flash is empty.
>>
>> UBIFS guarantees two things for znodes:
>> 1) all index nodes(in commit seq N) are written on flash before master
>> nodes(for commit seq N) are written.
>> 2) all index nodes(in commit seq N) won't be erased from flash before
>> master nodes(for commit seq N+1) are written.
>> So, I don't understand that why znodes not exist during journal replaying?
> 
> In addition to that, is just one znode missing or are larger parts of the flash
> empty?
> 

After reviewing the TNC related code, I cannot find out any illegal 
behaviors to make znode lost or valid index LEB erased.

Hi Benedikt, could you provide a corrupted UBIFS image? Let me try 
getting more information.

