Return-Path: <linux-kernel+bounces-220879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D6F90E87D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E931C21ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CAA12F5A3;
	Wed, 19 Jun 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="EjILjDfr"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4C275817
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793632; cv=none; b=OEHx6A+NZ9g0uBbNOpIkfmC8sK7Aab16HqR8AWJoFqbwDsqlrp6otn2vGDGVMsQzwX946AFzjbEe4PV8AOgURwBdXq9tcCCa6zi6iVMteXtgh/YmXgi98FsYgwZDCiRn1f4cx0y3cWb3GAugsivXDd10d48Mg2U2n3prRM75M6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793632; c=relaxed/simple;
	bh=e5IjEBrz1ZB51kpZdF05JxxOCeh8ajRvL7MyseIZK+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E0hwRsO4N5uUloD3L6Rpp1eoeUa7tAJcD8szqoOKsZ3hRzZq0SgIAOYilTYXADraAXY0NIoSmlZZ/HVmYXo0sEjwr9i36+O+faf92CDu2TUkD6IJcHOjB8WZuwQ8QOlBuimQWXplcf7GXzsyxwUv7GwSL4rAi95aXF0+2qkMEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=EjILjDfr; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7953f1dcb01so550997185a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1718793629; x=1719398429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p95lb1ctHFp3T74sDBuumFZbHTUwbXXyA3hdbJYiDoU=;
        b=EjILjDfrThvckglHh5m5Jg3N3/dZC/c8w4EIOmAm+z8kPJCnBRw/i4M25zv1PmtS+f
         +PnMwE24dhSc6vTrXv/COTuYaE8oy+pao/b7/TStnvbuRY09f2/HGAHSwQNkkVFgY2ZX
         o5LO5AKrUEpn1OgxebLRorHnpYD70QUcOy+s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718793629; x=1719398429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p95lb1ctHFp3T74sDBuumFZbHTUwbXXyA3hdbJYiDoU=;
        b=ECdV28FTnhsyJ+SB1xp+0zR+Zed880NVBTiUtKqRbcCzh55L4Ha03h+8PJ065ChV1O
         tO+c48oIo7Xf/rL0s1kJAPUV7DXqIuphDyIjrvXBWCAQANSf0Sd038v1fM2YKFZUnHGs
         h4m1Ggg+2AP7nj+0SK7cNt7UZ/U4ZmVtrHE7kx+JRgTT/lj9jbmdlRfOOSVjmQNnnVX5
         mlLH60LD6qHVVdyhiWCspSwlIg4Gg8cMUsyv7ANO86m62HQd1vjJt3TY4hv043CNrNnA
         A5sBYA8ChJwis2ftw1s56A8+KT5z/OJv2mHQkkPhLhXD2Imem5siT9gI5HOICks477sP
         So3w==
X-Forwarded-Encrypted: i=1; AJvYcCXiOa4S2DaR1EGHtxa/Bdsgrcv581JasuVf5pmkTiF8OPUWDVpQzQZG/bve1Glri2Jq7WaLEq5//znkocw9NAc0InU5TUvJnjgRWi3w
X-Gm-Message-State: AOJu0Yxwns51CwctGKcui4UKdIL4d0GfRceLRR4b4bFIsBTg3iZj8Xj9
	XhPt5eJbTDjVfQT7DqPd7qh4ps2oIE7FrNKvlt6zg/Pd51B4AbiHU8teqnPruxE=
X-Google-Smtp-Source: AGHT+IHxMvPNCyIKkLf/mcijHPuzQSLiYwyl/idVDNGL3pZUbs0K2RBLMulv8SBRXWBQPgj1vIs+sQ==
X-Received: by 2002:a05:620a:4510:b0:795:5120:97ac with SMTP id af79cd13be357-79bb3ebd69fmr203624885a.53.1718793629451;
        Wed, 19 Jun 2024 03:40:29 -0700 (PDT)
Received: from fziglio-xenia-fedora.eng.citrite.net ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc06e93sm595417985a.82.2024.06.19.03.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 03:40:29 -0700 (PDT)
From: Frediano Ziglio <frediano.ziglio@cloud.com>
To: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Frediano Ziglio <frediano.ziglio@cloud.com>
Subject: [PATCH v2] x86/xen/time: Reduce Xen timer tick
Date: Wed, 19 Jun 2024 11:40:15 +0100
Message-ID: <20240619104015.30477-1-frediano.ziglio@cloud.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current timer tick is causing some deadline to fail.
The current high value constant was probably due to an old
bug in the Xen timer implementation causing errors if the
deadline was in the future.

This was fixed in Xen commit:
19c6cbd90965 xen/vcpu: ignore VCPU_SSHOTTMR_future

Usage of VCPU_SSHOTTMR_future in Linux kernel was removed by:
c06b6d70feb3 xen/x86: don't lose event interrupts

Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes since v1:
- Update commit message;
- reduce delay.

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 52fa5609b7f6..96521b1874ac 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -30,7 +30,7 @@
 #include "xen-ops.h"
 
 /* Minimum amount of time until next clock event fires */
-#define TIMER_SLOP	100000
+#define TIMER_SLOP	1
 
 static u64 xen_sched_clock_offset __read_mostly;
 
-- 
2.45.1


