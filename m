Return-Path: <linux-kernel+bounces-563755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2B3A647C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137D43B1D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5582224241;
	Mon, 17 Mar 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYM4gSTG"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3222422C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204447; cv=none; b=IY1qFq/6uPB1fD1tba2pLWzmTm0E1nR+vifcXLjG6DVOPa0dMdVk1v4GoDuA96141JO4gmI3+Udo8aeVmUQT7mpWcR3m2DrwYf+H58mOfUNmvPNDUHzOT4ciwSCFYLtBQifCt0x+59VB4PrjjzNHi/rAUAHZkhV6Jfl8TjJ3VQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204447; c=relaxed/simple;
	bh=APl20oLiIyghWxIJdmnWNz+CLL4zbAU4mX+iZPQhSrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqXzzquoNIZDp8CChhnYvqT3hwLQxVWZAhhiwU6DO0q/Drk951fFDgrcu0PR7jcYbz4CeJdPyVu90bUTPeHrcT6qKpsWVOmuUp6gMv9fejDTtdvBFHcKU3TwZBQwPJPuXTIG4/xrTybRKrQ53D0sswjC5TSJShsvSJHRdvwsrIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYM4gSTG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso72545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742204443; x=1742809243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fx3Oeu3j4699U85PosDWVd527QVFHeMBuzA0oVdAb0Y=;
        b=rYM4gSTGQjqZMDhIZc7xetRGzLvSzqd+E2sKag93sFZv7KAbs5axuhzZnWF6V0/opD
         iucOhUMtxa4hoX6dSSpJasV9d9XmQGcbpnmsfj2J0sNHq/f7VKT0T7MVNz9Z74jDGEf4
         8adrQLTVneWsYRILV/dZOrqSZkXuz4mr90yNUIfbGW3MDS5xo2csdc8GRnAq533RBca0
         69dGm1UeeBqlVr0z6AghVXaj7O8B5JfEvWD64TFxLF7sj1XeaOb7DR3KI1J3PgZeLoWO
         rRmpLZt//CSF0N7j36YNWXrxTyT84Xuet5zpbMNyOANUDfT7WCH0bZrzFprf6ehE9nEu
         eLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742204443; x=1742809243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx3Oeu3j4699U85PosDWVd527QVFHeMBuzA0oVdAb0Y=;
        b=o+sRCOHvYBLJqHGzeihHyTVSKoe73vDlru7S9CEMAt3bVX99w0sarCZ6H1WrNAWCbI
         abhAUUogpiyIdVERWVGbOlTRwGp5t58oMrP+x4OBSL3fNL5XE5vnDurPZ8p5dDuJxIv9
         Twnnra6SzAMQRFVOH2HepHkUJLaJ3Eq40qyh/+KjLKkov9ACucQHi0npPueHOGmz38cj
         iA4xgwovrlw8zdNpeTNo/yb5jWkIpnL2r8Csnu/5fBRpCPs4YhR2zVnMeD4FEkZHdmQ8
         IShRnIW+6NvGkmwazUyVPRx2NbnE1flCeoda5pvXDgbN5q/tlIaU5uG/oCFQ6auAYL4W
         uKvw==
X-Forwarded-Encrypted: i=1; AJvYcCUZvTXKafIAEQ+4blsMZZ/V+mdFVbaPEQEQfaGJChdtsgJ+9yGyRY+BZD3mb1XYBWmVWi7vqd4x7XFaT1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ZHKJoyxdF+n20ZcB5rpYjzdWqG+pUQzTCn9tVybuTI7PAD/w
	D4I/8VPKguvahJDemN4SLS7CARlTTCv53c3KKaxCCoxL9pXZQfxADtux6HsdDFSun4AWRmP0DOn
	LjA==
X-Gm-Gg: ASbGnct5Mr9yZLW6ouYzQld00nWWj/XE7iNqRnCThkxQlCigk3aM66fzaqHJQUbX8Jf
	HdqrcqP5cWAGxL7zRoPyc+ygH4M08xNxsd4Ps1Nx8J5bJDM/fc2MYUjsde+B4cg3f+fPaDnqC4p
	/eGOawLb5WyAWS3opseJ8E7WsIB2t4WcBc3gRQ0gXqhfL4gPljF7IK7O+Yl/bcORht65KO9ZscL
	2GYhHTZ8ntmBzlEd3jeE7OZb1/o0O3SbY0dP+CK/eitrQEVTezhhTNAiLbRKJcp09IbeBZXCv0/
	S9MoQOwWBgm+Iw9jwCIAAdk/J0qZDUZLqUUmjoTbEAqTHbHKqQnFlq03fFF+jFLK3CrVVfCAdRG
	+vz/QOIQ=
X-Google-Smtp-Source: AGHT+IH5v8s2bHlKlL500JEplkYzoGW84g5Dei8WSixvWuiLXjxoZviiL1frg/rKzj8j+Yv8YeVE2A==
X-Received: by 2002:a05:600c:4355:b0:43b:bfe9:8b43 with SMTP id 5b1f17b1804b1-43d25562f98mr2347865e9.4.1742204443421;
        Mon, 17 Mar 2025 02:40:43 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df320csm14281091f8f.7.2025.03.17.02.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:40:42 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:40:38 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 09/13] objtool: Add --output option
Message-ID: <Z9fuFphLv5pM7AC_@google.com>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <0da308d42d82b3bbed16a31a72d6bde52afcd6bd.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da308d42d82b3bbed16a31a72d6bde52afcd6bd.1741975349.git.jpoimboe@kernel.org>

On Fri, Mar 14, 2025 at 12:29:07PM -0700, Josh Poimboeuf wrote:
> Add option to allow writing the changed binary to a separate file rather
> than changing it in place.
> 
> Libelf makes this suprisingly hard, so take the easy way out and just
> copy the file before editing it.
> 
> Also steal the -o short option from --orc.  Nobody will notice ;-)
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/builtin-check.c           | 98 ++++++++++++++++++++-----
>  tools/objtool/elf.c                     |  3 -
>  tools/objtool/include/objtool/builtin.h |  1 +
>  tools/objtool/objtool.c                 | 15 ++--
>  tools/objtool/orc_dump.c                |  7 +-
>  5 files changed, 89 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> index 79843512a51b..3de3afa0a19c 100644
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -6,6 +6,10 @@
>  #include <subcmd/parse-options.h>
>  #include <string.h>
>  #include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <sys/sendfile.h>
>  #include <objtool/builtin.h>
>  #include <objtool/objtool.h>
>  
> @@ -14,6 +18,8 @@
>  		"error: objtool: " format "\n",		\
>  		##__VA_ARGS__)
>  
> +const char *objname;
> +
>  struct opts opts;
>  
>  static const char * const check_usage[] = {
> @@ -71,7 +77,7 @@ static const struct option check_options[] = {
>  	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
>  	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
>  	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
> -	OPT_BOOLEAN('o', "orc", &opts.orc, "generate ORC metadata"),
> +	OPT_BOOLEAN(0,   "orc", &opts.orc, "generate ORC metadata"),
>  	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
>  	OPT_BOOLEAN(0,   "rethunk", &opts.rethunk, "validate and annotate rethunk usage"),
>  	OPT_BOOLEAN(0,   "unret", &opts.unret, "validate entry unret placement"),
> @@ -84,15 +90,16 @@ static const struct option check_options[] = {
>  	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
>  
>  	OPT_GROUP("Options:"),
> -	OPT_BOOLEAN(0, "backtrace", &opts.backtrace, "unwind on error"),
> -	OPT_BOOLEAN(0, "backup", &opts.backup, "create .orig files before modification"),
> -	OPT_BOOLEAN(0, "dry-run", &opts.dryrun, "don't write modifications"),
> -	OPT_BOOLEAN(0, "link", &opts.link, "object is a linked object"),
> -	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
> -	OPT_BOOLEAN(0, "mnop", &opts.mnop, "nop out mcount call sites"),
> -	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
> -	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
> -	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
> +	OPT_BOOLEAN(0,   "backtrace", &opts.backtrace, "unwind on error"),
> +	OPT_BOOLEAN(0,   "backup", &opts.backup, "create .orig files before modification"),
> +	OPT_BOOLEAN(0,   "dry-run", &opts.dryrun, "don't write modifications"),
> +	OPT_BOOLEAN(0,   "link", &opts.link, "object is a linked object"),
> +	OPT_BOOLEAN(0,   "module", &opts.module, "object is part of a kernel module"),
> +	OPT_BOOLEAN(0,   "mnop", &opts.mnop, "nop out mcount call sites"),
> +	OPT_BOOLEAN(0,   "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
> +	OPT_STRING('o',  "output", &opts.output, "file", "output file name"),

I think the docstring should say that it edits in place if the option
isn't provided.

> +	OPT_BOOLEAN(0,   "sec-address", &opts.sec_address, "print section addresses in warnings"),
> +	OPT_BOOLEAN(0,   "stats", &opts.stats, "print statistics"),
>  	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
>  
>  	OPT_END(),
> @@ -178,24 +185,75 @@ static bool opts_valid(void)
>  	return false;
>  }
>  
> +static int copy_file(const char *src, const char *dst)
> +{
> +	size_t to_copy, copied;
> +	int dst_fd, src_fd;
> +	struct stat stat;
> +	off_t offset = 0;
> +
> +	src_fd = open(src, O_RDONLY);
> +	if (src_fd == -1) {
> +		ERROR("can't open '%s' for reading", src);
> +		return 1;
> +	}
> +
> +	dst_fd = open(dst, O_WRONLY | O_CREAT | O_TRUNC);
> +	if (dst_fd == -1) {
> +		ERROR("can't open '%s' for writing", dst);

Please include strerror(errno) here and above.

> +		return 1;

The annoying pedantry demon on my shoulder is compelling me to point
out that this and the following error returns leak file descriptors.

To be honest, I don't care in the slightest whether or not this "bug"
gets "fixed" but at least I quelled my pedantry demon by pointing it
out.

