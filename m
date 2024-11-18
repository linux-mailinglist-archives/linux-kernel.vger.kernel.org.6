Return-Path: <linux-kernel+bounces-412534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D3B9D0A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667F12822F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A7176ADE;
	Mon, 18 Nov 2024 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="F+HMMT4V"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10865155312
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731914992; cv=none; b=Z4cKpOQE7ObP9d7GbUOtv1iHiFhJCWNJL0j4HFOWgxvC52Ar833gPDBHGZdnF4vQfSF2Y/wgWT/hcPvE/Z4C9AQgy/CHp0O5+6CwYkyvdXnW7lndlFeY44JOsA4OJWrqFLHh1WdygDR0JG2jFLnYlbJvna/IZmDG3tDjsL/CkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731914992; c=relaxed/simple;
	bh=WzUzZSeOucpGsbygrODX4oeceGvz4iDcK5HsaF1ybk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r58XCvtwp7faLXUS7FfcZBI3Ke4hiSUvF8ypaML8EztZ/WeWLcFxvjUk/aIIUWXn1S0M7gxVvWuuj4Jg5fvDh0gMg19ZknWVLZZLlLDgMgS2l13nkq/32WNdwJyX13kpMSjBfZ+VSaVQZTIPp2T1a7Auq6Cva39WKcWTLouY0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=F+HMMT4V; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=muLgn7CbcvkkVNpnLY1BgXOUBwVevTkmOrnBAmTOJe0=; b=F+HMMT
	4VIPL6J9uzgetqvRXp3N9z3t7h5pavjf/fj9ATLgXSJrQNLH/gvjy28WPsq3jobx
	xshS6WRtgurLnjnBJamUfTKtw4/u8cpLgaVt/bjRdZHpBgvVntj+X5zhJVfH2OUL
	20FVS45oBa+WBCVpn/E7IiHThmhLqUaiT40Rgia3YX4RrOFk6EpeDc7vN9yyLSW+
	TPqHLjGgV6xcQfa3baxAetAY1WXb4LnOGMBDuGeqqlwWV2eb/vrrEtxcJqE9avhN
	odiMsyeVhpRyfueXx2y1AnvV8N1C6VIKXuxhBFG/8VbRPnkYO/YbQqduZPXhMIBD
	8ywOC/UX4yFPVIrg==
Received: (qmail 112293 invoked from network); 18 Nov 2024 08:29:35 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:35 +0100
X-UD-Smtp-Session: l3s3148p1@9Zfj4ConvtUujntT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 01/15] x86/platform/olpc-xo1-sci: don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:29:00 +0100
Message-Id: <20241118072917.3853-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header clearly states that it does not want to be included directly,
only via 'device.h'. 'platform_device.h' works equally well. Remove the
direct inclusion.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/x86/platform/olpc/olpc-xo1-sci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index 46d42ff6e18a..36aad8cf97a0 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
-#include <linux/pm_wakeup.h>
 #include <linux/power_supply.h>
 #include <linux/suspend.h>
 #include <linux/workqueue.h>
-- 
2.39.2


