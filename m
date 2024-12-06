Return-Path: <linux-kernel+bounces-434353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DB19E655F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F341646C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8880E191F78;
	Fri,  6 Dec 2024 04:21:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C526ECF;
	Fri,  6 Dec 2024 04:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458880; cv=none; b=ML65TQ4DvpnfsMyqYuAKmfAGgeeQq1A5GmL5NcgxQocb9Ja4Cjb1cgxIIWy9BI1liljQvDzRjprWDeRfmUA3SmKoU66wnXunCJpq+aDlN5gGmheTL2U9P6F5cNmVgykKKNYn+BWQBwM5jP9pJLqBs6SYi4OrGDusIrMWfSIdK9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458880; c=relaxed/simple;
	bh=v5C0HARwM7EY2or5B3G54BkWFyN298b7SEvQVPXMK1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spkuoiZ+TATGWD8i5gSL5sjyNG2roTfHcKDLbhFUbmgUmH9dHxMnPYrSgJYyihuIOJJOJRwMPFHhRqehjv8fv/k7fWAmntNaY/O6JneiBXzjOS+SmnQ2VveHaFDpq3dsCZBSFzMpwKjp6zv2sopqyFuFiKQ62G9G7h60wCnmzaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64617169E;
	Thu,  5 Dec 2024 20:21:44 -0800 (PST)
Received: from [10.163.50.12] (unknown [10.163.50.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4518A3F58B;
	Thu,  5 Dec 2024 20:21:11 -0800 (PST)
Message-ID: <f625af22-cb60-47d2-a775-e9fd273a8e7c@arm.com>
Date: Fri, 6 Dec 2024 09:51:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: make rodata=on behaviour be the original
 rodata=full
To: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: patches@amperecomputing.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, ardb@kernel.org, steven.price@arm.com,
 suzuki.poulose@arm.com, mark.rutland@arm.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 cl@os.amperecomputing.com
References: <20241126085647.4993-1-shijie@os.amperecomputing.com>
 <20241126085647.4993-2-shijie@os.amperecomputing.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241126085647.4993-2-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/26/24 14:26, Huang Shijie wrote:
> Make rodata=on behaviour be the original rodata=full.
> After this patch, the rodata=on will be the default,
> and the arm64 kernel behaviour will follow the
> Documentation/admin-guide/kernel-parameters.txt:
> 	rodata=		[KNL,EARLY]
> 		on	Mark read-only kernel memory as read-only (default).
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  arch/arm64/include/asm/setup.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
> index ba269a7a3201..5ded3bd11476 100644
> --- a/arch/arm64/include/asm/setup.h
> +++ b/arch/arm64/include/asm/setup.h
> @@ -21,7 +21,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
>  	if (!arg)
>  		return false;
>  
> -	if (!strcmp(arg, "full")) {
> +	if (!strcmp(arg, "on")) {
>  		rodata_enabled = rodata_full = true;
>  		return true;
>  	}
> @@ -31,7 +31,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
>  		return true;
>  	}
>  
> -	if (!strcmp(arg, "on")) {
> +	if (!strcmp(arg, "full")) {
>  		rodata_enabled = true;
>  		rodata_full = false;
>  		return true;

After this patch we have the following and seems like 'rodata=full'
is temporarily broken until the subsequent patches come in ?

static inline bool arch_parse_debug_rodata(char *arg)
{
        extern bool rodata_enabled;
        extern bool rodata_full;

        if (!arg)
                return false;

        if (!strcmp(arg, "on")) {
                rodata_enabled = rodata_full = true;
                return true;
        }

        if (!strcmp(arg, "off")) {
                rodata_enabled = rodata_full = false;
                return true;
        }

        if (!strcmp(arg, "full")) {
                rodata_enabled = true;
                rodata_full = false;     <---------------- here
                return true;
        }

        return false;
}

