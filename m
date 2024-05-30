Return-Path: <linux-kernel+bounces-195557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B67598D4E80
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DF3B22D40
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D428517D892;
	Thu, 30 May 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ukpzFHxV"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827A186E5C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081127; cv=none; b=m0Ll2KAnZuItUmOhZ7w66pme90b2ZyV3KYUpR1oc0OsD68VchHJRpUGeuwEyelXGkJ4QKBtwzWwf4S1/+0AmZ7jKgvI8YJ1YtKQVGUpybpYJUXCjjDk/a+4eZLjHs37fEbTaY0CecvP3pKlsC0wkos3oPvGxqm5tQ/BFszHVYGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081127; c=relaxed/simple;
	bh=sdD5EKvPawDfwF33sGxeusqZlqiuH15jx7QlM/a78pU=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=etHI6cXzigntheGRHU/QJi4RG4gfxFUw1a845IycCeq84U+Amd52dioKDIOgKvTFMuD+RK0St8lwKDLLp0y3xblwfmr/oXwD7Wwo0m4rX4fKoz8+gWHiMpoZSU/XnJDOIRwY09m/KgRi0IqCM9mu8OkOVFO8SgA5/hQJuHhEqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ukpzFHxV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f62fae8c1aso620425ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717081125; x=1717685925; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=l5khecYMdKDHw89iJpsW1yiXKEfGunwm3+6Z9OsK0so=;
        b=ukpzFHxVSgxINPRQ7Si+DPOVZBMyXrt5b3d6ycfwB56rvGeUiX4s6JPM3P8eas05p6
         BVicx51UH3pnosWWR6TqqDaQECVtUJzXKLl86JcbmKPX9U0vU3I21+XDMVoT5NoVVpDe
         x8wUmzsOjvUaEiLFgIgZiQSq2WghFlNNahzl8vvLYckamoiyydc7e4M8xj5buPemQHQG
         gWSViWRdh5mgJWyJB5gnNxXjOjw2BCe7iuwd602yzveGDw8GYuBlJmN1Y2FWSttn9Q9g
         fY1bkRNeUuV4Kiv+iKkVbKJ81neNsZBV0vaW2sybSGPA4jKryCr8KnLlvuvGck6F8/tq
         /Yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717081125; x=1717685925;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5khecYMdKDHw89iJpsW1yiXKEfGunwm3+6Z9OsK0so=;
        b=Hug3uV3yoZx0qdXBGLHmKBdDVv8J68J6vH2+Heyj89XUhRa8b1r7l0ZkyoFOLIsHQt
         JnCWpLZ1Ujay8lfiB4/UycgJ580rJU7IxnaY2anXk+JtMp2IoCgn7AZeLpkJbY2yQIXr
         LMfWbB2yZEBfMR6fpWd6V0Qey76LX9Sp6vWGxVOWxVryN3ilojkG82f25knlDcuB5lS8
         1tmVVj+zO0Y4dE+M6+H/bYHItkszB9eZedJoVgBb7LdA7Ch9pSn4AGjmFXP978USu+9x
         FG3zaqpUhmPkFypTRsoXVWQII4Eg570aF+0olb5Lt2zLMUCfDp2Clytm6q72Q9q38HMr
         kAyA==
X-Forwarded-Encrypted: i=1; AJvYcCXAHmKn5JPxUd8MdtPkaAIOq9WFardf7JaLlVWUs2Emae+oFFN7tPd0YOIpkGQiH8DbU1wltJ9rK8oPx1mEQo90uiJl9epxkLANXYdq
X-Gm-Message-State: AOJu0Yw51fGAnL2adARMpndFC+4T83IIwBRJ2BG9IHhRjJGFGXZRU8hz
	qRYW+svdRPEA27jV2okaIGOda89pp+Rg8G+mXnA5t0WNWI+AWlL/QFe3vrgDlR8=
X-Google-Smtp-Source: AGHT+IEKvEjoLbbrN4JdqK6X02tKZ1Vg/fjeNLYXxvvVYtupVhUWAkZyf5sli6+XANrywg1P87S/sw==
X-Received: by 2002:a17:902:ea0b:b0:1f4:8190:33a5 with SMTP id d9443c01a7336-1f61a3dd9ebmr24276305ad.56.1717081124823;
        Thu, 30 May 2024 07:58:44 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967975sm119659155ad.152.2024.05.30.07.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:58:44 -0700 (PDT)
Subject: [PATCH] drm/amd/display: Increase frame-larger-than warning limit
Date: Thu, 30 May 2024 07:57:42 -0700
Message-ID: <20240530145741.7506-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
  christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch, Qingqing.Zhuo@amd.com,
  nathan@kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, hamza.mahfooz@amd.com,
  chenhuacai@kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: alexander.deucher@amd.com

From: Palmer Dabbelt <palmer@rivosinc.com>

I get a handful of build errors along the lines of

    linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:58:13: error: stack frame size (2352) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
    static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
                ^
    linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1724:6: error: stack frame size (2096) exceeds limit (2048) in 'dml32_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
    void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
         ^

as of 6.10-rc1.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index c4a5efd2dda5..b2bd72e63734 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -62,9 +62,9 @@ endif
 
 ifneq ($(CONFIG_FRAME_WARN),0)
 ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
-frame_warn_flag := -Wframe-larger-than=3072
+frame_warn_flag := -Wframe-larger-than=4096
 else
-frame_warn_flag := -Wframe-larger-than=2048
+frame_warn_flag := -Wframe-larger-than=3072
 endif
 endif
 
-- 
2.45.1


