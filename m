Return-Path: <linux-kernel+bounces-290804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033599558DF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9744D1F219DB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6BD14F9EB;
	Sat, 17 Aug 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He+K4Xt+"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17CC2C8
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723911637; cv=none; b=L0Yfk/KpHShUYSNy3MJoUucA4e31xr5YosmbUx+k1AANJqyYQSBSrkonD+CsNIgc64bZw5TFu7ARvHk3O9xmIxoQd1ZqJAhOsBT8DyF4f93Zg18mQErX0rhE4fbmg+g5l5A7tMQW/chvXckopUpyKaD8DUgWnXtvQpElgzSSlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723911637; c=relaxed/simple;
	bh=Btbe2UXpqZi2jI8wR8MRekm6MjW4u/jFsxjB28mjjEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4zcVW4dd/R+1DtEuHMxW0hmYjVrmFqt/ny9JecliziXlmnm/DmUUD4XaQa2xdewdLt42r8xE3EVrXYtnLtA1EyHAW+SLjisj1HbBShJpEMXpKfcSGLzftVpQ5MbeLnjySQeifjfkxEJc1pYVGAuN+L/gmkgsnSrF5//WScKC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He+K4Xt+; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3dd16257b7bso1018235b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 09:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723911635; x=1724516435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kP1WVQQ5Bv5vxEC3CBtv7f+mOuVDTnPEQv3oVhBSEyg=;
        b=He+K4Xt+yxUsNNlYvqK+FmfOQnMhQGK+ze6e3cp29DB7b3yEAiMROlUckr3aNK2iao
         mDiE4MYKnFwv3C2FsRj+RzaOJ8mN67zCmPpU5ff6OYJKKIbb/i7TlgHD24mMHbPlc9Lg
         6TJtDbOAxV6pOT5AhfMk90ioJBBi7pXxSMm58bOEDfj6v1TJcXdv+VnTwrXbJwDmesc1
         VYOq+Nt4geNLxNT0ePgrdiXv7NKt8Rlec/zJ+70azamFAP6L4DsPRqj8nQaNWWN73YMu
         5RAKuC5xqjskidCQ7b26WbrGw6lfjURblTfzHPFL5kPkOSBF+EWgigVpNS6pcdNxw5Ny
         e9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723911635; x=1724516435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kP1WVQQ5Bv5vxEC3CBtv7f+mOuVDTnPEQv3oVhBSEyg=;
        b=j7wy6ZawlCKwBGlK8aMiPdn63v+AgDPScc0A07+j63ddlkyKYkKWlYw8vkZZaFJUff
         w3KY+4h5KUpEhHUIgPY9tiTL9VHgtU6l09Zfx/Wxi03M9U1gRWpwG5oIoQA7uHyih/Mp
         HA61cXvj/xLShAvqD03HM8RYMLp431U0Urax47Sa/2hKTBBsajcQVaVC0GeCjxnZx1b0
         VtYWP1BDrwNj/L0eLM3LJORC4G4L+CTa4flFDNWMz2YYzqqfcz6Mk4WftxYrPLvQm28l
         ++Qrd1YIojj+YAAQJxj6lwY3A1ArLvGzkHGgTVvT/qqyve6QNZb4YwasgWo4bg5oGWKN
         dlgg==
X-Forwarded-Encrypted: i=1; AJvYcCV9JShz2TVqtozbrDUbmvVF4qo34ShG88DQzl+d/iZHX/Z2PwrUQoLv8UT1mj9q7MU2Hh5BZCAFexu7SO0Ev+tjaPuM5oPiR5Jmi3yL
X-Gm-Message-State: AOJu0YwgpQjwd43y59ponwR//B2oV1z4VKG+2fCmI1uBrz0DIge3nAVv
	SqRGwJM6QOovSkOOZQ52iS/1+DmaPn4IuedpTqMNP9m01ij2d5H7
X-Google-Smtp-Source: AGHT+IGtnjHFRx3Qp4aKtlGFHGnuR8QNSWs2lim3Z4YbIn2a/1+v2IR7KoPlS+OHSEswXtNKCPILhA==
X-Received: by 2002:a05:6808:1911:b0:3db:2afc:b19 with SMTP id 5614622812f47-3dd3aceab17mr8169782b6e.12.1723911634629;
        Sat, 17 Aug 2024 09:20:34 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61e799asm4258049a12.44.2024.08.17.09.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 09:20:34 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: ltuikov89@gmail.com,
	matthew.brost@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Initialize symbol 'entity' in sched_main.c
Date: Sat, 17 Aug 2024 16:20:24 +0000
Message-ID: <20240817162026.84761-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smatch reported following error:

'''
staging/drivers/gpu/drm/scheduler/sched_main.c:1063 drm_sched_select_entity() error: uninitialized symbol 'entity'.
'''

The symbol entity is initialized.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7e90c9f95611..dcfd4d0f7c6e 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1047,7 +1047,7 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *sched,
 static struct drm_sched_entity *
 drm_sched_select_entity(struct drm_gpu_scheduler *sched)
 {
-	struct drm_sched_entity *entity;
+	struct drm_sched_entity *entity = NULL;
 	int i;
 
 	/* Start with the highest priority.
-- 
2.43.0


