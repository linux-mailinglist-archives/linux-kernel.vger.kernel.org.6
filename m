Return-Path: <linux-kernel+bounces-520276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38811A3A7E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BF83B1B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5621E835C;
	Tue, 18 Feb 2025 19:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdboW2Tr"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E761EFFA7;
	Tue, 18 Feb 2025 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907709; cv=none; b=JogmrhAuCy6BqDcN8O9h0JihpU7DSbfbUnckXhUuhXyXyK5FlU+8mg1TTStxPU+PmJg/K5yIm48LfASsh+vWG+bHWWuecCLF9leVwhit0/pqMi2nVcAaptARok2Kf2q8tg/pluSnRLnTnl02Pi/Cu86mu6vdDME7lYJ0KYb/cB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907709; c=relaxed/simple;
	bh=GMhY2X6oUkz9NAXj5l8fbYvKnOZ0XDHBM4sQNLT/xkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjcYaiYFQBzgP2ECxQczfsHEw1x/t622/Mcj167he7sEVzaUr/F+9W9+t1u5sociGD1oRAy0mmOOq5ix6CBCGtBaQEB7bkrPIY0XztJ4gD4/FHwPH4cKiWqncKW9M6c2943K047fBBANW53u8G4DT0ll+1+pmmGs1OkOahQqbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdboW2Tr; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4be76fecac5so399959137.1;
        Tue, 18 Feb 2025 11:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739907707; x=1740512507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrSeJ2SSKPXe9psA+CXvKcG3ZPT5cBDgTCavvEP5NnQ=;
        b=NdboW2TrSfk+y8e56gY/prSiFkE7XKykqtDm6K3c/xcf0EAJjF0aoMV9XKBfS0J5KR
         Cl5/xhWPuf2LFxiNCdW6/CpDA+PQQmcWJ6vjeslu8GWyzUAjVMG5NvbUikNV/VNT6GBi
         2NHyEyyTs17hxD/u07EYfoJ0sBpcD5xMpH2Mf8ukMRxbtsOD1dYevV2JY8Lq8/h4bxNT
         QbVE1Y+LtxwnIc/sz+6fx0rWqC1WgHiEmRpdQp3CcN0SALPzeGfykDXLNc+Fc2GUl0uy
         W88KXLO0kOJ5rkk+hU9YliLfBgp1k2zfIia16jdCyQUN5AEeBcbZbZlmyAmAGOK6PAyB
         6/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907707; x=1740512507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrSeJ2SSKPXe9psA+CXvKcG3ZPT5cBDgTCavvEP5NnQ=;
        b=gZ9cLi+u31oIuiP+LvkvakdZyZxNNW0+wDhcDdzQ6KRQPOfuE78Q+wepi62aMumxsO
         e2uE4cT3Lqz5ZiRcMltwQirMvZ5W6yjjcaFGE42NaUOlgDuIw0kD13NOPhU1rpgcsEY7
         vphIoet7kO/hNH3icb0Q9m4xGHTaF3bEubdz40umsZtxv0S/+XfFj5xIS9Wk51LsouwC
         mrLcCCN6RsWtSi+VpZD0r5WExu3q2I/CJRndTV/oChCyzXVPxYCmgrMp76y8VPM8KbFB
         LBitecHFOrjICDWba/trwL8De/GEEqPeKPZ3agX7D4pHmiUsOKnbu1RBGfZek7J8+qMv
         NDfw==
X-Forwarded-Encrypted: i=1; AJvYcCXTjNF20Pp+tljTgnrXOgPqhkX08hZI7+4qD3YIKG9Ve6ZcHGdbp2QAlyT2nIXk594WORsDdlnUFziy/H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwACT8Z3lzemqPXJ5xJJJ1JQFthY5cn0gL5efeBbOWrplyF8KxQ
	s2SBrtzOrrOo5E7aY0kUU7akRgg/VfMzIk7LlXAGREITDyaOBYI2
X-Gm-Gg: ASbGnctPQXVwGxcRKcNfpHGfImlyyuaY2RZIJXG2J6VB4vKes9sW5FWQNp7eMSXVT/g
	IiUg6t85zyIMLYNV6R+Kf5UE2r2xPJXdNYDNNLXNBfVOBgxO8JOLW5WFWfJP4levsDOLICiR2Qf
	I6ZoarniV089VXAX2ejBWmG24MVux9SHOpJZ+eW1Z/jBPX96+qX2P/QOCQwXlIifG5rq2Q/PNnD
	WKvEMhXiEjcWC+mhn06qukcFcgxK148+R3OlbUjpJ9TK6HPhNjdJhMJ8yT5+s3Sfb5CVg1I7OVZ
	VDmudMZjlWQASquHxN8zLms=
X-Google-Smtp-Source: AGHT+IGJFLMla5373xo+8cLotDHzX6Nxqhx2kzLdmNkFtOjJ/5PGdFOMf1n3hDNQa+8VqFZP7cHPAg==
X-Received: by 2002:a67:e70a:0:b0:4bb:d062:447 with SMTP id ada2fe7eead31-4bd3fc61509mr9227291137.5.1739907706734;
        Tue, 18 Feb 2025 11:41:46 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bc68dd766bsm2305214137.20.2025.02.18.11.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:41:45 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jithu Joseph <jithu.joseph@intel.com>,
	Ashok Raj <ashok.raj.linux@gmail.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 4/4] platform/x86: intel: Use *-y instead of *-objs in Makefile
Date: Tue, 18 Feb 2025 14:41:11 -0500
Message-ID: <20250218194113.26589-5-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218194113.26589-1-kuurtb@gmail.com>
References: <20250218194113.26589-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `objs` suffix is reserved for user-space tools. Use the `y` suffix
instead, which is usually used for kernel drivers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/intel/ifs/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
index 30f035ef5581..c3e417bce9b6 100644
--- a/drivers/platform/x86/intel/ifs/Makefile
+++ b/drivers/platform/x86/intel/ifs/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_INTEL_IFS)		+= intel_ifs.o
 
-intel_ifs-objs			:= core.o load.o runtest.o sysfs.o
+intel_ifs-y			:= core.o load.o runtest.o sysfs.o
-- 
2.48.1


