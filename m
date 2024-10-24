Return-Path: <linux-kernel+bounces-380463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50719AEF10
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFE828198C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E941FF7B7;
	Thu, 24 Oct 2024 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="PsMoJYT2"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26F1FE100
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792844; cv=none; b=RAhqtgOuuxj6Fnw4QfY1AqxjIIqIZIEdCyiXWxEbQxaTdBlG1h9pmc2Y3q619e1Q91LPXtfDGGqQ/MN0BzKxh4UMxJcQOJThylDOErgfCB/w25Wex7qCBfxXglBXQQ5hmMvkDDq7u9gQK5B9PDLM+lPvplwzMnP2df7/aH2Vkuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792844; c=relaxed/simple;
	bh=v/HtRG5S2NVKfvlArIvjBQp0JcOSotOovrvIG+I/hzI=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=HkdLaES5kTfanWYAMhQsZ9DUgAGFLqIRESGwy9AHy0epwVMN7JDu9eg7A4YPloAYHzZDeSm16K5njwCjccv9K6g8BGv/04JqxTpP64r9Q+/EG1OO7liA4PvALiZ2kY9udcEJbQljbpGXP7gVkzmRafh26kUnjIxXuy12E8jp3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=PsMoJYT2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7203c431f93so939900b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1729792841; x=1730397641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/q1WiGJcS/tkbhu37qaq0jxibdm+CvDbpDg/bK1kAU=;
        b=PsMoJYT2tmiGPrUZrz+ssmCo4jRYcyKBn+sTM4JUwUm5JfU0+/9TNxu4dE6dLKaJVe
         mYtoZi4XdJPcnIjlv2ftF3EofleHO1/VP934gWmWz5UdQOMNonhIysNGK4N79/kyGl0H
         1codQpw53H71dqZ9mDXicx/kqdy14rkIepp+f5TSeB13PBWvHRIomusOQJ2Qg8CuUT4Y
         ljWHofVgJGIYCX/L9WxesJtLdx4zk/tGPSKv38h8SUzWAjykcw9zzj7+4ddrtqeCbWr8
         AV+5niDfMf80rCANBNDGYXLGUYsmSf/ETeivZaIuYwHNeu3mGfSa91rwgmnRSN8bl/vD
         81xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792841; x=1730397641;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/q1WiGJcS/tkbhu37qaq0jxibdm+CvDbpDg/bK1kAU=;
        b=pdIjhsAOU4H1OKiiyKWaRnl/u5gwEZSyMinHusSnvkUCmY2+TvrP0fwvtYfBa7aWSX
         CK9hlObrM0LLVRcz5HrORmWb1UJK4ereRNAmMgJNMdaMyLrVUciHRiCIMLo1PV9rEkjU
         DctsT/DT/xTeC9hk3z8KGaLL7y779JdUtPW3+MmSaEjkE7R3byKdFm7RqWmnBpFJO+qt
         pQJAQXZVBuG6swgL0CrSFXwIQ2i1v5zeZro0EY2DiZuqTfU4dDHwovH3AWWwTXUn2F3s
         3iKQ7yR7hKCLzzJ825A8yxkTlVmFsdtjux2WQ07OkG9mhIaaHibmOtXAoqj6eIPOdPL/
         VWvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV11vgGlVINcQbaAtnAYZWbeCCSMHlER0eZYrmPvrwNboiZwWifcffr52ilr2ifn8+3DVs2YnS0I2Jf/vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygFQJd/f6dZouF4gvgqEa6lHtMGc2ObZq6KT+wtVpUJrn9J8bd
	LejApr4y/Dv4m36vyu17tRsiRIhcM9zr6q7PgSmDf4V29Nfz4yCaMOdqCoUttXA=
X-Google-Smtp-Source: AGHT+IEWB1udhSviA9LAWrRVloAe7iAHeKwlFuxSRB7lYrklQRgkKc7BVJq9iQgQFB+GNpPYe7xzxw==
X-Received: by 2002:a05:6a00:2e1c:b0:71e:634e:fe0d with SMTP id d2e1a72fcca58-72030a8ae4bmr10220156b3a.12.1729792841339;
        Thu, 24 Oct 2024 11:00:41 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea720sm8218735b3a.157.2024.10.24.11.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:00:40 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:00:40 -0700 (PDT)
X-Google-Original-Date: Thu, 24 Oct 2024 10:54:46 PDT (-0700)
Subject:     Re: [PATCH V2 4/4] selftests/mm: skip virtual_address_range tests on riscv
In-Reply-To: <20241008094141.549248-5-zhangchunyan@iscas.ac.cn>
CC: akpm@linux-foundation.org, shuah@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, alex@ghiti.fr, Charlie Jenkins <charlie@rivosinc.com>, linux-mm@kvack.org,
  linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  zhang.lyra@gmail.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: zhangchunyan@iscas.ac.cn
Message-ID: <mhng-d7045132-a4e1-409a-9646-d8ecd3d6a48f@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 08 Oct 2024 02:41:41 PDT (-0700), zhangchunyan@iscas.ac.cn wrote:
> RISC-V doesn't currently have the behavior of restricting the virtual
> address space which virtual_address_range tests check, this will
> cause the tests fail. So lets disable the whole test suite for riscv64
> for now, not build it and run_vmtests.sh will skip it if it is not present.
>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
> V1: https://lore.kernel.org/linux-mm/ZuOuedBpS7i3T%2Fo0@ghost/T/
> ---
>  tools/testing/selftests/mm/Makefile       |  2 ++
>  tools/testing/selftests/mm/run_vmtests.sh | 10 ++++++----
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 02e1204971b0..76a378c5c141 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -115,7 +115,9 @@ endif
>
>  ifneq (,$(filter $(ARCH),arm64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64 s390))
>  TEST_GEN_FILES += va_high_addr_switch
> +ifneq ($(ARCH),riscv64)
>  TEST_GEN_FILES += virtual_address_range
> +endif
>  TEST_GEN_FILES += write_to_hugetlbfs
>  endif
>
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index c5797ad1d37b..4493bfd1911c 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -347,10 +347,12 @@ if [ $VADDR64 -ne 0 ]; then
>  	# allows high virtual address allocation requests independent
>  	# of platform's physical memory.
>
> -	prev_policy=$(cat /proc/sys/vm/overcommit_memory)
> -	echo 1 > /proc/sys/vm/overcommit_memory
> -	CATEGORY="hugevm" run_test ./virtual_address_range
> -	echo $prev_policy > /proc/sys/vm/overcommit_memory
> +	if [ -x ./virtual_address_range ]; then
> +		prev_policy=$(cat /proc/sys/vm/overcommit_memory)
> +		echo 1 > /proc/sys/vm/overcommit_memory
> +		CATEGORY="hugevm" run_test ./virtual_address_range
> +		echo $prev_policy > /proc/sys/vm/overcommit_memory
> +	fi
>
>  	# va high address boundary switch test
>  	ARCH_ARM64="arm64"

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

(I'm taking the first two as they're RISC-V bits)

