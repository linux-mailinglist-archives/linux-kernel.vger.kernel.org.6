Return-Path: <linux-kernel+bounces-243018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059D392909A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A3981C2142C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 03:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A7134AC;
	Sat,  6 Jul 2024 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="NnjBJ0uu"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF9EAE7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720238016; cv=none; b=k2Cv0QCLhbd9NpTxQb5yt3m3TuDr+dQ90G1cJ30QDYuFwE/QvF65XaF9UGmE7fgY1rL7z46hFwVHzGAu+4jRMhPUr1KKp9LwQCGpxwQEYf3YD+FIZDaz+cr3XEn4p1Bn920P67nrwgiqDviYxLxeuisWpzASnBCfbS8ygdJ12qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720238016; c=relaxed/simple;
	bh=W/CrAXDbeC0SSEXOfQP63UPOyqf4kQHI6MDqovcLp30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmKag/6Gn4E0rKgZnoIXESzc2kun5t9mw8DMv1cS26I6+DJzXG/AluzPrB8IeE8qlJOLzWxqGf3tTfV+bPpuWfaJwKS5UWZ/3NAtTCvIyAwTPBu8mlOdILr9jyRfQWZMMGN9c/n93B2i6XJdLq5YBC7F+QSjofbjdjewQg08Oyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=NnjBJ0uu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70af48692bcso1641078b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720238014; x=1720842814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/QJekGf6J0BGOc8SMTfzQnbLQk7qq4oZoAeuPMHAKg=;
        b=NnjBJ0uuqLYTUiB60fjJjWACm27o3kuV6yN0Fdomo4Zm3hDd0Ev7R+kqgZJmtv8PR4
         Q5DUwE5HQrovLVl7punZ+dMZLLl8wcu80f6TDYdEVCyQqFBlEU66luwPGszxCV+EaBIe
         JXIl80a66Fogksz9ZutSmB1u/JxBh1LXMhzZUIKRpdo3fzjppDhLYu8XeJT7uEX4dET0
         ba6gamagGrUXnm0tqNhFL5nACtVVxtObC2bgnU9hyqmlGBqyu1flOyu/iSFDCIV3T1+e
         CdcKfAKbVkNH5I2nxt7MTVvh21mM59koEyCWImkalEw1OKlML3bKIkAzc+jGh7h97+H/
         KFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720238014; x=1720842814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/QJekGf6J0BGOc8SMTfzQnbLQk7qq4oZoAeuPMHAKg=;
        b=eKrg0LNrYpIrW7cDPeARbhMQyg1MFVIgWiEDRv98nQN85ZNac8sUuqao9GIzyYVGeL
         h/BCx9BarrylD5UBtly85Kxr15WkOaHXwD6/Zdd/j3ik8dMPcL6DC0WETDo2iwtWle48
         AfdNKE0SDFrOQGkHioe/EdFCld40gCn1+a8wUgVqLpa7uAuT9spchqax6psBUBfLN7B3
         ttoUfsbeqzCpH/ZAFSDGZ6SBYzy0YiqyVpfkGEdYdN04t5ec9WRDleIX8+HFMdeP71II
         +1v7PRwzL6P7+Tibty+bwZbWVsg7BU8KDKN2JFN3vhVolKFSCfZjkLAT2J/8FuNuLX2b
         T0UA==
X-Forwarded-Encrypted: i=1; AJvYcCVXM/1aOSMFsruVYik4/EaWnmCzDIKZMcjuRJjqtWTjprAuhKBIGEShB6xCV4e2o/HxFiKlCPHzlt4DZq//LVt0UX2S7345F+wQxuDL
X-Gm-Message-State: AOJu0YwbiPxsVys2MxMy+Ezo6VbdS4GvuddGuzV7MUnOUTTr0DA9zhAY
	uUrLbAWb/UpZPZ6dSyGDEKx7Bvs867USp6eMDNutRXMb8Eclx6GJWsRop2OkHCxWMs3NMYMRZho
	CaM8=
X-Google-Smtp-Source: AGHT+IElTiFX17tmBkDLlD8Ps+E21r8HvLYEwZ9QL9A53DZVx3aEu+m+fg9vfnoheFDx/oL/1qSpyA==
X-Received: by 2002:a05:6a00:1c81:b0:70b:1d77:730a with SMTP id d2e1a72fcca58-70b1d778ccdmr309693b3a.28.1720238014293;
        Fri, 05 Jul 2024 20:53:34 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b10abeb23sm1905508b3a.72.2024.07.05.20.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:53:34 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] HID: hid-steam: Use clamp() macro
Date: Sat,  6 Jul 2024 05:53:15 +0200
Message-ID: <20240706035314.153460-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use clamp() to actually clamp the value to the range [-32767, 32767]
(as mentioned in the function comment) instead of manually mapping
one specific value.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/hid/hid-steam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index a765a48c0ab5..69dde025999b 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1340,7 +1340,7 @@ static inline s16 steam_le16(u8 *data)
 {
 	s16 x = (s16) le16_to_cpup((__le16 *)data);
 
-	return x == -32768 ? -32767 : x;
+	return clamp(x, -32767, 32767);
 }
 
 /*
-- 
2.45.2


