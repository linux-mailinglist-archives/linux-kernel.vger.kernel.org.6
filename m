Return-Path: <linux-kernel+bounces-333321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF3997C6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A3BB21997
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D697E19994F;
	Thu, 19 Sep 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d+PSUCJZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3619924A
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737699; cv=none; b=tXldUQKeeGV33fq8wEon7cEyYvCgsUuGNFKVu+schnTTDAe2BSCX2tmxuM9pgALS1g//n6COxpu0c9LogBxuNK82HqGRabiuVPWQmxwg30sXUqH7OtPGQ/VfgZujhbo8azcNLJUscB5x7txdYUwpgIzQBzdHYkQ1dwshlAir1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737699; c=relaxed/simple;
	bh=Ou8OfT+69WBiLVaYkprtWanFi5XHSO9mF882Eoasusg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eOmPHFw8Aco6tI3JmJjDbYJPOx22nYRSOEtf3V2fLjjftPwIqpAs8BezeJbwFcucpHpjNe/0Cm4h5zNWQ483FgWyK2D9D5UPa/HQ8vxvv2oG6nedLE8h14mifW3pMA+vqiyDFuP21Myk3MelB02o67/Ls/aPUL3SXdg2yDF3dcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d+PSUCJZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cae102702so4787515e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726737695; x=1727342495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bm+PhgVISoshe6+u0cv75nF5vnnSUSz3FJSs7aa+aiE=;
        b=d+PSUCJZmYdEiWLJZUNUc81ViaYPdsnZBvvzWuLxB/8qJoBWNoW3xz5GT4ZJ/rzFHM
         arpzuFQ3sUwXzIQeLaBvJlBuHD+xQK8wgB90nrjVJwNo3GUnCiJ/gW3FyNpCPdLZlaV3
         ojUJ7EQXF7A9gK6qZLp+2ZvQs1TGitn6h5MaH36B43Tleu2JARY+jcx8TA7TVOIUEDSg
         ncs05gMPftiD3Pr6m/N8M+q72BRnYaRlmevyqQQmjmFw1h6XlL1DtoIHiIHR7p84gQrJ
         Q4qIeJpygube7gDVuWowf00VjauGlTxsDsgyhoKMOjCpbF8Es1z74YIg6CQWiSmF7nRl
         mYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726737695; x=1727342495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm+PhgVISoshe6+u0cv75nF5vnnSUSz3FJSs7aa+aiE=;
        b=NwGVMcqaSvUIEF0FXzNLcNYcSFIly4DYBbdVkjGd/D2c3pwpl+JZ+qYRzBoF/AMGRL
         0T1cxd0zp+huTARWy/tMSrquakEzbo97gz/C+wq46MhNXGaOJUoYhaJjyl+cX6NqSeeb
         76GJocr6iTg+x4UCJi7reg3MJ4fDyXAPQ55gLVQbikXdNP3MRQoxc19vLbz8NEYysLux
         gYXN/6vlpZxKruvo30quqcel7wOJ849zfZuoCuieYAlDxLhLzOUP1StLyvehLXcxLyVQ
         WWfibChuKaxYgTwy/Lww01fSUNdwnfNktKGsAz0T4ZgB/Zuu0G9i1Oss5lIPPVBcRJ3w
         XO+A==
X-Forwarded-Encrypted: i=1; AJvYcCVT+ac9hMtcDut5fkjjqkn99yatfqgvZlKLebbO+zMbGxXqeEj48En8paWGwYIkXfQm0pcRbTykD7uq+7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92ZpuGmFvpaWdfBBTpBWNoQ4y/7sT0Zkg1/U1Yvgp0En1PHbz
	wFXXvVim9aVG9O6RmNqWpYMUWcwjncYMosSI5Cl0MVxuzy/3PjZk92tEAfeoPUc=
X-Google-Smtp-Source: AGHT+IFZL+BpyLS0ETVBklimnTddQLSVyt3UeGyl8jNbw4TKvjYFJ4jVSTQlrNtqaiCtdzx8j5Sv0g==
X-Received: by 2002:a05:600c:1c04:b0:426:6308:e2f0 with SMTP id 5b1f17b1804b1-42d964d8558mr144476935e9.26.1726737695103;
        Thu, 19 Sep 2024 02:21:35 -0700 (PDT)
Received: from [127.0.1.1] (host-80-117-99-70.retail.telecomitalia.it. [80.117.99.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75468413sm16889465e9.45.2024.09.19.02.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:21:34 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 19 Sep 2024 11:19:57 +0200
Subject: [PATCH v3 01/10] iio: backend: adi-axi-dac: fix wrong register
 bitfield
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-1-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix ADI_DAC_R1_MODE of AXI_DAC_REG_CNTRL_2.

Both generic DAC and ad3552r DAC IPs docs are reporting
bit 5 for it.

https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 0cb00f3bec04..b8b4171b8043 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -46,7 +46,7 @@
 #define AXI_DAC_REG_CNTRL_1		0x0044
 #define   AXI_DAC_SYNC			BIT(0)
 #define AXI_DAC_REG_CNTRL_2		0x0048
-#define	  ADI_DAC_R1_MODE		BIT(4)
+#define	  ADI_DAC_R1_MODE		BIT(5)
 #define AXI_DAC_DRP_STATUS		0x0074
 #define   AXI_DAC_DRP_LOCKED		BIT(17)
 /* DAC Channel controls */

-- 
2.45.0.rc1


