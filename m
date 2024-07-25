Return-Path: <linux-kernel+bounces-262508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1812893C7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3D01C21240
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C5E19DF76;
	Thu, 25 Jul 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yJqLGMB2"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E962119D8AB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721930239; cv=none; b=MfXr7awDJzMRc6lppH3L2uyia7bVxVGmYDVcuJW11z6aJfbZbYgogV5KDhy2L51pkZVz5PAyynzgvEQ7iZJIWR4cGlnGCkwYSoZr/co6gfcr8kNULrbMeUbrlHur8zkksBP85oUJeEWZRpLqQuu7DXBfjSSnMvh7AF3jsgekIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721930239; c=relaxed/simple;
	bh=DhAIgWDpgwVkWBBmDYSxAnHbMgCM6/NvKYHcNXQNSYg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UxyVF0/YOGHjQhUUoaSeJhEbhM8bXqyvb1Qt7S7JMk/YnlZossrz1ZCmO351OR16Cko2PY7ugm/tO2qC6cDRA2BxVj2IBWCpoxf7jCZ0fmg35Dgs8TuanVpsybz8G0MEsGCE/idb2xzXMvuLfnJoxzItQhXPBSV1vFppXKd7YWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--patrykd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yJqLGMB2; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--patrykd.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-367962f0cb0so702890f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721930236; x=1722535036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pj8wlsiwh+dQMB6deQXUuo6LHgenGkpoXoj1IjIi9wU=;
        b=yJqLGMB2gyKlE2cYCXTtK0gMxYMF3gnS86ppLbdfX3uaq6RsnS+akKSvncgj1v7X1y
         j5k7apdRg8s1u6V0OJR/lG6Sds36qJW1BdJGC1NguFpOKHKA7oMVhnsdcgl+CeBCVGGp
         WiL+uWEGczOzMLYkiEwOxYiKuwVqvvMjTED/uLVCAnGCcIydor6YsrsmhxIBNMGyPA/O
         exdgE00xMH+jcU2G/nrBgrXWA/OyRh6IHZk1+PVwKdJY6+2roNPoBUVDmoE9xQELzcAG
         lb/e9w/RQInk3Q9M3J0+cID0pXZQVIpBIx73Ua/a/WV15VOhGMo/BhbetJqtr6n0nGR9
         0nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721930236; x=1722535036;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pj8wlsiwh+dQMB6deQXUuo6LHgenGkpoXoj1IjIi9wU=;
        b=QvQSFB/kS8b9Vwq4LnWBDrHhMZeynaxx6CG4utinG0mRF731DRNMvNdLKcF1XBsyLe
         54vPMUK+FAmDRaFfgit3sGzOQlKel6IXAfZyBIvRZOQ67+8974FMN/3cvmZ188zWyIC8
         EyfRfrvP5weHeLGlOgX03qANJvtWDrVogwZtEvp9KqfHECyfL0EOVls7VJyA0Bq9MVSs
         ZYsEkgviWQWrjdxLran15AoW/nQPA5wXq+RGQrlcl5QizfNLs4YL2l38ZutmzXU7qPBh
         IexsEanYcB0r72m5FZXb0ODarEA4waN0lrvbNVkkNopblvS043plrNZSn/+br7r10dzF
         t9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVchYEeHt92UeLDMCx6I8EAaL4XzjcltKi9RGgh1rC2j2d55PbRQ4hpf+LLaiGIW4+9j5xMj+7PtZdTaOKf/r+WonYLOeDNVzZWV3Y+
X-Gm-Message-State: AOJu0YzJ2aN6pTfrWNmFEcgEE9ZjsCIX/950FH14dvWxSUjH9Rm1th3E
	W4tjGwt94eGi3C1KOlvXysupgK/FWm/y6VNTUHZz5XZ0tHDSqLCdx2pJYQ7ngTs4zDpBfDxqGFf
	EYJxZ2w==
X-Google-Smtp-Source: AGHT+IGE7PmENKFcCopXZjvlj0vKRfEsY2GhFANwEWqXPK+LTdTXsK5o4971ia5IpQPiVH9ll7u1HZGHcBZT
X-Received: from lysy.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:de4])
 (user=patrykd job=sendgmr) by 2002:adf:f091:0:b0:368:3373:30bb with SMTP id
 ffacd0b85a97d-36b363c2f19mr4817f8f.6.1721930236012; Thu, 25 Jul 2024 10:57:16
 -0700 (PDT)
Date: Thu, 25 Jul 2024 17:57:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240725175714.1769080-1-patrykd@google.com>
Subject: [PATCH] platform/chrome: cros_ec_proto: Lock device when updating
 MKBP version
From: Patryk Duda <patrykd@google.com>
To: Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Benson Leung <bleung@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Patryk Duda <patrykd@google.com>
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

 drivers/platform/chrome/cros_ec_proto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index f776fd42244f..cf7ef5f9db84 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -813,6 +813,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 	if (ret == -ENOPROTOOPT) {
 		dev_dbg(ec_dev->dev,
 			"GET_NEXT_EVENT returned invalid version error.\n");
+		mutex_lock(&ec_dev->lock);
 		ret = cros_ec_get_host_command_version_mask(ec_dev,
 							EC_CMD_GET_NEXT_EVENT,
 							&ver_mask);
@@ -829,6 +830,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 		ec_dev->mkbp_event_supported = fls(ver_mask);
 		dev_dbg(ec_dev->dev, "MKBP support version changed to %u\n",
 			ec_dev->mkbp_event_supported - 1);
+		mutex_unlock(&ec_dev->lock);
 
 		/* Try to get next event with new MKBP support version set. */
 		ret = get_next_event(ec_dev);
-- 
2.45.2.1089.g2a221341d9-goog


