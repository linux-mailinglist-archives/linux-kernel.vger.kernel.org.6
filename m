Return-Path: <linux-kernel+bounces-298440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C34195C75A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803261C242C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C3140E5F;
	Fri, 23 Aug 2024 08:06:05 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D916D1B9;
	Fri, 23 Aug 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400364; cv=none; b=sEGElOosF+nnvflxp6ptbQAmD4/pf+95KzTSArYCDccsESncOZ50oFGldrkeBbreeQdnluMtX8XmUvRhwSh32fSflYak8UquIWZhPpQMHYkYgd/5eW3s9KVfQxKe74voIELuEOkL/58W0R1WW9jn3wDua7ysWKVMCT9BBWkjO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400364; c=relaxed/simple;
	bh=nXhGF49aptPaKpXVKsSDKTiebUPg9KILrNcYoZXzQDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c53DKKR+OpM/ILN6jGjmDysMZJCfDh328sjHJiINsfEAwSZWX1i5YjZ0tKxVRS38nPMCzUf+Wilh8jS1R+N2ZjpWOf+S3peIFsBSaWL8fjG9od9z8Ms8FGKR6vEY1SecN5nIQdJvJxTXyXJQ0UGiQMKOQgahT2syeozqbM8hQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt1P4Ftrz9sRr;
	Fri, 23 Aug 2024 10:06:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ruhI3TKhrhbG; Fri, 23 Aug 2024 10:06:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt1P3VYzz9rvV;
	Fri, 23 Aug 2024 10:06:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 67D088B77D;
	Fri, 23 Aug 2024 10:06:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id mjy-OhivgLWQ; Fri, 23 Aug 2024 10:06:01 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D1DF08B763;
	Fri, 23 Aug 2024 10:06:00 +0200 (CEST)
Message-ID: <e217798f-af3b-464b-be6d-ea94668766b5@csgroup.eu>
Date: Fri, 23 Aug 2024 10:05:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/36] soc: fsl: cpm1: tsa: Use ARRAY_SIZE() instead of
 hardcoded integer values
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-10-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-10-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> Loops handling the tdm array use hardcoded size and the initialization
> part uses hardcoded indexes to initialize the array.
> 
> Use ARRAY_SIZE() to avoid the hardcoded size and initialize the array
> using a loop.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   drivers/soc/fsl/qe/tsa.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
> index 244d521d8780..3d0c31a62dbb 100644
> --- a/drivers/soc/fsl/qe/tsa.c
> +++ b/drivers/soc/fsl/qe/tsa.c
> @@ -448,8 +448,8 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
>   	int i;
>   
>   	tsa->tdms = 0;
> -	tsa->tdm[0].is_enable = false;
> -	tsa->tdm[1].is_enable = false;
> +	for (i = 0; i < ARRAY_SIZE(tsa->tdm); i++)
> +		tsa->tdm[i].is_enable = false;
>   
>   	for_each_available_child_of_node(np, tdm_np) {
>   		ret = of_property_read_u32(tdm_np, "reg", &tdm_id);
> @@ -609,7 +609,7 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
>   	return 0;
>   
>   err:
> -	for (i = 0; i < 2; i++) {
> +	for (i = 0; i < ARRAY_SIZE(tsa->tdm); i++) {
>   		if (tsa->tdm[i].l1rsync_clk) {
>   			clk_disable_unprepare(tsa->tdm[i].l1rsync_clk);
>   			clk_put(tsa->tdm[i].l1rsync_clk);
> @@ -710,7 +710,7 @@ static void tsa_remove(struct platform_device *pdev)
>   	struct tsa *tsa = platform_get_drvdata(pdev);
>   	int i;
>   
> -	for (i = 0; i < 2; i++) {
> +	for (i = 0; i < ARRAY_SIZE(tsa->tdm); i++) {
>   		if (tsa->tdm[i].l1rsync_clk) {
>   			clk_disable_unprepare(tsa->tdm[i].l1rsync_clk);
>   			clk_put(tsa->tdm[i].l1rsync_clk);

