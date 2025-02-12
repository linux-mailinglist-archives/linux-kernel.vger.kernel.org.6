Return-Path: <linux-kernel+bounces-510424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C69A31CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3FD3A7451
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D651DA612;
	Wed, 12 Feb 2025 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c3o9ET5Q"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B21D8DEE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330518; cv=none; b=pCLeZOXmenRlZe4A76SEepuE45WflC8kreWJXMSNafNLKzppla1w+K1ngSM9qV8GH1v/LP/sRn0vSoNg1hcbIeXmUhfpyglsJRcEiFG9oPb3g8KxDaaggTbyf6Jx6Q/2cucUjqieS2SAxldXjhjZMy40Fkh7hj/Ic8CgTDEFcAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330518; c=relaxed/simple;
	bh=GXIjdcanFwwm7LKyMwYAwJA0WALJk9p2AHH6SgAhdTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8QBMLj9XkKgMrm/p6lyEslR42XNeeujoG/sgrrhUhQZeSBx8gJCxIYM3UKhuMU25+CqeTJU8DxYZmkaQZXjcMa+IvXl1gHjixqEQJgv0sIfFNrKFZUgAbS3gIHr994Jh21tWu1G01RAOKgp8rMq3pC0x4RQAQ9DzA2BghbZFM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c3o9ET5Q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f6fb68502so7469795ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739330517; x=1739935317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhDIo/pgY9uUkXE2IY3OHzZfG1I5TLyMDQUSWmrc3tE=;
        b=c3o9ET5QAQTif8Cw3xpzCsMN24aV9JDeW+AaULOR9N+/ovsEuZKUvbYBK/bdg77fd2
         0A+c7nI82NzTRrqdUmmNx3XfWxIZvSaBBv8b6NBzPv+GWD1IWlhD+rrQFLN3PbmTLSQY
         tZSvY2WsI/Wha+iEGbX2WSQ3ugWUg5szZ4oLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330517; x=1739935317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhDIo/pgY9uUkXE2IY3OHzZfG1I5TLyMDQUSWmrc3tE=;
        b=hmMgWwr/Svc+S5f2/ka5qeJFO4jo8GpGiBNYCb6TqtePRXptYct+x5r8pHJ2/f0AGT
         WJbCymEqlxJdYN34hWoBIB8BbMtgt7QZjIZubiUvBlL11VjTH8R+WZdBgGtjsOhzRdRv
         3dCNrBLq8Zrz6nsgyX7u4gtqWHf2GVxPY23IDKerxsPn/7Lgvx3+LOva4ISh15oBv+g9
         GJrWfViXrVLikXh4Wt3ep8XcjBEVm/KsQoPFAZvRPsnuBzmX9DkfWxJmLd2dnBlABDgh
         0ZF8uYJppDje/dt6mYkFy+z5Y1VBDSRgJM/Y30krgX2JL5KfJs7hLqHZEzQebYRTw/fo
         TzQg==
X-Gm-Message-State: AOJu0YzNfN0ubDNFb85RiK0GaUxM+ge+zw+Q1urg6spXPQeOXX0YuOAE
	Gcia5ZsoZS1vTzu/iE7KwhK3o6DN7gzMLfev/Zi7M9GUykgiujUV8cAj5z7Z0w==
X-Gm-Gg: ASbGncsY598wyIdJ5YGxG8SrZmesd55j0KGZcM3pnLRoRcuJ8vXSTfmsdJ26F2vpFv/
	cdyLvy5sN36ktcPoqR2je/C7AJXMBjYqYJa/4zjl8yRoctWGyDYqL3qjJ0/ImP51WUmaQrvbdbB
	j5IOJc8zrAAr8PR3duWp1PcPAhXWUHDZLcHLHjBjO0NEAEVTPuUyV795AzxJk6mhEYQlmQa0XM3
	Zl9mW5eqcvt0PzXffVhYKpT5dI7pDo02hGvP9/EMHG3mAsC2atT9EPvrys7/+sYMXhYpuN7Uz5/
	NbW4hr7xv2F0cO69XQ8iWAqn8y00toC/NwB++QAV2BxO/RFPww==
X-Google-Smtp-Source: AGHT+IGj5JrfUFtJivT0L1NZIctVTEv6fxRQRRuajrSnp6hBeSeQ4P2FV57Y3QZUw60ZeV22PTo0Gw==
X-Received: by 2002:a05:6a21:6d97:b0:1ea:ddd1:2fe4 with SMTP id adf61e73a8af0-1ee5c8e9c84mr1016097637.0.1739330516623;
        Tue, 11 Feb 2025 19:21:56 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7308ac1a373sm4777776b3a.41.2025.02.11.19.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:21:56 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v5 0/7] mseal system mappings
Date: Wed, 12 Feb 2025 03:21:48 +0000
Message-ID: <20250212032155.1276806-1-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

The commit message in the first patch contains the full description of
this series.

------------------
History:

V5
  - Remove kernel cmd line (Lorenzo Stoakes)
  - Add test info (Lorenzo Stoakes)
  - Add threat model info (Lorenzo Stoakes)
  - Fix x86 selftest: test_mremap_vdso
  - Restrict code change to ARM64/x86-64/UM arch only.
  - Add userprocess.h to include seal_system_mapping().
  - Remove sealing vsyscall.
  - Split the patch.

V4:
  https://lore.kernel.org/all/20241125202021.3684919-1-jeffxu@google.com/

V3:
  https://lore.kernel.org/all/20241113191602.3541870-1-jeffxu@google.com/

V2:
  https://lore.kernel.org/all/20241014215022.68530-1-jeffxu@google.com/

V1:
  https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/

Jeff Xu (7):
  mseal, system mappings: kernel config and header change
  selftests: x86: test_mremap_vdso: skip if vdso is msealed
  mseal, system mappings: enable x86-64
  mseal, system mappings: enable arm64
  mseal, system mappings: enable uml architecture
  mseal, system mappings: uprobe mapping
  mseal, system mappings: update mseal.rst

 Documentation/userspace-api/mseal.rst         |  5 +++
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/vdso.c                      | 23 +++++++----
 arch/um/Kconfig                               |  1 +
 arch/x86/Kconfig                              |  1 +
 arch/x86/entry/vdso/vma.c                     | 17 ++++++---
 arch/x86/um/vdso/vma.c                        |  7 +++-
 include/linux/userprocess.h                   | 18 +++++++++
 init/Kconfig                                  | 18 +++++++++
 kernel/events/uprobes.c                       |  6 ++-
 security/Kconfig                              | 18 +++++++++
 .../testing/selftests/x86/test_mremap_vdso.c  | 38 +++++++++++++++++++
 12 files changed, 137 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/userprocess.h

-- 
2.48.1.502.g6dc24dfdaf-goog


