Return-Path: <linux-kernel+bounces-289511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE489546EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903711C2336D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C10197554;
	Fri, 16 Aug 2024 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXFYsv2l"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788116C6AB;
	Fri, 16 Aug 2024 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805367; cv=none; b=RwpEeL2oL6u51t17A4c9/7R2NZZw1V778HSCNO7QcFCcNOvHDviJpOW9NpR3UqVoTo93TWzV+RCztHH18+Bys1OJ6D3V127cGY8nKYlP42t6Rl7Gy+dQwGI0+J1FkBAHaxjjKWG+Oag9ryFsErMXar8RKDmm8ZRty0sHjoOz9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805367; c=relaxed/simple;
	bh=DFvGYpJUpf2dRhKTwTPdfU2fkvatBWHRd3oGvJ3oGt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O62ShqtLgE5tLWmODnrVCPLyd+A+AvXcerl0KBlfayRXvDdKGmfAm0cYYH0N7XYmE9WtbXGMx9ZEngcWpbX+/sEYPEMgjIS17976pqD7cMZ/i5rSHUXqqAEpLW8UepNktQwllbYHqX6WXv2ME39v7Akp5IWv3kZ7d2+vcCVX6nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXFYsv2l; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so1666804b3a.2;
        Fri, 16 Aug 2024 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723805365; x=1724410165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yf52WOlMISsygR/xVKq/752fUm4isQj4qzd84KHzZmU=;
        b=ZXFYsv2lm0NLAYjOZ7qIe24kI5bSmNca1hkNX64tf2mZD9icJHmG4pu3lcXer87z/b
         yDShK9wxocurdbYXZ1fTXg/nKrgHOJXQnot2q0m5UXwqp4q3oKCD82P4wBZUdvkrzWiu
         OudV5hAJYPiczto9CN7vYXpQKTmA/5n7qwKO5mhLcSxFYUkITwtbJ8dq83xMF2PfFZlB
         vBLtq5pp31uRqb4nMDMQ54KEDxcWqfJ/jsWiGa4OhogYO8HIpWhC7RwbVwnttCtKu32p
         ZYphcw9eSkDMM/7JPNhLXbR/PmcueupgZ8wXFUt+gB1CdQgCDc1dkE9I7Z+lhLJWSc6d
         Zzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805365; x=1724410165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yf52WOlMISsygR/xVKq/752fUm4isQj4qzd84KHzZmU=;
        b=lidCPnWX1gyPdsT6ki+YcQz71L31skgJ+hD/hiODjiBXtxGB6Opkj3D30dluIHz8i4
         v+m+AezzjhbS3F6YcoaimW8fr49QhyoLqT9VWqu6eZZGxfTbGLHvVGkcp7L6EVHfdmKh
         Wq1IIMomvMExgZZKvef2m5Bjg/zwKIoxV3UyLsIL74cCO/gjG1oAkA9t8jU5jZ+mQAvS
         yAL24PkaoB0OllvQnDLbFnkSL7GtVoh67LpopM3BLCYjfb6fsXrmU5Os5sDkqHj8GaEw
         rbCYpZjcyqwbuUWca0LGPnPP6cCdcOLV4ktFYhsuasRhm54lM6XpvcvWme0/+AUt2tK2
         Gupg==
X-Forwarded-Encrypted: i=1; AJvYcCUEi6EEaMzmxSbFhLEJuA7DHB9rUeeLCXUnslYq9P+9Cry+gPM+/ZeiwCz21o1x/CxzUJNkFQu5uEjDJJVb1ANGHLwEEVMmHJ6RA9KHo9Fjv2+eK5TVV0OFZjLVSwCF7Maj6s1DHQoJ
X-Gm-Message-State: AOJu0YxPBED/W7WFNCUwKCtdr5dzJlvwcmWzdSxjH/tV56znVHvVBnNq
	eRVY1Fi0R8zwtc/nSEBKxyyneAWgKaXcNm8q5RdZFYwBjF2EFzpd
X-Google-Smtp-Source: AGHT+IE4bWEG+S+HVHQ/YpTXfJLq5WBnpz8TnB1Iu4EL3ZSe/I67vULXbZQapdZtyLuYRHMNa3tM8A==
X-Received: by 2002:a05:6300:668b:b0:1c0:f1cb:c4b2 with SMTP id adf61e73a8af0-1c904f6d703mr2701309637.4.1723805364863;
        Fri, 16 Aug 2024 03:49:24 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. (126-84.iitb.ac.in. [103.21.126.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0e8a2sm2392269b3a.73.2024.08.16.03.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:49:24 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: linux@leemhuis.info
Cc: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SurajSonawane2415 <surajsonawane0215@gmail.com>
Subject: [PATCH v4] docs: Fix grammar and phrasing errors in reporting-issues.rst
Date: Fri, 16 Aug 2024 16:19:02 +0530
Message-Id: <20240816104902.123452-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix grammatical errors and improve phrasing in the `reporting-issues.rst`
documentation file. These changes enhance readability and ensure the
accuracy of the instructions provided.

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
V3 -> V4: Adjust line wrapping to split the long line properly.
V2 -> V3: Re-added the fix for the line: "That's why you might be need to uninstall the".
V1 -> V2: Removed the unwanted change to the line: "try search terms like".

 Documentation/admin-guide/reporting-issues.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 2fd5a030235a..d0e645fc845a 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -56,7 +56,7 @@ developers. It might be all that's needed for people already familiar with
 reporting issues to Free/Libre & Open Source Software (FLOSS) projects. For
 everyone else there is this section. It is more detailed and uses a
 step-by-step approach. It still tries to be brief for readability and leaves
-out a lot of details; those are described below the step-by-step guide in a
+out a lot of details; those are described below in the step-by-step guide in a
 reference section, which explains each of the steps in more detail. 

 Note: this section covers a few more aspects than the TL;DR and does things in
@@ -299,7 +299,7 @@ face, even if they look small or totally unrelated. That's why you should report
 issues with these kernels to the vendor. Its developers should look into the
 report and, in case it turns out to be an upstream issue, fix it directly
 upstream or forward the report there. In practice that often does not work out
-or might not what you want. You thus might want to consider circumventing the
+or might not be what you want. You thus might want to consider circumventing the
 vendor by installing the very latest Linux kernel core yourself. If that's an
 option for you move ahead in this process, as a later step in this guide will
 explain how to do that once it rules out other potential causes for your issue.
@@ -472,8 +472,8 @@ before proceeding.
 Note, you might not be aware that your system is using one of these solutions:
 they often get set up silently when you install Nvidia's proprietary graphics
 driver, VirtualBox, or other software that requires a some support from a
-module not part of the Linux kernel. That why your might need to uninstall the
-packages with such software to get rid of any 3rd party kernel module.
+module not part of the Linux kernel. That's why you might need to uninstall
+the packages with such software to get rid of any 3rd party kernel module.
 
 
 Check 'taint' flag
-- 
2.34.1

