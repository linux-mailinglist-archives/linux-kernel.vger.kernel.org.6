Return-Path: <linux-kernel+bounces-386966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11A9B4A41
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D111F23A32
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA456205152;
	Tue, 29 Oct 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuPxIOvG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44838206979
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206505; cv=none; b=V2iV1u8Yji1qqWp3f65zIyUI4TzYklQvxOfhO9gmZRfVIEz4oi+mjaf++tCVymrlDpLf3jaszirtTJpQVxUXtJZp8n8RnC9SPXu3fKc3ptKHLOmRvbahFMZksGRo1VXrufTNhlRdHukW2S5gZrJ3wfzPKyBqimsVDLW+kKB1eMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206505; c=relaxed/simple;
	bh=wsrgcgckUzKVDFRbi/YSgS+i6orOaA/wjwoY2un0FkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/MYTPSEwGgcTa/tFMt/yaWnKE7YszR8gYw0WraGAeLXQf0lmeTcXRs1hkI417gj2xgpiekgAwjLBORgtXVkVFjSA+/1Ugb+im4NWuMeO0aQt5b7TmzF/fLO0+/71Gt0Byshglw0Uup62PPc2sICSS3R5sjRptQCHRMEAvUw0BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuPxIOvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4371DC4CEE3;
	Tue, 29 Oct 2024 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730206504;
	bh=wsrgcgckUzKVDFRbi/YSgS+i6orOaA/wjwoY2un0FkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UuPxIOvGybzKkys8k2LVtms50JndeSNUJ5GCHKY85ECulRtSECWCwMGoSvFakNOHX
	 Bl4y/WCSgQPm5CN1AjONBxIK1zBBcpcyaqop4Dh2vN7swUrY70rjgC6vIuX8CjW1nk
	 OTTTDoFCgrzF0/Jmuf/7j2dnWaF48voPhCQnaV2rWiKcw+SPxo9KH5wlbDcyYxz4lU
	 sV2GoQ7PrSdAJ7QPfA4luNjfG/k2ChoDg1xqFRNH1kL9CZ1lc6kEaH/YiJbX5LTl6X
	 2xmfbKFkop17dn4NUtLpin8u+JZ0HUMid6Y7h/YbYBgLea9fiSbdz56hKErDNGDyjS
	 PDVRlx33siCaQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/10] ARM: smp_twd: Remove clockevents shutdown call on offlining
Date: Tue, 29 Oct 2024 13:54:45 +0100
Message-ID: <20241029125451.54574-5-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241029125451.54574-1-frederic@kernel.org>
References: <20241029125451.54574-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm/kernel/smp_twd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 9a14f721a2b0..42a3706e16a6 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -93,7 +93,6 @@ static void twd_timer_stop(void)
 {
 	struct clock_event_device *clk = raw_cpu_ptr(twd_evt);
 
-	twd_shutdown(clk);
 	disable_percpu_irq(clk->irq);
 }
 
-- 
2.46.0


