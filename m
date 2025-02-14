Return-Path: <linux-kernel+bounces-515773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74034A368C0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCCBC7A4517
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527E1FCCE5;
	Fri, 14 Feb 2025 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wNHWK90R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C41C84AC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573847; cv=none; b=lAjLgktyV1Lm6rkl8l3TDxRwZBQm4kqmOGD9fJmfNl7k6Z0/rIJVOpm0oLGrSL6r2ImAuw2ggbQTvt6E7R0D2jARn0BSjHtlap6Y1BXv9AfCeAZjeEDE/lm5yqZqc72k/5KfJgvpQJ6ou0/Eta5TmmDSP4YzdIZtSHsvpSSgyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573847; c=relaxed/simple;
	bh=0ILSp5JT+D3osiI60Lg0GB/KV/EA1edHu3s5ntXgN/c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E/C0RgvMjWK4ACHE5qYHD4Cw7mU7Sx3RXqVKyn0VPgo2D2YmDDTns457K9emeQzonUJCeWBKRb+tGsKh3J2OjZ/XcO/KaNIDd4pML3fp2D/zYZcLFW9skRNMeIlQcgjhQr6rMRKfSq/R29imk4BQfz2yk4302K9i9XThuQLXEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wNHWK90R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E28BC4CED1;
	Fri, 14 Feb 2025 22:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739573846;
	bh=0ILSp5JT+D3osiI60Lg0GB/KV/EA1edHu3s5ntXgN/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wNHWK90RZpaxhGt8dP93XV8XngPtWsFj6FWC265k5HT1xgomPYgwr8CICUUYMM5Bc
	 tGYtP4dBw19SdCryiRPKSTgOBiPPXOlE7Phu/LzqFFA7mLjcwbdy3hwJHh6ukOgnWv
	 JYio4GsXMulZUREsYxBxk6conNt+jT18wTPKXcyE=
Date: Fri, 14 Feb 2025 14:57:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
 osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 dakr@kernel.org
Subject: Re: [PATCH 1/2] drivers/base/memory: Simplify
 add_boot_memory_block()
Message-Id: <20250214145725.708746506f5937acc96783be@linux-foundation.org>
In-Reply-To: <20250214063504.617906-2-gshan@redhat.com>
References: <20250214063504.617906-1-gshan@redhat.com>
	<20250214063504.617906-2-gshan@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 16:35:03 +1000 Gavin Shan <gshan@redhat.com> wrote:

> It's unnecessary to keep the variable @section_count in the function
> because the device for the specific memory block will be added if
> any of its memory section is present. The variable @section_count
> records the number of present memory sections in the specific memory
> block, which isn't needed.
> 
> Simplify the function by dropping the variable @section_count. No
> functional change intended.
> 
> ...
>
>  static int __init add_boot_memory_block(unsigned long base_section_nr)
>  {
> -	int section_count = 0;
>  	unsigned long nr;
>  
>  	for (nr = base_section_nr; nr < base_section_nr + sections_per_block;

mm/sparse.c has a for_each_present_section_nr() - is that usable here?

> -	     nr++)
> -		if (present_section_nr(nr))
> -			section_count++;
> +	     nr++) {
> +		if (present_section_nr(nr)) {
> +			return add_memory_block(memory_block_id(base_section_nr),
> +						MEM_ONLINE, NULL, NULL);
> +		}
> +	}
>
> ...
>

