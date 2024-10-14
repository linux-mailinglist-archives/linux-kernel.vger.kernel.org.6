Return-Path: <linux-kernel+bounces-364072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D6599CACE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF661F23031
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6231A76C6;
	Mon, 14 Oct 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNwsM+gj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EA1A08A9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910632; cv=none; b=haIwxWVq0T8IOwu8bPUSXDdwVCFpTuie4LJSYszzwWzlCXBPnnSZtchv8PViW0PDJffQiTxlHyVJ8rKHshu40K4BJl7lOYckttYbxWFN3rEQiemBtCvVZ0pukNFzGuXS0v6V4HXLBNiOGNVWqm4Z1mNCogrv+mOFlPhwozyAMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910632; c=relaxed/simple;
	bh=95q1qEv3AreD4xQZZYXqmAGp2B69fftSxlZEkzq05Vg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tMfTPg9gUCg4R1FSo0D8b2BcXe9vP0bE4Fl51YgPAPvw40AQEl7RtyCwRDhyREWTE20BpOCf3eByMIMpWHcfkQtTRzp0gc1Ati5KCjNa4XFS9GLtw6RnwIV49O/fg3SpPHkiNQPuFoO139A0rBrWAC0aUsJfCYBlwHRLvxpJpn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNwsM+gj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3204db795so60975327b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728910629; x=1729515429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t6li6wFeQ4E3rD2qiNU9/G5GhCLFz3hLIbapKHZloZU=;
        b=eNwsM+gjRUpqYj+RgRbpG8Fk54P2nGeDnaTest7cbyD2at/6Xg+rz+9+OS1827FL/b
         Bb18OsALStX8dzAAPUkA358aZE8ckR0vwZQsTrYK+matjs03OJw2RzibxNo/Kqe9HYQu
         SFZhBryByqQFnTQJKg7jr2vyr8V2P8ZLPCXat6atzX8FS9pnNQO7VS4DI9SMzXJ54/9e
         2puP9x2tf9fkqXL+gbK5k+3WDaygO+cwapCBiKRbP8j2o8ZpO1h9OdmqzzYxk4/ApDV8
         ifygR4ZcDgP4PQqQYjDLkq2iyP/qVY43NvS6+z52FEV4yjwKDW1Pfw196EkAjQSW/SLS
         pzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910629; x=1729515429;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6li6wFeQ4E3rD2qiNU9/G5GhCLFz3hLIbapKHZloZU=;
        b=fNx7oGeqs5Hn+Owo2zVaNv4vSLL9M0SmcbAD2BOMVan08Y5Gw2fpMIwPoGS8EqHOzm
         ANDfE5ptgjyfBOXhp2DhNHVI0bjUX0KC478W97mwu6tpaztmUnprgqbGZXB/xAOsRco3
         XgTD31NqHeP3QXR9xmkG8ZNiiVrwWy3o/dgiXW5ZgVkyxGBj6nNmtL/+l1oLc8wxEowT
         y2Z1UEA+QKPfS5POU5TydqwIGWi7IuZk44gJWHl1Vd8UumaR2SvAhdclibRKxZ9TwrXJ
         mFZLgajBiHIVEp7QvcEuDZBYJyzkR+Zme79YP+P8Ez1tL85fhnC9+EyrfBl5VRsE41ga
         hjWA==
X-Gm-Message-State: AOJu0YzPUCbuQ0QVX27bYpy8veVSgygj8cXXBkxQCNbWE2SCSmSfQhTs
	aKCSuAAj4sv+cv2xkOvmrUcl0DScJwKVGOBv2umyXF0sN5mB1nsLeMrYWWkcjAMVupsdP5jMuEW
	Rc+1vCnnYjqg8WHv1F8MfDJU4MD2ieG5LoJGmBA8Ma7VraO/ovYLm9yqPaY2+8iELTP5pmdDWf+
	PFvtb7YRv7nEhKeR+TniZpdL4Z7O1DdQ==
X-Google-Smtp-Source: AGHT+IGTU3Vxqy01+1H6TKajVNIl45h3QLSGp34rJErLGk2Yt75X/DddK3F0YmEjLLNQykAVyV0SclC8
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:2e12:b0:6e2:371f:4aef with SMTP id
 00721157ae682-6e347b2fe3bmr274597b3.3.1728910629046; Mon, 14 Oct 2024
 05:57:09 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:57:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=ardb@kernel.org;
 h=from:subject; bh=91Wge0c+Id4XIKd5WqFFlARMHKg7IsAMaPdrRhgkLZg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1XVCErR0q3bPvkx3mb+GYJN59u6CxbnyV960v5QsWAz
 mvN7xw7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETi7zH84TcyXWAgIuH+S3fS
 S9+36odq19an2tZdvjxHnGHqtKMzFzH801ikayRtr2u99VqFsVtU9BvJn2LLGGYYVFyvmMx5744 MHwA=
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014125703.2287936-4-ardb+git@google.com>
Subject: [PATCH 0/2] Use dot prefixes for section names
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Pre-existing code uses a dot prefix or double underscore to prefix ELF
section names. strip_relocs on x86 relies on this, and other out of tree
tools that mangle vmlinux (kexec or live patching) may rely on this as
well.

So let's not deviate from this and use a dot prefix for runtime-const
and alloc_tags sections.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kbuild@vger.kernel.org

Ard Biesheuvel (2):
  codetag: Use dot prefix for section name
  runtime-const: Use dot prefix for section names

 arch/arm64/include/asm/runtime-const.h | 4 ++--
 arch/s390/include/asm/runtime-const.h  | 4 ++--
 arch/x86/include/asm/runtime-const.h   | 4 ++--
 include/asm-generic/codetag.lds.h      | 2 +-
 include/asm-generic/vmlinux.lds.h      | 4 ++--
 include/linux/alloc_tag.h              | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


