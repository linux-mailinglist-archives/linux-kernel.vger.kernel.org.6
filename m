Return-Path: <linux-kernel+bounces-211384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1E49050EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755901F2327A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143F16EC0C;
	Wed, 12 Jun 2024 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X1XFR+hf"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2363616E888
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189751; cv=none; b=ftgmjUbZgJHWBUE9GglGLjcdo6LmJdANs8Z320MhujTOmo8m92YQqiY34l5FTm6CTAxgD7a5T/vWxrhgln3QdaZX7ZJ7tbkUMSoecKJ29Xj6s1xtJHgIv6o0xNb4zBoKaWidkH+htdzywr996ZYmyRPJWbU4JvOPcTEalo+W1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189751; c=relaxed/simple;
	bh=o2/azgVrwaPNaWmwIxK9yQ8UpjBGGyP25jHl/Y4SoR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GkieDtO9S6tos1YypeszjQ7iDEVwYe7Tj3VajPAIo+L09uVopBKektfOSqI057NvCnkRwkLLfAzaGWASBuJFYl7z8HDKWukFzTAOYi+Xo2kvyTVKt1HApG8AYJmw6Y8v92Chn/kr3XeikK6oBXOHhoOSSUmN1gQlv4ioripp6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X1XFR+hf; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CAth2I070962;
	Wed, 12 Jun 2024 05:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718189743;
	bh=XX/2FTvcpOE83ZKsu0t3uhvjEs4L4Hnx0LHgBYjOiNw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=X1XFR+hfZ+xF5nw38IFLJl4DdTCZbIStWr+7e/46heu8L3Pvv3VCSTVVcLD6kfKfq
	 dAUVwdlmDxgtrMFw6lQrK3jLgSMMXLMs3UY3XHjkAS43U1jphdLlzAgXeqtFVu+Laq
	 /kabihcCFBSsOcjfhvQUypUuerwRxIIv0cxpJwFo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CAthKg004773
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 05:55:43 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 05:55:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 05:55:42 -0500
Received: from [10.24.69.66] (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CAteSN090679;
	Wed, 12 Jun 2024 05:55:41 -0500
Message-ID: <ab50c7df-c2b9-4b34-9b81-dc89f76dd80a@ti.com>
Date: Wed, 12 Jun 2024 16:25:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: omap: Fix mailbox interrupt sharing
To: Andrew Davis <afd@ti.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        Hari
 Nagalla <hnagalla@ti.com>
CC: <linux-kernel@vger.kernel.org>
References: <20240611170456.136795-1-afd@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20240611170456.136795-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 11/06/24 22:34, Andrew Davis wrote:
> Multiple mailbox users can share one interrupt line. This flag was
> mistakenly dropped as part of the FIFO removal. Mark the IRQ as shared.
>
> Reported-by: Beleswar Padhi <b-padhi@ti.com>
> Fixes: 3f58c1f4206f ("mailbox: omap: Remove kernel FIFO message queuing")
> Signed-off-by: Andrew Davis <afd@ti.com>
Tested-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   drivers/mailbox/omap-mailbox.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
> index 46747559b438f..7a87424657a15 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -230,7 +230,8 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
>   	int ret = 0;
>   
>   	ret = request_threaded_irq(mbox->irq, NULL, mbox_interrupt,
> -				   IRQF_ONESHOT, mbox->name, mbox);
> +				   IRQF_SHARED | IRQF_ONESHOT, mbox->name,
> +				   mbox);
>   	if (unlikely(ret)) {
>   		pr_err("failed to register mailbox interrupt:%d\n", ret);
>   		return ret;

