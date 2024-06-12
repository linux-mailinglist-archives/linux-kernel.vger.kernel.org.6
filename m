Return-Path: <linux-kernel+bounces-210982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6C904B99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E83B22987
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0B8156967;
	Wed, 12 Jun 2024 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcE19JJ8"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5C13B5B3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173720; cv=none; b=BfyY4eHdf5czK8Z+O+7TTjT7ZPpFe6Z0Abyt+j0dFhjK58TYhWmbd5FdCOHh5cM4OsPa1DH9CNJu1SsOH1zKUASjAxoa71yPJz3ggW0Zqyd4DiUOMaH89BSSDOiEgTpPUf4R1xD5ljpaER7A3Hw4XZz7nLBJmBhG6SW/iu314/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173720; c=relaxed/simple;
	bh=5VGHP0Uu4GEt9dUL3C7ycP0EIcDYBw17Aoa6jPD7lWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNt+uI9VzIYyJSdw3OkU5vpn2hWDmcfuGjqx5mRac99zhYJrf86kc6ZodSqoWY7Xs/nhLnmVfuFN/r7e81Zd8fxJFjDuTxX77CxKEIq0cjYEQ3mL9vgIeoNkMuXSiScqRndEnQOTrBWIzoFqG8M0clKLFOXBmoZ5BDFrYpMErIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcE19JJ8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f3efa1cc7so91234566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718173717; x=1718778517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9oHRS/6fbMlz5Nc/pRAypu+9kB8YgLFrFHMqAN2klms=;
        b=OcE19JJ8yLhauPdDZ+3VQ/o+qcQEtSXQEViINmGbP6vUXMEhg2AdtPauKZ+Ds3tKl0
         SxgcnpZ14E09PvwDDiDTxeuxxwHu4wE+KAQU9wPzT9Gh+BcN6226s9ubwmML0Rt81Pu4
         Zw/wUUELR1SFD5aGDuVR7Yzw+3arZbK5qkuG2jx08MwdDOV+cMyL8+YkJYDAU0hbrX8i
         ub8Hg9mg1rTEUB6N2dS+tAO0csiT9SjMXT8hW+SOxxf6sO5zbBoFkSKuBUFi9Iuzo1Z6
         1S475h+KEFrLKovd7fW9jCZWuo/GYB9pz8kpLmGuBwGeUQ9xCGfAE0LQ7xsFfdrS/YPQ
         gZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718173717; x=1718778517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oHRS/6fbMlz5Nc/pRAypu+9kB8YgLFrFHMqAN2klms=;
        b=Y3dme7PrTzwMrCSsG1ErBsmoJvSCUebj9Ox5+77Ap2PLGTBuO1cNCLhov3PkL8Ynzp
         BZ2bz4SbDk4siRji6u84uXcWxg7odQrWfngkPxfoM4yJkSszsuhOU9wpzYLCDuFmsyhr
         Fr/VegH4jhFRu0x+9AoVGyPn6E+BsYw/I4iZmCqsGX2wBTKSzavBw6u1ZdUh8LubHMHa
         0+kT0v2h0ZVKfDF0TOfnvCnDCul+/AgegWTy19Pro1HqNCp/tY+jtK+ZfPFaYS7T7ynI
         e/04cznlD2AGODyLRR2/NSqW8Nsqe3ZGLvbqMOx4/ZdOoMqPVpnTF0L9jECsHXU3UX2D
         w/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrr2nBNUpL0QimR3nG1NboWsJMLAnoYxyXlf9DI3Brj9nUtv5JToOedYazWKH63qgSbQ/BxM1ERL8JzlPC0F8zPeduzVQplsxGQ7Vn
X-Gm-Message-State: AOJu0YwkVXqSXj9SY6eQrU8ivbajxgFk0qzBKuHCo5SNFXMrnu53T7Yi
	IKOxfDQxmjz4WH8U9faG0bzKiejGGeOXZMVkHchZR+2g0cY0lKdg
X-Google-Smtp-Source: AGHT+IGI/oqkZwMwyUVDqo4ctemWaeIxP1af1zQk55eXFO/5r1OGyyJu7z6VsLk4Uj0wqWwkVg9X2g==
X-Received: by 2002:a17:906:689a:b0:a6f:4232:4370 with SMTP id a640c23a62f3a-a6f42324412mr120440366b.5.1718173716367;
        Tue, 11 Jun 2024 23:28:36 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1c99d8f1sm384201566b.175.2024.06.11.23.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 23:28:36 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:28:31 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: linux-riscv@lists.infradead.org, dvyukov@google.com,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org,
	Patrick O'Neill <patrick@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: riscv: link error when supporting KCSAN
Message-ID: <ZmlADwdvCHCNqg6E@andrea>
References: <c740ef8f-1bb4-0c4a-4b88-77dab19f3e31@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c740ef8f-1bb4-0c4a-4b88-77dab19f3e31@huawei.com>

On Wed, Jun 12, 2024 at 11:02:32AM +0800, Li Zetao wrote:
> Hi all,
> 
> I'm developing support for KCSAN on riscv but getting the following link
> error:
> 
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L996':
> core.c:(.text+0x2b62): undefined reference to `__atomic_exchange_1'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1015':
> core.c:(.text+0x2c40): undefined reference to `__atomic_fetch_add_1'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1034':
> core.c:(.text+0x2d1e): undefined reference to `__atomic_fetch_sub_1'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1053':
> core.c:(.text+0x2dfc): undefined reference to `__atomic_fetch_and_1'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1071':
> core.c:(.text+0x2eda): undefined reference to `__atomic_fetch_or_1'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1090':
> core.c:(.text+0x2fb8): undefined reference to `__atomic_fetch_xor_1'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1109':
> core.c:(.text+0x3096): undefined reference to `__atomic_fetch_nand_1'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1128':
> core.c:(.text+0x3182): undefined reference to `__atomic_compare_exchange_1'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1147':
> core.c:(.text+0x3274): undefined reference to `__atomic_compare_exchange_1'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1166':
> core.c:(.text+0x3366): undefined reference to `__atomic_compare_exchange_1'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1220':
> core.c:(.text+0x35ec): undefined reference to `__atomic_exchange_2'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1239':
> core.c:(.text+0x36ce): undefined reference to `__atomic_fetch_add_2'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1258':
> core.c:(.text+0x37b0): undefined reference to `__atomic_fetch_sub_2'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1277':
> core.c:(.text+0x3892): undefined reference to `__atomic_fetch_and_2'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1296':
> core.c:(.text+0x3974): undefined reference to `__atomic_fetch_or_2'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1315':
> core.c:(.text+0x3a56): undefined reference to `__atomic_fetch_xor_2'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1334':
> core.c:(.text+0x3b38): undefined reference to `__atomic_fetch_nand_2'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1353':
> core.c:(.text+0x3c28): undefined reference to `__atomic_compare_exchange_2'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1372':
> core.c:(.text+0x3d1e): undefined reference to `__atomic_compare_exchange_2'
> riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1391':
> core.c:(.text+0x3e14): undefined reference to `__atomic_compare_exchange_2'
> make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> make[1]: *** [/home/l00517538/PrIntFuzz/third_party/linux/Makefile:1171:
> vmlinux] Error 2
> 
> The reason for the error is that riscv only supports 32-bit or 64-bit atomic
> operations.As far as I know, this error is solved through the
> no-outline-atomics option on arm64. How can I solve this problem on riscv?

IIRC, support for inline subword atomic ops has been added to riscv/gcc
with

  https://gcc.gnu.org/pipermail/gcc-patches/2023-April/616807.html

(-minline-atomics becoming the default behavior with the above changes).

It appears as if your compiler does not include these changes and might
have to be upgraded?

+ Patrick and Palmer, FYI.

  Andrea

