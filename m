Return-Path: <linux-kernel+bounces-234207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F691C3B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA941F21E73
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F381C9EB9;
	Fri, 28 Jun 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ait4nsXX"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A51B94F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592019; cv=none; b=sJjwZlsiiWB/ExQuoMdg3/SrhplwkXFT3YKnlR6isWzzWpq1QqyQYv8kRg1/FsX4MxvtiHoptZ+YIf/4MbODFac0y+IBsabz7sE910uLamkfJ3YyFpTn/buTNHctkQRnc//813/fwWDczYMUsBJkoUl1ixYTcZpIBm4v4alC0EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592019; c=relaxed/simple;
	bh=oNoEM0nmquuoqMKzBk034g+C5uIVSrMz6TVoZP8ubUo=;
	h=Date:Subject:CC:From:To:Message-ID; b=E1hw+spOG0oHzo/VJUeggy+SgNKedFjBEafEcBDs1O/rmOnCbHDPZOskIuOv43tc/ztklJQ4FhAU2OFI3YDRkEQ9C3YTEUKhqzyaor1PCHDhdgeyim3ENxr58V2izPxWTAnadEqP+g6CUYejkz15vhziaoqyJOQ/bLXBsyfUHMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ait4nsXX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7024d571d8eso678888b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719592017; x=1720196817; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brRQ/jaSotneML2IT6EImsPLrw/XqO202b78nOa1wkU=;
        b=ait4nsXXlzjabGe1QyzLX4agkq7jVFYNT9gZRAP6m/qAjllmGh5Pmhk3bon0TuUVhX
         xFtix9XgW0vB99p0sxTPLqTTpG5uX1+0LeQAvvXbudprnzdxlxyla2aR9NJE/DCnpcLq
         Ejpv3bLAxlCwCx5IReD0bDq2vqPrOXOZ/mApRpLpHYg2GIRcVSvoOdJd411qOmJxsGlP
         w4i5HhSZHbPRm0nM3f25e6DEyeaod0hN5uHXCeXkzjFGQCIZaXnMQpq/mJj4rhZZ615p
         ukXNM1J1dbXTDxyL1CFKSioHmaxplupOmZIJJk97fBvt+zgpMZRK8w9aRdedAW+UfFVk
         qROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719592017; x=1720196817;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brRQ/jaSotneML2IT6EImsPLrw/XqO202b78nOa1wkU=;
        b=sLAzTK4O6yG/PMF5nel+kDMOK11wfBA9ZtetyYACp/pKSk8d0bgU68x21OShOKsjuV
         hqVF9MLH0zUAY3SFMF3LXvxIHqhgFa2p4sSGzJs9c3vvYHGj1NDxxxET1dS77OCANHqJ
         Y9seY5QE3lioOytgEuMJLKI/oTRZsslxCuQP6/PGjFhXW8z6PZIdRTxT2dgbytT8mCnB
         +UJGAWHBnTEpwlLnuhLF4vUfRrIcKgCW+s6wiU+CvVNVHJlzuMDa+a9oR2lInilv5B3v
         CHvAFnutc3cU79uwoxQD1tZ9LcxWoVfI3VDXediiKZZfqWBE1Ufj2cnCiR6byHVcdgEl
         5Mlw==
X-Forwarded-Encrypted: i=1; AJvYcCUVMexACgfoBbTnE2zdhUxnVp4j3SxfRCf7kscZFK2a3idkrcLbAf7H6/cc0SgIwmEzkXVgaUq/TWYQYaXVwNmvKXVhr21RZkR5LXy6
X-Gm-Message-State: AOJu0YyyiQf5rdYOH/BrQb95iVl5M/AG2CaJIz4QIRv2OrhDHZjMzTji
	wD/mLXFog8L5vfl8AcHXwIni0gsYJl/CQfoma7e3qdi0d2OYCmUBELXRd8tGDR8=
X-Google-Smtp-Source: AGHT+IEf8FuUY5fwtTIh0sCAujV/7yZT+yOZ0P5CdUNlMqj9i8bgimZ5q3CMytDBPOraVn0kGdHdvQ==
X-Received: by 2002:a05:6a00:3d43:b0:704:2563:5079 with SMTP id d2e1a72fcca58-706746f6a10mr24303576b3a.27.1719592016718;
        Fri, 28 Jun 2024 09:26:56 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080205c688sm1810627b3a.5.2024.06.28.09.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:26:56 -0700 (PDT)
Date: Fri, 28 Jun 2024 09:26:56 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Jun 2024 09:26:40 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.10-rc6
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-e131a037-69c8-423a-929d-e2f03e979ed2@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc6

for you to fetch changes up to cc2c169e34b4215f73c66a34bd292e9e1fcaa3c9:

  Merge patch "riscv: stacktrace: convert arch_stack_walk() to noinstr" (2024-06-26 07:38:02 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.10-rc6

* A fix for vector load/store instruction decoding, which could result
  in reserved vector element length encodings decoding as valid vector
  instructions.
* Instruction patching now aggressively flushes the local instruction
  cache, to avoid situations where patching functions on the flush path
  results in torn instructions being fetched.
* A fix to prevent the stack walker from showing up as part of traces.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: patch: Flush the icache right after patching to avoid illegal insns

Andy Chiu (1):
      riscv: stacktrace: convert arch_stack_walk() to noinstr

Jesse Taube (1):
      RISC-V: fix vector insn load/store width mask

Palmer Dabbelt (1):
      Merge patch "riscv: stacktrace: convert arch_stack_walk() to noinstr"

 arch/riscv/include/asm/insn.h  |  2 +-
 arch/riscv/kernel/ftrace.c     |  7 ++-----
 arch/riscv/kernel/patch.c      | 26 ++++++++++++++++++--------
 arch/riscv/kernel/stacktrace.c |  2 +-
 4 files changed, 22 insertions(+), 15 deletions(-)

