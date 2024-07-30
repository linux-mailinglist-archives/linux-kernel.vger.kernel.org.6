Return-Path: <linux-kernel+bounces-267852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD70941758
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181A91F236C8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55B18B465;
	Tue, 30 Jul 2024 16:08:22 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB481189918
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355701; cv=none; b=XWGsRG+W4lfHZy45+gl9n21/BYI+1He3GUZXQcIu6XrgcSVWW/FgdBv+NVIDSw2uTzXts3Nb7WlVRgVlSsday0T2ysQDHnqnqYWCySsdLOLASBzvTkgAMXXMkM4R4Hk3jUODufdrwms1gc3jHWDfp1msKT7SiPGuQ0nq0lbUT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355701; c=relaxed/simple;
	bh=DWDEU7qmN8QEqZNY/eNSh9DXKDMPLwWoEp53mfxFhgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2QdGssNrh0Q+dILONVmhhtahIAcAnhJGhjacnPXDQ7SoUFC2OZMjqYfEoIeJB8On11KUznWN/W2X2mAalotWZvWhPN/aAk/+k5L5iFf4g2G2WeCjgZMtDf6yuZphzCWeKERlK3tb9nR3vKtW4Qg0puzILZvjutH3L3wPzEd48E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f01b8738dso5019082e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722355698; x=1722960498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjBv1fAWCFs6OgtwYl8CJz9ikLHqeso2/TnPXZoH5oM=;
        b=PpCK/oFQxJ/8jiNj5BrZduo5dcQ8ZRPE6sg5Za4k0FnZuPDDN7Ud07SUrGMFVazkrV
         JdTLFkoKBzZoVki4i+GMDbKE8gJH3r0ODczAMht9PMOsCAkAEAKLo796DHNxyoI2s86c
         vcXBuVq+9BU6K+O9uUGu3pXlKyB4rSMEaAt0ArDWKKk+kgblFn5STN2yrcrCMp6DwrTY
         zAlKiGBDgX5S3RQ5koo0WjTjgIBoOoJdDo63eULGnAizKpPAvaV0uoPHHKjFR9XIiHU0
         OwMNnIz3Mog51UIpPpoNejm5jBtMyglzb7d9e2r3PE8w0K9Zd5rZDwFAxx1MbT1m0iTB
         zgIA==
X-Gm-Message-State: AOJu0Yzc6UxeS6WxIEAVIs9OwfsPxu1jdOz3S/VvPUE+jri0eh8d/Amg
	iQOkV5JSm1gImWBkWV/flCkil5j8uteWIbS5bw0JQHFJLYy8jP71
X-Google-Smtp-Source: AGHT+IFZQDxAprhHU8/z18XMSJePY4e45upQnRR2FsoU38NRdTf9W4VEUw0ZdKuj3VKg5/IrRvzJOA==
X-Received: by 2002:a05:6512:3257:b0:52e:be84:225c with SMTP id 2adb3069b0e04-5309b280e1amr6780566e87.33.1722355697502;
        Tue, 30 Jul 2024 09:08:17 -0700 (PDT)
Received: from localhost (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2762dsm674246366b.10.2024.07.30.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:08:16 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] failcmd: Add script file in MAINTAINERS
Date: Tue, 30 Jul 2024 09:08:13 -0700
Message-ID: <20240730160814.1979876-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

failcmd is one of the main interfaces to fault injection framework, but,
it is not listed under FAULT INJECTION SUPPORT entry in MAINTAINERS.
This is unfortunate, since git-send-email doesn't find emails to send
the patches to, forcing the user to try to guess who maintains it.

Akinobu Mita seems to be actively maintaining it, so, let's add the file
under FAULT INJECTION SUPPORT section.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..64087e9bde34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8536,6 +8536,7 @@ M:	Akinobu Mita <akinobu.mita@gmail.com>
 S:	Supported
 F:	Documentation/fault-injection/
 F:	lib/fault-inject.c
+F:	tools/testing/fault-injection/
 
 FBTFT Framebuffer drivers
 L:	dri-devel@lists.freedesktop.org
-- 
2.43.0


