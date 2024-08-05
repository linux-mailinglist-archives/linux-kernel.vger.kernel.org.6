Return-Path: <linux-kernel+bounces-274650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AD1947B1D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9875D281751
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87906158DDF;
	Mon,  5 Aug 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="S9YqwyOF"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0915531A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861718; cv=none; b=enXqKBxzgklsGBZ1YlvMICCG7PSBymPML8/1FUZ/S6I9Ay9YT6b12WInBi+9GDR18KrMHtg734G/xqYPkMUpyCyJ3BasXUbj301AQR9rb2B1oDIWSSx/LTvetxae6thPzLijhywl17UoGuw4iTG/jfO9wTX2R16WeyALS1NiVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861718; c=relaxed/simple;
	bh=3A6rVcuW0m0078khO1mNI86Z9b7w2oQ3ht6yUDw5gfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XqX/he/dXxgmiube7dgaiC8eEWHS4yDS7mtHgyAoS5PwTX0grRiLUkF/6dOv1YeAYGMAt+yC/owhxl1S04CcIdLVHSkKBOWHTz6JHjbbr64khmKUrL32DtQWfouNfWUjgokE7Misv38Jma0NPManbpdnlffc9TA520/Lwm0WCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=S9YqwyOF; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240805124147f472750eb3c525785e
        for <linux-kernel@vger.kernel.org>;
        Mon, 05 Aug 2024 14:41:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=z1LmfkSa79b3Ou+9g4Zco79UrjCLf4Sb2US5vjHH17Q=;
 b=S9YqwyOF76pn6ZoLSTpfiZGZNgK+ngZt8pMMBzuPpC2BMtP/Pjn383PAfbfVV017vsXUio
 P21Gzy+W9eku0WGncrJRauTDz58cgwSCTYP/OLYGQXCCwlpMHAEcRora4i/zy92TDn3C4H9K
 1TWVsm4trgmaa8xfPQJD82VaSCsKITrqyOhjx27K6Tt9osQjRXZRuawSVtjuYx7/GRkqLi2Z
 /2k9SlhoTw2pOMZbedbqVTn5KQZbyT4+EG3NvAqSutCvavKv0KZjkmixg1hD5u2v13gL6iy9
 WLWCOAFGTHhIWXc9LOZAUE48y8kH3f5YviICG/Qzh5UGsm8qoswa1ILQ==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 1/2] hrtimer: Document, that PI boosted tasks have no timer slack
Date: Mon,  5 Aug 2024 14:41:15 +0200
Message-Id: <20240805124116.21394-2-felix.moessbauer@siemens.com>
In-Reply-To: <20240805124116.21394-1-felix.moessbauer@siemens.com>
References: <20240805124116.21394-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

The documentation of schedule_hrtimeout_range already states, that RT
and DL tasks do not have a timer slack. However, no information about PI
boosted tasks is given. The current implementation consistently ignores
the timer slack also for PI boosted tasks (all tasks with a rt priority
at time of programming the timer).

This patch improves the documentation by stating that the timer slack is
also ignored for PI boosted tasks. It does not include any functional
change.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b8ee320208d4..2b1469f61d9c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2311,7 +2311,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
  *
  * The @delta argument gives the kernel the freedom to schedule the
  * actual wakeup to a time that is both power and performance friendly
- * for regular (non RT/DL) tasks.
+ * for regular (non RT/DL or PI boosted) tasks.
  * The kernel give the normal best effort behavior for "@expires+@delta",
  * but may decide to fire the timer earlier, but no earlier than @expires.
  *
-- 
2.39.2


