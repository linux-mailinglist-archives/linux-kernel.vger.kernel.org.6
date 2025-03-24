Return-Path: <linux-kernel+bounces-573223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC60A6D470
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384381890F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815742054FA;
	Mon, 24 Mar 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bferOem4"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DA204C2E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742799213; cv=none; b=eSxxv5Re7qCrGTJZB1gQXHXbFRAbTETchNyg4X6eUIHEK+u8LpgUWyeb8QSbo8c6xIe8uU4pdcYZZyUjKIz1DYvrpRnAHXe4+ZJ5+Sh5++0NzDg5oCrJnCVYPn6RHQklUzLEWGppmelnYsgsFfvX6NY8M+CWRNUl7CtbHMmcQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742799213; c=relaxed/simple;
	bh=BBod9XlyyDQ8D6adGtugfu8HDKv7/m/WFoETZ5Ucj84=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m6lU/kB/MqgdiqKyMfJf16FOcdT7wlXDJJK4vXC2yuBV7wENPuSF2uyB9YNrqgsiHJ51zIBbshnyedjkvgDYbcNz/XsITEKGcsOVlfvUveSiyL9+Y5Lc2Xv8uLOaF4BweUI7lopZyUUfRQro+VwjX83Qac/+nEXqPvRdtTraE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bferOem4; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2aa17fc59d1so3713511fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 23:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742799211; x=1743404011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ij8NrI5xZ43JBAGEthvNKWDZxxjZlhI2ViPlC5qM+Ac=;
        b=bferOem4Kmpd73E/n6xq19KUOfp97nSAZkcPz7DO4yw3lssi+zAGYriQuKYIQES1/a
         RO/v5grBrWbnyOpuY6NDWG9WXM2bUqhOt0MnEL181/o1X85rVcIElbeoXUQ6m8eg3nlC
         pDa80t0NC5atHl8/YQICgZ+UP8LVhtRtLfaZtJ3O14j1+mlaYzojfLcK7Fp7sJpXo8eK
         kCKoiKXHnQMctne3QVxZjxUYBMXs4UASBABuLMiF7s5kKzKG6UE3uHpFKmxdx00NMCFh
         9xRVKbwFmOnwyLVIDw/JBU9TH9QZ8uH/HvB4LkNh1l/QgwiAt+SwqzeVXk34I5tpgRMe
         47Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742799211; x=1743404011;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij8NrI5xZ43JBAGEthvNKWDZxxjZlhI2ViPlC5qM+Ac=;
        b=CuBomPywVuMZY/C9nZE56yl15AgeVv8NVDJWndWWzCv/la051mbdZ1GygTzaAOsmNv
         K4QLXSeBQkd8sriCSiddx+6jTKoIickEnL+oaFQ3fkBMnRYww8Ehko13fdEO/T5qiE8z
         zTmSYR34EKISrbe5JepqgdOixctmfDlhvJ/AvJj9VzAGkS7rrys7/Z/WWq62uIxXcjKj
         8gpAj7bQwkVseooLLKL/m3rivKhfOZZXLvyuItynhaZDkcg32l6L3CKcWZZzkf36W7xB
         b3ebRuRX5bukwl3zZtH7Y+MgMQLklu1OpTsh3YnUksByHfGs8mSEhFpvnHTU5+oWYlRi
         3TKw==
X-Gm-Message-State: AOJu0YwDxWtfFJVBFYLOTX5HQaAn3v4BZVute8xMO62pmJM1BT/f/j7v
	wVvSzhah+5rA34aOoH6kAgC4/HjFvhQ4OSurjGSkLHTTZSmFfxctboEYeDE7epWA4HKZGkGm4qD
	6WQ==
X-Google-Smtp-Source: AGHT+IHpdLVbnzsd3cNvYjM2o8eY6lwTbr3KBAgc79gozX2wYwWUwNW68nIoXf4IdVkTdg+SlaMY46oDTYQ=
X-Received: from oacpc8.prod.google.com ([2002:a05:6871:7a08:b0:2b8:faad:4f1d])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:8901:b0:2c2:57a9:79c4
 with SMTP id 586e51a60fabf-2c7805045acmr8278062fac.32.1742799211140; Sun, 23
 Mar 2025 23:53:31 -0700 (PDT)
Date: Mon, 24 Mar 2025 06:53:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324065328.107678-1-avagin@google.com>
Subject: [PATCH 0/3 v2] fs/proc: extend the PAGEMAP_SCAN ioctl to report guard regions
From: Andrei Vagin <avagin@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	criu@lists.linux.dev, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce the PAGE_IS_GUARD flag in the PAGEMAP_SCAN ioctl to expose
information about guard regions. This allows userspace tools, such as
CRIU, to detect and handle guard regions.

Currently, CRIU utilizes PAGEMAP_SCAN as a more efficient alternative to
parsing /proc/pid/pagemap. Without this change, guard regions are
incorrectly reported as swap-anon regions, leading CRIU to attempt
dumping them and subsequently failing.

This series should be applied on top of "[PATCH 0/2] fs/proc/task_mmu:
add guard region bit to pagemap":
https://lore.kernel.org/all/2025031926-engraved-footer-3e9b@gregkh/T/

The series includes updates to the documentation and selftests to
reflect the new functionality.

v2:
- sync linux/fs.h with the kernel sources
- address comments from Lorenzo and David.

Andrei Vagin (3):
  fs/proc: extend the PAGEMAP_SCAN ioctl to report guard regions
  tools headers UAPI: Sync linux/fs.h with the kernel sources
  selftests/mm: add PAGEMAP_SCAN guard region test

 Documentation/admin-guide/mm/pagemap.rst   |  1 +
 fs/proc/task_mmu.c                         | 17 ++++---
 include/uapi/linux/fs.h                    |  1 +
 tools/include/uapi/linux/fs.h              | 19 +++++++-
 tools/testing/selftests/mm/guard-regions.c | 57 ++++++++++++++++++++++
 5 files changed, 87 insertions(+), 8 deletions(-)

-- 
2.49.0.rc1.451.g8f38331e32-goog


