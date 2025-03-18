Return-Path: <linux-kernel+bounces-566972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD633A67F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B38727AA0FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7D12063EB;
	Tue, 18 Mar 2025 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noKTadI2"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47342F9DA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335570; cv=none; b=rK2NlLn8fIjP+dBjr4aFt+N00nOvxI8grRow/5xDYXKyWezqHNY12bp6kE+hnh7EXowCmH45DMrMyDz6/Y5N7YPZDMJIeRLO4c+lnzYuvsFq7SJ59Dhc8goW0lo5hMbmMjRY76d+sn3CqWCp+Rpt7k59E1C3BpSgwDjfWk3UBVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335570; c=relaxed/simple;
	bh=9P202me5VZNfxZEJWWT//4mdnhUl2AjJ4kT+GpD/pL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDlfqp5sJvnNVLEM94yq3ViujvocUnyusNM9OJJTPDr1B3dWw8GzMw0+LdNiObH7m32iJn5zFaL7UL/S62DukMc4JaoS1EAew7esLOQxGeWg/Bae9E0H3FnNhDiKhb+uVMFcBVasGKBNKC2KKwiZ8ZzMJpN/GySHXVoBZTTOXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noKTadI2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso36607945e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742335567; x=1742940367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3keg+xfuGlW8SnAhd6bmGN52uZdzGiNVC2K0IsdpCKM=;
        b=noKTadI2Q49Us4pTNIDFKWRh4DxMsTPEuWRleHi/WMYuMAhdZcG7F4t3Y70aD6UHe+
         xrQ8iUGcUk1yEO+Y2SdYcf7r19NBHN996+UnbE//OYLmK6TLO8m7py4gk7pOL4utjGWz
         1qX4rVld0kPXhr6i5Ac+3XKst3lIKnZq1IJAsCoR+b4pN4DZZmWHGvm6tZyPVc/lmdCs
         7qonqZm+kL5ZqG+s/zO2o8YDR7NEynxQ1ue4u8YnTlNiHXFBHAia5pteUjBKV5LczwyB
         8wiL0nnKAs7b03UjyKECEsFcmjhALXAL/ay+5EVnj1Fv9jMB5HUepav/SFGEwrzzxEXG
         Wmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742335567; x=1742940367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3keg+xfuGlW8SnAhd6bmGN52uZdzGiNVC2K0IsdpCKM=;
        b=iPxe9HHKKr4LfUgSHKvCVsK8rFb3OcTagZZWmDTk1mRpUatCC//3nW3+pSwXOge27A
         CIAYzZzryfXHqliWfyjF32sDlhTLEHBJNXt9KKQEVbu/qDWibkGTGGvlMCpJ/IWMuXSn
         wm5chqbxCg24BpHaUn42f+ws+Hi043XYIlnVyXnxWg15TWjt2pFKoONpPZGEjfIBSZ71
         0oD603yeoSY8glGOSPq2ZDisvLojeStILuaiPKWMUj9lGzfCTx/FS4zcCzAkPrKrzrml
         a7e29ZJD1nuqmhS7wd2SbNCdbmIJGuZeZTAxoeSNBBK5tdOXw1o/h8rM+c3R7YVcXdH5
         lF5A==
X-Forwarded-Encrypted: i=1; AJvYcCWN5hFAoTlAbjACyP83kBcxD6UPciIM44vF8e2zeEMRSufgZI75EKyOni/ME8+fILhz2gZ+XyXZm5m5EVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKPKEny/pUKg3bWZEcICvrlUyguoH23y3/Cak+frkFTXrT0xv
	LkyalLMzuds8uwcE3FnzEbG7CDbMXw5Tlhw2lm+QhK/fpHfw/WUX
X-Gm-Gg: ASbGncv+9GfRoncvX7Z516654QdUekB42IE5y3DK2l3/I6jxWc5jn/915AB6NKqpPlm
	3s9Mng8ecc0RUpMSt12x6YZTgSLjnftIkUs3b2adJKnR5h/QXbq40gba+LHS7TOIrq7ZjAa7VLE
	eeSAMjlWtQZ6BDG718V160HVJ1V5kzvJD6kedgNDX1n45cXhI5EwXDhuMx9z5Bn7qV1/h2E+PeC
	U/MTonIFS0uRWJhXv10gbiQa9FUQkefcaJcQeS4Fq4dq/toXuG9OlMJZCNOT5InLuTiIVfiKRfJ
	8KfFN+WbfA0p4VwlnXvzd5bbzDSbHLCjcfulOcv9jgZuF9LCbZlpKEIT/RD68lufkIdvr/1KrhW
	A1rJPuW3YkV91qyK3wg==
X-Google-Smtp-Source: AGHT+IGl+AzM9WCCEhBv8hRHNNChuIK9CGkOb6AXtxBiM5lTtNkxEHVB3FOfcVzU7j11jm3Sn9g+PA==
X-Received: by 2002:a05:600c:198e:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-43d437feb91mr1994415e9.20.1742335567076;
        Tue, 18 Mar 2025 15:06:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f55721sm152255e9.20.2025.03.18.15.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:06:06 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:06:05 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Uros
 Bizjak <ubizjak@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Ingo
 Molnar <mingo@kernel.org>
Subject: Re: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit
 barrier functions
Message-ID: <20250318220605.6ac40f6d@pumpkin>
In-Reply-To: <rvrdr6yefc6fbbsuhamf7ri4nlrxvmafcqpmgg6duwpj2blhad@a2wrcdspyvip>
References: <cover.1741988314.git.jpoimboe@kernel.org>
	<1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
	<CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
	<zfabhk7c3fucov7lpfsqf5bj7iie5324ccgn4ingzzakoyhl4u@fzg364keuphn>
	<20250317200432.1a076d6a@pumpkin>
	<rvrdr6yefc6fbbsuhamf7ri4nlrxvmafcqpmgg6duwpj2blhad@a2wrcdspyvip>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 17:11:58 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Mon, Mar 17, 2025 at 08:04:32PM +0000, David Laight wrote:
> > Is the ARG() necessary just to handle the comma separated lists?
> > If so is it only actually needed if there is more than one item?  
> 
> No, but my preference is to require the use of the macro even for single
> constraints as it helps visually separate the lists.
> 
> > Another option is to just require () and add the ARG in the expansion.
> > So with:
> > #define __asm_call(qual, alt, out, in, clobber) \
> > 	asm("zzz", ARG out, ARG in, ARG clobber)
> > 
> > __asm_call(qual, ALT(), \
> > 		([var] "+m" (__my_cpu_var(_var)), "+a" (old__.low),	\
> > 		    "+d" (old__.high)),					\
> > 		("b" (new__.low), "c" (new__.high), "S" (&(_var))),	\
> > 		("memory"));
> > 
> > would get expanded the same as the line below.  
> 
> Interesting idea, though I still prefer the self-documenting ASM_OUTPUT
> / ASM_INPUT / ASM_CLOBBER macros which are self-documenting and make it
> easier to read and visually distinguish the constraint lists.

Except that non of this really makes it easier to get out/in in the correct
order or to use the right constraints.
So are you just adding 'syntactic sugar' for no real gain?

Looking back at one of the changes:
-#define mb() asm volatile(ALTERNATIVE("lock addl $0,-4(%%esp)", "mfence", \
-				      X86_FEATURE_XMM2) ::: "memory", "cc")
+#define mb() alternative_io("lock addl $0,-4(%%esp)",			\
+			    "mfence", X86_FEATURE_XMM2,			\
+			    ARG(),					\
+			    ARG(),					\
+			    ARG("memory", "cc")) 

is it really an improvement?

	David

