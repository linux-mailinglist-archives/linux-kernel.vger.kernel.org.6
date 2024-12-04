Return-Path: <linux-kernel+bounces-431617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C969E3F81
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B14281AC1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0F20C462;
	Wed,  4 Dec 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8abmQ8l"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734ED20B809
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329296; cv=none; b=nsZ2Z9AAy263HudzM/Pk2aqJl2l9+plLLDoH7CdjuOJMzAPrW1PKzN5hZruS48sSpX57NIrEMnrJdItQLxz4oXtM9mnS2Iol6znJGPNJjSsT570kwZOblD4QQYz1/l5Tm/BcTMt6qnVTBnKD5xzTw8uEhjCI4s/tW4Uv7C8MkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329296; c=relaxed/simple;
	bh=a6WjITYDh8FlQbh3cr+ztIE3gMFYDSCNCAv8bVk/eYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpCodLVcH1tkavS753HCWdSInv5Nq0E5G4r7WJmPIw0e9WTiXmAHTYSCFUS1sA27pkSGRONmHd6r2Oex+XA3R5A3YAAB2eSdbmb8VR65+TUBc8EXWDMSr8Y0nyQjdpW0juegqhsnWckVrEahTSysUnOJFR7QF7ndrMocsx+fU1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8abmQ8l; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e1f12c82so4902790f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733329293; x=1733934093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXdDkWsDnFtUrE2+z+ujQNEAqNP+3i4+ZyErVIQ9EKA=;
        b=l8abmQ8lj/6Ds5NYzpQNWO2vYkW0UKJ8bsqphnqGhp8U6EdaisUHj07jMru2rjUwax
         koz0D1AqTIeHilMlwY3VNBFXj/iZZmW4CqID3Me0NBM+PpplzLXtEMuTMgVQxBSkp7+l
         UXBDAh6BJq6JQ1L7FSfpnY2GE/opXWTV30jtAC46oGAIfG92C3206AErYPH4GAKPKbeT
         fn48y59gNKALBW7qWjgVg5rYwS8+LLskrJhUa4y1d9f0ECdaKQKendmTNucrS08WPn9N
         +ulFJe2kDxzwaripRYus2chLK4c4cXf7j3hkK4EDtEtFrLbe9nv78+9SSKmNgDajTk0Z
         NZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733329293; x=1733934093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXdDkWsDnFtUrE2+z+ujQNEAqNP+3i4+ZyErVIQ9EKA=;
        b=pEDrqR6etDpJlDhDphPrah2OgZSOUnZehv0OcOOWMKXKndMRshtzMRFsskk33cE4fD
         ypuksDwnHKmP7lcvqu3YxbKu9NHNBmhJYtrsMiFJr5zY7yrkHrXsRPn3ipaAIVVkSsdO
         Li0iuG0GsxJLQfN/5SaWx332gpL2i4e8ZxJif/ftknVfKsrCxcWXHyB9WAEiVR5rcoml
         fVE/H4iHRoFZDWcnRrQIGocCrltNUdge/u4xxvFjvPPrxDPCN4g9NlCyUbv+WCSWj1oy
         Vr4fQ83YVEHuZRSJAiL0156A7qpYWy4fY37Pt946RMgcgOhl+9Fmu3FVSenVl3LoqceB
         +iiw==
X-Forwarded-Encrypted: i=1; AJvYcCXeigT6NWyD0PZXYOk+mM+l6Etp2rKasIYno4t3FrruNhobvGYfUYbLfQkh+JcqYVUaYrfMHiQB7Qf6HzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dxZdF9cexQc9gzalv6Hq4mxV4ClndTC9dEvKf3UlerYbmiyT
	xIvvFpqmzsyURniG4bDZVWxs2Y/aylEyvT0qKCjAcgdq8mLAHmNu
X-Gm-Gg: ASbGncvYVCLBmYVjtkMwVIVov+v6UgRMZo+KXUgjPfJUiBUEzQVz7HX2k7URxfBHE5H
	KcRLdANmHLy7G6fNoj745qFyYTDzO1bM1fZ2nwetLSjkzu8Ba/ASdsYUVxnO4FanzFxnQSKP76k
	VX4TIWuqItaKohBZIb3838zqPeTdGWCicvlIF9x/lxP5F74Ap3kXaApE4INIb+3P0oAUvrSv+Sw
	ShZqRatBn8PsJI2u/luTJEPs/S4oJtc6fONJgo40LNYGElMxPLpneWcH+CsHRtzd4Io+SodTZ4E
	NcQ6TnSKHg==
X-Google-Smtp-Source: AGHT+IEw1stCh48pN2T4EgDGQFXpVxFIxkZLFpmeriseUp2AmBTMzqWCbk3SxePuXPXryX7tk6wu0w==
X-Received: by 2002:a05:6000:78d:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-385fd4350fdmr8134370f8f.36.1733329292574;
        Wed, 04 Dec 2024 08:21:32 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385f0d38a89sm9705177f8f.97.2024.12.04.08.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:21:31 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5] staging: gpib: Fix i386 build issue
Date: Wed,  4 Dec 2024 17:21:28 +0100
Message-ID: <20241204162128.25617-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These drivers cast resource_type_t to void * causing the build to fail.

With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned
int which cannot be cast to a 32 bit pointer.

Disable these drivers if X68_PAE is enabled

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index 95308d15a555..6cf05586ca10 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -50,6 +50,7 @@ config GPIB_CEC_PCI
 	tristate "CEC PCI board"
 	depends on PCI
 	depends on HAS_IOPORT
+	depends on !X86_PAE
 	select GPIB_COMMON
 	select GPIB_NEC7210
 	help
@@ -62,6 +63,7 @@ config GPIB_CEC_PCI
 config GPIB_NI_PCI_ISA
 	tristate "NI PCI/ISA compatible boards"
 	depends on ISA_BUS || PCI || PCMCIA
+	depends on !X86_PAE
 	select GPIB_COMMON
 	select GPIB_NEC7210
 	help
@@ -85,6 +87,7 @@ config GPIB_CB7210
        tristate "Measurement Computing compatible boards"
 	depends on HAS_IOPORT
 	depends on ISA_BUS || PCI || PCMCIA
+	depends on !X86_PAE
        select GPIB_COMMON
 	select GPIB_NEC7210
        help
@@ -174,6 +177,7 @@ config GPIB_INES
        tristate "INES"
 	depends on PCI || ISA_BUS || PCMCIA
 	depends on HAS_IOPORT
+	depends on !X86_PAE
        select GPIB_COMMON
        select GPIB_NEC7210
        help
-- 
2.47.1


