Return-Path: <linux-kernel+bounces-330511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE177979F84
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCEB1C23208
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EEB38DC7;
	Mon, 16 Sep 2024 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAK0DOnz"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753C14D29B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483050; cv=none; b=qAKx7AU4c/sOfua63aGV8C8JDww2eNXoBAPfVVh2S1oUCtAqgbLYJwNKaH4uSq1NCx+WMx2Q04JN0cvgzsqTnyjZr0MNZlAX/VERnkOZX/sL0vUFpYorbt1szkOaAK3W/N1J1KTW5Ydq+mzf5AX0R2qLeen1wEhI+tzDiHLGunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483050; c=relaxed/simple;
	bh=e8EbIE7xK/lTkq0pT/z9NkUn0axjRZxvEdG/rOuuflY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gEwl280jpHbaYNrymLCbfTNEDa+LjrY8sDjUyR3sFsWn3mRLPFZBHHO+5DIsmQGdySd23LPhXpNo9ozZl3vrYCNq/LTHjUMDXL7Q/CtevxFdhI1+Ib8n1KqTvIPO5nnZYBTkjeH8bUQUUgpN8g6QBs4XC4gnV8YYfqr3kIJiKac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAK0DOnz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so42196655e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726483047; x=1727087847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCa5ueRIGjnyNr/huNPBEXq3DR7C/bUT92dAtDRDGj0=;
        b=dAK0DOnzFa34uw4HJIh+vO9v+oL+0Aifkw6zB8ODAAXwBA1Ntj7FP4aJFcGJNqpp0x
         bGRT0hczsSdBJRjGWJtp19uDGzdGKWko6tQYxsccDBxJjZn1BFWMH1eFC/wdSbGmQ8CE
         160bRwQMqdM0bT4tTX1WnmU6Jhb9NYirRAQxMkOp4U7hMVqvMBkRJUZVsB7twO1mdzJ2
         R6WxesZ9rfZVFago/9fUOZQmeP5gyAZw6hD6Ch1FvQTOEhGS1O8qB2b/tNUDmm07Cgkg
         rwJ90/Ym/PqSoKbD5hyZGpjNtxlGP7Bv9zes3S7v1dKbDRHOy28tos2cRZzDqp5vNeGE
         pprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726483047; x=1727087847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCa5ueRIGjnyNr/huNPBEXq3DR7C/bUT92dAtDRDGj0=;
        b=lL6lwd4PDyGJFA9eaFH/zTMnva1nXW80BVT6Q2LYpBqfPc/2Z+2BWfZCuC0fwJLT9/
         F7OK5l0ajrDtmi2RhKBfuvwF+mRft7IvnQMeVu4Srq275GiNqjTcj7tCGiq02rBrHiKx
         YJHbsvaQNgIumvRENXSOVsuNSWy7GfbnIDH+BurLbZWMhhVj9IwlejgBbiR/E3WfN+/N
         b5sQBKNuVMeOBAWBLsRpDrSJpMCIA2O9cKtF3p7UoK4KpjIQNYG01eRs/zpgS7PjzgNa
         9pOIsHXRIck9KEw+gD7fKHj+qcc8+Idxa/qpKu5T4z3qziB30OKOcjr/h/tPtM8e8AY4
         SnrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQDHnltMOy8IPUpzEzzfgvQf/4OUcIRiw1v+NPyMiZ12ga/EG7I8OOyg3SPJ4i3MOGBheoXuw3l5VN6L8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0c0sm/CzRjseAcA+46svx4D4paAXG9jZjgAS/SEBcJKnhEOTG
	j+WXiOHS5QlYx7yHLG/mE9+wMeEUxPV/PVSyrRpufORbZotSJf/R
X-Google-Smtp-Source: AGHT+IFxvPDIeIHJoeU66/O4f5oN/yiQmU3Kh54cHdZxg+b9cYP8oIDNBU4Pjc+zr6fZbV4dQgDr/A==
X-Received: by 2002:a05:600c:4fc2:b0:42c:af2a:dcf4 with SMTP id 5b1f17b1804b1-42cdb56ae3dmr89967765e9.27.1726483047185;
        Mon, 16 Sep 2024 03:37:27 -0700 (PDT)
Received: from wheatley.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b055018sm107029575e9.10.2024.09.16.03.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 03:37:26 -0700 (PDT)
Received: from wheatley.brq.redhat.com (wheatley.k8r.cz [127.0.0.1])
	by wheatley.localdomain (Postfix) with ESMTP id 0AAF424B2A4C;
	Mon, 16 Sep 2024 12:37:26 +0200 (CEST)
From: Martin Kletzander <nert.pinx@gmail.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/resctrl: Avoid overflow in MB settings in bw_validate()
Date: Mon, 16 Sep 2024 12:37:13 +0200
Message-ID: <f828f3177982a9cfe803d2aa8eb7602b70fcba50.1726482307.git.nert.pinx@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When resctrl is mounted with the "mba_MBps" option the default (maximum)
bandwidth is the maximum unsigned value for the type.  However when
using the same value that already exists in the schemata file it is then
rounded up to the bandwidth granularity and overflows to a small number
instead, making it difficult to reset memory bandwidth allocation value
back to its default.

Since the granularity and minimum bandwidth are not used when the
software controller is used (resctrl is mounted with the "mba_MBps"),
skip the rounding up as well and return early from bw_validate().

Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..7e6014176a29 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -48,8 +48,11 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
-	    !is_mba_sc(r)) {
+	/* Nothing else to do if software controller is enabled */
+	if (is_mba_sc(r))
+		return true;
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
 		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
 				    r->membw.min_bw, r->default_ctrl);
 		return false;
-- 
2.46.0


