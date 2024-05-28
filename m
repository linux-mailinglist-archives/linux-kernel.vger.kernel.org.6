Return-Path: <linux-kernel+bounces-192561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92A78D1F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9821C227FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6246B17083D;
	Tue, 28 May 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmaE18Rz"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0DE170837
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907444; cv=none; b=E+Zxu6CrfSHikAihrCVJQfTQKL4XGb23bu5SO16I5Q/dOKFW2ErkOXgZ+Einm7F6FkVxp6icY6D5TE2uYZ1WIuCwB0um624MKYEVx5vN2pqQrNgzoRUOVvRNsRlxGiwVxATec2mtnx5b/plOE0rc8FLZy6USEfPWZiWVBVqlxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907444; c=relaxed/simple;
	bh=mCO/rmIafDIe5Hkv/1oVwSP41shS73lnAxb063HgRtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYqBRFsVvgNuKNUiOrLjnq/eOVBc81lTgrToS/zVV1ifnZmfRknKO7BUEHdXfbefHrDHFXJEWW/n8318mqO3xHjVxEP5P5L5k2Un/Yvfdt2Gd50TSMxQtudJCz/tv34SykdPWVSjScnnLxFHXQqnfQTyRQoUfhEpH2bJx8FsCpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmaE18Rz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-529614b8c29so1562261e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716907441; x=1717512241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UMfUDTirHx9AqY5s/gqdnHQ3Y6Rgml00jUPMDkQzF2g=;
        b=LmaE18Rz44hwKWElg472qnRjNeF11GtugZp8MZm82EkKHML5296DfBqJcMIdSOFse0
         ndXrIZrqZZ0WGvrP7llwGMw8bCzZZBriSoW8e2IKDgnJOcygeAofpXybdLPBNsRaeEY5
         f0XbZ0oNnc/uU6hLyV8ZWw7CDdAmx8ROBqCVi6R3X7fZq/+4nbTi+xPVZ+Wgjv3nXfQL
         MrswU34LFTbE53oU4KON6lpCJbmdzarlzINbCubfjL6G/ErZmfEohmn4OH5/fiEcc6NJ
         h8XoCcaWOXRp9h6zPMn9gsariqMJBwUtWamITALuScqOW2kW20DDUgrhiD0ddwjynLCX
         ooEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716907441; x=1717512241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMfUDTirHx9AqY5s/gqdnHQ3Y6Rgml00jUPMDkQzF2g=;
        b=PzKs40agU+pI+3fVRE3Un0DtrHhXq0nr9ncryfcgqbNmhzmQDLgTCiDVyhPahEm9E2
         h7EOwpc5xgU28W/CZMXtK5o8Scsc7PEAPxeaKvByKAwoa7JBP/oUQLhmxglZ8yvmfrhs
         Dqqn9pE1W8JCx1UlZFjSZh83cjjy1a7cBnQpQP8h5Wx+Fn7CTcz7Ji/asYav2Bbp6OdT
         7Ek8t8Kea9PmP0q/1ZgqwR2Nr5pjaLhPV/2uHd2CwlWp11wMCigdYbyYvNmD/rue6WBS
         fP6XBbMrno37Ui1/UuqC6PoXiSxkkTv0fmWf4/Ctnt2IgnTIejimLWMczk1+x5rxTLva
         35yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzCJhjuEi9brfVAHyLZDbSheiIBqNG1p+svsb/bj7zSS4vgEXlXfhSLJeufL8uanSY8P+UmnqoEhGggotlN9D3++qfMQD1+jKmAiQd
X-Gm-Message-State: AOJu0YztmwfxnoYGoeq2YCcRW3CJg6WrYmHx/DDupV2lAak7hNk2lgyD
	hrLUoUNYYHRJWcktqyRqPFeWQz7R82BhVsD7Q3rf2YTg5Ej4fBht5bzZcArU9TE=
X-Google-Smtp-Source: AGHT+IEC9mDolb6Ese2exbI+TapVH9JPhCAovHWo2SBEk5sP16XS6XK7sfyYXR7sN9HWPUDGhi5n5A==
X-Received: by 2002:a05:6512:3136:b0:522:3356:3b8 with SMTP id 2adb3069b0e04-52965a4241emr8553100e87.27.1716907441050;
        Tue, 28 May 2024 07:44:01 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817ad3sm629797966b.16.2024.05.28.07.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:44:00 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>
Subject: [PATCH v2 1/2] percpu: Add __this_cpu_try_cmpxchg()
Date: Tue, 28 May 2024 16:43:13 +0200
Message-ID: <20240528144345.5980-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __this_cpu_try_cmpxchg() version of the percpu op.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
---
 include/linux/percpu-defs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index ec3573119923..8efce7414fad 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -475,6 +475,12 @@ do {									\
 	raw_cpu_cmpxchg(pcp, oval, nval);				\
 })
 
+#define __this_cpu_try_cmpxchg(pcp, ovalp, nval)			\
+({									\
+	__this_cpu_preempt_check("try_cmpxchg");			\
+	raw_cpu_try_cmpxchg(pcp, ovalp, nval);				\
+})
+
 #define __this_cpu_sub(pcp, val)	__this_cpu_add(pcp, -(typeof(pcp))(val))
 #define __this_cpu_inc(pcp)		__this_cpu_add(pcp, 1)
 #define __this_cpu_dec(pcp)		__this_cpu_sub(pcp, 1)
-- 
2.42.0


