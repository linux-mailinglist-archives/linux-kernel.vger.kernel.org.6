Return-Path: <linux-kernel+bounces-298473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1166195C7C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1962288A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE6F143889;
	Fri, 23 Aug 2024 08:14:20 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E6E13959D;
	Fri, 23 Aug 2024 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400860; cv=none; b=cWYGGKuY89TGdM8BT3c/whLVA96lCuIfY2dTuVfOflKjsfdhd8UJsNYfCchteFdaMOZRJP6L0A0v3V9QR6BfRJekvazgRmpa7FszSMCacbVN4w8/VpmteZ4fjZSxC1bEhSxzvSWsCl0VK8WrOP11fylO00e/Dy8wWyHRnGnDB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400860; c=relaxed/simple;
	bh=U2/lywYvBAM5Y+1GYFP0EuAbo7PstK3Lzd3ePRDf6/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTZV/tVCxGr4cDv/7ofhWvsD+Y8QAuLVGzgrSINFlCVrlq5NHJiuhxuq3WKA/omBv/m4enwGKXB3Ia2eImktpTKIgLAharaGtz7H5bFUgwdh4++hdA+6gy937bWbs6gvCi5Me0eQOTVr5MLYB52isvvXAGUqOQ5oMk0mXkhhYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqtBx1cqPz9sRr;
	Fri, 23 Aug 2024 10:14:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fcAlrhSmdtDo; Fri, 23 Aug 2024 10:14:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqtBx0rp4z9rvV;
	Fri, 23 Aug 2024 10:14:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B04B8B77D;
	Fri, 23 Aug 2024 10:14:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id V25q8XIA9PCy; Fri, 23 Aug 2024 10:14:16 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8036E8B763;
	Fri, 23 Aug 2024 10:14:16 +0200 (CEST)
Message-ID: <a79ef3a8-8754-4b74-9336-a06a17ac88a7@csgroup.eu>
Date: Fri, 23 Aug 2024 10:14:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/36] soc: fsl: qe: Add missing PUSHSCHED command
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-34-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-34-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> The PUSHSCHED command is missing in the QE header file.
> 
> This command is supported on MPC8321 and is used to modify the start
> address for the task running on a given peripheral. It is needed for the
> QMC in order to perform the re-initialization procedure and so, ensure
> the correct UCC setup in that case.
> 
> Simply add the missing command in the commands list available in the QE
> header file.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   include/soc/fsl/qe/qe.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
> index 629835b6c71d..8f967d15e479 100644
> --- a/include/soc/fsl/qe/qe.h
> +++ b/include/soc/fsl/qe/qe.h
> @@ -469,6 +469,7 @@ enum comm_dir {
>   #define QE_QMC_STOP_TX			0x0000000c
>   #define QE_QMC_STOP_RX			0x0000000d
>   #define QE_SS7_SU_FIL_RESET		0x0000000e
> +#define QE_PUSHSCHED			0x0000000f
>   /* jonathbr added from here down for 83xx */
>   #define QE_RESET_BCS			0x0000000a
>   #define QE_MCC_INIT_TX_RX_16		0x00000003

