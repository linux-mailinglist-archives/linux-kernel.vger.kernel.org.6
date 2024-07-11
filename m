Return-Path: <linux-kernel+bounces-248825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4780792E276
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29931F21723
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225621509B1;
	Thu, 11 Jul 2024 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpvPNsgU"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B7778283
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686782; cv=none; b=E+6XKxjBSM3jqUZw0WTZG/HUDxo21RHK2t17rYsMKeAgNFkPZPY/cnXU1yqA3v/N4fBzKbNF02e8EgHQb4P5bIHFYq+zxCkqyq+o3vjn4XDoOipgu7wMDJ0Wo0Ec7yt1snXLTm/0GLjKadN7ro1EaGrZYGLRyFvKJqSVsiNsun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686782; c=relaxed/simple;
	bh=iDmsWbPPeNy9bLfIfXJjsf2+bhGoueLePNLNhx4xg/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avm4mQ8YZMIOoRooovNjBDNMm8msV2hLXR9bcXcrK5I2Hra8deGDWpiDmM51aG3p3UCdySzCkZNuvwXCajSY0LNKZo5ZSxB4tzYSDLNjU/i2horL9D2qx/+OJxw3E34Rw6aVdn9Xdim093aDeG3uiggbCXro08kBlQ7cZguM8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpvPNsgU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b2a0542c2so607372b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686780; x=1721291580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LDEBjijCQpJCT7g0M/qxAjfKn4jcHCjhPGH3P7mUprU=;
        b=UpvPNsgUBwEQ8zNaA6GUIuV9ooyThJQeLbRtXNUDv/tjyAm4WZabA/P0LdjvheeVKD
         rHg9jaM/oqJw2+1PY6LAmqUrqp47Ev9fwvAL0MY6WpSoGv3NrmxiEVBvymAQrsvJviw4
         WjnRFWwu1+hHm5w5jhgQck5UNE80VSkMJssd+I7i2mVrprD/S97kg49LzkF3txeQbzWq
         dKeVUSJIxHT64/6DdYwZBPql7HS3zbpiSAX1o323x4ye5VJb2UA0CNJkhUXAUqg25oOp
         3uBomc4JjY1Uv4OJhn48GRVZ2TJvwId14gQEmlbhz8LBXcThmoeudP0vFuz5AkVSQBzl
         937g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686780; x=1721291580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDEBjijCQpJCT7g0M/qxAjfKn4jcHCjhPGH3P7mUprU=;
        b=epTVgOotrxXl0wZAaFHIWwhZRm91mNhw8Ls4iPXJ+91t3CPZBAycdft4iiMMTGIwIH
         gQw9KE3VYRzwH1HuavfDvBQwtBTvvJTu1G42cD6TUiymG9qyt7qU9rQ5RG6Jc9xDxkPN
         uANuIkFi9iQi6Uuk3TL+poEDdvifB6ZXKbwhy2UhbKI3Ij9bole2q5pAeRyMkU+3RXvK
         SQkSSMX1U3Ed/ZGHxWksjUjc7pT+UHWGjDfSpp1sceOyd57NH6zbfY8qrk0InkiJibPt
         tnW2Xd0SR2axYuonS0M/LrBh8x7FTVb6dtSke1zVs5ARASDVZEwTUYL0PKYCjVIHsFD2
         fktQ==
X-Gm-Message-State: AOJu0YyJCPe6KfMyHrkS8jdt/JifhK5dyEuLzbl/BhnAXM9+y/eNqPP/
	AsZVFE+XJ8iLpEbC8JUYdFve7UoYP7flalu70n43iXxAbKYzZ2mzOAtKcA==
X-Google-Smtp-Source: AGHT+IHCgu/g9ZSJqiOCxI4GYMDEFJPRKB3Wm04lhAXG2TESWIWD3pRBGlIy43dY/mgOGvtT+UTAMw==
X-Received: by 2002:a05:6a00:1387:b0:705:a600:31da with SMTP id d2e1a72fcca58-70b435f628bmr9463270b3a.23.1720686779886;
        Thu, 11 Jul 2024 01:32:59 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b53a8e7d4sm2734208b3a.203.2024.07.11.01.32.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 01:32:59 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 0/7] Add wq_online_cpumask and remove cpus_read_lock() from apply_wqattrs_lock()
Date: Thu, 11 Jul 2024 16:35:40 +0800
Message-Id: <20240711083547.3981-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The new wq_online_mask mirrors the cpu_online_mask except during
hotplugging; specifically, it differs between the hotplugging stages
of workqueue_offline_cpu() and workqueue_online_cpu(), during which
the transitioning CPU is not represented in the mask.

With wq_online_cpumask, cpus_read_lock() is unneeded for wqattrs changes.


Lai Jiangshan (7):
  workqueue: Add wq_online_cpumask
  workqueue: Simplify wq_calc_pod_cpumask() with wq_online_cpumask
  workqueue: Remove cpus_read_lock() from apply_wqattrs_lock()
  workqueue: Remove the unneeded cpumask empty check in
    wq_calc_pod_cpumask()
  workqueue: Remove the argument @cpu_going_down from
    wq_calc_pod_cpumask()
  workqueue: Remove the arguments @hotplug_cpu and @online from
    wq_update_pod()
  workqueue: Rename wq_update_pod() to unbound_wq_update_pwq()

Cc: Tejun Heo <tj@kernel.org>

 kernel/workqueue.c | 76 +++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 44 deletions(-)

-- 
2.19.1.6.gb485710b


