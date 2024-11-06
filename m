Return-Path: <linux-kernel+bounces-397561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27E9BDD60
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E52028449B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB3218FDBD;
	Wed,  6 Nov 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyHRpYGM"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E2718FC8C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861946; cv=none; b=hcNdrrC+jBOvNzMIcjqvUQbkceNu6G7Um0FkONW/iJqk2ZEed+RvKdLGo2paQoL+xJPOG7xWWOlGLro25cs5ilPJwplT/ZW3WKMUhnBP1dNRx9CLSKOKQhagkC57kYVFk6KXlhCvDdlhzvNNjRfCYhm4uAPLcJ9OdOCmcMceWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861946; c=relaxed/simple;
	bh=muPQDPmbSgck21JiDpDDSiXuIF+6p1CNkCqolNeuKvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sKXZWfQVYV9jfKJjNN4TRkY2MXHpt18nWD2E2RSGdPi0mMsPQBbcr6BQHFpy5MwGbW6eAjt9Fsp69hk/Bz9DYdt3QuVTA+cKLohtvEOhz3NPspMsFSEMxJFoNBL6ozgi1Js5Slq0VsCAcUG4OkhTlGVQ/UXoIvTr/8XOqu61pDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyHRpYGM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7eab7622b61so4727473a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730861945; x=1731466745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aewHjfrZ6LdC32tAimnrPMNKi9I3ZmUsMUDWVZFlpnQ=;
        b=JyHRpYGM1FyXY189Ggr9WgmJ1VunyydTQhqTEi9ZVQCvqoY1X7M42T+aXgxZwxNc5c
         SzR6jTKnJwewX55UUwr8s+SSiENHqOo2wakLQky0lchzFU3K1ODITN6ijD9xmc6OHv9j
         ohyxbXfJzIT+iXasQ64r6RJBPYXIdnqpQh9EsCjoVCwVzrfKLO9bdfBfPGAHRckkJOAu
         CujFafiwOkriZ7XKR8gvD8y6FXrgo5KcRqgOPbwtg2UGDQ8aQ5eF9V1gDpnDuXJ5dAId
         uuuX54xRu3BXB4Mo9P+gaN5jJMqhSRtnFSypkpBgDWFcP3GUwRK+VzSP0zEIe5KiXxON
         jGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730861945; x=1731466745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aewHjfrZ6LdC32tAimnrPMNKi9I3ZmUsMUDWVZFlpnQ=;
        b=gQKT29xwNZId3TmOWqGP6zuuJqEYlMhxZ1VlB4rg+q/3LZ198xIeXc99idopGBwOV2
         zMB+Pn3zke2iRfI5KbzmNODnDzgpcwVq6ZzpHESKRXVPw8lvY0RVok1ybDntZXnKbxKQ
         jKHrAa9HgtMur5Ne9F19GuNStj1LO28op9vbL8V5w/G8wPNlvPT5hdGCnuPNM4/l7w03
         9QDKfn7GP8hA1qOvASlIyN1jviHRLd1qyvM6NEetL08e703S6QcoQksFcc1AQbFuMdiq
         8sfvYGPGFzb7VKnJcUW7kMZIEDZiPWpPn4RQ/Wn90rFo9UzfF7Olnx53J2k1BvM0y60m
         8BcA==
X-Forwarded-Encrypted: i=1; AJvYcCUaMmc5U5g1yWcp6g4u3QWuEgOHMeRpLp2wHm4upYjMJkuiRHN8yPhMDPGH8556A/JKMrU9dt5daCCJ6q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywby8ctQRjqA4zRkZpUrmcFI/r16+FLuYIbkJuUGgOzdZdU9weV
	+blCULqiRS675OXRvnNYvAdqDz9arcVO0KT/t2Ks9A7KlEnu5iJl
X-Google-Smtp-Source: AGHT+IFdajRjrww28Kj6g8apacq729YapnE+XxbuyZl2dP3cf++buuS2ltWTyb28xBmyhhmYLCwozg==
X-Received: by 2002:a05:6a21:7895:b0:1db:ef18:d3d2 with SMTP id adf61e73a8af0-1dbef19ab02mr6658449637.26.1730861944721;
        Tue, 05 Nov 2024 18:59:04 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc2c4bc9sm10586996b3a.108.2024.11.05.18.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 18:59:04 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Yang <danielyangkang@gmail.com>
Subject: [PATCH] parse_options(): replace deprecated strcpy with strscpy
Date: Tue,  5 Nov 2024 18:58:58 -0800
Message-Id: <20241106025858.495458-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strcpy is deprecated. Kernel docs recommend replacing strcpy with
strscpy. The function strcpy() return value isn't used so there
shouldn't be an issue replacing with the safer alternative strscpy.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 87ab5696b..ee8861b95 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1158,7 +1158,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				break;
 			}
 
-			strcpy(ext[ext_cnt], name);
+			strscpy(ext[ext_cnt], name);
 			F2FS_OPTION(sbi).compress_ext_cnt++;
 			kfree(name);
 			break;
@@ -1187,7 +1187,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				break;
 			}
 
-			strcpy(noext[noext_cnt], name);
+			strscpy(noext[noext_cnt], name);
 			F2FS_OPTION(sbi).nocompress_ext_cnt++;
 			kfree(name);
 			break;
-- 
2.39.5


