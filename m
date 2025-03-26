Return-Path: <linux-kernel+bounces-577220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03128A719F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E55216F2C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0C1F4177;
	Wed, 26 Mar 2025 15:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MurPLbRg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42E1F4174
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001935; cv=none; b=pTx5wAwLeH5sWAAgsmlCk1lZgzSyUJH4X0UwzbEXvNm3EDKfoAwmJNvbIAk6ESdDQZ4j/9u/Tr51T9mIAGBteoeogjNzS7CEhokwMvfjLwfK/GZHSzyN+0oqtMptT829NvzENA2BVex1DLKAjsePN5nTlrf3/WMHr1bcmQSYBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001935; c=relaxed/simple;
	bh=dvH6cZROBDqL/EIJB0ddluLgh3GMP5pgXEtD5g291tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQxBjv4Hpv/rJEVcoN/5DAetBXYAQcfNM++r5iZT8phmtHiLu/rCJ3KAEuqzqy6ffyuEgAPLj8oD9G5nwxUFtscLmkYOL1LlhmcNF5Qtdfnmpdbtsd6oCsCd+9eV0diUhXdALWysZAF6aQXpSZw5LUfT8xresIHTaKWrp6pvX7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MurPLbRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6FDC4CEE8;
	Wed, 26 Mar 2025 15:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001935;
	bh=dvH6cZROBDqL/EIJB0ddluLgh3GMP5pgXEtD5g291tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MurPLbRgOhvxG7DGoeI4e6uf1uBNgQKuYEVn+R9J1Ys/ntkU8s2GjleUUf4P5gSje
	 K0Qw27qmTj6yClEmUiZYU3Jw1dUraF20/y3Y5X2ULu4JIBKzJDJcs5zPefI7Hkzoie
	 vbSpNhTmjCjRrUQu0tIv9GAwFTQynj6olDOMx+wonf4CXVF2xg0OSv6n4KuZs9Plps
	 V14SmWmJUQLArdVDliLtaFaZ+VR12eQgLTD7XuLG8HExBuGdATgUYre2U3B9lGEfxr
	 RcHi7NoRsrkmWAkQfXjInPNCwOkLvWM6CaaRHxsMWSD8aK5/8DS82WxDealKGyUyX0
	 LuAEXKNekpppw==
From: carlos.bilbao@kernel.org
To: tglx@linutronix.de
Cc: bilbao@vt.edu,
	pmladek@suse.com,
	akpm@linux-foundation.org,
	jan.glauber@gmail.com,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	takakura@valinux.co.jp,
	john.ogness@linutronix.de,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH 1/2] panic: Allow archs to reduce CPU consumption after panic
Date: Wed, 26 Mar 2025 10:12:03 -0500
Message-ID: <20250326151204.67898-2-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250326151204.67898-1-carlos.bilbao@kernel.org>
References: <20250326151204.67898-1-carlos.bilbao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <carlos.bilbao@kernel.org>

After handling a panic, the kernel enters a busy-wait loop, unnecessarily
consuming CPU and potentially impacting other workloads including other
guest VMs in the case of virtualized setups.

Introduce cpu_halt_after_panic(), a weak function that archs can override
for a more efficient halt of CPU work. By default, it preserves the
pre-existing behavior of delay.

Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
Reviewed-by: Jan Glauber (DigitalOcean) <jan.glauber@gmail.com>
---
 kernel/panic.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index fbc59b3b64d0..fafe3fa22533 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -276,6 +276,16 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		crash_smp_send_stop();
 }
 
+/*
+ * Called after a kernel panic has been handled, at which stage halting
+ * the CPU can help reduce unnecessary CPU consumption. In the absence of
+ * arch-specific implementations, just delay
+ */
+static void __weak cpu_halt_after_panic(void)
+{
+	mdelay(PANIC_TIMER_STEP);
+}
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
@@ -474,7 +484,7 @@ void panic(const char *fmt, ...)
 			i += panic_blink(state ^= 1);
 			i_next = i + 3600 / PANIC_BLINK_SPD;
 		}
-		mdelay(PANIC_TIMER_STEP);
+		cpu_halt_after_panic();
 	}
 }
 
-- 
2.47.1


