Return-Path: <linux-kernel+bounces-271080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F1F94493D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B8B281024
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FC5170A37;
	Thu,  1 Aug 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+vHRPNR"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B7446A1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507825; cv=none; b=NJLSwNDX471kXLiKQq/JgWUI6lDL0PBypQjTOh28guoFCgJZpJLrC2UiPNGBJA+LbxfMHzOKeI5FdWl9epv2uQzNkuJR0dKu/3a5opkHlgTnZ5VCmY0bIpFNzUrLJE05+1cyrBT/5OF4BIAj8JdS1eScYk65OMq8HXyQ7AeBUE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507825; c=relaxed/simple;
	bh=4dPukRyItOSIobx4WPsZvXe+nhAZ38RPLUln1mL7Ljw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ls6D2p9p7ljXzgKCQrpDtaGy6h2lMc7jUi/xhbcW4uUbMA3o58ecZ+GmvVz/wBMbq/hBUMaKinGTpxaNf9EQl40ZMcnhY/06VSXYjOi0+B2rUJucsaVWBNClBjlXsKmHhIpS4iQNny/eNbGv3EsvKlQAuoo4eEIe6kKVbgMlYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+vHRPNR; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7093f6adc4aso2600734a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 03:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722507823; x=1723112623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xy+YnBW0pTnJouWOqXyQ4NXMUNDJSPyAsk2GdSuKUs=;
        b=K+vHRPNRHe+GjnrnWhINVzYiVyWGQApULUAur8I5s8hmnqif9/i2jvOHpYsS4qo6Og
         9c+jmSxMiUUlM4ktGbu0/5h+6An2sDwNl8XTgDylR1nQ2o0Ika7jqdVPdmvROyGgZo2b
         4+1g6nA+93Oz49JQHHRFSsniymmsTusI6QX2ox+p4Ix1EOFqcDdl682iRGTZVefetUbM
         3Vww0offez6Ytd1zcZYcjpWZPoEuW8TVFMEbTetkD7bO0nT1a6uCTrzKCKdO/d4lYuqS
         gqr6c/Emm8EKe1Fvdz1vwLXn0GDuNCmYrIF/n/QAyztBB1nQj8E2uHcrDuni6R/T+JYb
         opsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722507823; x=1723112623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Xy+YnBW0pTnJouWOqXyQ4NXMUNDJSPyAsk2GdSuKUs=;
        b=OLJ3W8DkjxEivAWAlLffQyElAvC0ytLTZz6C3ulLbtRwdwxFiVUHf50d8GVNhdpx5l
         JzxW4Kb1XhNmb+69iw3ZEDjDrPXNLYgkPJanNysAB2lDUqFroSgqMLbOjXULykVSeoN6
         5yzOFrT1pk222JowtEia1ZTdonal9on/L3s6XNffpf9JZ5j7wcXzcmaGuWCFSFOYndMR
         teo/Wlj7uWZx3ThzZ6VGdQAOj24EfR/IffxVXLKOe3V8rL6hcyO18d4QxY2+2pBRR1Kk
         GtNyKWEMF4pB31uzKi7FLR6XcrY6W8j1yFIuegRNO4flFCfbN0jR+oAtwWBDX3xM1CeK
         AxPA==
X-Forwarded-Encrypted: i=1; AJvYcCUtHahzueapm8wMs5ZKYVaSkULIclTR6I2FqeqPADfUpx052TgZVoU+pSDaSD8VJMHn5dK8KKgCyQh6NYZadgyASzM7J4m6aneGjnM3
X-Gm-Message-State: AOJu0Yw9LsPySPu+CV8+rdrhpFqW8ORnch3IYtVaXmTI2r0V4b7wNAhc
	9AcJYqQH4uQSD0RmtRSOufeB/kaE7g1HANiK0djpFWVN9Sbr5lJK
X-Google-Smtp-Source: AGHT+IGIxxlyoDeUzX/z3mgluxeTtIsYQBu/I+K7lGL6G4vz4LFvH0ndqW0M6bE//iHQUiAIGFmFMA==
X-Received: by 2002:a05:6830:699a:b0:709:4936:d8fd with SMTP id 46e09a7af769-7096b882b33mr1996037a34.29.1722507823183;
        Thu, 01 Aug 2024 03:23:43 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cb4:cece:78f6:191b:3e2f:ac7d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a105bsm11186351b3a.194.2024.08.01.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 03:23:42 -0700 (PDT)
From: abid-sayyad <sayyad.abid16@gmail.com>
To: airlied@gmail.com
Cc: daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	abid-sayyad <sayyad.abid16@gmail.com>
Subject: [PATCH] drm: Add documentation for struct drm_pane_size_hint
Date: Thu,  1 Aug 2024 15:52:39 +0530
Message-Id: <20240801102239.572718-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed warning for the following:
./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member
				'width' not described in 'drm_plane_size_hint'
./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member
				'height' not described in 'drm_plane_size_hint'

Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
---
 include/uapi/drm/drm_mode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index d390011b89b4..b581d384d4b5 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -864,7 +864,13 @@ struct drm_color_lut {
  * array of struct drm_plane_size_hint.
  */
 struct drm_plane_size_hint {
+	/**
+	 * @width : width of the plane in pixels.
+	 */
 	__u16 width;
+	/**
+	 * @height : height of the plane in pixels.
+	 */
 	__u16 height;
 };
 
-- 
2.39.2


