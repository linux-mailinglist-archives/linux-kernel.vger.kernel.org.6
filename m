Return-Path: <linux-kernel+bounces-176720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7F58C33AC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 22:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DBC1C20DC4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A6208A9;
	Sat, 11 May 2024 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZDgbCTEl"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151661C290
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715457895; cv=none; b=ncvO4iS1IGMaP0KUC2cdVKijOQ9Q1Of4Z1GVUTWMi2yBweZxam1AUzdzMkfBYs2QvLMnsgk1Kfcuf6Pp/GF3be7xihv+AWMVjEXLXwmvxiAJX+W/I15SZR8w7FngArc7OBzEeDA+jBRMBYNDXgww4q39DLcoFqtFAYdddsnE7Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715457895; c=relaxed/simple;
	bh=m0PmhIZfGfLGxB7MdP6Q++k4AXvc2nOplWPxUyw2VLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF5izX9HhDFVlzQYGF0/RlPJykfh+B5IwhSmo7ebwUXAAkORUaQTqsui5yOq0ck+WnZAhp4Bx9u2SkWaDHaGctdJLs/hwkPjTGe7zo5G9IC+1WQv245ruE0FMtQ2RIEYJJcNf1E5YGEXua6G42YHVgmbOH4IOjKaGCGZos6cUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZDgbCTEl; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce2aada130so2222267a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715457892; x=1716062692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAxRPnoHPzaMqkCmlI5pbJkR9qG9/zkm1emY09MZiz8=;
        b=ZDgbCTEl5MhaSUfST1waVCnlPi8WVwFpmMJY3cuHXP+W0Q+fVNBcanSOgyrum5uVi0
         CLQ8ZrwK693xxvMu5UotmQ3baCfpZYhNFT5hRswwT88UYj5h12g+J/jRPjAitul0UqFE
         Uj2eGeJ9B/PnR3aMXb+xzCZIS9XLV4FyUxVGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715457892; x=1716062692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAxRPnoHPzaMqkCmlI5pbJkR9qG9/zkm1emY09MZiz8=;
        b=wfkINpqQ3e233z6Jj7h1xVzsSP23xg8V/4mBDnFmRVMSWSQlkr7VX5+NGeLFV1jXma
         Dni9aECmVGgi15a5lKSiUDYXr79CZIqH3YTMSaciqf+GjUWdPNhAGb2JupRdzTi0a/eC
         T/SYgjZJYyL/cSWxo6lFF1Le1k04ps0GlSwOnOEq+gVZFfFDw5P8ur1uOKIqOQDjyBC5
         as0t40T0XivvuvrRSy+fnGQ2wIUOmuP6m7Y57i/x/vxTPuA40ioSCZvc48lhjY/B/3v9
         Pf9oYosnk8eeobFl71FkQh2L0TRbSYHfsGpdr3GMEQNlRP2EsyKcU/VUAzt2n+zNjCWa
         p53A==
X-Forwarded-Encrypted: i=1; AJvYcCWtZ4oXeOj2syhcS/T5IZ2M+OyePCyKUd3yOSX53W6upO/lwMosAdNUyp94h4F2xavH5J7nBU8UGi2WVkutmAbj3I/ZunPMjWcvBgY+
X-Gm-Message-State: AOJu0YwjjQPFkGRdrPOYkANsw0EV0b+Ik3qIaYIevbFgFaNF6LhzJ2pl
	ht+gMKlmwtSqMBu3mofp6SrERb+JXlqdCeqkefAswEbxWv8a25lXMoULfYPdGQ==
X-Google-Smtp-Source: AGHT+IEH64K5jd6mjFYb931Me09tBfbrb15HesgvKj7DyqJhBJRz3ZGnEZ6lTZAV58PL9Yzco/fyPA==
X-Received: by 2002:a05:6a20:da83:b0:1ad:8755:976 with SMTP id adf61e73a8af0-1afde0b5aa7mr6858922637.13.1715457892419;
        Sat, 11 May 2024 13:04:52 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b6d0b8c887sm3496640a91.21.2024.05.11.13.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 13:04:51 -0700 (PDT)
Date: Sat, 11 May 2024 13:04:51 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/x86/amd/uncore: Add flex array to struct
 amd_uncore_ctx
Message-ID: <202405111304.6A390B9D@keescook>
References: <AS8PR02MB7237E4848B44A5226BD3551C8BE02@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237E4848B44A5226BD3551C8BE02@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sat, May 11, 2024 at 04:51:54PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> The "struct amd_uncore_ctx" can be refactored to use a flex array for
> the "events" member. This way, the allocation/freeing of the memory can
> be simplified.
> 
> Specifically, as the "curr" variable is a pointer to the amd_uncore_ctx
> structure and it now ends up in a flexible array:
> 
> struct amd_uncore_ctx {
>         [...]
>         struct perf_event *events[];
> };
> 
> the two-step allocation can be simplifief by using just one kzalloc_node
> function and the struct_size() helper to do the arithmetic calculation
> for the memory to be allocated.
> 
> This way, the code is more readable and safer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Hi,
> 
> This patch can be considered v4 of this other one [1]. However, since
> the patch has completely changed due to the addition of the flex array,
> I have decided to make a new series and remove the "Reviewed-by:" tag
> by Gustavo A. R. Silva and Kees cook.
> 
> [1] https://lore.kernel.org/linux-hardening/PAXPR02MB7248F46DEFA47E79677481B18B152@PAXPR02MB7248.eurprd02.prod.outlook.com/
> 
> Thanks,
> Erick
> ---
>  arch/x86/events/amd/uncore.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

My favorite kind of patch: fewer lines, clearer code.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook

