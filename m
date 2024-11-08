Return-Path: <linux-kernel+bounces-400892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3B79C13B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B061F21E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1744F14012;
	Fri,  8 Nov 2024 01:38:59 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6DDDC3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029938; cv=none; b=DKoh2tMtwUqRGtdaxSok7RlR/ieJCyFhKPxmPghsnGzcn33MxnjFWLZ69m9Ic5n2gXC+45qNbIGYB7rdEY7aG0pUaVREPb4Zk0rQRB34PbuB0Zwu+vYU5OjOU6a9p0BardkEJW9SOHDSDzkvAFFl16JlbTgkNdG970pshST1rj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029938; c=relaxed/simple;
	bh=GztnvjYBw5PwTJR9ZRQ1G4umLnC8+WcqZjHtuS6LVL8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eqdRHqj1p6Q+dVhfIhdhPSjzMSaWz0fr8Ex9ge+tq9CdJBNDhEAccXT+MO5smlBniDU+eVrghaGI0bDXGks3/1FGuIhcWCgpvemt6PX9OLiRFb+4bKRhF8CIbCBbONjMa6mfjv2CcA6yPp1qyryFoYHicNo6rJX3Hvkrvmglhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xl1l92x6nz2Fb3V;
	Fri,  8 Nov 2024 09:37:09 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 87DFB14010D;
	Fri,  8 Nov 2024 09:38:52 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Nov 2024 09:38:50 +0800
Subject: Re: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
To: Waqar Hameed <waqar.hameed@axis.com>
CC: Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>, <kernel@axis.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryder Wang <rydercoding@hotmail.com>
References: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
 <0f040e0a-c27f-2f29-6d9e-9c7152a18513@huawei.com> <pndttci1xgd.fsf@axis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <198ba9bd-9ef1-0cff-696e-6532dcdbe0dd@huawei.com>
Date: Fri, 8 Nov 2024 09:38:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <pndttci1xgd.fsf@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2024/11/8 6:38, Waqar Hameed 写道:
> On Thu, Nov 07, 2024 at 16:39 +0800 Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> 
[...]
> 
> P.S
> I wonder how many systems that might have experienced this
> use-after-free and got random memory corruptions (or other security
> issues). This bug has been there since v4.20.
> D.S
> .
> 

Maybe the authentication feature is not widely used.

