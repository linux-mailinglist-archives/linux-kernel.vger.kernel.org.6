Return-Path: <linux-kernel+bounces-331870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E7C97B23B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC501F2B325
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150DC19409E;
	Tue, 17 Sep 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Eh5vqDHy"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED291192D80
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587691; cv=none; b=jlu+Kyp2Whq7mLiJvTqlYY8o74g/mNpRDt4DU57YaSRJ/nC36FkFbuTC+3oEwgfzD7ZPqAZJSGkt0KALs5/KblE2LqnG7d2Fif7nrau+Ix5INFIOWEYThIHhFtW3kL/tkqmHVJIsyXRenZj1QoGjGLghFix8aJwyMMtVwSJ4Jj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587691; c=relaxed/simple;
	bh=Y/ueD7Er4ksHV0zEFMf0k0PeCDW+b7AGJyD5al1Tm/I=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=UJzORZmMBBYiISOpK0m/H5lT6xjfALhy1q8nBHXhLjrPffaqsGRXk1zcI7PSS22WY/28A2Rx6/8b92LxW2fgI0GCVSor/v7l4SH8e14ervrI8yz4ppbwUKesexSSabpKoGenzJ+UiqaHXQDyjFmnH5zb3U24GJ+YsWMKvt4zL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Eh5vqDHy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2068bee21d8so57679375ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1726587666; x=1727192466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6cEhAcJt3HhcTHDpOxIvaAzXbYRd4H4Nq0SQeFTmVU=;
        b=Eh5vqDHymQt7CkxNq7nMYn6S1sLA9zNkCRacJTJ+PoJ15h3jI0ECI6EJ/fgTcZRx5a
         GhrsNT12/bvZLamEjCBR6xmMXmC8yKV3O1yesBOfPxKA8qqE66ouSFUPr2ikm8pGBZmw
         +zyHkrw8Z7Wqcy8Tsoaafm9KHp9YYdNfbGWe5mC3DNy581NEw2bnXvT1vTwggamItdpG
         /soZOB11jCCED8AO2TcsmL4W3mbz2ocLnA+H55BIRn3v9+4eUGv4yRMNUupdPbbymh9D
         uEs6xMOHmWwPev1vj0joLSgtDITALi9T5Xg0U/2pmkHjSJX8RUe2v7tgSLtbRwVMDnkb
         eDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726587666; x=1727192466;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6cEhAcJt3HhcTHDpOxIvaAzXbYRd4H4Nq0SQeFTmVU=;
        b=nQFrY7zyutva00/+N6EGGI4OiIBVAK8CILUzim5FBD2q7QSfxW0VD4mQqBJVQCwCid
         mp+L1UugaHy/Xv+TlAPAVaOAOxh8cABKOrGc+b/bbix2/0b4rYh2lIc0BK/1xAXDgMbK
         NakcpxDOu8essWo7EwgZvmHsjsfuiekxgAYDqtx6k7r02QXDHY1CLEahMeL8wh0WtAGB
         yhPx25zmA6VEpMBi2z6N2W3B28Vd2d22regXWMzfncKjv0LnGgGxC1jyKoKxSpolyfml
         94YUCWCjRvXd602hSWQyIPFZmdhVc4xPDa4+C/JX5TusuJyx7NswKA6ZLdnHixytxPzj
         RkSA==
X-Forwarded-Encrypted: i=1; AJvYcCXrvAnQAGJt2MxFfAX6502Oxdq8KY/zTHJtdoo4uXSBs7aNDhoLXH2g30+CmVFyeBOiPb7JWi/2HBFgzaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd/ZWzqGSf1Lk/NpAmwIgBc0okHGv4GK7um5T+TiSLXN6PEEUj
	qF42kn6WDEnkdUUOOnjznrnqeeC8KFKfPNPeyht2qTM531QjwkoTCZue8R8hLtQ=
X-Google-Smtp-Source: AGHT+IH8BbHXUPz/AlzFd5EcNCywWECO/RcDJ1X5X6FPp6Pwu0T7DzZHVs7nzUw1h1hhW4jS6pFF3g==
X-Received: by 2002:a17:902:f547:b0:205:8407:631d with SMTP id d9443c01a7336-2076e3511c7mr238055635ad.13.1726587666169;
        Tue, 17 Sep 2024 08:41:06 -0700 (PDT)
Received: from localhost ([213.208.157.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473634esm51620645ad.262.2024.09.17.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 08:41:05 -0700 (PDT)
Date: Tue, 17 Sep 2024 08:41:05 -0700 (PDT)
X-Google-Original-Date: Tue, 17 Sep 2024 08:40:59 PDT (-0700)
Subject:     Re: [PATCH v2 1/2] riscv: vdso: Prevent gcc from inserting calls to memset()
In-Reply-To: <20240705060902.113294-2-alexghiti@rivosinc.com>
CC: vladimir.isaev@syntacore.com, roman.artemev@syntacore.com, guoren@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, alexghiti@rivosinc.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alexghiti@rivosinc.com
Message-ID: <mhng-b17acfa9-03e8-4ef7-a24f-a133b2dbf31a@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 04 Jul 2024 23:09:01 PDT (-0700), alexghiti@rivosinc.com wrote:
> gcc is smart enough to insert a call to memset() in
> riscv_vdso_get_cpus(), which generates a dynamic relocation.
>
> So prevent gcc from doing that by using the
> -fno-tree-loop-distribute-patterns option.

This option doesn't exist on LLVM (at least on whatever version I'm 
using), and I'm not getting any memset()s generated locally so I'm not 
sure what to look for over there.

From poking around GCC it looks like we might want -fno-tree-ccp too?  
That seems to be able to convert assignments into builtins as well...

> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index f7ef8ad9b550..c7e40bf36371 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -18,6 +18,7 @@ obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
>
>  ccflags-y := -fno-stack-protector
>  ccflags-y += -DDISABLE_BRANCH_PROFILING
> +ccflags-y += -fno-tree-loop-distribute-patterns
>
>  ifneq ($(c-gettimeofday-y),)
>    CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)

