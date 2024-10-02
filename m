Return-Path: <linux-kernel+bounces-347568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E998D546
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F251F22778
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EE91D0425;
	Wed,  2 Oct 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIWXT1r3"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B7D16F84F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875713; cv=none; b=nHLkV+ayxAhqsQ0C+l3TWvQcNqmc38CJC2EAfl2SOtEtj8rcVQHZtv4bn4yMmbm/+CSYTMEz3BjoYuQm1FJGUepatvUUEMDhrF4eD0DrCytCgrapYc6Rs+k4x+LZ6s4GlQbtU6GdnddHf6EIvbV//LAyrzASLU/MAlM1dIoIOZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875713; c=relaxed/simple;
	bh=jT055+MFltjtTxzItHRvNrTX2GMARXmC7A3pvndse3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dc1qxOGAaHG5gf1aKzR6P/HWWPu7TdHna/p33dbaW/SwDwWhc4PwW7+4X2CFne61lzvunTQRFlY/JxHqd+oZ6ThebSyO0rwO5l1P3gvwYHxfOlInNaFQm0EklFR3/lvCWQQ6XTndQgDENvH1qomPoVG/it9JtMqsmEBsWKCM5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIWXT1r3; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e109539aedso3149163a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727875712; x=1728480512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUdM77Xpa2KVFNEptPxhIDNx7G4UEev4geS+PHi3oYY=;
        b=IIWXT1r3a9u6OzTXpUiFijw9RRx3MUDqlmge2JRT0MiJvn/WzZ5IEFle6Zg1mgUf3w
         yx2Gc28VGJK+LnQk4U7xZJ6JOhHY6tKFkaQve0DOn3s0xzky8JZGZ3rbQ87/qwGyYpFR
         AmkXHImDQAgkBsEom+HHqltrQK2LvID825e5pSgQDkiZeIjq5dD0v6R37rB4ams+KPX1
         nrFaEGj8iNoQYPQv1AXqpQnWkDEoUdBJ1xzozlkzfOjz0t/QQJVR+2KuqXuM/X7Ye309
         iPv13AapW5y/2mWSAyMk2AMEoKEZ+aeOQzjzjCbfxAUAyZMUo+xuvhZ5Mlct08B50ctI
         1kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875712; x=1728480512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUdM77Xpa2KVFNEptPxhIDNx7G4UEev4geS+PHi3oYY=;
        b=BW4MZIrdywMY8Oq1SoGDdhnyDJi/tCS2s5RqsKvB3ZhaAfV2bEp9BlRpBITlUYv1o9
         xNDoWZMHE01SiFD0ZQ3gKTcbRVFZ1TnA77JVO4YEWdIi6fX8kmJiw1Rf61TL8Wqx3eOw
         PQm3+AF6PwVEuGLbAyL+ZthsgOqVODSR3SELMg9RHy07PrvcArglYJ/yc+kSiEjyAgDs
         /vSkdZYfLeeGxPR5Vv40SAbOK/eKKoUNXlB0pWADIb3ZWPvYgo8u39n9wLJztOX0vBru
         +ZaDe4rVy4qMc7GC1JaJ1GqBae4LBV/06jPFHyjo3IjkObs9icoNKGZ2SH7DabRHTIiq
         VMdw==
X-Forwarded-Encrypted: i=1; AJvYcCXmm167ui2R863Es/nupxAUpvOpuFQSPmTo3LPaZM/cwMRFY44Se3x/vHHsA0axKmpGGe0JB4awK6Ro3pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5zWYBsw2CGTgXPvDBaA6fpc0ZmKUvS9la95XASD1liqZvPf2h
	DuxQpDRpJFXsVEDZjYUqXJpmKMiY0RzbZUbuFlI+O6AEYJwSLLWM9G/htgO0
X-Google-Smtp-Source: AGHT+IF6zkvy6+eQJNc3Tih+OJqmD5b+H5QGpVA61mwNsdipu5U9oGYiQdmnB+iyPMEh3Ga54cZLqA==
X-Received: by 2002:a17:90a:bf15:b0:2e0:9d3e:bc2a with SMTP id 98e67ed59e1d1-2e18496a9f9mr3903265a91.32.1727875711591;
        Wed, 02 Oct 2024 06:28:31 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.173.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f7734basm1528740a91.19.2024.10.02.06.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:28:31 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-m68k@lists.linux-m68k.org
Cc: fthain@linux-m68k.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	sayyad.abid16@gmail.com
Subject: [PATCH 0/3] drivers: nubus: Fix coding style issues in nubus.c
Date: Wed,  2 Oct 2024 18:58:17 +0530
Message-Id: <20241002132820.402583-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses coding style improvements in
the Nubus subsystem, specifically in `nubus.c`. These changes
aim to enhance readability and maintainability of the code.

These coding style inconsistencies were found using checkpatch.pl

Changes include:
 1. Improved comment block formatting by aligning `*` in
    multi-line comments.
 2. Fixing assignments inside conditional statements to improve clarity.
 3. Correcting the use of tabs for indentation in specific functions.

Each commit focuses on a specific aspect, as detailed below.


Sayyad Abid (3):
  Fix use of tabs in nubus_get_vendorinfo and nubus_add_board
  Fix use of assignment in if condition in nubus_add_board()
  Fix use of * in comment block in nubus.c

 drivers/nubus/nubus.c | 94 ++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

--
2.39.5


