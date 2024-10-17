Return-Path: <linux-kernel+bounces-369539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049E79A1E99
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787FDB25F10
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269D51D8DF6;
	Thu, 17 Oct 2024 09:40:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9F1D933A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158021; cv=none; b=FulHjm4lbcK94R4TAtnLmsxipprpqEpInJdSahe2Z/ofEeYGtMRxQejwFVsMRpzFFNtdEungAqwegVQti3qe04LBB9livrjH++XjpQvOe1z8fZ+whfbggX5uergjkALWBRVDCsCJO8vFPYzLKA4PfJMGs0EC79yLOeq7Wm/PoCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158021; c=relaxed/simple;
	bh=sztngNhovEqaCnRoJiQBIujJEUd20TeJ4hbc8EmN2oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqn/YbWncB12HoQrWiMMCq6+OSf2EG+jVowac89STqJH8UaM+BfyxiWEY9ae5PfRaeKKPouIDlGuZ3M6Vd/Wa+oqRCGdwsLrvSk/8xBQRsBpVWhlGwM7hMwsYDsFMr6jIaity5zLIHdxMLb0Z71Qw/Wyune/QxvQ4vN/IXGGois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A3BC4CEC5;
	Thu, 17 Oct 2024 09:40:19 +0000 (UTC)
Date: Thu, 17 Oct 2024 10:40:17 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Pintu Kumar <quic_pintu@quicinc.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	pintu.ping@gmail.com
Subject: Re: [PATCH] mm/kmemleak: fix errors/warnings for coding style
Message-ID: <ZxDbgS98-_VNkGXJ@arm.com>
References: <20241014183918.30123-1-quic_pintu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014183918.30123-1-quic_pintu@quicinc.com>

On Tue, Oct 15, 2024 at 12:09:18AM +0530, Pintu Kumar wrote:
> There are several errors/warnings reported by checkpatch.
> Fix all of the positive once as below:
> - Use #include <linux/processor.h> instead of <asm/processor.h>
> - Missing a blank lines after declarations
> - Prefer 'unsigned int' to bare use of 'unsigned'
> - else should follow close brace '}'

I wouldn't bother fixing up the style in existing code, it just makes
backporting fixes harder.

> @@ -2179,8 +2180,7 @@ static int __init kmemleak_boot_config(char *str)
>  	else if (strcmp(str, "on") == 0) {
>  		kmemleak_skip_disable = 1;
>  		stack_depot_request_early_init();
> -	}
> -	else
> +	} else
>  		return -EINVAL;
>  	return 0;

According to the coding style doc, the 'else' branch also needs braces
here.

-- 
Catalin

