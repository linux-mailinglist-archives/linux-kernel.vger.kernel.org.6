Return-Path: <linux-kernel+bounces-170655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6268BDA46
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ADEE1F25554
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA316A8D2;
	Tue,  7 May 2024 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6zEu8j9"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCA6A8C1
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057648; cv=none; b=B8jF9YUVhOsjXr2GnhzghkogLF00EeE+RdJu3Z5eEFLWwJkzWnx28AFybjnCOGCvow73S5YCedg6h45YsirtEzG+TcQeGe1NmXK8AtJyLPZYZb0HsmjKx4MFPd9ZUh9s1Fp0eiqp8RFoQJpRXJj2seQAptDKFHQXe08QegCZ7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057648; c=relaxed/simple;
	bh=EG/4mQn3iUCIUBQpyIxWSzOoZetr0X+2/VpJcryuHiw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WPN0pC3CiEJu9LEaVv5f0FpPKicUkkzdwcAWFlBn3jtms4IHyHaC30RCTP7hZ3rBHpUoGoPxz4NTxoV1SLH7/Fi0uycjIy8PNaK8KDJIfJrQZVhmTs+0qVKkI1icbbg0kvu1L5hgTs9VuGfA031lXVgZ2oZGivlB30uFuutniRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6zEu8j9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b1200cc92so50184997b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 21:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715057646; x=1715662446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gbyIudFO5PLYpDqrCMxnrthgngfgspkn0imu/2S7Rx0=;
        b=Q6zEu8j9L6dQ29M473DdLfMMePGUzV2KOnf/YlYTsCackm31VJOLfrjPLFXKkPdEFq
         1JD14EXShmBc7WmhY534nSAXdUTGK1615MeId/jLYmSJpQaycmnWh2Zd1T4dkEqmJiIU
         yMMbJZ7MN9LplM8MrFPnIgKoRh1n8r8PbLi+8+Pt5agnkvb3YulkTOGq1ZZ4y0FyztXw
         aZMnt3SKmYlH7Dqaco0/DtlMvCDHovYutpa7aTsPtDQUEyzbdKLMrlN62D0lUIGa2iB3
         Kb9U+PDsREC/cQjscQOI/yrTd3VSCWGbjKZAgoLhmWCVz96iHiTPpJjinTSwxznFyJlO
         dDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715057646; x=1715662446;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbyIudFO5PLYpDqrCMxnrthgngfgspkn0imu/2S7Rx0=;
        b=c82V+PNH87ZeZmbk9PDeHJofm/EMH6TfZZq7aLaI3fdLaEW2Zg9M6Ze49jWR9PrYcB
         XHGPzlgpbDGXPwt0ftN8Nk5/REEP7vp104pd21rIP+hwmbSmpBJIljBmEc7an2t34zC+
         Qf241hhWo0Y89iURnaGMdlCJ4BQ0vfNBGA1brUcNfziRBTwpzLmyg9lonJ2WgAYhRAzf
         NEzjJi/n0wQSHgPm7C9CDm5xNNmH8cnTTmT4P0VleJoKyxggfO9WxqYxsjQlU47Vrg9N
         FMhq0tUbLGKityX7AKEp5uaSAn7b0PWx/8Ww4UPEQLuWWtScfpKgNljPbWfNrlHJEr8W
         rWpg==
X-Gm-Message-State: AOJu0YzV9cBuZYXTPKeqKzJKKCpZ9hzFXz1xzPdcMA1iW1AN4WsBoMy5
	kAIBO37LT3RwZA3ArqsdRNKY6ztemnbuMeSQQLSdjPm+zoqjUzDgBHtQFhzyBFqRqq0NAKSASqW
	CcjSsIrNrucgBQgqP/UP9BA==
X-Google-Smtp-Source: AGHT+IGtKc62aRJNXjBywonvm66zw3a+Ig610QNJpk2AMRvk3n/gRL2OtIFIddRHProULXF8OuFC4WeKNq/6R4hLuQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1004:b0:de4:7be7:1c2d with
 SMTP id w4-20020a056902100400b00de47be71c2dmr4112750ybt.11.1715057646473;
 Mon, 06 May 2024 21:54:06 -0700 (PDT)
Date: Tue, 07 May 2024 04:54:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOuzOWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwNz3SQTXaAa3cSSRENdyxQzEwMLyzRLw2QDJaCOgqLUtMwKsGnRsbW 1AM2QDzFdAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715057645; l=2482;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=EG/4mQn3iUCIUBQpyIxWSzOoZetr0X+2/VpJcryuHiw=; b=SG4WJI+L6YOTiMwNSdEmj0jgzxl6qA7a97Uc0+ganqFCfS1wHKfVd1XhLQOXZVmhdVMKl2a25
 uMiefYABR+SC/NkK5u/lNKaNx0YBHwD1rgKAWp3ByFHKBsGuCMDB8ax
X-Mailer: b4 0.12.3
Message-ID: <20240507-b4-sio-ata1-v1-1-810ffac6080a@google.com>
Subject: [PATCH] cdrom: rearrange last_media_change check to avoid
 unintentional overflow
From: Justin Stitt <justinstitt@google.com>
To: Phillip Potter <phil@philpotter.co.uk>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

When running syzkaller with the newly reintroduced signed integer wrap
sanitizer we encounter this splat:

[  366.015950] UBSAN: signed-integer-overflow in ../drivers/cdrom/cdrom.c:2361:33
[  366.021089] -9223372036854775808 - 346321 cannot be represented in type '__s64' (aka 'long long')
[  366.025894] program syz-executor.4 is using a deprecated SCSI ioctl, please convert it to SG_IO
[  366.027502] CPU: 5 PID: 28472 Comm: syz-executor.7 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
[  366.027512] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  366.027518] Call Trace:
[  366.027523]  <TASK>
[  366.027533]  dump_stack_lvl+0x93/0xd0
[  366.027899]  handle_overflow+0x171/0x1b0
[  366.038787] ata1.00: invalid multi_count 32 ignored
[  366.043924]  cdrom_ioctl+0x2c3f/0x2d10
[  366.063932]  ? __pm_runtime_resume+0xe6/0x130
[  366.071923]  sr_block_ioctl+0x15d/0x1d0
[  366.074624]  ? __pfx_sr_block_ioctl+0x10/0x10
[  366.077642]  blkdev_ioctl+0x419/0x500
[  366.080231]  ? __pfx_blkdev_ioctl+0x10/0x10
..

Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang. It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Let's rearrange the check to not perform any arithmetic, thus not
tripping the sanitizer.

Link: https://github.com/llvm/llvm-project/pull/82432 [1]
Closes: https://github.com/KSPP/linux/issues/354
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index a5e07270e0d4..20c90ebb3a3f 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2358,7 +2358,7 @@ static int cdrom_ioctl_timed_media_change(struct cdrom_device_info *cdi,
 		return -EFAULT;
 
 	tmp_info.media_flags = 0;
-	if (tmp_info.last_media_change - cdi->last_media_change_ms < 0)
+	if (cdi->last_media_change_ms > tmp_info.last_media_change)
 		tmp_info.media_flags |= MEDIA_CHANGED_FLAG;
 
 	tmp_info.last_media_change = cdi->last_media_change_ms;

---
base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
change-id: 20240507-b4-sio-ata1-9d64089f91c0

Best regards,
--
Justin Stitt <justinstitt@google.com>


