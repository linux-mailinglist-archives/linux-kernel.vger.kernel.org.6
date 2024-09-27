Return-Path: <linux-kernel+bounces-341854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014C4988722
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB301F22BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73057136354;
	Fri, 27 Sep 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDyLIVcI"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BFD13633F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447312; cv=none; b=i1M6EjdXjRHC4ylDMV+gKiS8xbhOK7eghcF1OycxTg9pa//MmxoGbjiMCC/Hz5UKneydpeIDiCRUIDjrf3RsPAJ3FjM38nYluj7JE63xsOEr+IxUr2a5WO9JOr1UbObVnx83esEtN7DALkKrQU244Y0Hh6vPBMRV5VCWlwiYBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447312; c=relaxed/simple;
	bh=AESb+YxYi2TzZlWCio2wOV+r4zTSZXwltaBxwilKnLQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ecdXm1HAKf8E13G2rcFpXNyof2ZlABNAFj18u4Hy3VyqQcouMgYsFb/0X6STVdOQN6ISl4UuxTqqWcN/+wzqTZ2r1/RK2//rT1FPwfOLTWov7rdpqq5/VFSCQa/5LPaODmOad4fDTKl3IVa0Pc0UR2JR88Fvg11ce/DPSuXpCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDyLIVcI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e21d0bfba7so40497417b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727447310; x=1728052110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gUIrkrVfzZT3g3VJMCTxChsL0KmKbAyIGWxgN/7cdFo=;
        b=IDyLIVcInHZgmNTD4cTj6+fg9tKKkpUfcdi9yrO6SHWrTbMlj80CcMKGy9Q5sTadoQ
         a1PHcbx+VWF5yWv2oQevCEEh1VKuth1rIHoZ1ZqQTjDPnA7Arx2I3ng8fujpOlj5kOR6
         tKVG3rYebabvnGWJWiyA7owIw2jP2jGkBOUYMRH15KKIvV2fBVZYPo4qr0W9V07rJuE7
         oQ7J9TnsLsqs0WpVOFH/nCnc+fRr4f4r5M3IDd99u6LBWv7yqnGo/1ApP54C4tUZCW7K
         9YN7I++Q4B5v5Pt7tNnUcq3T8TDvmTIrB8AnXszWWwOmTX0KNrWxsZWXhRwRjkJQgxxb
         slaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727447310; x=1728052110;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUIrkrVfzZT3g3VJMCTxChsL0KmKbAyIGWxgN/7cdFo=;
        b=HzYl0g1HY5NWkXD1yhh8OEVUEN0s5pnDBu+c6km3Fg7WnvvETtTD96xq+dSh+dR9OI
         nffVdVLxtJRJiaqb10WCLGzrllkswA+ssy7TptxyQ9len0ab2mYEIUtU5B61lUSq1G3Y
         +qh/9r2I0ErCgAvuDMgmT2SkLnwvUziDaXiGyVSkMUAGi5lyQSGGlPYqnfV9s3+cmNqn
         Q772xuoNKGfu//iMVaChAE49h0zV6C4iwNRTGpNql+oC3duuktrkwtV3lNBTVaLCqaFH
         wHXhaqqC25u7EkUB26bs79yfEl4bcpskUiv2TJlVRqIgYLKxdpkg2KO9Cx3+yVaj+XAk
         TgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy/oB+Fee0FAo5d3jlR6wfaBJhkjLoDXqec3qVxcIobh/D8fiqq3wRTHPOLeBn6uJt09XkjV0egit9GBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxhOBEjyYLkpfjH/KrLzy/wpe+s6ZVyNxRnyLn6XlLbRkuxWp3
	oYgmEecAGHrYLm2begzpPO/fxBLPEN3mudZPsZZxQC20bb7tw9JJkHXPgM4+uu47+pShHQ==
X-Google-Smtp-Source: AGHT+IEd68EF1Ddse6gA2vHRo728udZhP5k9aS2XfpYBGrOfkOWN/gAvmHWReCfPJ+ICUTVIJxlI86fO
X-Received: from keyz2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:27da])
 (user=keyz job=sendgmr) by 2002:a05:690c:3146:b0:6dd:d138:d823 with SMTP id
 00721157ae682-6e247619fe4mr288657b3.8.1727447310448; Fri, 27 Sep 2024
 07:28:30 -0700 (PDT)
Date: Fri, 27 Sep 2024 22:28:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240927142807.544325-1-keyz@google.com>
Subject: [PATCH v2] devres: Fix page faults when tracing devres from unloaded modules
From: Keita Morisaki <keyz@google.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, 
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com, Keita Morisaki <keyz@google.com>
Content-Type: text/plain; charset="UTF-8"

The devres ftrace event logs the name of the devres node, which is often a
function name (e.g., "devm_work_drop") stringified by macros like
devm_add_action. Currently, ftrace stores this name as a string literal
address, which can become invalid when the module containing the string is
unloaded. This results in page faults when ftrace tries to access the name.

This behavior is problematic because the devres ftrace event is designed to
trace resource management throughout a device driver's lifecycle, including
during module unload. The event should be available even after the module
is unloaded to properly diagnose resource issues.

Fix the issue by copying the devres node name into the ftrace ring buffer
using __assign_str(), instead of storing just the address. This ensures
that ftrace can always access the name, even if the module is unloaded.

This change increases the memory usage for each of the ftrace entry by
12-16 bytes assuming the average devres node name is 20 bytes long,
depending on the size of const char *.

Note that this change does not affect anything unless all of following
conditions are met.
- CONFIG_DEBUG_DEVRES is enabled
- ftrace tracing is enabled
- The devres event is enabled in ftrace tracing

Fixes: 09705dcb63d2 ("devres: Enable trace events")
Signed-off-by: Keita Morisaki <keyz@google.com>
---
Changes since v1:
- Rephrase part of the commit message
- Add Fixes tag
- Remove a newline in the patch
---
 drivers/base/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/trace.h b/drivers/base/trace.h
index e52b6eae060d..3b83b13a57ff 100644
--- a/drivers/base/trace.h
+++ b/drivers/base/trace.h
@@ -24,18 +24,18 @@ DECLARE_EVENT_CLASS(devres,
 		__field(struct device *, dev)
 		__field(const char *, op)
 		__field(void *, node)
-		__field(const char *, name)
+		__string(name, name)
 		__field(size_t, size)
 	),
 	TP_fast_assign(
 		__assign_str(devname);
 		__entry->op = op;
 		__entry->node = node;
-		__entry->name = name;
+		__assign_str(name);
 		__entry->size = size;
 	),
 	TP_printk("%s %3s %p %s (%zu bytes)", __get_str(devname),
-		  __entry->op, __entry->node, __entry->name, __entry->size)
+		  __entry->op, __entry->node, __get_str(name), __entry->size)
 );

 DEFINE_EVENT(devres, devres_log,

base-commit: 075dbe9f6e3c21596c5245826a4ee1f1c1676eb8
--
2.46.1.824.gd892dcdcdd-goog

