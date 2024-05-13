Return-Path: <linux-kernel+bounces-177221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D948C3B95
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F226B1F21581
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E176E146A60;
	Mon, 13 May 2024 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbPmMD2h"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ABE14658B
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582899; cv=none; b=cTAwA1Q06n8IfGlUdoXSLMA/d1aPua8aJE1rH14FpMaLZOVfNYWrPHEwaL+8sW60NuapEAOzQOPULNMTvvDnAp/KSbN7byz73PlastvngJZnz7onC6LzBbfAclGDa/Vv7Ywb3zhQmmT4YorL9u6lKdMUEyNKMEnxHr7H4g+niKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582899; c=relaxed/simple;
	bh=g+Txp+V6bBnZ6mNM2ldvG8Bo61JXNkhjI7TrcZpMoR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JA9xwbqKsNhieZm5T0CNM67/Ky4ndJWscoMwKp6gqczez/Myq6C0JMlakRDialrz/cH4P/dzhbu1Srd5Z2YPaih0rRpIuC312YEMe72U1rLigmdnnPhlfHdyid8DpYVa+x/gMTKg7cKRGOkx1YIxK+aFgkKEnjnSscD71SdkLm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbPmMD2h; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ee7963db64so33297925ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715582897; x=1716187697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WAn1QnCLmKhF79JSYAzXqb2f9rtYvseqh4fzWPBN/xY=;
        b=mbPmMD2hR5W7BluqXRZ0BY9+iI5/dkoil7vdm6yvF5KC7vQdrn17Bokc14GoZdnf62
         Il3MLmr5QlRPeiE8djdX3iMrGC1HDtlzLdLhyVyd6r5X0xIUXmtftBwr+b0WzXWud+EG
         7zqaTz4j5+7EHB63yCVdBwhR1I1HohvzP6Qj5snEmVBptR5biefkd2hDpM/rOiFBn1/y
         qCWU7PlGnx73LrqJdillc/p6unySEawwRc8Of5+kKgyzBTtsMkLC0ayBeigQ69QJ+nKX
         2sMmaKRDghMmmhfOuvKN6DIIE+jBkyD/f44CfoL3ytbJQrN7qOlCkwUlqQLTU5xxps2W
         FW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715582897; x=1716187697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAn1QnCLmKhF79JSYAzXqb2f9rtYvseqh4fzWPBN/xY=;
        b=M3WSbQJ7KeOwLZCKQfTpY2nmSdK6/kGhVmsC3nt6DR/2UgORfdb7/JmuMh3e7uHzLC
         AjH9xgIE8zHQ98SB7/jo1IA8rVR8wDvo9Iv7ho1COnCbYYlAP2LCOhMmZdDPRRn9mX6m
         zJhVbxilP2QOz9i35WdC09Dx1w2ifY2QMuNqV+HnG71j62eVmUSbxbLDB9JaH0xCdY3x
         6Wj+pqGVx8uuRkem7N3cikHpJGmjSs++X3gNzs/GGUNcvidZZCiqQLX8E98eI6Uum9AM
         2Q9O4RG17oq01jKU89dxhy8G+6NwiGWs3MrKL5yilYGeluO6UpIpcaRsoS02D4voMx+a
         eOBA==
X-Forwarded-Encrypted: i=1; AJvYcCWrBGnaekzqAIRyMx21pHFP/6toMUqfLqir5nOjDioiDPVeBrSm9U6M1u2XH4zqTKX9CuJzWo5K/NNP3lZbgnv9HtxRxeN8iNWYji3Y
X-Gm-Message-State: AOJu0YzAUnVyVL2k+rdh1M8NUwUtQPQL1RR1AsXqxO0881EV+R3KisWK
	Yu0lMscT+R8IAl3YyCe2GhpboTFGl2ZOSpNiD79vA8yPuvGQ8h2L
X-Google-Smtp-Source: AGHT+IEKlTF/Ld4tfYqam1+K7GJQo14DMMl6bt/fxvXZP7TcBciAH9kQTe1fRn5e3zRlO1WqIYbZYg==
X-Received: by 2002:a17:902:9a4b:b0:1eb:5b59:fab9 with SMTP id d9443c01a7336-1ef4404a1admr97980705ad.53.1715582896474;
        Sun, 12 May 2024 23:48:16 -0700 (PDT)
Received: from jay.. ([140.116.245.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d35fcsm73500465ad.25.2024.05.12.23.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 23:48:16 -0700 (PDT)
From: "Tse-Chia.Chang" <merqqcury@gmail.com>
To: snitzer@kernel.org
Cc: agk@redhat.com,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Tse-Chia.Chang" <merqqcury@gmail.com>
Subject: [PATCH] md: Reduce flag condition
Date: Mon, 13 May 2024 14:47:00 +0800
Message-Id: <20240513064700.88178-1-merqqcury@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear DM_COPYD_IGNORE_ERROR will have no effect regardless of whether
it is set in the flags. Therefore, this patch reduces one conditional
check.

Signed-off-by: Tse-Chia.Chang <merqqcury@gmail.com>
---
 drivers/md/dm-kcopyd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index 6ea75436a..7a21875b1 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -817,8 +817,7 @@ void dm_kcopyd_copy(struct dm_kcopyd_client *kc, struct dm_io_region *from,
 	/*
 	 * If we need to write sequentially, errors cannot be ignored.
 	 */
-	if (job->flags & BIT(DM_KCOPYD_WRITE_SEQ) &&
-	    job->flags & BIT(DM_KCOPYD_IGNORE_ERROR))
+	if (job->flags & BIT(DM_KCOPYD_WRITE_SEQ))
 		job->flags &= ~BIT(DM_KCOPYD_IGNORE_ERROR);
 
 	if (from) {
-- 
2.34.1


