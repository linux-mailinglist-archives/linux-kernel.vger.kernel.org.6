Return-Path: <linux-kernel+bounces-276027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D544F948D75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A3D2842CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C121C2314;
	Tue,  6 Aug 2024 11:10:24 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4D143C4B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942624; cv=none; b=RcDQKFfB7LJ761eF5UF4O2UazmzrwkM9WqUMEwvlo8wmaSG75OP8cNi25bYwsI6JfU9JXaiwRYwFTof5VXq2ARHSwdjLE2VdX89sgYn9/3hH4JnTkWZX6TmkV2Anuyn9DSbF9FFxZUaLK0M5+HqIs2Gs6nTWDfUlgaVHkKb4ry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942624; c=relaxed/simple;
	bh=s4Gr27AQWXCCRf40+iSbOzNfA3IdLGT1V1JslAXKO+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eROEo2qqa1EKvQoVK0V9ViDOhv2M+7kBpIctDyyrcmJgjnGpRfaqR0DQoYh772JLX0cxKRNmDRBtRW1gJsZqUU7o5etTnmm/d7v9jOkxOjU8GHuJmvXESklp83x5T+l0O44R3rWAvLMp9j7+Q3+3QiIfqvyC9pxx80OnWeLrFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WdVtZ2kmVzpSxD;
	Tue,  6 Aug 2024 19:09:10 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id F373D140135;
	Tue,  6 Aug 2024 19:10:18 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 19:10:18 +0800
Message-ID: <8912aec0-d47d-3574-1e57-b03abb8c7171@huawei.com>
Date: Tue, 6 Aug 2024 19:10:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH] ARM: Support allocating crashkernel above 4G for LPAE
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Baoquan He
	<bhe@redhat.com>
CC: <akpm@linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240802092510.3915986-1-ruanjinjie@huawei.com>
 <Zqy8lwZM2Z6RlV5H@shell.armlinux.org.uk>
 <6c0a45c3-08a2-f889-9e66-ab8aff66ae8c@huawei.com>
 <ZrA/QWAy2iXl/Oc4@MiWiFi-R3L-srv>
 <8f051483-46be-87b6-03bb-5e0d145a2ac3@huawei.com>
 <ZrHasuAXM2Ph9V5p@MiWiFi-R3L-srv> <ZrHgH9hFADBJrtJ6@shell.armlinux.org.uk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZrHgH9hFADBJrtJ6@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/6 16:34, Russell King (Oracle) wrote:
> On Tue, Aug 06, 2024 at 04:11:30PM +0800, Baoquan He wrote:
>> I am fine with it. BUT have you addressed Russell's concern, e.g how to
>> test it actually?
> 
> Thanks for bringing that up.
> 
> Let me reinforce my position on this. I will _not_ be accepting a patch
> that allows the crash kernel to be placed into high memory on 32-bit
> ARM unless it has been thoroughly tested to prove that it can actually
> work.

Thank you! I'm looking for an available environment to test, otherwise,
the patch is invalid.

> 
> Right now, I don't believe it can work as placing the kernel in highmem
> likely means it will be located *outside* of the lower 4GiB of physical
> memory which is all that will be accessible when the MMU is turned off.
> This is a pre-condition to boot a kernel - the kernel image _must_ be
> located within a region of memory which is exposed to the CPU when the
> MMU is turned off.
> 
> Unless it can be proven that placing the kernel in highmem means that
> the kernel will be located in the lower 4GiB of physical memory space
> with the MMU off, then further work on this patch is a waste of time.
> 

