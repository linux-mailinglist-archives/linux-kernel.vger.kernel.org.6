Return-Path: <linux-kernel+bounces-221449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E87090F3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4226E1C217F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6614F9C4;
	Wed, 19 Jun 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g2A6W5Y1"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4912146D53
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813623; cv=none; b=mGxHx8AeZfRCL7w/Xerua43XKQW1ONOlEdYDyJckZbuTzsOd3u+fh5AOAYDT5RgUgvAjt+v1LbSlWH3Sv31PQzcSuAHAtWhkOEf/KvlW1Ap/V3ZNgh5IHWV8/DZ/V5uQ3xjcYruiJ3yPxE4/SBKKMgewAIBqzgowLGh4CrwniuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813623; c=relaxed/simple;
	bh=ZuNheAGDS9lyLirqvsvZEcE8a0E6ASuPQtJZ3l+RY/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OpoyItQmYBs9EH7tVRxtid0Gc8w7x+S8Ly1uieKTVFid5sT/xHkeBKFGhHGSN0OpKMa4EoJ5IwO9SQEcoFxE1RbV0wUEGsgQjoUX78s7L739ciAz3gx85nrBKv6INX224l7JFTv8O3pP1Auf578Q2Gs8Ut8uqgjNbcOrhPK73iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g2A6W5Y1; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45JGDYSb037980;
	Wed, 19 Jun 2024 11:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718813614;
	bh=LdYSf4TpjDJaCD9ffg7q90Gif9wyFLmDS+w2UmWNTQY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=g2A6W5Y1hOF+mhmZgCc4WBmZpSavTXtNZwgkGAswPTHnuuDgWdUzhWAG4jN71Popx
	 5tXGJn+IR1PPcCGWOzKKr3ktldlQsae4x+FNnnJ+2BR0rUTnN9tzGYo1u9nzarZtHW
	 oq+L1JOQefOz6k6FKWeQe6mlai0DVGTj6tjCr1DY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45JGDXeQ004395
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Jun 2024 11:13:34 -0500
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 11:13:33 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Wed, 19 Jun
 2024 11:13:33 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 11:13:33 -0500
Received: from [128.247.81.8] (ula0226330.dhcp.ti.com [128.247.81.8] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45JGDWSp056013;
	Wed, 19 Jun 2024 11:13:33 -0500
Message-ID: <ea70aba9-3d20-4571-8f22-417bcf54929d@ti.com>
Date: Wed, 19 Jun 2024 11:13:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: omap: request shared interrupt to fix
 initialization
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jassi Brar
	<jassisinghbrar@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux@ew.tq-group.com>
References: <20240619115258.108557-1-matthias.schiffer@ew.tq-group.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240619115258.108557-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/19/24 6:52 AM, Matthias Schiffer wrote:
> The TI AM64x and similar SoC families have mailboxes with two channels
> each which share the same IRQ. The IRQ must thus be requested with
> IRQF_SHARED, or initializing the second channel will fail.
> 
> Fixes: 3f58c1f4206f ("mailbox: omap: Remove kernel FIFO message queuing")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---

Looks like we found the same issue, already sent the same fix last week:

https://www.spinics.net/lists/kernel/msg5247681.html

>   drivers/mailbox/omap-mailbox.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
> index 46747559b438f..03187c65f98bf 100644
> --- a/drivers/mailbox/omap-mailbox.c
> +++ b/drivers/mailbox/omap-mailbox.c
> @@ -230,7 +230,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
>   	int ret = 0;
>   
>   	ret = request_threaded_irq(mbox->irq, NULL, mbox_interrupt,
> -				   IRQF_ONESHOT, mbox->name, mbox);
> +				   IRQF_ONESHOT | IRQF_SHARED, mbox->name, mbox);
>   	if (unlikely(ret)) {
>   		pr_err("failed to register mailbox interrupt:%d\n", ret);
>   		return ret;

