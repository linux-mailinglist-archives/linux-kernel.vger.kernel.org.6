Return-Path: <linux-kernel+bounces-539544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A6FA4A5AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58FFA7A7096
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00091DE4F1;
	Fri, 28 Feb 2025 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wBClVgkx"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB81DE3BC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780511; cv=none; b=EajRq5FcOEfg5Ep0Hy2DKQXos+Jl4fsZFH8g/L5X4RQkzc3V7SgbsYctWUTk94PsA4d2zbB9LxUspM6XrUrOckdf1RVvpu5z/Wjc6j31AisS9KbkI2PHeD0Wrd92oaMP2sQHRf2HmJii5eVzboKH/ZEu/+2u2n67jwg3I2ZrulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780511; c=relaxed/simple;
	bh=UHyXyHGxaFKOCU+wBk/h3HQB02PoKJ+t3n/8GjE07vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0VVkDaOAE4in1AzXFHnT4sBDb6bIJT80tQx+qzVDE+I2bE5msNxMBiAYUQB3pXgVsM08ir1NcUvvTdMlicCUXpghS3xLPhvoc/KJ8/cx+V2wpyjaA5LbL91T3NGtXjPsbQarqqmgO81f6JpnhsqqZV3xOoEsiXUSCKg8G19ve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wBClVgkx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2235c5818a3so4600325ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740780509; x=1741385309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BD+w6VMpAnn3IS97d9vhggATREKLnYXv4vSMZfUVh4=;
        b=wBClVgkxjF5xbFaFj27kgwYE72GgUHcEyzgN4FdjRk5iCc3YaXQEil2uR4J4CX3f5z
         zTzBjnSfsPQOsKW2y9IfU4oR7EZb4hBBg8U/p57xwmyBazxGP8d86nUdf6fMY3pPccmu
         kUJyDu1m1OOiaClD58XXiXG5iMD0shpzNmm6wQEtSYEj3lUo9hHAVfa96SSHn2wkWK+B
         Bxhr2TLtaMKTwgAUqmP8qjVpgutkKSMsF9tigxgjUbA+sZRIxm0nJ3jn0P3qhEELCTpE
         Y/FF8755s6MRmBKr+VmiqWu63dquX2ek7Vgn6nmeX6hPRl+2wVk/wdBB8u7zSL5CHUm8
         VoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740780509; x=1741385309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BD+w6VMpAnn3IS97d9vhggATREKLnYXv4vSMZfUVh4=;
        b=qpHV1fuqPfjBDAtgsVliS1GN4sh4PCTwmF7e77gJCu+dSJOMUJZPlyX87lcgNzQ8Yg
         N3ZSIXZe4UgNVcHng7fmKN7/1A5jLxMiLGiERrqgWVJYeQnyays/25HnVELkYkhPz1zC
         UAmdxYlpJsj5sP5t3lu5DVTOHsXGksS8SpCQY/qFeIDvIGpRwoXd2pSMKoF9dG+DsDlB
         VXsX2ezsA/w/9kpeIf0mlm2byAtpxYBfBH60xkN4mBT21LUazeG5/zYpoxYLdnUe/vur
         /D2z5IfFSvpSvojM3q0B49n0ReR0OOUaA/o3nntdZHO81txa3D1jvU19gKyndw79yIux
         /O3g==
X-Forwarded-Encrypted: i=1; AJvYcCWnRL3/FoBPPfQEtSgYNCJvnMnl7mbfFiX3ZhKeVngDoJcjeh0MZ+RD6xeuGwgF6rRupUwX4u5sq7cDdv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9lI95/jKHA/KbMH9vvOEJl8tZWY1OhjlvSAh6E97+pqyFS6qq
	P4JwuQ02R6lzY6NmbJI+ijCmzxvbSzRRyKhNd1Y3eSLLNKHHDYamGMpas6bhpmw=
X-Gm-Gg: ASbGncvqTieTazsknkEKhP52PKGIELCeX3O3xcbsQ0Y8WcVUh/z590MmY/ITU7sXqAr
	Hmkchr+bKv+k32wskddSymDfAUT3ZKdix4dxZcbHC/F5nxz69TCfJsXmpFdtVMHKBPdTvj03Uqx
	HQjZD/YuCW+PUX4Rhh0MUD0kQUmCmwTlM6Rfx+Gsp28ZDZc4Yn22auJ/u2Ipdrj8pmrMnpEQsnj
	aZWWhKh3XEMOYzNaLg2qB5+M1wdUD1PJE548WVpYWV5ML3gWCjQv+duCkW4FASmK77NuYSfe80U
	RRiJpGoNJDqya9kOHrPwSYA5bDEkXMnYHTju1oyg
X-Google-Smtp-Source: AGHT+IERVixQDZRmXy6YmTgIKl4r0DNokCo4tKImYTz6bKxMaR3nQyLm/o/mOg01P8iD7ItgEE71jQ==
X-Received: by 2002:a05:6a20:734a:b0:1f0:e808:42ee with SMTP id adf61e73a8af0-1f2f4e01892mr7482416637.42.1740780508698;
        Fri, 28 Feb 2025 14:08:28 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:6935:f301:4e47:2b68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a005fd15sm4277261b3a.168.2025.02.28.14.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 14:08:27 -0800 (PST)
Date: Fri, 28 Feb 2025 14:08:24 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: fix in-tree build
Message-ID: <Z8Iz2JPpqer00aZ_@ghost>
References: <20250124-perf-fix-intree-build-v1-1-485dd7a855e4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124-perf-fix-intree-build-v1-1-485dd7a855e4@bootlin.com>

On Fri, Jan 24, 2025 at 02:06:08PM +0100, Luca Ceresoli wrote:
> Building perf in-tree is broken after commit 890a1961c812 ("perf tools:
> Create source symlink in perf object dir") which added a 'source' symlink
> in the output dir pointing to the source dir.
> 
> With in-tree builds, the added 'SOURCE = ...' line is executed multiple
> times (I observed 2 during the build plus 2 during installation). This is a
> minor inefficiency, in theory not harmful because symlink creation is
> assumed to be idempotent. But it is not.
> 
> Considering with in-tree builds:
> 
>   srctree=/absolute/path/to/linux
>    OUTPUT=/absolute/path/to/linux/tools/perf
> 
> here's what happens:
> 
>  1. ln -sf $(srctree)/tools/perf $(OUTPUT)/source
>     -> creates /absolute/path/to/linux/tools/perf/source
>        link to /absolute/path/to/linux/tools/perf
>     => OK, that's what was intended
>  2. ln -sf $(srctree)/tools/perf $(OUTPUT)/source   # same command as 1
>     -> creates /absolute/path/to/linux/tools/perf/perf
>        link to /absolute/path/to/linux/tools/perf
>     => Not what was intended, not idempotent
>  3. Now the build _should_ create the 'perf' executable, but it fails
> 
> The reason is the tricky 'ln' command line. At the first invocation 'ln'
> uses the 1st form:
> 
>        ln [OPTION]... [-T] TARGET LINK_NAME
> 
> and creates a link to TARGET *called LINK_NAME*.
> 
> At the second invocation $(OUTPUT)/source exists, so 'ln' uses the 3rd
> form:
> 
>        ln [OPTION]... TARGET... DIRECTORY
> 
> and creates a link to TARGET *called TARGET* inside DIRECTORY.
> 
> Fix by adding --no-dereference to "treat LINK_NAME as a normal file if it
> is a symbolic link to a directory", as the manpage says.
> 
> Link: https://lore.kernel.org/all/20241125182506.38af9907@booty/
> Fixes: 890a1961c812 ("perf tools: Create source symlink in perf object dir")
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d74241a151313bd09101aabb5d765a5a0a6efc84..bbd799a0fd544db220f29d1e250a819a765d04f3 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -164,7 +164,7 @@ ifneq ($(OUTPUT),)
>  VPATH += $(OUTPUT)
>  export VPATH
>  # create symlink to the original source
> -SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
> +SOURCE := $(shell ln -sf --no-dereference $(srctree)/tools/perf $(OUTPUT)/source)

The kernel Makefile has:
	$(Q)ln -fsn $(srcroot) source

So for parity the --no-dereference could become `n`, but it doesn't
really matter.

>  endif
>  
>  ifeq ($(V),1)
> 
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250124-perf-fix-intree-build-fbd97f560254
> 
> Best regards,
> -- 
> Luca Ceresoli <luca.ceresoli@bootlin.com>
> 

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>


