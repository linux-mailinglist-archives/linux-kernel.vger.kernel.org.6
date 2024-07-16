Return-Path: <linux-kernel+bounces-253709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FD19325AD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D5B1C21FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE421991BB;
	Tue, 16 Jul 2024 11:32:40 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23815491
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129560; cv=none; b=rN0v5jIv4QEXBDmdSTtU6SXbIjhHnvSRrCyPEsl3L7k/+tGQ3Z5pOIHs0PKxUrDmhXoq/vKJb0lciaSIPyF8h1KhbZc4G+Kq1OYJ260GNuOccq+L04iARhtiais7BAyH6YiGbGrU+PpzKbLswFAu8e8MJQQfpYhfu0wJFPMO48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129560; c=relaxed/simple;
	bh=/CMspuTbviwsvCwrgOi5LH7wTNtSRcVuk0D6ZgaiRJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u6XrWmFndWRCQvAlCddtBMs/VlEMukDF0kSjLQ+/bxRpQMuamulm3l0AkBL00VqWV69cAnbpxSiYVZ6SRuRxP+LJpvpv7Bw0r+fxI0bamm62DHbVY+FRlleScbtS09IzG7AGMJmU08ljIuLAsU6EVDfSoo2kMVU+zZZu859ImWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WNcNb4QJFznbGr;
	Tue, 16 Jul 2024 19:31:59 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B9BE180064;
	Tue, 16 Jul 2024 19:32:36 +0800 (CST)
Received: from [10.45.179.188] (10.45.179.188) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Jul 2024 19:32:35 +0800
Message-ID: <ba2702f9-f66e-498b-853c-d23f1f9191bc@huawei.com>
Date: Tue, 16 Jul 2024 19:32:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH sched_ext/for-6.11] sched_ext: Reverting @p->sched_class
 if @p->disallow is set
To: Tejun Heo <tj@kernel.org>
CC: <void@manifault.com>, <linux-kernel@vger.kernel.org>
References: <20240711110720.1285-1-zhangqiao22@huawei.com>
 <ZpArK0qxZZI-0ykt@slm.duckdns.org>
From: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
In-Reply-To: <ZpArK0qxZZI-0ykt@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200007.china.huawei.com (7.202.181.34)

hi,

在 2024/7/12 2:57, Tejun Heo 写道:
> Hello,
>
> On Thu, Jul 11, 2024 at 07:07:20PM +0800, Zhangqiao (2012 lab) wrote:
> ...
>>   		if (p->policy == SCHED_EXT) {
>>   			p->policy = SCHED_NORMAL;
>> +			p->sched_class = &fair_sched_class;
>>   			atomic_long_inc(&scx_nr_rejected);
> Did you see any issues with the existing implementation? The policy is set
> before the task is attached, so it should work fine. Also, you can't change
> sched_class by just assigning to it.

What does "attach" mean? I'm not sure. p->sched_class is assigned in 
__sched_fork()
which is performed before scx_ops_init_task().

>
> Thanks.
>


