Return-Path: <linux-kernel+bounces-298435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136AA95C749
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3010285602
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C49C13DDC3;
	Fri, 23 Aug 2024 08:05:10 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9E524D7;
	Fri, 23 Aug 2024 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400310; cv=none; b=ELXmYBhj9i4+SY9hg0WKE/+4USODQeyF+Kr1XfMn46A2bQ5zoDwnU6YPTSjCgQkAbabz19PgFP2FsxzZkXRrAR3vqQkWkUkWRcIhZHunh7pzzcu/H6Pus+9QDCny2NDfyZg0WfCRVqsY1n6qb4PkLccby4UPGxKe1JvG/P1cQN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400310; c=relaxed/simple;
	bh=lbPhxS6FtKtpTOe+E8oXTspxWHPLnza11DbC91kjNg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8a+2gahO+6xtlo1nLoS6xgM1uC+STelTt6l3gq0uW4t6c5ey798p9W4B8+oeagNESfxXjIBNeRdTKFJR92U8MAl2F5JtpkWGHgI215W/k4F3pb8sq/0OT27rIHmFaPpwX7oBn/BtK/pzM3JPvo+o6wR3yZnymMsntBz2+Uvn8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt0L4gxRz9sRr;
	Fri, 23 Aug 2024 10:05:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCvNb3mogfdq; Fri, 23 Aug 2024 10:05:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt0L3v7sz9rvV;
	Fri, 23 Aug 2024 10:05:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E9858B77D;
	Fri, 23 Aug 2024 10:05:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Wg2k2ytsMXth; Fri, 23 Aug 2024 10:05:06 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CC8368B763;
	Fri, 23 Aug 2024 10:05:05 +0200 (CEST)
Message-ID: <716df5e4-72b5-42c0-912d-ae31d687cfad@csgroup.eu>
Date: Fri, 23 Aug 2024 10:05:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/36] soc: fsl: cpm1: tsa: Add missing spinlock
 comment
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-7-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-7-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:10, Herve Codina a écrit :
> checkpatch.pl raises the following issue
>    CHECK: spinlock_t definition without comment
> 
> Add the missing comment.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   drivers/soc/fsl/qe/tsa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
> index 7b1032fb1572..a9d35b44489d 100644
> --- a/drivers/soc/fsl/qe/tsa.c
> +++ b/drivers/soc/fsl/qe/tsa.c
> @@ -128,7 +128,7 @@ struct tsa {
>   	void __iomem *si_regs;
>   	void __iomem *si_ram;
>   	resource_size_t si_ram_sz;
> -	spinlock_t	lock;
> +	spinlock_t	lock; /* Lock for read/modify/write sequence */
>   	int tdms; /* TSA_TDMx ORed */
>   	struct tsa_tdm tdm[2]; /* TDMa and TDMb */
>   	struct tsa_serial {

