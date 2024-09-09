Return-Path: <linux-kernel+bounces-322035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FCB97231E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A4F2855BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC58918A922;
	Mon,  9 Sep 2024 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYb7epX4"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6C1304BA;
	Mon,  9 Sep 2024 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912186; cv=none; b=LZqmMo3GyArfw14cuLYM9LDE6N9sMDiPXdOTiYzvEDcvpY+1ylKCUvRA8hIe3jyGwdu6cI1OyLNoIsUJrdHM2q+7xjTlF+Ibl6xjH2nAeXHYW0THBATH5b5WQomWjtodn4VAxXNKu9jTQEjW4HrpBx9C81c+Qau9UAlk/7bEPgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912186; c=relaxed/simple;
	bh=98ATOqRpPlw66eNskJRZJR4j0GxcPt3Mqkps8rzxzXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q9Ibmbi+ri1xI6rb/OFAs7F/p5Ztm8ChutEn0/duxB/XVcvgljqilgFo2P005BCEQmpAFa9SbkenFEtJtjInHQih/E6SzxAr/MCbJuUFRUltaIA1iD6rr0Wh9DIlUeDEx6jzyJI90m6kmzJY5hFy4hdi1Mq71yBkwXhAnjvMFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYb7epX4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718e482930bso1460483b3a.2;
        Mon, 09 Sep 2024 13:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725912184; x=1726516984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XIpVNTIU7AkD5qFomoi/slMfyi8wrL5+kfsNJ7Mu8EY=;
        b=cYb7epX4QuIBXakh3b7oVVB6kz3Lrdig12yXgKKF35UhyCHjjq2343dApswxhIm/Yb
         szLEtLj/p4JlRK6WlOZ8S1JROu+9ZgmVrhGTa5BbyASMdSTk7TQFLI6CTk1xcZA81PMB
         khIFjytazcZ9i4beIuAJHuQOU2kouT7abITXUbior7l6jZVcat7cmAA+mbAVoVkAIsA8
         YiiOPdFhj1CQolkDsx1He0lX9vxRzEcKD8i2pfEPAHN01p++mAzURdAI8KogLMmyttia
         TAN+jlJ0F1f3TicagncN3X8zK87XMKh5P1PCxY+z1rauY6JQgQHAQddH8RAh/326fXx1
         ZrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725912184; x=1726516984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIpVNTIU7AkD5qFomoi/slMfyi8wrL5+kfsNJ7Mu8EY=;
        b=A6WGS0vwpER7BVmGX8CcZOKMLKeTwm1NUR8/u3UNfv3w7YinUezVFy6/2OnRDOUZVT
         9BB5cILjugFycLFKt78WoG1uT4Jbqe6cIKqFSc/XY3yJFYv0iJqFY8/6aQPDL5CHgW5n
         296DMw71SzuFlcdrgv/5TZAEJ4Ja+tddgaSTI1FS4sRMVRxKA8uvi4v1DPKf8XmVSy4T
         v1SPIUuYOWo73oStR3LHaqpezrZl5qcu29/ODnlHgPK2DePtCp8LoLRuXNj0kbTrHIoZ
         dASilSap56SxFM+1WkaJDcVvtoF+UwIXcXj300pQ/bR9jZB9pwUQJT3vR+93pEA2rGu1
         LJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3SEAtUEA66KhrSidhWJsbHx7hpgw2eZeuTvePFEEIwqqDjkRSexI0f/9oEh63YB4jUYgmlw1bhuM=@vger.kernel.org, AJvYcCUNWLZnlich0ry7m2SeEoURVCWOPzC3A3VOM0CJZ4vfUSeOiTicRwHoOwXKofwURMLejgSUeR3Sr506fo3U@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqk18BaEiA/rGKhQIvyWcI4c1HdAfaAzWHzf0mucrUGRC3Ji7J
	Chi4Qh0lSjCNvShetCB4EzIgHcCPUMrtgzhezodD8SXiprgcp29I
X-Google-Smtp-Source: AGHT+IHPYLUqDL9wxAHrYhKP1C7rVJvZOr82JaMztbBhc457FG8zFTv3sXRmmYAsW5VdVnxAsMdvRA==
X-Received: by 2002:a05:6300:4c:b0:1cf:32b6:bcd with SMTP id adf61e73a8af0-1cf32b60ca3mr9822622637.33.1725912183946;
        Mon, 09 Sep 2024 13:03:03 -0700 (PDT)
Received: from Kuchus.. ([27.7.2.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7190909222bsm110594b3a.115.2024.09.09.13.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 13:03:03 -0700 (PDT)
From: cvam <cvam0000@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk
Cc: hch@lst.de,
	sagi@grimberg.me,
	corbet@lwn.net,
	linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cvam <cvam0000@gmail.com>
Subject: [PATCH] Typo in the file 'feature-and-quirk-policy.rst'.
Date: Tue, 10 Sep 2024 01:32:53 +0530
Message-Id: <20240909200253.19818-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

location: 'Documentation/nvme/feature-and-quirk-policy.rst'
tested: Not breaking anything.
Signed-off-by: cvam <cvam0000@gmail.com>
---
 Documentation/nvme/feature-and-quirk-policy.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/nvme/feature-and-quirk-policy.rst b/Documentation/nvme/feature-and-quirk-policy.rst
index c01d836d8e41..b5461aa303a4 100644
--- a/Documentation/nvme/feature-and-quirk-policy.rst
+++ b/Documentation/nvme/feature-and-quirk-policy.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 =======================================
-Linux NVMe feature and and quirk policy
+Linux NVMe feature and quirk policy
 =======================================
 
 This file explains the policy used to decide what is supported by the
-- 
2.34.1


