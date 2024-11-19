Return-Path: <linux-kernel+bounces-414561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3419D29FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6646A1F21B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33701D5142;
	Tue, 19 Nov 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA9jbpgk"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A711D4604
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030792; cv=none; b=Wen+V4XEzGnNHgurLMLeszlOugJFq0n4xi2NbG4CnO4g4DqYXPhx7dqqgAx8CmK/8IX6NF1hck3xiC1OfFkadp8heCvPim93wNXnpJc4tn/0CUa1jGtzKk+eN5x0ZPN/SvtdFapt34KJHchO0LEFkk63s17CttWz4SLdlBZCUUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030792; c=relaxed/simple;
	bh=i8MuDTdkKi9dl0BKZ9AznMERrR3sQdWrUZZ+pbs7Xy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ukt4QJ/Pwby2XYfFZt9t+7uL3NCB5AlouxQ9JrPo5XS65CFRth+696zO/yxeuGj6k6c5bymFGVKqt2DbL4l/jjyS/+yJYNZXipFu8hjB0xfqh1/He/I8EliOiX6knwdv4K4P4o8JiDMF5mWX3Sr1nKA+BKMSz3234DUQ6EMl3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mA9jbpgk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2126408cf52so2481805ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732030790; x=1732635590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7KzftO9zi2bxnpNJZHPjDGDIefT9OY4V7qnZzEYHPhk=;
        b=mA9jbpgkmsDeXIDMusBA8RjvPuerERPC4HavuwZ7Nq/mJNV0jcx11x3LiHAIUi+Kws
         a9+1imWBRktrgzJqUqIBhIZiWJzxfmr7XRtILATIdNaSwrCaOUHvi3IjvSA9pwHKWZbB
         O5+HzOCRNOWDriE6+V22rT0AWI9lnOSYV0MGW2CBxdLUi/FAKWJKbNxIvAYxO3VsFIc4
         0x+470jE2hVzwo0xMSH2auD7Hyo5qflsh5S3enz6PoLwHJAj+P5EjIR0kNSaPMBsFRdF
         TqVw/OAcLBIqSfeSLBRG5D8jU8TKUrzH4MIJ5Lmg9I7k7sMEByKlGhhbt2LjIiwoJjxU
         X8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030790; x=1732635590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KzftO9zi2bxnpNJZHPjDGDIefT9OY4V7qnZzEYHPhk=;
        b=ijVGJhOb0fjPEvn+XczFqTOdPA80/xa9G5Spv4Lnd0T8O3NtK2DpnrJs+Io4ihFp+l
         oW4CY2UEBBfIJIgG966i/PL24mgs9BZAxrJxKxANYaclbFIbbilEFjckHQd86EuR0pGn
         roslrOYeoL622oFAsriMpIZySppyQljLqDUVriPOTONOPRZHjVDI0zfBaRswdXe9ehz0
         R6bEXtcczAz1EZhWfzxpjswDEr/qKQLc068nbfjfDMsHxjtwvIuTS0N6+t+Tf6lMmnAg
         nDgTVKqeGS2kcYFsMaCHZG1sMinunjx3SdGq+VCSMb0CvhwEhYOzMM89/fDwW0xBU/Yn
         iwvw==
X-Forwarded-Encrypted: i=1; AJvYcCXbGgZAwPEo6Dkkr9oujAzEi4sh2D9Fe2LowQV2uZqV4MdxNt2mGkH0sH1Vx7fcRtAv6SvOricjamYanp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywobkc6cfjNAol1kHn0aXA7/uuoSh4u5+qbtzyf9S5ZTloM1TGQ
	I2HMHofjhE/cpKhTqsZSExVx7FWLNpHfk5OQFfjTHPKHW4iOL9hw
X-Google-Smtp-Source: AGHT+IGVBPGQzY6hPrwtnFG1R1rj7oLhaWoxeEWonvMcUjG2rx218VxjPEKt3FCtBiTZe+sCPeCVyw==
X-Received: by 2002:a17:902:d482:b0:20c:7eaf:8945 with SMTP id d9443c01a7336-211d0d8fff5mr230230695ad.28.1732030789888;
        Tue, 19 Nov 2024 07:39:49 -0800 (PST)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:7dd3:c95:4ddf:3d69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212389529b6sm30114595ad.236.2024.11.19.07.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:39:49 -0800 (PST)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: [PATCH-next] i3c: master: Fix potentially uninit variable
Date: Tue, 19 Nov 2024 21:09:41 +0530
Message-Id: <20241119153941.8307-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devinfo is uninitialized if the condition is not satisfied,
add an else condition to prevent unexpected behaviour.

The variable will contain an arbitrary value left from earlier 
computations in `i3c_device_uevent`.

Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 drivers/i3c/master.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 42310c9a00c2..7594d3793eb0 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -284,6 +284,8 @@ static int i3c_device_uevent(const struct device *dev, struct kobj_uevent_env *e
 
 	if (i3cdev->desc)
 		devinfo = i3cdev->desc->info;
+	else
+		return -ENODEV;
 	manuf = I3C_PID_MANUF_ID(devinfo.pid);
 	part = I3C_PID_PART_ID(devinfo.pid);
 	ext = I3C_PID_EXTRA_INFO(devinfo.pid);
-- 
2.34.1


