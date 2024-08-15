Return-Path: <linux-kernel+bounces-288468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9B7953A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64822B23666
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438BE5B69E;
	Thu, 15 Aug 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqJWgHYS"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0AB41C65
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748199; cv=none; b=lUc/ANCXPT81V9KiW7XbUtZMn9rIOP4rD1YiWhLXrC3OlMhGzBTsUje+4R1n8Fp6f9wYE6aIjMpmZmFymhP0pw9TM65OZ4G0I5dPF6CDEQ6gAkVdym8cEFsEnTpFBHgkd97xegRkYd4WispsvSQYe0GdbYIhPgum74LPAqHIiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748199; c=relaxed/simple;
	bh=AzsKD29AvljJ9C14uJBkqsOIiuWUtfGYYyaoIXf4iyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYO4JYO5BhftlSsbFFnjG7ic0at6WpkLqqUjOa2/aFcRlnupLMGrYGP6VAwNFBZYd8RVPwYW2E8VSJuZg0lg/KC9S7pefZTCd0BMWL8bzUmAp2bgk7nlHreUEeN6DRx/cVtkk8/wKgeKwgSWVRJGWJOFhHk8wIjYSAUmFzhsxHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqJWgHYS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7106cf5771bso1052789b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723748197; x=1724352997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P2ijR5sS9+P33OT+BK82QSH+TCaValD97AwdFX5nob4=;
        b=jqJWgHYSnfbCbdhSOAN7NWpEtFaQbtQqnxXHPFGUtztTyVVSCpCeo5iDBLJPwmMpDj
         4yTXWdkzASzaR24Db3P94bfpWF8svJmoVJY7rQz59DQSR1YmcA9ncKaR+u2aR1cZp9Ms
         NDawY4i4LLo27nBaJDjQrFODpamZmpZB22Q9QUN9YhYwcG/EjNT6N3TFBElOX0JmJ0i1
         lA3dhT7dwLQJTi6WzgrvWWocmbQz+I/jbksdrZydXSmCA09/8DoRu5AXHzlvvHenpCly
         jMMO4WvlW8Dbm0BeopYNHF8XZ8eOLWiYUtfdnGCh5YQjvlAGuw2IwDORwjqKTC/pwykH
         JZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723748197; x=1724352997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2ijR5sS9+P33OT+BK82QSH+TCaValD97AwdFX5nob4=;
        b=GFo2l8isN8XbnV3DUBkJ6R4mgAKXtG/W9SAiryHrGKdvMImN8pc95SitMBMC2V5wYF
         kVMatuMRx+5RO97IBz2/iKTmQFQU3K019gaw60yrOTshCt3q4m81DwgiVptCgRnxAT75
         mjuWZ2H6DqBohboOjQ9iu6Jt7T4x+SxqI+dHx5IgQRSeoEteNDZ5dsI598qs3ssK8rUE
         IYcgFoWm8Tl33BNPNPYMv6y51UWXbJHOFQUvRl7WV2aID1C7negWan5F15z4h5qxHRgO
         Znk5bfkRE9fJUyxJJSf26oh5US6yd4B3UOVBKjOUCksDXS0CD3lk9ZXYs34SrfHZqcHE
         Q55A==
X-Forwarded-Encrypted: i=1; AJvYcCU6lovxo0ZJcZrP0F3p27CiPbAYAcoIVbGDyF/KtkQDwz5FeWvQVhHGDR+WIIKgDQo+B+UDrnamrakPdIG8JWuhxKBJ0afQO9LTFDeB
X-Gm-Message-State: AOJu0YwHT93JrNtaHmUSvUladcEoHJ++L6mspqpGE+xPRpDmug0qSB86
	jFWaxZ/NibLkj1ef413x7bxmTcDmKYoBMxNIl6mi/9IOAWBab2N1
X-Google-Smtp-Source: AGHT+IFwYGOOjKTUC0Iff1yvkbw1tOY+wLVqX8NH0HF16cxeKgHLMG2BxroguqvE3YR036a9umE+eQ==
X-Received: by 2002:a05:6a21:648b:b0:1c6:ae03:6607 with SMTP id adf61e73a8af0-1c904f742dfmr893637637.6.1723748197433;
        Thu, 15 Aug 2024 11:56:37 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61a93aesm1448242a12.17.2024.08.15.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:56:37 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	hRodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix warning: symbol 'dcn3_14_ip' was not declared. Should it be static? in dcn314_fpu.c
Date: Thu, 15 Aug 2024 18:56:27 +0000
Message-ID: <20240815185629.65725-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse reported following warning:

'''
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/dcn314_fpu.c:36:30: warning: symbol 'dcn3_14_ip' was not declared. Should it be static?
'''

Since the symbol dcn3_14_ip is not exported,it is declared as static.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 21f637ae4add..b7463e70b6e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -33,7 +33,7 @@
 #include "dml/display_mode_vba.h"
 #include "dml/dml_inline_defs.h"
 
-struct _vcs_dpi_ip_params_st dcn3_14_ip = {
+static struct _vcs_dpi_ip_params_st dcn3_14_ip = {
 	.VBlankNomDefaultUS = 668,
 	.gpuvm_enable = 1,
 	.gpuvm_max_page_table_levels = 1,
-- 
2.43.0


