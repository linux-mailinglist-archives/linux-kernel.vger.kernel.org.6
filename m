Return-Path: <linux-kernel+bounces-302841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FF4960411
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE064284000
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A0A188A07;
	Tue, 27 Aug 2024 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK0kRw2I"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9893C13A25B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746334; cv=none; b=k2/5WTRiIBGljSRJ063bbaur6ALs4srJCmmwp2RmI7kS0/YU/KRL5h0tBRZuE4f25Th6Dfmx+sXE/YAPJcfOv91UaihwKD5FFCQZrx+k9/tsFYKSqbUq/hoBEdHDEfxTU9cNLe9RfK9wlim7jZ2TR17U18SIXvtk8/eIfxxLRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746334; c=relaxed/simple;
	bh=1zhjPy35tAft0ML3E1rzPPQg/5mwiHuG7IzmJoqGCfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CMBl5j66eRH6CDz86yp7xARVINn4ke+c/SaIE9AKdrVufLZQRMcPfSY7bbGrijONemyplYSr+4HoKjj8Yhxw01rBdpupkVxr5fKz35m6TC//UqkVFkoxPavK+b59tYYs0bUiTCn7SAcgDc+0pUc0cSVzTwSHMXIXneblarU9bYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UK0kRw2I; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-201e2fe323aso2713615ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724746332; x=1725351132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6eyASXvFFBLrRxfnlPxEMs4Lhi6ZcRK67/88H1vNg4I=;
        b=UK0kRw2Ie6aqlnDx78FckML2r4A6eS8AA1XMbgm+l8fmo5/T7wS3PerMh07b1rrnzi
         GdHdil0wQXyfXIi8ZeyqcSH/OnLSaM1XSu9sOWa+uBXvPPAzQLIIi3F80LYQ13nKsweK
         fZB0FoRhEBF2XyM7UQdafZwXabT8jEtrFYoAIlVDc3P7pLg53LzFK9Bydur9NtDyT3a1
         GMMBvovOLXef7sxMDhyWtQO+lWQhuJp0hPTs8saDebIzTrjcItiGUGfUUJrR++E+jAyk
         NOMZN5o+t48yAmLt0yHyxZd2Iw0A0MZiBrHw8QdydPnkh6Uu8lK3tFh4TZvROish8MHK
         1hrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724746332; x=1725351132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eyASXvFFBLrRxfnlPxEMs4Lhi6ZcRK67/88H1vNg4I=;
        b=uKHYuUOePwkD1DBuoSNKV+KpXohlX1qMO9BEZ80mbSPEA2ZoTMU9RAVOmitsfZu0pn
         P+6nzEKWSn/PgT23TkbIg1K6jgwqaOekudeX5ug+l8WtuQ3S+imQX66APcx5riNHu9hR
         dJg2lgclMslCt5XNPLWyDVFrvCiDHFvELuKMF4m8ZkI9D3Ri1xzje879wmXadbqFjPfP
         WvhVbZ+KnJwtNn5IhLvjvRoYddK71AAxCr7877CH7xV8Miihi3fu2RYzDBVS8RUj222+
         k18gEScrFyy4TzuwHcNpTeiVa9t5N3xMjonP+HFvG+HqlzPRJHb9fnT+aKtWswNKkYUk
         TFZA==
X-Gm-Message-State: AOJu0YwwIf7TKaO5dYb9Ys7cxzn8AHnc7COJU8hZqdGc3ynyg9Bltkmt
	WRcNIRcXhCGx49fD1Yw/VO+Fyg8Oo+JCKneLgINooATEnulEUwAo
X-Google-Smtp-Source: AGHT+IE9Lx4C7FqZirHSDtcCNwvnG8C6KW6FoCsLKETWZ4N2KdxiCpdD8C00jV89+kJ7dDlKQd8SDg==
X-Received: by 2002:a05:6a20:918b:b0:1c4:d11d:4916 with SMTP id adf61e73a8af0-1cc8a07737cmr10040372637.7.1724746331658;
        Tue, 27 Aug 2024 01:12:11 -0700 (PDT)
Received: from localhost.localdomain ([49.0.197.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e4417sm8313732b3a.97.2024.08.27.01.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:12:11 -0700 (PDT)
From: sunyiqi <sunyiqixm@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	sunyiqi <sunyiqixm@gmail.com>
Subject: [PATCH] cpu: add CAP_SYSLOG check for reading crash_notes address
Date: Tue, 27 Aug 2024 16:11:33 +0800
Message-Id: <20240827081133.872741-1-sunyiqixm@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPU crash_notes value can be obtained through /sys/devices/system/cpu/\
cpu[NUM]/crash_notes for leaking the phys address(introduced in kernel
5.10-rc1, but some distributions may migrate this feature to 4.x
  kernel).
The relevant function is crash_notes_show() in file drivers/base/cpu.c.

Though crash_notes file permission is 400 and owner is root:root,
but in container, the root user can also read crash_notes which leads to
information leak as most of kernel pointer value can not by read for
root user in container without CAP_SYSLOG capability.

In current linux kernel implementation, kernel pointer value or address
printked by %pK is not directly exposed to root user in container. For
kernel interface which includes those values, like /sys/kallsyms,
/proc/net/packet, etc., address values are guarded by kernel function
restricted_pointer(). Without CAP_SYSLOG capability, value 0 or NULL
will be returned for reading those interfaces in container using root
user.

In restricted_pointer() and container, address values only returned by
kernel when root user has CAP_SYSLOG capability which is not the default
capabilities for Docker container. CAP_SYSLOG prevents root user in
container to get kernel pointer from lots of interfaces based on printk,
but not for cpu crash_notes.

Add CAP_SYSLOG permission check in crash_notes_show() for viewing kernel
address.

Fixes: aa838896d87a ("drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions")
Signed-off-by: sunyiqi <sunyiqixm@gmail.com>
---
 drivers/base/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index fdaa24bb641a..a2f27bb0ffe6 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -156,6 +156,9 @@ static ssize_t crash_notes_show(struct device *dev,
 	unsigned long long addr;
 	int cpunum;
 
+	if (!has_capability_noaudit(current, CAP_SYSLOG))
+		return sysfs_emit(buf, "%llx\n", 0ull);
+
 	cpunum = cpu->dev.id;
 
 	/*
-- 
2.34.1


