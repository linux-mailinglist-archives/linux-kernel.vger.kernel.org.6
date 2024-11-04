Return-Path: <linux-kernel+bounces-394520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C996A9BB080
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767D71F22ECA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87F1A724C;
	Mon,  4 Nov 2024 10:02:21 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3118562F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714541; cv=none; b=EZ48WfFIsFSIHEjdFiPAjZ+d+I6Ug6PAKdHGZfza6YEFN6EyukQGT1zUgJzNUNI8z7qedbSTJ77O04cBaMv1TiMWy+19LnHdIn16EJfREnduDF6nnsqyrMcqifavoy8Sd0xvM0INpelnB0stmD7MKB5u49TNBUVmyaNe3Cl7y9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714541; c=relaxed/simple;
	bh=N1mGJFaWXzKaM6ddxg9ILytA8QDZtoo1cS8M+OzSibs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4Cs1L2FuXmVytU5hnch7iiF9ItLLObEDd4Gm1wOS+EB5Ksbmd0mspQeVNn2p2JxSKNrp4LZZghW8bw2gyC81m++MfXkgWFcLzWiRiVHHipVYqKt2wkcVaPuxSnompywfhRkAsn2r6uZ6xMOBxOn7lMPbER6VUWl+lJhumhGFa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0667C0008;
	Mon,  4 Nov 2024 10:02:14 +0000 (UTC)
Message-ID: <d380fd10-ebc4-4d66-becb-13995372d41a@ghiti.fr>
Date: Mon, 4 Nov 2024 11:02:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: add forwarding header for
 arch/riscv/include/asm/fence.h
Content-Language: en-US
To: Andreas Schwab <schwab@suse.de>, linux-riscv@lists.infradead.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrea Parri <parri.andrea@gmail.com>, linux-kernel@vger.kernel.org
References: <mvm5xq44bqh.fsf@suse.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <mvm5xq44bqh.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Andreas,

On 07/10/2024 09:24, Andreas Schwab wrote:
> This is needed so that <asm/barrier.h> can find <asm/fence.h> on riscv.
>
> Fixes: 6d74d178fe6e ("tools: Add riscv barrier implementation")
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   tools/include/asm/fence.h | 3 +++
>   1 file changed, 3 insertions(+)
>   create mode 100644 tools/include/asm/fence.h
>
> diff --git a/tools/include/asm/fence.h b/tools/include/asm/fence.h
> new file mode 100644
> index 000000000000..917a173059a4
> --- /dev/null
> +++ b/tools/include/asm/fence.h
> @@ -0,0 +1,3 @@
> +#if defined(__riscv)
> +#include "../../arch/riscv/include/asm/fence.h"
> +#endif


After a discussion with Bjorn, it appears that he had already solved 
this issue with the following patch: 
https://lore.kernel.org/linux-riscv/20240927131355.350918-1-bjorn@kernel.org/ 
which we find cleaner. I have just tested his, and it indeed fixes the 
build error.

Unless you have any objection, we'll try to make Bjorn's patch into 
6.12-rc7 instead of yours.

Thanks,

Alex


