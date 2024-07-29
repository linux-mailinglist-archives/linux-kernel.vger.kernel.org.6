Return-Path: <linux-kernel+bounces-265849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F5B93F6C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBA24B20E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27FE148FEC;
	Mon, 29 Jul 2024 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgIqBA7o"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9208C06
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260050; cv=none; b=FSRPZfT+5E9vMrIfCIrVzKsbwKf4QQgdZxDOYaH20Jgm5kXyvVbMJix14A5oi0R+0qQiTpDdGzrNorNjkgD733oL1DxPxtZ/L5amJ0EjGysJfqVU+YNbBBElaHrkV9mJTMSGWCfzMSy7UO6YGX/T3U5X4pPhTtvHKmRCfELpISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260050; c=relaxed/simple;
	bh=w12nwxUIREwYIPXpg/GTvCcfWPETkevslajpYZZtTuQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nV/k82wVUfCZPzumz7vmLZxMtjfSJhMKOkyXyqBUtWPfW9JerXhtWQsLallOlY1BrskyyxIlgeIk3Mp0w39TN+eyzDFaZZsCks2Ub8n1nebdXsGQ9LFVrx6D1rK03azUYgd8CZ7By5RuPSwf4sgjQOCb3wpEwxlP4DEBqoKOUgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--patrykd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SgIqBA7o; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--patrykd.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3687f5a2480so1383231f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722260046; x=1722864846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=465ZBROIKLCLkrN/lLvUWM4F6rNUZr8UWVo8sKBdyEs=;
        b=SgIqBA7oU5DSD/UkZiQqpAzgEbk5cT/45GkS1le4uZzD1xFh++gvxxRLrTlHiZSd6l
         rDJ84tKcwFANY99PfHnRtNbcnP6d60kt1nrz42UKi4wO8weDDF0vTrx/aFjKqP4Tjiib
         knSt+QDk5VSn/EAyUi71bI9K/olmlFtz0JC4/G0pUS5bipbPCsqEsRFXglFy2VYrrd+r
         opOG1y/kGPXWreLD3dwwO+7/NOv6DX98P/KFBfwPThjoVxvxJsKLIsWs8ac3yQRSby0O
         o67rkqHGziK7cswBujag/a2UxzapvKxgIjfv9Z436jE6DeAuGIZl7FwDWlPbdeSb/ERn
         d6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722260046; x=1722864846;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=465ZBROIKLCLkrN/lLvUWM4F6rNUZr8UWVo8sKBdyEs=;
        b=cD4xe3p0oaBmDQikmRu8/MJ2/LHdSubmt/VE0rrp5TGePAVsCVN2GG9chsf8hEsC9R
         DPPy+1viCDyy5lVbPJmZaoYYVX4QonjUEim/zohuZKWpEfsnNw7KPEhhY7uSfRrbbGr/
         eD2BLIVMMjKHVoK31B7+WolKBZa7VoUhglQPlyPGMlvIhqxIqeSkAy0nzFv/QD/7qayz
         uKpsX/tDR07TB0YyMw0crGJXmMyK7c1y77T6dnJJYoCy0ZqW8WxosEYUh/iSG/GlchZh
         PRjDI6is/WoXXgG8j3MHhxS55PBhamXrgQL2CCQ3iFp/vjANkETNBkF5a+BsXSXd42Mu
         sErA==
X-Forwarded-Encrypted: i=1; AJvYcCXyOtzJTLXfS/pkrWTiLrbjSEXjp1NQfC7EwKTDrbQezij/IQ5ur7lPJB2r48lIHHqgMtWJxZ+0JJXQ1mQ+5ULTTLushwx/+RHJKwRX
X-Gm-Message-State: AOJu0YwzELwsMf1YWjO2sknSfP+q8cT0m2yEeO28M5DkYBDbGs4nvqur
	2CNJf7Qg7Ja4U56ocxNKGpZCSRGBrjKH3Ke00jczgJvofUOp40R0hrDIMZMvgVOmTHEoZxSo5nK
	womXOiw==
X-Google-Smtp-Source: AGHT+IF9rOb7pQOtFCNoiOZzLDJokFhreMRyBjy14aQy0ThNkcmbqxR6nWbsT6OH2KVHsm0kUsmqNSNe5nSj
X-Received: from lysy.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:de4])
 (user=patrykd job=sendgmr) by 2002:a5d:5267:0:b0:368:3ee5:e3d9 with SMTP id
 ffacd0b85a97d-36b5d352629mr11284f8f.4.1722260046110; Mon, 29 Jul 2024
 06:34:06 -0700 (PDT)
Date: Mon, 29 Jul 2024 13:34:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240729133404.451210-1-patrykd@google.com>
Subject: [PATCH v2] platform/chrome: cros_ec_proto: Lock device when updating
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
  cros_ec_get_host_command_version_mask() failure

 drivers/platform/chrome/cros_ec_proto.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index f776fd42244f..f278fde15504 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -813,10 +813,11 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 	if (ret == -ENOPROTOOPT) {
 		dev_dbg(ec_dev->dev,
 			"GET_NEXT_EVENT returned invalid version error.\n");
+		mutex_lock(&ec_dev->lock);
 		ret = cros_ec_get_host_command_version_mask(ec_dev,
 							EC_CMD_GET_NEXT_EVENT,
 							&ver_mask);
-		if (ret < 0 || ver_mask == 0)
+		if (ret < 0 || ver_mask == 0) {
 			/*
 			 * Do not change the MKBP supported version if we can't
 			 * obtain supported version correctly. Please note that
@@ -824,11 +825,14 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 			 * EC_RES_INVALID_VERSION which means that the command
 			 * is present.
 			 */
+			mutex_unlock(&ec_dev->lock);
 			return -ENOPROTOOPT;
+		}
 
 		ec_dev->mkbp_event_supported = fls(ver_mask);
 		dev_dbg(ec_dev->dev, "MKBP support version changed to %u\n",
 			ec_dev->mkbp_event_supported - 1);
+		mutex_unlock(&ec_dev->lock);
 
 		/* Try to get next event with new MKBP support version set. */
 		ret = get_next_event(ec_dev);
-- 
2.46.0.rc1.232.g9752f9e123-goog


