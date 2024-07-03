Return-Path: <linux-kernel+bounces-238755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C0B924FA0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD901C228E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F64179BC;
	Wed,  3 Jul 2024 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWC6whJM"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC111187
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977771; cv=none; b=arFgITA9cz2zjN3Hvz1P6wgZ5+3oWd5fYIo3gSki1je+DrKVx9NrHu9fugQydvUOD04qE5iCerbOB7nkDkQvdOCrFRLHmu6bMTkRvYP3K04/9XeUMg/qt0NPyyQ1HuZK/V5MQzERlewRbpWxrmzCdJOkprw5SFVcedlFVOIk+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977771; c=relaxed/simple;
	bh=G8nq3KYdh9QirMoONwHDujRMlhBFSRw8PHtUh+RYGks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L3rJCS7j7cMrJ5+RY97NtvQaSAmjbUktL1HP9i4TcJ/6PUhGtIctKFDXVWUy0O7Uvd/cg+rO5sIJCikPyM51Ikr9aB92TgKNUcPEaxAAXK0ECxZxYFvxl1nhIie+AjBtAQoCwggotc3AMgqv39YIF+Ha4LQ3ANl1RG1mq7nl1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWC6whJM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f6a837e9a3so21279975ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 20:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719977769; x=1720582569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bIW8fFKo/WA1Akzmq2h4ZjGts16MbSA8rHna9aaImEA=;
        b=gWC6whJMSv93qa0iV+TbT+Aqo4zP49h4Jj//SNsN6gzOL9PMpb5zoCXSQxWPmPNYJ6
         ZEg44koVkVK9q2IiRTMpMB0MvowNuEw6k6BZns4V+ZS8ZHNGPsnaskh5kC01vp6dD8pF
         nWnUs1O6c1xY3TYXUfD3rXgLjHIU8D2codgXAdYaJdPY7lanVOpJPFcutYSnfV1iBhPa
         MS+jiLpYH7jsInc/MQxwueiefUXYK8RKlFLtsRhz2Q066CzlW5FplCWd1JSZSW0pY5X/
         OjNscOdVj4RdovF1cTMeKfP62cIG2OyMkyuhud3nGgsvSoTp39d2NVwFMmtksD1T2MFu
         Qzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719977769; x=1720582569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIW8fFKo/WA1Akzmq2h4ZjGts16MbSA8rHna9aaImEA=;
        b=Z0TcrX8arOKHlmFUOloDw6b0whQu+EmmtSWFFhkndJAYKMdugMskdI38/pwmcc6Avq
         hE6xrXZc1uclCd388GZSZIBN/OU9V8Za+oUpo6rHzwVz0Z6VYhkPnCqkb6D952uWo/TK
         RCNG2CUB9nHrOq6qFSEYgomNH5HYk7Z2Vbjde5srhzImfO2uukCpRX1t2SacVy0/HH8F
         ccUDDBxrgkm517sA2DPABq1MmuaL+95RLbkBoOdpt/uqx2HAO7CbpP1l7J3JnDx+HM8C
         NFuTBvigtxX87Q9VR3VH+0lSXE4LBcWFvjR3+Cz4AM/zq6XSFFWomOVeiJsgR8gdFR/s
         x8AQ==
X-Gm-Message-State: AOJu0YwXLPwXksLpSidyjz7F38pZUQmX0t9Gru+uX7U8QbvwYta+f64v
	4HnsI1BozPzAmCY8aV1GF3cvwlp2luNdF3NaT/I2W8jEyDgMpp3NkVLVQA==
X-Google-Smtp-Source: AGHT+IFUaQRh9Twvhn5vIaZkCwv2byP3iBgWI4hMzsshOr0cs6sS704KuhSLYUkH+411U/fLfgNWUg==
X-Received: by 2002:a17:903:18e:b0:1f6:7f05:8c0e with SMTP id d9443c01a7336-1fadbc5b502mr64752865ad.2.1719977769053;
        Tue, 02 Jul 2024 20:36:09 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15b890asm92092705ad.301.2024.07.02.20.36.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2024 20:36:08 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 0/6] workqueue: Make the PWQ allocation and WQ enlistment atomic
Date: Wed,  3 Jul 2024 11:38:49 +0800
Message-Id: <20240703033855.3373-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The PWQ allocation and WQ enlistment are not within the same lock-held
critical section; therefore, their states can become out of sync when
the user modifies the unbound mask or if CPU hotplug events occur in
the interim since those operations only update the WQs that are already
in the list.

Lai Jiangshan (6):
  workqueue: Register sysfs after the whole creation of the new wq
  workqueue: Protect wq_unbound_cpumask with wq_pool_attach_mutex in
    init_rescuer()
  workqueue: Separate out destroy_rescuer()
  workqueue: Init rescuer before alloc and link pwqs
  workqueue: Move kthread_flush_worker() out of alloc_and_link_pwqs()
  workqueue: Put PWQ allocation and WQ enlistment in the same lock C.S.

Cc: Tejun Heo <tj@kernel.org>

 kernel/workqueue.c | 110 ++++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 47 deletions(-)

-- 
2.19.1.6.gb485710b


