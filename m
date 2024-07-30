Return-Path: <linux-kernel+bounces-267312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D9F940FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5363E1C2048C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A87E19EEDC;
	Tue, 30 Jul 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E807KgKx"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C50F1990A6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336271; cv=none; b=AdczrBXmM7REsnNH/WJtKL56MsEi+zRI427rnB8NVwFaNgolkkQRLZDkfj4Xo/ygQzFRsRrDBRT9eoiK9dupAj2n3VqUNtmJcepgUNU2e8hN7vmbfYoDOxliq5gU0yB6zH5kP9FS79YwnKiIpnO8xTkdK8CJu3PVLrEeUB4UQ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336271; c=relaxed/simple;
	bh=fK1eD6ZgZaJCFWg7plGuYvU5/18MRafwTZqCt2QDch8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jie/178Q616LS3qacLAEBzs7uJGdcLjvmJvXEUkHTIQ0ubQerBeuDIFB3LON/jznneEVwDQVebZ3cWwshkhSmWUDMv+Dht7tWPKe+Gt54s/HwxpNA+pvHzv7hl4tKhpeRCbgXpYLFeWjL1RgUPYL51TK6oCb74sIXW1stHCybRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--patrykd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E807KgKx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--patrykd.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0ba4d19585so675202276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722336269; x=1722941069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Ju3CEnm/75GdSSu7/W/MwAhJEZT9eFBSL3oOgUpEoo=;
        b=E807KgKxGS1eY1b7fniWKXkwId+ZcdM4Gk2w96jH+d1lyEYIl75jEPeZMJ/asfdCTR
         bB8dKy7y7MpfVx0BwFE8Of47E3T1IZc+FD8rwyFnOKuQ5ZXCEYYbM/r0tCsoSySE2dgx
         7EuddgsJd6crVyELUyj2BkryL3u7N93Ta5E+kflhR5kKVc8a9ob3upgPTJPu1r/4l0+v
         I6B5RRNRHR7lQPo8wXyQWezhpDNoqQ0Una9Qa9+Q6yRA4Or56X4mb8R5TyvYgjqat1Wa
         jPIHHzoSQYl2BeWJFXquSVao3Zgk19GTf8DkM04rteZxULFFl3H0tR9u25dfsOEyV+OH
         R90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722336269; x=1722941069;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ju3CEnm/75GdSSu7/W/MwAhJEZT9eFBSL3oOgUpEoo=;
        b=dNHxtNay22iWg6Il0kJxJoxko76WeDKBi9+b5zFn4/2uaRLcM0hQhC6v/3e5/a2nW6
         wxtn4hgHL93Gjrie4ZzruB1dH7MhlWPAk82aGh6NTy+1t310uu0anBnK2nJBROybRgvb
         UU8lKHjhQ/W3YGE38n1a6iZQ1m/Rh9sZMWIG/ofzFEVTILDHHli7SAp4EkWZqyvjwV+G
         QELBxKxIy3HajzfKE9nZvG9Z/r1biPC9T1AelkoqCETrPKdKnJkl/IZJ1wRGzOfA8fz9
         gttz8m0hS3xgXvjaN5eXahDnF9Gc7eTDLdgJoraUsLxbDQ5dvz+G0silLODCouyky1sk
         nl/g==
X-Forwarded-Encrypted: i=1; AJvYcCVqYdWneZmUg+vs65X5aOyIAkBCeESQkOTrsWyoVyqNdQSXRxstT/ypg/kBJGH1797Zn+WWZbHDGz9vPg4G+yYXueRWU77V5OIuA4Lc
X-Gm-Message-State: AOJu0Yx4nBWn5rkMBJCGX+4NcJGzAngICUcOgcbVpGG579MriPXCe8fH
	PHuln0NLl3ZMqHXYTZXmYTCkTs9SFFC7JvAdJ/bghano4RgCgWxxaoFQMjtpCzoAY1yzPA7B0oa
	Bef50eg==
X-Google-Smtp-Source: AGHT+IHazDOvazf0vrwZ1/mMamY8v4MleZ3SzQ8ocVwM20wVxRY/0nX3NuXnnpuypD/FCNGXHB2hSQb62xSJ
X-Received: from lysy.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:de4])
 (user=patrykd job=sendgmr) by 2002:a05:6902:2b85:b0:e0b:1407:e341 with SMTP
 id 3f1490d57ef6-e0b543c0bf3mr19416276.1.1722336268990; Tue, 30 Jul 2024
 03:44:28 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:44:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240730104425.607083-1-patrykd@google.com>
Subject: [PATCH v3] platform/chrome: cros_ec_proto: Lock device when updating
 MKBP version
From: Patryk Duda <patrykd@google.com>
To: Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Benson Leung <bleung@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, Patryk Duda <patrykd@google.com>
Content-Type: text/plain; charset="UTF-8"

The cros_ec_get_host_command_version_mask() function requires that the
caller must have ec_dev->lock mutex before calling it. This requirement
was not met and as a result it was possible that two commands were sent
to the device at the same time.

The problem was observed while using UART backend which doesn't use any
additional locks, unlike SPI backend which locks the controller until
response is received.

Fixes: f74c7557ed0d ("platform/chrome: cros_ec_proto: Update version on GET_NEXT_EVENT failure")
Cc: stable@vger.kernel.org
Signed-off-by: Patryk Duda <patrykd@google.com>
---
The f74c7557ed0d patch was tested with Fingerprint MCU (FPMCU) that uses
SPI to communicate with chipset. At that time, UART FPMCU had the same
version of GET_NEXT_EVENT command in RO and RW, so the MKBP version was
never updated in this case.

Version 3 of GET_NEXT_EVENT command was recently added to CrosEC. As a
result MKBP version is also updated when UART FPMCU is used which
exposed this problem.

Best regards,
Patryk

V1 -> V2
- Added missing mutex_unlock() on
  cros_ec_get_host_command_version_mask() failure.

V2 -> V3
- Moved call to mutex_unlock() below call to
  cros_ec_get_host_command_version_mask().

 drivers/platform/chrome/cros_ec_proto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index f776fd42244f..73f75958e15c 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -813,9 +813,11 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 	if (ret == -ENOPROTOOPT) {
 		dev_dbg(ec_dev->dev,
 			"GET_NEXT_EVENT returned invalid version error.\n");
+		mutex_lock(&ec_dev->lock);
 		ret = cros_ec_get_host_command_version_mask(ec_dev,
 							EC_CMD_GET_NEXT_EVENT,
 							&ver_mask);
+		mutex_unlock(&ec_dev->lock);
 		if (ret < 0 || ver_mask == 0)
 			/*
 			 * Do not change the MKBP supported version if we can't
-- 
2.46.0.rc1.232.g9752f9e123-goog


