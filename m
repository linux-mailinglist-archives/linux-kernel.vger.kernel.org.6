Return-Path: <linux-kernel+bounces-232728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B90691AD9C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B5E1C21F86
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A1619A295;
	Thu, 27 Jun 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIEA9/f3"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A6219A288;
	Thu, 27 Jun 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508297; cv=none; b=baZi6hmNXRVhDKAgtzFr9GOoCUU/oBttU8v3pKBQqdr7Yd0Se1cLZOEjlryqR+CV7BmbIu5TnDSeGDgM3bhRnZM2WSkjCKiXCA1kLJY/jgUwDDkBZ0fvRMkCHzS7AGbsotDmfqVM4drlCSqtloJN9CShWdJsDQ0D06g0iVfFHxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508297; c=relaxed/simple;
	bh=QxkEVdlf8zyk1RIA+/TdGzvbc2WpIDBuALqYaPUC+r8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TqDVpAKeQ0K29XpDnlHmMS+HtaBdMCya4QJRNsiNEyOXUw8sreGhkb7JKrWzzFRa8B039Ss2++YEG6+4Bny9UQWHY8JkXd4I/NzNBZOr6TaX7lnhzu7aFCL8KRktT8o4pkPoI+rdfUcb0sfVe2a1AQlExWhb1c0ilSP4tS/JmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIEA9/f3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-424ad991c1cso25352545e9.1;
        Thu, 27 Jun 2024 10:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719508294; x=1720113094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqg+cB0tsKwYbj2AdR+1t235Rjir/+bGbK9C4esMo/Y=;
        b=GIEA9/f3CNGaZ+M5VqS7A0ET6NxJYXaZiQX82tceAnj9bJ51kH8gfzxmwhNylM77uT
         nO40Y9MP4rB9EyqsfqZbkDdz7xv+4cjF3Jq5MNbToa6DSR7vt4R7vsrSeHIWgJWlGBmG
         5cv4HFjNa5DHUQVq3B+1mUTy57zkv3gk0KeVyjab28MD8cWYnjKzaC5Xl+gK8WVRg5ZL
         h6+hezqPW8FxKAjjDNxxFpN3QAIEKbVLOuqSGM8Zmd1yrMGX3NbyfFSO+XoDbyrLTIkI
         DNCpvpFDBIvDD4z9JxkpYXxA46Nxml2QvZpMwF0tJla9IxclGfe4vgoHepLYhgHrXjAm
         US2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508294; x=1720113094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqg+cB0tsKwYbj2AdR+1t235Rjir/+bGbK9C4esMo/Y=;
        b=sPxfQruRAhzx+EzEv9x68bZ1iKfRCWuzi4xfx701iSN+XRIBpD4BkMqqDg/MRvczm+
         jrBxYlJxvCMJW1rEaoTbXyDfXjbfyzay2aW8aJqUD2dA8WKtxLi/mDjBR1t6S/V0Yz/J
         PnwGFaqcRNATipkwzrgAuXgynH1apgunkhweYIETFQhmNiwxR3GMMyU6BAUdGS9QeisZ
         QAauPdUtmNGqsw9T7riYoYOKxP0fU1jYpWG7M0kP0/TlLV4UlMryYUAb2/aAUMSRVYqh
         5p9U/g5sDGSUNMGHvX3k1l/7dSd4DbnFVDyNpG7jrRJOxbxxuErOJzd8In+t/e1z4Yah
         dOmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqgDAZAEeJAK5c1s3mduw1P8+/r+46Oi8BfCviWoXkbxdEKH3OnpxE4094Y1nIOkM0mVMM7+wS2BbgRfybzyTvCyTgk0re9spSpYer
X-Gm-Message-State: AOJu0YzmwNTfZkemqX8PpdqVIjdQhxrO/I9ynXqIL4GEwmj3BsSjuh0w
	rDH9eqS6QoTHwoDvQfucsUZ7+bDLlYeQG/w+SMStmlrQzEeN7xCB97bJig==
X-Google-Smtp-Source: AGHT+IEQyc28xXl89nzT+yHLn1As7BSXret+foZ1FqJN1HcCzTFQPzttZkYpnClu1IgjIjaR2UqD2g==
X-Received: by 2002:a05:6000:1844:b0:366:eb4b:4e74 with SMTP id ffacd0b85a97d-366eb4b4f40mr14405736f8f.1.1719508293966;
        Thu, 27 Jun 2024 10:11:33 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36743585528sm2499212f8f.65.2024.06.27.10.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:11:33 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Josh Don <joshdon@google.com>,
	Barret Rhoden <brho@google.com>,
	Hao Luo <haoluo@google.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] sched_ext: Fix spelling mistake: "intead" -> "instead"
Date: Thu, 27 Jun 2024 18:11:32 +0100
Message-Id: <20240627171132.127421-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in the help text. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/sched_ext/scx_qmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 4d41c0cb1dab..e4e3ecffc4cf 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -31,7 +31,7 @@ const char help_fmt[] =
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
 "  -D LEN        Set scx_exit_info.dump buffer length\n"
 "  -S            Suppress qmap-specific debug dump\n"
-"  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
+"  -p            Switch only tasks on SCHED_EXT policy instead of all\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
 
-- 
2.39.2


