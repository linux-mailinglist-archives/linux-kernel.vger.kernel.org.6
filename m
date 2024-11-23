Return-Path: <linux-kernel+bounces-419086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD339D6944
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4891616EF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13814EADC;
	Sat, 23 Nov 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhkAjt8O"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6BB195;
	Sat, 23 Nov 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732368649; cv=none; b=V6g4dJpwVYIgK42onAygUB+KHofAyskFP2VogUDRK+0xMbDBaclmWBdErwSwJAaCuIqfDBfJ0nsM+94xANVQqyiPfAl3t9EYdaJC0BXbUIy+u3vs+4tpFC8smyt85+TDcqVnHgrFjd+dc+8ab1hsRVWSen8Yf5Cg06rdjYnAj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732368649; c=relaxed/simple;
	bh=PODvO7efBSYrARH+0IcTSogGogSpn7ZuwexSw10wPcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ECHh7y7FFbfvaIZ58L6vUV5gNbKT2mejZ62RLBf8cfzwXRwzGMi8JWA3TPDnNhF43RVbP7EoX6Nfd8j7ODEsZb5j4Rh/3S3ZS2Ne5QZxl0H971MhNtmjFTCH2SnPdPJ9ScYIQwFbyJUrcRtpkr5UPOO4o8dLZrWDDYWLWfrtvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhkAjt8O; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ed49edd41so489006766b.0;
        Sat, 23 Nov 2024 05:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732368646; x=1732973446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9jVh5FVgJEYeptk/BgcXIyUBn+GDLBlAirNbIOzByfI=;
        b=FhkAjt8OaGYrmz1WRXrBmZ1tDalCsumqSiJrrNNwmNxC+KXtd6Fbp9ZtR5VSTIaW0w
         9Tysj8R5j0l1Ijkm94O1MV48rNNn6dR2DBT0bfHX2zegXXyQ+X4YrkdAY3ORUmhulMRp
         gzY7kUs57GO+DLetWWlAeZ3MBZzJ+7Pz/gYFBlmYytnd1kCebRMlwLogxa699j30mrsB
         m/w/ImSJoSR7yYmuHKO7RotHOuBnbDuH86JSp+65+XIVM8Rjuq4oUMQCHrCf5Ndj0PfC
         e/ocIvZOekoOGH8yAUmJv1KHikAaqKMxRVniPMRQM9dNWeedu3LWyovmYQF56jvpwX+J
         DNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732368646; x=1732973446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jVh5FVgJEYeptk/BgcXIyUBn+GDLBlAirNbIOzByfI=;
        b=ST7M5WKkZZ4sDL0mjqPCHe+JRMr1+GWeo4nSq7hQKVdnEgwIooZ8PUPW/eqnCvNFUW
         G75E7IjUx5Fd3JbjCNOgXaSZedaHXycWcsnwV6t1U9FIjX0MDUIOUuIflDD37XWK0qIE
         Ga8hg8ySHD7h78flzQ9iFqZRBO19lDbg6EmQUbZ+vNU+8HMtdgDNpxRBM+/pi155xvXt
         /1WWJB33IxfpLMFDgCcnXdSbfmnoj828EVIAPncwmgE5fdB7RyIUjqi8Bpw8YmtCepyP
         I3tFKN3zWRz8qWhfjAD/pxSXzRe/6jDbiJaoN2i1PYQDDXdTjeRdij+PnlqJkCRRrbf5
         BMEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh/oKmQWJGYjLjy7TK/PcR8q3NNFO+z6LcALv+kGIICSUCGtxCGQ+2WFEP5aPofUm67NtTbL/A8idR6T7NezdXwa7a2g==@vger.kernel.org, AJvYcCXaIpBdIszwKnEVCZxlCI1qnuVyJg3doKq+A5nOdGY9aJWl7aGGGegMBLYaIyVYwIQ8LRKdsRqW9ExO9H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMt+M1vNalw7EKCz1DPCg01is0vYCSECVtp0fP7+PDIQJDIu4L
	FRouoHxbjqM0r+VPwteAQI5h4nRgH0Hvf9UE+hHkz86mNbR9EdXQ
X-Gm-Gg: ASbGnct4JBmz80kFso5FeCrrsShY4Bql4oM4VEITL83G2qfcQWkwlXtn57xZzL/Hdne
	ljriDni9MYUBML1l/V2jjM7wBTYKe0bPlIxIb2M78/2UJzflslfAOXvPa+xyJ+I+uTwarL2xIyb
	2XU0HznKpx4yI0pA6GtdqlCGT7wEeIScwRa+qNarlWME/iS2JOz5WnLLhfx4xNV23elI8IJk+Cl
	Jhu+chya9GMEb7n/kGtcqJQU44zkfJ+atbk/TzoViWa+OzQnz0oCXGPqeIju8J+rg==
X-Google-Smtp-Source: AGHT+IH3iRbFV5Bzaffw47/xC2RWeLgrHDa6s/8Lzdsn6x/e+Nte+W8YFRBxuPBpOchdVjoZ+ONq+w==
X-Received: by 2002:a17:906:3295:b0:a9a:296:b501 with SMTP id a640c23a62f3a-aa5099f7262mr422932066b.26.1732368645937;
        Sat, 23 Nov 2024 05:30:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:3030:a:6268:4624:5b8b:5eeb:b500])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28f6d8sm225877966b.33.2024.11.23.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:30:44 -0800 (PST)
From: Sedat Dilek <sedat.dilek@gmail.com>
To: Corentin Chary <corentin.chary@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH] platform/x86: samsung-laptop: Rename MODULE_DESCRIPTION
Date: Sat, 23 Nov 2024 14:29:28 +0100
Message-ID: <20241123133041.16042-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename from "Samsung Backlight driver" to "Samsung Laptop driver".

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 drivers/platform/x86/samsung-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 0d3e3ca20b1b..decde4c9a3d9 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1653,5 +1653,5 @@ module_init(samsung_init);
 module_exit(samsung_exit);
 
 MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@suse.de>");
-MODULE_DESCRIPTION("Samsung Backlight driver");
+MODULE_DESCRIPTION("Samsung Laptop driver");
 MODULE_LICENSE("GPL");
-- 
2.45.2


