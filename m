Return-Path: <linux-kernel+bounces-169198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BC28BC4B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 01:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C5B20DAD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 23:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F064140374;
	Sun,  5 May 2024 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="KEXLAvWk"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43BE374CB;
	Sun,  5 May 2024 23:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714950669; cv=none; b=BhZP4bQD7e3rQB/qqx1NhVrUhUpFFAGP+ch+EK4YlWf9RKPdYFJJSQfN0BYqPlwFRdHHG+fzmHPGhpABcvT206gc0rqXGmwQdIxvYcI35XmYmoKFElOeoNYIoyayOwUzz/0hWKbOLWTGXDCuzaKKPGfqCRWsZXYpJ48/nepMJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714950669; c=relaxed/simple;
	bh=loojZtttU7t5pbIgoFyEFs7JafS9UXGFyu75MeYPuCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2rtq290+xcWQ5U+CiYzets236iivmr1QSAxhhYw+uCltTYByMpGJ5gR/edO3+GmDJc/npeO1qIhggDbcREJn4TALZ1h1vJG1fdUrOxZCyRZEVZqYFbsTchYTPNP3h09zR9o5eUbiUK/yz17IsgGEkTCXA/XsqmVd5RbBZFe6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=KEXLAvWk; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=oC9FD8zt+F7Rybkip3HU5AJe3eOY0yHHuJQ8UoqywNs=; b=KEXLAvWkqGss/QP4
	0nWairnDQzlXLv2zrLky7D537VdKiodcsOQZImnkPf435ZT/TtWO90s+jtDC5qlTo4+c0YRfrN0nG
	YpAwMjZFDxTrCbMKAiJLoktypupHO83vas/Bw/DpfKvSc25Dy7UXkUmWYlTaP1SX8lU14Odmw+Zqd
	la8iIBXXgTj3r+qY9/7fCXoePCrW18gX+3mNUUiPVWHGd1fM230MWO/EeZNkSxTq0ZBZEIpfZwEIC
	TqkpTGcDs7Zkl2HVs6Q1e1ZDjV0hZ7YwtV+I4cbFBOHv4CO0aij7co1gNCb24MMLr3LpxpOhd5c0C
	WKBYM03KkOM3mATGjg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s3l0Y-004pPk-1u;
	Sun, 05 May 2024 23:11:02 +0000
From: linux@treblig.org
To: James.Bottomley@HansenPartnership.com,
	deller@gmx.de
Cc: linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] parisc/math-emu: Remove unused struct 'exc_reg'
Date: Mon,  6 May 2024 00:10:59 +0100
Message-ID: <20240505231059.680502-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

This has been here since pre-git.

Build tested.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 arch/parisc/math-emu/driver.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/parisc/math-emu/driver.c b/arch/parisc/math-emu/driver.c
index 6ce427b58836c..34495446e051c 100644
--- a/arch/parisc/math-emu/driver.c
+++ b/arch/parisc/math-emu/driver.c
@@ -26,12 +26,6 @@
 
 #define FPUDEBUG 0
 
-/* Format of the floating-point exception registers. */
-struct exc_reg {
-	unsigned int exception : 6;
-	unsigned int ei : 26;
-};
-
 /* Macros for grabbing bits of the instruction format from the 'ei'
    field above. */
 /* Major opcode 0c and 0e */
-- 
2.45.0


