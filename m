Return-Path: <linux-kernel+bounces-261641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F92693BA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8879A283206
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEA96AB9;
	Thu, 25 Jul 2024 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnUt9yEV"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A14428
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871725; cv=none; b=KTZMIciTRknhuts2sP6YoqashCMJOuSiB3YjspogqgdNA+HmIavnNXoL9SVyCgQOJWy+f6rYdOup1Rn2ap3mS7zifEINWiiJk7R7HPl8I/i2PA/OGv0Q8olelBfkDiQYBPCGEPDMH85/AN4JqXU1WF0YciZXsPEz5ggG9jlo+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871725; c=relaxed/simple;
	bh=/F8SqBtjqh1bFRoCVnVK3wrRf/QS65Bw6/zDPMXMJMU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OLSyuS3N518jrlaG2mQDhq9XXKkFDANMHMPQ2QDDuupC5ika5JhP7WzynWWGdLM+u9ZrjXiy3N7CsTLhJkabyg4HLbZA+JqfDIDGinVMg+Gxtvs7gRkX3jHAGt+k/29n9aYMUWqGjJD4UDjq4uzPmCnDw8h4oHwmCPIfemGB7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnUt9yEV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so2754668a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721871722; x=1722476522; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFpkKmmT3youOgcmlSfL4KcOPVXS0ZnF2VstHXtU494=;
        b=AnUt9yEVaP+rZgbZE+yXdI/2nmlL55C1DNOMfKaON7StSCgtNSht99UZuu/SPgwsEl
         6u6aTcUGJZ93ZK3jJjjUnTKYEtr13GPQGZayjCbKMm6pUprIQByqJR4AASsKiY3eazjJ
         ZBUdfy557LGFBYjz5CQNffRXit8cWGYk3wYFsaFcvZ2SMeOP4DpzqCN0hBmn42jWAB/2
         R8AGVUSbz+3H7c1xcE/ZJHivxMmtZNceKJv9fZjp3aE535eEMu+FUMQkRluVyDNSLlG0
         tbEykyaW08azULPUFnkpf4SB1sDjE2N5djRR7L6OkhMsWZanx390Ul0/o7AttglHj02/
         TMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721871722; x=1722476522;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFpkKmmT3youOgcmlSfL4KcOPVXS0ZnF2VstHXtU494=;
        b=okfDPDt+Q20YGrLWGyM8UiA2KOex6LiQm5pbQsD3ViPg+6CLmhEu7AjN0UQE5Gk39N
         5vpTVnCzrAiTA9DC8xcNxtX0HYBNQTOK4QcKytcM99v4+OKoXLN2VLDDNV+H3RwApwvG
         xbOhJOweDliMeR+JHJuRt4b/uOj+DnvcVcKcK3JjSXQa65VtaU0NHRz7dVjl5VeIXjSz
         3pxih4lr4vEGWYwwGFhZLIipvEIIMxgi2FPK89rnY4n2extNaOiruYaV70sIzIJcsyK2
         b8e3rY3jXWW/ZNvbF0ojUjidU1Q2ceaIJm3qQTi3ijoSkxKaPWGpHMeldCiqYgWXXVko
         Pd6g==
X-Gm-Message-State: AOJu0YyA3ut6xp1szcIaa3uVx361kqNw3NJncZ9L5RO1xAAgv/2EPFUH
	u0xhPjDhcQAjyF5xjdH/DQ1QLAsweZEAhTdWq/+AZhW4Hv1jfV1m
X-Google-Smtp-Source: AGHT+IGoI+YQCe7Aw7rC7D+UViXAni2IQOz76J6pHhJWn2CLyBJkJKv38LUss6T7pyAx/2pjSOHYUQ==
X-Received: by 2002:a05:6402:2546:b0:57c:614c:56e7 with SMTP id 4fb4d7f45d1cf-5ac148aa3b2mr1227907a12.18.1721871722021;
        Wed, 24 Jul 2024 18:42:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b59c86sm246231a12.42.2024.07.24.18.42.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2024 18:42:01 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/5] memblock test: fix implicit declaration of function 'virt_to_phys'
Date: Thu, 25 Jul 2024 01:41:53 +0000
Message-Id: <20240725014157.17707-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
alloc") introduce the usage of virt_to_phys(), which is not defined in
memblock tests.

Define it in kernel.h to fix the build error.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 tools/testing/memblock/linux/kernel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/memblock/linux/kernel.h b/tools/testing/memblock/linux/kernel.h
index d2f148bd8902..ca56f36ef296 100644
--- a/tools/testing/memblock/linux/kernel.h
+++ b/tools/testing/memblock/linux/kernel.h
@@ -9,4 +9,6 @@
 #include <linux/linkage.h>
 #include <linux/kconfig.h>
 
+#define virt_to_phys(p) ((unsigned long)p)
+
 #endif
-- 
2.34.1


