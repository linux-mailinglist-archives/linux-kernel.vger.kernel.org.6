Return-Path: <linux-kernel+bounces-390788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320DB9B7E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5FA51F219FB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D171B3727;
	Thu, 31 Oct 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="CHA0ncml"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D41B5829
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388542; cv=none; b=EfwjA+VUGplstzrz/3baGzdWzuRdAxQqgcUptipZA2+OnihzaJxsH1rhlKruzfba0BYeE3B8z59qeZvgBapqCH0aRG1nUtTqBuFrvYGtcqEk6oDOXVmrft+BnYaIWB+OixZCw+xXAO42Zbrf1BkaTlicswEV7Yf9xxTxzedmcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388542; c=relaxed/simple;
	bh=ka3siW0GtX8GNcnMQC8SnoezRdFtH6Do1ETQA8Rjizc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cFgb5vdVD5/6Q57mPADFPTU6/LqN2FxTCfXUVCURL92yM7IkRboiK/a9Yhgr/L5TYFB/9DK3O6PIUJsozn7lFbT4RHwcJViTqbzU2WRWgQfSJ94c+K6cyQZG3H371ziuowwjMhT9SgTu3+OGwmKaNLwpBIpwJ5OAmp7rhqJaEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=CHA0ncml; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315eac969aso6669955e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1730388537; x=1730993337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rpxd1Wa3OWeEEx8H8WR2xSUmackvwxeKQOHoyz3QWko=;
        b=CHA0ncmle1JhlNnPFwqNyY22p5H1sAik7o8QifmwSezd2ChJrT4btxd9nXW7cgmq/c
         Wm9gOTFpOTpMcyrg3e1htwMsLSxwQ062O+y63LYx1KwnUNcPEwKs//TSKYBHZV5btpKR
         azzNuK0jyZdwEuqXPTupTA4LEZ9OzrWmV20Fs15ORAVK6QFqChhGopJO2QkxYDMl0w/U
         K7qiIejDxqMIz65omWH4tzzs4SfWrAN1i/cwGAnNqn14VqOodgmFGMzISaMNAiCx7EXC
         VMEwlT9ywx3DLm8FH/Eum7ob66Mw6c4tZwuSQOM9zGSHCJisJI4UUPJnWxvuRydd6PSd
         545g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388537; x=1730993337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpxd1Wa3OWeEEx8H8WR2xSUmackvwxeKQOHoyz3QWko=;
        b=Gh2iJhNdXkVX5YEja5upgKyZsG0tu6HUageQkEHPJYIBqCzeCEELD8v8O5/n/o5Pye
         g2EY2F7uSggIJ9XpPAqTgOuiqvVeeYfdxXKR+HSRAfbXqXd2TEmgpjhnBchHxY8EYn7P
         zh8Kb11tgmIslRiq2x0TMjD6LBvaiHlBF61XHtspF6v4/s/xlFPJWy4zyQuqQbXvspHL
         5prO4N1QutgiDAAORwwOf133fn/1PcgmAi6+HnLG6V6cvaSlD0U+ah1uBSVFlPV03MCJ
         Q9eDOqWuMgGEQ2iI+iT4cKPGVCLfC6yZmYQOxBR2XrwWDP8r73R2J+TQFPn07lCFcaSJ
         mKbg==
X-Forwarded-Encrypted: i=1; AJvYcCUSCyExqMlfwBJzN45CHSeCxI710HCwmPENV08U/T6ZdmemLMtLhGmm1NrmFdbIYlIRf2hJibNEsN+nYAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxreIjQpuGW7whjCk2NB9vBVBOoZOb/yfeS5hTdILo9/E6A1xIy
	cZZ4oT2GGsrJl69Ggy7y1NuwKKkCML3oIqmVM2MoERaTfUwgdnmAq9nCwxh3sMA=
X-Google-Smtp-Source: AGHT+IFoBxKsLoz39uPKBv9j+HXWXkAGIl612NqZQoe4p4s5DLp2XLQRN53tAbxQ8nsfJYMNkdC38w==
X-Received: by 2002:a05:600c:3b2a:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-432830a19b6mr3477095e9.15.1730388537243;
        Thu, 31 Oct 2024 08:28:57 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:634e:2582:d0aa:ee79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1189118sm2449976f8f.116.2024.10.31.08.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:28:56 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	mario.limonciello@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH v2] amdgpu: prevent NULL pointer dereference if ATIF is not supported
Date: Thu, 31 Oct 2024 16:28:48 +0100
Message-ID: <20241031152848.4716-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_evaluate_object() may return AE_NOT_FOUND (failure), which
would result in dereferencing buffer.pointer (obj) while being NULL.

Although this case may be unrealistic for the current code, it is
still better to protect against possible bugs.

Bail out also when status is AE_NOT_FOUND.

This fixes 1 FORWARD_NULL issue reported by Coverity
Report: CID 1600951:  Null pointer dereferences  (FORWARD_NULL)

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index cce85389427f..b8d4e07d2043 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -172,8 +172,8 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 				      &buffer);
 	obj = (union acpi_object *)buffer.pointer;
 
-	/* Fail if calling the method fails and ATIF is supported */
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+	/* Fail if calling the method fails */
+	if (ACPI_FAILURE(status)) {
 		DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
 				 acpi_format_exception(status));
 		kfree(obj);
-- 
2.45.2


