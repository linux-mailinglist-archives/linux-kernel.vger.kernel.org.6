Return-Path: <linux-kernel+bounces-287687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1CE952B57
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52943B20B29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E52F1B32CD;
	Thu, 15 Aug 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jpx0X4WP"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42919A281
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712137; cv=none; b=WtXL+mmlteT0vE49jPG6+a71BLXCzhFGaaCgZZ1HspUT6NzJfNjAgNj0ESiui9BxmZzWb2PwzA7ebsEywITacuBQUfSs6OKSV8btrE2th1YusthrDksUlPzK1gDK5s5ODCEvp5ROCsoirE5/Qw6k+fUWAlI2jIrzcPUx7x4NaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712137; c=relaxed/simple;
	bh=C0D2yyqt/WHCbkrlhUw+2syRlzBlj8YXLsPRUHWVtuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWBwLH8fNB2mzJwOzC7EO45DRs70Qp3bIxcEzFowu/1SR7a53dbMNy2t5FYg68RCvGPsU2d96OsDlWI8v+25ei5lCJrlZW9c8iV1VOtUiAifuY2wxrX1eJx0A16ujpehT0wigoMZmRN2lR2HlYCo7gmZkGyoNfISCUqWPMXIQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jpx0X4WP; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db1657c0fdso413974b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723712135; x=1724316935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0vnLL3kbPXvkotUPyNMjX8bBOkSvxIBHQZGgdMJco+g=;
        b=Jpx0X4WPglqgnpQeEn56NmueL/zfCdbbyl+jd0DtzNvHKMPF5WySssyawED5YUO/Zw
         ww00bO8hr3xiKIznobo73zzE6G/FHc9kRGM9RPyMwyTP6qrNKQbGlRXzjnJBUAgXYaYv
         sp7Em29sQrulsg986lYDt1eSmNqZfrE6YMIxmUtlqRGuD/3wAQk/uR/YhVZlWuB2O88u
         oqS+NnU1hR3fvghlb75dsOpGL1ZK3zr2eUZmEfeSEsxc3WNS5urTuw9dW0CcsDxkJCOB
         xqzALZJYMDkAVBrqaVvIFwyylkIZ4+8t4M87GeZhzBeqUunhWkvUjrcRJRJBSwjfxJ0n
         xP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723712135; x=1724316935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vnLL3kbPXvkotUPyNMjX8bBOkSvxIBHQZGgdMJco+g=;
        b=mD7vIYFfI0U8LHUZvyTPbcTV06rQ+TXBkFkSqsJnDlJGimbA7eF04NrQZfPXbX6ddu
         /Ay0UuMxk9BhroOZ1XrWoszFW6220MMFL9osW2bYd+e/Jry1VRpBnuxmUQRaGgvEiYpv
         nenFj1D1Dbl4eyDUeASnixH4WHKauwqyupbGbezJA4b2ViRhgD5XCgI5ZT2QK6D8gHc3
         cRkaWiNTi8vv9lk94kDj6HdjOTCrx9LEjGnLYeRC+fq5bSbWL1SBviY4xEJ+oCJoQjUE
         IgtmTrCg8ZIdoweQ0KvnHQY8MU2+unY4AJG6TFBn3w+Q6l6ThXVXrdFXEj7GngdC5cI7
         VDMw==
X-Forwarded-Encrypted: i=1; AJvYcCUj+3gckjgUCI6BeqC6wSH5+OX5dVnjNLxzAPec4mLncFt3Y7VMqXFx2PMtLGflA4cCGngqXnR27mYNMEeMDEzv4/MAB/ijKHGaRTBu
X-Gm-Message-State: AOJu0Yx5cRHUFqKB4CN3b0z9w082nLMi4pEH7dBFKAcQI6gRxoa8vbav
	uuQtxYMFeJWnv4clZK8LpLHTWwEapXfk1KBqAPqtg9fSzG7kdijF0tmY1V+fhv2CNDs58KrZWb3
	e2zGcdTj42EJdrImAQnWVFGHtW1I=
X-Google-Smtp-Source: AGHT+IEMsGuvOnnlVvDqfxlTE6uF1abrIIwQj2PNoQyRCmB0mY4VFRR18hxk76HzLAnSmCaeb4Q1JX6ZLkjaTvS93Rk=
X-Received: by 2002:a05:6808:1706:b0:3d5:60fa:d717 with SMTP id
 5614622812f47-3dd2997e006mr6082073b6e.41.1723712135319; Thu, 15 Aug 2024
 01:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815030403.832489-1-zhangchunyan@iscas.ac.cn>
In-Reply-To: <20240815030403.832489-1-zhangchunyan@iscas.ac.cn>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 15 Aug 2024 16:54:59 +0800
Message-ID: <CAAfSe-tDw03TNn7jRWxZfcxyEL=efUURAU6gsWzoanXHAtTLEw@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] riscv: mm: Add soft-dirty and uffd-wp support
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 11:04, Chunyan Zhang <zhangchunyan@iscas.ac.cn> wrote:
>
> This patchset adds soft dirty and userfaultfd write protect tracking support
> for RISC-V.
>
> As described in the patches, we are trying to utilize only one free PTE
> bit(9) to support three kernel features (devmap, soft-dirty, uffd-wp).
> Users cannot have them supported at the same time (have to select
> one when building the kernel).
>
> This patchset has been tested with:
> 1) The kselftest mm suite in which soft-dirty, madv_populate, test_unmerge_uffd_wp,
> and uffd-unit-tests run and pass, and no regressions are observed in any of the
> other tests.
>
> 2) CRIU:
> - 'criu check --feature mem_dirty_track' returns supported;
> - incremental_dumps[1] and simple_loop [2] dump and restores work fine;
> - zdtm test suite can run under host mode.
>
> V4:
> - Added bit(4) descriptions into "Format of swap PTE".
>
> V3:
> - Fixed the issue reported by kernel test irobot <lkp@intel.com>.
>
> V1 -> V2:
> - Add uffd-wp supported;
> - Make soft-dirty uffd-wp and devmap mutually exclusive which all use the same PTE bit;
> - Add test results of CRIU in the cover-letter.
>
> [1] https://www.criu.org/Incremental_dumps
> [2] https://asciinema.org/a/232445
>
> Chunyan Zhang (3):
>   riscv: mm: Prepare for reusing PTE RSW bit(9)
>   riscv: mm: Add soft-dirty page tracking support
>   riscv: mm: Add uffd write-protect support
>
>  arch/riscv/Kconfig                    |  34 ++++++-
>  arch/riscv/include/asm/pgtable-64.h   |   2 +-
>  arch/riscv/include/asm/pgtable-bits.h |  31 ++++++
>  arch/riscv/include/asm/pgtable.h      | 133 +++++++++++++++++++++++++-
>  4 files changed, 197 insertions(+), 3 deletions(-)
>

This patchset applies on top of v6.11-rc1.

> --
> 2.34.1
>

