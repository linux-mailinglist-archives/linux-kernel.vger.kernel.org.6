Return-Path: <linux-kernel+bounces-316529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7666396D0C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91631C24696
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ED1194083;
	Thu,  5 Sep 2024 07:50:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63949146A72
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522606; cv=none; b=ND61OQZGjCT7rAiuOZsunYCMDDoaAm+IX1aVXB+N1KPLPDE0AE9UUQPQ+dRE+b82EJzcGK6LszeeliH8sJjPoPomo8Qyobo5NmCyoEA1K34pto09vqIhfaJVheqhdxcFKiaszG6IGR+2XLX57HGfUD0dH5KX/R7F6DUSvgeovGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522606; c=relaxed/simple;
	bh=Fzf8xVtrkfaPBKItV/wh3P9Lo3hz+pHaaXCVV+rC1PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUqbetvFOT1q0nZhC7tMxxEpFV80wiyx8hr3fg73Zmk0iQBqM5MOne0VhoDTBMj8liUaxt3ZIjAYLKLteF45kRxb9zWqJLvZlWt72YSUHoWioM/wa5XPX1/GieYqIknIBek5ZT+HYLJgd5eU9udDqdcAyf9fAg6IGvgJPAaTANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wzrds6bn2z9sRs;
	Thu,  5 Sep 2024 09:31:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jRPEweHwrZMe; Thu,  5 Sep 2024 09:31:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wzrds5sNzz9sRr;
	Thu,  5 Sep 2024 09:31:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B93ED8B77C;
	Thu,  5 Sep 2024 09:31:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id kyGx2BmjE22I; Thu,  5 Sep 2024 09:31:45 +0200 (CEST)
Received: from [192.168.235.27] (unknown [192.168.235.27])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 580E78B778;
	Thu,  5 Sep 2024 09:31:45 +0200 (CEST)
Message-ID: <7091c023-c7e6-4b3a-b306-12d73b8f6698@csgroup.eu>
Date: Thu, 5 Sep 2024 09:31:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: fsl: qe: ucc: Export ucc_mux_set_grant_tsa_bkpt
To: Herve Codina <herve.codina@bootlin.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, kernel test robot <lkp@intel.com>
References: <20240905072215.337010-1-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240905072215.337010-1-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/09/2024 à 09:22, Herve Codina a écrit :
> When TSA is compiled as module the following error is reported:
>    "ucc_mux_set_grant_tsa_bkpt" [drivers/soc/fsl/qe/tsa.ko] undefined!
> 
> Indeed, the ucc_mux_set_grant_tsa_bkpt symbol is not exported.
> 
> Simply export ucc_mux_set_grant_tsa_bkpt.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409051409.fszn8rEo-lkp@intel.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Arnd, it is ok for you to take this patch directly ?

Thanks
Christophe

> ---
>   drivers/soc/fsl/qe/ucc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
> index 21dbcd787cd5..892aa5931d5b 100644
> --- a/drivers/soc/fsl/qe/ucc.c
> +++ b/drivers/soc/fsl/qe/ucc.c
> @@ -114,6 +114,7 @@ int ucc_mux_set_grant_tsa_bkpt(unsigned int ucc_num, int set, u32 mask)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL(ucc_mux_set_grant_tsa_bkpt);
>   
>   int ucc_set_qe_mux_rxtx(unsigned int ucc_num, enum qe_clock clock,
>   	enum comm_dir mode)

