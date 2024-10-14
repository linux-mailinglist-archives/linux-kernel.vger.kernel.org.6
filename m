Return-Path: <linux-kernel+bounces-364787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EEC99D95F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A7DB21966
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A351D1739;
	Mon, 14 Oct 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ea26KL9A"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7531AB50D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728942632; cv=none; b=YjuEPe12yOs8bqhM1AGWeglm/PCBiCUvG+BBsyoBaFLl2JDi2Rs1kI8veTyngD7b02waxOgWP4i5j+FM4ib91tflqvfPOLVA+MkOPuWlPSIfOr/nro1WTeRYKn0uaKvLNYMWh98pQ2Pbnj+W7HUui6sY56lItSwKNIOG+5LU+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728942632; c=relaxed/simple;
	bh=Bn+0tgTQ26spkOkGeU3zIn5oIOy8xE8ehmLP1HtPYdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OfbKEmMoptR3XRaOSvhGfRJLvaP8dqw/cNpTuoS0ucOLxEr4Cvn6PqbknwFAuz4vVAnoidRFyYiQay/5qBbZpVeS+5umemcfuUGfjptwWQ17RaC4ZImb5SHvMrtkSOyxpZwkIi93DjWK6J1V0/KawPS1pY/02ja4uC897SJ2eYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ea26KL9A; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e74f35acaso38370b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728942628; x=1729547428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHgAeWx2Z6u/Rr4guiu2M1wSVbBmkz71ggb4GDq4zfk=;
        b=Ea26KL9AtGCNZ5BGVBK/nx5HAK1eFUzaDZCXJqJc7durL5BbBZAiU3Z5L06KATkDGa
         v6Lc+SwVFHtMKMJ8Ig6h5cVTd65Db2OyEm2ObGXxtFow+aVU+jWK0X6l2qmUupo42JcF
         X1H9RVBRTov+sdBq3/5MdB2+DAelrnOSi/UN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728942628; x=1729547428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHgAeWx2Z6u/Rr4guiu2M1wSVbBmkz71ggb4GDq4zfk=;
        b=EBKlB3Ls46/6CA2SWB0SLi6YGSCpQ1+V7EEF4zqE+Tyjvc7zx1WH/iVZm0nZLWNPMv
         YZ/6Y5c+b5Kbq+3xRkFH9rsTYgD/26VCBbpM+DCVFrNZk4iewysgBcJEPvWVPOpZqKzS
         5XpoBSqLHbor/2WTkBfp4Aewgq0BH9P/fOB9LeyWEhCvZ6QsHzdKcueHExOMtAC+inIC
         TzpTZ1U3m2DzI8xQOiHZmAYaoVRabZGDnsKD9irf1pU5KqA91BLjWKaTlI8u7+JXT8k4
         lp1knEO0LSCpcolb9dX/9Vvlvnu1yrpe96nPm0nNUbrFsROarnSEVYk4lskRP18woNCX
         8lEg==
X-Gm-Message-State: AOJu0YzzoIvwKaM65tzAIdLNEy3kr/8+yBmcRD/vYETvOwsXEQlNzWGl
	6FDmqaSaRmxGY/tCranC7p12CqNHomLatB+5Pn6JLmm4WdZhILqpOoZJoqIYsg==
X-Google-Smtp-Source: AGHT+IGthjCd3HKvWtjJZwDzbVAakFkQKTTiDKfjfpQUEZRgXxs1pRU5IC3CwN8YbItLINHiJkWh6Q==
X-Received: by 2002:a05:6a21:999f:b0:1cf:46ff:973d with SMTP id adf61e73a8af0-1d8bcfa83edmr9185549637.9.1728942628504;
        Mon, 14 Oct 2024 14:50:28 -0700 (PDT)
Received: from localhost (56.4.82.34.bc.googleusercontent.com. [34.82.4.56])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71e625b63a2sm3035501b3a.159.2024.10.14.14.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 14:50:28 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	ojeda@kernel.org,
	adobriyan@gmail.com,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	hch@lst.de,
	peterx@redhat.com,
	hca@linux.ibm.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	Liam.Howlett@Oracle.com,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	lorenzo.stoakes@oracle.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v2 0/1] seal system mappings
Date: Mon, 14 Oct 2024 21:50:19 +0000
Message-ID: <20241014215022.68530-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Seal vdso, vvar, sigpage, uprobes and vsyscall.

Those mappings are readonly or executable only, sealing can protect
them from ever changing during the life time of the process. For
complete descriptions of memory sealing, please see mseal.rst [1].

System mappings such as vdso, vvar, and sigpage (for arm) are
generated by the kernel during program initialization. These mappings
are designated as non-writable, and sealing them will prevent them
from ever becoming writeable.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [2], thus sealable.

The vdso, vvar, sigpage, and uprobe mappings all invoke the
_install_special_mapping() function. As no other mappings utilize this
function, it is logical to incorporate sealing logic within
_install_special_mapping(). This approach avoids the necessity of
modifying code across various architecture-specific implementations.

The vsyscall mapping, which has its own initialization function, is
sealed in the XONLY case, it seems to be the most common and secure
case of using vsyscall.

It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
alter the mapping of vdso, vvar, and sigpage during restore
operations. Consequently, this feature cannot be universally enabled
across all systems. To address this, a kernel configuration option has
been introduced to enable or disable this functionality. Note, uprobe
is always sealed and not controlled by this kernel configuration.

I tested CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS with ChromeOS,
which doesn’t use CHECKPOINT_RESTORE.

[1] Documentation/userspace-api/mseal.rst
[2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/

History:
V2:
  Seal uprobe always (Oleg Nesterov)
  Update comments and description (Randy Dunlap, Liam R.Howlett, Oleg Nesterov)
  Rebase to linux_main

V1:
https://lore.kernel.org/all/20241004163155.3493183-1-jeffxu@google.com/

Jeff Xu (1):
  exec: seal system mappings

 .../admin-guide/kernel-parameters.txt         | 10 ++++
 arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
 fs/exec.c                                     | 53 +++++++++++++++++++
 include/linux/fs.h                            |  1 +
 kernel/events/uprobes.c                       |  2 +-
 mm/mmap.c                                     |  1 +
 security/Kconfig                              | 26 +++++++++
 7 files changed, 99 insertions(+), 3 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


