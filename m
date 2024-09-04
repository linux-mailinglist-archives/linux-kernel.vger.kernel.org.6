Return-Path: <linux-kernel+bounces-314918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D404996BAFB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901D028A08D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594191D0173;
	Wed,  4 Sep 2024 11:41:23 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783351CCB43
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450083; cv=none; b=Uc9iYsLOsnyrGqVb24cEiIFWeDyP+DnyUYG+gbwJ/260oCF8HGOEoCG0Tq6Eqq6kxHDg91j89T4ROMpMimO90gYs1YwEnnigGPrgwGYCARPDKZQZAEAwSveE/JZG7jHSRam97agHoLwiyiGNIevarn9SWCzdexZoVDB6Yd0F61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450083; c=relaxed/simple;
	bh=5U/sAfu6fDMYladg7S1N6V5lZi8WcZqMGbiIgzWx6P8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iviN+sQyb1SdPpseumngeofGaVS4XImIXdOEu+HgnRCyILtE+wYEd929XzQ8bLBUxO35UrpLXCHmjpOOied0aB+XWlsOL6QkfpKQ5fhIwSVx1uSL7Aky16DMkTOu4dEynlhRhoz5LfxGFwSmyRjd3jdp83snvywBBWh15ZIdWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WzLDH5M27z9sS7;
	Wed,  4 Sep 2024 13:41:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AUxpvlBysyoS; Wed,  4 Sep 2024 13:41:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WzLDH4b6Gz9sRr;
	Wed,  4 Sep 2024 13:41:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E07B8B77A;
	Wed,  4 Sep 2024 13:41:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id EpWSv8U77IeF; Wed,  4 Sep 2024 13:41:19 +0200 (CEST)
Received: from [192.168.234.246] (unknown [192.168.234.246])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 478688B778;
	Wed,  4 Sep 2024 13:41:19 +0200 (CEST)
Message-ID: <30e9575c-a53e-4e17-bbbd-7127798efb05@csgroup.eu>
Date: Wed, 4 Sep 2024 13:41:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: fr-FR
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Xi Ruoyao <xry111@xry111.site>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Profiling of vdso_test_random
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm done a 'perf record' on vdso_test_random reduced to vdso test only, 
and I get the following function usage profile.

Do you see the same type of percentage on your platforms ?

I would have expected most of the time to be spent in 
__arch_chacha20_blocks_nostack() but that's in fact not the case.

# Samples: 61K of event 'task-clock:ppp'
# Event count (approx.): 15463500000
#
# Overhead  Command          Shared Object        Symbol 

# ........  ...............  ................... 
....................................
#
     57.74%  vdso_test_getra  [vdso]               [.] __c_kernel_getrandom
     22.49%  vdso_test_getra  [vdso]               [.] 
__arch_chacha20_blocks_nostack
     10.80%  vdso_test_getra  vdso_test_getrandom  [.] test_vdso_getrandom
      8.89%  vdso_test_getra  [vdso]               [.] __kernel_getrandom
      0.01%  vdso_test_getra  [kernel.kallsyms]    [k] 
finish_task_switch.isra.0


Christophe

