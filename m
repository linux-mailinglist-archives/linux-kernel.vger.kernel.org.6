Return-Path: <linux-kernel+bounces-251524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C49305D4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10981281D90
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959721386DF;
	Sat, 13 Jul 2024 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTxVq6xv"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A18BFF;
	Sat, 13 Jul 2024 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720879500; cv=none; b=madqTfU+jMw4IagPrteV35qufz2SbAyt5tPkwtcMvBQct5IcWsOu+6NgO9gEAGXid5Asgv3SPf6O1zsPYTJm9oI+WBN9okwRoRi1GnRL/oda/34ikEJMUOH7RgZN9V7hJDdOf8UK3CKTX9K5eK/rw+TkOTzFn+PburBuEXb7Q8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720879500; c=relaxed/simple;
	bh=+JjPg/ynR210yfPecduwd0IkUI6e+zEV9+ZDkl3p/gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ks1elDXHMq9uUwANxd/vQAzVFhlM7+X7L8cNqaMjLGrIk+PSaq9sZLcEOUXMuRa3hTVLLyL5TN5s9zuq1RCxljVxb5U37oOIO4x9jZ5AgSlrGItz+ANaaF6WAPz4vT53EE0IhjSlFjTASfQzSEktxUpz4LQZEM8V4ywRQh54BEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTxVq6xv; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d96365dc34so2330369b6e.2;
        Sat, 13 Jul 2024 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720879498; x=1721484298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YL0cATNIDQXNGuBmgfBZv3zmqaEM0VVnU3yAgSMA/do=;
        b=UTxVq6xvr4ft/PHC5WxUp2LI2RHKiwTWqKGIUwX4wQ6YmH+Clzk6rtSRsN4xDzw/J7
         /V1BlC8f1LW9cSgOtPPoEgdKzHBfWO2eW4+RDAYPrjS3UsbnviJOVFFj5glRv+RBbf3r
         UQmT/u5zn+vkfqt90IUabbZn9JKpPEHSXbkzysP/2ClAvFiq9Vno1JOBUnxmM1a1SLG/
         gRIZs9tvGSyq6pp23b6aqNoxFYMsJKt9AV8j9Sjh+iZNgvGtmVsL3YnYYQGM9+jkhns2
         b2372thkRrIZoO4FKY5pCkMUrKOzZdr8BZio9Scux1BYfrzy0h1GgmEiCEqp6m6ZpBHp
         esyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720879498; x=1721484298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YL0cATNIDQXNGuBmgfBZv3zmqaEM0VVnU3yAgSMA/do=;
        b=Zl3JrpAV70lKsDUDRzWSIgFrOgoXugOrEZfXu/ltSHpfw8+wH8NnGUYim6Oqt98atL
         F448y472D2VJlLiXqowMAMJTkszqJ1Y4rIQVO588WtH1Sw159YVr07+fjf37cW+vLZir
         NsjXefapa6wb8dFWc7FE9v0LUFQTCt9g6rEikdC5GbDoAxudPAfrQDn5xqbv9TBmH0lj
         2Qec+nTXaOuIDwioMmcGjqSlap4HBD9MaMQjAu0gamvki+8GvC+P1gpxd74ZPR+vIsjA
         NN8N7pi1jumDc+abB5qW71Kwv+DyUUr92gzDI9qrft2v7a3IPK4L2mWNm0aoDZcZkq5a
         FmDw==
X-Forwarded-Encrypted: i=1; AJvYcCXeLR8MREP5ZhsBzKns7ABJI+dZghb39f8ueUmaXiSLDRX+up6xIGuKaR78AGfUnr8x82uJK1JYEZinKzhoSYaiWYBrrhdNLgtms49nbum4d2TdB2D5mPEC1G1+9ObiMfIlrIttFiJR
X-Gm-Message-State: AOJu0YzHobpDK1rWhaveV52OtgsuFNgbxPfRwqRa2gJuk+M1Ij0fOGZk
	G1jnLCT9ey4NplflwuV5EcLGBbERghNl3FYicEi6Bp7vgARM/eSJ
X-Google-Smtp-Source: AGHT+IHCGZrhgCeHYGZ0Gh8Ey3ljPsZV3Bz0dMlJmy821JAQdVFJxRmvO0afXBLOfizd2hy3gEbhcg==
X-Received: by 2002:a05:6808:1b2c:b0:3d9:2e7e:53c4 with SMTP id 5614622812f47-3d93c046573mr18042982b6e.34.1720879498541;
        Sat, 13 Jul 2024 07:04:58 -0700 (PDT)
Received: from pipaware.austin.rr.com ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dab3e0fa9dsm192463b6e.39.2024.07.13.07.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 07:04:58 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	sergio.collado@gmail.com,
	peterz@infradead.org,
	rdunlap@infradead.org
Cc: bilbao@vt.edu,
	jembid@ucm.es,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: [PATCH v2 0/1] docs: scheduler: Start documenting the EEVDF scheduler
Date: Sat, 13 Jul 2024 09:04:53 -0500
Message-ID: <20240713140455.4072847-1-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I was in the process of updating the CFS documentation, as Sergio proposed,
when I realized we don't have any EEVDF documentation to point to. I have
started it. I know it isn't a lot of info about EEVDF in the doc, but (1) I
wanted to get the ball rolling, and (2) I prefer to keep it light until we
have a solid idea of how EEVDF will actually end up. This could take a
while. When or if it stops being an option, we can revisit it.

Sergio, if you’d like to update the Spanish translations of CFS and add one
for this new EEVDF doc, please go for it! ;)

Thanks,
Carlos

P.S.: Jon, I have triple-checked for compilation warnings, but if you
      encounter any, please LMK the versions of your tools so I can match
      them moving forward.

Carlos:
  docs: scheduler: Start documenting the EEVDF scheduler

---
Changelog:
  v2: Move file within scheduler index. Remove incorrect subsection
      numbering.

---
 Documentation/scheduler/index.rst            |  1 +
 Documentation/scheduler/sched-design-CFS.rst | 10 +++--
 Documentation/scheduler/sched-eevdf.rst      | 44 ++++++++++++++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/scheduler/sched-eevdf.rst


