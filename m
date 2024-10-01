Return-Path: <linux-kernel+bounces-346819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5D798C958
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 525E81F2362C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAAB1CF7D8;
	Tue,  1 Oct 2024 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxbyntyu"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0A1CF5C4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727824353; cv=none; b=GJm1npCGKHx0rLon3r/lznfN4rW1iOiYjK4Ji+ugnQM4kNgc9B5LK4k6Sf2b3ll5kBm2QnvNomLyqAu1eqmLQOzDtAHpi8DMucfoWf7POzuuJW+m38eRAONL2pDhlSrjcqIPbXancBljwthmRd0ov3xjZbr96auRXT8B4iXkqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727824353; c=relaxed/simple;
	bh=UJEo7ZbVngp//T9WAn3g+kIQ8hS525iGbt6hspN/biQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=t1+gxie8TrRD28wButJgodmADRNKbBxV0TGZm1V6m5AquWp1X5yl+fRLoIKmGdX7nfzhaRe1S9t5AUVsZDpmd71Tgdzbde8RfEDkelC1XKrgybhuyhn3RmQHPHvqUeUBNXyPGNCDFQN3vhumXPO9l1AeD3Fy25MCrCDCmEbmlns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fxbyntyu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20afe0063e0so59549355ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 16:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727824350; x=1728429150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yfKsYMpaU7VvuhLl70RiS1jJf8XNvJoYo4Hby8DN+CU=;
        b=fxbyntyuQ0rm7BLDzlyhZnTYzekqbZ3ujfeORgKNPJRBlKqKWMv+gwCTbJVSUf3ceQ
         t0h2ITk5INCXIqNg2w5EoYWx7jNQ46Dna1c6ZI/CKKZ92V1KNjfZaDfRmTJuKdrNUxmY
         XivHRZmEy/1fwJk3xUBoHg/j+wB5DWnwj0WSns5J6/kmzvHQJdFm5aVgqUbuNFvf2eUO
         oLwwONBaDPIwfTh0bHJJv6diJQWRZFaoLau6AjFMKJq/G+AppVGhnJ7+0NHbEH04hVOP
         Nafz5bTyyPcTK3OUdP+ZK0jteuxUyjAQD2o4OZbECRgyO+wIOghUxmFN1/3lSqtYQujw
         5mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727824350; x=1728429150;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfKsYMpaU7VvuhLl70RiS1jJf8XNvJoYo4Hby8DN+CU=;
        b=u8BH6sp7DI1I/4h8IktEjB37rr+z4iaBYGk9qmYVThtexWmqJ3JGg+24K5GXaeV74U
         tdSujsYtfEd+pBWy8yff4pvbgJ0JGqiEQgvo7ooVLPATAL/DS+zereKTXqcfTDluRvHU
         H+k7tJyOzniT1XJKVsGH+lKK8EZ0ROfOj/mKcUJF/AL0lBcVf47NjXfyCDzcxP2GmxY5
         VDa0VFW1IiYnLsfPBGSoxK+yJ6NBAXLIJfjWXShWm/ANOYw3GmZHk8l00OkuGzLzsjKP
         PYM8AtSvJdGGAWUN1LCx+UbsEmAoV+Fx/8Z86H+hxl1hr+KGD3t3vopnyhp4w41n1rth
         IVNw==
X-Forwarded-Encrypted: i=1; AJvYcCX0KtXeaLBMq17Wzk4XIHcWZuynAKWrrmwPI+jiStIKptutWYSReBLHef2CtKf0fsDYrXo7eidEQmINi38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwShzqriOF7n3+PaJ58LYaKoS9Hzwh4qcJq+hSxmhgc4I8+wAIl
	Q22kvL2Lmvx2y4ngNVRvMbNaUwn5Viv4ZWrLZ37yzlLOghDhaYQluPuAElOhdi+HRjiX3O3zug=
	=
X-Google-Smtp-Source: AGHT+IFYlrcOGsDvZLY/eGYCzs70AYjmWagZL0Cjjfxx6fUGcCl923aS8j/xVPRRR+iJEaJLcWnUjAtpBg==
X-Received: from avak.c.googlers.com ([fda3:e722:ac3:cc00:ef:85c8:ac13:4199])
 (user=tkjos job=sendgmr) by 2002:a17:903:41c9:b0:20b:bc4b:2bc4 with SMTP id
 d9443c01a7336-20bc5a599f2mr78285ad.10.1727824349757; Tue, 01 Oct 2024
 16:12:29 -0700 (PDT)
Date: Tue,  1 Oct 2024 23:11:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241001231147.3583649-1-tkjos@google.com>
Subject: [PATCH] PCI: fix memory leak in reset_method_store()
From: Todd Kjos <tkjos@google.com>
To: kernel-team@android.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

In reset_method_store(), a string is allocated via kstrndup()
and assigned to the local "options". options is then used
in with strsep() to find spaces:

  while ((name = strsep(&options, " ")) != NULL) {

If there are no remaining spaces, then options is set to NULL
by strsep(), so the subsequent kfree(options) doesn't free the
memory allocated via kstrndup().

Fix by using a separate tmp_options to iterate with
strsep() so options is preserved.

Fixes: d88f521da3ef ("PCI: Allow userspace to query and set device reset mechanism")
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/pci/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2..0e6562ff3dcf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5244,7 +5244,7 @@ static ssize_t reset_method_store(struct device *dev,
 				  const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	char *options, *name;
+	char *options, *tmp_options, *name;
 	int m, n;
 	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
 
@@ -5264,7 +5264,8 @@ static ssize_t reset_method_store(struct device *dev,
 		return -ENOMEM;
 
 	n = 0;
-	while ((name = strsep(&options, " ")) != NULL) {
+	tmp_options = options;
+	while ((name = strsep(&tmp_options, " ")) != NULL) {
 		if (sysfs_streq(name, ""))
 			continue;
 
-- 
2.46.1.824.gd892dcdcdd-goog


