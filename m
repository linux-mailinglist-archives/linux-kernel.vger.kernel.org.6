Return-Path: <linux-kernel+bounces-311585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA38B968ABB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F551C2267F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D5319F134;
	Mon,  2 Sep 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxGOWkJm"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5271CB537
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289960; cv=none; b=R8I51r5vEJjyASSBX68gK64QFu5tZpcTq3j6C/0RicjtIpnX5fp56Idprf7OFhOw455/dU1ex0cF3WLm0hbZm0nGIJaZIT6JaWM0wFDDcNJVH4MfAiuxpiQpfJKtmuBGSejN2cnURMAwyqCmafEyGc6MQwwzwXdjyjuTXWGBv84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289960; c=relaxed/simple;
	bh=iDy4i4AehiIZeYd4i1LFRxEcOaeR0XqvXNmYBX9hMEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kLvSC8UmLAdoS6ch9H7w1QpBnxu1VzYnhPWcZz7P/g7irJnNA5tcCDldgd1n8QHxXFUQ04tdq2UgdYBlXFhXyVMI4Ecbo9sr+JujvYLXzBzlf4NVA2SZbMxaOq07urZ2QfmOIa9nHfZEgIHTZ5OgvTB0TF6kY0gS2T95HzsknOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XxGOWkJm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so4567185a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725289957; x=1725894757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKVoTZcvRuMQbe62Ok1KDq4nvQBQsJ3GYutKczQmCkg=;
        b=XxGOWkJmzdGCe3WgVExMOv3P0d/kActtXPn10Onu/g7cgNSLps42XSQsa1qqv5Uz5W
         dYPujVCTxKTnfu4paV3iQHI0jmS8PaULWoT688M/P4r7YIVva/bt5nT3WpEokWybKscv
         g7rkhv+4SLf4FUaVcF3IjiGEVOFrFH4yBEAYqwY9c1r3bGWxPANzF/MuQ5ruhOCk0EXS
         qOD3QUDtbq8tjA8ZoRhlG9MoedvOZUaONjN2OSmhunsr8Si0fixc+9L1qMHAA0cgKlDP
         AIQIH4JoJRB82/urjznM/27g6yYR6FREhBImSvnUB1sZdycamkxAkMt7v2PqYoAe01A2
         pNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725289957; x=1725894757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKVoTZcvRuMQbe62Ok1KDq4nvQBQsJ3GYutKczQmCkg=;
        b=eu+bzUYYz58a988on6GkXnqs2X9IX3bX7tCFdbSKM3gr6zwvHgpUA2bxeDlTk2VWLx
         l5dpdrNQjKSgaEQcarg6S+JWqTyN1BJUfgptTmmuiZJygfeHL1VJIxmjpDk3ZfRHrW6T
         a/U2lXH1xOn+zoj7PuVzsj94seXDv6QpzeOi5JdkotrlmGKjzTTOFAIOOv3aBAIr0Ruv
         k2PzO6GUe0QVE42amaU2l6RpdjBVTcb/Z9VNTPPHDTCXL87jE8/C8IwOKdm/uoDfsqF3
         HXBlq7CMx421fp7tVX4Lads4YQK/pIpKRcvHo+0RHbRVQ7jXeY88Dw30qYxFSy63qkgu
         FrLw==
X-Gm-Message-State: AOJu0YyXMxWwfP211XFVPnTB4MjEVxMVblos0HcHfjXHtPX0J4ouMDGi
	PzM4jbqN4zA2uDJuG5oJyeYtQF96bKO9yxI41FNDSOkhOG44Xqc+6XlysUj1FxsVkCep1ATMI68
	lu6k=
X-Google-Smtp-Source: AGHT+IFHX7kiNyn/EiCOAg3GxNi7qZm+j1QIWUM2UZ12L/slU+bQcHGvd41F4a6Rn5ZG0q7TBWZrIA==
X-Received: by 2002:a05:6402:348b:b0:5be:cdaf:1c09 with SMTP id 4fb4d7f45d1cf-5c25c4034damr3023143a12.28.1725289956747;
        Mon, 02 Sep 2024 08:12:36 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c255d3da3fsm1923394a12.79.2024.09.02.08.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 08:12:35 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sumit Garg <sumit.garg@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] optee: add RPMB dependency
Date: Mon,  2 Sep 2024 17:12:31 +0200
Message-Id: <20240902151231.3705204-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902151231.3705204-1-jens.wiklander@linaro.org>
References: <20240902151231.3705204-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent build error when CONFIG_RPMB=m and CONFIG_OPTEE=y by adding a
dependency to CONFIG_RPMB for CONFIG_OPTEE so the RPMB subsystem always
is reachable if configured. This means that CONFIG_OPTEE automatically
becomes compiled as a module if CONFIG_RPMB is compiled as a module. If
CONFIG_RPMB isn't configured or is configured as built-in, CONFIG_OPTEE
will remain unchanged.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp@intel.com/
Fixes: f0c8431568ee ("optee: probe RPMB device using RPMB subsystem")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
Replacing "rpmb: use IS_REACHABLE instead of IS_ENABLED"
https://lore.kernel.org/lkml/20240902080727.2665235-1-jens.wiklander@linaro.org/
---
 drivers/tee/optee/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 976928641aa6..7bb7990d0b07 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -4,6 +4,7 @@ config OPTEE
 	tristate "OP-TEE"
 	depends on HAVE_ARM_SMCCC
 	depends on MMU
+	depends on RPMB || !RPMB
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
-- 
2.34.1


