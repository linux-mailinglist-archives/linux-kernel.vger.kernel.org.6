Return-Path: <linux-kernel+bounces-381070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D79AF9D8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64522B21D72
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7431B07D4;
	Fri, 25 Oct 2024 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWYd3nr7"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208018C030;
	Fri, 25 Oct 2024 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837204; cv=none; b=PCuz6dsMmJsliwM50E1R+SL0/xWOJI4RuHAg6BuZpYw7peCpTwQnQ3uRwwS3tpwD9rMPKuA7VgVncQqRgwaWEIg4uEsp59QO150Q/XzlRVCCEr5E41Puwa/FM295NM+VDaZEjuIeL7ai3iR1SWnLSmZlSbC2U88J7+FwYPGWR+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837204; c=relaxed/simple;
	bh=V+vzqnpPmPOEdSqgXZ6tsPtY00/HMyQfMBMLBpIhT+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9OHXwS2kHH0CmL1PDb7VIaibDeOeUBE2v1drwLLRsLH/rjb4xcjNjBmKN5Fxr3kYQHij48H6JKWW/EEObggrtonFltyFZnV/NfAOv06a44Nje5hvydmS7tPsJPGlRIbNrODCvHB0VgJyzFMfKK9s8jmsEfehhqeNBD+seSGftc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWYd3nr7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e4e481692so1257759b3a.1;
        Thu, 24 Oct 2024 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729837202; x=1730442002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhrgVqLyxdqiQnXAPef/3Ame6YwmD5s7oj3GvR+R9AY=;
        b=jWYd3nr7DOwk53CvbAWLHw0OWF+1Qf43Cc2ofFPrfd4nnwTXcKbq2l7b3ihyg/mTXD
         JdtnnMza4dGqQ6LcxIPPT0E9+ZHsOV4CXpOFDAtjJT096iQ8mlhqSFvgJSJOQyAiyihT
         o7b7tvM/CvV36NLTNr4L141r/iQwFmyuKsA/DqPvWP1yYpjqIpkbcSVMDuQHxFiY9AMK
         uqu4FMrb3GLgtVKQQOChpHzjpTOCKVOnvG4gpWzhZ3YYzwsvAEv2TdCXxnbv7NOFm5t8
         JPhMy2bVcpTlZoGMunuBaGUtj3vtWEdU8jJGR8XoBG1CN3dmYf3In4uF//1mlarHIQQQ
         Zd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729837202; x=1730442002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhrgVqLyxdqiQnXAPef/3Ame6YwmD5s7oj3GvR+R9AY=;
        b=ZbzyyG4mG5kxdNw2GUYFsvumSbtTfv7N7XIpELrF0+22EVnapXkVXpYSdXiZGSHbj7
         8VGIyvagulGtQBKtx/ovs93vQr2xYJSV/UrZ52AStna0wF4lWVymIhT0Aq+QusDhaY3B
         2PyrVzPrh1PdB99N/zue9NDn0t6IJ82Me6YWI+pQbcK6nfJNlUx2qgUJzwovR6G0sKur
         W1UgnfCo1EsbwGUAPHZXLLePJk4mj4FbquLzcy7iLqxueKJVjs/pV6B4K7x5jDuLAj10
         aDiT3aM1v6+d30+ihNEED3x6eqQhFKkl0/Is2fHoZs+aoJ5rwrze6RET99IFeIzW/YUO
         rjWw==
X-Forwarded-Encrypted: i=1; AJvYcCWkH2EXZS66ahtnPEmrBBvOUOQ3oZIaBaA/5EGPy37r/j18HDo6P+fB2YSd7HaYXEGWFibA2oCawRW5hQc=@vger.kernel.org, AJvYcCXUhJ1wiVB2IGVpLY9WxyRxsgw46xujmK6PoeAd0Xc2wxJVSUEbEWBUxA6+OmNTqZgjr8oagpiQmzBT@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk655LjtIvGAQS6hiqTa3lkYWovUJTpYUxpHdXolGugiIyPMap
	ovBPPU8o3CGiPREHMDgp1pROIH7J1ZtYNRr5SW4Bp7XhewR2P1f0
X-Google-Smtp-Source: AGHT+IHLtn6zzosWSTiHk/ocfkpgYgaKXO9o5WjHynguqyhi9xSdotBxeLlz/c/h5aq5C8GJKiETbQ==
X-Received: by 2002:a05:6a20:b40a:b0:1d9:261c:5937 with SMTP id adf61e73a8af0-1d978ba06eemr9944881637.33.1729837201788;
        Thu, 24 Oct 2024 23:20:01 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:550b:d387:a102:1511:5e8b:8a24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e578001sm2566697a91.43.2024.10.24.23.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:20:01 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH v2 5/6] drivers: usb: serial: mos7840: replace 'unsigned' w/ 'unsigned int'
Date: Fri, 25 Oct 2024 14:17:16 +0800
Message-Id: <20241025061711.198933-6-tony467913@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202410250141.AEkzzW60-lkp@intel.com>
References: <202410250141.AEkzzW60-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix coding style "Prefer 'unsigned int' to bare use of 'unsigned'"

Signed-off-by: Tony Chung <tony467913@gmail.com>
---
 drivers/usb/serial/mos7840.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 31ec2cf1b..d2cae6619 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1201,7 +1201,7 @@ static void mos7840_change_port_settings(struct tty_struct *tty,
 {
 	struct usb_serial_port *port = mos7840_port->port;
 	int baud;
-	unsigned cflag;
+	unsigned int cflag;
 	__u8 lData;
 	__u8 lParity;
 	__u8 lStop;
-- 
2.34.1


