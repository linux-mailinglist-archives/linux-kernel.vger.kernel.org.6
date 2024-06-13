Return-Path: <linux-kernel+bounces-214026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C306907E18
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39532868AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEC614374A;
	Thu, 13 Jun 2024 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="pCvdsCYq"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BEB13BAD9;
	Thu, 13 Jun 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313958; cv=none; b=UD3ZR4bgegrx+FlxgZ7CIjXfASGOuX/4KlgHhK571gO37uvBWgaaAGVOl60dSFyVojQoi4beNIfYDKl1/iA6r4UtsQuypMM3eyniSu9LRiLoAK2buwz4inxslHQ6f+Ke4kecpIEPmbrBcPGAdY4I/HcJyt6vYiUqZrbPPVOUOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313958; c=relaxed/simple;
	bh=6oPn3wrqX0l+t5ROEP0pwn1fL4VOz+XZFue25SmIsOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkeIn8QnVA75+wPVlWP1fjFvuA+wVFaKbCXa+ZwObk7MZXiuEiMClF+VBL4IAhFdpX1Dn57+h5XCJ7xGrVV40XwYiQnF9JtjVJ1lNKBJKpEeTCqVuoBoUs0Fd/H7Or8JuzDDshI2Iy+XFLlU7FT55a9euuNVzJ4Sdhd3uGxObpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=pCvdsCYq; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W0b742dHhz9sj1;
	Thu, 13 Jun 2024 23:25:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1718313952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m0CctiFYHR/2FJ2WI6KLq+krPX1+1RwVnGUumUa2SXk=;
	b=pCvdsCYqoLm3uQMGlS3Nlbpco9uXdz3Tpab+HP5FF/+a5/zNh/BuH86NrPwOlOh+4CYaeD
	i3YDpE7zbwZD8fQUQp05FnPbhcTeUYkabQ/RZHUwA22me+/MWs8xF/po5ZhzPQn/fnxrs1
	56TtpvIFQA2laELi0CiqYZZkZcRzhdcZ8+cowpy9TE9I0t6LUdtxLw9rEbA2AUAhpt6hmG
	Kn4lseCyWxyn5I2/gfeHEVIAViCRp6rP0IVDqbDsDBUjqjreWe4AREzLDivkmj1tu+h5Ys
	PF7IlyJPVRi3uDl/9r5kz4npHaHaGnD/8yF4+OU+8rylOO85LslCapAmLcgvEg==
From: Ben Walsh <ben@jubnut.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Cc: Ben Walsh <ben@jubnut.com>
Subject: [PATCH] platform/chrome: cros_ec_lpc: Handle zero length read/write
Date: Thu, 13 Jun 2024 22:25:42 +0100
Message-ID: <20240613212542.403-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W0b742dHhz9sj1

cros_ec_lpc_mec_read_bytes and cros_ec_lpc_mec_write_bytes call
cros_ec_lpc_mec_in_range, which checks if addresses are in the MEC
address range, and returns -EINVAL if the range given is not sensible.

However cros_ec_lpc_mec_in_range was also returning -EINVAL for a zero
length range.

A zero length range should not be an error condition.
cros_ec_lpc_mec_in_range now returns 1 in this case.
cros_ec_lpc_io_bytes_mec checks for zero length, and returns
immediately without beginning a transfer.

Signed-off-by: Ben Walsh <ben@jubnut.com>
---
 drivers/platform/chrome/cros_ec_lpc_mec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index dfad934e65ca..a56584171168 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.c
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
@@ -93,9 +93,6 @@ static void cros_ec_lpc_mec_emi_write_address(u16 addr,
  */
 int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length)
 {
-	if (length == 0)
-		return -EINVAL;
-
 	if (WARN_ON(mec_emi_base == 0 || mec_emi_end == 0))
 		return -EINVAL;
 
@@ -132,6 +129,9 @@ int cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
 	enum cros_ec_lpc_mec_emi_access_mode access, new_access;
 	int ret;
 
+	if (length == 0)
+		return 0;
+
 	/* Return checksum of 0 if window is not initialized */
 	WARN_ON(mec_emi_base == 0 || mec_emi_end == 0);
 	if (mec_emi_base == 0 || mec_emi_end == 0)

base-commit: 77a714325d09e1527d865dc011ef91c4972ffedd
-- 
2.45.1


