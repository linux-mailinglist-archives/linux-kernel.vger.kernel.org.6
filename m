Return-Path: <linux-kernel+bounces-239186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A87D9257C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF2B2898D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37F6143C6E;
	Wed,  3 Jul 2024 10:05:07 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1813541F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001107; cv=none; b=S1p3fisJl8Qrar09l9MEIrsbxPheHqgSt5RvN4d/gYwm+dgd/BSQg7ETiBmXKPqiF3DuUx4q7mw+FdVvxAfsEO/Ft1oTpeEDJ8IDhCGwULexsBqy6CTrTvtjPFmSdkcRwzaAfgp9YdCvCdQ+bTE/XatOqGmGXkKqZh450xk7z4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001107; c=relaxed/simple;
	bh=AF3U5GlPA9mCmhHGZtzE2qfu99EgTzFHSx8J233fTpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NliM3DF0NbGdfZFsGE9ll4qCANtRg6wz/Sx6Q0/wwVHcdTnE59HICUdJqPCYic2d+x5kQs4VPjOW2TCT0b2HkNTdwBNunMjRYuDj6IU+KvW49yuMncgFRoK5er/XOzBzsqRM8rcxLbGgtdmF36M2KcZQT/UchEzCi2j4X/wpST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpsz5t1720001040tepgz58
X-QQ-Originating-IP: JVJParCQJX31txIFihbcR4urx36FbLnqLbvHyv5bb5A=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Jul 2024 18:03:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11011914129124645858
Message-ID: <A929246EF5D140F2+6a40266f-73c2-4ec3-9667-3503ed1ff3a8@uniontech.com>
Date: Wed, 3 Jul 2024 18:03:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND. PATCH] nvme/pci: Add APST quirk for Lenovo N60z laptop
To: Keith Busch <kbusch@kernel.org>
Cc: guanwentao@uniontech.com, huanglin@uniontech.com, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <AFD9EEAB191702D0+20240622042108.10427-1-wangyuli@uniontech.com>
 <Znnp6jIfcNYoDb2m@kbusch-mbp.dhcp.thefacebook.com>
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
In-Reply-To: <Znnp6jIfcNYoDb2m@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1


On 2024/6/25 05:49, Keith Busch wrote:
> Based on your commit message, it sounds like the platform works the
> majority of the time. Is it possible that NVME_QUIRK_NO_DEEPEST_PS is
> sufficient for this? Or do you really need to disable it entirely? The
> power usage differences can be meaningful.
>
> Also, 30 minutes of idle is an eternity for APST to kick in, so I'm
> curious if there's something else going on here or if the breakage
> occurs earlier than that.
>
When we "quiesce" a machine, some applications may not stop disk I/O 
promptly,
so the 30 minutes include the time to wait for these background 
processes to quiet down.

Thanks for the reminder. I've tested it and 'NVME_QUIRK_NO_DEEPEST_PS' 
is effective and
more appropriate than 'NVME_QUIRK_NO_APST'. I'll send a patch v2 to 
update my code.

-- 
WangYuli <wangyuli@uniontech.com>


