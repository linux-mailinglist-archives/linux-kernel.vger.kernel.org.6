Return-Path: <linux-kernel+bounces-252130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0701930EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB725281F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDAE184105;
	Mon, 15 Jul 2024 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sfhzg7CD"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75D41836FE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721028306; cv=none; b=cTQul1+fMoPDMRK+UP6tmv7STHV1P6TuiZESwIq2TGcotGuTqnVv69w4Rix4HMa95ODfVbswPRxsfjXnFy9aB9yEdg/+QXKRbSZSuS8nsXTpSSpk3VqSq+MO+K6uCk789j9/o+50FiW6NRqO15ZjbTa8vKeOaguwFhIBpLKuQP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721028306; c=relaxed/simple;
	bh=sbyLlhjofZdAJtPNPgnb7LPHkkkU7QhNTT79vwUcv54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/5jW554jF3GXV3XmHgDGbyIEcrVqh+T1GfL+jHCUqx5OSA8kfSDPfsOcPxKkpEObhq0cUczoRjFPV+4DUW78tHyXUJMQJ0pVa7QimoUzg9FFmRV33AIpONMg0pXiAluq2OdM2qG9HTIbV1qXuzHf2xYQ6C4LFjy1Vk1Eh5RDGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sfhzg7CD; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jarkko@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721028300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwcjV/bevO35hmapj8qjcNG5QxUfmtf63GLtye+Mzas=;
	b=Sfhzg7CDnh2hGMQjojYRzdOIWBGfHdH9UTldSKMuH4eMy5ZcDWpFHIRP0+PMevBgTRZP0B
	S8/Yxu6vie+z+GXxnRfQIoTCnIiy400wuFpWq3rJH98MECMhkkdrq0Ny4823xSWgDTLu/K
	ohfxxzCYJy5r474Fd6a08WfGDUyZse8=
X-Envelope-To: gehao@kylinos.cn
X-Envelope-To: hao.ge@linux.dev
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: linux-integrity@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: peterhuewe@gmx.de
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
To: jarkko@kernel.org
Cc: gehao@kylinos.cn,
	hao.ge@linux.dev,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peterhuewe@gmx.de
Subject: [PATCH v2] tpm: Move dereference after NULL check in tpm_buf_check_hmac_response
Date: Mon, 15 Jul 2024 15:24:28 +0800
Message-Id: <20240715072428.474760-1-hao.ge@linux.dev>
In-Reply-To: <D2PDLHX51C3K.16A4U6XFXRE29@kernel.org>
References: <D2PDLHX51C3K.16A4U6XFXRE29@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Smatch static checker reported below warning:

    drivers/char/tpm/tpm2-sessions.c:755 tpm_buf_check_hmac_response()
    warn: variable dereferenced before check 'auth' (see line 752)

Move dereference "auth" after we have checked that it is
non-NULL.

Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2:
- adjust title and Fixes commit
---
 drivers/char/tpm/tpm2-sessions.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 2281d55df545..d3521aadd43e 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -746,15 +746,16 @@ int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 	struct tpm2_auth *auth = chip->auth;
 	off_t offset_s, offset_p;
 	u8 rphash[SHA256_DIGEST_SIZE];
-	u32 attrs;
+	u32 attrs, cc;
 	struct sha256_state sctx;
 	u16 tag = be16_to_cpu(head->tag);
-	u32 cc = be32_to_cpu(auth->ordinal);
 	int parm_len, len, i, handles;
 
 	if (!auth)
 		return rc;
 
+	cc = be32_to_cpu(auth->ordinal);
+
 	if (auth->session >= TPM_HEADER_SIZE) {
 		WARN(1, "tpm session not filled correctly\n");
 		goto out;
-- 
2.25.1


