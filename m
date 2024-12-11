Return-Path: <linux-kernel+bounces-440985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E90D9EC779
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AA7188B5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486DA1DBB38;
	Wed, 11 Dec 2024 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYJp3v96"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6491C5CD7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906393; cv=none; b=ec1GjNIS9EYXL3VoX1yAVKsB05S9QD+7DTIG6Bg/heeRXJJ8BIKknh1BgBuDZImP7a4tpjlBjwP97tq0HDUTVZHuoPGGoPTIgJhEVLvgNvPZsPsmNuwCz7Ow6QJfQxATU9/HcATtf7xPsUicOtv/sgI3+rJF09XqLfL/KqUlcyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906393; c=relaxed/simple;
	bh=6Cb2eXYbnDnF9MbV7D6DmbWpJZ3pLF6UlxkEtHzazGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsVqCmZgyVbj1QEu3nQJk7pBq4BhnSEqKwOXodCat2dbaVOaDzAqIidg66isf/PCSQGWvFiKwNzOoGQB/aoKbdIeaezoruwYJFXb5ou60eoBfpqf2LqegeF04TGovLyASzu3lfFAh1LxRw8kBUV+rGcRAtk2H42/pG0D4nAm0gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYJp3v96; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216728b1836so14893855ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733906391; x=1734511191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a9kKrqfGW0A54dxn1v83SDxNjg3jBwrNlLRh958PFM4=;
        b=ZYJp3v96jIffcQUojr0zsw35kBwWkHPTo8IzHj5r2IGBVxQ/Xq9751EYIh2XjXpPOQ
         rVAtPMYl/XidZAgsERNjK1Z0wG1CC9M8aUYCl3MMwVaGAyHPnJcGiNuXiUhYcpUuQIsr
         TGg3CBS/SWN0oGbm/1wUF/0LnFofl0D+hVdX3uEpe2x7FVXHdgb+TX62pktEtI3olrMv
         uGa/4iPCCj1vfrSJh3ytzmad/Y8HMwRAAnuoRuNX8xXnTTtNmh9l7fvDnbK/SDvgUkKK
         myT6/8iC1b7tiODAmMOdSVaaQjgeGCbLTFy8Q6FHRUkOfGvPrKKGXPVcbZfuhCKa0fqa
         /6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906391; x=1734511191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9kKrqfGW0A54dxn1v83SDxNjg3jBwrNlLRh958PFM4=;
        b=PJksZGrIkYpG8U2XZoQwEfaihPbk2VNFKcBxXGrMxXd+x5KH/5hoNMfxiduNwZ+Phb
         8mdb4TL6Z+6/3OQU/bP4HTNsxAl5jjAhPQB05+hj+ygZl2WK0Fy9FHJP4fMBiEADwlA3
         HfQPMt77EuV/IEzQKg3b28XD0qW3/VQ7AD9A9q0TSzWzMnzFcR0XjFAu0amV91dPQsok
         Uodx9B+pIzJgKWSguj9OnZyISq9mVM/VLxJJ46G3iLZj6rzShq3LYOW28xTqIZyxYhqu
         rpZmwhpw7vk/HozchB+fiEYSH8xfZXLbEpT0QzbSx1J9QvmPHlbC9fjCxr5LXdZoPfw2
         c9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWyzXxLGk/dbPe5nIu9uSMAGFqTBReiCwF3ZpXRKbn0PSYMTx9lgXNoqIue5bTl2xG5SiyoSgkC4ISvC5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ljObMDGrZ6oUPHpdArYW1m+0KAMa+uKChxIeUDU8f53kFpun
	YFVhzaj0NdUFOVnNeAe1NE4vzV6GqFNUsLrEloBYWNdgY52Xmnss
X-Gm-Gg: ASbGncunf6sRXgIZ7aTiqWv7ODH+Wl7aiQo7lJ/23EE31aPVJpe8HgPzrZIBTadq92o
	1UDLbz0PrcleVKeJKDAV7AqCQMBMn5H80HIsSxv1vD4tSS8pQaI4QM8piSvOpxukIy5fMaJnZ3Y
	6qioRBlHPrxYd1DBgjyhPefsqwqmY6P7JWxTZsEat/1ASx1n8DHcXCbpQCwByc+/ArKHsIX9bvA
	wcW1vzhUNI419mDQ7BuvZea73WHtZ2ba7OJ+vsVrfca4zaOVduNlgGpFIgNXCqJjg4JgYXaATEr
	qKaMEh+Wzw==
X-Google-Smtp-Source: AGHT+IH2WdpnBVNj09+ru8TRkcBQGhbYSw4uxyGvy2N4W9/3sv//NspxuQ95dh6osnLM+HprckO9Dg==
X-Received: by 2002:a17:902:ccce:b0:216:3dc5:1240 with SMTP id d9443c01a7336-21778508c51mr31249635ad.45.1733906391544;
        Wed, 11 Dec 2024 00:39:51 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631118cedsm67195655ad.150.2024.12.11.00.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:39:51 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH] MAINTAINERS: add me as reviewer for sched_ext
Date: Wed, 11 Dec 2024 17:39:45 +0900
Message-ID: <20241211083945.832294-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add me as a reviewer for sched_ext. I have been actively working on
the project and would like to help review patches and address related
kernel issues/features.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..788681fb209e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20902,6 +20902,7 @@ F:	kernel/sched/
 SCHEDULER - SCHED_EXT
 R:	Tejun Heo <tj@kernel.org>
 R:	David Vernet <void@manifault.com>
+R:	Changwoo Min <changwoo@igalia.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 W:	https://github.com/sched-ext/scx
-- 
2.47.1


