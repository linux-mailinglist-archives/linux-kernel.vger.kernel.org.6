Return-Path: <linux-kernel+bounces-521356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D17A3BC26
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D501A3B6714
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37F1DE899;
	Wed, 19 Feb 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A94TBx4P"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD9F1DE4FA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962566; cv=none; b=kpZ/1kt3Lyqm4D1b8ss85XPLk5YDPzmPh8aN7gD//YYTJgyfgbEXXNgDi6K2erMZBW/TeRxg58PaHXItSPp7BXAgNjVT0cHUZ+amlehewZMkM98eEjMOOS3DZIM3Uj/MUweL1bGkIcUc3Rb9KrXhOXJyoV0EZ0RZismIUAqm3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962566; c=relaxed/simple;
	bh=cF0+Y6p/EkkU1e7y3Q/w7PZ8ECL+RmyCTsNBFV3FKtc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J1HefAw+Erj2KSrAyS2XWPh3k3Ufg0HWLawLX7Yxboe5wfK0V7Al69Gvki38A/bZE8ePF7sF6Kz1t6hPEnQnwspOwjP0wHX+wQXO3baBIrNdhPMbev7u7ISffAxnrhWRoVMSkxQtTNh/MZiCrBYK+lXrl2k8ZWRAPpix7/cQJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A94TBx4P; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43988b9ecfbso14641295e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739962563; x=1740567363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FsXUS9CeowPMfI55zYwVGQzkKFBgfU5GEvUXhIe1vDY=;
        b=A94TBx4P/Y+Rq0SbepZkKfZPD/sFUykoJxgYsnkC35Uk7gH9O3gSXMC5AWHw3hHvx/
         93d4VK7EjP1O2CZK02xRHblwLjcA/K/xX+ep1otfp+n/auVbxgWPCd6klgRr7XJsm3jB
         4XeCNC0KGRIyNH+2RhNhZKrDnqYVQ9aKksI+rlpxRyKyro183AnT8usiwAH+GECqSAcf
         pP4/A+AYswccEx0QMgyi1eTqzde+ZJomBE0EhWbaq/10MII1xA5I5DPibXxEytPFUb2s
         CO3Xx1A0D9iL5SUNX7/ze3hZaVYo051JjFDWo8cFdeRzOCQTse5kOqlTSOzTGEviFWOH
         JAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962563; x=1740567363;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsXUS9CeowPMfI55zYwVGQzkKFBgfU5GEvUXhIe1vDY=;
        b=FQ+oH46pX9Swm6+I2QOPxNipwUeWkuy3iTJQYJOh4maC3Jl7Mwi28WlEJV7nYXqMUX
         VskP7Xegz9qoaSa8OKHMpXbXXP5mAWBvodKgC7pKfEUBK4TyiSO6RbILEqIn16KHs+iw
         /NX7mq1WRS5xDgnMSFQmewyqa91OG2KsxZjZ+gS47mAgM2ydzqO9qMGyzCRAMpbQO7z9
         dA0xbs/BlrjYsZTcEScMYIf0z8yd4KXqMxGWomDnEUI4I32iCPjlwJJ9aQv5cAXagINd
         og9VBtzHiTlveiV+Ny/15vrd5lTINOPCXz0ixlgIoXZ33sOKvLPgvjF5jxzUD328hZwv
         ADGg==
X-Gm-Message-State: AOJu0YwnwPba4lz1qkOopRD9Oa00eEb6rBwtuteefi2QgZ1l+rdeK5xq
	fZHsH1vGl8WIsGzsjt5zPviNeAFi4SU+Is/t+738QBE0pYyQrZVbcCe1LvcV1u3fjcScTrfxqiP
	HNNbUs0dcxEGUwgeRTagcJgBc/kDmx9pyvPQSqF5KL92KtvzsON00VjQxN8gSa8beRG43CNF659
	DLwIPt8oEZp3vo9J+jHZLMzQGpysMJqA==
X-Google-Smtp-Source: AGHT+IFm3H06hlJlG6v4lgMB9xk2MWch77NDL3YqhIK/Xn/ajJQEy3uIIjFN4wGCklDaaOiKgUyhWQa5
X-Received: from wmbg23.prod.google.com ([2002:a05:600c:a417:b0:439:95b9:9200])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c86:b0:439:8346:505f
 with SMTP id 5b1f17b1804b1-43999dd21e9mr26792855e9.20.1739962563056; Wed, 19
 Feb 2025 02:56:03 -0800 (PST)
Date: Wed, 19 Feb 2025 11:55:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=ardb@kernel.org;
 h=from:subject; bh=aUT9I+MQdR2FNRJfxqBoAlTHUCqvqY5/1Vn0rSgbDXE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIX3rjvXcF0K+xOv4/r7u4P7v8o+qw9fjH81IvST6MSSSY
 Z4tv9zpjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARR3NGhllJTvH6/cl6VcGb
 GadZymx8vDDPjeukREP+POGfTOXLHjP8lep0Fjhz6aXEV4FEhn1W/CsD/sT2Ox2+v3JZx4wm7z1 MLAA=
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219105542.2418786-4-ardb+git@google.com>
Subject: [PATCH v2 0/2] Handle .data.rel.ro correctly and use it for BPF
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Huacai Chen <chenhuacai@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

LoongArch uses PIE codegen for the entire kernel, which has some
implications for how .rodata is populated and emitted into vmlinux.

Changes since v1: [0]

- Always use .data.rel.ro.c_jump_table for C jump tables
- Add Tiezhu Yang's Tested-by
- Split into two patches and rebase onto Linus's tree

[0] https://lore.kernel.org/all/20250218092538.1903204-2-ardb+git@google.com/T/#u

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>

Ard Biesheuvel (2):
  asm-generic/vmlinux.lds: Move .data.rel.ro input into .rodata segment
  objtool: Use fPIE compatible ELF sections for C jump tables

 include/asm-generic/vmlinux.lds.h       | 2 +-
 include/linux/compiler.h                | 2 +-
 tools/objtool/check.c                   | 7 ++++---
 tools/objtool/include/objtool/special.h | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.48.1.601.g30ceb7b040-goog


