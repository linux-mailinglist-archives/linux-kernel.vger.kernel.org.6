Return-Path: <linux-kernel+bounces-361484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498499A8DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E1D284FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A75A199222;
	Fri, 11 Oct 2024 16:25:58 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B71474BC;
	Fri, 11 Oct 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663957; cv=none; b=MYZv+JxhPfdlhyUzLoyCyOhMRWlVE+gAQ4jRsewu2EAh/Q9Rks7S3e4WVfVo5XROndmd+imSdU9crk61XWrf2DOvbLa3NuOoRRAqDLFlcziviMdnnYMESFtH6Y7Mirp9QSabKVhRQ22pOjdXDPVwYwPp+JF/X5vCVABmi2t7Evo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663957; c=relaxed/simple;
	bh=f9VyAev0FoKz62jHMtvpWxgflMBtUDJgE8sIs+rp65k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrYNLD/Iw4CxhNxDlvksp1+uil5WgXoVnA2bNbaOs1HkauVndL0vliU00BgHTDt/C1bFkP6tiEV7dEQSldqQ2NCAhv4rzwl7xjZ+INdKfPXzaepDBCI/OFkjz/yB9tpZ12tbI8xoMvBiNoq9lwUaVh2KZrm/mEqeTHzj2QH1DMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XQBnR6xkJz9sRy;
	Fri, 11 Oct 2024 18:25:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5JmGQAo84Yjs; Fri, 11 Oct 2024 18:25:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XQBnR5cGSz9sPd;
	Fri, 11 Oct 2024 18:25:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AFC408B7AD;
	Fri, 11 Oct 2024 18:25:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id nlZi6cgF6vzi; Fri, 11 Oct 2024 18:25:47 +0200 (CEST)
Received: from [192.168.232.203] (unknown [192.168.232.203])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1311F8B79E;
	Fri, 11 Oct 2024 18:25:47 +0200 (CEST)
Message-ID: <c629e544-f768-4063-bd2c-f72382bdf69b@csgroup.eu>
Date: Fri, 11 Oct 2024 18:25:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powermac: Use of_property_match_string() in
 pmac_has_backlight_type()
To: Markus Elfring <Markus.Elfring@web.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org, Jani Nikula <jani.nikula@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <b7e69e04-e15c-41ec-b62b-37253debc654@web.de>
 <d9bdc1b6-ea7e-47aa-80aa-02ae649abf72@csgroup.eu>
 <ede25e03-7a14-4787-ae1b-4fc9290add5a@web.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ede25e03-7a14-4787-ae1b-4fc9290add5a@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/10/2024 à 18:18, Markus Elfring a écrit :
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 11 Oct 2024 18:10:06 +0200
> 
> Replace an of_get_property() call by of_property_match_string()
> so that this function implementation can be simplified.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinuxppc-dev%2Fd9bdc1b6-ea7e-47aa-80aa-02ae649abf72%40csgroup.eu%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cf278e44683c04b931b9c08dcea106447%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638642603333398766%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=6byvgvuGiBSVu8F6kLA2OozUuHZunJRH%2BU%2Bq9q7osmM%3D&reserved=0
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinuxppc-dev%2F87cyk97ufp.fsf%40mail.lhotse%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cf278e44683c04b931b9c08dcea106447%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638642603333422636%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=IDuYfe3UoaIEmedJ07H67zvzrPnzbQ2g8EeTtbJ%2BbZ8%3D&reserved=0
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   arch/powerpc/platforms/powermac/backlight.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/backlight.c b/arch/powerpc/platforms/powermac/backlight.c
> index 12bc01353bd3..79741370c40c 100644
> --- a/arch/powerpc/platforms/powermac/backlight.c
> +++ b/arch/powerpc/platforms/powermac/backlight.c
> @@ -57,18 +57,10 @@ struct backlight_device *pmac_backlight;
>   int pmac_has_backlight_type(const char *type)
>   {
>   	struct device_node* bk_node = of_find_node_by_name(NULL, "backlight");
> +	int i = of_property_match_string(bk_node, "backlight-control", type);
> 
> -	if (bk_node) {
> -		const char *prop = of_get_property(bk_node,
> -				"backlight-control", NULL);
> -		if (prop && strncmp(prop, type, strlen(type)) == 0) {
> -			of_node_put(bk_node);
> -			return 1;
> -		}
> -		of_node_put(bk_node);
> -	}
> -
> -	return 0;
> +	of_node_put(bk_node);
> +	return i >= 0;

Could have been:

	return !IS_ERR_VALUE(i);


Never mind,

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

>   }
> 
>   static void pmac_backlight_key_worker(struct work_struct *work)
> --
> 2.46.1
> 

