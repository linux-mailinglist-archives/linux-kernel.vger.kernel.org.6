Return-Path: <linux-kernel+bounces-309763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DFD96702C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84FE1C21957
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246D516F0F0;
	Sat, 31 Aug 2024 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WQbeHUXs"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69971E52D
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725090077; cv=none; b=W4aaWMtXF8xj5WAkCPrQbxWbrjl5dYhI0ABUktotmuh7YKJrYcVj3EtbYIGFBqOOcS4EUrHpw+dP69oikg1VuvvYsrgHwmN479qkRwKHtC6ckj7Qgo+7qnT9PYJRpTGsREOIL6eqKteTO1NzBvsc9TbRXKtoq4rgFVuS6BOkWOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725090077; c=relaxed/simple;
	bh=u2TLDIVYn/ltoYIw/AoXlW3X+ya46JQbBlhZ5/T2BQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8IIgMiiJCmqGd2l8rBD+1lwEMteQc/YhGJ6mJgzBsqDD9W677+NhtrX27AbpJhTUbS77sQx13GiXfTdKgK6PNeC+opqiA/7LZeubNEUgrQyuJnjrRJm6H0eV6hXfn2UwhoaACQkHg6D3tzssHfht9Sg79Gyy06g3bYNhReS3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WQbeHUXs; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725090038;
	bh=titFpAFRFG6lSC5TNWm3vO0HJx8nVGVx12kXcfKUHUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=WQbeHUXsVf1bbvgaEgD11OikP8iUeU/Nv8XLeDWAGa/R9cQvFuLvWjwGdSQdPOyZv
	 9J0YC0+4tO17R/WrI04Ct1vymGG2gB8jPMr0fIzHxaTeAk1ziksizIf2xfCimA7Q7I
	 FLmMJLk9kxr4OYv5YUsfN0SqSP8VQw8936GoR5vI=
X-QQ-mid: bizesmtpsz13t1725090023t31myz
X-QQ-Originating-IP: sNcB1n3vxgVmHjLmLNF0NJUB/d2IZqPIuDFnWQbqixE=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 31 Aug 2024 15:40:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15338145670686491411
Message-ID: <95E05902A7743E7B+99bf08fd-c057-41a9-9250-d05e1e89d92f@uniontech.com>
Date: Sat, 31 Aug 2024 15:40:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Loongarch64: pci: fix memleak in pci_acpi_scan_root
To: Huacai Chen <chenhuacai@kernel.org>,
 Wentao Guan <guanwentao@uniontech.com>
Cc: henhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240831052157.13532-1-guanwentao@uniontech.com>
 <CAAhV-H7GptUdpKScV1AuZZm7w-F5oUXHRmaT9BFCZV4HuQExJg@mail.gmail.com>
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <CAAhV-H7GptUdpKScV1AuZZm7w-F5oUXHRmaT9BFCZV4HuQExJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1


On 2024/8/31 15:18, Huacai Chen wrote:
> Hi, Wentao,
>
> On Sat, Aug 31, 2024 at 1:24 PM Wentao Guan <guanwentao@uniontech.com> wrote:
>> Add kfree(root_ops) in this case to avoid memleak root_ops,
>> leaks when pci_find_bus() != 0.
>> Also delay assign root_ops when used for making code read clean.
>> Found by code review
>>
>> Signed-off-by: Wangyuli <wangyuli@uniontech.com>
> This should be Yuli Wang <wangyuli@uniontech.com>

While I maintain a preference for the traditional Chinese naming order, 
not particularly like putting my Chinese name in the English surname order,

I acknowledge that flexibility in this matter is often necessary.

It is sufficient for everybody to be aware that both 'WangYuli' and 
'Yuli Wang' refer to me.

>> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
>> ---
>>   arch/loongarch/pci/acpi.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
>> index 3eb61b8cd5e3..7f3539f5fa23 100644
>> --- a/arch/loongarch/pci/acpi.c
>> +++ b/arch/loongarch/pci/acpi.c
>> @@ -219,17 +219,18 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>>                  return NULL;
>>          }
>>
>> -       root_ops->release_info = acpi_release_root_info;
>> -       root_ops->prepare_resources = acpi_prepare_root_resources;
>> -       root_ops->pci_ops = (struct pci_ops *)&info->cfg->ops->pci_ops;
>> -
>>          bus = pci_find_bus(domain, busnum);
>>          if (bus) {
>>                  memcpy(bus->sysdata, info->cfg, sizeof(struct pci_config_window));
>>                  kfree(info);
>> +               kfree(root_ops);
> Add kfree() is fine, but move root_ops assignment is unnecessary.
>
> Huacai
>
>>          } else {
>>                  struct pci_bus *child;
>>
>> +               root_ops->release_info = acpi_release_root_info;
>> +               root_ops->prepare_resources = acpi_prepare_root_resources;
>> +               root_ops->pci_ops = (struct pci_ops *)&info->cfg->ops->pci_ops;
>> +
>>                  bus = acpi_pci_root_create(root, root_ops,
>>                                             &info->common, info->cfg);
>>                  if (!bus) {
>> --
>> 2.20.1
>>
>>
-- 
WangYuli


