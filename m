Return-Path: <linux-kernel+bounces-348225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F898E457
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4B77B21B2A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7541217314;
	Wed,  2 Oct 2024 20:43:56 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E39216A21;
	Wed,  2 Oct 2024 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901836; cv=none; b=ooEBhasjUa6+dM+RcuCqCPiLg2Nf9nUbLIYzT60MQJycdjIWaHiYnNn285vtPdn1qj2LPjGCK2NTYX+LcV/dDlu6/awPHa91YnVLVy6BTcRJ17+ndPfVAlxDSnto0XOfwi0Kt0akNJ/VDwEzURkcSqqoa3fpyMmmJI2EYKKCj6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901836; c=relaxed/simple;
	bh=m9vi7Rrk3MHL0f0AikwyN1ORuM9yo2gPb/hvXNpSH0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYwZHEQnZs8hbtOsPGLi6MCu9ud2lMXA+z/aaZ+6SxhT1Y7Jl1d0wae40+MVMXb8U2gppijL4Voh3UpGKGNv78l8HKv6XUj0DJF8Pesyd0OXM2smExXtpi0RQ35DBjF9eg++HLqHJ4fsHN3FJmBdZl7LgxoI/FFa+qXSPsZNlZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XJmxH1JjTz9sPd;
	Wed,  2 Oct 2024 22:43:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qISjOr7O0dDK; Wed,  2 Oct 2024 22:43:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XJmxH07Ckz9rvV;
	Wed,  2 Oct 2024 22:43:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DDF428B766;
	Wed,  2 Oct 2024 22:43:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id SWDakdAXHTTF; Wed,  2 Oct 2024 22:43:46 +0200 (CEST)
Received: from [192.168.233.87] (PO16952.IDSI0.si.c-s.fr [192.168.233.87])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D9C18B763;
	Wed,  2 Oct 2024 22:43:46 +0200 (CEST)
Message-ID: <d9bdc1b6-ea7e-47aa-80aa-02ae649abf72@csgroup.eu>
Date: Wed, 2 Oct 2024 22:43:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powermac: Call of_node_put(bk_node) only once in
 pmac_has_backlight_type()
To: Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
 Jani Nikula <jani.nikula@intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <b7e69e04-e15c-41ec-b62b-37253debc654@web.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <b7e69e04-e15c-41ec-b62b-37253debc654@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/10/2024 à 22:02, Markus Elfring a écrit :
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 2 Oct 2024 21:50:27 +0200
> 
> An of_node_put(bk_node) call was immediately used after a pointer check
> for an of_get_property() call in this function implementation.
> Thus call such a function only once instead directly before the check.

It seems pointless to perform a put immediately after a get. Shouldn't 
of_find_property() be used instead ? And then of_property_read_string() 
would probably be better.

Maybe you can even use of_property_match_string().

> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   arch/powerpc/platforms/powermac/backlight.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/backlight.c b/arch/powerpc/platforms/powermac/backlight.c
> index 12bc01353bd3..d3666595a62e 100644
> --- a/arch/powerpc/platforms/powermac/backlight.c
> +++ b/arch/powerpc/platforms/powermac/backlight.c
> @@ -61,11 +61,9 @@ int pmac_has_backlight_type(const char *type)
>   	if (bk_node) {
>   		const char *prop = of_get_property(bk_node,
>   				"backlight-control", NULL);
> -		if (prop && strncmp(prop, type, strlen(type)) == 0) {
> -			of_node_put(bk_node);
> -			return 1;
> -		}
>   		of_node_put(bk_node);
> +		if (prop && strncmp(prop, type, strlen(type)) == 0)
> +			return 1;
>   	}
> 
>   	return 0;
> --
> 2.46.1
> 

