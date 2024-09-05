Return-Path: <linux-kernel+bounces-316924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610796D711
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38FA71C24F54
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6AA1993BB;
	Thu,  5 Sep 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPKqXcK9"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3F19924A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535680; cv=none; b=XhaEDqHjCjtyXR8aTKXvA1wJ8oGBDdBaC71MBcNpzddX7mQl7Sh1cV+clpgbwn5sLuew6zZmy9eu0UuhdLb3IdpnIlh+BnQNBMPMGVIAOQXo9CLQvuBSAopE1EqwTDqG2SU0B0+XDebbPC8NM8XmoTV8XLTa03YANDoAXDBzSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535680; c=relaxed/simple;
	bh=+jABMERXQN5KTk8oMEuhXLCBTTpd6MUgesfngcUhsWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iIhdQWL4xqirR30JJOCS4k4gSzftzT/zzLv2ax76dHXN7YaclMYveycNOJE4m4Nz9VCErZuK2OWzImc4aClSbJFLO60tfK0SlYh7Bl01BjSQRol6XS5ttvHZJb8ebftYBjmt0VpiEGSdUj0ay+U47fACmL6S3pcT208RS1YiCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPKqXcK9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d88a8c66b7so79052a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725535679; x=1726140479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+CyzlaX7v1ZWBjca1vTn1xo6TzAjHdC3F714KL1PH3U=;
        b=GPKqXcK9Dj6IEOobrsSpF/nHNJb6EO0Y/DBhZ9F1GIC6SK5bU9Iy9qF6v7WMoCoQUv
         mY8uHVSx3unRgDASbQ3XlWc24jfKhX6ObUMoAgbumEciIhhBqi0QUZpnBGQPGf55g7vX
         4emeNg4YiPAaNkEm+qetTi/CmqB8HO8Puz4X1+44Esaosdkq+zHd1xVH5yVxBDqW5zdG
         /CEb+SsNX+98CV0KeBlntlNTJEtvRCKhYe/nypTXffW+7IhunUyMiiLioJBbKN0fuszb
         tmvCT7i6Gitdi5cHlPlt8zbiCSKeCjnzh0TFly0U36RwNrbS1fXpFgnMENFLhKF96dWL
         s5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725535679; x=1726140479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CyzlaX7v1ZWBjca1vTn1xo6TzAjHdC3F714KL1PH3U=;
        b=gZRCFf6S8ncG2ige1rsSqYTY8Lwke5kEeFxtby/1AHHbggYyQkHAcPgeW1BzZDvkyw
         nCW9TusLa4hJlWIHFZVS7FPJfrf9DitPDPRLGUdwkg9QT005PlZ1nfifwhUW9WbO4Gc2
         wrgNsZBifJ53SmPnBsaUpCJkoZZAbmekqJNBi+gFJeB373wrRXLn9c9jpw+9SzuEzzFb
         T8Z9Kea3pgIWmqU5SlM2lUW43WhgFSY9j6Wiz6AZxH11xhEcSe3b+xnP/8K7r2qIXl94
         IoJ3evU/qi7HBsF16gZyaCODx+N8FMc0SCPinSLb7LzHVeMkYhvqefATO5eb+tHLLcQ1
         uNRA==
X-Forwarded-Encrypted: i=1; AJvYcCUrHPdq6Rt3FvBJU67ylTGqVTOtHw+sKOAw9arlqw9eco07lDIsRZVQIpEfHBuhiKywMI2wLXhMSgA6KEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+n6EClhHMq6cUUZM+JdyJnznoPvty1ETMgd+DRM2902MKZ1nZ
	+bqix+pOsf4LqcCwMYxt0W55STfocYd3jooKAEIm88qbvhctITlDeVn9BjQW
X-Google-Smtp-Source: AGHT+IFYh5wXTwNDatXldUZFMomOBR35HgUGuo4YSeLso2Z9EFhRWFovy68CskujILszB1NPTyf13w==
X-Received: by 2002:a17:90b:4f8b:b0:2d8:e7ef:7d23 with SMTP id 98e67ed59e1d1-2d8e7ef8144mr7285337a91.4.1725535678797;
        Thu, 05 Sep 2024 04:27:58 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da509e97e3sm6651162a91.19.2024.09.05.04.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 04:27:58 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: include: Fix spelling mistake in rtl8723b_hal.h
Date: Thu,  5 Sep 2024 17:12:20 +0545
Message-Id: <20240905112720.3141-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes spelling mistake to increase code readability
and searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index f9ecd9047d52..e6d6e9de5474 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -38,7 +38,7 @@ struct rt_firmware {
 
 /* This structure must be carefully byte-ordered. */
 struct rt_firmware_hdr {
-	/*  8-byte alinment required */
+	/*  8-byte alignment required */
 
 	/*  LONG WORD 0 ---- */
 	__le16 signature;  /* 92C0: test chip; 92C, 88C0: test chip;
-- 
2.34.1


