Return-Path: <linux-kernel+bounces-178040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 651DB8C47CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061DC1F24A83
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ECD76C61;
	Mon, 13 May 2024 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E33ss5Q0"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F37711C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629507; cv=none; b=qNccaUJSN6Pzj05xx4/tWSb8bevAiXBznW83dJFn+AFz+Ls3OFShf8DDpI5UQDKizcv2ZPJ+5MLHkA9R0awxDC/+d6p1tQO5UJGh1ZrlwzSCdAHT1yj07lCFHGuh6vYDuQ8BnEMv/aG+LGEAcbIWEMxap4wOQqSwTZ0tNu43wkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629507; c=relaxed/simple;
	bh=lkX/M/OVTWkcdWK8AyuLdiu5b3a3EKqBIzeiduQZzZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjUAxmv49iAJ95H0HkSDmG9CNIv7g7+0h5WyMLWOGxxU2cC5qjoLvBgpfa7az2zx7sgOi15ZbdJk8iE+t0TE/26rya2Im83jYt+B+SczharaZRyMdq1i3xQ+fpFgVRhDZGrGmYg6Tk0xDF/uKXzIXWe1tdpchdrP2PoWyInCvMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E33ss5Q0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8b519e438so3927465a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715629505; x=1716234305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9chi3Xc1nvI/gVi21b7gtgutjXhJ9XfFazGItJ10RrM=;
        b=E33ss5Q0TJGnHz3o+AiCo3QuUv1pGfj+squ9xsx7x3VhplSgGvo27nzC2FvVLGX7gp
         5Hj5SgZBIZJmKPDaLGNnaAqu2mvBfK1QoVvBAD4mHVmoWW+G3N/EFQAM5WtycZ7QTRZg
         MlSxv9D7m5yhYaszB42tuDdehfptJ3JcnvVQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629505; x=1716234305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9chi3Xc1nvI/gVi21b7gtgutjXhJ9XfFazGItJ10RrM=;
        b=n+Al+f8sm80w4CGkPgvmiqG2vApUQ1zkxDSi5rTM8ybEqwmP0okrKPNIHNOZQ5fem6
         bJp4z/l/ycnggBPU+pgjkUXJ1pEirjumjoDgwzp+FWDfQY/m0WtRP6RhqnSNFyeHi2In
         VA5A3e9WfvsZoaEfg+w9RySGkaPNJ/dSeBiwkvxH2LLoCTU8Jci+MIcOFrEtiD+xO1jC
         JqESyMLf6HG5TenV5d2Y1jcL+G+9t1YWsqABN0J3/K3kzl1OkJwowF9xPxN6mxem387N
         IUyRBu9NRkCwzgrgm/cPgNvnGXF6CA1kwGz/a9XbojF2VAPXssEEWTaEAtoFeE0AcgHE
         9LgA==
X-Forwarded-Encrypted: i=1; AJvYcCUTOtJuoL5lOSVCl4mvFdp6vn+jId2Ej01oJ2WXtFoYt8sSIgVYHX5TVpZGFZybsxrh1IQ1cY5tXEsE60e8kfnG/4r9R7oRBLYm/+rA
X-Gm-Message-State: AOJu0YwVSJEth/Zjbw1kKo/epp3PrV50YWlZdN1ewn46/bpD3GMX1gmH
	Sz3BhnLoMkU6wlVGQk1GdRo7FlsIxalD8KxPQCXax5IwZ9Sl2Tu3Uv+nAwWQaw==
X-Google-Smtp-Source: AGHT+IFiB350HJmAM9p6dy50xn1DH9UD4cBCncM11fBjTw9zQRi5Yi8p+prPZer6lZhPmiwwzOChIA==
X-Received: by 2002:a05:6a20:c909:b0:1ad:999b:de47 with SMTP id adf61e73a8af0-1afde1d7b38mr11221877637.51.1715629505306;
        Mon, 13 May 2024 12:45:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea6ab8sm10150799a91.55.2024.05.13.12.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:45:04 -0700 (PDT)
Date: Mon, 13 May 2024 12:45:04 -0700
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
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
Message-ID: <202405131245.E572E4C6@keescook>
References: <AS8PR02MB72379B4807F3951A1B926BA58BE02@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB72379B4807F3951A1B926BA58BE02@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sat, May 11, 2024 at 03:24:37PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "rb" variable is a pointer to "struct perf_buffer" and this
> structure ends in a flexible array:
> 
> struct perf_buffer {
> 	[...]
> 	void	*data_pages[];
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + count * size" in
> the kzalloc_node() functions.
> 
> In the "rb_alloc" function defined in the else branch of the macro
> 
>  #ifndef CONFIG_PERF_USE_VMALLOC
> 
> the count in the struct_size helper is the literal "1" since only one
> pointer to void is allocated. Also, remove the "size" variable as it
> is no longer needed.
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions). In this case, it is important to note
> that the logic needs a little refactoring to ensure that the "nr_pages"
> member is initialized before the first access to the flex array.
> 
> In one case, it is only necessary to move the "nr_pages" assignment
> before the array-writing loop while in the other case the access to the
> flex array needs to be moved inside the if branch and after the
> "nr_pages" assignment.
> 
> This way, the code is more safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

