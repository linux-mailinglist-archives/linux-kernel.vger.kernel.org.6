Return-Path: <linux-kernel+bounces-298460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0CC95C799
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0C91C24DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279F1465B8;
	Fri, 23 Aug 2024 08:10:51 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125E13D881;
	Fri, 23 Aug 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400650; cv=none; b=LcVoMKR9rC7neMB10qpHhvzSTi+mHSnJviSqfAd8AGWlNeNF4cgnCXQPxqSSge82QRddaffSiD5Tu+rj7Eukb+iylaxp7+nSoiiDVjYiKt0VNlN993CPgbs8y8447UQ0IzaPH1qYiP3MtJY6iafSucuY/l2XY8zgnIyv/yOhXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400650; c=relaxed/simple;
	bh=0goeapzwFX8/7EhrSSuKZ1rDlP1St7g2e3q26teIqhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfV4D7nKCMIGYJnLtXldlozxx6338G+rT3LZ0y6pfd5XW0ywi0rgs7Q/994WmU92Q6GSuCJHRUqs00ohkVoEV75a/QzRBV3CKThamk+rE26cynYV7z/PqDWpN4glnJeu7pC+UcSJKW115VM9+cZJmK+l6tY9mhLc5/wXkPQhOCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt6v4mwZz9sRr;
	Fri, 23 Aug 2024 10:10:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FS1D3af3fsRN; Fri, 23 Aug 2024 10:10:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt6v40cnz9rvV;
	Fri, 23 Aug 2024 10:10:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 771368B77D;
	Fri, 23 Aug 2024 10:10:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id TcN3HHoc2kt3; Fri, 23 Aug 2024 10:10:47 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E99D08B763;
	Fri, 23 Aug 2024 10:10:46 +0200 (CEST)
Message-ID: <447b75e4-6a25-4756-a37e-dbe46091ef76@csgroup.eu>
Date: Fri, 23 Aug 2024 10:10:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/36] soc: fsl: cpm1: qmc: Add missing spinlock
 comment
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-23-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-23-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> checkpatch.pl raises the following issue
>    CHECK: spinlock_t definition without comment
> 
> Add the missing comments.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 2d54d7400d2d..3736a8e4575e 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -196,7 +196,7 @@ struct qmc_chan {
>   	u64	rx_ts_mask;
>   	bool is_reverse_data;
>   
> -	spinlock_t	tx_lock;
> +	spinlock_t	tx_lock; /* Protect Tx related data */
>   	cbd_t __iomem *txbds;
>   	cbd_t __iomem *txbd_free;
>   	cbd_t __iomem *txbd_done;
> @@ -204,7 +204,7 @@ struct qmc_chan {
>   	u64	nb_tx_underrun;
>   	bool	is_tx_stopped;
>   
> -	spinlock_t	rx_lock;
> +	spinlock_t	rx_lock; /* Protect Rx related data */
>   	cbd_t __iomem *rxbds;
>   	cbd_t __iomem *rxbd_free;
>   	cbd_t __iomem *rxbd_done;

