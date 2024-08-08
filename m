Return-Path: <linux-kernel+bounces-279230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAF994BAC1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591FD288002
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCAB189F59;
	Thu,  8 Aug 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fjh8Ejxs"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9730184526
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112461; cv=none; b=PsQBXagB1A/wrH9oRcNXIkDWtMtpED2zoTyENVtfF4t8aVYwdfYv2xCJjHctNoM2cXXLTIdpGW0HuZTwH48p3pJnsF/9+I3LvsXaH0rus1+vorz5geAdX01PKr/2N7SGDmHjBRds0xg05qOojllKt9aVpvbRzJzmf3p2Lz+JpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112461; c=relaxed/simple;
	bh=+QbjV7V74FmlcndIROSiCfczbHt4V/u9ib1DRriPGfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=If43/ch7ge7yZubtQFVftDdOHSG9JpBsqi3O4LnY3zZYAKlWE0K1e5jNep840nubw6rgIIp35xBWBrzkiaU2YQT91KuHdLxXevDiIkVQX6Vq4mYyRlnjlqLYm8mBoYJw60DqUDpT94MHtZltB0Jn6PblJ1ECKIkoF73/LfZ2g2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fjh8Ejxs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a8553db90so96970066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 03:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723112458; x=1723717258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjbY9LnQLbutSe6h09pQ5dRYk+5NQr/p3mX4BdB4wQY=;
        b=Fjh8EjxsViIdgozFKhYnPB51vZ259NdRJiJIn5FXKqnrK2lZW0+J/wjjYIVhLfeqUc
         Wtnh0omXdJ2LEkarWa0vZQI3mlPPJT/bupQzhRpRBZDNaouA25jtYYGvLexVrXILr7OV
         Jv01Wlr8Sfu1MQ4Pp2exFBdL1xJKAT3IrDkAdO1OEqqdxOqjJxpCjGAjBloP3cDky1of
         SXTaCaH1j86k/udXthWHDtsEOoRn/0HOOdPz8lIq2DB8Eei1AItwjeYchGqGjIUIreKU
         jc59rb95Bpdw3kfrJwfGqJ/b3cPHA6AbkvQkCC7PUMHTbFyPe/MpC0XOkatBXs2Y0XII
         vQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723112458; x=1723717258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjbY9LnQLbutSe6h09pQ5dRYk+5NQr/p3mX4BdB4wQY=;
        b=pdXPZU+Bmf1DyJYcxJmjdRM4Oz1F4Rs3MWalSklDtQb8TqJE0vnudoKonjEd+CQ8ig
         EKETqyHhEdP1e+aqh1FinD/YM7oiPE3WfQevDbFAsTpeqw9kTLqGuilhUaFA6T/7J3TE
         pMQf/CSDkWMhNzH6+OZhlyAHuXCQU8HXakAsyyaBwRvNryx77X0SCQzQEscR76lvML7r
         Vzg0o8UtI8904okpggA1sMMfkRsL6Wcbt/21RYvsUdwH47MIS+tBTb0ViM++83gb6BPz
         R9ZTCBA0suJ/+UItSmVAaM12rDW7LYo5miJxploRgRimN3eYO/I86dN5k+7VQ8h/7Ba3
         dzFA==
X-Forwarded-Encrypted: i=1; AJvYcCUrwW78dCHz+pD/iQmnYih2VvC8/1ojmjT94eEouPEfvsarUrZBNLQOmirTGcinLigkyiMmrrg0yaPpG7G7umo2fAaA9bv7lASjzkh2
X-Gm-Message-State: AOJu0YzzSKANqd/0nsA2wpz2cJ0Yt3mYDpfYjOvfDYo7wLGqMN+Q+DwD
	7VqJeo1vcZ/iG5IR/zsAcZbVvmiunS+vHYPA42gfIL/Zhz2I+/Q1m922PZxeeuE=
X-Google-Smtp-Source: AGHT+IGt5emtBrWgdy8SSYZYlV0d869w/JvaLmuRfPLKVv+LBGh2tvll7OMouxkEA25eOZNenA3J3A==
X-Received: by 2002:a17:907:1b13:b0:a7a:bc34:a4c8 with SMTP id a640c23a62f3a-a8090f35272mr99329666b.69.1723112457842;
        Thu, 08 Aug 2024 03:20:57 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d88741sm729110666b.150.2024.08.08.03.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 03:20:57 -0700 (PDT)
Date: Thu, 8 Aug 2024 12:20:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
	nathan@kernel.org, morbo@google.com, justinstitt@google.com,
	mcgrof@kernel.org, thunder.leizhen@huawei.com, kees@kernel.org,
	kernel-team@meta.com, mmaurer@google.com, samitolvanen@google.com,
	mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2 2/3] kallsyms: Add APIs to match symbol without .XXXX
 suffix.
Message-ID: <ZrScBzRRTB--q7Y-@pathway.suse.cz>
References: <20240802210836.2210140-1-song@kernel.org>
 <20240802210836.2210140-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802210836.2210140-3-song@kernel.org>

On Fri 2024-08-02 14:08:34, Song Liu wrote:
> With CONFIG_LTO_CLANG=y, the compiler may add suffix to function names
> to avoid duplication. This causes confusion with users of kallsyms.
> On one hand, users like livepatch are required to match the symbols
> exactly. On the other hand, users like kprobe would like to match to
> original function names.
> 
> Solve this by splitting kallsyms APIs. Specifically, existing APIs now
> should match the symbols exactly. Add two APIs that match only the part
> without .XXXX suffix. Specifically, the following two APIs are added.
> 
> 1. kallsyms_lookup_name_without_suffix()
> 2. kallsyms_on_each_match_symbol_without_suffix()
> 
> These APIs will be used by kprobe.
> 
> Also cleanup some code and update kallsyms_selftests accordingly.
> 
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -164,30 +164,27 @@ static void cleanup_symbol_name(char *s)
>  {
>  	char *res;
>  
> -	if (!IS_ENABLED(CONFIG_LTO_CLANG))
> -		return;
> -
>  	/*
>  	 * LLVM appends various suffixes for local functions and variables that
>  	 * must be promoted to global scope as part of LTO.  This can break
>  	 * hooking of static functions with kprobes. '.' is not a valid
> -	 * character in an identifier in C. Suffixes only in LLVM LTO observed:
> -	 * - foo.llvm.[0-9a-f]+
> +	 * character in an identifier in C, so we can just remove the
> +	 * suffix.
>  	 */
> -	res = strstr(s, ".llvm.");
> +	res = strstr(s, ".");

IMHO, we should not remove the suffixes like .constprop*, .part*,
.isra*. They implement a special optimized variant of the function.
It is not longer the original full-featured one.

>  	if (res)
>  		*res = '\0';
>  
>  	return;
>  }
>  
> -static int compare_symbol_name(const char *name, char *namebuf)
> +static int compare_symbol_name(const char *name, char *namebuf, bool exact_match)
>  {
> -	/* The kallsyms_seqs_of_names is sorted based on names after
> -	 * cleanup_symbol_name() (see scripts/kallsyms.c) if clang lto is enabled.
> -	 * To ensure correct bisection in kallsyms_lookup_names(), do
> -	 * cleanup_symbol_name(namebuf) before comparing name and namebuf.
> -	 */
> +	int ret = strcmp(name, namebuf);
> +
> +	if (exact_match || !ret)
> +		return ret;
> +
>  	cleanup_symbol_name(namebuf);
>  	return strcmp(name, namebuf);
>  }
> @@ -204,13 +201,17 @@ static unsigned int get_symbol_seq(int index)
>  
>  static int kallsyms_lookup_names(const char *name,
>  				 unsigned int *start,
> -				 unsigned int *end)
> +				 unsigned int *end,
> +				 bool exact_match)
>  {
>  	int ret;
>  	int low, mid, high;
>  	unsigned int seq, off;
>  	char namebuf[KSYM_NAME_LEN];
>  
> +	if (!IS_ENABLED(CONFIG_LTO_CLANG))
> +		exact_match = true;

IMHO, this is very a bad design. It causes that

     kallsyms_on_each_match_symbol_without_suffix(,,, false);

does not longer work as expected. It creates a hard to maintain
code. The code does not do what it looks like.

The caller should decide whether it wants to ignore the suffix or no.
And this function should always respect the @exact_match parameter value.

> +
>  	low = 0;
>  	high = kallsyms_num_syms - 1;
>  

Best Regards,
Petr

