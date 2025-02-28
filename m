Return-Path: <linux-kernel+bounces-539522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C04A4A57B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2563AFF0A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C6B1DE2C4;
	Fri, 28 Feb 2025 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tk8eYh1k"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFCD23F388
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779943; cv=none; b=L4VpNgpLvaIHdMVASDbVYwSvXVoR2Nmw8VVs15LRlIO1bn0y1GOa0AkkKye91nJQQK6YACdNc2wptzoVjxlVqSzOOV5OfxjZZwxIbJvaaeavmC0uOni6ccfNZBQ26bl9RmhzNZiFTG1wxsis0Jd8Cvcx9Oh70UcRRnFD7DgxYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779943; c=relaxed/simple;
	bh=FXmF3PiNKKcWPPr+aQeb8jG3PSOC/Qb2ar8qg97uGAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0GRaggIa4BUTGXndLYY5jdj5POGHXq02elv5o/Ewou/CUnLpGQOWIFgMzX7fAG4djswZRDPgzrvlfFV4qoZ3K7o/nDvqdlEHIZ+SU5RJlwhA93LclHOOEBPALT0O66N2YC4dQtPqf+2a2d6uMxBnF4J7SjHNYhOngQ4FHlmCSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tk8eYh1k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22185cddbffso65796105ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740779940; x=1741384740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htwmJPr5T2uqdai6eVyfL3xJDIabMmOP4IMOsJVBxhE=;
        b=tk8eYh1kpwPV105V1MxG8v4pbJ1Y9jP9bILd8dBquvHDdDKqfbhXzzsI7l+HuCAxKz
         NxkZSxVTra8SLFY6V2nWlj47Cw+D+Mox9fpkhUEFJNr+Ud8mqXPLtCVwT+ZaFCGF6whG
         jq2V7GbVbGBjY08neVVg9SNhR14xtRm6N7KPFkPvaP5bbN+g41d3Q/EUbA2QFjKwbRlu
         HJqnX84jANpoufAsW/IbQG6aohBdnjlSfEm2DPST7pfpd0DnE5yG6L8dgo/yQAcA2EON
         PrIwJrFg9Gj1azij6SJJ4Fo8jd1LLPSOgMf43XQwozvg8fzjbBalphBTtcVud29c6AIL
         3WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740779940; x=1741384740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htwmJPr5T2uqdai6eVyfL3xJDIabMmOP4IMOsJVBxhE=;
        b=qbruwwFlfUdCfkUT5KgV19ue49ONHAyZ5th/xMN8hspUvdj515CiQm4Hl3Zo/Tio9k
         AKb4S0f4rA/j83ZyMtJAbinAbB0EDeQKyGOYegg24+BudMfFjL0kOmVt1b1SANmQhnUb
         u7b6WgicDFEme5Rkhu/Q3tcG9ZB2tSbIN9iyRmfe/BDUf8arubfxCg0j29W51BaZ7l3A
         MoJOzsEWBUGZHL4LsyYFi6fWmyPKbzChWJfpZEegimCzB39Oev/wcnOZq4qQWOeuZQQQ
         LZ/Qv2pN8O+MhZmkmgwbX6jd/fCK08KTQPx036wFrB74ZLOapGHjydkXs45uwr7+m2H5
         MYrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcqT94J3LornRjjQrbVZzHUz7/pRRiAwmnjG+cupA8ztWZJewb2tWInVaGSQ7iuldRcB7UtgWLmIhCozY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGIncTTWzPZpqfr6+qxxf2lwFs+AIdyxh/1IUrXqtdeRBZjkb
	PRFRabFV0rHNNGt0tOJkMXbO6qjvBht0H2bvfgqyyP2xuH7Ud1Dba4DYa0TIbuQ=
X-Gm-Gg: ASbGncudcgi01wafIRuSgWpGxTcZ2OD9pdL9cM0mwtojOc7RFsH9HAp7cdM1Da7oN0V
	A5l1iMVYW8Nv9Zz6Xme1IjgFZX6cO1bkB8P2F+qAXJWJiVRxEr/kQyyGmMCEVDCb7UavEWyoCZp
	WwCNQkh3NOz4Q0UmSw/jkYtzwXHBWPXOs8oAoGezjHy8WReDhfvDA+uX9ucPOEoclt2jZ7yrBLS
	rWwJDJpHmp608oAqj0QOsmzJO5q6LH3W7PbDj9/MxMmMF7rNQzTlU8A7Qe3dzuTeoGTfvZoGrK3
	mKnu+4wCssi7mN0W0zXXblNK2msqCvmJCVIl8UVO
X-Google-Smtp-Source: AGHT+IHrXgYSbWtJbGGvvjbqgGeeMYXQJ4bKQjXqIkNDzpxQy6/BW8JhnsRoif+JrDmxplX8OOVelQ==
X-Received: by 2002:a05:6a00:228c:b0:730:8468:b2e8 with SMTP id d2e1a72fcca58-734ac386d5bmr8631206b3a.6.1740779940231;
        Fri, 28 Feb 2025 13:59:00 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:6935:f301:4e47:2b68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7defbd9asm3409033a12.74.2025.02.28.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 13:58:58 -0800 (PST)
Date: Fri, 28 Feb 2025 13:58:55 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix perf object dir symbolic link
Message-ID: <Z8Ixn3J2hw8TLdRj@ghost>
References: <20250228-b4-fix_perf_symbolic_link-v1-1-3ad734838929@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228-b4-fix_perf_symbolic_link-v1-1-3ad734838929@rivosinc.com>

On Fri, Feb 28, 2025 at 01:48:32PM -0800, Charlie Jenkins wrote:
> The -n flag is needed as an argument to ln to avoid recursively setting
> the symbolic link when OUTPUT is the same as $(srctree)/tools/perf.
> 
> Without this flag, the perf binary at $(srctree)/tools/perf/perf will
> become overwritten with a symbolic link to the parent directory.
> 
> Additionally, remove the forward slash after $(OUTPUT) since $(OUTPUT)
> implicitly includes a forward slash.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: 890a1961c812 ("perf tools: Create source symlink in perf object dir")

I should have double checked that this patch didn't exist already, I see
there is another thread here:

https://lore.kernel.org/lkml/Z5aiWiqJbkNaVG2Y@google.com/T/

- Charlie

> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 55d6ce9ea52fb2a57b8632cc6d0ddc501e29cbfc..0b6f9de6f222da1181402aa33e41ec3b05f9189e 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -158,7 +158,7 @@ ifneq ($(OUTPUT),)
>  VPATH += $(OUTPUT)
>  export VPATH
>  # create symlink to the original source
> -SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
> +SOURCE := $(shell ln -sfn $(srctree)/tools/perf $(OUTPUT)source)
>  endif
>  
>  # Beautify output
> 
> ---
> base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
> change-id: 20250228-b4-fix_perf_symbolic_link-8cc373a195ac
> -- 
> - Charlie
> 

