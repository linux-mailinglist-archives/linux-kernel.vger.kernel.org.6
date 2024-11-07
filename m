Return-Path: <linux-kernel+bounces-399395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AABC9BFE65
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3BD1C214F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42F194A51;
	Thu,  7 Nov 2024 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpbhpSjD"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC24E16419;
	Thu,  7 Nov 2024 06:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730960359; cv=none; b=ofUMO6rgzn1sLCaduw+AZE0D788POSQ9mrUxWA8qMqPf0n3JnLze0HA2njVJlkNDa1wbV3EeGlgi1MjtPGj/h5nMU4jkA9HqK6Z6Hxpo+QSzdmO6AG9qUe2YtR3oqlp7FEwrYUJLQBPxI24J+5qwCap1PowNByrCM0sutcbRsHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730960359; c=relaxed/simple;
	bh=ANxD13YAGSTYC6cNRZS2MistrSwi7MUahJbAyk88Auw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M1iRxb0cu36f9BxS10jTXOb7ppCouVr/m2f/kgFtXsKJwybtmz81ds3lNFMNhDo0Ih/8i/RwOxiRXzpbkUkZ4E1xUabr5xo77EOweLEVzYOYeB/bVWunhRYem+s/NB6lUut0kJyF8UUeN2vqC3LP0ppJsjZKjbJaUs9Cr8FcfsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpbhpSjD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7203c431f93so435621b3a.1;
        Wed, 06 Nov 2024 22:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730960356; x=1731565156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+AhCXqAG1kLEFq3qc9uec/6rupnmZiZFxA7GdB80Lg=;
        b=DpbhpSjDsVbOsaOb5pKjtXPqyIds0EOqdkyxhczRGAr+gWB0p0ia7tX2QHIIzkkzgL
         +RXX3/zJ/yl5D6CdG33ELVmWy2WEhOxrIh6eh018v6UcGu8Uc9IR5UNqN1wV3RO35tJm
         +HJHscdY5JnV5BQbKlFUJykGxXJDj8s3WORKGZrOp6+X9dUGcZ1uMjlsLiVjvO+WEbUQ
         dVidUqZtx8gnKAeFJP2xBWPL4rk76KAswGjniUtbNzHKKSHiB9yEyDKkTyrQSZkQz4Wo
         GfyDs3z/8aa4c0b1hqfrPO8AY1BBJLcyEiSULKXKNMV8nbTa0Vq9MT9/iW90ld3qp+dO
         ZXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730960356; x=1731565156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+AhCXqAG1kLEFq3qc9uec/6rupnmZiZFxA7GdB80Lg=;
        b=a+xFbwJbWDdGhpTJOTnCdk9PEe7oHEqc6NiX4k0ZA1v2CmeTOAKm/ePrw0EenGduID
         NslvlliNUFdXJuSvOLV1ce3VTCsqfZQG4vyJgpi6tHeCFn+u6HXkjSM4DaA77Xhm32vH
         XLnkmjZRbzS0ZbE+cHxKXFYGPojEB0BhWEUM6Pm7JFOdBGmPjGbf2o9IUWpxGztyQ5+E
         DsYtdszoEKEjSbvkG8m/204AcnGmIli4/+m1rB0v7npwpYZY6FBeXnJEK6zcFcJRRXQg
         lBpvB7EMmvhjwy+QLyx3amZ81Xl/OrPzc0nb2JwWPFUAOlZkPaGvaqEJlK1SE1PWFi71
         TeQA==
X-Forwarded-Encrypted: i=1; AJvYcCUIIbvZiBmlHUW7Pkxn6CIeRwiR4YtKAeReglKDfMn5/4+zablMHZg1z2D12OZZ1PmIWKawz4FEGIgBsuQv@vger.kernel.org, AJvYcCWwiS0HISDv/oMACCLyFJxtjBtZV2bibf1WhFU7sSQT/OBb4hFJ+2VjMvb3s/k2XYFox+5bMmW5ACs/@vger.kernel.org, AJvYcCX5GIhE5NQ/cyVpXuLJGDgPtgVl09/6rAV8DbaCRV2+YPnP7ifIEwAWvfG+8sqYz5OMU1T4BM4V74k=@vger.kernel.org
X-Gm-Message-State: AOJu0YycMrBLC1m1yU2xGno9CZT8+KyeD8Ad8CrHCZti2xBmmeCat4Et
	d/5/mTAnn2hDgWGeY1l7QMleIDZUmRKT4dOwCYkXeoQZBkuEwxr1jgLNcTLc
X-Google-Smtp-Source: AGHT+IGNBcdEGIHkv+fNvnfYUh3MUw696z8lIVcstfD0ZkGTSBmAMs23W89m3QsQO5uwBr67WzaqIg==
X-Received: by 2002:a05:6a00:803:b0:71e:4930:162c with SMTP id d2e1a72fcca58-724080b01afmr1146788b3a.6.1730960355859;
        Wed, 06 Nov 2024 22:19:15 -0800 (PST)
Received: from 1337.tail8aa098.ts.net (ms-studentunix-nat0.cs.ucalgary.ca. [136.159.16.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffc2sm676523b3a.25.2024.11.06.22.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 22:19:15 -0800 (PST)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH] docs: fix typos and whitespace in Documentation/process/backporting.rst
Date: Wed,  6 Nov 2024 23:19:11 -0700
Message-Id: <20241107061911.106040-1-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Fix repeated word "when" in backporting documentation
- Remove trailing whitespace after '$' character

These issues were reported by checkpatch.pl. No functional changes.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 Documentation/process/backporting.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/backporting.rst b/Documentation/process/backporting.rst
index a71480fcf3b4..5e15adc34799 100644
--- a/Documentation/process/backporting.rst
+++ b/Documentation/process/backporting.rst
@@ -553,7 +553,7 @@ Submitting backports to stable
 ==============================
 
 As the stable maintainers try to cherry-pick mainline fixes onto their
-stable kernels, they may send out emails asking for backports when when
+stable kernels, they may send out emails asking for backports when
 encountering conflicts, see e.g.
 <https://lore.kernel.org/stable/2023101528-jawed-shelving-071a@gregkh/>.
 These emails typically include the exact steps you need to cherry-pick
@@ -563,9 +563,9 @@ One thing to make sure is that your changelog conforms to the expected
 format::
 
   <original patch title>
-  
+
   [ Upstream commit <mainline rev> ]
-  
+
   <rest of the original changelog>
   [ <summary of the conflicts and their resolutions> ]
   Signed-off-by: <your name and email>
-- 
2.34.1


