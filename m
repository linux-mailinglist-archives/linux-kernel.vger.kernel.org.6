Return-Path: <linux-kernel+bounces-423604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A699DAA39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768FB166F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4E1FF7AA;
	Wed, 27 Nov 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hLJ2JAhk"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596EB652
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719546; cv=none; b=C/JlxW1ABo4OV2z9vgDWgq94qyI95NA5zEJ/T4MxNU0EGTYYbFVbxwyAPk+CGwn3wL+fAl6NkN/N+zC3w0LBGRpXq3zT4MYRWkX+gyQu4R7G/9zITjfghZDMKE2++woveXy5YDel+L80zKy6lagkyoarrNxKMnqTmw9Z1i4ps/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719546; c=relaxed/simple;
	bh=d1Yf7lV6LprirBnM5DZ+am7RY70xRgwA7d7ed1VUkPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aBuioO2PrYlhg2uoBdRRfK0HTDRPvB3bacPVU0nabuR4fV7kwTSw9o9Sz/A2r+dbd8rXR1U6hewZWF+Q/obEGL/Wm1aO/JjWG+ads2MQKXLrDGmR9IblCHcyrHvoR3qQ2B5J2FLDAfSwkNHHk3R25qtBe2kfR61S5ciE42ug7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hLJ2JAhk; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732719545; x=1764255545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2DX3H+a44kQ13gTw3hzeF4XJrHuDL47mesPKbbKCQO8=;
  b=hLJ2JAhkO/bmjdspnI9UvmIE+h7OVIThix4mIqVvHnQyofOA8OidBQxF
   /V4qLQ6fR+Hj4eaorA0+6/SUs0KvLOwIBC17CHUcWfrHkzu5I37sVOTpC
   9L/k8LEuyj0l0NiHFzH/94d3yNey8zSQNiIyR6xhMczJw+gDhRSSmwKAQ
   0=;
X-IronPort-AV: E=Sophos;i="6.12,189,1728950400"; 
   d="scan'208";a="677169741"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 14:59:02 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:60970]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.13:2525] with esmtp (Farcaster)
 id e0021fdb-2735-4534-9e9c-863282448e48; Wed, 27 Nov 2024 14:59:01 +0000 (UTC)
X-Farcaster-Flow-ID: e0021fdb-2735-4534-9e9c-863282448e48
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 27 Nov 2024 14:59:01 +0000
Received: from [192.168.90.101] (10.85.143.173) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 27 Nov 2024 14:58:57 +0000
Message-ID: <7846b08f-5bdb-448b-9c56-73d9f16a839b@amazon.com>
Date: Wed, 27 Nov 2024 16:58:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: kexec: Check if IRQ is already masked before
 masking
To: Marc Zyngier <maz@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <akpm@linux-foundation.org>,
	<bhe@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <jonnyc@amazon.com>
References: <20241126050509.4426-1-farbere@amazon.com>
 <86cyihvopl.wl-maz@kernel.org>
Content-Language: en-US
From: "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <86cyihvopl.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

> Maybe a slightly better approach would be to simplify this code for
> something that actually uses the kernel infrastructure:
>
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 82e2203d86a31..9b48d952df3ec 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -230,11 +230,8 @@ static void machine_kexec_mask_interrupts(void)
>                      chip->irq_eoi)
>                          chip->irq_eoi(&desc->irq_data);
>
> -               if (chip->irq_mask)
> -                       chip->irq_mask(&desc->irq_data);
> -
> -               if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
> -                       chip->irq_disable(&desc->irq_data);
> +               irq_set_status_flags(i, IRQ_DISABLE_UNLAZY);
> +               irq_disable(desc);
>          }
>   }
>
> This is of course untested.

I tested your suggested approach and it works.
I will upload V2 for this change.

Thanks, Eliav


