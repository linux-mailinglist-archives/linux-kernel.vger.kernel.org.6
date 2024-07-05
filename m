Return-Path: <linux-kernel+bounces-242013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CAA928288
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54CFCB24923
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE61448FA;
	Fri,  5 Jul 2024 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhDWa+HZ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463771F61C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163570; cv=none; b=GRQxmOHKsGfiiSEtiug0dolMFQsVGKr4JuAU+HITnHR86hq1XIvNnCCbasankF9TtIAZkqH4I+4C1g7jEzA5phkjMD4GRNFVJz9f4AH7YNnpUsrUaGtd68d15qB593OH8l4RG/GeAtjpUP/7A031q52jxXjs4Oq0PQ0ySZjC6vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163570; c=relaxed/simple;
	bh=iv2ERwCzCiB2gd80xhoDKXfrPwpuGkjxdijGT/Gdy3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf68L+sz3e3guCQiDY6ZONFfvNLTPev8lQrbP/adhv6tgYvissRRiSk308ppz8WyZ7s8FE3ezMMwav0JL60nnIjERF+QxxRvmJUpSJjImPJVhQl8wSjV0Z65iedQ316PX+M523eRxPqKZO8qm8HPD4bwvE/LMf8YXpZ5oQ+AT6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhDWa+HZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so2308929a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720163567; x=1720768367; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBowXacvCBPq8+HeU6bAJH+gmUcBy4EmRD/T8EkAqIY=;
        b=HhDWa+HZ6hYzizFJBBBQO5q7UdJ+b1gZJFEjSLbZ6qVJyxwCgKPhkjNRqzqWIwBxE0
         TEQW6XKiakDOSsA+CDTmno8TqPGk42UVfYTxPd9O6Mcj2iXRinsNGAhv63QYGEctfo8w
         t1SnN6uhaMe7UFoavXpNNqXuG3u6Kfd2FE7MQsui0w5qa7guZQkVdUWP1orAzh6Ib2tV
         CqyU0v2Opcs1DL05r7bEoGuWRj48PshUG8kmdGqy1Qvn4FZTqc7ty/gvDdQtch4zepxv
         VlzBEt6LcKDiMfwscdfcu1/mG1ZoCNVDTGYdZb2Bndpm+B1coPTB/Obloo/1qxja0qUu
         VJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720163567; x=1720768367;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qBowXacvCBPq8+HeU6bAJH+gmUcBy4EmRD/T8EkAqIY=;
        b=e/2G7UoAp59FVBGqxIdro46FKmzRE4qCZ0vE9xE/gvW5Swz42HQFPUJIBa6yaLdVpX
         M0n+TL7+WUexYGjeUPvxsSnOLTwL8RZborcM/BG069iVeA8jCnioq2y0vqE5LKO16eQu
         3OXTT5ZkgFBa3CyHj3VQZiTPdNRmzvq1OzdaoOXwRNbdjIgN37DbT95Zw5aH0oJ0HAHQ
         e44+f98DFbr0Y8+MKlVjSzm+TdJKcNvRBKBx6BvMop5+sX1NEwUsUSCIviiIbCP8Jfky
         VAxT5xvkFHJID4EZ+yZzWvHIC5BRYp6BuERLlCdZCVGhbaGYX029R7GP56ghxgOOoKKr
         jeqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQa2u/RAXLuNtPoXxASBbgfn6CKLfFFSzP428a3dwttT/Nhs3UOMZ5Tj4JAVmRk3KP7yv47GowGXYLWgPkWOgiOO8T7BzrCGcmVE9H
X-Gm-Message-State: AOJu0YwoBEnx/h96IuB0mb6/TnNnWbC/KjI3j3R/Rh0H5mJ/w68Fp9NL
	lVMyb+6Lael3UL0kkvGE9ePOwtEHB9/8gbU3g2P1phOWAOwWcso3
X-Google-Smtp-Source: AGHT+IGbgcTijE9L+vJOhQbgm9TMODvfV1FQxBa++ZNxzLCfaLSJFpwi6EABsOb3uGWlKoHa6Ow87w==
X-Received: by 2002:a05:6402:4305:b0:57c:6a05:afd0 with SMTP id 4fb4d7f45d1cf-58e7b6ef9d4mr2812851a12.14.1720163567296;
        Fri, 05 Jul 2024 00:12:47 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58e88a6c067sm1528408a12.38.2024.07.05.00.12.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jul 2024 00:12:46 -0700 (PDT)
Date: Fri, 5 Jul 2024 07:12:46 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [Patch v3] x86/head/64: remove redundant check on
 level2_kernel_pgt's _PAGE_PRESENT bit
Message-ID: <20240705071246.wzl224vveysrunzc@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240523123539.14260-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523123539.14260-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

May I ask what else I should do?

On Thu, May 23, 2024 at 12:35:39PM +0000, Wei Yang wrote:
>Remove a redundant check on kernel code's PMD _PAGE_PRESENT attribute
>before fix up.
>
>Current process looks like this:
>
>    pmd in [0, _text)
>        unset _PAGE_PRESENT
>    pmd in [_text, _end]
>        if (_PAGE_PRESENT)
>            fix up delta
>    pmd in (_end, 512)
>        unset _PAGE_PRESENT
>
>level2_kernel_pgt compiled with _PAGE_PRESENT set. The check is
>redundant
>
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>CC: Thomas Gleixner <tglx@linutronix.de>
>CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>CC: Ingo Molnar <mingo@kernel.org>
>CC: Steve Wahl <steve.wahl@hpe.com>
>
>---
>v3: refine the change log per kirill's comment
>v2: adjust the change log to emphasize the redundant check
>---
> arch/x86/kernel/head64.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
>index a817ed0724d1..bac33ec19aa2 100644
>--- a/arch/x86/kernel/head64.c
>+++ b/arch/x86/kernel/head64.c
>@@ -260,8 +260,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
> 
> 	/* fixup pages that are part of the kernel image */
> 	for (; i <= pmd_index((unsigned long)_end); i++)
>-		if (pmd[i] & _PAGE_PRESENT)
>-			pmd[i] += load_delta;
>+		pmd[i] += load_delta;
> 
> 	/* invalidate pages after the kernel image */
> 	for (; i < PTRS_PER_PMD; i++)
>-- 
>2.34.1

-- 
Wei Yang
Help you, Help me

