Return-Path: <linux-kernel+bounces-388322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F0D9B5DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A078528456B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50F71E0E10;
	Wed, 30 Oct 2024 08:33:20 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA71D3578
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277200; cv=none; b=cmcBIK+I6fw2ph8wEzR/ywqX2wfP49p+2r+7P2cn/whvsn2Vr314GLExRclH0mHS5DY4eCPJcjU6OCn09Opw4fDzlcMZjr+aCzp9iDPqBt2TQFmME/x65lu/ZJp+hAg6wF04NhLEFR/UatFxvNM2M3/GUHFyZW+t/MNjaesbaaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277200; c=relaxed/simple;
	bh=myL0utpVAO72zFsiTycJMmn0jtm0x0iN3CKoXmBhc+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSKCwfK9sDz6zFKXSxO6A7luyuvNX0OCrQO0sqE/HTXLNflT7JXqzzMdPQnUOs0J6d319gmwV08MWhihA+id4D5Mgcq5Lvv8nr2KFu+hQ+FOJ4AhIFKl/3TZALdYkIZoOnOEqjo3gE1NTCtQH5AMnHn+hCg6K+40pS8w/dnvDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B1302000A;
	Wed, 30 Oct 2024 08:33:08 +0000 (UTC)
Message-ID: <7b4228ab-a645-4cb0-8f05-000aa78f5f27@ghiti.fr>
Date: Wed, 30 Oct 2024 09:33:07 +0100
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
To: Andreas Schwab <schwab@suse.de>, linux-riscv@lists.infradead.org
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


Thanks for the patch!

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Alex


