Return-Path: <linux-kernel+bounces-339765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4B8986A40
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AB01F226FF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 00:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC316B748;
	Thu, 26 Sep 2024 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHugjOrU"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4D1D5AB1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727310414; cv=none; b=AIbW+guKOY7Hqa6bRb+4r9FsKk6ezuFYYm0pgpfO8a+fnvhUCDYrRpVFSYtwSPzdQXmEGRel/MaOf95Dl3WX1nm5WgRJM2QOWnaYSwvjJyZKwVSm8lMXZpff6vUVRh2S7nvuzfWWeUCysfXl88ibCuheCMf13tvppnrRkUNR6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727310414; c=relaxed/simple;
	bh=eAiQtJBAcrSyMxCXhV2DPYPjQFK0zG0qlWB4H62qWwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMDSDyZFZsNw5LjUpILH+5+4SG7xEij2Y4KBBnb8u8IBdKfCqWm+am3uAOkuFOLAPH6K6lUqylrc1is0F3NaPL1v6QFRvBrh8y5YH72mRNPLc2GTkTfsI3TbVg0v5IO/AqUUeS9UsD4aktSQoc1jD+nPq2Svr1nBvFMgCn8Sgys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHugjOrU; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a0cad8a0a5so1905435ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727310412; x=1727915212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4h71KNl97QvEZ5noXaz7sknDoxojg3IEoQ/oR2jE0tY=;
        b=LHugjOrUZqmfPad+xut9Ku2Urb0AFO8bWbC9k2OKVZM7KNk8pT9rBFttVhvZ0NDi55
         rTq96wLEkFD6n01hNPVLsIU71h5JPkDuk8cMaLvyaQPBuc2H2pO5D3ebLURm8gbvLG4w
         cLEHWXBvk5E0MYJ54icGySUfEGemt1SPoYIVjp3yFr3A3u5AMbNiNLecnQK/hebDMjdg
         yw898T2r2nxMu4VH+x8xYdNPmXjiCqYIsEYWRFRKIb+Er3bUjeo6PspAodqmEyFeYRsF
         ceRyTmb+KkWnub4L+IK5mLPgPn82ibQKI19HzJoYGI4aJQ+FLcVLOpPuJ7qaE2tbZXSc
         ZGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727310412; x=1727915212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4h71KNl97QvEZ5noXaz7sknDoxojg3IEoQ/oR2jE0tY=;
        b=rAgePpBabdA5AmGSh6pXVFrjOlbtKVKsuln22rDX5GjLXCHzjgEUgxpFX205mpjMk9
         7wx8dNIsXrgC/GqRJD5ukGdUGncxi399ygrhIHzrFvSeELAxBXC2eGiiHQilw943J5ES
         9aEXTomfZRcHw64ZSP3gvDeXEwsRGL+7tEY2KC1q4fUBYFs4z0A7sTjVwkkdEJpSQK8G
         2eLkRSihvZaOlfAHH6V83mLaZokGkqToyqo80Vd9v5MDc4iYER+EIRTsbxPIAzA3vKWC
         r/JVUfDfJJ82IkMrIhTcpJ4mEsu5vlUXqlLC+DlhZofBEFceZX5AbqV7MNGjeYUglg07
         95AA==
X-Forwarded-Encrypted: i=1; AJvYcCXe0IGzY8eg/jsHPy1q4WJMvxh0DqLNg+ZgSdNr4zd9q6i/RTGFtFc3QSSuQRuWzJf7kWITq/piOZYSJy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4tFuGL4DbNEtKTLO5YwmYG0tSoGXIpAx9mRkdS28Bz6r6jeD
	pJHyclvV2CkIMOriC/tIx5JAQfLeoBdAPuKGSJvTqcF1xaSpn5jm
X-Google-Smtp-Source: AGHT+IHgTXutoVNi8aDqPPP/+KgfDCgrksJCESMS/68BZDMFkdIdxvC3YnaBA0YfWndNPVbYHVlGDQ==
X-Received: by 2002:a05:6e02:164d:b0:3a2:6cd7:3254 with SMTP id e9e14a558f8ab-3a26d78f4c9mr48930055ab.14.1727310411822;
        Wed, 25 Sep 2024 17:26:51 -0700 (PDT)
Received: from localhost.localdomain (24-220-248-19-dynamic.midco.net. [24.220.248.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40ed005a8sm1407875173.0.2024.09.25.17.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 17:26:51 -0700 (PDT)
From: Benjamin Hoefs <bendhoefs@gmail.com>
To: jani.nikula@linux.intel.com
Cc: rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Benjamin Hoefs <bendhoefs@gmail.com>
Subject: [PATCH] i915: Fix HBLANK Expansion Quirk Causing Modeset Failure on Dell WD19TB Dock at 3440x1440@100Hz
Date: Wed, 25 Sep 2024 19:25:34 -0500
Message-ID: <20240926002533.10153-2-bendhoefs@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I am using a Dell WD19TB dock with a 3440x1440 monitor. Using it at
100Hz used to work but recently I tried it again and discovered it no longer
did, specifically the modeset seems to silently fail with no error message in
userspace utilities like kscreen-doctor and xrandr and no output in dmesg.
I found the problematic commit using git bisect to be
55eaef164174480df6827edeac15620f3cbcd52b "Handle the Synaptics HBlank
expansion quirk".

I found the issue to be the hblank_expasion_quirk_needs_dsc function which uses
the following comparison in the current kernel tree:

if (mode_hblank_period_ns(adjusted_mode) > hblank_limit)
	return false;

with hblank_limit being earlier set as

int hblank_limit = is_uhbr_sink ? 500 : 300;

However, my monitor's HBLANK period in the 3440x1440@100Hz mode is
exactly 300 ns as verified by this printk immediately before the
problematic comparison.

printk(KERN_INFO "Hello, kernel world! %i\n",
	mode_hblank_period_ns(adjusted_mode));
[   38.429839] Hello, kernel world! 300

With the attached change the modeset works as expected at 100Hz. Would it be
acceptable to modify the comparison from > to >= here?

I'll do my best to provide any additional details you may need although
that printk and '=' sign is the only kernel code I've written, so my best may
not be great :).

Signed-off-by: Benjamin D. Hoefs <bendhoefs@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 15541932b809..052c5a67df93 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -446,7 +446,7 @@ hblank_expansion_quirk_needs_dsc(const struct intel_connector *connector,
 	if (is_uhbr_sink && !drm_dp_is_uhbr_rate(limits->max_rate))
 		return false;
 
-	if (mode_hblank_period_ns(adjusted_mode) > hblank_limit)
+	if (mode_hblank_period_ns(adjusted_mode) >= hblank_limit)
 		return false;
 
 	return true;
-- 
2.46.2


