Return-Path: <linux-kernel+bounces-297713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A4895BCB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B6D1C23268
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354B91CF289;
	Thu, 22 Aug 2024 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLT92HCA"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294631C9ED0;
	Thu, 22 Aug 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346298; cv=none; b=OIm4z/tYrSOtOO/RRrznhYi5OcnIr/m6YmSH/arl/BQyp38h9chFfy0gw0Al8GMMjj0DucUQIIYEtOeFz5z5P/0bTt7S2+jTI7SW4t/3cdxNOg9LqpqEzx9SM/SFoGKEiKDMa3zopG9MJQE3ptUt/+zdSBMJkE0JV4+m4BcBsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346298; c=relaxed/simple;
	bh=qYXRmZqu8Y2R/AjgbiFNE6VHYQ7cSgy5C8RAZ9XLQFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GsrJ4aRNZG+VX5MjJ83tR2lJLzYMDStd0zDAdTwm6T1bmZY8njrMjRJqmH/KmEbr2kf2H7BIkaQA2CBvoEtbSCWkkOfZeheZiFvArFqllCcHo1pnj2QBF36CXjfOKFE+XC0D/0dygu/ff7zWpJxxG4guE4VQmwX1uNHXXBqM1zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLT92HCA; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d29ba04f2so4165655ab.2;
        Thu, 22 Aug 2024 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724346296; x=1724951096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=esdJRnf0pT4wQ8RYLjmyXYlK/HtDqyadnSKJPULfJpU=;
        b=WLT92HCAq3m7MLRwsCa7p7JDboeTNOegK/14bU7u5IejMBGrY9eEgyNtSFAlQC2Ilg
         l3p1YzKQ9ovySUr1SEMTio0y/z5mhm+K6Sjc0Wd5L/dNvze7iiOnQQD2LELz8gzBbzJJ
         7lDuXZjJzzcQAE6BY7B6XkLllRs2gmTVY4X/6U93Q4opiWD/WO3tZtkUN2yrpFwxF/AT
         g2u5+pnbzJc9BnON4IJSI/rVHEessjiqWMZwnJxPP15ximNlTiUZRWiq0zfnzPiR0Y05
         GWXogoKH5VvvJkQYvYH6vehgxVzJfq42V9LErmU3IEuXUoxFYH75JqxCrarZNg9qpuCY
         qi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346296; x=1724951096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esdJRnf0pT4wQ8RYLjmyXYlK/HtDqyadnSKJPULfJpU=;
        b=ApiFnv0eJtD3B9CejzO6WOptUvNasl56eXPkuj8OoLHR/dq6LnNGVX5/oPghKa9ypJ
         ywVLcXWWil96tLQgedWMGQolpkSYOPBDETAdY95ekM6YWjy+RlavNFRAPdw1mIU4bchs
         v6UFnH5jut2j3RHAIKth1dNb8wfX2fT3IkaZVwm6C6mjarBMHW7Bt8rOtm5Dt7ecA1hY
         ml7W+0vhNm8Fx4CTqy5t9H00Y1TUS7BXGZSuyP5u4t7o2FGpi9ACvrFFkX6f1QSxoSje
         CwQm+Dk5GFuNf+kkp6WJqox6wt75GMG+F1lnhz7sqnnbEavK5jp4XEF6HyoclRouWARz
         HqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnpnGIqArMH/EwsBvuDItpsgMLNUhkDo6RMvN8cYFLl6GljlXvDOVwStdaA1dx2NOEBmL9D9msN4Pp@vger.kernel.org, AJvYcCVYSn5S8oTpXGKMEkIoH+bFVYeUcBNv8ErE7s3tcWUbHVLL6HwntVk7wQJD9lln5lsgfI8vs8jaGDDlOzAi@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9u7q03ljFUJnQk6rW+AKNnj9tDuRW/uYJIetL2WinX7HZXvW
	z7g4Wgy5dwbYzH2C0ZeJUObW03s8w96375sHlcwE9jMUtL9q3Kxy
X-Google-Smtp-Source: AGHT+IEEM23ZtWl/rNRm8DcLBMjG3HmzO/ARhfm/Zlt1dompJymJdZtLCX7QIrLbZAGZ20gAh4c02Q==
X-Received: by 2002:a05:6e02:1887:b0:375:9e3f:5f6 with SMTP id e9e14a558f8ab-39d74b5582amr35641725ab.6.1724346295855;
        Thu, 22 Aug 2024 10:04:55 -0700 (PDT)
Received: from hestia.. (216-71-44-235-dynamic.midco.net. [216.71.44.235])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d73e68e60sm7677125ab.5.2024.08.22.10.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 10:04:55 -0700 (PDT)
From: Robert Nelson <robertcnelson@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Robert Nelson <robertcnelson@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Davis <afd@ti.com>,
	Jared McArthur <j-mcarthur@ti.com>,
	Jason Kridner <jkridner@beagleboard.org>,
	Deepak Khatri <lorforlinux@beagleboard.org>,
	Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: ti: Add BeagleY-AI
Date: Thu, 22 Aug 2024 12:04:39 -0500
Message-Id: <20240822170440.265055-1-robertcnelson@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This board is based on ti,j722s family using the am67a variation.

https://beagley-ai.org/
https://openbeagle.org/beagley-ai/beagley-ai

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Andrew Davis <afd@ti.com>
CC: Jared McArthur <j-mcarthur@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Deepak Khatri <lorforlinux@beagleboard.org>
CC: Drew Fustini <drew@beagleboard.org>
CC: linux-arm-kernel@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
Changes since v2:
 - cc more maintainers and devicetree@vger.kernel.org
Changes since v1:
 - switched to the TI model am67a over the family name j722s
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 4d9c5fbb4c26..5df99e361c21 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -140,6 +140,7 @@ properties:
       - description: K3 J722S SoC and Boards
         items:
           - enum:
+              - beagle,am67a-beagley-ai
               - ti,j722s-evm
           - const: ti,j722s
 
-- 
2.39.2


