Return-Path: <linux-kernel+bounces-345636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE59198B86C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFE01C2233A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C3919DFB3;
	Tue,  1 Oct 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="kjkrqz4C"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5B17BB08
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775217; cv=none; b=EMwSAW5ABqC/7LWMIPzvW0XIo31vHs2Rg7Dnse6OCMearMF/cqN0OLtkxzCwDAVRhqH9tp9+l3ttoe1Q7c1ALtLQLZsbGXeQDvDv9TgGMFaPy0eFDX6tN1AWvRxZnMRSRJNRo90E8UsSJa2r379NTR75Z4yGiLFs8cNJUGZu0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775217; c=relaxed/simple;
	bh=832Sfh5dEawpvzYC5byVLL7/71ABMtrNg2Ifhu2tfyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPW/LiEuA/nNa2YO1FDKo5qS45tLC6pb20V6zAjhH7mNx8BDCoGIosr0ibFV1DmuGEzlFFaJp3UcARdHFnMdbxbuzXKSgWq1/w3KgR84GNU/5IRA3sL4MYH/dnjr0mizruVB3Uq3SU3BMLbH3n1fbaRaQ1T3POqVm2NQ1mPI3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=kjkrqz4C; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso24450541fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1727775213; x=1728380013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PFxJYWVYL4m9rE0atW0FXnpT4C+KIuBj65xKR04Gdzw=;
        b=kjkrqz4CdyIwYlIsbxcUySFT7ODS9O6cSTp5iwcJlKCRZnKk9Y9iCxUxPUVATSJo5z
         DIN30Np2fEKuqxzIFcYLHcngG5SWEU+QT5slfje29MptK4uGt0RreK0YRDsdJOVjYWKA
         Jei650kY8SWo8vGxpMDSeM4F02gkKJHeL1ss19pfLwNJTILp+PLQMd8bCE3zQWXQn1uf
         Rv6WwqRyl10Ca8Gd+fFkgX3Cgjp8qW3sqlJplcwU8eXgu+ytlltumyGn8K4+VXu8W8MI
         2lgEeYTQM0HCC0bl6Dz9o1SfzZtx9MXPJyca2x9bTJFXe6vCq13Hknw/0fhTA7DbcYVS
         F19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727775213; x=1728380013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFxJYWVYL4m9rE0atW0FXnpT4C+KIuBj65xKR04Gdzw=;
        b=ZY3nM3CVAUxKjSdezy4tYDl33ujcO32AacOt3sM3Vvi2inB55tbW6w/IRPfesf/H7O
         FnOR5TWclRHIZP8dQzfirjZiCYZvyWKokIBS2Aan9su3At5sWHWjq3NpWnkDRsZvj4Yp
         7B396/bzTgHMRHpIT/3mO4Iy7PUJ+RZ870PDZf0TzA1o8mI4JUpC8OCQOFDPXP13esKl
         6aE0N85GkLHqdsBkgSBRGYlGAOP9DsakVUtP5MW0ZISDSMj8zl8tFYcQ8fpZo32bSk1W
         /v+5sxpH1ypKEO4QXqgDfKE0TXEEv1skzy3DXntJnn7xQBbq3pmg0Rt9nUaeQwvMw2pO
         QG3Q==
X-Gm-Message-State: AOJu0Yz1sBW95sZwtqIkbpa5JPIe0Znf3aOmTK2nR50j1KtrvQncVD+t
	HQq/eBAOYmWiIPCGFtw1GYjmgjC5ibkmUo6v7Ve5Fafq9ZHqQ86oQl4jI0cWQb8JNdsl/+AD+cL
	W7+wtFNC2nYESFA4Q2CVvDvzDpDu0/oEk/I+UyDeMxUtkjUfD83TXNnzn9GkTsAxMQ1/1rtgINt
	KF/dFUYmQCtTZkRKpoKhPUdsS+qBweTm1HradKDiz3RZA7DHhTHw==
X-Google-Smtp-Source: AGHT+IHgbM65iRgjdKkWLJxzp7a+tVrFT3J8ugdo6d2R1hi7mQ/aAui2ZSk2LrHPR6AyBvjz2CUX9Q==
X-Received: by 2002:a2e:be24:0:b0:2fa:d4ef:f234 with SMTP id 38308e7fff4ca-2fad4eff502mr33460231fa.1.1727775213046;
        Tue, 01 Oct 2024 02:33:33 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-216.dynamic.amis.hr. [188.129.47.216])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a93c27c5b70sm670267066b.47.2024.10.01.02.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:33:31 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] MAINTAINERS: Remove Luka Kovacic as CRS3XX maintainer
Date: Tue,  1 Oct 2024 11:33:02 +0200
Message-ID: <20241001093326.13885-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Luka Kovacic is no longer with Sartura, so remove him as maintainer of
CRS3XX boards.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea8a2227b822..5f64790facd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15504,7 +15504,6 @@ S:	Maintained
 F:	drivers/usb/image/microtek.*
 
 MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
-M:	Luka Kovacic <luka.kovacic@sartura.hr>
 M:	Luka Perkov <luka.perkov@sartura.hr>
 S:	Maintained
 F:	arch/arm/boot/dts/marvell/armada-xp-crs305-1g-4s-bit.dts
-- 
2.46.2


