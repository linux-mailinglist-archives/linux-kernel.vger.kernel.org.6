Return-Path: <linux-kernel+bounces-513116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87CFA341C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180783A3FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B237281358;
	Thu, 13 Feb 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="mBdkXQ2f"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A6281345
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456235; cv=none; b=O9lMiFZDvPFDoZVtqIeRZEHJdlUuINerTS5dGTUjGW89yvDMmZUbJh2lMDloKc6omtPkS8aY1DooGxK3Gv9+Q3bQfZ+wX8k72BeEkrr2CkxvkTxx19tjvxpCd+dCxSByGufr2MbLFfHJYP6++XEhDKe3HNCVTSVCe8DoK69UPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456235; c=relaxed/simple;
	bh=/mY48pFDXxj6a+JwYG2IJVoNuPx4K0DlQ+fKdubCr2g=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=S0qR9fd06k/sQzrBPXZkdXTbWbYp6XV/0j05AXkVkMo6XETtHL6Su1xEu1MygJG+RMygwub7/QXYaeMr2c2LUcDViJbyrn8E8h5vaj/9fPC5C8C0e0mc8vVEx96jA4lhhoU2L3NUNtl9sWw2zRa8luqZ9G9gahHjU3bY5sYqRL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=mBdkXQ2f; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f6f18b474so11127565ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1739456233; x=1740061033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Th6lX7yB9qjmpn3x3XWkX4vhyaraeYuwBL7xGtC75O0=;
        b=mBdkXQ2fUxQEoERAdR/GPjQh+Kb/L6qzxDYUHEQAxF8pqQq2YLg3mP3IZYhzFrmTZI
         xyUwXKgz1YodOu4vHLFFoTGArJZndn0KLEGKZMwWE7HXEVFQUB/OOeakTSLM3zxUqCOt
         CtqPjJyDGQtYC55DSsiEMnwboG0bXvgmgX0JyvKXS/QAI/sQaBHafbQZ4jX+srZD3xhi
         bNlw46Iv8BBbSOaXYRsjHKgTR3HvfJmHa7B4VBMm9rC9oZ2/LVB4V5BhIOwjlHeftDSg
         Efa6vkAvMpJyuZIqPwetmYbf7EEcsb9MqexjQTb7kScolb+jQ9rhep6w61hvHWzKFbLz
         3HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456233; x=1740061033;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Th6lX7yB9qjmpn3x3XWkX4vhyaraeYuwBL7xGtC75O0=;
        b=ET7gDtmlqqoZeT5Q56B0rm9ye+4T+r9ljoKGFYXflym1Xujm6/AR8ic9das1TJmi14
         AbbE8t7YpGhyStRW1xkM5rjmoDZcVAXUIO6C2QlE1YOy2b+rdxPxAqZXnVHcVgZvyJMZ
         QeFTF0eMR/AICn6EKfgBY/DwnHWknIAQ8Gh6nH16yIFTRvdzOH9v4kmX8FQuhYjUJ5aA
         AMwTnUEzZ1pNH0cayOMWhSN/M0DjBqD2R6i0wK8JfGQusxK1EiZrvQTpf/5+BZOvLhwB
         xwNrLytUnf9AZX9pAJ6ZvG36xy0ZpicxFwv1+6eKjdp2DH2SupsAPnKJBCUsD8b8qRX3
         IFkg==
X-Gm-Message-State: AOJu0Ywh4SBwMd36o6kf1D4nEhcfanNXYb7yE/Wk/jw7eZ9wfj11nV51
	u74724jJ7ut8ADH5dyxZYdU5V5jI4ucxunWpzUzupdKvnc1ZUaWgy3JRV+26u/DHfbj7eitD5Ak
	q
X-Gm-Gg: ASbGncvi0pNE9C70dhwgPmoGwfVo5p9dDPmDoaFjH1gNS7Zfgwrj1gwlGCI0zcElaHO
	IPUgCdV0zoBAiLktrEsGqFGMa8oxLvIsoBgIVZIWv2Ykg23wimuvgmng9iLXeJQDyx2HB+0FhLY
	o2RXkxXmpwbsakds0bLRBuKR4eQKKqghCUJBsyUWLujufDPZgQnRjta5OqfYmQOGkfpeH5C/KcQ
	D0hc+n7hW4SfQpBHH5qspHaHxpZN3ETXiz0QmkaPtYEacFLI3L66t+UFXi7slza2sS1bqZDIYXo
	DUjxFRAoMI6N
X-Google-Smtp-Source: AGHT+IEGdbnZBMKZzS1Nj16TfST25tvEcj38W13TegR/1BDT0XWfns6gOT9rmswIL2lBD8LhXfdYvA==
X-Received: by 2002:a17:902:e54a:b0:216:7c33:8994 with SMTP id d9443c01a7336-220bbcc6cf5mr126074435ad.53.1739456232785;
        Thu, 13 Feb 2025 06:17:12 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556f97dsm12958985ad.172.2025.02.13.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:17:12 -0800 (PST)
Date: Thu, 13 Feb 2025 06:17:12 -0800 (PST)
X-Google-Original-Date: Thu, 13 Feb 2025 06:17:09 PST (-0800)
Subject:     Re: [PATCH 0/6] riscv: Relocatable NOMMU kernels
In-Reply-To: <20241026171441.3047904-1-samuel.holland@sifive.com>
CC: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  akpm@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, alexghiti@rivosinc.com,
  samuel.holland@sifive.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: samuel.holland@sifive.com
Message-ID: <mhng-25ab7f97-42b6-40a8-b96d-d387cbf54ad1@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Sat, 26 Oct 2024 10:13:52 PDT (-0700), samuel.holland@sifive.com wrote:
> Currently, RISC-V NOMMU kernels are linked at CONFIG_PAGE_OFFSET, and
> since they are not relocatable, must be loaded at this address as well.
> CONFIG_PAGE_OFFSET is not a user-visible Kconfig option, so its value is
> not obvious, and users must patch the kernel source if they want to load
> it at a different address.
>
> Make NOMMU kernels more portable by making them relocatable by default.
> This allows a single kernel binary to work when loaded at any address.
>
>
> Samuel Holland (6):
>   riscv: Remove duplicate CONFIG_PAGE_OFFSET definition
>   riscv: Allow NOMMU kernels to access all of RAM
>   riscv: Support CONFIG_RELOCATABLE on NOMMU
>   asm-generic: Always define Elf_Rel and Elf_Rela
>   riscv: Support CONFIG_RELOCATABLE on riscv32
>   riscv: Remove CONFIG_PAGE_OFFSET
>
>  arch/riscv/Kconfig               | 10 +---
>  arch/riscv/Makefile              |  1 -
>  arch/riscv/include/asm/page.h    | 27 ++++-----
>  arch/riscv/include/asm/pgtable.h |  6 +-
>  arch/riscv/mm/init.c             | 97 ++++++++++++++++----------------
>  include/asm-generic/module.h     |  8 ---
>  6 files changed, 68 insertions(+), 81 deletions(-)

I'm getting some build failures

riscv64-unknown-linux-gnu-ld: arch/riscv/errata/sifive/errata.o: relocation R_RISCV_HI20 against `tlb_flush_all_threshold' can not be used when making a shared object; recompile with -fPIC
riscv64-unknown-linux-gnu-ld: arch/riscv/errata/thead/errata.o: relocation R_RISCV_HI20 against `riscv_cbom_block_size' can not be used when making a shared object; recompile with -fPIC

