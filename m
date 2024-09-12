Return-Path: <linux-kernel+bounces-327322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E5197742B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8428A286569
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD6E1C244F;
	Thu, 12 Sep 2024 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBPSOGQH"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA96191499;
	Thu, 12 Sep 2024 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179435; cv=none; b=dWqc45C2Ct2mKJQCP8zTrSdq5BLdWiuS1FHCKUaN7T5jVZ9LJzcuxMFVM9PpFYGjHZj9WB9aZj/u8cklz7joO3jQ0YCUxigcdv6yZG+JoAomauhm6S37f+HCXwkz8mkD2zafwe3OzGJVunuWa53PbWHjNenkgtwCcAeFBBjHbDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179435; c=relaxed/simple;
	bh=HidIV7DDUgoMDR/lsc3IlvUu2n4hxyNhY/8G5N5MSG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=olEUA4cIwjk9zXC6r8J8C2dogDNd17EPeg/V+98fEvO52YKcTbg0EO2DIe2EcSizctGVTL2b2za5bScje4Z7JnoKpeGYX0D17mpvJD4PeVB+VoOMSwssN8Hp+/+lPNU1mi6qOGbwD17wlux3TTMPVbjMqcGCvPLgMnNaeGDVLU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBPSOGQH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c3cdba33b0so1743318a12.1;
        Thu, 12 Sep 2024 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726179432; x=1726784232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v7SCT3NfZbXaabFDnIi01F/xMGXBpljgamt0TyRucKk=;
        b=cBPSOGQHBcnOf/i2OitpD07rwce/pnF0BsmQ8mxv5IwT+j6NQf7SiDUJgM7c+yPNTz
         thwK5qyVMGFFQGOIcMedKrvYn3fiId0fhT2oj63qRSzkqLucmxpV4NlCDsqmWlA+GX/O
         Tm/5qtT3PFbJo3yd7BOQMhHkfhD2SpORu80e8tFLalK4Es4HI7PsQMEa/40stNYzeaLQ
         5dDHRn2RwQohBNu7utexFjDa0c5ab76NZfQKr7TVgek0tJ5EyVzymZtNu/YU+Lh30p99
         dA9IRdw2Bed/xlXGgLupHJJmlyP+Q3rkD+plR3tevLWV9fky9vNv0aIJd1WFp7vY20x2
         AUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726179432; x=1726784232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7SCT3NfZbXaabFDnIi01F/xMGXBpljgamt0TyRucKk=;
        b=LdpzM2qqzlIpH4MaXJ0ltmHbggWbJZGy/+d/lti7AsfGPMwX6T1i+v3zwVhL0sVkqs
         m7bM/v5cygPvAR1BwH+d5m3P/X+UwaqiDyEUX3NaiTTA0h+Pf3N9DGk6JKJcnhXEUDTj
         yxJRDKfW5gSW5Y+Fyp6soUYW3Yl59cE/fVaDtfJHsv9Dz0/pksGy1OZboASiJapqBUus
         XgojZD5pmBKAdbt2qpFRFZTcFY5f+6M7XyyhJT6b4qQvV3l89EHSYjtquHKYzl1DbPky
         crO/dZGn/Gs7XWYXVVqDFmEshqKeWA3i6GqdisW4ZdxtKNcaVYFs3nMgpLIs0+CYTAuo
         04ug==
X-Forwarded-Encrypted: i=1; AJvYcCWAbGEXPYiRhpKj/rpzHeZewdhuTOoaldskJxqBYX5oBcra4WXhnI65Ctn1m8cP4q2zeoBc8F3PjCmm7Y5P@vger.kernel.org, AJvYcCXd79yKj7ce3V/vEyIKRRZIB5Km6I8MfJrvEW7EYB6QD2IHUTvFKYUxGVMNmBH2MnsURQDNFTy8tKk6@vger.kernel.org
X-Gm-Message-State: AOJu0YyhoGRtAAc1EuSz56s4gyt7TxxpUuePKXgyDVGSGq8LsetWPuYp
	mH9dNU2w4Kc4cI2ytW8JWEJVQi5ZRnOWyDtENlDmLNbk8BYmFWjf
X-Google-Smtp-Source: AGHT+IFS2M6dUVeQLtbTr2dm8i5twGkBYjiXzeooE8U5RTqMdS39Wv0PiwAAu7cWkskDQXFtB8a6IQ==
X-Received: by 2002:a17:907:7e92:b0:a8d:5e1a:8d7b with SMTP id a640c23a62f3a-a90296180damr427049266b.43.1726179431476;
        Thu, 12 Sep 2024 15:17:11 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:85e4:cf41:16db:65d5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5491asm792195066b.198.2024.09.12.15.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 15:17:10 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: robh@kernel.org,
	saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v4 0/2] Use functionality of irq_get_trigger_type() and
Date: Fri, 13 Sep 2024 00:16:03 +0200
Message-Id: <20240912221605.27089-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series is compile tested.

Changes in v4:
	- Use Elvis operator in patch no.2

---
v3: https://lore.kernel.org/linux-devicetree/20240911160253.37221-1-vassilisamir@gmail.com/

Changes in v3:
	- Fix syntax error in patch no.2

---
v2: https://lore.kernel.org/linux-devicetree/20240904160239.121301-1-vassilisamir@gmail.com/

Changes in v2:
        - Split patches to subsystems
        - Use DEFINE_* helpers to define resources

---
v1: https://lore.kernel.org/all/20240902225534.130383-1-vassilisamir@gmail.com/

28/11/2024Vasileios Amoiridis (2):
  of/irq: Make use of irq_get_trigger_type()
  of/irq: Use helper to define resources

 drivers/of/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)


base-commit: 32ffa5373540a8d1c06619f52d019c6cdc948bb4
-- 
2.25.1


