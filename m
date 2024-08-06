Return-Path: <linux-kernel+bounces-276339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2C0949242
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF272837F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672F520011D;
	Tue,  6 Aug 2024 13:53:35 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1A20010D;
	Tue,  6 Aug 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952415; cv=none; b=QYdaxWTkOzE1SX7y0MWmzlF/S63N7MZ0QKXKZVzJbf8UcQZLWyPPdChkK4i2jEi33efPu8fzDnPDkowtlIY+Mmmtw0w8xui59ErKIK6DBHljgkbcn4c9f3FQ8moO6A8QaL6r/UT8JDvGqFiawfoj8qULnicoDqf4ns3sn1LxBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952415; c=relaxed/simple;
	bh=QqZfmolHSCLONq31MalmbYHiA1YumlPvGFXqfsFCezA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m7yidJOWUTNg/LknE+gVxyMOD8RHDhOea/koUSbwBq/iJANA6D4OjgJWo4ZL2wJCKb377PGpjdYi3+l6YYrBv7qNz3T+iaiXTrCl+QAPnC2EvP4FdvV/JV1zjJ2wTgzbglERuMnUWUfLa+xmMI7OWx/ldHcQLcGFwI8HcMhsVYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WdZWm47JZz1LB3h;
	Tue,  6 Aug 2024 21:53:08 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (unknown [7.185.36.84])
	by mail.maildlp.com (Postfix) with ESMTPS id EA678180AE6;
	Tue,  6 Aug 2024 21:53:27 +0800 (CST)
Received: from [10.174.179.13] (10.174.179.13) by
 dggpeml500011.china.huawei.com (7.185.36.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 21:53:27 +0800
Message-ID: <d36feb2f-c1f2-90c2-bb33-e6d0ff41096d@huawei.com>
Date: Tue, 6 Aug 2024 21:53:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: CVE-2024-42226: usb: xhci: prevent potential failure in
 handle_tx_event() for Transfer events without TRB
To: "Neronin, Niklas" <niklas.neronin@linux.intel.com>
CC: <cve@kernel.org>, <gregkh@linuxfoundation.org>,
	<linux-cve-announce@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mathias
 Nyman <mathias.nyman@linux.intel.com>
References: <d5691b1b-c7e6-ddea-bd58-10855fd36d40@huawei.com>
 <9409f3d3-02d1-1e31-a6da-056b44a9523f@huawei.com>
 <010cb430-b0bd-40f9-897e-b48e326a9caa@linux.intel.com>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <010cb430-b0bd-40f9-897e-b48e326a9caa@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500011.china.huawei.com (7.185.36.84)


在 2024/8/6 19:15, Neronin, Niklas 写道:
> On 06/08/2024 12.25, Jinjiang Tu wrote:
>> Hi, Niklas
>>
>> The commit 66cb618bf0bb ("usb: xhci: prevent potential failure in handle_tx_event() for Transfer events without TRB")
>> has been assigned with CVE-2024-42226, but the commit has been reverted in 6.1.99 and 6.6.39 due to
>> performance regression. Do you have a plan to address this issue, or if this CVE should be rejected?
>>
>> Thanks!
>>
> Hi,
>
> Currently, I have no plan to address this issue.
>
> The commit in question, was not intended for any previous Linux versions.
> It was created as part of my handle_tx_event() rework series. Future changes
> in said series could potentially trigger the issue, so preemptively preventing
> it was both simpler and more secure.
I don't know if I'm understanding this right, do you mean the issue 
mentioned in
the commit will not be actually triggered in previous Linux versions? 
Now the commit
is reverted in v6.1 and v6.6, but the issue can not be triggered in 
these versions,
so no more fixes patch is needed for these LTS versions?

Thanks！

>
> Thanks,
> Niklas
>

