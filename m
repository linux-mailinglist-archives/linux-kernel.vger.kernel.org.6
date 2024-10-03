Return-Path: <linux-kernel+bounces-349274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ED098F3A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091E21F215F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203B41A705A;
	Thu,  3 Oct 2024 16:08:36 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC661A7050;
	Thu,  3 Oct 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971715; cv=none; b=iLn3aIH1VSm0NBTKUebsCw7xFGngUOXdnVPE0JR0Zfliw50twyz9sEGlj9VWg+X7+dfGHVz6QuaOPTEAqrXRF8xktGV7F+bfgI+cvTooIlWF0FKJ+4q4ZU4jsP/YUyGghQyr21ruZNSkoejhqcLjxg3MB2DNiBTbgwoo9ZYz0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971715; c=relaxed/simple;
	bh=r3CvogXyotkFfUTVwyvgKHy5mDAvqaZDvSX9/pr1Ftg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbKcGc+m/IFFd6RBX8B4kJlTmy+pwEIRuqluk8B+sZ4AAEfErzIcuXmtJ2t5bdaIXAR1kBdYBQBd6Z6CVmSJtl1pQM8K8KaZmpza220L7nbw24ApFnMEGZgd4IpZV17mbLq1oB8p38Fu7yfIpvqyi1AXCDoIbMDOxS6iZ2WG+Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XKGnC4DHvz9sPd;
	Thu,  3 Oct 2024 18:08:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vGOblWKlMNCc; Thu,  3 Oct 2024 18:08:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XKGnC3Qphz9rvV;
	Thu,  3 Oct 2024 18:08:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F7EE8B77A;
	Thu,  3 Oct 2024 18:08:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id m8Cmdue2PRME; Thu,  3 Oct 2024 18:08:31 +0200 (CEST)
Received: from [192.168.232.46] (unknown [192.168.232.46])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C1E108B770;
	Thu,  3 Oct 2024 18:08:30 +0200 (CEST)
Message-ID: <e843b3f9-2214-4945-bc07-68fe935551a5@csgroup.eu>
Date: Thu, 3 Oct 2024 18:08:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] powerpc/4xx: Fix exception handling in
 ppc4xx_pciex_port_setup_hose()
To: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Stefan Roese <sr@denx.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <72a7bfe2-6051-01b0-6c51-a0f8cc0c93a5@web.de>
 <ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de>
 <e68a714b-32f2-de9f-066e-99a3f51a264f@web.de>
 <8edc93c8-b146-4507-8336-0709b2596cb9@csgroup.eu>
 <66655a11-888b-4c50-8e57-06552b82f922@web.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <66655a11-888b-4c50-8e57-06552b82f922@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/10/2024 à 17:47, Markus Elfring a écrit :
> …
>> Looks like you have messed up your patches,
> 
> There were special communication settings involved which hindered desirable
> data processing for known information systems.

Don't know what you mean.

> 
> 
>> there is no much we can do it seems:
>>
>> $ b4 shazam e68a714b-32f2-de9f-066e-99a3f51a264f@web.de
> 
> Please take another look also at published information according to further
> mailing list archive interfaces.

Another look to what ?

It seems like several patches were posted with the same Message-Id 
and/or with an unrelated In-Reply-To:

b4 is lost and cannot apply your series, it applies the patch at 
https://lore.kernel.org/all/82aebf6c-47ac-9d17-2d11-6245f582338e@web.de/

You may consider fixing and resending the series as an independant series.

Christophe

