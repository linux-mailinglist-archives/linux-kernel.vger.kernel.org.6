Return-Path: <linux-kernel+bounces-255583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEAE93427A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0451F22891
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDAF183083;
	Wed, 17 Jul 2024 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VA0ziMBO"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA5181D1C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721242686; cv=none; b=sM8P91VyoLQlBdf2HUzaUAa0+48wnM/Nj3zdqhxpL2uphY6a/Q+9aLh7oyC8ZqSdHPmKSvrkL4WqfjfXFUJH+3Bf9YXQRN4q/uquwsAQyujQJZTxPjdJQyXWokusWKOJfXcyO/iG/qcx5UExYBr1rZoBNkKAVSxzGVbyeW39MIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721242686; c=relaxed/simple;
	bh=GvwL2MamBexf2IAXlg3pCGVub/YfPtuX77A7VLpFOHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oeDUsUhkN4SGEBGxuPSGSebHIl8blf6PHQEHwi54UmsVIzTBCZ3HORTsp+NmFkvaEBi1Nng6j2COq8WQttjPVrz8oBBsHX0Z2fOn3BAND+5wRh2d4TUmpljGLORO5iMpfe7GHWyt/0neFE5ezjK+Im6wwRKZZ4KXgTF1MtcBiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VA0ziMBO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-78aeee1068aso3845254a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721242684; x=1721847484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQIyDiaE+ClPiBp80hO5ErTtgh10GYm8LU2b4tKKZso=;
        b=VA0ziMBO/DyGTT0mmDUpu75ZUYhNOEBjV3fN/MAB/zybsgxKit0cUGWDkBVNS982Fw
         Cq3IDPEbhs+rQUvj9KK1AmwSOzWU9WOczXFjGdso2uK1fhg0KhNExkx2nLiBgmeBcPp+
         lE6PE3iXz87+PKfWqnDporxAKcZw7InSlbPz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721242684; x=1721847484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQIyDiaE+ClPiBp80hO5ErTtgh10GYm8LU2b4tKKZso=;
        b=UQe9/aMUazXBx4+iEbxnma/SiI+ZJw2lfBn9HmMwvZ4CAnyTvEFOKBa9fFp7KroZe7
         A8EfEgwqN0th3Bbrh2ik+OLhir95xExx4JeeBjsCRur204UjYA4d3GvveHi0y9nhU/Jj
         EFyOq4kKwIveSeS0NXQfexA1ElmXlarB1WK+pH3Ro1CSY6R2ZGKHU2k6aGfOsHpOMyjJ
         WPqKg/j51X2ouXbv/i2H+kBY3A5AfWFwqHKveLNiiQMrXKNNF7OnyUA6mtoKtGSOISVq
         ZtOrarxw+BrLg4ef9UOPO2yp/xbQP80In5YaYZRQlhYVoah6lH8gJhvB5Ck2R9h/0Ywl
         I4DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbd/TFRGwzApqX/piNst0zwVY+QbZtNQJ7Cv/A77g1B+/Uq2wfrz90qC41Ub48p92juMcYBx0SSGkEK7FIgKvnhgHHOsNdS2hUMXBs
X-Gm-Message-State: AOJu0Yx0JDjuXH1R6D+9jDYp79U8/OVutAj7REEQ/gyhlqYxm8mRIs4D
	zDSxA2ZDA0hDGdx1nLNvu7rteIMvOrgEiPxKp3VDnMAgqhKOevlu/2W2bW55EA==
X-Google-Smtp-Source: AGHT+IHPkzahbBHA98FUgdZB5mHOIUyDg27+QzN4gYapMulyWLYICptq571PRhkgkdgfkKsYtpeFMw==
X-Received: by 2002:a17:90a:bd8e:b0:2c8:946f:5fe7 with SMTP id 98e67ed59e1d1-2cb52691c53mr2038292a91.17.1721242684091;
        Wed, 17 Jul 2024 11:58:04 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2a3:200:ba92:94ff:8264:6b34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb60145f70sm290192a91.32.2024.07.17.11.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:58:03 -0700 (PDT)
From: Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Khazhismel Kumykov <khazhy@google.com>
Subject: [RFC PATCH] dm ioctl: fix erroneous EINVAL when signaled
Date: Wed, 17 Jul 2024 11:56:40 -0700
Message-ID: <20240717185640.1026114-1-khazhy@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_resume when loading a new map first calls dm_suspend, which could
silently fail. When we proceeded to dm_swap_table, we would bail out
with EINVAL. Instead, restore new_map and return ERESTARTSYS when
signaled.

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 drivers/md/dm-ioctl.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)


RFC as I am rather unfamiliar with the locking semantics here - whether
we do need to re-grab hash_lock to write to an hc we previously grabbed,
and whether the device becoming unhashed while we're in this function is
really something that needs to be checked. However, this patch does fix
the issue we were seeing - we'd get EINVAL when thread in ioctl was
signaled.


diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index c2c07bfa6471..b81650c6d096 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1181,8 +1181,22 @@ static int do_resume(struct dm_ioctl *param)
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
+				else
+					hc->new_map = new_map;
+				up_write(&_hash_lock);
+				dm_put(md);
+				return r;
+			}
+		}
 
 		old_size = dm_get_size(md);
 		old_map = dm_swap_table(md, new_map);
-- 
2.45.2.993.g49e7a77208-goog


