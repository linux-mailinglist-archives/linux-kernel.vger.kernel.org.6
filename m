Return-Path: <linux-kernel+bounces-261036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C3193B1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7ED2833C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4276158DC8;
	Wed, 24 Jul 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AW5wLz9R"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA2158D83
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829095; cv=none; b=SqUqMQeC7dtsSa23cQgzZ9UxGhb16BXFWbzkBjRwfqPpeyPLctPBHyr30mnAzSb/FipOFn7VpE6GYVodFO87NGg9XUUvtJX+XpGFnMoT/Tfgrahe07HbQmvJscBSksNhl/sYaLo3PjzygxhuOk0v6i9ZHgwhlGlr17ATO0/u25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829095; c=relaxed/simple;
	bh=SsSkhNGn7QJejrmFIGvtXvlDi/a721Ld8Pj4EOwWE9Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oNWFL27U6U6aXcm7kkk//LRpbIAyrzyqYzma2vJXa1EmfQFAzTQnul20+fpJecctb/zNMNblf6Dz75WkOUSzCzZOyc3ErIVlIe8Ntrjs0F1EMu6VKaMTcz3jS7jcYeLdD25PYObneZfGiX5AnEfdNpRIo+LWDnGwds4lnEY3Wsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AW5wLz9R; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vamshigajjela.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66c0f57549fso125523577b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721829093; x=1722433893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RrSVcz2VewJByKdMTTCyLdkt0Sk8iz5c/M167BcRneY=;
        b=AW5wLz9RIirxjwNsnGeKKn57OpR1l5gRSpRbrzXsw11ssdXqmVzLSxxTFPNV+TFfxA
         0IJjzjiowdKl5dOclPWRCVjarJP6E2fqs9O5N0IJ/j+np4F4g3zqd1sFRQTTnuDfxK32
         tqOKp8nEOKDdxcdfb9MYUMXmskYdB1rOFX0jXPnugZ+CbdvSqcNNIpR774xRD9zHnlTR
         4ihIqT2dTkZrtwOQQUAnTYRmviUOHxGSAsm1RAukB1OT8uYe+nOkw2oBsug4t71dxtSz
         UFWE9JXv5VV1ZOIH++wj+x0/+oIQrdU9Te35ifqnoirh0X284eCL03JjqXLNnoD+xdF1
         w1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721829093; x=1722433893;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrSVcz2VewJByKdMTTCyLdkt0Sk8iz5c/M167BcRneY=;
        b=wXRzpAE/m4r8BCaUPMI/Xn2Dzsh+8GaVUtP54jCCq9hX0HbO8xsMexugebU2ckiQ2M
         +XjHcawWsiDcNNBa/3+n+CxCelm1oA4Kmaum9XpkLtTXKdbX3EUGwfbqXTmohQnYKkR5
         3p/pIGO52plzsryyyPLTjlwH+eXV+YJ8nQGP6TfVTf2t7osp2QY8H7ixQPl4ajIdV49I
         q8VPYvnoE1wrZSHkV+K1z/v5Ruz3EourKLdN9boQULYfAaxyw7XgP5w2fgLVS7+uX68y
         GBX/pBlVR8owsaItu8fkjUfvTO44WCkts2hhG5nSSdhcaZusbQOv0kGearfjwl6+919w
         rRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+t5+m0+qnM0PRVc2glxLCY7s4QeyXAsAhZde4Ac49uxReea2zJSlxlPYG/AHYWICTysCC5uepRpSgzeEg2AHjJiZ54ykgrdE/gOpH
X-Gm-Message-State: AOJu0YzjbxfOdNmro+RHi9OJYw9fKEAH0zyYoDu+y5AZ8Nr+Dx2Ab2jJ
	4gnWMQhqF0C7vfv8v9fo0m3FN6GvpI7Bmjswg+TMpQUpUR+8pTZs6UwRpc9BofcfHc2lGYBVVOj
	+wdmLjXoAC8qU/br5um5Pj1cZstEpHw==
X-Google-Smtp-Source: AGHT+IHbNtAEuIYXFpzA3YyBaOuWG4DbFIf/VUQVlqhnq9b7xo1ygHVyCorff/HREiUTR/35hKqZj6/k+Rc0jmFFM1pJ
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:690c:810:b0:673:b39a:92ce with
 SMTP id 00721157ae682-673b39aa039mr103587b3.3.1721829092669; Wed, 24 Jul 2024
 06:51:32 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:21:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724135126.1786126-1-vamshigajjela@google.com>
Subject: [PATCH] scsi: ufs: core: Fix hba->last_dme_cmd_tstamp timestamp
 updating logic
From: Vamshi Gajjela <vamshigajjela@google.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: Yaniv Gardi <ygardi@codeaurora.org>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"

The ufshcd_add_delay_before_dme_cmd() always introduces a delay of
MIN_DELAY_BEFORE_DME_CMDS_US between DME commands even when it's not
required. The delay is added when the UFS host controller supplies the
quirk UFSHCD_QUIRK_DELAY_BEFORE_DME_CMDS.

Fix the logic to update hba->last_dme_cmd_tstamp to ensure subsequent
DME commands have the correct delay in the range of 0 to
MIN_DELAY_BEFORE_DME_CMDS_US.

Update the timestamp at the end of the function to ensure it captures
the latest time after any necessary delay has been applied.

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
Fixes: cad2e03d8607 ("ufs: add support to allow non standard behaviours (quirks)")
Cc: stable@vger.kernel.org
---
 drivers/ufs/core/ufshcd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index dc757ba47522..406bda1585f6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4090,11 +4090,16 @@ static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba)
 			min_sleep_time_us =
 				MIN_DELAY_BEFORE_DME_CMDS_US - delta;
 		else
-			return; /* no more delay required */
+			min_sleep_time_us = 0; /* no more delay required */
 	}
 
-	/* allow sleep for extra 50us if needed */
-	usleep_range(min_sleep_time_us, min_sleep_time_us + 50);
+	if (min_sleep_time_us > 0) {
+		/* allow sleep for extra 50us if needed */
+		usleep_range(min_sleep_time_us, min_sleep_time_us + 50);
+	}
+
+	/* update the last_dme_cmd_tstamp */
+	hba->last_dme_cmd_tstamp = ktime_get();
 }
 
 /**
-- 
2.45.2.1089.g2a221341d9-goog


