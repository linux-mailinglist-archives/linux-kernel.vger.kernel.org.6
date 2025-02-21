Return-Path: <linux-kernel+bounces-525241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E6CA3ECE7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6100C17FCC7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A221FCFCC;
	Fri, 21 Feb 2025 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF/NZIsu"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A361FC114;
	Fri, 21 Feb 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119737; cv=none; b=aoySlFCpaJzRJVVFO0CifSW8/dXQd+agkC+69KQ8nzw39zerXEB4rrtJPEUFysOzcZa20F4EC0fJmYfJAR8ttfEaKdT/t95nWGvn4J1bIDzPOdU5ly7bvZTdaCeFxy5csI4rPyJCuV2mM1a/7bSgXpZwPAFHm05a+C+5sCgC/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119737; c=relaxed/simple;
	bh=Nf4fcOuWgRppA+LblaREvE6VQmo3gUUHrklfBY5bz90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=skneyhoBbQ2G3ZPQZypf8m7YpJRe3XbV/rGSmlA3TisufEpyVJrv0GQ67L6OoF+Zn4+V0dbMgCUwFcqiGeh/xhLa3lxjWr+DdP9nZNjg3rnMgRJpIMC+AzWG0HEBsHk344YnbG2wLtoD/K1uPe8pQIGfCa1qr/zOelpEIVpfYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF/NZIsu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220bff984a0so33712405ad.3;
        Thu, 20 Feb 2025 22:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740119735; x=1740724535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gaAwgWYN6mC8bbarqgL9b/ntEOrc+hTOljfxQkKCFDg=;
        b=FF/NZIsuQOL6aQur6rN/Hf6IfItdnTYYGIsMZ0g6E9tz8kt22ogPE988VyDGiG8IcI
         QcNbKu0cJ4hvo+y4sqLIq/Uw6oY5gEtnBNIOy2bLRXBUvyh8QhgpHOyeBp73UcHXNfL+
         tu6t4SR+zy7OgZhYiqBOsDQnepCEIt9RQvCd/Lp6uDX6nj1+fCgn4ui91wJ7u/sg9maQ
         v+reEUXW6bxFL8+EuKHR15COBdB3HlYoOKpoUP52W3LrXcOw3bo587O5JbzeZ3lYevaZ
         BYvRzbrVNcsPCFeBU4z2u9dvfQDxdCtEuHHg6uNczNLOC5WlyFMIjG1EBlgBL8wCg5N+
         oyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740119735; x=1740724535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaAwgWYN6mC8bbarqgL9b/ntEOrc+hTOljfxQkKCFDg=;
        b=X+4MvuA1CsDnmS8A6i8AIUFzh7EaIWAfjWkmFiIcmCjvm/P536+WhQlsIkIu+K5Cr1
         B6cuACr1JdmpoymEdryiT/Bh2vxFBsitU72+VADu4It7zwJb4v1PNSyVgQ72phtW6XO4
         qIOKd6T2LLbZimKfPPJHicx6vdBuQNACN4TV4Cp4bq8CD/JV0GFhuBCw8aLj7FhYNMmn
         giAOlZiqskD/X+Q7y25K/OVYXs4hvPRez1CG5Ke88WSu+lEgs+m61j5CJHNJN970UGhy
         jvKnC/ryPkf5ZQlShSc1BhS6O8nwp4RQB+J+s8Us+cYzow+jFaYk4D78ues4GFwsdczi
         9ELQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlDZGqlS0KILoAXr+fDVvoYABWos8i8XEw2w1g7aLsgaNLnC4q/mKjz4YZeuUMIQOC6zzLpvuj6278@vger.kernel.org
X-Gm-Message-State: AOJu0YzYf+yh3iO8fck5UArdhgEfBhRK/a4rXbPY1CZvYgto7YjJ3xPd
	aYqOqqKGvhBY67JYzVVAvYTt6AVPJmPgBmwthpOPg4IdzOacQURx2OPiiw==
X-Gm-Gg: ASbGncsW5oTI+WEK0YCdxuUPJcLhR/Q1R7ADlHuThC431jHPuyjOUvqbNUXd/MKdmpu
	YAQQjGq4M3kTJ4F8hyUOWinmAzlSlrpOs/oapYxvCEF1wHX39qSAuRqhj3xI82H7kOGW79A021E
	Sdk4EccJoOqMzv+DKvNBxTmDDEKiWNXmX73k9iR6PGEpwe1lC43/z1LDNURhVuJwNmKB6/oLd5o
	/PLXSUlsMxszuJ6AXsSkzs6vVdv01U1dp2ruGgYXbXp1avLoKSQRFJwDqNh4XZ+rSHSDB3PQEqD
	pezEWJE0C/5d0gMeD3uY9kszUY2rR6ylLJKu
X-Google-Smtp-Source: AGHT+IH9IEr9JoMJYSAg85kbfpXIEgYLzM3yHCu2Pv76Pa87pXjWae8C0Nh0Xn4+HTysrZd6HUuoIg==
X-Received: by 2002:a05:6a21:9988:b0:1ee:bd99:9c71 with SMTP id adf61e73a8af0-1eef3cdcb2fmr4082990637.24.1740119734846;
        Thu, 20 Feb 2025 22:35:34 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5dc68sm13777275a12.9.2025.02.20.22.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:35:34 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH RESEND v2 0/4] Add support for Nuvoton npcm845 i3c controller
Date: Fri, 21 Feb 2025 14:35:24 +0800
Message-Id: <20250221063528.1810007-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for the Nuvoton npcm845
Board Management controller (BMC) SoC family.

The Nuvoton npcm845 uses the same Silvico IP but an older version.
This patchset adds fixes for the npcm845 specific hardware issues.

--
v3:
 - Add more description in dt-binging commit message
 - Add the svc_i3c_drvdata structure in struct svc_i3c_master
 - Improve the do_daa
---
v2:
 - Add a new compatible string in dt-binding doc.
 - Add driver data for npcm845 to address the quirks.
 - Modify svc_i3c_master_write to be reused by SVC_I3C_QUIRK_FIFO_EMPTY fix.
 - Fix typo of SVC_I3C_QUIRK_FALSE_SLVSTART fix.
 - Remove the code changes in svc_i3c_master_do_daa_locked, will add it in
   another patch series for common improvement.
---

Stanley Chu (4):
  dt-bindings: i3c: silvaco: Add npcm845 compatible string
  i3c: master: svc: Add support for Nuvoton npcm845 i3c
  i3c: master: svc: Fix npcm845 FIFO empty issue
  i3c: master: svc: Fix npcm845 invalid slvstart event

 .../bindings/i3c/silvaco,i3c-master.yaml      |  4 +-
 drivers/i3c/master/svc-i3c-master.c           | 57 +++++++++++++++++--
 2 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.34.1


