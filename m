Return-Path: <linux-kernel+bounces-380465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE8F9AEF15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF651F23C82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B8B1F666B;
	Thu, 24 Oct 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="qNLLN7MA"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0321A2003D0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792851; cv=none; b=EIUKczyejNVwfkcPMSfBoJxkgI/rCK+yZ8dtrI3wb2wgSOi2EDEFvQ9w5WUq7qaEUnyA9UGXUOBc97xQP2T5J4qlExASA2yhaZLuCBaJqZOAoDKL+NYzdAyhSHcHrObXdPI0X0ftUa2+6Uq2GLH8zfniQRFXFo1949Xhn2FoGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792851; c=relaxed/simple;
	bh=cn5X3AkK7SOjJzCQhPem5vUa0eeAjshXQ8pfClrIxnw=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=tCTlCvBelRwJJ3vvMl9ZWC+lfPx/5dWAky6vSk3cIc8fRZCkMhPu/mdhAMCX2lrkAaqf56CNpCbP1LX0O1gjc2ozb446ZfSuQl//5jwGtNc6wr4RWqAinSjPUg2ydXLosIyePwVSiKpGfhOViQy7vh6Tul4awuZQaW5XWEX9h3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=qNLLN7MA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso1627181a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1729792848; x=1730397648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKFTwGg9t3aAI0dYQJFy+Q5hfy/zjV2LsgAZPzWGPLI=;
        b=qNLLN7MArs8s66Dzlfx5HiXe/kUTvJ1i5iGW2X7EwnmwXZj1wNR2pOMgzKvW4FWkwx
         rQNMpp+Sphfo27EeBFJ0+I7ZyBKewrJjRYs4OHdpO1ljcYtj82E6LABBS8FxubkqFlzL
         hClovLi+pHfgDG7bTkA42BpVrrL8u1Jyt+ATRslTKt+/sJknizrWao5S6t17+59ubUqe
         aWebEVoI2tO1EZuQVYBykRZESKGyLXmkk1NpNLNmUrsAxuMrHfWQ2vqwb0wR/PRJFNVG
         vMuiwQDB86FndXNpiY21uhsLRHo50ZbPbLxlFEasLwDHwKueBnjMswt2dp35bQO0/s5c
         WBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792848; x=1730397648;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKFTwGg9t3aAI0dYQJFy+Q5hfy/zjV2LsgAZPzWGPLI=;
        b=C+kK72X+Rh4obCt0gcXDURNaEoj7L1FOFWzRKUQe711TxvFdLFo+qBFa7gZeor5va2
         /n9CO3nQTgToP4co7WjTBfj20zhITZMDNq75+bz8Pa2m7b3obqcIa2Jdv5lMu3AbOtZ9
         7lGRn6+yko9nivrpi18zJXr2wVX8LBtoRcS34RGFoH3mS1ShOj746p8vQhTwpuZcfPL4
         Ec0wpBwKPN+Z1+93F0bUJM2Ife4PnCcMcAVnJcogreQIMRyq1On6MN8yzwusUdB+Retz
         0zZ7hSTPBJ63DWGcxrd52UJl4fLK7xzR6AYNGArLhcu6Bbm9MaYIA/XMiO56AyykUsjv
         rPeA==
X-Forwarded-Encrypted: i=1; AJvYcCVQUW3KTTrECwDvX+six2sw2thtwUX/f2IT4rpqBacSxdX0KvKvzRYedXEbU+tFGtweXSBmoyDSCGYeh9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgAXTv38+2zV5UCh9Jsy7oylc0ypgN57MJPzpmvfximGgANAt2
	L8f/Yu3X4AmZCsQOlMwLU53uTTgOU0hgTT8H6O56jhX2tXhfcSpDqybeLLTdJCI=
X-Google-Smtp-Source: AGHT+IGiCgZKgSuJv93hUr5hChCUjQsiSQq3PX+NDu60a4swnVwA7uAJkOhnlQF4ihAdw8OcHOqkVg==
X-Received: by 2002:a17:90b:3b91:b0:2e2:85b8:14e with SMTP id 98e67ed59e1d1-2e77e7dca22mr4650526a91.15.1729792848304;
        Thu, 24 Oct 2024 11:00:48 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5df40bf66sm4706770a91.0.2024.10.24.11.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:00:47 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:00:47 -0700 (PDT)
X-Google-Original-Date: Thu, 24 Oct 2024 11:00:13 PDT (-0700)
Subject:     Re: [PATCH V2 0/4] A few fixes for RISC-V
In-Reply-To: <20241008094141.549248-1-zhangchunyan@iscas.ac.cn>
CC: akpm@linux-foundation.org, shuah@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, alex@ghiti.fr, Charlie Jenkins <charlie@rivosinc.com>, linux-mm@kvack.org,
  linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  zhang.lyra@gmail.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: zhangchunyan@iscas.ac.cn
Message-ID: <mhng-539e6cce-55db-4170-b3d6-cb63e7ec0a25@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 08 Oct 2024 02:41:37 PDT (-0700), zhangchunyan@iscas.ac.cn wrote:
> These patches are all simple fixes with no strong dependency though,
> I hope that making them a patchset will be more convenient for merge.

It doesn't: there's two RISC-V fixes and two MM cleanups, which makes 
stuff likely to get lost.  I'll take the first two, but you might need 
to resend the others.

> The patchset are based on v6.12-rc2.
>
> Chunyan Zhang (4):
>   riscv: Remove unused GENERATING_ASM_OFFSETS
>   riscv: Remove duplicated GET_RM
>   selftest/mm: Fix typo in virtual_address_range
>   selftests/mm: skip virtual_address_range tests on riscv
>
>  arch/riscv/kernel/asm-offsets.c                    |  2 --
>  arch/riscv/kernel/traps_misaligned.c               |  2 --
>  tools/testing/selftests/mm/Makefile                |  2 ++
>  tools/testing/selftests/mm/run_vmtests.sh          | 10 ++++++----
>  tools/testing/selftests/mm/virtual_address_range.c |  4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)

