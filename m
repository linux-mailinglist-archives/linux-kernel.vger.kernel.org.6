Return-Path: <linux-kernel+bounces-559080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E6A5EF4B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56727A99DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FEE2641DD;
	Thu, 13 Mar 2025 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqQpr28b"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC90263C8E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857252; cv=none; b=hQlV1XiMKBm0oj+qOQzquYKksJAOWoXm4L9b1co3QpUOqSN5/lvBkYpMRRMiUdrgLnCJ3OpDArSyFSI7VQul1sQ2lR947T5ecwwtZQEenMA8K+LuRH8zuDrHK260TCQiX17dwk/beLOZelFlWATdVinf1P7Q7el9tk9hg976bew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857252; c=relaxed/simple;
	bh=LKuINLvR9AokwKtQ0i0k3u46oD1MBrKVji5Ygd0Sbao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FK0VuBWs+AANnUEwCMyp6E21vOBz4MP4ppLaef0qAxfBfE844Y/KWP2j25pbHY3WvFofKO4ectN+Zy1Yy/couKJdO+xFMRuJSiR6Z0UFupL0WMhIgtXWp5SNbUrCFRWL2wyjICjiE5p4euRfnHqHf8Bk6FfZqVNd0AXY6lR2vcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CqQpr28b; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7098af6fdso9493166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741857248; x=1742462048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5PkfWYyLQ7CmSIcBpOb+fP0/u9MUfqLHtzcFlzAIW3I=;
        b=CqQpr28buO5sfcUflDxdAuZB5SHl0BboxR+vgT18PrFpX09ljzkEnnGVFK9fpi3aLU
         kdsl/1gm7lGLAc9yPAi/uygWY9+m64x2gdmtDBEb6QI50Kpxj+kpdvcMqm8LGqr3ebnt
         syrsjIYc0SialSMQ5QsCKbfWxqmLN3TXtRvvhv7FKIw006zhsABHVFaXEFYgpiqewLjZ
         MbJdSJvWd8/T/HXpTqIFqOwsCYsRXE9ZxsoNWxonaRHzzbJMS+l5CkmIdTsAUdG81HiM
         o2DSuVyz8HOd3YsNbI7OnCvrkA7dYvGa3hs0Ru8tUStm4mEVhLzwfbAVjLAX/I23rOPh
         yzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741857248; x=1742462048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PkfWYyLQ7CmSIcBpOb+fP0/u9MUfqLHtzcFlzAIW3I=;
        b=PecjgZBIs7pjDF1Ni/A2d58AEUiqo+BPIrYJVCohDMTpTsiQlKFMNvalrshW17g+LT
         XX7w4WbIEB6wcTvboyo02kGO384jyD/duvVj/KEQhpJYww7WHQg5xwg0cUbwgR2rhKxK
         zRrOioq3CfGYRUsv49crKrKkev7An4PF7jDHfBgQ38IOA1Bjn8Pz/5/xwKwaePQIzGUU
         vPszgnA6ihm6sKjDPsTwcHxanoNNrqjOs5is2/QEwx4NRd/Ahig20cqAk9wycsbk8Q88
         QNuvcMkKVjQ3AtWcbBLeCvqhZAe6ebfp4VS31YTctgbcUzBOD2KEeXT19XJUOaYE1ycA
         m8vw==
X-Forwarded-Encrypted: i=1; AJvYcCU/jEoGy4FOSDEajIo3h3zuZmTn6gGUV2OAk83cKph7oq5COJeXTjiJjmoqUfW09dnf/d7Y4L2NTsX9atQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+hNWbZBmQ+QAgnL3vRPHOSj8VQ1ce98o0hhPnlI79GNI8MZp
	R8W41p8lBL6z7Gd4M7MdX8W19Eoy6U5yR3Jdx2MlSDCZA4TBC96tIzT0JKLBFOyVZP3q11OERY6
	c
X-Gm-Gg: ASbGncvmM/zrdRfzfNPZqlwHlJRrQB9PtVP5fnYvbefYB8cbLjWSXupikuItAo9ECQJ
	lMFwg70twHO6q3/DIHf/8SZqfKDGRqP+LJSWRj5MyVox2QzHI/yt0b4vCebTfzHozs36cR7jfV8
	qlv4raOGs92aQAGs9XB6gr3OSYPvQ42eYLRaSaEtGAqb7mvHhZ7eHULKayWRLylnKQ+Vt+aVsp5
	NUW0T42wm4As2JcZwd/ADS3zmWUdKzpCvU4iCbz8A52PvdabT/76WspiR4V7//wcE3P0+cVWray
	4dGJBhR6A94ucWwF69E7fJdPYPa1Y+MC0FzI3C07JYO/XD/NmrLtM4CRsQ==
X-Google-Smtp-Source: AGHT+IEqYE3xmRAC+FrB/kFJGQaFpMK3ddVVqQK87lG/Lu5OOCAf0iOzDDllrv0hIcMtoiZEWlJkjw==
X-Received: by 2002:a17:907:60c8:b0:abe:9c69:a7ce with SMTP id a640c23a62f3a-ac271317c2emr869358866b.1.1741857247978;
        Thu, 13 Mar 2025 02:14:07 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9ab1sm57803466b.52.2025.03.13.02.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:14:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Len Brown <lenb@kernel.org>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH] PM: MAINTAINERS: Drop Len Brown
Date: Thu, 13 Mar 2025 10:14:03 +0100
Message-ID: <20250313091403.50077-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emails to Len Brown bounce with:

"If it is importnat that I see your e-mail, please let me know via
instant message."

While I fully sympathize with above statement, I do not have Len's
instant message details to ask about patches and unfortunately email is
the preferred form of reviewing contributions to kernel.

Last email from Len was in September 2023.

Cc: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Or entry should be changed to @kernel.org? Not sure, I assume it's Len's
intention to use that one specific email in maintainers file.
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 67bfd9109535..68819df8e398 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23125,7 +23125,6 @@ F:	drivers/sh/
 
 SUSPEND TO RAM
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
-M:	Len Brown <len.brown@intel.com>
 M:	Pavel Machek <pavel@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Supported
-- 
2.43.0


