Return-Path: <linux-kernel+bounces-279120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BCE94B92D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1811F2177F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACEF1898EC;
	Thu,  8 Aug 2024 08:41:18 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275A18950C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106478; cv=none; b=bBm/cmD+PnAkM8YedZe7dq14RborLgF8OhA656k2YSSwhCg/5TZSVXE0zjYS+PZzSPgQNLbBmizRc7Ka8vnKFHaVKjicUO7grWfdWrWheJurjnv3pVZCi4+zhbs9qZYE0ZmWpjjw/qI13Tx8XtOsfGDk55AvDKhXQj+wMLzZ1lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106478; c=relaxed/simple;
	bh=9qLflyGwzLp66uwiZk1qW99YTxLLQLLfjJEFAumgnUk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOL1UCRDEBAfQzoI+aEQ7mIe0DVUq3OTck45AP+GgFeEqAszQeEzaOvgciDtn1uHtmKZOpMmifrm7zEosJPN878v2WgWqbQPxpsgjdqAklT0dwbcQHV+881czgER+MGVdjPAd2ODkkBQPp/huNLDXQxWsUjOfZEcwd46bbM3fw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WfgSD1W5Fz6K9g4;
	Thu,  8 Aug 2024 16:38:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A21B1400C9;
	Thu,  8 Aug 2024 16:41:13 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 8 Aug
 2024 09:41:11 +0100
Date: Thu, 8 Aug 2024 09:41:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gavin Shan <gshan@redhat.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>, <salil.mehta@huawei.com>,
	<shan.gavin@gmail.com>
Subject: Re: [PATCH] cpumask: Fix crash on updating CPU enabled mask
Message-ID: <20240808094108.00004b97@Huawei.com>
In-Reply-To: <20240808040808.647316-1-gshan@redhat.com>
References: <20240808040808.647316-1-gshan@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  8 Aug 2024 14:08:08 +1000
Gavin Shan <gshan@redhat.com> wrote:

> The CPU enabled mask instead of the CPU possible mask should be used
> by set_cpu_enabled(). Otherwise, we run into crash due to write to
> the read-only CPU possible mask when vCPU is hot added on ARM64.
> 
>   (qemu) device_add host-arm-cpu,id=cpu1,socket-id=1
>   Unable to handle kernel write to read-only memory at virtual address ffff800080fa7190
>     :
>   Call trace:
>     register_cpu+0x1a4/0x2e8
>     arch_register_cpu+0x84/0xd8
>     acpi_processor_add+0x480/0x5b0
>     acpi_bus_attach+0x1c4/0x300
>     acpi_dev_for_one_check+0x3c/0x50
>     device_for_each_child+0x68/0xc8
>     acpi_dev_for_each_child+0x48/0x80
>     acpi_bus_attach+0x84/0x300
>     acpi_bus_scan+0x74/0x220
>     acpi_scan_rescan_bus+0x54/0x88
>     acpi_device_hotplug+0x208/0x478
>     acpi_hotplug_work_fn+0x2c/0x50
>     process_one_work+0x15c/0x3c0
>     worker_thread+0x2ec/0x400
>     kthread+0x120/0x130
>     ret_from_fork+0x10/0x20
> 
> Fix it by passing the CPU enabled mask instead of the CPU possible
> mask to set_cpu_enabled().
> 
> Fixes: 51c4767503d5 ("Merge tag 'bitmap-6.11-rc1' of https://github.com:/norov/linux")
> Signed-off-by: Gavin Shan <gshan@redhat.com>
Thanks Gavin!

We'd flagged the merge conflict but thought we'd chase it with a patch adding
set_cpu_enabled() as you have it fixed below.

I completely missed that Linus took a different path whilst resolving the conflict
to https://lore.kernel.org/all/20240701175051.0ef5d901@canb.auug.org.au/
which was what Stephen did for linux-next (which would have needed a follow up to
use the new infrastructure.

Anyhow, all's well that ends well.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/linux/cpumask.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 801a7e524113..53158de44b83 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -1037,7 +1037,7 @@ void init_cpu_online(const struct cpumask *src);
>  	assign_bit(cpumask_check(cpu), cpumask_bits(mask), (val))
>  
>  #define set_cpu_possible(cpu, possible)	assign_cpu((cpu), &__cpu_possible_mask, (possible))
> -#define set_cpu_enabled(cpu, enabled)	assign_cpu((cpu), &__cpu_possible_mask, (enabled))
> +#define set_cpu_enabled(cpu, enabled)	assign_cpu((cpu), &__cpu_enabled_mask, (enabled))
>  #define set_cpu_present(cpu, present)	assign_cpu((cpu), &__cpu_present_mask, (present))
>  #define set_cpu_active(cpu, active)	assign_cpu((cpu), &__cpu_active_mask, (active))
>  #define set_cpu_dying(cpu, dying)	assign_cpu((cpu), &__cpu_dying_mask, (dying))


