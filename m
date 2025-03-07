Return-Path: <linux-kernel+bounces-550213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB96A55CA3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EF8171AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08593149C4A;
	Fri,  7 Mar 2025 01:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5q7KfQB"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C3149E16;
	Fri,  7 Mar 2025 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309621; cv=none; b=tIk8xU5aSMC7udqvfDeuoko+0FoB1oJYAyWGx60BpW6g0saEirHwTXFmOBmQ3wOz5PNJ0UcmP4S7cL8XfYXBaCmlCvyMuwEzhoZjFNljRdfteLnlnBsKFNsR07Z5pQpiPR/toItvmB0hsHd9cvffRVG+MlGg/AqlVLHV815dHJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309621; c=relaxed/simple;
	bh=aEqSvb3bhI5gUhZW2nPCKYFhqATFoI+W/DdltbIlaqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVtB9TU7HYUTZeSmMA96jSfZsretjj9CfwnTbDBDymfSbeAz/FOMGGX+n4SFibMLRvhdZ3pnwNFm321MtSqmuy6Akl+5FYFGOsDpW0VH1egYRzBXm7TafFJj42JoFI1ljARC2tvaxT3SEbgtJuzmBROVPSCxLkI0wt6Ib1QZ4Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5q7KfQB; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8f7019422so11647046d6.1;
        Thu, 06 Mar 2025 17:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741309619; x=1741914419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyywHQPXcyfHqDiD+G22vJ+bxldrNlq8Ec4J0npD+7I=;
        b=a5q7KfQBn0IByQiCYUjGnPD65Jh0AGf1N31gE/CIcTBCz9W/OFzvQLyPaH6JkiNmOP
         DCsnGrG6YrZECf2mUBz1CdDl/hWs0SakCz9m3BRrYWYUAP3NZpZp1mkx4hIUIPmzEopU
         oVEQ38mvvQMhMdvIw8H7b8o+5F0TpIrR79L1GOf64ZMwdxPGg6tAfYyoZfDAaXlh0ZPT
         6tKJ/xOzTeNLh9NlorkfsYH9xRd5qsXHCP2aFz+C3h9Nm/KaFhhAEkOoJ0z57yacT2a/
         TwlW0IGPVz1K8uqwzfhe7MOZmr5i1RRxvJY7P1pvSOudkE99rgOqBcx0OLFZrC0Zfm/9
         s23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309619; x=1741914419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyywHQPXcyfHqDiD+G22vJ+bxldrNlq8Ec4J0npD+7I=;
        b=YUFEM8rF6pv2+kmmeySVcEaIEu/sdofGxLwNB9hLEmeGXt4anik/6uD69DRX1lweO6
         lY32+ofOT0jb82J65l6DrinYE5ZhwELO4qR85UjzRr7dtNj3divIqs//aQo0UUg4iOm/
         zYTZlWKvHSWw766kAnh71bT6M4phbWNLy+AT8RTyM2X4j8E9PsOjVTLmBYytFUQ+iIyn
         s4UBw26g6yzE2QT5WAuas2b80cCrVsvUSeFxMpN2hKiS0xYmMRaYeA87s2i5fnUMggxS
         SS95EkNEToP81Cr6mMCWLXCB3c+HPvHrFsPLNsCc3uPatVPS9r7OvGBrFNKZQSUJ5oU2
         55RA==
X-Forwarded-Encrypted: i=1; AJvYcCWmzbtqT0ZGjM+5KQtQ48LHhofDYopYssA8AjGvuin1BWktIPqD5UhLnjvNWp7PmzsYHhYWUxNUXiQh@vger.kernel.org
X-Gm-Message-State: AOJu0YylFbO65SHgFJLkG8e4Mk33EYhcNj7cRru93GBTTIrJ4xOJeBaf
	Fi4aKdecqwKbBcEN5m198BjuGvLht4b/zsmILFbL1UvuK0DCuxS/
X-Gm-Gg: ASbGnculzC56fKkRsVcOosbUJcvGHUDLlTGHMQ/i3dd5fUMD1+cvNIhwcsTH5VBq3tX
	PEcfOAgpVka2iNlZeLhvWd2sQD31l3zBY1gaD1RImsCDgtmrDcdYB4gTwWeYcGUDVqEwpefFLGO
	/bxqMVFpn1KVkHxuuyJeYew5d2ZgDgdJ30VoaQ5PnBlVxaCxlpCQluJjuBqoEJvuP8ZzMvx3Z/G
	Vbk3foG2fqcQyJdFfUwTD4XP6kviLyHIXO01GNGMdP92FOVNlxp223Kzivhq4+TbJcnlifBGiyH
	QcYeOWKrUXZ+rrv3Y0+q
X-Google-Smtp-Source: AGHT+IGyisWh9R/IV05ZBzDHIWTnlM5I9fN/HL5vjDHLVRhtDEa6+NOTsTOLeiyN/jflRKwmjvzg9A==
X-Received: by 2002:a05:6214:230b:b0:6e8:9321:87cd with SMTP id 6a1803df08f44-6e9006cbb95mr14545556d6.40.1741309618743;
        Thu, 06 Mar 2025 17:06:58 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8f70a4495sm13271196d6.52.2025.03.06.17.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:06:57 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add Sophgo SG2044 MSI controller
Date: Fri,  7 Mar 2025 09:06:46 +0800
Message-ID: <20250307010649.422359-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307010649.422359-1-inochiama@gmail.com>
References: <20250307010649.422359-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like SG2042, SG2044 also uses an external msi controller to provide
MSI interrupt for PCIe controllers. The difference between these
two msi controlling are summary as follows:

1. SG2044 acks the interrupt by writing 0, as on SG2042 by setting
   related bit.
2. SG2044 uses interrupt number mod 32 as msi message data, but
   SG2042 uses setting related bit.

Add support for the SG2044 msi controller.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/interrupt-controller/sophgo,sg2042-msi.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
index e1ffd55fa7bf..f6b8b1d92f79 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
@@ -18,7 +18,9 @@ allOf:

 properties:
   compatible:
-    const: sophgo,sg2042-msi
+    enum:
+      - sophgo,sg2042-msi
+      - sophgo,sg2044-msi

   reg:
     items:
--
2.48.1


