Return-Path: <linux-kernel+bounces-283034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D35694EC35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598092822C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF78178373;
	Mon, 12 Aug 2024 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwKDGtdF"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA127457
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464002; cv=none; b=aeypB3E11b69GFaBQ0SbNBpBOIvu+o3ARDsB7+9Hdp1Vy4CfoaWWKvg5De65P+vkmEaDNCSqR/e89FUJHFy4TM9jmhHazPJfXb25VsHJsTTkCYL6SzQW7H7M7KKhUPddtCrR23stt0SxyOK5BqnHlpJLelMojgTgq2ukEuplBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464002; c=relaxed/simple;
	bh=6T5U5J+76eqPdL/cU/Ax9ZyF3TvyQQsGkmbFRNK4EkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVzPs+15cSaj72smHVs0r5Aus0VSxDqeDzG0M+iW8NF4DZgMIuaVIKN0036YfR30SLMXQJwmKJbzmGTmnPep6jv+Z7aAldyt/ew2StumoVb+zn0c7vnO9yIHy4EqHeLdUKr3wCTSJaLkqLMDLvfnq2GpyxYtTB7LY1otRNjfsqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwKDGtdF; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ba482282d3so5195946a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723463998; x=1724068798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRKx9dZX3QjMkF5miIckcLbQZtgikNx/maL4/UrUqR8=;
        b=LwKDGtdF3OFA1phAMf8CXxt4d1mpv+cwnX7pBhBil3Anm8yjBc7Wj83LMJzwSfmjND
         1XoG3u9/nkJgOX6xi72DtLQNRgxe/uK4ovLK8uz4JrMN9c8GyYj2uMc12G+1LWwTc08L
         ofZQxH8EvFf8Bt6RU1Jgpe8k7irlmEXWF8qv65ntusm/jK2GRHEsOztDCr4UKXMSGk0x
         XtGnTpOS23RT6EHc2NC6KSBRi5Um1Ven8qIVzgcjqXv/O+R94tfPMvLF45eRtPqJy1wT
         Qgs904PlNQdHvy2DoJi9lMU22uAcDmQINq70Ck+kW4YL67CnpLdohlkMyNBvA+QYbT3A
         FvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723463998; x=1724068798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRKx9dZX3QjMkF5miIckcLbQZtgikNx/maL4/UrUqR8=;
        b=wI2eTfsrAriT2RO2c8Xz70dL9QRKrrQw0XzYAeBDVNZckmaO2sILBNsL8J/VN9FABR
         /1oTgpkDqcB8c7G6X9TdJtkaKs3KALvm5Dp6+Z+noRN2N/0rVBtLv5iDLDiivUZc+ZZo
         3aLT2bSpn8yN/CnOlRle1LHy7Ook5NTl2+aWQacQYdQEUcZOzvNygdGgmIw3zAZS4DGm
         tn8wESyBAZSsm65ykS9P7xMjIYqtlUZ+WZSpUP1I5MVtefsL2tkao7jEg+5B4nIHSsj+
         FHbQ1l1IcDMBWKXusNSiefPUAFQSE8puLJGO2OCRBr4nDly7c+8J4ybak5yYGc/fvBx3
         yORQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9OvOycai0b3ffsuNUCQsYk0RIuMbS0JTz8cOGyzmhFCTUnbYiLYogZ4sb4VwFkJ89uwTr3DwuvY3Vu0dMbRmM1JRu0cYWFu4XUnFb
X-Gm-Message-State: AOJu0Yxsss7kmYZI9lL4ETR4306/tlgb9y+Uq4nc5l4nyJMNvh9J84lB
	kteR0M3q0KDIOzWTTfbZTZgoRIkguzrR3KEg7nLz782MgtxYO1Yd
X-Google-Smtp-Source: AGHT+IHgH1TDpiQShSgpot1VvJxvHAYo32/du5ZSHtZ10/tza/HQdHkI7tdD0Hqt2qPFzIpMIKDXEw==
X-Received: by 2002:a05:6402:5ca:b0:5a2:abcb:c4d1 with SMTP id 4fb4d7f45d1cf-5bd44c77743mr9130a12.34.1723463997238;
        Mon, 12 Aug 2024 04:59:57 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5e04aesm2055970a12.76.2024.08.12.04.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 04:59:56 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH v2 0/4] Enable strict percpu address space checks 
Date: Mon, 12 Aug 2024 13:57:34 +0200
Message-ID: <20240812115945.484051-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset enables strict percpu address space checks via x86 named 
address space qualifiers. Percpu variables are declared in
__seg_gs/__seg_fs named AS and kept named AS qualified until they
are dereferenced via percpu accessor. This approach enables various
compiler checks for cross-namespace variable assignments.

Please note that sparse doesn't know anything about __typeof_unqual__()
operator, so the usage of __typeof_unqual__() breaks sparse checking.

Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Uros Bizjak (4):
  percpu: Define pcpu_typeof()
  percpu: Assorted fixes found by strict percpu address space checks
  percpu: Repurpose __percpu tag as a named address space qualifier
  percpu/x86: Enable strict percpu checks via named AS qualifiers

 arch/x86/include/asm/percpu.h  | 53 ++++++++++++++++++++++++----------
 arch/x86/kernel/head64.c       |  3 +-
 drivers/base/devres.c          |  2 +-
 fs/aio.c                       |  2 +-
 include/asm-generic/percpu.h   | 41 +++++++++++++++++---------
 include/linux/cleanup.h        |  4 +--
 include/linux/compiler_types.h |  2 +-
 include/linux/part_stat.h      |  2 +-
 include/linux/percpu-defs.h    | 39 ++++++++++++++++++++-----
 include/linux/prandom.h        |  1 +
 init/Kconfig                   |  3 ++
 kernel/events/hw_breakpoint.c  |  4 +--
 kernel/locking/percpu-rwsem.c  |  2 +-
 kernel/workqueue.c             |  2 +-
 lib/percpu_counter.c           |  2 +-
 net/core/dev.c                 |  2 +-
 16 files changed, 115 insertions(+), 49 deletions(-)

-- 
2.46.0


