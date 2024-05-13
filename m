Return-Path: <linux-kernel+bounces-178185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584AC8C4A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2B61C210A4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C3E85936;
	Mon, 13 May 2024 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0DMEE5N"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2620382488
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715643975; cv=none; b=Js2uEKiMkf8+M6bQervgq1CLNpk2FWF9WIisqhCjZmKRcezuph9cMdSAAQBIfFGGOduRGPuxPVEqbUyy3JwFQHozPhbMI5QcxrSzCb21TZTHYrqQzwsjYQCpRubuR/RaVtiPmyaxp9fzDfF+phDWs9vKEaHsdfVKnhYpYM5c9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715643975; c=relaxed/simple;
	bh=AAdoFPqByr+rSZV5fnbb1g3bDcI5/e0JDBu1rdESPU8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mcOPHS3mlsclYaPWyyLGI70p6h7AKM4VFYC5VdU4woxP7nT1EA7aXrgcPMCeCE/R44Q5BqwJYN0ve/4dZk5zQlKVQ2g5OhlovQsC9m70b+M7rYDuXcbHklh1uyF1k67/MYJ6dQGlf114kQk7bBjZfVEXwrvlErhH6yV5VAhrhsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c0DMEE5N; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso3802a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715643972; x=1716248772; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DYyPp/GZh5UOQMAPDnHfvV0S7X7W7YFaMKKEzXMQZG4=;
        b=c0DMEE5NRO4Y0Lnf/ikNn2o1vk11p2ZVcnL7pIMD0I/R4eEShWBTgpCZQ50eDoVvD/
         V4XCQRdzN99pPACrqUvlf0pgrZc8HYYUpL+IvYvZmpHg0ciUXTQfFBBWo9qfnP1pyB4P
         67ktNKzixRUVH1vMP4y6qGZCAMUo/qn3bIKD+PHYnPYMQP2z1THrkDeC84VagxOVqsmT
         QZ8joN02RJdGULYTNivBKIe8JAg23OjCbVtI8GjaIM+4tAhsuNtnbyRvVF8aO+9VNcPa
         80JnidbmHtySfeT5pGwo/paAAQIDJoKU0pTwmcNFavYFUJyNjHg4Hvb81MWr1BP43tqR
         T4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715643972; x=1716248772;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYyPp/GZh5UOQMAPDnHfvV0S7X7W7YFaMKKEzXMQZG4=;
        b=w52a1MYqvmUguSj444olAjiZEqAdjSGBLjVrgiQlHWGu6TChfxix1xzWDyHdlT7023
         VvsVLfZf3FjMF/Dv8b4XmPpE6PoRR7TldKhUc+ZKDX3gRUz3GEBHk9PjvwD3Eku4zdek
         SJnStu1yOGeQjW2bOAqladDKWqLhqVHnazf+DhFoMygAIQjrLTAtswEu7NXPOeUujiBS
         q/lOGALCYWD2D+ipHWBM59m/dLBAQ0s0eQH9TThxJSsFN+HNfkNqC3aVXdIC7jilkpQS
         tkk5jYLukpkV+Be+z3FKVogxcMqgd1fThdJrzv0m9ktAMQmsQaP3agePzErVJjNe/XtN
         ooHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEeat6bGTArs8OEZY1dE24fcYiDOZxSRiBEjjX9vPfa+CdIiXa5um8eLXHZ02axktflw5DpG5ykiUqd+D3Ua5yr95dJtCQ+tqwsKsQ
X-Gm-Message-State: AOJu0YyriAJCL0S1yDqe63ecTIxiAhzbGTFLWDE7PtHM2jP2sPdp1/fY
	1krZmSvEFds1x2AM/KoJYL8vQpEgfgZW6LY2LTidtO0R+ax8/HlpxPljx6eyBjWnkblIHY7yg/H
	+KXh/CQ/oH1OPz3JfiNl+uNtKm0o36zWcJFY=
X-Google-Smtp-Source: AGHT+IHC36aGzMD1bT5d5MO7nX9+nNZe1zJ0ciaXZgrLAtGQ6NmzdofJpU6zKL3UG1/jTyQ0JMKkLLAxFRHXH8B/dVc=
X-Received: by 2002:a05:6402:1e87:b0:572:25e4:26eb with SMTP id
 4fb4d7f45d1cf-574ae5d8176mr396424a12.7.1715643972027; Mon, 13 May 2024
 16:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bill Wendling <morbo@google.com>
Date: Mon, 13 May 2024 16:45:54 -0700
Message-ID: <CAGG=3QW4b9mqh9oGQ16NmMGbo4HVHmdM00Be1Qk97StCpW4xTA@mail.gmail.com>
Subject: [PATCH] hpfs: Annotate struct hpfs_dirent with __counted_by
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Prepare for the coming implementation by GCC and Clang of the
__counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time checking
via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
(for strcpy/memcpy-family functions).

Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Bill Wendling <morbo@google.com>
---
 fs/hpfs/hpfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hpfs/hpfs.h b/fs/hpfs/hpfs.h
index 281dec8f636b..ac137787f1f9 100644
--- a/fs/hpfs/hpfs.h
+++ b/fs/hpfs/hpfs.h
@@ -357,7 +357,7 @@ struct hpfs_dirent {
   u8 ix; /* code page index (of filename), see
     struct code_page_data */
   u8 namelen; /* file name length */
-  u8 name[]; /* file name */
+  u8 name[] __counted_by(namelen); /* file name */
   /* dnode_secno down;   btree down pointer, if present,
        follows name on next word boundary, or maybe it
    precedes next dirent, which is on a word boundary. */
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

