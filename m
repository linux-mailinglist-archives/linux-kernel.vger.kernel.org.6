Return-Path: <linux-kernel+bounces-303682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B9896139E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F703B248EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444CC1C871E;
	Tue, 27 Aug 2024 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEIu7J2Y"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A51C6F48;
	Tue, 27 Aug 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774737; cv=none; b=oFrZZleMNEymz6hGme1cj6c2eNWIxrbeyTRd8BWM0ujZoSqNfGIgn/nfIbQ527ApdrAUkHm3jnu+NnwpJDjNWutVSiyD2TrB6Bak0L5t9alboVwdsGxrxpSIMtEb1aEWyY0AdeEx1BtkW8sbUsKkzIC1YS9m5Y+hFHQ+eu3hC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774737; c=relaxed/simple;
	bh=f9f8lgXpvqTcodB9v5gsQ7zHGT6GCWyTgjoaP9uOozY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=omXGTkJfC8Og4wK1G1Bn+j59JgVzZd1eFjN77VvJyjMcfDpG4h8jE2/S8aDbeUkBOyqoBJPQteoh65Kat2CB4IsLqGHCj9BYUU4tHkt8bjY5S9h8OPBvlk8l7ek6uap7bMTfUUkOFukUL6FJBopihkBGuWfO8UccRY+tuoJ8TEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEIu7J2Y; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7141e20e31cso4762590b3a.3;
        Tue, 27 Aug 2024 09:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724774735; x=1725379535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jhp+ekc12c6Q6VDRk1GVsy4ZTxEJksFkC4dGRiI9m6w=;
        b=GEIu7J2YVJVOqk4gu85bFpbgg0+y/BSd5O4RRpJZXVWmiXKiHqe7+Xun3x/wwYD3xi
         VoVd9BpWownfQxztfLcYkTPh3qtIQXsP7XhM2ViTNXVbmjWDv9qqpmnWp/tNMdNe2Bhb
         vNNMRR9VgODkGDLnIU9K97IxUsNhWqLQdFkHHMmmIzn7o3vnU5/m04vRXs/unyYX8819
         yPEY3WjGPUvj3Izx9oCfUIZUmv9OSwg4gB1d03RiWnQWJSiUCpAhWa+Si+LT2wklu+Ns
         LNATmFfVAdiS0fNXw+U6Y3goadll2dHzftlSDA7eyCk/PKVcJ3rcN9YYw1O3vtVMBp6v
         NsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724774735; x=1725379535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhp+ekc12c6Q6VDRk1GVsy4ZTxEJksFkC4dGRiI9m6w=;
        b=NUTWh4UuyTO0m1mVeTwow8bYBoIIHjyuWcqLYsTdfbsX1KRbzbrYBy7S4IKdbUUR/E
         gWvZ39kWio6wM3LkGTOQgZpduMK88mSnwi80WocTdU9yJyEY4QFQ/sbxSoletUi0RMgR
         5HfhkPZGtuUv3UoXBqCERAoehm1m7OsvvFkCn+tilIDkKASMthusm+uciTzN16FH/XdR
         /9FyojtjARNz2tmHMsiyEK3GQ3byqIlifWGOfXsMMNqNzSiaYdDydIeAsqJUZ7IoQPw6
         AsCVWNTBbKmxZ4bc4C/AuhGyihPSNMGGjwCw/kOafft3iRG/r8uomID+8OABPERcVwu5
         LvIQ==
X-Gm-Message-State: AOJu0YzdkhoK/KwM+50zq/dAoKgYQWoCXxNPwd3z7/KQAPygDGHxCGa6
	mFOV24lbYt290EkefmAKezQubc7Q2i0f4fzUtYb9I6HHy+prtdHjXofWak74vqo=
X-Google-Smtp-Source: AGHT+IFYso0YJODSpMmoNfQ61B5mFIzydw/OAaUH0JtXvNjAuxIxW7MSo9Thua+A8C/+PvxbQWJT5w==
X-Received: by 2002:a17:90b:4d90:b0:2c9:5a8b:ff7e with SMTP id 98e67ed59e1d1-2d82591fbb1mr3842085a91.25.1724774734868;
        Tue, 27 Aug 2024 09:05:34 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. (126-84.iitb.ac.in. [103.21.126.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d6139201ecsm12487557a91.18.2024.08.27.09.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:05:34 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux@leemhuis.info,
	corbet@lwn.net,
	SurajSonawane2415 <surajsonawane0215@gmail.com>
Subject: [PATCH v5] docs: Fix grammar and phrasing errors in reporting-issues.rst
Date: Tue, 27 Aug 2024 21:34:10 +0530
Message-Id: <20240827160410.124448-1-surajsonawane0215@gmail.com>
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
V4 -> V5: Fixed additional whitespace.
V3 -> V4: Adjust line wrapping to split the long line properly.
V2 -> V3: Re-added the fix for the line: "That's why you might be need to uninstall the".
V1 -> V2: Removed the unwanted change to the line: "try search terms like".

 Documentation/admin-guide/reporting-issues.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 2fd5a0302..05f2c4f0b 100644
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


