Return-Path: <linux-kernel+bounces-342453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F24988F43
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 14:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB6B1C20C22
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF41718801F;
	Sat, 28 Sep 2024 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y5KRxePn"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AEE157490
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727527865; cv=none; b=NQz2sbCSQSs7hxNKj1STKJGKMgbugtAqX4UVXFWTnyVgkBSqaMbAzru3JM41P4DzrUJO+y1otqMrDgmlMXmcf6SA0xAs0MkfkwwOSMXeVG6sfbdN6yt0W5wQ3Oxqm7/1aoqSsQ/Zjog6R1LcvgFx/DEr9IQLUPgZsobHudES4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727527865; c=relaxed/simple;
	bh=uzNDFIASlcjmhnq4B84kGsWJoqwEJ2D5FOaAsLQFPDg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=htW7kcsgJ9M8sLDxagdWaBl7zkAiuzzNmy61HBTbACXRVAJK5R+e5JH8AklYStqc/jehQOrmfXeE6NP5a2KtJlloxPmkDMjGUYetjNdcCLQLnwzApgbUSqZzVfv0dS8Oq2O4nuXhyf/PqobgOJkqaH+hpJ71D+toCyWHolaNSu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y5KRxePn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-718d6ad6105so4159015b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727527863; x=1728132663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WbcikcQghLA80yn7fEgUn8n+Xqz0Oab8G7/Spbe8pME=;
        b=y5KRxePnU1SnW0YERreQntTz1nWCuJVbcA8aQG1X//dU+EizxdL4fXCLu6VZLeLOSE
         68e7SYn7Mpe0cWiW5KiNvfODmuymMCZHjo01in0wADVr0KO/jwDeGwHjNjZcZ6/HiVJ7
         QSfEBDR7ECtqam2CUxTShcjgfrjrwIBuTjmFINB/QNzzUPzzGgluMwrLQRin8zuggJc0
         1l3ZKVJwYk8RgpPYiFEKGFo1hZeIAq8xVB6docMlnOkKZ/w/T5l/SpdGvhyYbCZFMZEw
         /zAlEiLmrGb0ai7cPY9+An2HRDfKwday+p8R8taranEiDja/thcZMvuyOqUqL2gZPJDr
         ZEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727527863; x=1728132663;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbcikcQghLA80yn7fEgUn8n+Xqz0Oab8G7/Spbe8pME=;
        b=ujKuPAWJHB4VRGpviBrhfqcl5gaFq+11xeJhtmAZ4dwFOfdNuT5UvO0RR5gxeg/d4w
         T5haK6HMk/8ogL/bp985BMoCkTxtyqsIUE+3adaNvs+o7VY6BaFK4WJO9Uiku1MYdS3y
         zS26x2FCx3/fdIblc4oivSsCuvzMpz82Ap8R6nOX7ChlqreFYXNJKGb6Fa4Tyke+GzIS
         iuU9j7SFmntAbC9lY9GNCLBHRHVFMsKpU2/CeuDAeXDyIe/1EOfUjwHnDLTWPOLaxkhc
         8ay+Kv8iGAxOS+Wt51cDXpU0zRczP16G4q2L0IcDOJROfIqBhwwq+6lj7xdWNwsuzNTz
         qBag==
X-Forwarded-Encrypted: i=1; AJvYcCUkopCoaC7aNOyqwy1/gd1kPbd3X9m1ylrDnQvJME36qgIBnk2oWPdaYwpQ2lRAlvCXbnFdnpXqmuzLphk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhY5RK5o8sUqjTcV7wumLeskgOFg0HZFHMOujRYBfjaeNR7/Ql
	1HwY6waOH2aK72NU0YiPuu0JOmxSOtbGb2oQNdz38entLA7Tzph4v5CpAna13G6e/n0AFw==
X-Google-Smtp-Source: AGHT+IH3yEkpeq/TThQP8zDxhQ2tmCMlsZVCGE2CrPs/xfP5vkjvVN9L4g+viRDmbWRmMiQt1IVOrU8A
X-Received: from keyz2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:27da])
 (user=keyz job=sendgmr) by 2002:a05:6a00:38d:b0:717:9643:2043 with SMTP id
 d2e1a72fcca58-71b26079b04mr19396b3a.4.1727527862564; Sat, 28 Sep 2024
 05:51:02 -0700 (PDT)
Date: Sat, 28 Sep 2024 20:50:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240928125005.714781-1-keyz@google.com>
Subject: [PATCH v3] devres: Fix page faults when tracing devres from unloaded modules
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Keita Morisaki <keyz@google.com>
---
Change since v2:
- Add a Reviewed-by tag
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

