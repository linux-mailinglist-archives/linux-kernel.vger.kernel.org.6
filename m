Return-Path: <linux-kernel+bounces-411994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE229D0219
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 06:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971F6284EFA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 05:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2C42033A;
	Sun, 17 Nov 2024 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="Tn1LpXPS"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA01392
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731821711; cv=none; b=rVbhfI31kRv22Hi159aEqMrS7ypIHjrLvbEHr/qVeJt81PejwJxuULjLztUBJmXgYEu7I1cdHWlnkmE1Mk3at8B3WbsyKt8kjxq8Lsp6Qkcg85ZRY7p61gI+aWpXO8PuN/8RoJjcG1vdQCvdOxsVYKtBB/H4o9cuhX/PDTqMDh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731821711; c=relaxed/simple;
	bh=nzbg6kkkpFsR5AMw/Pd9i3wEU4f0c1iRZEx+0SHEPtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p00LkCcRXJRZ3P+v7uaTkHh8eyPiy8Tmfy+xfOArgZFR7iMjOKTYzl+M2Luwp0aA2wlTbQBTmuuAleKdjPfMFPOeeEX12s+5+rkUHW0ZiyhkjqU2qI+GfqjSpiDqquQB+EcolqEpGHKZyn8oiso9sBcJGjnASlxgp0kvDcNNy1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=Tn1LpXPS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c803787abso25243495ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 21:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1731821708; x=1732426508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xioySJGJhfYF5zMTYwcy+Zyp7kJH/8KqwR8zz/AHa4=;
        b=Tn1LpXPSjaNNil6bR+B1ufbTQupfezqKi7xe+kEaqMfu3NOwW/b0RtC3JchXSMzj3g
         N1c6g6tv9RadwrJZ/HG+KClNYzqp03Pqqz20m2U/+aHAy0X8DrIyKoxmipVuhhZSTFkH
         dOgllnDqYRqdzHE0kdX3qGkDfltt3q4lNSszf+ua/9wu0OAQLpHLOTvy/wrMs/J/goE+
         qTsCK34I7Zmn+mRoQXpx9jH2aip2MAbDfWo+Gm87DaBAAfi100pnMO6o/czAEKngdHBJ
         JVZgYiCWzKWYWcpsSJYqAytxtYyhPFNTHjV3TdkWlP/6SW1ZdB18vDhJgug/XDHNw6P8
         G1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731821708; x=1732426508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xioySJGJhfYF5zMTYwcy+Zyp7kJH/8KqwR8zz/AHa4=;
        b=k+0cty6aBc60Apu5f7tTy/MW0dtjy2VchNRM4FLW2su23cqvluArQpPxnagiUPAz01
         dxhOHpDm1jgH0xjOMpixPU1vfZXZpLJnGJ/jAm/3PMGd1p9u4OoVrcrdqSAbbtxsGtJw
         PjGtllekTVOWQBH1IvoDMq5jP9csn3M+eyBTshaYzKKLmDixCyG7eJ72Q0oHltR8B316
         aU+zHAEIWnlXNZFJP/HMNOu1v9LIrSgaeVox7UnXdFxlqehEw14+a3YOYVba3BPodNIK
         83c/hJIoHfivqoeAvJOMSkmUT1yVaa8V0PKueqfPZmh2vbtYZLA/rdEbN1ngls3eiCyT
         XE5g==
X-Forwarded-Encrypted: i=1; AJvYcCUxCacPJOOsxhUvIfixGRvOfNQYrjqEZNu3GTfR1v0MCtF8MBpkZcqLf3vt/qvZ3lJ9+j3vS3eC5tN1oMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV35EVojkoUIqvAAhHqCvnLTsMj+BVDec3wOWYFNNiWJ9CpJNf
	dc9xMxmKYSBEzOiigAFATbz+j+vEm1h/nrE1YuejAMIhhgBtM/lZ3xOWkqrKw+YRS2KHCEuJ8g=
	=
X-Google-Smtp-Source: AGHT+IEQCh0aDWW7PWBo+ILuoIa9T9qcn7UxxLpwkBNZYapl4xbSedztORaO8KpAAbOlgL1ADQKKBA==
X-Received: by 2002:a17:902:e5cb:b0:20c:e169:eb7b with SMTP id d9443c01a7336-211c0f3de99mr168696545ad.14.1731821708015;
        Sat, 16 Nov 2024 21:35:08 -0800 (PST)
Received: from localhost ([2405:6581:5360:1800:96f6:cb09:e09e:fe02])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211f119b3f3sm18519845ad.192.2024.11.16.21.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 21:35:07 -0800 (PST)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: Sebastian Reichel <sre@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Davis <afd@ti.com>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH v2] power: reset: as3722-poweroff: Remove unnecessary return in as3722_poweroff_probe
Date: Sun, 17 Nov 2024 14:34:43 +0900
Message-ID: <20241117053443.1148902-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return is executed on the devm_register_sys_off_handler() line in
as3722_poweroff_probe, so the last return line is unnecessary. Remove it.

Fixes: 348fde771ce7 ("power: reset: as3722-poweroff: Use devm_register_sys_off_handler(POWER_OFF)")
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 v2: Set correct mail address for Sebastian Reichel.

 drivers/power/reset/as3722-poweroff.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/reset/as3722-poweroff.c b/drivers/power/reset/as3722-poweroff.c
index bb26fa6fa67ca7..8075382cbc3625 100644
--- a/drivers/power/reset/as3722-poweroff.c
+++ b/drivers/power/reset/as3722-poweroff.c
@@ -57,8 +57,6 @@ static int as3722_poweroff_probe(struct platform_device *pdev)
 					     SYS_OFF_PRIO_DEFAULT,
 					     as3722_pm_power_off,
 					     as3722_poweroff);
-
-	return 0;
 }
 
 static struct platform_driver as3722_poweroff_driver = {
-- 
2.45.2


