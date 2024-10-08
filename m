Return-Path: <linux-kernel+bounces-355915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA19958CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B3F1C21A04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E1C215011;
	Tue,  8 Oct 2024 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="u8W271SW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86311E0DC1
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728420909; cv=none; b=iR5Fkmsu3PqU4b0eEPhWpLgJ0V9RCDbDYOfYXuKBFdyY+4p+XYyJaFKwuI0jejAT8g+k0qyjgdC9XV+Y5zZme/k3fOw6u8OikcqBXPa+WbQfwraSOL+QtM9UuIPISA8svdEg7BoZM2jX4CS1unCeMCs8530pS883Tb0qtzzMylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728420909; c=relaxed/simple;
	bh=4wQNIu4/Ua8YXW4f38TGr99Bjm+K/ywUOAGfzRyvGLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jV1vZF1F9xy4NlBqYg23szW9dYwL1nzewJRPOfL6oigRLXGXGjuHLbkr97PJfhlCuZDQdpiZzZBQdcmUAfxfZVWJ4BQKcAqRcLgaZBmTnWF7SCDtCU1ZATc6LxtwtJtiEcFWjkCII/1tVV0pbJ/mfWhoqM+G9EmpaeSCGdykB1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=u8W271SW reason="signature verification failed"; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b833f9b35so53383055ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 13:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728420906; x=1729025706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0tFkED+mY089YHzAtW+B1O+++Bw0Z0pfmZQ8b1ZguYk=;
        b=u8W271SWslxF5yJIdFPrKRECVQJYttiICI7y/A1ZM9Yrd30i1CHntKDCKeHV5w4IOq
         53E0B7snG9e/8WQ4iZt7lBMqIekPgXIASr+u4ON1LSV56jv8h8+9buwmVSpRrxTVuK1k
         Kkn4MD82rIpqWOF2NIkqM+sV6I8YpVN6Ulx72tpjXkOHPxdySxPCwPrfm60YeyS2ML6H
         on3vcQ2tmDPwro0u0JBL6MJpW7ktgrF7MqFxFjz7xMxgoIVI0g6tRKWCfUYEC0uEu9El
         wLNtaaMtCjZzHjjZp1+IbON6FFi2qHA6AInivWe6X/DBqlnai/juxvKRJ0qZbixKtS2t
         Om+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728420906; x=1729025706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tFkED+mY089YHzAtW+B1O+++Bw0Z0pfmZQ8b1ZguYk=;
        b=WzIwsI4X0aTAGIGdyI9XqxXoSMY3aWkN+vxgvNPmHopMlIGtOpYn7TcH3b9K20bk0O
         Idt6/u5XFF0XBiNE34/rxuANZIg38iyUh8/qItyUhe/amNJzksFR1lwKTPg7xx8WWhCv
         D7R2IOQLZAzSdnUNuhxNM3+Hw4xgyRL0lhVlqopKgOHGYwo3a0IELfDWd+r1Iis8ZWhs
         ev2EDF2Y6199XAPcI8ml8znVLTE9KM4547uJBuwzuiyUPkfVlhbAO1V3e0YtvZ4h76wQ
         ZNj5/9MnKSIyFKiiqp96B3CzWQ+2w7LK/4LGRc3TNEer89zGEywZi6ilxsaaf7gvWeao
         HtGA==
X-Forwarded-Encrypted: i=1; AJvYcCWjbDU4Z9pZqgeOo6a+o6durQL0xfeR7kwXGXxojW6olte7BDUKQTgI1lz+qkocn6/oMOMNfvIvs+kFLPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcnHsRqd+xU7+35aHguoxBp7Xy8utHZlUQPnw+ALO4Hjf0zxD
	H8/Za5XvfBkVtPLotNNTUCsJxbhTQ3envgU6uzwMDQJ+OnF85jkOp3bfiScb1RQ=
X-Google-Smtp-Source: AGHT+IG5QtndTuvxUc4EQsIUMZuzUEKCOMQYR+xtaqDBDhzPRGHOGMjKNeFwj/pDDHDOMAis6O/BGw==
X-Received: by 2002:a17:902:c411:b0:20b:9f8c:e9de with SMTP id d9443c01a7336-20c6376dfefmr4938325ad.13.1728420906131;
        Tue, 08 Oct 2024 13:55:06 -0700 (PDT)
Received: from localhost.localdomain ([132.178.207.21])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c13986787sm59611735ad.242.2024.10.08.13.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 13:55:05 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	skhan@linuxfoundation.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/xe/guc: Fix deference after check
Date: Tue,  8 Oct 2024 14:53:48 -0600
Message-ID: <20241008205352.4480-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `if (!snapshot->copy)` evaluates to True only when `snapshot->copy`
is Null. Thus, derefrencing `snapshot->copy` inside this if block is
equivalent to Null pointer derefrencing.
The `if` condition is now changed to evaluate to true only when
`snapshot->copy` is not Null.
This issue was reported by Coverity Scan.

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/gpu/drm/xe/xe_guc_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
index 7fbc56cceaba..4e1a5e8ba1e3 100644
--- a/drivers/gpu/drm/xe/xe_guc_log.c
+++ b/drivers/gpu/drm/xe/xe_guc_log.c
@@ -122,7 +122,7 @@ void xe_guc_log_snapshot_free(struct xe_guc_log_snapshot *snapshot)
 	if (!snapshot)
 		return;
 
-	if (!snapshot->copy) {
+	if (snapshot->copy) {
 		for (i = 0; i < snapshot->num_chunks; i++)
 			kfree(snapshot->copy[i]);
 		kfree(snapshot->copy);
-- 
2.43.0


