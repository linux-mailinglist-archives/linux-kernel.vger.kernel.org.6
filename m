Return-Path: <linux-kernel+bounces-563696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F86EA646C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27195188E37E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B541A3142;
	Mon, 17 Mar 2025 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38rCp8Jz"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6E156F4A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202911; cv=none; b=X1Xk7VIo/eRiI48ic9dXGRJ7AYTMM1FIVsYbR+8mPy+b2GXJuKGduRjZGS8j8RwoF0yb6Fvv61Ob8wJLkw52nS+K0J3yU8QLUP51hB0O5UNRXQWVzo2uK04yO7YyS/JOxBPv6/ep78svIakw9TzFe6VbyBPEJRAUol5xrg3v11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202911; c=relaxed/simple;
	bh=rlB9n2CJZjx5EBI9waKftcdpZdgT3/guzWWKKxaPvu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir8BDIA5lJoXObiL1tZ/5McW+RVLlmOlf1QPC1Q1ldsf31m3Ge/D+Tyn6RtfD7Fi87LwNwl+wxTpm6yu3GX07yzLhhSlXJVKroYgUZs5xhC9UkdPGgu94bs0Vc/36xSX2TsIIlLHUrXzuKBP7rUk3M+WaEwoKZjQzya3unDYlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38rCp8Jz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfe808908so70835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742202908; x=1742807708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0W7LYnBoFD9RyJswEHj6z0sY1snq1IW4WXf6ELyhrs=;
        b=38rCp8JzlDSYuiItNFZ5gU9ybbJWR9/s5SyKs12S87jg5AQIUMCnOVNcckwdrLENlr
         /9Fs+2sV2AhDhwmygnJH7D/DIlL2NC5+R4Qf+X0KUE7RDx/KisYgUmDRev2QOpSJOxpD
         OM/sxSHp1eHES7uhLFIEM8uoAyt0U03i4yxlycUP7VmNnyoFkT8CpO6Ku4HMFWC2OtaJ
         HWU49woJo44eF0ILwk5pHhhjPrFD3W1t/fB9ZZWMT8O1dAybBjTp2gow7d2Ot+AcWRQd
         H2JISmSzFGSfzbW//bHNDTceUY8qip/INU/0PD6BStaMN73PMtlYepU4KdB+CQ6dh/w3
         0Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742202908; x=1742807708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0W7LYnBoFD9RyJswEHj6z0sY1snq1IW4WXf6ELyhrs=;
        b=bfip5GW7dg2bqKvT2dpjjWmt8sVUkbTkn+LqYAD8MqDeEffjlk71xrLMvyCHbj2D/h
         sJ0btdvKF7yxH8OP9RYZOd3mNhBbd4eu2IgfP0KO8PVKSEZyl9uOSUil8u3DLum0C5mt
         r+cbooazR1uXmCcKB3q25qetUr7pXOvr43ngENjabgMQPX+5C5mazKVzjOjdCpI7O6s0
         SSS5DT3EtN6iOzfqwXrWWJ2B9n0VDkEnCRZxAiQPWxq8QKtUg87iLCKB61sBUk7cGGQR
         xJiTExrqyGPyT57yz6iQeDIIAErI7J8Fw89+nu/ZJE4dLd5bNje5wac2OWf5dxvKUsJA
         q2qg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/MKRW15CcdNpMNWgju9I3YR7tIAVs7oJ2oeDiswOhBNhwjRruCDoBmd8+f+uYbQxa3B4SBpc/toXzFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUkdXaOudc48v1qnMf4DFbhxAZnBeuUNT3LZxKO31cE3di/Ipp
	6sTJ3sU6mxjcLj0p3GSNSFMewQQqwaFHRuFCcoI6duU13X6ThNCgL8JaYWkNeg==
X-Gm-Gg: ASbGncsTvfPSQ+DJ7Z2MVjFGLKhIFbrnFcKXF7gamTI/a0wchCKLuHJ2xePtk4Hrt6+
	eTZP+UkxbCJSx2Role53v3PVr7A+GodC8vG2oTwcGoudeWa3VpZCgC6hQE+VVeVw09P2Gy2ZW9f
	Hb9OJePJiuN7o4CzsdfPbmhsH3lGe3yG58GKQzonxTg5ZrkOf18EmgSPRGzHG53zlRt0aqIptyU
	KYZd7BoHVmNTRg9arSNJNgnY77mzdG2vWfsx31NIRir64cOYNp0jSlECuZGMj/kVwsaBJFO0zCM
	Kgcd26kmL0jw9thRQWBMlpkuKqjAbigGM9KHqSygIDSFcuFdqjRLeoF2ii7totAF/bWyhm9qAuw
	SgpdDIgI=
X-Google-Smtp-Source: AGHT+IHvVUwhVL5MUfYvngoxF2mTEf4oGKZh9oFqpDcR8dS74JF4reJ9jEFgJFgr3N77YO615vgp1w==
X-Received: by 2002:a05:600c:1792:b0:43d:169e:4d75 with SMTP id 5b1f17b1804b1-43d25ba7c5bmr2371875e9.1.1742202907902;
        Mon, 17 Mar 2025 02:15:07 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb62ccsm99230645e9.7.2025.03.17.02.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:15:06 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:15:02 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 05/13] objtool: Increase per-function WARN_FUNC() rate
 limit
Message-ID: <Z9foFvqpmo0nX1XP@google.com>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <aec318d66c037a51c9f376d6fb0e8ff32812a037.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec318d66c037a51c9f376d6fb0e8ff32812a037.1741975349.git.jpoimboe@kernel.org>

On Fri, Mar 14, 2025 at 12:29:03PM -0700, Josh Poimboeuf wrote:
> Increase the per-function WARN_FUNC() rate limit from 1 to 2.  If the
> number of warnings for a given function goes beyond 2, print "skipping
> duplicate warning(s)".  This helps root out additional warnings in a
> function that might be hiding behind the first one.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/check.c                |  2 +-
>  tools/objtool/include/objtool/elf.h  |  2 +-
>  tools/objtool/include/objtool/warn.h | 14 +++++++++++---
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 6b9ad3afe389..3ddaefe97f55 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4528,7 +4528,7 @@ static int disas_warned_funcs(struct objtool_file *file)
>  	char *funcs = NULL, *tmp;
>  
>  	for_each_sym(file, sym) {
> -		if (sym->warned) {
> +		if (sym->warnings) {
>  			if (!funcs) {
>  				funcs = malloc(strlen(sym->name) + 1);
>  				strcpy(funcs, sym->name);
> diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
> index d7e815c2fd15..223ac1c24b90 100644
> --- a/tools/objtool/include/objtool/elf.h
> +++ b/tools/objtool/include/objtool/elf.h
> @@ -65,10 +65,10 @@ struct symbol {
>  	u8 return_thunk      : 1;
>  	u8 fentry            : 1;
>  	u8 profiling_func    : 1;
> -	u8 warned	     : 1;
>  	u8 embedded_insn     : 1;
>  	u8 local_label       : 1;
>  	u8 frame_pointer     : 1;
> +	u8 warnings	     : 2;
>  	struct list_head pv_target;
>  	struct reloc *relocs;
>  };
> diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
> index ac04d3fe4dd9..6180288927fd 100644
> --- a/tools/objtool/include/objtool/warn.h
> +++ b/tools/objtool/include/objtool/warn.h
> @@ -53,14 +53,22 @@ static inline char *offstr(struct section *sec, unsigned long offset)
>  	free(_str);					\
>  })
>  
> +#define WARN_LIMIT 2
> +
>  #define WARN_INSN(insn, format, ...)					\
>  ({									\
>  	struct instruction *_insn = (insn);				\
> -	if (!_insn->sym || !_insn->sym->warned)				\
> +	BUILD_BUG_ON(WARN_LIMIT > 2);					\

Shouldn't this be >3? Anyway, I think it would be clearer if the
coupling was more explicit, e.g:

diff --git i/tools/objtool/include/objtool/elf.h w/tools/objtool/include/objtool/elf.h
index 223ac1c24b90..a86e43d2056f 100644
--- i/tools/objtool/include/objtool/elf.h
+++ w/tools/objtool/include/objtool/elf.h
@@ -46,6 +46,8 @@ struct section {
        struct reloc *relocs;
 };

+#define STRUCT_SYMBOL_WARNING_BITS 2
+
 struct symbol {
        struct list_head list;
        struct rb_node node;
@@ -68,7 +70,7 @@ struct symbol {
        u8 embedded_insn     : 1;
        u8 local_label       : 1;
        u8 frame_pointer     : 1;
-       u8 warnings          : 2;
+       u8 warnings          : STRUCT_SYMBOL_WARNING_BITS;
        struct list_head pv_target;
        struct reloc *relocs;
 };
diff --git i/tools/objtool/include/objtool/warn.h w/tools/objtool/include/objtool/warn.h
index e72b9d630551..2fba6866fd2d 100644
--- i/tools/objtool/include/objtool/warn.h
+++ w/tools/objtool/include/objtool/warn.h
@@ -56,6 +56,7 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 })

 #define WARN_LIMIT 2
+static_assert(WARN_LIMIT < (1 << STRUCT_SYMBOL_WARNING_BITS), "symbol.warnings too small");

 #define WARN_INSN(insn, format, ...)                                   \
 ({


Or just drop the bitfield (surely it can't be that important to save a
byte here?) and use sizeof, e.g:

BUILD_BUG_ON(ilog2(WARN_LIMIT) > sizeof(_insn->sym->warnings));

