Return-Path: <linux-kernel+bounces-363259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92BB99BFB9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12E61C221C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5AD13D53F;
	Mon, 14 Oct 2024 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAVW3pL/"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30713C9CF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885902; cv=none; b=hkohO5ch6emEI3m1e6Nf3ZLXLEffsZJGNGKgnM2vJpY8i9eVvohubQr8XyE/Uz6fkdFFLENQHPzc/z3PkvgZRDuuUd8/m1FujKJZkyH0auFJ6zaMU3RA5uGOKdPAO+YxvMqyoPn1sPjIhgOnHXlhOvBNvYFNg5oL5l+grI+4FIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885902; c=relaxed/simple;
	bh=znU59uJgP8/aTBB3ZXAKZBYoSiO4aYtb8EgLLo83IsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CwWbPFas1eVsFSHo8iSBGfNW2+vxOnMlXYDTI3f9GNosovovu1XdKMiRi/yJDxf4nluFWUqOJYU55KpOdFAl8urhi/TTi+dCwX4U+ASRBen8e8AolvqqrxOGpuRl/EFleB9fZj9OtsBNLRT/xErVcUGao9mzHb0FhpLphTZHAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAVW3pL/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so203887a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728885898; x=1729490698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hj7nzagu+uMKvRlSwKyqT4g1m+IqUs/iPZmR2zWRGQE=;
        b=SAVW3pL/GAUwSnJL2R9IopAUcOSBnb+7A31tH2waoY33zzKyWrEYlgsYs7ZynWDxI3
         kFiRGGxiaPt4HwgzTwPL7DbxuDB/qbgz11IwCpOmZ7PhctAGf7QNSa966FjRzxoPq0kM
         9bIViOYS5Z98GejvXIVIPhIVP9TuUWWLFyqAbiy4M3Ndziw3BMjxkZvhdxnFr4Q2XgA6
         0M9p5ZDevRYQy7FLI5IBJbgwXNUp1jJJcKrpqjwhFt9emLgZrDgmj0C+LPiH7MBYc0uX
         H9K0fUpFv0HaMaRW7c/CKdeShqhdNfDomKI45VVCcnaQWtYd8LzX0goHgsr1O5KPeSi0
         NH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728885898; x=1729490698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hj7nzagu+uMKvRlSwKyqT4g1m+IqUs/iPZmR2zWRGQE=;
        b=UpDeT5WcAY/cEryqt3sTBZLwrX/a7btrBzFPhUjgIV6ZmivujjBt6pAJ+t8vWXge76
         qhdrzUeA9GiKGObSsGFs0/wmZza6K00H8JwMsn7ivPKYnKUooYrHImrpaJYSVvXQWghd
         CTBiVdhkD3N9B+AlKA9ieYM5dyumm8dFvbSEIvweshy+/Wa5BYFW09tQxSvbvsQOpUIi
         s2dT6TeJjfMdComgQrlwI5B0CeGlmUTz/2ukdCnwpR7qzIJBujGKKTBGqO/0bGUvXz2V
         wcKEw6tpNbzApuv1a7V761bdtfk9v6WhLgdRvt0JRhdjgYv0L8+l7L9m0AOD7J1JH6xT
         r82w==
X-Forwarded-Encrypted: i=1; AJvYcCV7rcgnRaHLvEljwl7N35SBThuhjiME05KkesUkKNc8x4JBCvv1WiPT9fuQ3veNTW3HrDCz4K9z/1dtsdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbu/k97QU4uiSzC0m5DVE2OK+RhKVs9/vbC5xXob9xde2O7pi4
	13mEozHEVfzUFZ1rZGZhLfexApVB3zhZnzLgJR3YDLBFJGTnqpwl
X-Google-Smtp-Source: AGHT+IHImB8RQ3XxIX1T6+ZDB20H4WiJeIMtsn6kc5w65W/a9/0ivGhYYBGWkIecouWP/DPTbwITBg==
X-Received: by 2002:a17:90b:1843:b0:2e2:991c:d790 with SMTP id 98e67ed59e1d1-2e2f0a36567mr11475511a91.8.1728885898532;
        Sun, 13 Oct 2024 23:04:58 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fcc759sm7915156a91.57.2024.10.13.23.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 23:04:58 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] staging: gpib: Replace kmalloc + memset with kzalloc for zero initialization.
Date: Mon, 14 Oct 2024 11:34:30 +0530
Message-Id: <20241014060430.1533329-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change simplifies memory allocation by using `kzalloc`
for zero-initialization, improving readability and reducing
uninitialized memory errors.


Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/staging/gpib/tnt4882/mite.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/tnt4882/mite.c b/drivers/staging/gpib/tnt4882/mite.c
index adb656a5eb2c..54d80f89195f 100644
--- a/drivers/staging/gpib/tnt4882/mite.c
+++ b/drivers/staging/gpib/tnt4882/mite.c
@@ -57,12 +57,10 @@ void mite_init(void)
 	for (pcidev = pci_get_device(PCI_VENDOR_ID_NATINST, PCI_ANY_ID, NULL);
 		pcidev;
 		pcidev = pci_get_device(PCI_VENDOR_ID_NATINST, PCI_ANY_ID, pcidev)) {
-		mite = kmalloc(sizeof(*mite), GFP_KERNEL);
+		mite = kzalloc(sizeof(*mite), GFP_KERNEL);
 		if (!mite)
 			return;
 
-		memset(mite, 0, sizeof(*mite));
-
 		mite->pcidev = pcidev;
 		pci_dev_get(mite->pcidev);
 		mite->next = mite_devices;
-- 
2.34.1


