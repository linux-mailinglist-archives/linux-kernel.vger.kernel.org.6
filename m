Return-Path: <linux-kernel+bounces-358421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E008E997F21
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1C51C2323E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19561CCB25;
	Thu, 10 Oct 2024 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTHZV3nD"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3921C1ACF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544231; cv=none; b=UaRMvdQz80uadspxtLehXsaAn13N9LOFEj2OYunolYld+Vq7FKRmeM1nS7yiE2o3/L8SkNlRYpP4AM0F8WUfNiifl+5gLjqCR2U+Ap9U9NOSN3n3jwDYqlQun2Je7OMG25kI0T2u4Wo54CZDSmWpWTLDCgbAe4ZjUhZip8frSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544231; c=relaxed/simple;
	bh=VE5E23zJX+cWOKOIHdq5T6w8xM6pIZNJpwdFRgWL3q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D9cOUtl1SionFWYull5H8YaQeby7VMi1O9vYsNbrINb24vqNGsxlMd9bu67O6SvODR8qt1NI5+DzA5BpzV8ziWR6W1ONijG3oWMewpe+j1FP8a6bWUULvM26e+3p3yLEueSIscfvy+UmWASDn+KpiHcX7Ueng47ddRCjzPNSEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTHZV3nD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4311420b675so4572245e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728544227; x=1729149027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=feRwyThEjIGhLEb3VHNlhVmx856Xi2sfTY3h8PSPA3E=;
        b=TTHZV3nDk06XDEdNdZodYYPMSSiC4WsMW46z0aXLeJxK/hwSpxp1GLZzhzD4CanmjP
         LvPWRrYXHsH+OIFz7dwgBtrMAlgc/VGcgOAyUEd0Xy3iZuTy/s7Fny6ryX7RfEIOQkD9
         0XMIxEfT8O+M2tq5+eT0GiYAj2r1C8fAnyYF0FYtcqZe0mbqSm/aUjMMHHNvflCRFHUN
         adU2da/PcZZSQx8BxxldH61YMYa1Gmb314GifqeNvi1c5Jlexi2DVFTzdN/ehs38uLQh
         vbc5f4hjlCMW5+4gRm7yuqlnrDR4JxEYCj+yKrDRLvicZAlxbD5RnCyXmQ9JfEiTLcC8
         7rGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728544227; x=1729149027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feRwyThEjIGhLEb3VHNlhVmx856Xi2sfTY3h8PSPA3E=;
        b=k6GErhB8YSBU0WME5sPsHte7rBJOXpa4tAe+2S+IWX60k5GlUCNjEsRXjdkjo7+dBK
         F3zfg5AHZtdKGlibEFaRschiUCUrxu6JXnzvFSMO1/nDqgKWVRxYmle9IMecyKZrxK4K
         Rg25GtzjWln5qsudANWRXCh8Z6vfqAue9wOmo8q73wcNS0TyGSk380Z0ZysPN35Esk6B
         Nl1lqYQmvNBbfisExobz+P4F5005H789yybv1kjmcEAfwz1uJk7LV0EBzoEXwR11QIcN
         b+vsyyfsCeCjoIL23q2urKEKTKZGqAisrp4pbbt3D9/0zsR0IkJnTO/H2tL+BoX5iGEA
         XI9g==
X-Gm-Message-State: AOJu0Yydo1Df3bIYFqk+85rHw1CYzTgeNYf1iQ7zuT8ocCaQ5RDdy/G7
	7bn/xr/GvucN9cACEQfa6pdGtRc2dehM0SMxa//Ei/w6XG48slyff66v/2JD
X-Google-Smtp-Source: AGHT+IE++zbq8WtiFqCVeh2kXuU0kqB5v2IGYJVOOKR3wkSaxnIYIxA9ZRID+8TPyJ4ZLFKIwApuCQ==
X-Received: by 2002:a05:600c:384c:b0:42b:8a35:1acf with SMTP id 5b1f17b1804b1-430d59b77bbmr42676655e9.25.1728544227270;
        Thu, 10 Oct 2024 00:10:27 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d78dcsm7011115e9.5.2024.10.10.00.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:10:26 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 1/2] futex: Use atomic64_inc_return() in get_inode_sequence_number()
Date: Thu, 10 Oct 2024 09:10:04 +0200
Message-ID: <20241010071023.21913-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation and ease register pressure around
the primitive for targets that implement optimized variant.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "André Almeida" <andrealmeid@igalia.com>
---
 kernel/futex/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 136768ae2637..3146730e55f7 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -181,7 +181,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
 		return old;
 
 	for (;;) {
-		u64 new = atomic64_add_return(1, &i_seq);
+		u64 new = atomic64_inc_return(&i_seq);
 		if (WARN_ON_ONCE(!new))
 			continue;
 
-- 
2.46.2


