Return-Path: <linux-kernel+bounces-267042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FAD940BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570FD1C22EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034B01946D5;
	Tue, 30 Jul 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl98/i65"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01491194156
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328069; cv=none; b=FRtrqhsnICnhA02nzwo4gyU09UYStkZTdyFFGC694j9rdnqGdzjJLbb1X45eze+kmnapKK497WrvfRsUlabQUHxHh1g56RGeGd+bVxEzT+dQqcrEVTwSedWceXkGlw2eBPu1RV4GAn5WJz81DQQRS5ofPsBB+9g/2bsg8HahHEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328069; c=relaxed/simple;
	bh=OiO5UAluMGH15+ecE2HSNa1RCksWRZlw4yMoX9NzHB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OnWrSPxEdU6uasAbaWtGXIrIKMZ+gUHUblb+E1XbEdwF1QJXQtLuzx2f4pbv6voZYwKgbr7DUx60EFrGdO40q9kaj5+aW8TzJ7fo2tdcj76j/pmnOe73UsroMf/9f1psh79TqJUamNkNTNb0aDmKrJmQDASqSnV0c9e4kW1MTVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl98/i65; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-264988283a3so2573145fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722328067; x=1722932867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FD69V+SEf3VTzCz0q/lThcouLOtxPJMVTQPRVoHNK8w=;
        b=gl98/i65IBC+ysYRwfFs0a6f+ds7HNErWhcQV0yqR3ruv3A2VH8PIDuYR2YkwCPX0Z
         VhitLq7AehR8FQoNBaOYvTS0rqZczB6+PsEYUZ3b/mNkgE45UqBykPy54LZFF0JSf4X4
         i3Mq2fizyZnRGBWYvje8vbMIr6zW51puCwpaTPPbLhYvritR17JAv+QCEBjIKMpa81jV
         zYn975w2UAprc9mXGEfGcZUm+nUgMM+ukBVAadxrPGFI3MOodIG2C0Hi4UDK46k9eU+L
         Rci3PuObibpJ8qmGo+vNqW0Qw4HNd+fi64gY2D0R4PPvZJToWwqNaaZQw6OYVo9Jp/9q
         2ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722328067; x=1722932867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FD69V+SEf3VTzCz0q/lThcouLOtxPJMVTQPRVoHNK8w=;
        b=pat+NG7MclqBcxVkf/RaIdO9aQSpF+u2WAcpEXen9THzHzgNaOOzPnt8M/KV998bBY
         bxaGChY82DrI8vBwMt+AO/l7zcVXqV5xklxvDxCzP1YqtCYa5T15nPVyaFrv37qKwNcr
         CCbDMickCRvXSk75VXjkHgDIC7RHxZZ3JMRbPUYcz9VDuIi1b3/2Bj1i9VdX3zKs1eC+
         1+wYkDoGbDfIQ5obKnLsHIG80tSiqfy6XW2Y9KVyz9soNoPcBTsCzAeMhu5EV51Bpbq9
         nCEM8Mr0nraH0Cb4NLuR9hvbbNzZFGxJeOMRrc/abpHtFyranX0we9zq60ETqpgy5N8l
         55Dw==
X-Forwarded-Encrypted: i=1; AJvYcCW+JTgCdGesRWaizDKx7KdKDMCoEXN5vlMkbL2TX3RYesxun6sluG/1cKRfymRisfO3Owl76UzZJnWRRvk9yJdWd4XWT0hk/b3vD628
X-Gm-Message-State: AOJu0Yzm6FY5wVe92vB4xhlNoPE/yTSUYPz9A1uWn6ranBklwcD9+WMN
	nXbQ4RurY+r56S0iWpLG7KCH8Hzs9ohui1ETbDnR7nEPFpF+CJhJ
X-Google-Smtp-Source: AGHT+IGMDtjFzoJvTNv0HkvGGR2DW4nWS0t5fU/JDbdbj//BhkM0SEV5svR4Ogu5z/TQNie6PX8b6Q==
X-Received: by 2002:a05:6870:206:b0:260:e096:414c with SMTP id 586e51a60fabf-267d4f34e2amr12419301fac.49.1722328066831;
        Tue, 30 Jul 2024 01:27:46 -0700 (PDT)
Received: from localhost ([222.190.105.194])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f8751ab7sm7169492a12.42.2024.07.30.01.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:27:46 -0700 (PDT)
From: "zhijun.han" <hanzj.it@gmail.com>
To: brauner@kernel.org,
	linux-kernel@vger.kernel.org
Cc: hanzj.it@gmail.com
Subject: [PATCH] fork: Using oldmm replace current->mm for dup_mm
Date: Tue, 30 Jul 2024 16:27:25 +0800
Message-ID: <20240730082725.7477-1-hanzj.it@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation of copy_mm(),there is a line
initializes `oldmm = current->mm` before dup_mm.
This means that there is no longer a need to use current->mm for
dup_mm.

Signed-off-by: zhijun.han <hanzj.it@gmail.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 41771bde2ce7..833557bb0187 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1720,7 +1720,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 		mmget(oldmm);
 		mm = oldmm;
 	} else {
-		mm = dup_mm(tsk, current->mm);
+		mm = dup_mm(tsk, oldmm);
 		if (!mm)
 			return -ENOMEM;
 	}
-- 
2.45.2


