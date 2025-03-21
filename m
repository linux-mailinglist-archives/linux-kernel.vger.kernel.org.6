Return-Path: <linux-kernel+bounces-571147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296DDA6B9C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC423BBC48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E7F2222C9;
	Fri, 21 Mar 2025 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPN4REO/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12691F17EB;
	Fri, 21 Mar 2025 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555914; cv=none; b=JBPvq+J0hEOO7IUV59g8Bi/KJ38m+WGSbndc4EJX2E/w03qxMHwmReF8aHRXYVbLsQvUgoUpbyxQ6wE4cWk77EnmCejt9nEEE7Jk6ArOOoR83NnECNEMcJhDLey4Pz3x0avY4tJUGDVt2K6Y4iXcMpWKTm4ZqBqyxq0wnmmt7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555914; c=relaxed/simple;
	bh=6tsrNnv55ss3CWez3WtOhZ8n6kBmyz9IWLqGYH2EzrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kxyq0G8To85bu3BD3nmWMRPulJ+kqIdA1QFUMZ+Yx9yCOC73a2/AyImFn7LnEumG7ZhzG4s0wdo1doWvpMV9oOI/xUyC8jcOjxwraUt2u1bxIn6PcyWAUVA8lDgDQ1lq83hijg98v+5wsQAfbvc+ufXBHMtAcIJj9PTW2RTlgkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPN4REO/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso409015166b.3;
        Fri, 21 Mar 2025 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742555910; x=1743160710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrqQ4n0LQf74p7Y0C7SlfGdZZHt8VEuNBlap7dzBxjc=;
        b=iPN4REO/iWgLr87Cg1aUw6fRUYaBsGmlfup1a41Pe+wCaoy/eP0owyDC+CnmbZbu/W
         OgnxHPj0FHbuF7edxwPK8tyJaVopCEh6A4iYEsMrBvxjaxiSgo7+UJOE3PtsA8BQUcrP
         cpPsnPhq/k8lL9MRmYrc05uDon2E17dR09CASv3IOZC35ogf/FfEYAmPjM/2DOLGN+w2
         GfR+5PjAFDHfjxoM188CzWcru2ofYIrS4hP7P9jPDQJcs79yrdfJb8leUzrXxvb+cgUo
         G00vGcq2Yfcggyzd9M4q7pMRl64tea02M4tXKfq7bKv4I0ARYIh9fN7JEaWC+/ydze6p
         fSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555910; x=1743160710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrqQ4n0LQf74p7Y0C7SlfGdZZHt8VEuNBlap7dzBxjc=;
        b=MOO+Zv8eeI18Z+xpvAOeNHtdX2UYISKQQ3wpoeFvd4z05x0se9aJ22Mmv7JOE+ihRw
         lUC4b9uZj71neVWyCpFahhtIjoq9kgjHkVkdM3MYIhZ28pRuWBcOFqAAgHv0irXNtosg
         bBX01YivqSSecCHVvd+x0hvgBTLXoLlqFahJQDssZ2n6lprZqxvR+w32ukmuTAYmjxjF
         vl/gu/H6IfVcdUS1CScc2Bu7KUTIWpMaejceKOJlkQBmiUKdXAzmWFVW9A4S1traAPxT
         Xvyrq6SvvBUqTno7SPXkkfsSn4NKiHOefiW64IeE2chvAluHaOiX+6mHof8hq6SK6Isu
         qgOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlDEnTFBMtouBQ3D7q/9uCW6brFVhpJws5LmWS1NnEAc2B4OgOriB9zu4naegZQLsfrbRDzihdNL0z@vger.kernel.org, AJvYcCX6InaqDmtXBrlD+Dkz9jRDa3HS3EOimHvabtbvni2BbyxJsuD29+GqmtB42Pgvfqjj6M11shL6HlTHJ8bw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9LTFwNtjkwQlC2HqcwleU6jySUjbE14JgeYH2qA02+oA+M/Xr
	gkUtBVjXBtq1Tvs+7L1Kjqb+psMNWpE7oS7Zu37e0bhC/w8rl9kPDdti1swt
X-Gm-Gg: ASbGnctOToi2SrCuR0FIwfQehkIxTVRgEN3iFR+Mtt+2OUuqsilbnhY890QSDvf892l
	+GBBT+JsSni67HDVZw8Qy2Cc/ga6GNVs5VMurJCXE10JtsjsvUc0Y89nEVEJdRE3oiA6t5v7I+i
	0O6GSbR7sNXxzxo1e+oPn+0EQSlQMHRo9/OssrVAtxX+cFZhKART/2nezA6rCFP9bgGkNTQMH8j
	4KM3zZROFQYD6rZ2Du4DrCFQaF+mXjsrJz/LHTYALR+M3vcef9LkW9uPeJEQ8cudxmAVIWS77yV
	kU6ebcBW4dJ7Sj+D2DR7Az9dNFI8uRe70i3zv2slhCTsS3b8
X-Google-Smtp-Source: AGHT+IH8lF8EZSQO5skolM1/FFH5wVUxuwCePPrejsFwuPumvSESSVNEChspXrDKOQ2zZqOfHK0arQ==
X-Received: by 2002:a17:906:f587:b0:ac3:8896:416f with SMTP id a640c23a62f3a-ac3f2272aeemr306585766b.15.1742555909599;
        Fri, 21 Mar 2025 04:18:29 -0700 (PDT)
Received: from wslxew242.. ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd569f3sm134228866b.171.2025.03.21.04.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 04:18:29 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <gradenovic@ultratronik.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add Ultratronik
Date: Fri, 21 Mar 2025 12:18:16 +0100
Message-ID: <20250321111821.361419-2-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321111821.361419-1-goran.radni@gmail.com>
References: <20250321111821.361419-1-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Goran Rađenović <gradenovic@ultratronik.de>

Ultratronik GmbH is a German electronics company:
https://www.ultratronik-ems.de/

Signed-off-by: Goran Rađenović <gradenovic@ultratronik.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d1..91285296dbd3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1597,6 +1597,8 @@ patternProperties:
     description: Universal Scientific Industrial Co., Ltd.
   "^usr,.*":
     description: U.S. Robotics Corporation
+  "^ultratronik,.*":
+    description: Ultratronik GmbH
   "^utoo,.*":
     description: Aigo Digital Technology Co., Ltd.
   "^v3,.*":
-- 
2.43.0


