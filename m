Return-Path: <linux-kernel+bounces-368983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B748E9A174B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A0A1F22E57
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCF3175A5;
	Thu, 17 Oct 2024 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MuzbC3gr"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305521E3A4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729126270; cv=none; b=tCq/pchbVRTYqRbwBGPCnMUs2RI+E2dc+3cS6ol0tN2bEvsHyDDxH+gy+t/0nuVrujCWrtQqdJkvMgXlmKLoDGB8bgyaFMB9t30UZlUifVOchLty6NcJPM/QfDXZbjA7Z3HeiMqD1xLrB7TIJfnNKG9K8/N95IVDrgYo8iEaQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729126270; c=relaxed/simple;
	bh=Jgnqihu6FbtNVoNoIj5vSy2Qh7tCgSEbPpKuBouotIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDaTRvwSvyv0FKUQn/KhGoSdoZiT0RA4BXMOzmKxC/OKynjUs32DS+MfWNjwzgc6n04/UEcYc2WeHgXCo8rs5c4Vpn+nWsHvIyzKru6LzTWqAp7x5yeeEOIOGPlhEWeub9yEfc4ZEKl8pMyWdRHfJ47O1jKhPTc63xA8K6Kr7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MuzbC3gr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea64af4bbbso47288a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729126269; x=1729731069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNLnN/iucIUQy/y3ju6Adhzlqh5K8kEraoCv1/E/7vA=;
        b=MuzbC3grzlnaYc1ya/ZU9GBziOQYwDwSs0qAmJycq8iE+ZXKcNxUwGx3NydIsI2lVE
         Xu13dA4qlXJQzryyesoCvPiwwtVPb0UNl2wlsPZALPAdGetsZOeurbke5rPgRExu8nIK
         dXBYqlMsNMaB0KQFLE6QpQyGNxSi08aHBsbEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729126269; x=1729731069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNLnN/iucIUQy/y3ju6Adhzlqh5K8kEraoCv1/E/7vA=;
        b=cXlLtjnLha70MhMuXIRo0iYmmaQ0GM/I6urK/cnfPJaBxrD9CL/UCeYz6QU4PLkW/V
         v+zoB3BqQjQzRFFZHatghFZBxIhoSf+CjTb26Y1KZpdLoOmMIRpX8JwtmtACtdKgNlj5
         1bhuEusJjxcJEsvIk/GUG5JTGtLMVc3D0XFxUvkbNdkVMgbvwTLhL+yAj6Pr24jKRBbj
         gRbzYL/jWNKtKylrmeb2FrtrpwFoeGT8GWkwRr/VrQdkJSvI2POmwzgVDixd/AZrDTUg
         P7URYWNdVA3hYl00cYAEwNIEdOlJ8iD+Uok5fPvoQe5PFBGwmIOMZr7gIHEQWRophBy9
         33tw==
X-Forwarded-Encrypted: i=1; AJvYcCXCHWRA8dt7ZBS6gAPNzVuT+L9KXgD+v38jPPLjEnIdQJjBTWslrQSL35tnGApfMkAjPJRlJyml04rhG6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YztVi2ikKDrMBuSYYl3qJ2RryO1GN6tZX+tQjSzQSXox/pZnBfm
	ig/1Dde9Naz9g+amfchR05ZiYSeuK6cCMZ2FYfZnQwCMqHu5sCUoQlsirou4/g==
X-Google-Smtp-Source: AGHT+IE/KwJHBKXnkbyNA/+4lZaIr5QamZ24gPBpSlNBEOwhpQ1CTC7sgfsehGTCkqBVVE0FRU0pPw==
X-Received: by 2002:a05:6a20:3944:b0:1d4:f5e4:6a9a with SMTP id adf61e73a8af0-1d90cc869ecmr2448743637.12.1729126268835;
        Wed, 16 Oct 2024 17:51:08 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71e84982905sm1770554b3a.96.2024.10.16.17.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 17:51:08 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	corbet@lwn.net,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	deraadt@openbsd.org,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org
Subject: [PATCH v1 0/2] mseal: fixing madvise for file-backed mapping and PROT_NONE
Date: Thu, 17 Oct 2024 00:51:03 +0000
Message-ID: <20241017005105.3047458-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

Two fixes for madvise(MADV_DONTNEED) when sealed.

For PROT_NONE mappings, the previous blocking of
madvise(MADV_DONTNEED) is unnecessary. As PROT_NONE already prohibits
memory access, madvise(MADV_DONTNEED) should be allowed to proceed in
order to free the page.

For file-backed, private, read-only memory mappings, we previously did
not block the madvise(MADV_DONTNEED). This was based on
the assumption that the memory's content, being file-backed, could be
retrieved from the file if accessed again. However, this assumption
failed to consider scenarios where a mapping is initially created as
read-write, modified, and subsequently changed to read-only. The newly
introduced VM_WASWRITE flag addresses this oversight.

Jeff Xu (2):
  mseal: Two fixes for madvise(MADV_DONTNEED) when sealed
  selftest/mseal: Add tests for madvise

 include/linux/mm.h                      |   2 +
 mm/mprotect.c                           |   3 +
 mm/mseal.c                              |  42 +++++++--
 tools/testing/selftests/mm/mseal_test.c | 118 +++++++++++++++++++++++-
 4 files changed, 157 insertions(+), 8 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


