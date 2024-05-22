Return-Path: <linux-kernel+bounces-185864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC1F8CBC20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7EE6B216FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35567D401;
	Wed, 22 May 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKLMpaOT"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC919470
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363293; cv=none; b=iH9hCGw9kq/pA8QKCTz5+4bsPVwGdQ0eVEyWFTy8eYDix6EdbJo+ESrxd6n3v5zQRnz0xoUuNWKU0UrOUkaRFvN3C75TFqF+b76RUWREpQ7f2ouWcOwcuaYespw5k07W14QALJ9tILumnTbu9J5QlRURyDGoHDRJ9KkdbUVUSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363293; c=relaxed/simple;
	bh=msTPwn7ZsEqBoinGPO+dc0WZL8ZM4YIZawQtr7Y2IJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZq7cfmJqqFMgbLoWwIz9AlQKXY1/WuJiJRNSJrBsvsjkzqWuh7cLH8ZBAcw4dqGplpanAOVNdIASE7M4UuSdNXtlv5GNh7/vdgsmvqKA3CmusmHyomJ0HkZHBuGgh705Xz5urUxmebdl5MTQBrZStGf+AG/teHFN/QHYQ4ti8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKLMpaOT; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so839804566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716363291; x=1716968091; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/hJjssYBiKK3FJt3graYUFAtnDD1BmJX550YECuzF0=;
        b=VKLMpaOTCJr++kDLMTTBbz6iDLIntkge5t8u+6l8qUcgxS522SyZBar2hcZBZsFEWw
         0ISty7xmGTIv6jDeFOwZQlNdu0b/0IRahijWVxxuBMqnWLJlDXB9j3LG+vVzAAe8fGPX
         zk8eY/u6dojvh7M1n8kw58r5o+H2M44eisJNEbFsRe4KKfPZ6QXAuineAL+2IZGdCiqs
         xmzyCbbd8Oylr+PMoF+0IcYEW7myhcyvpsQ9lQ36jge518l+z9026JzOixCb1MAiBRAV
         ASFQopJVdzETKowwXO4nXR2JVUqlH3+WGU/1fj9kjV/DyXRy/ZYqc+cVuAsKkDWn+rx/
         1gRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716363291; x=1716968091;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J/hJjssYBiKK3FJt3graYUFAtnDD1BmJX550YECuzF0=;
        b=CpdtlgT4wshXbXDmUeSQ/eQQnYwbj0bq6EkdYwn0f3RUlAPCpJdodmwkWtqbcjYDlc
         e5I7om+TFZiSMW2UrYXnM8a0cAPbQnf4CYStheNekYwUfx/lA9hEjS+qWbhdQ3MPB1zD
         hAHtQg4jzgLYrDgsHH9BypYnBtbI+5nJVK8wYk3SLZ3/FjofPGdkSgIvE1Y35GYlF74Y
         qlGxh3K2FCNBf4gnY0gHy7xav2QF1ryoFk/Pv36tzRUkMLrRnF7U+Unbu3DkTmcK9jPW
         bEXGLikSztGt1+4nH8tbeQnfR4o5LqAOlckd9hOMExT3Fk/kZEPVN64WjzCEqSG08X0W
         0Oeg==
X-Forwarded-Encrypted: i=1; AJvYcCVGO6Flw3kJaczt/JHT80u5AmdxwHCpGtXdAJyv2lewUOqR1S/D1I4zB6QDE0LJ7bgt//HqQe4hh8/PD/DqbnkP6JsbQa4ZUr6iIx0I
X-Gm-Message-State: AOJu0YwxBFSGrfZgyMQ7k7OhedNsaN4I6rAdp4S3Nm2K1zv6Owu63lQH
	EQ+4wFk5/hBksel8aeQGOgxQwDm0A/tcrazw5iBN/eqeriDKGe+L
X-Google-Smtp-Source: AGHT+IFYDikEeHgFRq52t9CmgAjqyxOfnVG+aoPwX5Os1DKmEpMXI/HT+5XVZ7lq9sRYNHOC5GZmOA==
X-Received: by 2002:a17:906:817:b0:a5a:7cd3:b2e7 with SMTP id a640c23a62f3a-a62280280b0mr80183166b.11.1716363290514;
        Wed, 22 May 2024 00:34:50 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d48dsm1727170666b.5.2024.05.22.00.34.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2024 00:34:49 -0700 (PDT)
Date: Wed, 22 May 2024 07:34:49 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Steve Wahl <steve.wahl@hpe.com>,
	Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/head/64: level2_kernel_pgt's kernel area is built
 with _PAGE_PRESENT set
Message-ID: <20240522073449.sd4qfvysvjbkc6t3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240323232621.10400-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323232621.10400-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Mar 23, 2024 at 11:26:21PM +0000, Wei Yang wrote:
>The code is first introduced in 'commit 1ab60e0f72f7 ("[PATCH] x86-64:
>Relocatable Kernel Support")'.  Then 'commit c88d71508e36b
>("x86/boot/64: Rewrite startup_64() in C")', convert it to c. And
>'commit 2aa85f246c181 ("x86/boot/64: Make level2_kernel_pgt pages
>invalid outside kernel area")' limit the range from _text to _end.
>
>Originally, it does the check because the loop iterate the whole
>level2_kernel_pgt, while currently it just fixup the kernel area. This
>area is built with _PAGE_PRESENT set.

Ping

>
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>CC: Vivek Goyal <vgoyal@in.ibm.com>
>CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>CC: Ingo Molnar <mingo@kernel.org>
>CC: Steve Wahl <steve.wahl@hpe.com>
>CC: Borislav Petkov <bp@suse.de>
>---
> arch/x86/kernel/head64.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
>index 212e8e06aeba..75c69f8620d8 100644
>--- a/arch/x86/kernel/head64.c
>+++ b/arch/x86/kernel/head64.c
>@@ -253,8 +253,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
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

