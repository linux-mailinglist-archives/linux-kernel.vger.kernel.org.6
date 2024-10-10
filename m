Return-Path: <linux-kernel+bounces-358972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADFB9985E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0622028201F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685D81C57A7;
	Thu, 10 Oct 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBW0mfP2"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E061C579A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563296; cv=none; b=Lqu7ut8312HgLO2HxjqFjzg/iJW4o4JgRF1iZgcTFfl2iLXRw/4K5bhBqBQqB9Ry8y6U9JUo+vcH286MdfXthFueGzV6DdQbrnmi3ebjAxUTk1osYwsqp3eRVcnqulI+NIxXOsoftJ2azDd0IVcoinwj7QMVaG6BcVWM3Cbrh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563296; c=relaxed/simple;
	bh=9CZ10MgdUs33tVMefWojRZ9mEtCTbVIyu5tPpcOoyo8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jLWcCWyUnLDZqAcQ580RrT3BNUpuzvkLDa5e4fgG378ZJmJmToC8rwWapnRPydZFS5sKZ3j2dkU7fYj72/ynCvpm2OhQoX7jpO3Oivwe2ttDiq5aRu7A6kDP1dGQEx8s6vYx1PPggAXfiRQ9IMFqAETVyxo7y9wDApsqNGzG8Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBW0mfP2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so1211944276.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728563294; x=1729168094; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xrd6A0+7MH5QHNBADjPQsyGPWVF0M+W3GXfNip5cqm4=;
        b=sBW0mfP2gPidIWlE0u+K+8YdPPTkh2c30kDFFNAf/LB6OGHZguEEr4K24yIriRB6Om
         3ridnKeYgBJvO6sZzr3+QBIx8mTeaC3gsSr9QjowbW1yQzj1fdeoiILATaUz8Vc35T0H
         NZEsVBIqeNkNYcCAoFRB/3OEdRpNlm23oCvYcUlORXmN7nDuC3zb1G/lGz+Ln+beKzdZ
         bpysrj8YAHejgrjMS+6BsCklqGuJLpw7Bkr9IgA96Oa1ExVwd+2xsPODCJGMd2Ux5KIN
         ZE3Uc2/hBlnlpHjRBUK1gzO69+fgy/m7L5MpKfSJ29s9+H87Au+tGq9h0lr8fibe9KG8
         L8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563294; x=1729168094;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrd6A0+7MH5QHNBADjPQsyGPWVF0M+W3GXfNip5cqm4=;
        b=k0yRKyyho2l+z+e4BySZ+yM3VvW78mMUMm0INPKegOTzWbFnUS4HGXD8vBJPQ8smjP
         MNjfr5pL5VWxWjEC6G4vU0FtLetf6F++JYNmEd9DX/rCCuEFhQ1VsqRA6eVDscLwvNXA
         Gzaw6i9ny4eFAyl2ryvGL3lENStLHtELptcBX4j8A8vZVS7jlSDJjpHoFay6ZxlCF8oM
         MNT7Gjy8k0C7DZ+/MWg6pOjPhf6+rLPPof+KV3X4doYHrxxKWxO2JJu9rOe5IcQ+mRBD
         peNEVKiHh/7O4CHLXK1pgq0xxv0+r8Hx7ZV4uihPy3Wsi5omoqFVRhJtdWuQhA0/Keb1
         tT8A==
X-Gm-Message-State: AOJu0Yz9u2hD9ePCgc3LLO4w5fJT0x/DI9KL+LSbdWO0mY8CHaoTtEy5
	vCQf0tKlHZHYWBWy0IR4SII/8yHqsPHQXb+3ZVlLxQVFD/XNpDWTassJCZ+lpqPQJysIlIWJWyC
	VS4xWC3RlGuWTzoyAfsElt5Ftc0oAsiyMt4eWqMh8RIrp3eIo+EWCWvmlzD4GVIPxZIyeaeElvH
	GVYXnxJr60AsdNzGuAdkFu2h3VoinWXQ==
X-Google-Smtp-Source: AGHT+IGQCZqQHYW7zF+uRL/q5WaQLuKiFxw1NPqQF005s3WsaDa4bCSOkjsRCv2M8bA3TMVImRIYhD7C
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:c2c1:0:b0:e22:5bdf:39c1 with SMTP id
 3f1490d57ef6-e28fe45b504mr3788276.10.1728563293508; Thu, 10 Oct 2024 05:28:13
 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:28:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2776; i=ardb@kernel.org;
 h=from:subject; bh=pt3xJmvifUh1VzI8I+YsoMxUTjanH+VXWtq5UYuOa4s=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ39RFDLxT8JElr3ZoiZXJPxy/tf9e/KJ27Dlh1bVu00T
 Tnv376lo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExEZSMjwyo+Y3Z2IZUnCk23
 dnn82pM9+cVEawVlx/uXDf819NsH/mZkeCAmyeXpybmk4WF5a/KJ2z/4lmRarbtY6PbaL5D9z5t 2DgA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241010122801.1321976-7-ardb+git@google.com>
Subject: [PATCH v2 0/5] Improve objtool jump table handling
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Jump table handling has faded into the background a little due to the
fact that jump tables are [currently] disabled when enabling retpoline
mitigations and/or IBT on x86.

However, this is likely to come back and bite us later, so it still
needs to be addressed. Given the difficulty in identifying jump tables
from .rodata references and indirect jump instructions that often have
no obvious correlation, it would be better to do this in the compiler.

This series implements [on the objtool side] the suggestion made at GNU
Cauldron this year to annotate the indirect jump with a R_X86_64_NONE
relocation that refers to the jump table, and ensure that it is covered
by a STT_OBJECT symbol whose size accurately reflects the size of the
jump table.

This can be wired up in objtool with minimal effort. The only
complication is that indirect jumps may be direct jumps in disguise, if
they target retpoline thunks. This will result in more than one
relocation attached to the same instruction, which needs careful
handling in objtool.

Other than that, changes are rather straight-forward.

Patches #4 and #5 update the CRC32C driver, which has a jump table
implemented in assembler, to a) use a relative jump table, for
compatibility with linking in PIE mode (#4) and b) make the jump table
more difficult to identify by objtool's existing heuristics, but provide
the annotation so it can found nonetheless.

This series is labeled as v2 because patch #1 was sent out before.

Changes since v1:
- tweak logic in patch #1 to ensure that all jump table entries are
  covered by the same type of relocation
- use the corrected addend when validating IBT targets
- add patches #2 - #5

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jan Beulich <jbeulich@suse.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Kees Cook <kees@kernel.org>

Ard Biesheuvel (5):
  objtool: Deal with relative jump tables correctly
  objtool: Allow arch code to discover jump table size
  objtool: Add support for annotated jump tables
  crypto: x86/crc32c - Use idiomatic relative jump table
  crypto: x86/crc32c - Tweak jump table to validate objtool logic

 arch/x86/crypto/crc32c-pcl-intel-asm_64.S | 40 +++++++-----
 tools/objtool/arch/loongarch/special.c    |  3 +-
 tools/objtool/arch/powerpc/special.c      |  3 +-
 tools/objtool/arch/x86/special.c          | 43 ++++++++-----
 tools/objtool/check.c                     | 65 +++++++++++++++-----
 tools/objtool/include/objtool/check.h     |  5 +-
 tools/objtool/include/objtool/elf.h       |  6 ++
 tools/objtool/include/objtool/special.h   |  3 +-
 8 files changed, 117 insertions(+), 51 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


