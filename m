Return-Path: <linux-kernel+bounces-298441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A3195C75E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4362865DD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D424313F42A;
	Fri, 23 Aug 2024 08:06:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26646D1B9;
	Fri, 23 Aug 2024 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400397; cv=none; b=QBXQ9GSJi4BQQ/KWUIyGboPWiOzmVgG2V07OqV4lY6P3++UOgtU+QxjH8EA34AxaDpSFbPUBexlf5tnHAxqXUM5NfDNdpc+sjeh6Ban5kFwz43jraop7H3sCGTTbDexCRjv59uA5kzhWt0LJhuXToFZc3kii6KcwqUsF/0ZGjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400397; c=relaxed/simple;
	bh=WZ4eIozf0TzvsDfhRi5Kzsmm0rfNVsLDbps4G0RV5RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2drDEwM8Dx8KjPPRxdPvwDbfH9wsbpBOQUQIxv1HcHz359rHmKjynJvVAl0+AHCg1Rpi6nMaLMcqyG4z7TKPhmArhvfB74T/QaY0m7lLgqFvDmP9vWD3XsqXil+qsFw79t0596mQ+jLK3UW9w1Gb0tOzaToclohH0XNTMFxpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt221BVPz9sRr;
	Fri, 23 Aug 2024 10:06:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZvIZ5efkLFBQ; Fri, 23 Aug 2024 10:06:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt216wzfz9rvV;
	Fri, 23 Aug 2024 10:06:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DAA5A8B77D;
	Fri, 23 Aug 2024 10:06:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xZhIZzVRdc2Y; Fri, 23 Aug 2024 10:06:33 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2AB638B763;
	Fri, 23 Aug 2024 10:06:33 +0200 (CEST)
Message-ID: <98269f9e-e96e-49f0-9063-f957e963baa5@csgroup.eu>
Date: Fri, 23 Aug 2024 10:06:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/36] soc: fsl: cpm1: tsa: Make SIRAM entries specific
 to CPM1
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-11-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-11-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> Current code handles the CPM1 version of TSA. Compared against QUICC
> Engine (QE) version of TSA, CPM1 SIRAM entries are slightly different.
> 
> In order to prepare the support for the QE version, clearly identify
> these entries and functions handling them as CPM1 compatible.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   drivers/soc/fsl/qe/tsa.c | 75 ++++++++++++++++++++++++----------------
>   1 file changed, 46 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
> index 3d0c31a62dbb..bf7354ebaca4 100644
> --- a/drivers/soc/fsl/qe/tsa.c
> +++ b/drivers/soc/fsl/qe/tsa.c
> @@ -18,18 +18,18 @@
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   
> -/* TSA SI RAM routing tables entry */
> -#define TSA_SIRAM_ENTRY_LAST		BIT(16)
> -#define TSA_SIRAM_ENTRY_BYTE		BIT(17)
> -#define TSA_SIRAM_ENTRY_CNT_MASK	GENMASK(21, 18)
> -#define TSA_SIRAM_ENTRY_CNT(x)		FIELD_PREP(TSA_SIRAM_ENTRY_CNT_MASK, x)
> -#define TSA_SIRAM_ENTRY_CSEL_MASK	GENMASK(24, 22)
> -#define TSA_SIRAM_ENTRY_CSEL_NU		FIELD_PREP_CONST(TSA_SIRAM_ENTRY_CSEL_MASK, 0x0)
> -#define TSA_SIRAM_ENTRY_CSEL_SCC2	FIELD_PREP_CONST(TSA_SIRAM_ENTRY_CSEL_MASK, 0x2)
> -#define TSA_SIRAM_ENTRY_CSEL_SCC3	FIELD_PREP_CONST(TSA_SIRAM_ENTRY_CSEL_MASK, 0x3)
> -#define TSA_SIRAM_ENTRY_CSEL_SCC4	FIELD_PREP_CONST(TSA_SIRAM_ENTRY_CSEL_MASK, 0x4)
> -#define TSA_SIRAM_ENTRY_CSEL_SMC1	FIELD_PREP_CONST(TSA_SIRAM_ENTRY_CSEL_MASK, 0x5)
> -#define TSA_SIRAM_ENTRY_CSEL_SMC2	FIELD_PREP_CONST(TSA_SIRAM_ENTRY_CSEL_MASK, 0x6)
> +/* TSA SI RAM routing tables entry (CPM1) */
> +#define TSA_CPM1_SIRAM_ENTRY_LAST	BIT(16)
> +#define TSA_CPM1_SIRAM_ENTRY_BYTE	BIT(17)
> +#define TSA_CPM1_SIRAM_ENTRY_CNT_MASK	GENMASK(21, 18)
> +#define TSA_CPM1_SIRAM_ENTRY_CNT(x)	FIELD_PREP(TSA_CPM1_SIRAM_ENTRY_CNT_MASK, x)
> +#define TSA_CPM1_SIRAM_ENTRY_CSEL_MASK	GENMASK(24, 22)
> +#define TSA_CPM1_SIRAM_ENTRY_CSEL_NU	FIELD_PREP_CONST(TSA_CPM1_SIRAM_ENTRY_CSEL_MASK, 0x0)
> +#define TSA_CPM1_SIRAM_ENTRY_CSEL_SCC2	FIELD_PREP_CONST(TSA_CPM1_SIRAM_ENTRY_CSEL_MASK, 0x2)
> +#define TSA_CPM1_SIRAM_ENTRY_CSEL_SCC3	FIELD_PREP_CONST(TSA_CPM1_SIRAM_ENTRY_CSEL_MASK, 0x3)
> +#define TSA_CPM1_SIRAM_ENTRY_CSEL_SCC4	FIELD_PREP_CONST(TSA_CPM1_SIRAM_ENTRY_CSEL_MASK, 0x4)
> +#define TSA_CPM1_SIRAM_ENTRY_CSEL_SMC1	FIELD_PREP_CONST(TSA_CPM1_SIRAM_ENTRY_CSEL_MASK, 0x5)
> +#define TSA_CPM1_SIRAM_ENTRY_CSEL_SMC2	FIELD_PREP_CONST(TSA_CPM1_SIRAM_ENTRY_CSEL_MASK, 0x6)
>   
>   /* SI mode register (32 bits) */
>   #define TSA_SIMODE	0x00
> @@ -228,8 +228,8 @@ int tsa_serial_get_info(struct tsa_serial *tsa_serial, struct tsa_serial_info *i
>   }
>   EXPORT_SYMBOL(tsa_serial_get_info);
>   
> -static void tsa_init_entries_area(struct tsa *tsa, struct tsa_entries_area *area,
> -				  u32 tdms, u32 tdm_id, bool is_rx)
> +static void tsa_cpm1_init_entries_area(struct tsa *tsa, struct tsa_entries_area *area,
> +				       u32 tdms, u32 tdm_id, bool is_rx)
>   {
>   	resource_size_t quarter;
>   	resource_size_t half;
> @@ -280,7 +280,13 @@ static void tsa_init_entries_area(struct tsa *tsa, struct tsa_entries_area *area
>   	}
>   }
>   
> -static const char *tsa_serial_id2name(struct tsa *tsa, u32 serial_id)
> +static void tsa_init_entries_area(struct tsa *tsa, struct tsa_entries_area *area,
> +				  u32 tdms, u32 tdm_id, bool is_rx)
> +{
> +	tsa_cpm1_init_entries_area(tsa, area, tdms, tdm_id, is_rx);
> +}
> +
> +static const char *tsa_cpm1_serial_id2name(struct tsa *tsa, u32 serial_id)
>   {
>   	switch (serial_id) {
>   	case FSL_CPM_TSA_NU:	return "Not used";
> @@ -295,22 +301,27 @@ static const char *tsa_serial_id2name(struct tsa *tsa, u32 serial_id)
>   	return NULL;
>   }
>   
> -static u32 tsa_serial_id2csel(struct tsa *tsa, u32 serial_id)
> +static const char *tsa_serial_id2name(struct tsa *tsa, u32 serial_id)
> +{
> +	return tsa_cpm1_serial_id2name(tsa, serial_id);
> +}
> +
> +static u32 tsa_cpm1_serial_id2csel(struct tsa *tsa, u32 serial_id)
>   {
>   	switch (serial_id) {
> -	case FSL_CPM_TSA_SCC2:	return TSA_SIRAM_ENTRY_CSEL_SCC2;
> -	case FSL_CPM_TSA_SCC3:	return TSA_SIRAM_ENTRY_CSEL_SCC3;
> -	case FSL_CPM_TSA_SCC4:	return TSA_SIRAM_ENTRY_CSEL_SCC4;
> -	case FSL_CPM_TSA_SMC1:	return TSA_SIRAM_ENTRY_CSEL_SMC1;
> -	case FSL_CPM_TSA_SMC2:	return TSA_SIRAM_ENTRY_CSEL_SMC2;
> +	case FSL_CPM_TSA_SCC2:	return TSA_CPM1_SIRAM_ENTRY_CSEL_SCC2;
> +	case FSL_CPM_TSA_SCC3:	return TSA_CPM1_SIRAM_ENTRY_CSEL_SCC3;
> +	case FSL_CPM_TSA_SCC4:	return TSA_CPM1_SIRAM_ENTRY_CSEL_SCC4;
> +	case FSL_CPM_TSA_SMC1:	return TSA_CPM1_SIRAM_ENTRY_CSEL_SMC1;
> +	case FSL_CPM_TSA_SMC2:	return TSA_CPM1_SIRAM_ENTRY_CSEL_SMC2;
>   	default:
>   		break;
>   	}
> -	return TSA_SIRAM_ENTRY_CSEL_NU;
> +	return TSA_CPM1_SIRAM_ENTRY_CSEL_NU;
>   }
>   
> -static int tsa_add_entry(struct tsa *tsa, struct tsa_entries_area *area,
> -			 u32 count, u32 serial_id)
> +static int tsa_cpm1_add_entry(struct tsa *tsa, struct tsa_entries_area *area,
> +			      u32 count, u32 serial_id)
>   {
>   	void __iomem *addr;
>   	u32 left;
> @@ -328,21 +339,21 @@ static int tsa_add_entry(struct tsa *tsa, struct tsa_entries_area *area,
>   
>   	if (area->last_entry) {
>   		/* Clear last flag */
> -		tsa_clrbits32(area->last_entry, TSA_SIRAM_ENTRY_LAST);
> +		tsa_clrbits32(area->last_entry, TSA_CPM1_SIRAM_ENTRY_LAST);
>   	}
>   
>   	left = count;
>   	while (left) {
> -		val = TSA_SIRAM_ENTRY_BYTE | tsa_serial_id2csel(tsa, serial_id);
> +		val = TSA_CPM1_SIRAM_ENTRY_BYTE | tsa_cpm1_serial_id2csel(tsa, serial_id);
>   
>   		if (left > 16) {
>   			cnt = 16;
>   		} else {
>   			cnt = left;
> -			val |= TSA_SIRAM_ENTRY_LAST;
> +			val |= TSA_CPM1_SIRAM_ENTRY_LAST;
>   			area->last_entry = addr;
>   		}
> -		val |= TSA_SIRAM_ENTRY_CNT(cnt - 1);
> +		val |= TSA_CPM1_SIRAM_ENTRY_CNT(cnt - 1);
>   
>   		tsa_write32(addr, val);
>   		addr += 4;
> @@ -352,6 +363,12 @@ static int tsa_add_entry(struct tsa *tsa, struct tsa_entries_area *area,
>   	return 0;
>   }
>   
> +static int tsa_add_entry(struct tsa *tsa, struct tsa_entries_area *area,
> +			 u32 count, u32 serial_id)
> +{
> +	return tsa_cpm1_add_entry(tsa, area, count, serial_id);
> +}
> +
>   static int tsa_of_parse_tdm_route(struct tsa *tsa, struct device_node *tdm_np,
>   				  u32 tdms, u32 tdm_id, bool is_rx)
>   {
> @@ -636,7 +653,7 @@ static void tsa_init_si_ram(struct tsa *tsa)
>   
>   	/* Fill all entries as the last one */
>   	for (i = 0; i < tsa->si_ram_sz; i += 4)
> -		tsa_write32(tsa->si_ram + i, TSA_SIRAM_ENTRY_LAST);
> +		tsa_write32(tsa->si_ram + i, TSA_CPM1_SIRAM_ENTRY_LAST);
>   }
>   
>   static int tsa_probe(struct platform_device *pdev)

