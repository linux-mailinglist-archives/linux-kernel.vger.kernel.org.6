Return-Path: <linux-kernel+bounces-285639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E629510C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9512F1C210A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADDC1AC450;
	Tue, 13 Aug 2024 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rCRS07Ql"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584AD383BF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723592881; cv=none; b=Ea9aG/S8PSJdXT9MmzZVxDFe5puOVeWVy2nvIeTKp9jKeKOusMUrYfL/jcpo8mVO72W7vfEbsPnXUnWBdRCqSpYNqSeIN5XotFsihUizUaf/JCBh1z+Csy9gZLeGQ2VSs44oyDXBjmS5HXS1iUZ980exFPUbbLe7KaEfTipSIVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723592881; c=relaxed/simple;
	bh=+0mxwpd3S5XnzhzZmUgULgCsyhsrGJEBwQBSlhWJMpg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VDiIHWPbgVBjaXbalJdmXnX31ZLi17ims8/SlEM0fICrfSJEcRnKrGJrUOa2CchlxrRIM2bHQNOeFgx/AobjuRJTZQWDyf55RZhi+yaGpwMxGZONQtwlXeIj/8oIu6A0PCakcwbynBGLDZWS4BPGjSXRJeEg2w4wobLhfqVFjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rCRS07Ql; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0e4cd64909so10368326276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723592878; x=1724197678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dbtX85OIvDZqZDvoebC/8Rwcxt4sIKvuHnf821Q6cFk=;
        b=rCRS07QlqfmzCEK1oH0JxvBlgNqJZ8o0fWS8aCwn3Srd0X+bmKtPJkrn1wFQabCsyU
         1EF5yADzUTzV5IjETkbLcNj7QdV3mr7EYS6IalIl56thi69HmyjCyC0eeyXuMPGSFnKE
         FB9V31KPPTkr/Oz5qOsPuIVTZBxr1RWLmyJ/5bWwVucn+AMZB5yhbi+er3vVChfF1RZZ
         qMo0vdfCCO6gzQiOzcUuOjed5olpGD7K4bRZXcJWbOrA3k+6LlkeTWvrkUwCq4i7+ym6
         PCw3kDVmSUG/Wr/Q72mWBsevlUZXYQM9ahPlgsv4xgpwV9p3K63Ha1s6wD/4tKFRQIl0
         yNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723592878; x=1724197678;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbtX85OIvDZqZDvoebC/8Rwcxt4sIKvuHnf821Q6cFk=;
        b=jRSD1dqWLX8eKCtyYlCUbLi7JiDLBvZ1aA5evFzM3LKcDh60JRubBDx1jgodfcw9uP
         5dSzGIdQoQBV6nzuZulpGV+5gWICgO4lavRoVBuTJALLVnYCP7SprfnvpzFPQ6/hW1cV
         Dv56Bwboh9DZ9jI7UGDu5nXVEUUweAJlDsdgIltemcP+FSywCDe/CB21BHJCD5SXOWGW
         aPgxIvB24WPBXk9nbNkOX7ZRX6tmWflfTTpbIPAHej+EYRo0y4rdWaF6MTZ807CEu/u7
         TW1kYvEYFlQWRBMXQ1gks7aGxYoYEaEgz9DDCmL8ZAd/FrNtbH+y+PJtCgr3r7MhC5fu
         9Vtw==
X-Gm-Message-State: AOJu0YzYsKxw7MshrmrwK2KBRRYsRzhuW7KhvVAvKXA1PR+3+JuNyRiq
	eoWnAp27YeD6NRUMcpcKAobrFuyDWYBVWhhHv3qSOwvPvhqF7Cp0C7M5XDlR6+WDvfBRWQ==
X-Google-Smtp-Source: AGHT+IGrjD1ml7A/TNR6lQFgx73bBKn21UdMK+Yp53+uTqPz9PLiWm/B6ur1ScVNlYzKlitVe/qxgYCP
X-Received: from varda.mtv.corp.google.com ([2620:15c:211:200:7199:1729:2be2:5cf4])
 (user=maze job=sendgmr) by 2002:a25:cc3:0:b0:e05:f565:6bd3 with SMTP id
 3f1490d57ef6-e1155bbe9dfmr1591276.12.1723592878254; Tue, 13 Aug 2024 16:47:58
 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:47:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813234755.3615697-1-maze@google.com>
Subject: [PATCH] um: make personality(PER_LINUX32) work on x86_64
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Without this patch:
  #!/usr/bin/python3
  import ctypes
  import os
  personality =3D ctypes.CDLL(None).personality
  personality.restype =3D ctypes.c_int
  personality.argtypes =3D [ctypes.c_ulong]
  PER_LINUX32=3D8
  personality(PER_LINUX32)
  print(os.uname().machine)
returns:
  x86_64
instead of the desired:
  i686

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 arch/um/include/asm/Kbuild   |  1 -
 arch/um/include/asm/compat.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/include/asm/compat.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b2d834a29f3a..0b961dd089ab 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y +=3D bpf_perf_event.h
 generic-y +=3D bug.h
-generic-y +=3D compat.h
 generic-y +=3D current.h
 generic-y +=3D device.h
 generic-y +=3D dma-mapping.h
diff --git a/arch/um/include/asm/compat.h b/arch/um/include/asm/compat.h
new file mode 100644
index 000000000000..110319031dcf
--- /dev/null
+++ b/arch/um/include/asm/compat.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_COMPAT_H
+#define __UM_COMPAT_H
+
+#include <asm-generic/compat.h>
+
+#if defined(CONFIG_UML_X86) && defined(CONFIG_64BIT)
+/* From arch/x86/include/asm/compat.h */
+#define COMPAT_UTS_MACHINE     "i686\0\0"
+#endif
+
+#endif
--=20
2.46.0.76.ge559c4bf1a-goog


