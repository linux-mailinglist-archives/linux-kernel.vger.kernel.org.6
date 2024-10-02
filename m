Return-Path: <linux-kernel+bounces-347366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE2098D1BD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01BB9B2342A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A621E7672;
	Wed,  2 Oct 2024 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGA82dMq"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E21E764D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866340; cv=none; b=VYV9uB5xQg3r/XPEYEPQEyjSaxnS/C+Wy6TTo0KJBzTL9vGMj3ghX/FlWaY95WblAyas3x697fGW9LmKGajrriFHxsr2dWndvupdck+R/DqiF3dIpBWcCCxoNBVlg+ouplAy/7rfhSJCVY/2ulK5n/8uFUVC/YChMj9Stnj7mXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866340; c=relaxed/simple;
	bh=+6/WjKVuqsJTgYxMCsWvQ93HmDROcsdO9cXTdRcnAdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fib1iTxyfmis4tZ9BMfitSSUtJ3ki6w6uWdYnawqnlu9WK8RgES1DiR1KOKeVY0lFaV7rQQtUcZ37bYUUUigBUUJViYFWRsJBfS+m1nRXcgELkjZq0OOUKjPgq+UcrDaIWqf7I78IHBjt8MxjgDcr3xX5lJPF84Kvbh3V2Wli5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SGA82dMq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb0d0311fso9198735e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727866337; x=1728471137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JCXsapE6XMt6JKCikb0dIpPeaKutnr5vOR9s+wgu0QY=;
        b=SGA82dMqnarst3OqKvSO3kdW72A6GGvHkOwUgC+8es7/VxVDVILFoM0vsV0E0FSS7g
         fOkOUNcsICBKf1lLl94ZW9+ion2NdTWzvBqlSCJYqB0sjIGwB/2ZmKN122LIOXAhlVM/
         YrROSePkCEnfebJf2vtNAhAjF7+iLVhqmnwovE9jwrSgd0Ht61Dk9/3q4UWCj31JS6AP
         ymkHiSmxfIPGGheMJGygRYt5runC6Bd4waUyDvDgpCasVxBv1EIEkYPNqd4lg9mTdgk3
         kDr7yh9vJ+uiWiNQ3ds398dd14dZ9rePpKJpdME84PWjcQw1M/EU9lUvT9IV71zKK7Sb
         8epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727866337; x=1728471137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCXsapE6XMt6JKCikb0dIpPeaKutnr5vOR9s+wgu0QY=;
        b=T98s7BgyTLfPxPet1rEP9w4ZHMjMu32LxemR651KOaS2Q8t/E/7jR5bDQB4DF4kB9d
         jGqSolH+vJX1sbpd40BdpUjI+ktgcYttOKfj50iNHKUDAn447Yh5GWIDO1uy4P6ouQxK
         ZG5kROPDmkZdOuOASkv/91rA6BZsDPw45xZbHtVaVWYnJhdfrJc1SxuO9xpuk06fVOhI
         NpB1KsOKX5aDLo6etw0+lp8jyBN1Y3d85t+Ej2vFx+bje/fd47oifGfEhdXQdlyl4vf6
         UaSkwNxl3LiaS2Kxm1OjC6Hc87lByaXrYsaPiL77HeesJJVrUwd+HWl1BMGg/4A1+0KH
         jC7w==
X-Forwarded-Encrypted: i=1; AJvYcCXhvNIMh9Y3zjsza5mS+hqzzsfvQoa9sRFWKW29KAecm1lazbjO+llAXPEic2pfL/X/eadRcJ+MN7mk/TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9ihJUaEH6RiLLTim3sPTl8JvpIk8wgU6gipkzXCakV/hZ4O7
	fQqt44dA/72N5+upz4nEy/b2iIak/Gm3CkJBfWJkRXv52l5C1LyZEQgxB6Ttrn8=
X-Google-Smtp-Source: AGHT+IEhB254ZsZGGxI3gC5jf98kCFBKhEyUS8kIFNcJ+2q8/X6umczaZso5OJQnvpnpcQYud/X2zg==
X-Received: by 2002:a05:600c:3b2a:b0:42c:aeee:80c with SMTP id 5b1f17b1804b1-42f778ffc41mr9306535e9.9.1727866337420;
        Wed, 02 Oct 2024 03:52:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d33dsm13680120f8f.19.2024.10.02.03.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:52:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Li <Frank.li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	York Sun <york.sun@nxp.com>
Subject: [PATCH] EDAC: MAINTAINERS: move FSL DDR EDAC maintainer York Sun to Credits
Date: Wed,  2 Oct 2024 12:52:11 +0200
Message-ID: <20241002105211.43276-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last email from York Sun is from 2019, so move him to Credits, which
makes Freescale/NXP DDR EDAC driver orphaned.

Suggested-by: Borislav Petkov <bp@alien8.de>
Cc: York Sun <york.sun@nxp.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index d439f5a1bc00..77b4760142f6 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3795,6 +3795,10 @@ S: Department of Zoology, University of Washington
 S: Seattle, WA  98195-1800
 S: USA
 
+N: York Sun
+E: york.sun@nxp.com
+D: Freescale DDR EDAC
+
 N: Eugene Surovegin
 E: ebs@ebshome.net
 W: https://kernel.ebshome.net/
diff --git a/MAINTAINERS b/MAINTAINERS
index a77770cd96b8..b9e2824d7ebb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8130,9 +8130,8 @@ S:	Maintained
 F:	drivers/edac/e7xxx_edac.c
 
 EDAC-FSL_DDR
-M:	York Sun <york.sun@nxp.com>
 L:	linux-edac@vger.kernel.org
-S:	Maintained
+S:	Orphaned
 F:	drivers/edac/fsl_ddr_edac.*
 
 EDAC-GHES
-- 
2.43.0


