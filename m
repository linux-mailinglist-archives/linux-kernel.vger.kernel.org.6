Return-Path: <linux-kernel+bounces-415635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2940A9D3939
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D66B258F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D3319F46D;
	Wed, 20 Nov 2024 11:05:39 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36E319F43B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100738; cv=none; b=j9vxpkUhIOuqqfjuvE6sUyU/94ynFoCa9KTIwUi2Xo2pwzL24sVPShVgLJb+OI9IHGpvOsJT9QgsEZ0jrb7FbEcmHzcPZ1svliqnakEifu0/xeG2C5UT4WFlwc3tiTAeym9a2VhN1nHTH3F6uyTQKiIFl27h+iAKc5Pl5lN4DQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100738; c=relaxed/simple;
	bh=q6Tmhl7CgPU0ajuGBrCqGjDwKVCukwwlIJ3PTfFAY+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KF/NyNjiNWmA/SEPCACDvSHpsRokwICD7j203yLU3pSIyOx6sEGmT21ClkPXOpQhWw4h/VGlyrKlpfPG0CEpzMBGF2JFv9D+RaS3U+4uJcI13e5Klc/k4fIlE1vyCbw9Gv5g15TOfgWGjXbG2qW5W2vSTCZKpXmoGv6ailhgAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XtdnN4b0wz9sRk;
	Wed, 20 Nov 2024 12:05:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KRl99YdAGIa3; Wed, 20 Nov 2024 12:05:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XtdnN3rRQz9sPd;
	Wed, 20 Nov 2024 12:05:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7680A8B7B7;
	Wed, 20 Nov 2024 12:05:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id s3GXbmcGUpO4; Wed, 20 Nov 2024 12:05:28 +0100 (CET)
Received: from [192.168.232.160] (PO19116.IDSI0.si.c-s.fr [192.168.232.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 28FF18B798;
	Wed, 20 Nov 2024 12:05:28 +0100 (CET)
Message-ID: <83d92bcb-b025-4595-8d77-0c5546b84518@csgroup.eu>
Date: Wed, 20 Nov 2024 12:05:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: fsl: cpm1: qmc: Fix qmc_probe() warn missing error
 code ret
To: Pei Xiao <xiaopei01@kylinos.cn>, herve.codina@bootlin.com,
 qiang.zhao@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, xiaopeitux@foxmail.com
References: <bac2dc94-1bf3-4dcf-b776-cd78ef992d28@suswa.mountain>
 <82d8c18da160b9e0a73c5c5e2eb25ad2831cc6f9.1732095360.git.xiaopei01@kylinos.cn>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <82d8c18da160b9e0a73c5c5e2eb25ad2831cc6f9.1732095360.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 20/11/2024 à 10:38, Pei Xiao a écrit :
> [Vous ne recevez pas souvent de courriers de xiaopei01@kylinos.cn. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> platform_get_irq() may failed,but ret still equals to 0,
> will cacuse qmc_probe() return 0 but fail.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202411051350.KNy6ZIWA-lkp@intel.com/
> Fixes: 3178d58e0b97 ("soc: fsl: cpm1: Add support for QMC")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>   drivers/soc/fsl/qe/qmc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 19cc581b06d0..a78768cd6007 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -2004,8 +2004,10 @@ static int qmc_probe(struct platform_device *pdev)
> 
>          /* Set the irq handler */
>          irq = platform_get_irq(pdev, 0);
> -       if (irq < 0)
> +       if (irq < 0) {
> +               ret = -EINVAL;

Why force -EINVAL ?

What if platform_get_irq() returns -EPROBE_DEFER ?

Anyway, this problem is already fixed by 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20241105145623.401528-1-herve.codina@bootlin.com/ 
which is on its way to mainline.

>                  goto err_exit_xcc;
> +       }
>          ret = devm_request_irq(qmc->dev, irq, qmc_irq_handler, 0, "qmc", qmc);
>          if (ret < 0)
>                  goto err_exit_xcc;
> --
> 2.34.1
> 

