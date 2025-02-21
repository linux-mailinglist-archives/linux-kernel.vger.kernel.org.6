Return-Path: <linux-kernel+bounces-525606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB2BA3F22A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C9B3B881F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC22054E9;
	Fri, 21 Feb 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bAzDBYIr"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC3205AB0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133786; cv=none; b=YbfeAmpmb90kwuhBTj5ZzaL93UPw1ERcCBXVj/lmo5yNVfHD/0oOz8UpTtDFqruQr0OED3wbk8c5Zfp8vWuVQgvg781CTaWYGzmco+R/NlnP17CBggbwdDxQ6TOc4SL6Bfhf8xEJPufQG4r0A7gk02jCqvayr7jMhrpAc+ClGb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133786; c=relaxed/simple;
	bh=h3ApYvzKTccF1XnzB7gk+k2ClnVcJjmA56TFYSxYExU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I4OGieiWoBxe8+fyvFH5gZy+Y4kQdrVMiTnvFHnujGF7IloJ9D4IPlh6sqOxP7/rBMlciER6Ga2skB2D02UYlRicrjy16dH+aCSrr56ts/z9ypPx4Dh0buaRZKjlx4a8v2s0oBOpfoqPw/N972t2LgLREIN5/5OFfskL49JOfbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=bAzDBYIr; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30761be8fcfso17629611fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1740133781; x=1740738581; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBgTd9yS8bHj2inA4KCI/wGm8uZFJ13xmrkCLQobpyg=;
        b=bAzDBYIrwE92+mtrgAOBk90lUvMK5y7/VoRAed5bOuogGf3/t25VpidxhE+llYOKqa
         mPOEZCovZuOAfqJrw+gvAdcwtVB7nwQ+6nODua6uxyErvnm1rzYefznV1RUgG9vUJcc3
         ZcPHMRL5FGgsuyxGX6LBw3yXODh2wdn5n4WmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740133781; x=1740738581;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBgTd9yS8bHj2inA4KCI/wGm8uZFJ13xmrkCLQobpyg=;
        b=oltxP4b2lMcCMHlvJNghLlkyNHAcPRpUMVjbLOL/k3ym3ooFv/F1GYUEHdjhkggLNX
         YJ2psVP9RigaLv8XsjGNcop5Mr4UNvERstEz344Zey9MPPHLa2Cq8nWsVLKQEfvNP+Ia
         78dfSnv89mZTp+6MwG618thQCip+uKvzx/8P+t4M24+q1nv1kD4b8svVKLgpBOad0e5K
         tUYD3CIgry8gAe0AORqD7nQHtN0/plnPnJfkM/DxH9T46yT6wZStnbEP7fqJ8s3PIlA5
         xAfA2w/IQQ0Hr+JFH17vgPcf3etDwoftwTyJ/ue5H8kgZpjJSSO6THV7IY53frRVeQXB
         /kSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkP6rfZufNsIsFHhNQ3NW9OenVb1XGJuI3sKK7fDoFhRDQK6/nCbUTK94uB8uo5xl/wA8Xc0PgddVBUcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4Sb2389yDhwv67JitOOuOdPgehohOXjx+uJELvJ3cowOxhTA
	gRimPFkzeR9vRXNWMFMUQC/k+4DgmdIuFbFT6K5ZOs1tpwtl9Nq+CM0oO0gnDMk=
X-Gm-Gg: ASbGncth+v+L0q152ih908IBX5qNfMkfKuny0h5d+lx4Sey/Qd30mafVLojFwqrdWge
	HDz8XPCv6BX+RzbXwEeh6RjmJLqpoENIOXN7wMrEyf+SyP/Hw87848o9Hu6803yQ0b41TvyzVEd
	/isbq6Dc6lwPRNB8NtKAfaaCGwoerXIG6hfjcIprH+IUwiEqw5glEL+lf/j2CRix8B4c+ai3dlC
	1EafIXixn0Fg21sx9l1oXPT/RXdi9Edfx6hQdGS9t53TjHtZmpWFQiSpTdsJrZDd998J1l+3O0G
	IOM0U04G0nEYAgsl8vyzX2q5Re4=
X-Google-Smtp-Source: AGHT+IEUOdqdqFnuqPXA4cgWINcdgxUl8JQ3ygr09PQ43kzULiZT56Khi3z1J3sj7fkaU8oDV/YSHQ==
X-Received: by 2002:a05:651c:2120:b0:309:1f98:2848 with SMTP id 38308e7fff4ca-30a598e2984mr10302661fa.19.1740133781115;
        Fri, 21 Feb 2025 02:29:41 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-30a449aa148sm8429891fa.109.2025.02.21.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:29:40 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk> 
To: Aditya Garg <gargaditya08@live.com>
Cc: "pmladek@suse.com" <pmladek@suse.com>,  "rostedt@goodmis.org"
 <rostedt@goodmis.org>,  "andriy.shevchenko@linux.intel.com"
 <andriy.shevchenko@linux.intel.com>,  "senozhatsky@chromium.org"
 <senozhatsky@chromium.org>,  "corbet@lwn.net" <corbet@lwn.net>,
  "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
  "mripard@kernel.org" <mripard@kernel.org>,  "tzimmermann@suse.de"
 <tzimmermann@suse.de>,  "airlied@gmail.com" <airlied@gmail.com>,
  "simona@ffwll.ch" <simona@ffwll.ch>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  "apw@canonical.com" <apw@canonical.com>,
  "joe@perches.com" <joe@perches.com>,  "dwaipayanray1@gmail.com"
 <dwaipayanray1@gmail.com>,  "lukas.bulwahn@gmail.com"
 <lukas.bulwahn@gmail.com>,  "sumit.semwal@linaro.org"
 <sumit.semwal@linaro.org>,  "christian.koenig@amd.com"
 <christian.koenig@amd.com>,  "kekrby@gmail.com" <kekrby@gmail.com>,
  "admin@kodeit.net" <admin@kodeit.net>,  Orlando Chamberlain
 <orlandoch.dev@gmail.com>,  "evepolonium@gmail.com"
 <evepolonium@gmail.com>,  "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>,  "linux-media@vger.kernel.org"
 <linux-media@vger.kernel.org>,  "linaro-mm-sig@lists.linaro.org"
 <linaro-mm-sig@lists.linaro.org>,  Hector Martin <marcan@marcan.st>,
  "linux@armlinux.org.uk" <linux@armlinux.org.uk>,  "asahi@lists.linux.dev"
 <asahi@lists.linux.dev>,  Sven Peter <sven@svenpeter.dev>,  Janne Grunau
 <j@jannau.net>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
In-Reply-To: <C66F35BB-2ECC-4DB8-8154-DEC5177967ED@live.com> (Aditya Garg's
	message of "Thu, 20 Feb 2025 16:39:23 +0000")
References: <716BCB0A-785B-463A-86C2-94BD66D5D22E@live.com>
	<C66F35BB-2ECC-4DB8-8154-DEC5177967ED@live.com>
Date: Fri, 21 Feb 2025 11:29:40 +0100
Message-ID: <871pvrpp4b.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 20 2025, Aditya Garg <gargaditya08@live.com> wrote:

> v2 -> Add this patch
>  Documentation/core-api/printk-formats.rst | 32 +++++++++++++++++++
>  lib/test_printf.c                         | 39 +++++++++++++++++++----
>  lib/vsprintf.c                            | 38 ++++++++++++++++++----

Yay! Thanks for remembering to include test cases.

>  
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 59dbe4f9a..ee860327e 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -776,21 +776,46 @@ static void __init fwnode_pointer(void)
>  	software_node_unregister_node_group(group);
>  }
>  
> +struct fourcc_struct {
> +	u32 code;
> +	const char *str;
> +};
> +
> +static void __init fourcc_pointer_test(const struct fourcc_struct *fc, size_t n,
> +				       const char *fmt)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < n; i++)
> +		test(fc[i].str, fmt, &fc[i].code);
> +}
> +
>  static void __init fourcc_pointer(void)
>  {
> -	struct {
> -		u32 code;
> -		char *str;
> -	} const try[] = {
> +	struct fourcc_struct const try_cc[] = {

I know it matches the code it replaces, but kernel style seems to be
"const struct foo" rather than "struct foo const" (at around 130:1) -
just as you use in the new helper function.

Also, please consider changing the array, and the newly added instances,
to be static instead of automatic (our le32_to_cpu should be usable also
for static initializers).

This will conflict with the conversion-to-kunit which is in flight, but
the conflict should be trivial to resolve.

Rasmus

