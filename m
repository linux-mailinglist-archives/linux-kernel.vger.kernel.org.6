Return-Path: <linux-kernel+bounces-575162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B1A6EE90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991C2189178D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CFD255E46;
	Tue, 25 Mar 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUrK9IB9"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E419F40B;
	Tue, 25 Mar 2025 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900673; cv=none; b=OjN5Ao/FiHld5yQ1cDcgqOfLu6WBJ6+z57bvYNTmP3S7XHbYU0/b+A4JCvD9QWj1pDv5aJidB51rThf3EJrLaA/QcHM357ZQo0XLmxlY6sDzamCwjsLdiXr36CfTH3nuozZUk+kjsILrBrlIJOs2SdCqu1dd29oXSV+Opny0Gfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900673; c=relaxed/simple;
	bh=inVfMhTBvcjaeEc6iDcKXHoo3RoFLLPwcmr7O3Uz+60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbKVCKmYTvNKFHODSujJDLB9js/QHmP69HclV6vzI/x6NTrrMbUmnHW1oDOzZKlm2gy8gki+ZoM+vQBrGUeaic3R2G381RVU5kDgGo72NLa4Vr8P6hXdRipupFvP+821BFa/+LwGouJPIjTqTEuA8MGWySIcp0rH9dMZuesKQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUrK9IB9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so9152346a12.0;
        Tue, 25 Mar 2025 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742900670; x=1743505470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYzJH+XUDBUF/N0lAmCHUaQA8dWYRxiMlRySq6cDUpo=;
        b=hUrK9IB9H/G+PpjDU6kBPfEKYE5U023/36AMV4Y65k/SlU37UfJQ7qb2EiFsQvQiRV
         OADfM8kNucc/44HUvFl0XMLl0rsnVAE7rETYY8A0yeZh6Iz80teRVhij69e3szg9eby4
         RLa8PI+GNC7pjReneVf6mKsXLeyiM5XKBF/TTVihE/WUGSbPyNETkLxSP79MSUavxmNX
         RT7NPmLDqdCcK3zidFMzKP3rgRD3oeMpuXwnLGXNizIRjXnjro7Le6AQRdc1OrLrMRHW
         taFli+L3EjXt6XAoARryCosUw4MPYVnw7cmXV/bBY+qwA5uSKpk/RUrRor8tvjG1SL80
         fXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742900670; x=1743505470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYzJH+XUDBUF/N0lAmCHUaQA8dWYRxiMlRySq6cDUpo=;
        b=d1JH63/tNLaxj4QM65hQS5eVWxICEJlCeEjOrF7Hos6qarW5d8HCI90TnkMS780j2p
         9seUZ1KAQMpvg3eSULYEzONC2h6W9pKb89S8J2JUgFaelJhFCAQqqPz5+pydX+VojVYp
         XopFK0jDIWD4gWwb3GrH8KTE9326aUrZu+AnRFUFTLbQ9M+QRKXN3cKBqszGCmlv6Hpi
         fiViJHKO6ikMhK9PngYFDd8LeWPd/u7aQTzm88PwFQwkF6oYGd7jZNK3HF8K50kJkN1n
         aWh+d7XYZq3SAKF5YSYquh3qu6eKYr+6T1nWr4NE2jPUFoImn9dmLetgl6HrFHcLPF5L
         GMvA==
X-Forwarded-Encrypted: i=1; AJvYcCUeHrhxTy0vLdZ/S2Zmzn7O5EzmYMnt48R0oQntv7iu+6EGd40rM6Ym3vwrgLsGGVFxACi7QjDJsXZI@vger.kernel.org, AJvYcCX9GAi/tak3HykEmd31Ad+dYAxY75AvCj84UeihuYHsX2P/2EllZgXv4luzWS77J3lwdRtQ5sJzsK2XklQr@vger.kernel.org
X-Gm-Message-State: AOJu0YzOq4WoKNKiOARWmwdZtMR1TimfdiQPAbxNtd1khyKSQGcSXx7P
	Jt9sVHaau3UtmJEZdpBEpzqizJqN6IyaAxiijVureh9tJKAkMj+B
X-Gm-Gg: ASbGncun1ymUqs/XsEkn4hO6oCK5c4z/nkf0P9r9ueknF0szmEozS37dCuHPFy8BSGR
	FGHdIQtMBvupIcx1UFlF86YiZRDsk9VolzFR6ZDhPHV66sjFW1qc9L6AhtYm8SGAzjgD09ykyqj
	i2lO/JYPd4DIuSx3RpRI42DAkzYidDPH44c+Z8fiw0YEMqh9GxPzRocPIE+S2JPdwVVShM4ziZY
	x5cWLVfDVCYeTgGEQQZX6vdU7rW+TfJJaV3u/osVVQnMq8gB+DOXFNWBCVtmcm1f10K38pZ9grj
	FEgyc8GVMcFuAwn3VTlvmPyj4XiosNX5tViup2Iyj70S7Pt5ItNjYwQccS4caEbEYjgNEsKwpIJ
	IzQ8OSLR2bc5gktHX
X-Google-Smtp-Source: AGHT+IGjYBkqXYerys/mgiL5w0LGUgClKn/t3akwJFbuIP56/P4GUrbM+dD5ttple3vDwypq/KVE0w==
X-Received: by 2002:a05:6402:354e:b0:5e5:c0e7:f455 with SMTP id 4fb4d7f45d1cf-5ebcd42dd4cmr12337589a12.8.1742900669673;
        Tue, 25 Mar 2025 04:04:29 -0700 (PDT)
Received: from wslxew242.ultratronik.de (mail.ultratronik.de. [82.100.224.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf8cc99sm7556809a12.32.2025.03.25.04.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:04:29 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <gradenovic@ultratronik.de>,
	=?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: arm: stm32: Document Ultratronik's Fly board DT binding
Date: Tue, 25 Mar 2025 12:04:06 +0100
Message-ID: <20250325110409.2323611-3-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325110409.2323611-1-goran.radni@gmail.com>
References: <20250325110409.2323611-1-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Goran Rađenović <gradenovic@ultratronik.de>

This commit documents ultra-fly-sbc devicetree binding based on
STM32MP157 SoC.

Signed-off-by: Goran Rađenović <goran.radni@gmail.com>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index b6c56d4ce6b9..c1cb54ffb210 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -175,6 +175,11 @@ properties:
           - const: phytec,phycore-stm32mp157c-som
           - const: st,stm32mp157
 
+      - description: Ultratronik STM32MP1 SBC based Boards
+        items:
+          - const: ultratronik,stm32mp157c-ultra-fly-sbc
+          - const: st,stm32mp157
+
       - description: ST STM32MP257 based Boards
         items:
           - enum:
-- 
2.43.0


