Return-Path: <linux-kernel+bounces-575688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5025A705E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379911894C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942F6209F40;
	Tue, 25 Mar 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BVn6XOb5"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ACD255E32
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918391; cv=none; b=LipWXOE8A/jIKdoNGvCfBbFMdIh8dkFVblMcLGfDl5WqdQtui9drbQt9eDU4GjX3DE8eWnuWoqGjMVOGkXAHr0jwCpWI1EAekvj+iZy8Fy3Rd4iPbyLnExU0pL2AAN9MAlqx5+YEzTZBzSyf3jeavhfX3o7kcpYm1YXqDukFRIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918391; c=relaxed/simple;
	bh=P9EZvz4B3JvjSrOKiGhWM8/zqDEdiPCtLo7O1sswpoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QB+fL2LY+Nehf778orsWrzNutmS0c5uFW9aWBIYU/90triVG2uukUD9dYnFmOAbnTXiJoVC1Xwjwnuu2ohBaWqevZB0LwZwca7mhpXCcYLuDsba5vgTe7wmSlB1ZG+VifsIeBclP7k8cYoburRtUwwHMTM4z1gYXwfESGwrl91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BVn6XOb5; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85b3f92c866so64584139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1742918388; x=1743523188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToYD10NOrDEQyo76Lqg0Zr9yLQm8kUn7JcZ1hRviNk4=;
        b=BVn6XOb5sKx0mD1rcQ8BW8NwiwPKWKQbkmRq/H3H9puIXuH1y52rb3P0neRwphDyui
         FimyQGLI9nqWnHFtszqk60ypb2+FCmw6C3lNvk0QdG5t4XZXgL2KhFaBlW9p1dpHuzGq
         qLPnzV+vyCsByBkMK2M4h+dIfw8ChzmvSuc4/XznIAtjHqQ/iBONF8S+kd/DH7K2P8a5
         foSjhX2XeQdkiamLNdHbhd0tAEcNSSTZZ/0tFa446hmKDSLvdWwQF8o5OMIXHJTwxxY5
         SS8O64Rt5WJwpNHW3VLR/7a6BmwfUu1kKMSKU9U3spHuyuQYMQLj+S64bAbe5zXD5jfo
         q5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742918388; x=1743523188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToYD10NOrDEQyo76Lqg0Zr9yLQm8kUn7JcZ1hRviNk4=;
        b=pSLgeH8TnIj/1rJziSHqoX12u4820ZGlH1eJsyU69Azn6CK1e9WVcyDieJpy69fb8r
         /Fu3car0VNbWI9v3gMscQV19uMQmZfDrp/boedoTZ74OARw7Jft7FVrd7GhxsdraArmm
         JH5SrsmeUKR91v3kzjEzdStSx0u4z4+10hTmQPU1WGnvQvSMLgG1ffYVIErbUaLxNEd/
         /GH1XGlpcmeGDJDCOY5EQahd/lzuhRfF27qBgYt0WsfrMhmF02qw8UTO5V4BO4qF92fF
         2dK74glQLgV42N5VrNQ3ayJU4BubuQAFAdRhngcEPU1Ja4B2Ws9+BCqwOhZIhIxa29jD
         mY+g==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1/gEfTy07BraZZi7ZcupT3lnzVEEX2QxmTTawjlzp/3hA6zYXdn66Gc81XFgp64gq8KmteDQbXwQ5kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuy+w8WgC+pjtnYe4wsidqHC13rGnOfs7PCM5MWpOd5JYqTCgT
	hxxwZMI6lLJozpuaWfZsrZoAgVYPL5jwzIlA4uUAgu19+VlNn4hFd/xLvRts2vY=
X-Gm-Gg: ASbGnctndiSA9tLGR46UttjOqajyuRvOwd51jMbQMX84J4HQQ5l1GexbBmXHvGS9zKr
	Nh97hup3WFe3CJq+YMruHJNOOZMp3R8ByLqBsxz/Wu8v68w+sCQT62AFFm1xOJfRFjQmUxlyf8a
	a5jevQjX1HoxxJ6H0OptSwbcCtRB+3H7fn4glrZNHVN8bi0uLcaCegJPRliRFeLjyjonu6XYSmO
	qfqbxIardluR3mWHJb7HVm2iJbZXSVVOnaeyeu4Rktbmxj0pK09WUN/Lhm3y9oGb8mr2AsqkvFw
	3D5DGegK0a4VIRwiEtCYetUvUacY
X-Google-Smtp-Source: AGHT+IERsLCKQu0CXD36QCbALj7leHW0DXhR5mfzF4W90S9fbas/OUhKJkADjxti4v/7OWSezllccQ==
X-Received: by 2002:a05:6602:4013:b0:85b:3827:ed06 with SMTP id ca18e2360f4ac-85e2ca33995mr1894741539f.4.1742918388082;
        Tue, 25 Mar 2025 08:59:48 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bc273a1sm219975639f.18.2025.03.25.08.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:59:47 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	James Morris <james.l.morris@oracle.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-ima-devel@lists.sourceforge.net,
	linux-ima-user@lists.sourceforge.net,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-team@cloudflare.com,
	Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH] ima: process_measurement() needlessly takes inode_lock() on MAY_READ
Date: Tue, 25 Mar 2025 10:58:59 -0500
Message-ID: <20250325155934.4120184-1-fred@cloudflare.com>
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
 security/integrity/ima/ima_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb7984437..78921e69ee14 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -181,7 +181,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	action = ima_get_action(inode, mask, func, &pcr);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
-	if (!action && !violation_check)
+	if (!action && (mask == MAY_READ || !violation_check))
 		return 0;
 
 	must_appraise = action & IMA_APPRAISE;
-- 
2.43.0


