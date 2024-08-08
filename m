Return-Path: <linux-kernel+bounces-279684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80B694C06E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA54285A9D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0105518EFE7;
	Thu,  8 Aug 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Y3Qm1zXG"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B526118A944
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723129244; cv=none; b=pyOdAJJ6qxuLFspmWXZsL0j2MTytcD89eey3JAFTHE208XH6Tb+vSrGMmmtfkQU16jU+/LpafkqCcDFP6acZGkrRmhySftvvTe/QX+/dNRbMAqHZbKlWqAfWDdkSmB2g/O7O8OM6+0Q3MMioqaSJvEv0y+M/DYg+5jOLd6ty8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723129244; c=relaxed/simple;
	bh=vuvMWh6YATvbV2e/4JH4NJzWpYvqaaRTdIQvBVZ710s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IuRSA3NMP+Hj905kYkXSnGndjpqp+lSJrLflxTRxFkFRF8/jTWzS1j4QE6KHtJCc7SB2VZDqypsaAy1qUra0UZ3tcrvmJuiIm9DWq4gYR2Kuld7RJcNv7JSkUU1S2jdKhWN+egRjYDfwy/W2KySHaoCwHF59jwvvs18dPn7OuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Y3Qm1zXG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so1259188a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723129241; x=1723734041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rAu/fAt9pD45BuwjaKWE/kC9nLY3RaeXFsWLxqTj2xI=;
        b=Y3Qm1zXGGB9WN+rnRUikO6VRXtHsRLxrwAzNrb7iZKnFAFXurxCQMBqxnLNUGQvaZg
         gWxv6fq+jooWxp5XE+u+yBu3bCgUVILpqM+8pM9CjgQEmpYwi7QGQ7YeOk8CDxZyD79l
         ZrJi8bmBzR8JANdd73oaX7LY42s5kcT1wiBykqzFg6A41xNnbor/LkV5Q+hmdwEmkrMv
         KECKGhBVC/vh+xZS+Uw8jcbhIaVHo2FA7CYYQhl/yi6v+DU0zf+6rNLLfEKigKiHh+na
         N4R99Ymmi3OtI/nkVcYTr5JyKsI98Qke5zyi0vxMX3MD4fekUVYxKsw7xlrNQiTXzh8f
         KgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723129241; x=1723734041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAu/fAt9pD45BuwjaKWE/kC9nLY3RaeXFsWLxqTj2xI=;
        b=egjDTCIrolB4n6oxeTUVs0gb85E6ch/UFHeHhmgjU50YI/OQwAXsFAmnMD6mSfDMsT
         7wJNAlnX7+548RRFcyv29AH6lZ/IqIhQor6h5YcTcc6AmO/C/kQ9yVnDgE0b8ulOU4vA
         8v8g0sZX9kx6WR8I8xGVDAn0DEb6aV0KfnH9sli0PFeDINXpKqTlS6iC2H2chNQyNNFL
         Nrac9T7AV2uTzORNK/oeNUiXpEoUpw0R6Wl8OcCFEkqMRAfpX99qbnQ7BZ5qmARECq+N
         72TCfX/42KVJN7kFQQQPNdz5T3smoMdc1sReU6dVFSJZ7o60dBlZPor9xVW/QglGI2eA
         Pv5g==
X-Forwarded-Encrypted: i=1; AJvYcCUCFMy66UlSHs9xtwGLJMS802vN7z7vzTH8+Yl46dolXFzol4Vt3HjceP4Aw5Zy0gskfsQPRX0RMAQS8AQoxlt7KO26mszrsqm/xqOs
X-Gm-Message-State: AOJu0Yxyk7EE+F4VNnTVqHez5NYxIyKPXV9rIkde1iV0nJdznmSir32v
	PbCrFsWXvuYK7OMtcAG+UM1UJie8JKE8m0abxBmpV+RRxzt9TLLh0t0THdgf2USBwEgBzXFBlef
	hiwQ=
X-Google-Smtp-Source: AGHT+IHJsIUMLs0BIicJgJK+av1Wa9E1DZrzzBCC/VZUB70rVlhYNgRsGns9/IL3QCsWu+oHUYyEdA==
X-Received: by 2002:a05:6402:3550:b0:5a0:c709:aa0b with SMTP id 4fb4d7f45d1cf-5bbb233a752mr1705181a12.24.1723129241008;
        Thu, 08 Aug 2024 08:00:41 -0700 (PDT)
Received: from fedora.fritz.box (pd9e1640a.dip0.t-ipconnect.de. [217.225.100.10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c1dbe4sm698105a12.27.2024.08.08.08.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:00:40 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] fs/select: Annotate struct poll_list with __counted_by()
Date: Thu,  8 Aug 2024 17:00:24 +0200
Message-ID: <20240808150023.72578-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/select.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/select.c b/fs/select.c
index 9515c3fa1a03..1a4849e2afb9 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -840,7 +840,7 @@ SYSCALL_DEFINE1(old_select, struct sel_arg_struct __user *, arg)
 struct poll_list {
 	struct poll_list *next;
 	unsigned int len;
-	struct pollfd entries[];
+	struct pollfd entries[] __counted_by(len);
 };
 
 #define POLLFD_PER_PAGE  ((PAGE_SIZE-sizeof(struct poll_list)) / sizeof(struct pollfd))
-- 
2.45.2


