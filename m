Return-Path: <linux-kernel+bounces-575920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83648A708E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1469E1722F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D8818DF81;
	Tue, 25 Mar 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Wt/ssl4h"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BFF2AF07
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926601; cv=none; b=n9YZwZG6zNqqFbxQqR2D4NPww501RQNl+7/XC9A8N6O1YhFwlnQJAvOWEiUiq6Lh8s1ORtEu+ZU2DYDEjikGsKD4d6KaSIE2VqIw2iriRsG0VCu/sEHVvpy3ZfuGtzEfL8y2/ocqhKc7rISkJJjre6tp9IbYl5fOe7ihBG+IMVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926601; c=relaxed/simple;
	bh=esYfgx0cdDMN5ZaBBHor/lPAhpyh+4gBj/W9cpIjRxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfrhA7w4V6yPCy6xD1FVZlenwyvFjPpR5DIy0706OQt05/p5bvUZB70r84HN7z97cwiXg+RNG/W4vfVNOSRzL+dEmlBQ63RTT77y88zha5Y7O4vcRdrx0sRh6NhgXYqncvICGNJ+RCZQuFZS0QJGpiwLAMWUs++lA+kq5Peys7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Wt/ssl4h; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8efefec89so51793226d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1742926598; x=1743531398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4H7GcC3ni0ITvlHddoWo0ZRS35tRQvYIbusVzXzsR1U=;
        b=Wt/ssl4hTb+V8ObCcMJIuOfK3rTcdeW1j/Qd1vXWy4+8IntCmvJDM1QHpGigZbt6XJ
         a5rh0DnwGLttZkWfNstRG5Llcrgj/ltoAe0a6bKz05YcD/Pnc0dM96JRTGz0+jPmEN6z
         3GIzqhWOUZxz3SqCA0znDn1ttVgxdqcV59A2W6tF25r3e8GUOuaTvYQojJ0qUqfy6fXS
         dott1LdQtilrXsdahnnRzNKSNPPJrKsEa3W1AU8Ia+TcLMXCvYxvNQxXP5ZSbEWBxOwb
         kH1Ab6qgHUqIt2+iDSe7ogBaKQ6Sr0Hu8hKvYp5Wg6MzoY03STJj9TMO8vXs5GLQUA08
         b3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742926598; x=1743531398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4H7GcC3ni0ITvlHddoWo0ZRS35tRQvYIbusVzXzsR1U=;
        b=lqAvtVOd3dDGVPkjWWwQv2/VgK7y6qMU27aV4Nb4wfPy8A27PVcKu4hqfgzeOAmQrn
         l3mL9WmwQkj6noyWobq7+Vri8gTQJ8DEGhNonVmrmHZGtyVv0vITnA0SRp1uW5ZwlRKC
         CSuD7Btl6VIH8KVgCPEPpU84luSpSKQMmL+vbdggAnb+29wKCfm6uBoQHFgpm7oAVZxV
         xFxXlL0xxgzfyIX4/u6EiEIAxX7KkMbkz3LQuMiT61Aom9uB/cWZ2cZSmWwY0cMdbsaW
         tv4oVDTf1Dc/Jevy0IbxcESWa3jHsWyVmLG1iUfiHf3VZ5KGTLkkKWGwL6HB2o+JOPdr
         lN9w==
X-Forwarded-Encrypted: i=1; AJvYcCXjYBIaQl1UcQmf/uC3//wnGNVKCoBTjSvpklXD2FE+2Loo7yVboLgfrnneoungTUcyz1QUPzoEZw1liz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdmmK8LvWYEWehHmc8BGd7PQAq1Tj114gQFQtgJECWd3hStavp
	YDMx6UwFHqXwAJAJ+ip8/6wR8T9/sdZYOSHahTDAmO5YqDEl/JaoOuMXw+dKVXRS7mdWT7z0LSo
	Hrcs=
X-Gm-Gg: ASbGncvkaZU352KxQ0YI/sxwrqQWTorvR6wEt0COmtd/rwDBC+dLhfERoeOHGIThBaE
	UIZwoMPXH5IBe4hAtN2W//m2sNLf4AQSGBDBOCC6MYFXTqRQDglBqROYVZO7x6EbDson4VKxomg
	L3hJn5CpSlh8rpEwMiOSXd9I20Zuy/IawXgdy+iV45yt/pntthjQd+I2hF933os4qXGke95tQ3I
	fW4BC1A+3PMx+1D9Qgn99zAKSf/5K8ZwfZLASdQ8gGdHfxFgHGbGZz/j6SeFkZoLQJtopRyq3Wb
	9amBeKXYBegeBDOcTa1ljr0Vhd19nBgX4sQmP0I=
X-Google-Smtp-Source: AGHT+IHKUmFTlJlS488fjeGCyxmy728lgg3HbhLTJYyWpR7aP0o43Y/7GdzMIdEqqfoalzFAPGEA/w==
X-Received: by 2002:a05:6602:7218:b0:85b:5564:2d51 with SMTP id ca18e2360f4ac-85e2cc52346mr1871960339f.11.1742926587923;
        Tue, 25 Mar 2025 11:16:27 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bc273a1sm224670139f.18.2025.03.25.11.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:16:26 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-ima-devel@lists.sourceforge.net,
	linux-integrity@vger.kernel.org,
	linux-ima-user@lists.sourceforge.net,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudfalre.com,
	Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH] ima: process_measurement() needlessly takes inode_lock() on MAY_READ
Date: Tue, 25 Mar 2025 13:15:03 -0500
Message-ID: <20250325181616.79540-2-fred@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On IMA policy update, if a measure rule exists in the policy,
IMA_MEASURE is set for ima_policy_flags which makes the violation_check
variable always true. Coupled with a no-action on MAY_READ for a
FILE_CHECK call, we're always taking the inode_lock().

This becomes a performance problem for extremely heavy read-only workloads.
Therefore, prevent this only in the case there's no action to be taken.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
Changes since v1:
- Add MAY_WRITE && action check to violation_check to avoid MAY_READ
  only situations
---
 security/integrity/ima/ima_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9b87556b03a7..11a91d9dae48 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -237,7 +237,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
-			   (ima_policy_flag & IMA_MEASURE));
+			   (ima_policy_flag & IMA_MEASURE) &&
+			   ((action & IMA_MEASURE) || (mask & MAY_WRITE)));
 	if (!action && !violation_check)
 		return 0;
 
-- 
2.43.0


