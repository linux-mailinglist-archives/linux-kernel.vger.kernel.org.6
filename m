Return-Path: <linux-kernel+bounces-327251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF389772DC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3ED2860AD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8227D1C1738;
	Thu, 12 Sep 2024 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="W8nJKsdp"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDA126C17
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174045; cv=none; b=B5DcV8+dq5lmqwhjLuiUFL21k0lGG9JO1afr172UhMq2+dzTe6QPzyEMyw02S6cNedu32Z6LCy1KE/aukL7KYrMT5MKNKv7WmwdaeMFIDdE5PFvZ24cYOHIhDpJIilIucLAhh9e7N5NevQsNaezqJYFHSnoBTcNxKjm5mfXWXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174045; c=relaxed/simple;
	bh=UeKDIfl46B0MjAeHHAOJysv7+DcyldeuRzbyODT/6Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6lvFHiIukKimiKyoExQNATBd18hbGQTbk/cz7B5/DEMyq/JO+T736SyZvxZIrzwtp/Ax3RW2qK8icxBKwvccPrcbWksd+qPI6LegpQnvlIIWiJ87G5SD6U31Lc0e9FNE0ksbLSR37+rfiQPYtS4Zp9klwySsn1gFS50McX615Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=W8nJKsdp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d7a9200947so75776a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726174043; x=1726778843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkYEDgSUi+q4cC1mKbyRLPDEigMYGApwN1eBhMPthC4=;
        b=W8nJKsdpI8iv3NLyLAEaFtnhAZlR/I8zVU7hEdlE9lWIbzTWLQRhrwW9P03gQKm7ol
         yNNbwmpfuZlHuV4ZvnxHGCXu1cy4v+IqK6qsaoIF0sSVQepg4A9tO+byMrA9IURBAceb
         nIsDGJbJuLHeJpJ0p98izj6ts6NL4dQBGYmN4+e4/IvLbAgaQQZOz0yZ9F3wnyNzEnRW
         tA7HfYHwwitRTHdq4ABm+gzfZTMYPhUt94phP9Hn7hzZXOf3rSaO2hKZFsZWeqiXNmg+
         Ea1nUO1MFIiVWR5uyRGGv19KjGcNOcCc8KKRgyHqsTUXkUGLFUVAuqVNtxcAmGtoSFC2
         8L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174043; x=1726778843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkYEDgSUi+q4cC1mKbyRLPDEigMYGApwN1eBhMPthC4=;
        b=iPB/0wxlqUoavWMWgftEWKVqzrV4mnkPllomd+X2x+3+yF6qMzp8dJWgjY4fvTtbg5
         RydyOIxXRLHfSKRvkgmkJEvFwt6hH7TuZ/7ACE4cDkjaGDrucQCzub+FZ6DXfWCltsXc
         rv82pdJ5K0ot+jziBf8kT61A7vT4YJHRpC4uRF3Jp+rDyzi0E+khSDguP9hvUHQ66hcR
         XYTJZjoPFyX/b16lBm5T0MNG+ahxZc2oMqXAI/gu0O4qDNBaqlByHNPAJPQ2VpAjnRsV
         /afyoJbmuBN8TNw296u5PfYUMyaGOreu/QgOl+LUGBtY5YWH219Saql3ok8JPHiztB/T
         8REg==
X-Forwarded-Encrypted: i=1; AJvYcCXKw/VWjOzGk/WK2/kHGShBBnIWb+91psCLcS+rqnWsw/KtcHCOagsHCflUXHd/XcSBMo5l39kQ0/WYEv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtP+I4+AhEeY6KgS6QS+2G5TLsOSk+xCwpkE5V3vCMjFszmr/
	UT9Z4RnCKQ7NEqoGnFg1Hha3/Zi2AKz+h3nVWgcOBGGig2H/zqpeWfQU9aR6Wgo=
X-Google-Smtp-Source: AGHT+IHY1ulWf8xIoYCgymvFfMz7AvIjbgg3u2pIVYFSwdjBxA8LW0bzDtVMfKaopkm+QTibJTkj8w==
X-Received: by 2002:a05:6a21:e90:b0:1cf:6d67:fe5a with SMTP id adf61e73a8af0-1d112edc9b4mr484866637.50.1726174043300;
        Thu, 12 Sep 2024 13:47:23 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fddd1c4sm2128722a12.63.2024.09.12.13.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 13:47:22 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:47:20 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH] selftest/mm: Do not use hint for riscv mmap
Message-ID: <ZuNTWCsPPLTm1zdX@ghost>
References: <20240912100018.736447-1-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912100018.736447-1-zhangchunyan@iscas.ac.cn>

On Thu, Sep 12, 2024 at 06:00:18PM +0800, Chunyan Zhang wrote:
> When the virtual address range selftest is run on RISC-V platforms,
> it is observed that using the hint address when calling mmap cannot
> get the address in the range of that validate_addr() checks, also
> that will cause '/proc/self/maps' have gaps larger than MAP_CHUNK_SIZE.
> 
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>  tools/testing/selftests/mm/virtual_address_range.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 4e4c1e311247..25f3eb304999 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -64,6 +64,14 @@
>  #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>  #endif
>  
> +#if defined(__riscv) && (__riscv_xlen == 64)
> +static char *hind_addr(void)

This is not a typo by you since this is the name of the original
function but this should be "hint_addr" right?

> +{
> +	return NULL;
> +}
> +
> +static void validate_addr(char *ptr, int high_addr) { }
> +#else

This is something that I am trying to solve over at
https://lore.kernel.org/lkml/20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com/
(the solution is still in flux). Since riscv doesn't currently have this
behavior of restricting the virtual address space, I think it is more
reasonable to disable this test entirely. After we have a longer-term
solution with the patch I have up we can adjust the test and re-enable
it. What do you think?

- Charlie

>  static char *hind_addr(void)
>  {
>  	int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
> @@ -81,6 +89,7 @@ static void validate_addr(char *ptr, int high_addr)
>  	if (addr > HIGH_ADDR_MARK)
>  		ksft_exit_fail_msg("Bad address %lx\n", addr);
>  }
> +#endif
>  
>  static int validate_lower_address_hint(void)
>  {
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

