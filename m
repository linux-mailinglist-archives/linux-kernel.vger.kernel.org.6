Return-Path: <linux-kernel+bounces-223431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB809112D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDB01C20F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6724C1BA87D;
	Thu, 20 Jun 2024 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9gayOoH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611F51BA07E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914487; cv=none; b=P2/y9LBRKMhABiQVYG7OlRvqHmW8+DApeO6tVi5udeAmc6YAWCq7LecG7FCa0AQ3+O5hJoJQnwGukwObbTWbN+uTNQGSfinoq5gII+l+uqA6Mhq0RgbDUF/BlNpR4QifGzdXQg885KCzBNNPlj2c7ckAdjJ6KDG4PvHJd1iXdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914487; c=relaxed/simple;
	bh=2j3mQFB7iTl1buIKWTw++t/Z3MBaEzKNVz4k5V+ti+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAazCyDh8iNQBQdWH1FAnnPEQdHRfQlsj+yT4cnfReKWoOtLCUoFc+nK2orD9a9f+jzmzxGnROchlrCNvRcwKD9NZkzL2+EPoCLboFKD+/jsiKZqma5hHUJ6em/Xamyc9WG8ph7lwbnzD2dQsFjVqxBDTTIRiJv99tdLLN++wCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z9gayOoH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718914484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=stWFvKfQWMunoN+aSizxyUNPbtT8PDu9EoTxxN5jaME=;
	b=Z9gayOoHCm1Srud0PTV27PzzICUcc+1MsX+DrlCgZnB0QAYqeOPsJUu6dS7vP/h2itS3h4
	H1XSu8hRyIB7LKbmdeH+oXYp1lHcBFfeEXDmxSmiywYeMj1H++szdki+u9hv87f5I8z7Zi
	nCxvMXSjd5Eq6BFYuJldFPth0kuv0dk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-na0uturlOBm5kvJUWfkqaQ-1; Thu, 20 Jun 2024 16:14:42 -0400
X-MC-Unique: na0uturlOBm5kvJUWfkqaQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-57c93227bbeso701443a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718914481; x=1719519281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stWFvKfQWMunoN+aSizxyUNPbtT8PDu9EoTxxN5jaME=;
        b=I1dW4lmlYO/Z2AJ90KG3vBijVoC2N5JnnetNwEaa1hOoC6hHkPAyOaH4t9wtQ79Q6W
         ilxShVZ7PLNsc74PqRzDELEHW9KKC5NfMXpKwa2VSO5F4TraFPrSip2e431S04UoDXuA
         rPX04+zxQrZWnjWiA9cv1WKcj+2aoNAIa0yRtk4K6KrjZ9/yGth2MRvn2rIw+8JCTEfv
         H8TAzuCJ8p3Y/FgyZPOh53FL+tlfS2GQ27IS1Ls4ZiY+wN0etxKHsMJIPYamh9C/n6+V
         yrnJps36AHtB9J6gMo5rKsNa0rqXpmQfeGbocMAt/5tTE4br/dujratqxMEQwv23MkkS
         tPVA==
X-Forwarded-Encrypted: i=1; AJvYcCX5DGe9qrdHGwnuByOiE/p3ShSEuVujfy5CHTog6uZUfIlZtJwUmlW6ShzMIDyA55d1LVzltKq60CGbYV5fZ46LD30S/9HvEXHpCNmk
X-Gm-Message-State: AOJu0YxDBQaeF4Xsah9+0eMD0yBeJY4Huqh2sV3MlwxWR47OFUApnU3d
	Hm48UE9TeFLcsSkV3Vnc7FYfwXoF2nWjt4bsdWXs+9Xq6899+akWOMHAkjemDPsWRMMBA6OXies
	YhdK6tz7SgtotBSCnY00pH0N2wauWyMnxEgtvwGDJyXg9F0QHWI+t2N98CHXVpA==
X-Received: by 2002:a50:9b1c:0:b0:57c:a701:2311 with SMTP id 4fb4d7f45d1cf-57d07eb266emr3541325a12.26.1718914481514;
        Thu, 20 Jun 2024 13:14:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwT2V8ppfUQALHQ2Gx2dIUCQcXKuvxeXgHo5UbL20yvWmBKnofAzONZopukB2iwYsqsq/PEg==
X-Received: by 2002:a50:9b1c:0:b0:57c:a701:2311 with SMTP id 4fb4d7f45d1cf-57d07eb266emr3541312a12.26.1718914481052;
        Thu, 20 Jun 2024 13:14:41 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743b032sm10020898a12.92.2024.06.20.13.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:14:40 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] clk: qcom: select right config in CLK_QCM2290_GPUCC definition
Date: Thu, 20 Jun 2024 22:14:31 +0200
Message-ID: <20240620201431.93254-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 8cab033628b1 ("clk: qcom: Add QCM2290 GPU clock controller driver")
adds the config CLK_QCM2290_GPUCC, which intends to select the support for
the QCM2290 Global Clock Controller. It however selects the non-existing
config CLK_QCM2290_GCC, whereas the config for the QCM2290 Global Clock
Controller is named QCM_GCC_2290.

Adjust the config to the intended one.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/clk/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index f72838aa573b..ef3c2852f531 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -68,7 +68,7 @@ config CLK_X1E80100_TCSRCC
 config CLK_QCM2290_GPUCC
 	tristate "QCM2290 Graphics Clock Controller"
 	depends on ARM64 || COMPILE_TEST
-	select CLK_QCM2290_GCC
+	select QCM_GCC_2290
 	help
 	  Support for the graphics clock controller on QCM2290 devices.
 	  Say Y if you want to support graphics controller devices and
-- 
2.45.2


