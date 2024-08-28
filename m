Return-Path: <linux-kernel+bounces-305384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F252C962DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD2D1C23DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8779D1A4B84;
	Wed, 28 Aug 2024 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWyTSIho"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024A381B1;
	Wed, 28 Aug 2024 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724863843; cv=none; b=jDj2+AxRALV3Eisw5HZ4bDHucHG56j5OhUfo3k/w9UEb/osGMO72FkliHrl7V5CSg1rL0Tbrh/OLMhikMtW6y39nQZwJyDu2KQoHPBXVkvm4erSMNXjuqv/ilu3xqL70P210xDD5IV0MNMDaBtHZQqHRP8aw0SoUUyCCGFE0TQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724863843; c=relaxed/simple;
	bh=uR4tAHN0Qo40j8NjOj3sDMr7CkE6cPZh1RNJqSRfWH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A2+PJ03kLAWTqHP9qyjJz0S6XAgy8vdeGeteWoP/kp/xYrUkmQ8vBFlQ3dTOps4Ktka3N8JDldb9v3d17wX11ZJcbQW61x4geoMKiqwUGNlfbpHf+VaPJqs7Y3HOppBbYkCj7B2Ly4vH81D3rfWL7/ckTjDHb00ki5ihO7d/39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWyTSIho; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7142e4dddbfso5477257b3a.0;
        Wed, 28 Aug 2024 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724863842; x=1725468642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud+SKCk3uZori7nNnaTbM6rzCLuKVUSqKZbZeSa/r8Q=;
        b=eWyTSIhozYYxjAC5AuqM6zvBZ1CMvOP/e80TrAcqRCY6FvUyHZStJQINfZGJRzBCCf
         f3Javdnuz1zgw2E5qW5/PmZmAovqAKRliIbMyC0meqz1KkcwW2JwBdrrSqsN95RtbKpN
         7zzNftu6iCb6a52cYhOWPIJRerPx/KEPE6+3ySRJd3wwbpUHkTHhOkinyHdNEzAzpIHe
         h3YGR54IzWROU2u0B2LrWPXa0yUDoqcL8ccpAkXEOyXdWd6sz/+xMa6T0Vc6YpL+k8C6
         AULYn15vXBhCnO0UAa8DEiGBjyuaC2VoNYQw7r6vvt04t1TJteV8hsJ4RhoieW6yY/Cp
         CVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724863842; x=1725468642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ud+SKCk3uZori7nNnaTbM6rzCLuKVUSqKZbZeSa/r8Q=;
        b=YX2sof8Ez+zg7EKwKsemMgNsGGc8sWBywPEmVDUBYIRGh+WAWl5EhQzJKTxeCN+/IU
         gbuGs+HVSaPat6sW5jDCTxkadhOhylh3SEyPlNScrm3jq8jcFPR6gQOWAbetM6hWzQnY
         CpWHdNyfqMH62c5Z8q9X9eynpJk8v8PqAxVmeTfBanOxzV3YmQibpc6JvYk0+Yqirh3a
         ndOuy8VLVmOFQePsKtniTCl88AWv0RZS4Kdbck6md5M1xc+oycYxQ6WPzwKHFHC1RfTM
         Xejr+Nc2JiWsmdI45jLKR7M4AnNUZ+EFZam/y+J39gY7ZoXDm9m6LaOV/7y4SxSdecKL
         gJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCV+aVPRdmykfquJ5hcb2GQ4dtXidzDqcjORG7X6F4C7w6hT4Z1aL69wXgsjfJ/8htP0CrFLWBxniRgHLdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/0KziqkDHdmGlHrf7se6BkHjXCi67cvHcmiQX4esRgSjg7jq
	RRRJzlmehGV186SuPJcEmvfG5+Gq5TvDK/O5wk88prUZnZl9RYCsthzE9A+0
X-Google-Smtp-Source: AGHT+IGBf1zglBAKgNy2Wg+je4t+CYmFFKHRAYFkHXYTBR+q3EUthHjqImdeOoIT5+GNfjjgfQxKUA==
X-Received: by 2002:a05:6a20:6697:b0:1cc:9ff8:eaee with SMTP id adf61e73a8af0-1cc9ff8ebecmr11040397637.1.1724863841617;
        Wed, 28 Aug 2024 09:50:41 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:e187:3f8a:c354:5c62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdcf7dsm9734259a12.50.2024.08.28.09.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:50:41 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] docs: scheduler: completion: Update member of struct completion
Date: Thu, 29 Aug 2024 00:50:36 +0800
Message-Id: <20240828165036.178011-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The member "wait" in struct completion isn't of type wait_queue_head_t
anymore, as it is now "struct swait_queue_head", fix it to match with
the current implementation.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 Documentation/scheduler/completion.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/completion.rst b/Documentation/scheduler/completion.rst
index f19aca2062bd..adf0c0a56d02 100644
--- a/Documentation/scheduler/completion.rst
+++ b/Documentation/scheduler/completion.rst
@@ -51,7 +51,7 @@ which has only two fields::
 
 	struct completion {
 		unsigned int done;
-		wait_queue_head_t wait;
+		struct swait_queue_head wait;
 	};
 
 This provides the ->wait waitqueue to place tasks on for waiting (if any), and
-- 
2.34.1


