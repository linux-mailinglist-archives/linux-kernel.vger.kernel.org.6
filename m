Return-Path: <linux-kernel+bounces-388467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3AF9B600C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEAA2834F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F511E32C6;
	Wed, 30 Oct 2024 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1GLVbga"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3E1E1C2B;
	Wed, 30 Oct 2024 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283989; cv=none; b=SqgnhD7+0oiQSGcfo0p7SSnrLXPAx6mLZd30iebjlmD/8xaU346UFlzKkUizMiKqd6Sq1MYeZ7RCHcbdmeJDjuSezCc+V5zgSVsfIe8/tmg6uomhZOUorFAEhsPCs0prY3sLIJS3gEaquwCf46cK0qlHNVFMbu1lwhcSGyKSvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283989; c=relaxed/simple;
	bh=KZxrHt9CYnQJFKvKowHqw9Jfy90y1ljtj4x03RBuQkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IGMjSoQcWlH3G7lG6TNIFqi0RiCEqseP2p+GURu02fNV8RiK09py3WK0UgSjZWGFK8z9k1NPoVsHPqLzEcyuL8JnHaq3Pvz8dJynQcR4N6BZ6yfbJwo7IvmKxRtg0/oGrLALR6flmz5s59TWmSCsPql0iQ6wpRHV+WisGNqk7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1GLVbga; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d51055097so4080644f8f.3;
        Wed, 30 Oct 2024 03:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730283985; x=1730888785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7IHw96pJSceCRXSurQsDRafKcFmCLrbbLG2f0iuwx0=;
        b=B1GLVbga6sbPNl2goWQ0eTSL8Isfk0lAzUXwE9tBQcAFlzYBS9MeGiKK5SV/FIIfKb
         FwfcPfez8yqlT1Cm6aysqVG/b9o1l1V7/29iSjruL5eVN5/IDAiMVchkY8ieWNXAnEmu
         IkLvxSc9LzSeJehLmpHB1rF+DjHF9HiUnfQfs3auLOSIKdHzYzlrtSgdJWnk/4xmm9Iw
         u5NWg1er+NCKCr4vKrv1nXncIjhObLIFE+sipkph5vduYdrAXDtTxUhl13JM2RxoJQv8
         hmhIHifKHBNk9IrA+RU48fuL+fdkzMOhGG7CLEPvUX1ZAPnNQbCRmB9olVNhskLDXd53
         chOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283985; x=1730888785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7IHw96pJSceCRXSurQsDRafKcFmCLrbbLG2f0iuwx0=;
        b=IbY1BwVsLz9noEtqsYKTj15kjxKQ3P6tx8/DRWW2ZWrAVyWi2n6uZEfAEKuW3JpMv4
         vwgJCWZLOipm1siViVrmhx/YSmPwlosCSZYHG8pwSfRyv3DARsy11OBgfi8TcTJPYsEm
         xdRMx5Ncj+dd9kKcu8Xxql4ndsUTOsisTmZ3eRLpPhyUX4eP1FDjn1rrRpgPuQgidOEV
         u1gZATlmR/HuKyzARlwqvidBfOLZvs2HJxsEGelUkS0lh4MB4AeTg6W9LJz43K9gNvnn
         ZH7TsoL6mm/EhCyG2j36vYkjTkH9u5frCTDJV3YbCik+J7ctzSERWXfzOkpbuMR/Ru8O
         xyyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh6yEqNVeZUxvmIA8baAYe4FwQ1/yg/1nCmyGHMVHuuu3LGkyLxYlP1lyDtIgEvBVJRanmozopgt+XgpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7umMGwwqW32oEl1z0NPfNp7qmTvgQN/apr8U5PGZ2a6JwgDuW
	LFkYsMIDByhfYeLOLzP0DH3ep3UEsIG9YnnCDzm3lI6JaxjRlbVyjpsUg5w3
X-Google-Smtp-Source: AGHT+IEsSQn2lZf939G8zecVmAyRk+7lmNeIiSQV0fgQYc2Uq2X5T2UTvVmvgUGq+bfIhy02aNc+xQ==
X-Received: by 2002:adf:ebc7:0:b0:37c:fde2:93b6 with SMTP id ffacd0b85a97d-380610f4419mr10091913f8f.11.1730283985298;
        Wed, 30 Oct 2024 03:26:25 -0700 (PDT)
Received: from localhost ([194.120.133.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479ffsm14978666f8f.49.2024.10.30.03.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 03:26:24 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] docs: ABI: Fix spelling mistake in pretimeout_avaialable_governors
Date: Wed, 30 Oct 2024 10:26:24 +0000
Message-Id: <20241030102624.3085369-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake, pretimeout_avaialable_governors should
be pretimeout_available_governors. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-watchdog | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
index 94fb74615951..70eabccf0557 100644
--- a/Documentation/ABI/testing/sysfs-class-watchdog
+++ b/Documentation/ABI/testing/sysfs-class-watchdog
@@ -76,7 +76,7 @@ Description:
 		timeout when the pretimeout interrupt is delivered.  Pretimeout
 		is an optional feature.
 
-What:		/sys/class/watchdog/watchdogn/pretimeout_avaialable_governors
+What:		/sys/class/watchdog/watchdogn/pretimeout_available_governors
 Date:		February 2017
 Contact:	Wim Van Sebroeck <wim@iguana.be>
 Description:
-- 
2.39.5


