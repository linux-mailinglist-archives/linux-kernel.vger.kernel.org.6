Return-Path: <linux-kernel+bounces-327538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9AB977743
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44442828A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADCC145A05;
	Fri, 13 Sep 2024 03:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BUUgnEL1"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A10145B2E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 03:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726197379; cv=none; b=hxpGOfcUJtFUcMHnaNIMzmQI4A/NdTpah8GUweyUZjoZlEwtH8eoucN4NeeLfg8NuS7e8QSgauiuf/YdwR0+HnZdXzo92fsLRX3zpZHpR2oNs9owj/PKTnM3YxdHrvFRRdbMgLEmT/x+0l1pgxyluMDDQdVq+naSHjjy82IWsUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726197379; c=relaxed/simple;
	bh=70w5PmhQTmIIwpI8MXLURAsLlFUb4hIJSDuuCmsAO+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8sSOkP56GPK5jMY2GHe3UzPGdNNzQpUOWHOzIbpyBwW7Doz1qrdzsCRe2wh5LYEHLp8mWt3SlwrLoMcF4/8CjRuuEa2pfn9uxrbP5EpGUKdSa0MztNzp1gjzfvHqUOuhI69F6pubKMI9qZOf80rrCZx6dgnpVo6HxBcEwFN7HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BUUgnEL1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8818337a5so2032966a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726197375; x=1726802175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qmIqDIRKmZ3iBqg4fjUfRWxUySLwSHYWorSaFVgYpdg=;
        b=BUUgnEL1J5zbjoUXXTJKyKtDy2PGWJsXoDjocTr77p/ShA4vLUX77jbRGVuUrFx/1B
         Wjv2LryDF1mad2cTymd1W7oP5ee/YF6cttl2+tG/jJWZyhMXGYXTOQSJPCRzyF97b6tB
         7aBJFjbP2HTBLCExEQOlrKZQYk9kksrd5QWO/gvzQripj4cymU+YphEuDU1XBkaH2yYA
         VFiXtSzeMiFNUj/P7dhCfMJJzsXpLgk4rkUTfRVe5Q0fCHbWZriV5iO2Vq5mbqYEUWsc
         SHoyBgOjN9ADDf8f5AlKGo8/qwd8Idk043pOrHNh+t8euHoo5ayOKtFT0YM/b6hNmgL5
         4f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726197375; x=1726802175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmIqDIRKmZ3iBqg4fjUfRWxUySLwSHYWorSaFVgYpdg=;
        b=iL/3Jir3V8EqISw8q476tm61vs960VdJqneR49oL5gZSEIX/Zc/O0kFXgAO1rQz5aw
         lttFTQxEgjFxHgb1/pxNCTkEJU9mc9s0aAPuekfpx2Nj+d7gjrUQVRT1tQvQzhUlbA1y
         N26UaWAAGjCEWE7XKienCWhR8ua8u1vVqPGnYsA2VgVMCW52l3Ky5je3fgicG1fRurqB
         ds7S97q5pDGIzkTl7QyOESDAii7IUnAJmtfuK9a+nMoSHDXw5CfWsmj33yVHWXTbx3ra
         y+09X/Nd8tiO4+HYO/QAFCSbkDjlxBpq+tSToUMWyK3NvEdJSa5QkB1Mqnu6+RNLrM23
         Nehg==
X-Forwarded-Encrypted: i=1; AJvYcCXNIUDLaj9zrE4gsgWvUUIgNVG6pP5xUobu7f7TodPMpuA12UM0zvmz+BcUgLoICcwNAh0IBjKuHqHfXMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhONGzOuCIkQxSRiCNovZ9VepaCddIApBkk4CBkrZrPI+kfE6b
	iwtP9WOfPZ6/ycTm4GQfAFVqiEikekgHrtB9xr848qJkcWajggFoPJveoGy+Khc=
X-Google-Smtp-Source: AGHT+IHofoEYfpWNv4esB4XO4Rim9SF/7infwEOUPzQiA3C8UNukICHiPv0hDgZfogm6+/vqio/R2A==
X-Received: by 2002:a17:90a:a408:b0:2d8:7a2d:62e1 with SMTP id 98e67ed59e1d1-2db9fc1bf64mr8322148a91.2.1726197375526;
        Thu, 12 Sep 2024 20:16:15 -0700 (PDT)
Received: from ghost ([2600:1010:b329:66c7:b074:429:f745:d035])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207842d435dsm2339975ad.46.2024.09.12.20.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 20:16:14 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:16:09 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH 1/2] selftest/mm: Fix typo in virtual_address_range
Message-ID: <ZuOuedBpS7i3T/o0@ghost>
References: <20240913022635.751505-1-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913022635.751505-1-zhangchunyan@iscas.ac.cn>

On Fri, Sep 13, 2024 at 10:26:34AM +0800, Chunyan Zhang wrote:
> The function name should be *hint* address, so correct it.
> 
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> ---
>  tools/testing/selftests/mm/virtual_address_range.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 4e4c1e311247..2a2b69e91950 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -64,7 +64,7 @@
>  #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>  #endif
>  
> -static char *hind_addr(void)
> +static char *hint_addr(void)
>  {
>  	int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
>  
> @@ -185,7 +185,7 @@ int main(int argc, char *argv[])
>  	}
>  
>  	for (i = 0; i < NR_CHUNKS_HIGH; i++) {
> -		hint = hind_addr();
> +		hint = hint_addr();
>  		hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
>  			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>  
> -- 
> 2.34.1
> 

