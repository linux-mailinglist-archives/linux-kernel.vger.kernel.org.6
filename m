Return-Path: <linux-kernel+bounces-378306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E890E9ACE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C411C21836
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D831D151F;
	Wed, 23 Oct 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VmUSM+Gl"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F1D1CC170
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695546; cv=none; b=otOBTRBT36UcRppuj/NUbvfuR+ryF/3ki1XHm5Kxb5/7pIpJvXpnMvOp8jqt6Tj1rxoyTQGUZUpKx7NCIJuGu9LDyxSFddN4cBwQLIJSJR0mFzeAeGRKjUikyw3OerJqFE7YU6EN4tpQtyy4k4ays2XyFKISBUsXW8pzez0wwL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695546; c=relaxed/simple;
	bh=qVcZMLHwHyQhq7MBDvAiHcGYCqm+ZH0H3VY5fyTsc+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFcqHB5abIthEu0kZF+UZoEnEMs9kdnkmG6rf/LckP7f1u86j0qi2PkD04LBOz3nMNQKZrOkykz8m3bTsTPLV0ci7w9X3KfnCLJAMzaAYx0OtPeaSfu788ZmmECLxZzTcdvT7r2ko0fw1tMbtDpMW74xhE1f8tNXkv7gRt9vleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VmUSM+Gl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so8762505a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729695543; x=1730300343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdfhAg7XOG6KB9fpE58iZth2jLApIcWYhDgoIBS8gtw=;
        b=VmUSM+Glq3Kxxdi6a1y56SZzilllSkrkoLejXN4qM6jfcpQb5zMe+H64E94jmdAgzJ
         ga3+5OzUAXYRfoNdBYQMc+swFxzQ5bmUOaWCO8c6bm+K2KWk++09YLAinIddqQZsWjP+
         ceiyWX5GdoPaKmm9ClMYg3d7tdb05vDXemZ4HAONwj6/45b2uyorou7IGMFZy5VdIjrq
         qszTITz4lk20YUcXqIarx0ideYOdZnO0lXIPTy9zDrxzNQXxf5psY31akmwl6vbeA8D+
         +cCkgxnQTHwtIWnmJW3TduycxP/Wt6pSbEEqJ9wTsQE2yGpaIqY0TNHhhbZfpsMYmrva
         OTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729695543; x=1730300343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdfhAg7XOG6KB9fpE58iZth2jLApIcWYhDgoIBS8gtw=;
        b=gfqXXAytoC0MNQsvUdsjcYadEXkLQ6qJ+7zOVWpqaWEOJ+ojr2TfKwX5o8XWMYaU2E
         8KecN5IDU9m6EcdcMbQYMdGe0s+Plvy7swNqEhoiazNlV12ydkzw3fcRhKl/Mhr+aLcC
         ZehhoS0FmGKrpvGWhHjbylZTNU54MNPh/GK64Kn20TH6lLbstbArNSS8sg2nyENcxwNo
         dTLVKTPY1nJEj+uVmZoc+vIVpqB49qj/rBlGLLmUgXG+7+fDugGqVSeF4B9g8ep67ul6
         La183SAacVhVhlAPacSmbYy+fg+gmnLGfR5R9TcvKcAtFEKTYh8wYyhLOXFepReGVCo8
         nqRA==
X-Forwarded-Encrypted: i=1; AJvYcCUGpLB8otsT6A/2CcFNj9NpZ28ctP0sPiI3dcSFZuEcMHjRoWflfLVBUbvRLFXjgjqekzbjXxKvxj4Wp2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLxjz/P0lyrDyguMwogt3dK5tcnLBV6u4dyq2ybXNuxjS35saC
	/FmhcXPPS7rUCGshFOsPkHLa1bR9O8hNTgdyaxphawckU2UgZMFCn/u+NI6cMyc=
X-Google-Smtp-Source: AGHT+IFC1aic+ZWmPBAnotFGoZ7s0fl8OisT/L75WyZvmDcXyVbJaWz0S1S/NSTReRarLlppasFQew==
X-Received: by 2002:a17:906:794c:b0:a9a:4a:284a with SMTP id a640c23a62f3a-a9abf8792bbmr287818566b.26.1729695542525;
        Wed, 23 Oct 2024 07:59:02 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6234sm486571666b.24.2024.10.23.07.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:59:02 -0700 (PDT)
Message-ID: <8017c328-f039-46c3-b472-f203cd6e2cfe@suse.com>
Date: Wed, 23 Oct 2024 16:59:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/19] kbuild: Add gendwarfksyms as an alternative to
 genksyms
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241008183823.36676-21-samitolvanen@google.com>
 <20241008183823.36676-39-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241008183823.36676-39-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 20:38, Sami Tolvanen wrote:
> When MODVERSIONS is enabled, allow selecting gendwarfksyms as the
> implementation, but default to genksyms.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Acked-by: Neal Gompa <neal@gompa.dev>
> ---
>  kernel/module/Kconfig  | 25 ++++++++++++++++++++++++-
>  scripts/Makefile       |  2 +-
>  scripts/Makefile.build | 39 +++++++++++++++++++++++++++++++--------
>  3 files changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> index f9e5f82fa88b..e6b2427e5c19 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -169,13 +169,36 @@ config MODVERSIONS
>  	  make them incompatible with the kernel you are running.  If
>  	  unsure, say N.
>  
> +choice
> +	prompt "Module versioning implementation"
> +	depends on MODVERSIONS
> +	default GENKSYMS
> +	help
> +	  Select the tool used to calculate symbol versions for modules.
> +
> +	  If unsure, select GENKSYMS.
> +
> +config GENKSYMS
> +	bool "genksyms (from source code)"
> +	help
> +	  Calculate symbol versions from pre-processed source code using
> +	  genksyms.
> +
> +	  If unsure, say Y.
> +
>  config GENDWARFKSYMS
> -	bool
> +	bool "gendwarfksyms (from debugging information)"
>  	depends on DEBUG_INFO
>  	# Requires full debugging information, split DWARF not supported.
>  	depends on !DEBUG_INFO_REDUCED && !DEBUG_INFO_SPLIT
>  	# Requires ELF object files.
>  	depends on !LTO
> +	help
> +	  Calculate symbol versions from DWARF debugging information using
> +	  gendwarfksyms. Requires DEBUG_INFO to be enabled.
> +
> +	  If unsure, say N.
> +endchoice
>  
>  config ASM_MODVERSIONS
>  	bool
> diff --git a/scripts/Makefile b/scripts/Makefile
> index d7fec46d38c0..8533f4498885 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -53,7 +53,7 @@ hostprogs += unifdef
>  targets += module.lds
>  
>  subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
> -subdir-$(CONFIG_MODVERSIONS) += genksyms
> +subdir-$(CONFIG_GENKSYMS) += genksyms
>  subdir-$(CONFIG_GENDWARFKSYMS) += gendwarfksyms
>  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
>  subdir-$(CONFIG_SECURITY_IPE) += ipe
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 8f423a1faf50..ae13afb71123 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -107,18 +107,28 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
>  $(obj)/%.i: $(obj)/%.c FORCE
>  	$(call if_changed_dep,cpp_i_c)
>  
> +gendwarfksyms := scripts/gendwarfksyms/gendwarfksyms
> +getexportsymbols = $(NM) $(1) | sed -n 's/.* __export_symbol_\(.*\)/$(2)/p'
> +
>  genksyms = scripts/genksyms/genksyms		\
>  	$(if $(1), -T $(2))			\
>  	$(if $(KBUILD_PRESERVE), -p)		\
>  	-r $(or $(wildcard $(2:.symtypes=.symref)), /dev/null)
>  
>  # These mirror gensymtypes_S and co below, keep them in synch.
> +ifdef CONFIG_GENDWARFKSYMS
> +symtypes_dep_c = $(obj)/%.o
> +cmd_gensymtypes_c = $(if $(skip_gendwarfksyms),,			\
> +	$(call getexportsymbols,$(2:.symtypes=.o),\1) |			\
> +	$(gendwarfksyms) $(2:.symtypes=.o) $(if $(1), --symtypes $(2)))

Is it possible to pass options to gendwarfksyms that apply to the entire
build, specifically, how can one say to use the --stable option? If not
then I think it would be good to add something as
KBUILD_GENDWARFKSYMS_STABLE (similar to KBUILD_PRESERVE), or maybe
a generic GENDWARFKSYMSFLAGS?

-- 
Thanks,
Petr

