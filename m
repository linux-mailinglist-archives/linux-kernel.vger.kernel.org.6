Return-Path: <linux-kernel+bounces-333103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C3797C3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27997B21377
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587AD1B285;
	Thu, 19 Sep 2024 05:12:51 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A381865C
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726722771; cv=none; b=P0IrMC5SgMgwO0Q8jKhUR2wbLi7NLQKNz7zPtE6nBefErceHnUSM4xS/RYr5xxOyKXBnfyfEzkUErxVtQq5GPsTlBDCmBcHYsKhkC/wg9uevCinQeAj3ibq8kQvFq/2U2QqvyuwciNFIleqvokgG0bRSRAMAxmTnH7Yv3zBlvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726722771; c=relaxed/simple;
	bh=DQRaR7EZeeV2cqRWEHPs9jh3hWdz804RkjjWoEz3Yzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgQGG5bVTvA9lgTD9sj/T7RmiPMr46UFTH8S82SCuhG9UKexugBIgOjZ1sC/WexnW5VZLHl/6iSZaXMTuMzpkIzFWnpDGAahJRzRbb361byuiUJ302YSqQ3RPxZi8rk927nt52vfUIlEnNw7EWO8XNd1r6zW0mTKwf4IjgvZcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X8Nv262lTz9tQt;
	Thu, 19 Sep 2024 07:12:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4RULTJogRSBh; Thu, 19 Sep 2024 07:12:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X8Nv25Brdz9tQC;
	Thu, 19 Sep 2024 07:12:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A1CF48B775;
	Thu, 19 Sep 2024 07:12:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 9-15FAM90Jzf; Thu, 19 Sep 2024 07:12:46 +0200 (CEST)
Received: from [192.168.234.38] (unknown [192.168.234.38])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0416F8B763;
	Thu, 19 Sep 2024 07:12:45 +0200 (CEST)
Message-ID: <65664ab8-4250-47c2-be50-d56c112a17fb@csgroup.eu>
Date: Thu, 19 Sep 2024 07:12:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 02/13] powerpc: mm: Fix kfence page fault reporting
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Donet Tom <donettom@linux.vnet.ibm.com>,
 Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
 Nirjhar Roy <nirjhar@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 kasan-dev@googlegroups.com, Disha Goel <disgoel@linux.ibm.com>
References: <cover.1726571179.git.ritesh.list@gmail.com>
 <87095ffca1e3b932c495942defc598907bf955f6.1726571179.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <87095ffca1e3b932c495942defc598907bf955f6.1726571179.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 19/09/2024 à 04:56, Ritesh Harjani (IBM) a écrit :
> copy_from_kernel_nofault() can be called when doing read of /proc/kcore.
> /proc/kcore can have some unmapped kfence objects which when read via
> copy_from_kernel_nofault() can cause page faults. Since *_nofault()
> functions define their own fixup table for handling fault, use that
> instead of asking kfence to handle such faults.
> 
> Hence we search the exception tables for the nip which generated the
> fault. If there is an entry then we let the fixup table handler handle the
> page fault by returning an error from within ___do_page_fault().

Searching the exception table is a heavy operation and all has been done 
in the past to minimise the number of times it is called, see for 
instance commit cbd7e6ca0210 ("powerpc/fault: Avoid heavy 
search_exception_tables() verification")

Also, by trying to hide false positives you also hide real ones. For 
instance if csum_partial_copy_generic() is using a kfence protected 
area, it will now go undetected.

IIUC, here your problem is limited to copy_from_kernel_nofault(). You 
should handle the root cause, not its effects. For that, you could 
perform additional verifications in copy_from_kernel_nofault_allowed().

Christophe

