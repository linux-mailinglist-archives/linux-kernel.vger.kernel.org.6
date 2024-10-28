Return-Path: <linux-kernel+bounces-385194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C60A9B33D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC741C21A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529CB1DE2BD;
	Mon, 28 Oct 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpy725/H"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48551DDC05
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126455; cv=none; b=IoOEBVSNN2yAQyNbLBce014KGg3ZHs6VrqSUpoo9GiA18E59ma0W6wOPQ59+HHGGVlh/C+jxfJT3c0HAmPrBgh99Svuu+E1qEqSzqa7UvfBtp+zh28f99azKKCFthNTIPqIQGa0ujbgprIgZFXfvqzng+sg/RzHG8wJoa+A3G4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126455; c=relaxed/simple;
	bh=5OXWCdXlYFEC82+QeLBrMiVngK/dtDPdLzFwiOlEeKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig3idqmLD0RuHLiUAdA0w7f7shlKQvmAdmdSz6qpYzdmf8Wwavx5DT6HrNX3nTf9pxJV8mOtKGtJzI1DHwrYw152DT5zwgVN3/QEGM1f9ApzVT3lNUNel+5I/j9zlQ0XSFkIo8GsNa4gtD92sza1Qc6UJ1xL8v/oHlCSXScTUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpy725/H; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso4630492276.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730126453; x=1730731253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GUxmQDCroRcD5PADBIPqWMHqU8j4+rH6VILtabqlNM=;
        b=cpy725/HVTgBQhagyHnn5Ec3bjluLIfyedVlNB9S9EczxBkIEPPrZXaT0wMyDoGCsR
         1anonubkrVjMgglbUcqxObA7cYkohqZ4jhM1RaPKWK62ktXSP+ASnfGkvfRZxvXYTYk7
         vw3g2wez9ljBc4+yofdEXx8mqwNFy8KoRdkjZ7o5pR2UfJ21LULjcGSqNjat9wKHiviZ
         zslsJ+8Iewe79yXi1WkcRImPQFe+5SQA0FIp0l/d/EM2DBbsAV/0zkXczE+u2kABcssI
         2oa4+eV4NoGCZ4dyYxq4h/TeB05aqyikVXhUBSpmNwLpBOQPOpz4cvfveq7xwxX3ePGn
         yvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730126453; x=1730731253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GUxmQDCroRcD5PADBIPqWMHqU8j4+rH6VILtabqlNM=;
        b=rdOt/OqzqggygDwUsgk0z+K65JClSA5UdO+pXgJxpSwJSjttCxRwS1Z4aNLmyvyKh/
         MyB0EvRka0XtffbaI+Ug4B2skjT4tl2M4hzWYzPkBguhbmkH1rWP5PBVh9pljgCkrEkY
         SCxzHRLXXC1pG6Xh0zl7dmZ3T/1AdRYhNCMzXRmjxP1DIrWnfBTtNat+dVkTxuooAQMS
         OiOCV31wGYGx6PlOX52sCMdfEPCQYtm+X2Ji5M1qH78B45iDaOWqkB95+bStpQNaY5uB
         D+dLJGXNgjTN/HuKyo1qOLaXGs0/kpXUXqiL8e5nF2BYQ9CMXOONbgIL03AHsVBGNp45
         GAGg==
X-Gm-Message-State: AOJu0Yw5xEazCPseQxmpoAgAcIWBi8VjdY1YFisojwfls0Qq73xvyWH3
	9Iq39GVtybG6BTmbdoUy5QqAH67Ea8j2ZRw7bDqMurMrUiO5KUKh
X-Google-Smtp-Source: AGHT+IF6p8JXy5eD9IeeaSNMTrkEwu1Z0077ihk2q6rpvti0E4hqVsqXakpLffDqPISARjgUzPqmnQ==
X-Received: by 2002:a05:690c:6f89:b0:6e3:37a7:8a98 with SMTP id 00721157ae682-6e9d896fc93mr84770867b3.14.1730126452702;
        Mon, 28 Oct 2024 07:40:52 -0700 (PDT)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bb1e2esm14342747b3.28.2024.10.28.07.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:40:52 -0700 (PDT)
Date: Mon, 28 Oct 2024 07:40:51 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/1 fyi] tools headers: Synchronize {uapi/}linux/bits.h
 with the kernel sources
Message-ID: <Zx-icwjwSxT1T9K5@yury-ThinkPad>
References: <Zx-ZVH7bHqtFn8Dv@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx-ZVH7bHqtFn8Dv@x1>

On Mon, Oct 28, 2024 at 11:01:56AM -0300, Arnaldo Carvalho de Melo wrote:
> tldr; Just FYI, I'm carrying this on the perf tools tree.
> 
> Full explanation:
> 
> There used to be no copies, with tools/ code using kernel headers
> directly. From time to time tools/perf/ broke due to legitimate kernel
> hacking. At some point Linus complained about such direct usage. Then we
> adopted the current model.
> 
> See further details at:
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README
> 
> To pick up the changes in this cset:
> 
>   947697c6f0f75f98 ("uapi: Define GENMASK_U128")
> 
> This addresses these perf build warnings:
> 
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
>     diff -u tools/include/linux/bits.h include/linux/bits.h
> 
> Please see tools/include/uapi/README for further details.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Yury Norov <yury.norov@gmail.com>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks,

Acked-by: Yury Norov <yury.norov@gmail.com>

> ---
>  tools/include/linux/bits.h      | 15 +++++++++++++++
>  tools/include/uapi/linux/bits.h |  3 +++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
> index 0eb24d21aac2142c..60044b6088172b3f 100644
> --- a/tools/include/linux/bits.h
> +++ b/tools/include/linux/bits.h
> @@ -36,4 +36,19 @@
>  #define GENMASK_ULL(h, l) \
>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>  
> +#if !defined(__ASSEMBLY__)
> +/*
> + * Missing asm support
> + *
> + * __GENMASK_U128() depends on _BIT128() which would not work
> + * in the asm code, as it shifts an 'unsigned __init128' data
> + * type instead of direct representation of 128 bit constants
> + * such as long and unsigned long. The fundamental problem is
> + * that a 128 bit constant will get silently truncated by the
> + * gcc compiler.
> + */
> +#define GENMASK_U128(h, l) \
> +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
> +#endif
> +
>  #endif	/* __LINUX_BITS_H */
> diff --git a/tools/include/uapi/linux/bits.h b/tools/include/uapi/linux/bits.h
> index 3c2a101986a314f6..5ee30f882736cbd1 100644
> --- a/tools/include/uapi/linux/bits.h
> +++ b/tools/include/uapi/linux/bits.h
> @@ -12,4 +12,7 @@
>          (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
>           (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
>  
> +#define __GENMASK_U128(h, l) \
> +	((_BIT128((h)) << 1) - (_BIT128(l)))
> +
>  #endif /* _UAPI_LINUX_BITS_H */
> -- 
> 2.47.0

