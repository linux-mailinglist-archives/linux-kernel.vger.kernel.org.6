Return-Path: <linux-kernel+bounces-255780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D9F934504
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1CC3B2292B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFC756766;
	Wed, 17 Jul 2024 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BfqWwxKq"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A3379D2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721258440; cv=none; b=LTHlx8QuW2O/HCNVJhFm/jdX/JBRoCGec4r2U9IDd3z/QPLjcgTYtfUNtUS4bYF/+6FtNl8hExMBoynrOATnqcs916bsg1rSOwH6Nx5TeXOyu8yiQOt+y03FKXPj1CeBbHJEG3AgZoNchSGZxsoJorYbHjtlnv9XYmFgjOnKA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721258440; c=relaxed/simple;
	bh=alkn7u8DptvmEkL2WvLNybsQ9pA+gLO09vP+UQQNaMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBoqU/pUHAldrz9pYx+9G8T+aiCh1lEBLok3omAmTrf0RFxSKzg9TcLBPGZKSsZNXwoJmcCxpNTTzaLxQx2DM8qxcaXhV9nGfIp6EKxmTbFM55urhai3PFKhX8crk6nDJAO/CHFLZ8Bn++i8mF1zY295CAF3M9svpvXbg/C/u8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BfqWwxKq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ca8dfa2cceso157150a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721258437; x=1721863237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJ4Rtgfw1crxH82KHr40tMf+xK9HrNqVoA0f8i6QWg8=;
        b=BfqWwxKqzpWlfXe3JFQ8QSqs+t8QUb1R1NbC4OznrQ9xJk5FSRUtQH0MGeIjG12vE+
         eI9GpbS34YcTMPZQZjM5U6yCJ+r8CKkfA9wt3NcVXdkACGZXen0B+wGKLCbd8vO+nKOM
         PaV8aZRz6l4+2q3/iHFxUnsGyLgG218ThZWMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721258437; x=1721863237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJ4Rtgfw1crxH82KHr40tMf+xK9HrNqVoA0f8i6QWg8=;
        b=N/gw01+i4EMDMl0hKZpCupSZt03eR1080U9CtMURmsZhz4Vj+HX1MjW6x0SqWFPv9s
         gYwRA9NwMDSls9SaKKbCF54sSgwzAcKImBOp2ldjcLWgPq23aHrjnd5ay3MN/KlNBGhE
         Ouvpbhs+FGr7tRNDOPm4EwYk14SEj33Qa6hhb7UUBzAI/B1vJRd2dSj/Bb0u8G7vhrs+
         Kzssr43Ar2Lo1iQHUw+RFtB5Piqw86jpcSNJqJy57Fc08SGMxJMcixxp9eXzn84BDw8Q
         pQ0jIEIn82PFGcrQeVUdkGKbBXFtus1sDgmiMUDXRrcEFOx/oAeRGE39Oz3gJa0wDgfb
         XFug==
X-Forwarded-Encrypted: i=1; AJvYcCVgAgVjhW5bI/9X4rfB6fWSSmmZ07e6xhMwgSMcsAQ+Ls+uyTWPZbHQmnD2RkWZFnXNqfgnhTblxtNvRS71eoWT3SOt0nZHctkOJnIw
X-Gm-Message-State: AOJu0Yw3N0LK++/UtTbrwlXcye47c7fEi30Um7euf5O9tzdhukQ44oSN
	+YCfYxnBKCMmAM5AdC3zevdNHiJ8449qSkMjQVQlsX7mWJvGSb+WvGokb9+D+A==
X-Google-Smtp-Source: AGHT+IGSq9WFJ24jFHe7nZE5xQPf4XbD2c2tgVy5+rSjm5TliJ99S5ZpUoONUIfw0XUZLKuOlJXl9w==
X-Received: by 2002:a17:90b:a51:b0:2c9:7803:1cf6 with SMTP id 98e67ed59e1d1-2cb527a1155mr2419597a91.20.1721258437108;
        Wed, 17 Jul 2024 16:20:37 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2a3:200:62a5:b19:9711:d3a6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb60219d21sm510034a91.53.2024.07.17.16.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 16:20:36 -0700 (PDT)
From: Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Zdenek Kabelac <zkabelac@redhat.com>,
	Joe Thornber <thornber@redhat.com>,
	Heinz Mauelshagen <heinzm@redhat.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Khazhismel Kumykov <khazhy@google.com>
Subject: [RFC PATCH v2] dm ioctl: fix erroneous EINVAL when signaled
Date: Wed, 17 Jul 2024 16:18:33 -0700
Message-ID: <20240717231833.2090430-1-khazhy@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <CACGdZYKbdyALADEMDV+Vg+eog+UjjgGigEpmJTSKw_64RM8rbA@mail.gmail.com>
References: <CACGdZYKbdyALADEMDV+Vg+eog+UjjgGigEpmJTSKw_64RM8rbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_resume when loading a new map first calls dm_suspend, which could
silently fail. When we proceeded to dm_swap_table, we would bail out
with EINVAL. Instead, attempt to restore new_map and return ERESTARTSYS
when signaled.

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 drivers/md/dm-ioctl.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

v2: don't leak new_map if we can't assign it back to hc.

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index c2c07bfa6471..0591455ad63c 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1181,8 +1181,27 @@ static int do_resume(struct dm_ioctl *param)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
-		if (!dm_suspended_md(md))
-			dm_suspend(md, suspend_flags);
+		if (!dm_suspended_md(md)) {
+			r = dm_suspend(md, suspend_flags);
+			if (r == -EINTR)
+				r = -ERESTARTSYS;
+			if (r) {
+				down_write(&_hash_lock);
+				hc = dm_get_mdptr(md);
+				if (!hc)
+					r = -ENXIO;
+				if (hc && !hc->new_map) {
+					hc->new_map = new_map;
+					up_write(&_hash_lock);
+				} else {
+					up_write(&_hash_lock);
+					dm_sync_table(md);
+					dm_table_destroy(new_map);
+				}
+				dm_put(md);
+				return r;
+			}
+		}
 
 		old_size = dm_get_size(md);
 		old_map = dm_swap_table(md, new_map);
-- 
2.45.2.993.g49e7a77208-goog


