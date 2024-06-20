Return-Path: <linux-kernel+bounces-223647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA2F911604
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EFA1C21F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80B014D2BF;
	Thu, 20 Jun 2024 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzjUHhRk"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B11422D5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718924128; cv=none; b=dcSyDAMRhL4tmRAb6g4PM/vztILJJQxJ+tTzNxavUWXX4pK358DpSnnLUFBoBbhdjKqrfK9TuCVo5bgvYEgu91+RVK5Wa8nP8NKhYDtQqW/Mzdi98mbG1c+vzMs08DaSNp1p4Od3u77hNGK8vNLbp2xB2HjI7d2Mhs2wciV1ppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718924128; c=relaxed/simple;
	bh=7E3v+0gLqGBn3XeWvM8WTYb4Nd3klVpPD6SOrvO9a+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=emAFyXxKASk0HWd2CwOKNXQh9yehbohYwtltSS64NPJKTVGGySu8lHL0LW5vTUlIKfH4kZc9fDGggq150GnO6vE24CnDWEPNN4+ztkQIYmWqlNjBLddUylASUeQ7Cr0s/5KesGtwKyW9Xi1X/5CZP9xqnTLRaiyUHoAMWUDK3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XzjUHhRk; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so16197111fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718924124; x=1719528924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59oHXNpi12pYEsSfaS8SpC7edflQWBXEOYjnnm2ogho=;
        b=XzjUHhRkzk7BPMXPjSnBx6YOZ9oPEGcPrs6AE5mzUgYInr66V9zVIKQwW1ohhbkFNz
         Qjxi7drZ02KP6xWeH2NF93IbUp/U5gYUcIJrdYtpS8jL3eEyjmxfhbFQk1LiEexx8k02
         ZZct553Bo8X55LSU5OPmi4dU8ZEFsqN0eWxUEwjpPzHQSVe8Bu79ybh95A+Maa2Mk23Q
         0Q9ise7QE9AdV84caUMyw3DTdkzpRXAShx7COB3Quehc8pcaFBaZVTRFRK0ph3T0ZEtJ
         X+9amU+JJCWw7Zy12p3iHo5g7LIh0wEaNwjlVeNKL3cFaH9WieZUbfT4HQModmgZ7BYE
         +bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718924124; x=1719528924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59oHXNpi12pYEsSfaS8SpC7edflQWBXEOYjnnm2ogho=;
        b=cGNN3+IW6ilLBo/p15GXg/Ya2u7q0WiydZ/gHWole3K3ZRlgIgCITY4Eazac8BCQDf
         90vGxs2fEjdc8ljD9ugymOkzIj3/G3KHpUjxXv1AtGxxC247joMHfl/7dAginKP8nLZC
         XytojgKMuH2jVywZfoFTvMTNJRc6LOUSXmK4r2mSGUztQGDtlVxqBlpaBZbGkw13U7Iu
         fqlIMD52uvtc+HUs0fd0cFGsqnnJtKWlWiMRJ4MDfrdGZjJPaEJp+gyuRCZDXjxt6py3
         EUEZNQQs+WRkZC0+75VGNmluJiIEjI2SGZF89y6TYqvUvU+xbPmWDnCm46IrLZzMsCst
         z5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCW59Pjn2eUpVVrVgOYzVW1SnpkJjqoENgPDvn8zt1ddhjfdxK8NmTo5z6rD3/W3SDt5tbym41shO/VwQVGA+i+Uf4QlySeWXIP4sHx4
X-Gm-Message-State: AOJu0Yy0AWu37ZWozj53pkuPifWu6AfdNu3PEicA2p8ahqrL/5xXulXA
	A378V/LJmfsLVcqvjX5gO2t/cTFVV5gsJ2r78RdGG8GwMFbSPutmsr+2UxOhNGA=
X-Google-Smtp-Source: AGHT+IEDyGBKz3t3wGE2QIBNprd46E5kie6qSIewKgUjN4f5gzLvwrTF8H7FN9Rdja49NN2RywJamg==
X-Received: by 2002:a2e:8904:0:b0:2ec:eee:f197 with SMTP id 38308e7fff4ca-2ec3ce7e058mr46393111fa.9.1718924123766;
        Thu, 20 Jun 2024 15:55:23 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d60126fsm510461fa.20.2024.06.20.15.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:55:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Jun 2024 01:55:20 +0300
Subject: [PATCH v2 1/7] usb: typec: ucsi: move ucsi_acknowledge() from
 ucsi_read_error()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-ucsi-rework-interface-v2-1-a399ff96bf88@linaro.org>
References: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
In-Reply-To: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Nikita Travkin <nikita@trvn.ru>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7E3v+0gLqGBn3XeWvM8WTYb4Nd3klVpPD6SOrvO9a+g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmdLNZ45oT6EY8DYlITEu+W5ykCaKw3FQHbQSiU
 G+9rz60uKWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnSzWQAKCRCLPIo+Aiko
 1V0oB/97hJGoKKWHK/VtNc0gAJ9+nbCucdeyixOoQ2IAHqQRbB406Sz9CIG2dlvR1ljV2fhUjol
 /TLxEA2QJgN9N9Z7o8gdFY1TmCtgB6XEVYKMA1be5fzzCDE0OA4lMHTTItT4VKvzWIBWsgGfsqI
 tn9C2ze2WpNKnVTFGIHOmY83R6J2BvHTk7lOPFYxdaA33oFYNt6Tw63jl11XXwJ/MKvkIlFG557
 rwjeWarTd7Xygqco4AX5c0cGdU5uRoPZ3kZ02bDFHoGekzqlOuVC42XxqGYZgBYRHJdEUngqAj0
 CJtDpxRPtZAH3K1yS8Seke4+5pQ/bXf2ij+VZI4/tJLS4vGz
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As a preparation for reworking UCSI command handling, move
ucsi_acknowledge() for the failed command from ucsi_read_error() to
ucsi_exec_command().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 134ef4e17d85..8e4d92cbd6e2 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -70,11 +70,6 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	u16 error;
 	int ret;
 
-	/* Acknowledge the command that failed */
-	ret = ucsi_acknowledge(ucsi, false);
-	if (ret)
-		return ret;
-
 	ret = ucsi_exec_command(ucsi, UCSI_GET_ERROR_STATUS);
 	if (ret < 0)
 		return ret;
@@ -153,13 +148,14 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	}
 
 	if (cci & UCSI_CCI_ERROR) {
-		if (cmd == UCSI_GET_ERROR_STATUS) {
-			ret = ucsi_acknowledge(ucsi, false);
-			if (ret)
-				return ret;
+		/* Acknowledge the command that failed */
+		ret = ucsi_acknowledge(ucsi, false);
+		if (ret)
+			return ret;
 
+		if (cmd == UCSI_GET_ERROR_STATUS)
 			return -EIO;
-		}
+
 		return ucsi_read_error(ucsi);
 	}
 

-- 
2.39.2


