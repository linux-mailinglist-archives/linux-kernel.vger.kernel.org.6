Return-Path: <linux-kernel+bounces-320353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4F897093B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 20:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E813C1C20B9F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 18:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838E7176ADA;
	Sun,  8 Sep 2024 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lClReZ9H"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738226281;
	Sun,  8 Sep 2024 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725820677; cv=none; b=YuMqIsp7X14eTX9L1VKqv/QyS4+9q6Xfd9C0aVFIY2ILlcHelhbP7sX281Ob+EylSs88KEBUYPXfu5u17sucLqcrpGQiM/d5QtHc1o/01P/8l7OVVg3+AYVaeBZA52OhQoHojTccL14gH6m3+OXloKL/LoZajBw49rKFOmR69C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725820677; c=relaxed/simple;
	bh=b+Q7cPnCeO/yx+y2/RMNcMrxOGmRA0EmdFI5lGTo+oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/rvh1qfNgYoUxVcS9NqUr7KfKJcn1SDxWbDoBmOQcC8J5U5Bst+72zukxaGS8icIzX77/d2ezd+zK4NNdFuCh6OWdG+GTHUDPJVA8xnhOE7/DrNedvXFlWa6VzuY1jHl02sFh5q+EbjK/PdEre20VzSOr/gI0gGw34BToN5hjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lClReZ9H; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c34c2a7dc7so24874866d6.3;
        Sun, 08 Sep 2024 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725820674; x=1726425474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cokJ6ZaY1NJlTrapog+7pjsTEDaduw1R6NmGJPrMiuA=;
        b=lClReZ9HXgyGuNwPV+RBdoFrA7dBpTpHL7vOLrvc0R5J6brU/A2e41i2awwc2xR9xB
         9hzZS491IOViVvdmLCa4/RYav1XiG5K1QwvAYbvtZkqnWtTM8mjaRVJLFIBx55TX0f7E
         iacw6e4DSCdoP88saqtwSMF/JtH89QBpcCJjRTPqGsqIiJn15Dey6bFWOdXO7yWx/eZs
         yr9IH4vE+/F4Qopx4w8Gr6T0jtSr51BpkcJIRFKQdA8R5hY0G6cU+14Z5VtTiydNo1jK
         WarF6mZGQx0RDxFpMlHo6hCsEGS3Gps9/m5HZjLT1BbdOotsFw44UaJwmtjOAUCgBi5z
         zW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725820674; x=1726425474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cokJ6ZaY1NJlTrapog+7pjsTEDaduw1R6NmGJPrMiuA=;
        b=RNBS6rqW2SxLFHS2RyYviQpEHQOP3PPqcClIGY7es6WRuxHLWqsj8kA3+a/MaLFoBG
         UmJ6fnu4HUqWEaCnftQopDjeptRwPw6UwT4+PF1OyRzBWhaHnowjAvg/tcUUgQ1IvLGS
         IR6WoYlKcN4xuUmM2w3gTX2tC1Dr3nb/xSfSaimyLaW5HjmyEY2U/IvQzW0WinUqOSzX
         aUbQDA3uwKLNA7sz8e90vVsY/45j1MSurybvshlV0ijslSz9GQGg3waRct4xpijovuCI
         FOdsLgvYlHuZTw3pCveaA2qthC1SyFyt2x+EG9oT2mo8e+NjDlIXdoaHF709qcsfekt2
         6nOA==
X-Forwarded-Encrypted: i=1; AJvYcCW5EkCkCoTmC6jtnQFzYPMkaC9vWYhl8LTkJGNEwqK48N1jjGC2TYjctoB8hCGjQaWoZoewQ4uc5hetjYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcwNnOVfQpYAWZ2AVf40nlSk9mB3sWQX7duYytM2tyz6ZrV7G5
	7bsFWw38F4vpc8Yc+OmRCTxSfooERnCnDT/4Wiq39uKnlSuEkL0NKigyyp0j
X-Google-Smtp-Source: AGHT+IEHrt6A7TzSa0lTe2OJ1NUtGz3fRD6hrOwD5WIiB6XtDqt1h6LlKgqKAg3IsDyg1I1kLSHQMw==
X-Received: by 2002:a0c:fa88:0:b0:6c3:69be:a3e with SMTP id 6a1803df08f44-6c532b2cd39mr80096156d6.43.1725820674287;
        Sun, 08 Sep 2024 11:37:54 -0700 (PDT)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6c53433989fsm14462516d6.31.2024.09.08.11.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 11:37:53 -0700 (PDT)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Lam <dennis.lamerice@gmail.com>
Subject: [PATCH] docs:filesystem: fix mispelled words on autofs page
Date: Sun,  8 Sep 2024 14:37:42 -0400
Message-ID: <20240908183741.15352-2-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 Documentation/filesystems/autofs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/autofs.rst b/Documentation/filesystems/autofs.rst
index 3b6e38e646cd..1ac576458c69 100644
--- a/Documentation/filesystems/autofs.rst
+++ b/Documentation/filesystems/autofs.rst
@@ -18,7 +18,7 @@ key advantages:
 
 2. The names and locations of filesystems can be stored in
    a remote database and can change at any time.  The content
-   in that data base at the time of access will be used to provide
+   in that database at the time of access will be used to provide
    a target for the access.  The interpretation of names in the
    filesystem can even be programmatic rather than database-backed,
    allowing wildcards for example, and can vary based on the user who
@@ -423,7 +423,7 @@ The available ioctl commands are:
 	and objects are expired if the are not in use.
 
 	**AUTOFS_EXP_FORCED** causes the in use status to be ignored
-	and objects are expired ieven if they are in use. This assumes
+	and objects are expired even if they are in use. This assumes
 	that the daemon has requested this because it is capable of
 	performing the umount.
 
-- 
2.46.0


