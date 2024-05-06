Return-Path: <linux-kernel+bounces-169212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146D28BC4EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 02:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE64F2820EA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6438C11;
	Mon,  6 May 2024 00:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="sH8eA+ta"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F746FD3
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956192; cv=none; b=ACsmm55uiF3fbunvxCzgZ31kUh6HfgR7FB1YpKTUwrhHNQkDQqALWBdBwKOfmrxJvyx0uhsF3nhiQqq2kBu9DVxu+7mv58haYZp5EcexcoHg1mZ5F8QRS8k7o1r8cuFmhcuHCtkX0ojYibW906/rXrbHSqPaFGxxRiBdl+UhR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956192; c=relaxed/simple;
	bh=uOX0PhmvNHgWxT86ZneadqdUQba8W5dne4B8qtTTjss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJGTlhTfWDH7ttrRt/TBcyV2uXQY4Ervo9KQtlHx6SKlZJdHcRlzCKzs6hx9B2yhZGkXY2P5yyq3RNqgFZ6oeumd02emOeJ5DV1zsS5ymskqHS3f+4S5EE2ezhBFgrF67zKBV/cwIf2B4cExjWH5N6mgDBszcFv3/e/avUFT380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=sH8eA+ta; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=G1Gj2Hnzo2ZD16fHfZrhJMRm2fpUj1qxW5xMXWXwHbE=; b=sH8eA+taaySOAqS2
	qt12dVmoYI3Y6ZYzlOmi+CyYU161TSoMCsIRbq+oRWdIdJedYL7cVa+SheovSGhHknYX5DkSXI7Sx
	hNnUT2xeeABib5fxcx5PFjOq/5PhS1BfpV+b39hp3wjLvk5cv0d3OWTaz/nGUHvBZKClldqO3OvnF
	MYOQxiol6aBSxZqqIYW95N+7EQWwM8MnFXigAP3DUJkhGk1n7Q3FqIcJe1Xz+NoET0xm2CGc67ib7
	janthHYkGQ3j6Yo2GOXRgGtmJfWKjRV5T69noHDcI4kfZT+SBReIHqUmcGCveVAtkbKBSMbdpN9c0
	hJaPzKJdQoEOfDiSLA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s3mRb-004ph8-36;
	Mon, 06 May 2024 00:43:03 +0000
From: linux@treblig.org
To: bp@alien8.de
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] x86/microcode: Remove unused struct 'cpu_info_ctx'
Date: Mon,  6 May 2024 01:43:00 +0100
Message-ID: <20240506004300.770564-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

This looks unused since:
Commit 2071c0aeda22 ("x86/microcode: Simplify init path even more")

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 arch/x86/kernel/cpu/microcode/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 232026a239a68..b3658d11e7b69 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -60,11 +60,6 @@ module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
  */
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
-struct cpu_info_ctx {
-	struct cpu_signature	*cpu_sig;
-	int			err;
-};
-
 /*
  * Those patch levels cannot be updated to newer ones and thus should be final.
  */
-- 
2.45.0


