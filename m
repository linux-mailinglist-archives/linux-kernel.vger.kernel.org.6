Return-Path: <linux-kernel+bounces-245096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6192AE2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532EF281F8B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94B93BBC9;
	Tue,  9 Jul 2024 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lPrIMDxG"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA1C433DC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720492451; cv=none; b=PiFdgVqzO24WsRWAxCgWqOFAGCV4IGjkeGVQJiQJFWjSErDF5ZSecCV7eiEGDE0ccUT2hKbb1jie33AVC2EJ4r6dT7unRg5J4YXyYxRx3NiKWw4YafZEzmrpwrXr6/ncdgTBvUnxLlo8wEE+YeX90VXAbRJweMWw7GsxR3/VUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720492451; c=relaxed/simple;
	bh=j5f0t/ZkTfAf72f4lGFD54355I0VA9/bqSSd0R415nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V/z2hysfXrOSMDNBYM+siR2kq92hV+Tf4uBIGOc0mG8ApL11IcNj++wfNOnig5SoDxWhFCkyfo1RY9Ia3UtBXCFwuHTQ7vx8kXj293raFqJ3mei5B/386AVjPM6Iv2ot/Ai+juk7wJBheWrqANu5KWw54r9LrbntVBU6BWLlcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lPrIMDxG; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: peterhuewe@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720492447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dESyPn6fHrrOFKeg+MO25QiK3iZkAlXxA2p63xOXIIY=;
	b=lPrIMDxGWCyHR57OVkrJg87ZZD0TGd2S1Af6GBKzggvUm4/6/Jrpj8H21dk/MPbYMdEKlg
	zTawyokvClJJDfeaNFMe1lyOEFhglOHIL0poxgMxjPiqsSSMBjz8xMAQAUe3kj1yMuh7Fy
	Oxfmm38U1TNLhzZUWecQhH81dd8c9u0=
X-Envelope-To: jarkko@kernel.org
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: linux-integrity@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hao.ge@linux.dev
X-Envelope-To: gehao@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
To: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hao.ge@linux.dev,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] tpm: Move dereference after NULL check in tpm_buf_check_hmac_response
Date: Tue,  9 Jul 2024 10:33:37 +0800
Message-Id: <20240709023337.102509-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

We shouldn't dereference "auth" until after we have checked that it is
non-NULL.

Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_session*()")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
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


