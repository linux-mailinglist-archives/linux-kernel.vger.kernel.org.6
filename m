Return-Path: <linux-kernel+bounces-182919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A7A8C91AF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3D71C20C9A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62E13E478;
	Sat, 18 May 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifyVAzgV"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B618E1DA32
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716051527; cv=none; b=IdmKhrr2YXLgKydUVcebOg2rO+GrJh33ydlW+quPU8SEiJS95OWgDyE17I3HDAim1gEWpwL4CnjI7ihJ7UFxmnMIJONwgMHUDaS2bM3FP4eC/MbLJLjasDLmK/HYiG/1R/KuN6Qj47Sbbvf1SxLl9bRNpw6XGGdC4+anXgXUbR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716051527; c=relaxed/simple;
	bh=+XvZ6d4i182WKkKIFekI5zg0hoZztDTHBp6z/XoY50U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VyDGD+hr2iDULzlhrYmOOzFMQewwe+4cJ/7AAsaaEWq4oB9X+BmrHsEgfXMthMc8+JTBPAS3+xIV4QuGxqmTuHEWwyo5GtOWadHV5MSfgBs524cSJDSYD137SHJW2ZwlnKGf3yEU5mhFb4MhhrT1lx6T1MAg1QCo+av2kQeab/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifyVAzgV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ee954e0aa6so3721435ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716051525; x=1716656325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rTukOohCbA5F7xEgfP8EP+gEt6jl+p1n2yxKJs+r/CM=;
        b=ifyVAzgVEsZDpLtmpi5iUgdm4f0kNiVmJ6ZN/wy8XmVs35Il0ux/lCwu/2/uqHLRge
         pWauNChBfEX1RqIV7kP3C3puQNi/MdPI8mST8xuxGy3F7R9Hyq0LTok745Bkupfx6u3c
         8P4G+PrS5hQWp349M4RI4E2ayUYrv8vvnrBOnUurFyRMWPvDPiJO5Lzkyumy2JCI+Mqb
         i+iTSR9VSQwA3WcO+czg6vJjjXJOqqSkTasEzRfWUuZ++Qy7KXeHPMH3bSWO4jhQ+CZU
         1mwYsLwtc0Bl+Oig3P+aFgSQHmhVvuK7+sQHnYHZQDLC7ecgP5VP6ChA9MnChNLnNo/z
         DcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716051525; x=1716656325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTukOohCbA5F7xEgfP8EP+gEt6jl+p1n2yxKJs+r/CM=;
        b=fcvngic0JXzk5ZNJruAUreV8Lj8YrqKCtlB+KmGyEPeLQmj7kqZrDqScnQNotNtCQu
         vzvDFAFXfd2SC6+NyF+/5nZHjSQhCFo3C5GqWau5R2NAtt4jRfNU4iXXcgT7T1HtkGsS
         nRtuYW8LOyNDITYDWy69woVjM0UZ9ag8wTCrVqLYwOSGlN6xQ5LUR+9NsA5x0jTWGV5K
         AJrbvfDZ0iYuFKjuGtMu5/ygdayjLrCz/el1pAI9DIkOuAWyqU95h72EZ+U7etaZFq4G
         XdUhuAz+TW+rF9bdKuhd9BkaoCDnlPAIz0lInYty4bIKZ/TEtnEyHSbNX1c7I7hMP8aw
         IW7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZbWyAJMFrSntKQzylwOI7i7MaVbB8R86uArbshOxBnUjpYW3EZGTF5Lj1BpOZnz/Q8OIQFjJijC0JeW/mr75Uk07ti2Q7Ua9+/Eem
X-Gm-Message-State: AOJu0YzQs6Ig2BJLVx7vNN+IsqtJaKEo987Stj46wa67wFIlfUgmOKcB
	GO/C571uEtK1dHUVqXYtqHLv5drrwdQFZQXTMyHNSj5DzY8L0CeGr48Z9/661gk=
X-Google-Smtp-Source: AGHT+IGWTwojRSUx54PlrPIRbCX2SnMpw8DyaPWMR0v4yghfUOM6EWROnUfONnTmNpNSDj2bOy2pVw==
X-Received: by 2002:a17:903:98f:b0:1f0:79a4:6847 with SMTP id d9443c01a7336-1f079a46b66mr190933405ad.55.1716051524761;
        Sat, 18 May 2024 09:58:44 -0700 (PDT)
Received: from localhost.localdomain ([136.185.82.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f099518969sm56544635ad.119.2024.05.18.09.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 09:58:44 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: srinivas.kandagatla@linaro.org
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Remove redundant description in struct segdist_code
Date: Sat, 18 May 2024 22:28:40 +0530
Message-Id: <20240518165840.29415-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove redundant description, ensuring the documentation
accurately reflects the structure's members.

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
The documentation for struct segdist_code contained an
excess description for the member 'segdist_codes',
which is not a member of the struct but rather
an array of segdist_code structs.

 drivers/slimbus/stream.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index 1d6b38657917..9e7983507f19 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -18,7 +18,6 @@
  *		and the first slot of the next  consecutive Segment.
  * @segdist_code: Segment Distribution Code SD[11:0]
  * @seg_offset_mask: Segment offset mask in SD[11:0]
- * @segdist_codes: List of all possible Segmet Distribution codes.
  */
 static const struct segdist_code {
 	int ratem;
-- 
2.25.1

