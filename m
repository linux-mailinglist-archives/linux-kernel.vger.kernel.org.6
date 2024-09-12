Return-Path: <linux-kernel+bounces-326330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9D99766A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E05B23E96
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACAB19F414;
	Thu, 12 Sep 2024 10:23:34 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DDA187552
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136613; cv=none; b=TzzB3eRF+cgoYrteV141J4FlTMJzzkL7wnzhkmm9sYGP4mJG63ZdBjiTtirOW3KXKSqfsbTdxzoev2xLfQrd9mdtDyRBBZNpj60sxXKCc/cxKnGvkFZAZQUdu55iYNiM8Xr2n7r2wmH6rBkm0I6oi70F16kfnhJuNr70P/p7Q88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136613; c=relaxed/simple;
	bh=DSeEp76wd3zElFejXlz9c3H/nHp6FwzSdyAIYi8XzFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pf3aVpDQ/QxpQmgpOF1pMsOgRt5an1fUdnN+aIUlblUz6FDj8etf/8fwxVJ9Cd1e1NWd5TEj9hy1EsmV4TED0IinuzFlH4i+Ncph/yUygDaee6sAnp5fpCj+lDQp9BIuOMOet9xBaxr9rkDPwItFrPnEk+VbC8VKkgi8jZG51BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X4D6n6zNsz9sxD;
	Thu, 12 Sep 2024 12:23:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VmIkdEF43PU9; Thu, 12 Sep 2024 12:23:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X4D6n61zsz9sxC;
	Thu, 12 Sep 2024 12:23:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B7BE88B776;
	Thu, 12 Sep 2024 12:23:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id v96SPtwGdzRW; Thu, 12 Sep 2024 12:23:29 +0200 (CEST)
Received: from [192.168.233.25] (unknown [192.168.233.25])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 576418B766;
	Thu, 12 Sep 2024 12:23:29 +0200 (CEST)
Message-ID: <fc509bcd-5ca0-4dc2-962e-766a01cbe4fb@csgroup.eu>
Date: Thu, 12 Sep 2024 12:23:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/entry: convert to common and generic entry
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 jialong.yang@shingroup.cn, luming.yu@gmail.com
References: <B4ABABEA5F13B86A+20240912082500.1469-1-luming.yu@shingroup.cn>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <B4ABABEA5F13B86A+20240912082500.1469-1-luming.yu@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/09/2024 à 10:24, Luming Yu a écrit :
> From: Yu Luming <luming.yu@gmail.com>
> 
> convert powerpc entry code in syscall and fault to use syscall_work
> and irqentry_state as well as common calls from generic entry infrastructure.
> 
> Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> ---
>   arch/powerpc/Kconfig                   | 1 +
>   arch/powerpc/include/asm/hw_irq.h      | 5 +++++
>   arch/powerpc/include/asm/processor.h   | 6 ++++++
>   arch/powerpc/include/asm/syscall.h     | 5 +++++
>   arch/powerpc/include/asm/thread_info.h | 1 +
>   arch/powerpc/kernel/syscall.c          | 6 +++++-
>   arch/powerpc/mm/fault.c                | 5 +++++
>   7 files changed, 28 insertions(+), 1 deletion(-)

There is another build problem:

   CC      kernel/entry/common.o
kernel/entry/common.c: In function 'irqentry_exit':
kernel/entry/common.c:335:21: error: implicit declaration of function 
'regs_irqs_disabled'; did you mean 'raw_irqs_disabled'? 
[-Werror=implicit-function-declaration]
   335 |         } else if (!regs_irqs_disabled(regs)) {
       |                     ^~~~~~~~~~~~~~~~~~
       |                     raw_irqs_disabled


You have put regs_irqs_disabled() in a section dedicated to PPC64, so it 
fails on PPC32.


After fixing this problem and providing an empty asm/entry-common.h it 
is now possible to build the kernel. But that's not enough, the board is 
stuck after:

...
[    2.871391] Freeing unused kernel image (initmem) memory: 1228K
[    2.877990] Run /init as init process


Christophe

