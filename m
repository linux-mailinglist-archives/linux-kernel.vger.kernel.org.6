Return-Path: <linux-kernel+bounces-262440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CA693C723
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541F42833E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E446919DF6D;
	Thu, 25 Jul 2024 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtzUo0tV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF719DF57
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924900; cv=none; b=IgYNscqdLXbVrx8SS02feb8W0lVTejN54nyqw7CqaqhtBSMngW4kfoLxgR7pDQI5uSu8CpqCm84svBzxykJwFqHylc4pvMcefnZKW7XULC0AaGnSQxyIlWb3WFOhWT33zr+8d/Q5jpy2FEoCBPLwDVkD+rqJ7YRVmLNFuN9Zp0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924900; c=relaxed/simple;
	bh=Fy3kYahgwmE/GH4851HLgNpm3At9MaQwpO/m3ngJEhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NWOhthbyL+TvxdkEnCcihu5Xb8tedS4/f4rJTblcamnYyMVGa5TUlrYRlANCHuF7FTfTLSIZoNF/Mm/wVL/tZaeGFl4Hvgok9QnlFJbpwmF2N/Yc9+YlHd2OTYCYs6zR5NDriyVSUvso/OTpfX3DfRi5eBia66O+7qEumjfDbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VtzUo0tV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721924897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cZ+wQu25/ua22FV3hTgwYKgkP5cYl1BWWCM6PQeMbuQ=;
	b=VtzUo0tVrMN0zAdCzABUK+RcMPeRyQKAyLBUQ8zWQb77Ck2XYOeQ8PvWSWy5vaWrssrKJD
	C1bM27596cJvUj7FJtfhwnRUUcr6HzeIfF1JePSrkG65dSupkjfknIHX3G8mmV3H0h06Ns
	7ghTVmTalaOGMyUSVqWTLmXIhstOm80=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-e8OTtE_rNSmuXvxUmi4GXQ-1; Thu, 25 Jul 2024 12:28:15 -0400
X-MC-Unique: e8OTtE_rNSmuXvxUmi4GXQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3db18cf7be8so39815b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721924895; x=1722529695;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZ+wQu25/ua22FV3hTgwYKgkP5cYl1BWWCM6PQeMbuQ=;
        b=k3cV0HflWNU78m+la1XnQy3AbyreP1D7Cf9ve8RZQleYXBAPOau+g3m42TgBVuRNMU
         OQRB2RjnH5+o2OH80GhZ1fNYaS3jizSa9Zs8WLZKmqNlRNdPDxeb/BI8DqE5Iu8QwqK6
         h1ZTIPNktXRWZryygdxfpxv/gFP9UKldA/SbIFTdrZ9Q1sWelKPFuQu69yg+dLMreRdL
         Zmdz1odOMHunsJF+MNCgYAVvHbJwLHRW6n+JrzGXkpLx3FRN/ArC6Kr5FquWsl8rjwN1
         akLq/+LJGkbMGLajDE3I9AijEWlUsSrmeitNmaGKI1TCd/b8KFIo0BIaRyYAAP8ctHKl
         6Fwg==
X-Forwarded-Encrypted: i=1; AJvYcCXEeG6UXsFL+QWZHsPvkZBwStFVQEU4Z52bxmmitpQmCgemG6i1LrtjGU+DoeVqjP5WKoOshRiL3wgi86Zd0aXssABShiD0xz49eWPj
X-Gm-Message-State: AOJu0Yz/cU17yrocn/8OWd74eUWEOQt0DnHwBr+pX1w7Ca97A3yJ7x+z
	OLR90C0fCEkVMK10CPZL0lCjXnsf2XCWSakoa0KsLKvg4D1963MIvvMzCq/lUVkZ7HOmgUCvEZ7
	GKzRD/93Fd/a8a8pva/MSkT2BkLmzXve1Br0TdKnBb4bTPnX0LmvI3U3P/WLSrA==
X-Received: by 2002:a05:6808:181d:b0:3d6:53fc:e813 with SMTP id 5614622812f47-3db140bff2cmr3159248b6e.27.1721924893346;
        Thu, 25 Jul 2024 09:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMAqQVsztQReopcibpry4r4T/+OwZn5ktiSNKQro8eLj3uPSHdhUfG11WU01ulpVQ63n41VQ==
X-Received: by 2002:a05:6808:181d:b0:3d6:53fc:e813 with SMTP id 5614622812f47-3db140bff2cmr3159220b6e.27.1721924892887;
        Thu, 25 Jul 2024 09:28:12 -0700 (PDT)
Received: from [192.168.1.111] ([2600:1700:1ff0:d0e0::d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d82c2sm8781806d6.16.2024.07.25.09.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 09:28:12 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Thu, 25 Jul 2024 11:28:07 -0500
Subject: [PATCH] power: sequencing: pwrseq-qcom-wcn: Depend on WCN36XX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-pwrseq-wcn-config-v1-1-021dce9f2513@redhat.com>
X-B4-Tracking: v=1; b=H4sIABZ9omYC/x3MQQqAIBBA0avErBswSYuuEi3KRpuNmkIF0t2Tl
 m/xf4FMiSnD1BRIdHHm4Cu6tgFzrN4R8l4NUsheDFJhvFOmE2/j0QRv2aHYtNbjpoyWAmoXE1l
 +/ue8vO8HghHL7WMAAAA=
To: Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.13.0

This driver does sequencing for the hardware driven by WCN36XX, let's
make it depend on that. Without WCN36XX, we're sequencing power for
nothing.

Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
I *think* this makes sense, but if you disagree please let me know. I
was sorting out configs in fedora and noticed this was being asked for
builds that didn't have WCN36XX enabled, which seems odd to me at least.
---
 drivers/power/sequencing/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index c9f1cdb665248..a4765cb33a80e 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -16,6 +16,7 @@ if POWER_SEQUENCING
 config POWER_SEQUENCING_QCOM_WCN
 	tristate "Qualcomm WCN family PMU driver"
 	default m if ARCH_QCOM
+	depends on WCN36XX
 	help
 	  Say Y here to enable the power sequencing driver for Qualcomm
 	  WCN Bluetooth/WLAN chipsets.

---
base-commit: 2347b4c79f5e6cd3f4996e80c2d3c15f53006bf5
change-id: 20240725-pwrseq-wcn-config-0b6668b5c620

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


