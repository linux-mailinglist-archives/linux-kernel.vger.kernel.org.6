Return-Path: <linux-kernel+bounces-400087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C3C9C08D5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D12282A19
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637AC212D0E;
	Thu,  7 Nov 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gdbyXreu"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C129CF4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989506; cv=none; b=fbGWNVPQfHv+5EGKairZTZCEOB/RzCd4ISb1MSgNASQr3urY9bqthgq8CxKOlI7fto9JaugVAWZvZB/3VdUEMz0+kgBmzhHtW0C3/VL643kr/MVYK0tuJMDgcXc8YM7GgxXLGp2I0Zqy/JZetvLzfUtfuvOkibwbOfOqDlHqOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989506; c=relaxed/simple;
	bh=c+hf6uB4fqH3d+WnnBByOCsUBIviwNFcQsOTMU6mvKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYpWUF6jiwPUy0okSPCav6tX627bJlYUDpi3d8EkS7kz3Ev+7W64VP7Rw3ZfWbusG3Hh1ImXHpMb/NcElTtjVFJ3hq0XBq7zWKOvsHuzqmgNqiMnSiAHI1W0cxkixkPTWtaJ5am1va+Mi7tAQtQr+V2wpotuklH17UxjtCKnTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gdbyXreu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d43a9bc03so672291f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730989502; x=1731594302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WbRzJJ/6WJtGg6mWwg9t7KQ5S1Rzj9qib33nN9SCn2I=;
        b=gdbyXreuJqP+CBEYXKtaQJ5/CSX5qTLqpZ7+MoOVnDSKzOrgjCqUozpVydX5T4fc9H
         2qhAaPUzVveFT6MdIia066NZxiGpWxXtoraHAztV/yaA0iAdEcCtdIISQ91+mj/Cx7ir
         wiDtajn9GEE66GePjYUPH3CA23ZIJIoZcpZoiUbx+ZqoERPZ7PZTxgSgRaa6glpWaCT7
         EgEnYgtZSL8F9PjQi/BCjwmMCAatmM5BuBRiylwkf1dS/SDpegOoaILr91tMVGA0EpSK
         QhC9o20XniG6vNe5tmr2x1b1RxLflnF3TvSPnJOvUUGx3VIOmhmBjRwxplYm9xnx129q
         eQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730989502; x=1731594302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbRzJJ/6WJtGg6mWwg9t7KQ5S1Rzj9qib33nN9SCn2I=;
        b=Vr3iXyzaUJV2J2Eh6QIh0kzKyibE4vAw7vx5J2Z6DPC/VrZagzPyZ0NwvV2bULxdE2
         vv5ySV16zCNtq4BN6mR56ejfxo/DYgW6uHabmKtDnHhSuingd9DOdWWRkmnpR0jATYld
         WwpP04Asi7AaBknhxw9KXv6Pg8E4K3s+kiMG92i4EUn89LhuKx8fjn2kux5TihALUKww
         z/hegWV1GZQRMsZfY2twqN7GBGPjE1291yfOErllt4j8mSbUc0CBszuPYgophw8BjbY+
         gKo/r56xZfTaE2Zys8SaeHFKyqzDRtBDDzy8OP9kOeavv+ih6MHnVItl3Kk2pxu+FFVN
         JHWg==
X-Forwarded-Encrypted: i=1; AJvYcCVKzEuvHDdDLo3KzjIFpCEohCPOqtYLoEJHgmVRteYhtFtzEXFxhxJqGEZClEe3mehWsEfWGAJBoPW87JY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gdh8wrytkBEcHe/8QSfBzAJKrgXBwmq360mkHgsQYbnNCypc
	xPRrLTGC6xTWn4NH+rBiLOp/LmJLpIrRIyeSJ8r8Hl0gu8SwckNZlHyR2b5GAMw=
X-Google-Smtp-Source: AGHT+IFM7WGqm0tmvVPpXPZBla5CuqK2zZ/9lXPmqEDUa+4PIGt5LF4OSu5sUzW3/qV8o19bqFF9mw==
X-Received: by 2002:a5d:64ce:0:b0:37d:45de:9dfb with SMTP id ffacd0b85a97d-381c7ab2cc1mr15453550f8f.46.1730989501840;
        Thu, 07 Nov 2024 06:25:01 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed987d33sm1907677f8f.43.2024.11.07.06.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:25:01 -0800 (PST)
Date: Thu, 7 Nov 2024 15:24:58 +0100
From: Petr Mladek <pmladek@suse.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/4] printf: Add print format (%pra) for struct range
Message-ID: <ZyzNuh9BJxQxihYv@pathway.suse.cz>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
 <20241025-cxl-pra-v2-3-123a825daba2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-cxl-pra-v2-3-123a825daba2@intel.com>

On Fri 2024-10-25 19:46:55, Ira Weiny wrote:
> The use of struct range in the CXL subsystem is growing.  In particular,
> the addition of Dynamic Capacity devices uses struct range in a number
> of places which are reported in debug and error messages.
> 
> To wit requiring the printing of the start/end fields in each print
> became cumbersome.  Dan Williams mentions in [1] that it might be time
> to have a print specifier for struct range similar to struct resource
> 
> A few alternatives were considered including '%par', '%r', and '%pn'.
> %pra follows that struct range is similar to struct resource (%p[rR])
> but needs to be different.  Based on discussions with Petr and Andy
> '%pra' was chosen.[2]
> 
> Andy also suggested to keep the range prints similar to struct resource
> though combined code.  Add hex_range() to handle printing for both
> pointer types.
> 
> Finally introduce DEFINE_RANGE() as a parallel to DEFINE_RES_*() and use
> it in the tests.
> 
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2229,6 +2264,15 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> +static noinline_for_stack
> +char *resource_or_range(const char *fmt, char *buf, char *end, void *ptr,
> +			struct printf_spec spec)
> +{
> +	if (*fmt == 'r' && fmt[1] == 'a')

This function is called only when (*fmt == 'r'). We do not need to
check it here.

Otherwise, this function should trigger an error when (*fmt != 'r').

> +		return range_string(buf, end, ptr, spec, fmt);
> +	return resource_string(buf, end, ptr, spec, fmt);
> +}
> +
>  int __init no_hash_pointers_enable(char *str)
>  {
>  	if (no_hash_pointers)
> @@ -2277,6 +2321,7 @@ char *rust_fmt_argument(char *buf, char *end, void *ptr);
>   * - 'Bb' as above with module build ID (for use in backtraces)
>   * - 'R' For decoded struct resource, e.g., [mem 0x0-0x1f 64bit pref]
>   * - 'r' For raw struct resource, e.g., [mem 0x0-0x1f flags 0x201]
> + * - 'ra' For struct ranges, e.g., [range 0x0000000000000000 - 0x00000000000000ff]

The range is printed without the space ' ' around the dash '-'.
I mean that this should be:

 * - 'ra' For struct ranges, e.g., [range 0x0000000000000000-0x00000000000000ff]

>   * - 'b[l]' For a bitmap, the number of bits is determined by the field
>   *       width which must be explicitly specified either as part of the
>   *       format string '%32b[l]' or through '%*b[l]', [l] selects


Otherwise, the patch looks good.

I am sorry for the late reply. I had vacation... The problems are
rather cosmetic and could be fixed by a followup patch later.

Best Regards,
Petr

