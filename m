Return-Path: <linux-kernel+bounces-434358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9FA9E6568
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221C51884509
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04235192B76;
	Fri,  6 Dec 2024 04:29:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760BBECF;
	Fri,  6 Dec 2024 04:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733459377; cv=none; b=M7qWtdkFpDlsUH5pWBjgE936b6X7Zq9c3ozcZlM5XJUofz8iduRhsx5iLzc+t4TrVeIFnC0RPUmYqbCkSo3MWIakr4AsX69Jje6lQyFCLrv3UBeXNotCl2LnG5sZuKtYfZgPq8oe+U7DLcVIiLJoKYbmNPAomHoESrYCEZDMnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733459377; c=relaxed/simple;
	bh=ACte4UBGSvGouCXSY/zdfbHLzl3Fi//YtS1Kb4ZbHDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuQKu/C2uLUau/vwogxrqTfU0aZEllp/GtPg3N64XBze3+23uVV3klqq5sQDqYutpv+sqsobwtyrnCA/B39MoLWK+PSrk61ph7IPWINTgKwceOt2BKKCeQmeuWSLgQWWfwwSXkdexXbTe1duOC59pETUx55qnKkNIbhVxpdekho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A47F2169E;
	Thu,  5 Dec 2024 20:30:02 -0800 (PST)
Received: from [10.163.50.12] (unknown [10.163.50.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDAD13F58B;
	Thu,  5 Dec 2024 20:29:29 -0800 (PST)
Message-ID: <03245d82-ad68-4ac2-a6f1-d8e4cc5397c3@arm.com>
Date: Fri, 6 Dec 2024 09:59:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: introduce rodata=noalias
To: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: patches@amperecomputing.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, ardb@kernel.org, steven.price@arm.com,
 suzuki.poulose@arm.com, mark.rutland@arm.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 cl@os.amperecomputing.com
References: <20241126085647.4993-1-shijie@os.amperecomputing.com>
 <20241126085647.4993-4-shijie@os.amperecomputing.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241126085647.4993-4-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/26/24 14:26, Huang Shijie wrote:
> The rodata=noalias is the original rodata=on.
> 
> The rodata=noalias can provide us more block mappings and contiguous hits
> to map the linear region which minimize the TLB footprint. And the
> linear aliases of pages belonging to read-only mappings in vmalloc
> region are also marked as read-only.
> 
> Also update kernel-parameters.txt for it:
>    change "full" to "noalias"
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  arch/arm64/include/asm/setup.h                  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index dc663c0ca670..54b4df42e631 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5894,7 +5894,7 @@
>  	rodata=		[KNL,EARLY]
>  		on	Mark read-only kernel memory as read-only (default).
>  		off	Leave read-only kernel memory writable for debugging.
> -		full	Mark read-only kernel memory and aliases as read-only
> +		noalias	Use more block mappings,may have better performance.
>  		        [arm64]
>  
>  	rockchip.usb_uart
> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
> index 5ded3bd11476..3d96dde4d214 100644
> --- a/arch/arm64/include/asm/setup.h
> +++ b/arch/arm64/include/asm/setup.h
> @@ -31,7 +31,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
>  		return true;
>  	}
>  
> -	if (!strcmp(arg, "full")) {
> +	if (!strcmp(arg, "noalias")) {
>  		rodata_enabled = true;
>  		rodata_full = false;
>  		return true;

This patch should be folded back into [PATCH 1/4] ensuring that

- "rodata=" processing gets updated completely i.e dropping 'full',
  adding new 'noalias' and also updating the documentation at once

- Avoids temporary the "full" option breakage as mentioned earlier

Also please do add in code comment above arch_parse_debug_rodata()
function explaining all the options after these update.

