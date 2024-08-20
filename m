Return-Path: <linux-kernel+bounces-294227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C346958AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C75282912
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7888E1922EE;
	Tue, 20 Aug 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FWw3EhR0"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90F1922E0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167126; cv=none; b=h7m5ibUOMgg+Q1FgsyOMdtCNVeij4G9uDoczAaYgW1Xhhcc+bdB9U3QQ753yytI259sRt0gBRFmj7VcQnMOUT+tNDe1GEyOZodlMxYXOwoeSEMISOGRj4hQjHUAOsKPxXZkGHMk7m1hlXE8wW1u3PTc8TezWD9vEe+PWp62TcGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167126; c=relaxed/simple;
	bh=L9acGCAPfUAhZqVmLTPxxGB6397void34tVzkENBXM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b1mC0X00vPkcnyzEoe4KNdDvBFLjfC8iVgiovlRJL9gUHV9b0Y9/cWVOIlSTOeYfdP/+zZ5i3cUyquJptM8KVmi7/tH7MccFbOQdWkD0Euflz2Hq+o1DagCTYA6n90x/NnNgmtQm+wkB6HNZL16zSGzd9MB6tYKUOMviF2i1LP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FWw3EhR0; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7093472356dso2956309a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724167122; x=1724771922; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5EbeUTVrdAwG3ffY5P1A4CIKG8gQCJjFS83H7iQ41yg=;
        b=FWw3EhR0bjhxNa3dZzx04Bu237DeY28wajRY/cKL1GJBpJ+mEppkSVYlOdsbIl0iVT
         OoXECI4DRI1B7F/NmYYlcaLYO+Dx1VC+QEJBVxxh1XI7EwrDkoqPRaSe0cHyiMVFjiX0
         dHV031bG/6NmhHaUPnYKe5FZOy/dEAIFhubyijM+I3UPfyjvQdw3Z2cGr96m6wDjAzso
         uy5ADJbAsKg5fGWmPre9fwTrXRHnmWPl8CigwWGESZ0Nh7Tjcpzj4lU64loWn/EZD+mQ
         Q8/W8UHF7bx81rX/nRd19BbAzPJagufAkcwk8Tj7pUMQpH470+RmzJYJuXQrU2vDp1Wi
         MEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167122; x=1724771922;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5EbeUTVrdAwG3ffY5P1A4CIKG8gQCJjFS83H7iQ41yg=;
        b=dpm/MppO2F6+yZVuVB+vtrMPqfjxbGZcg1Oq9OjMmO3G/S1SL8daQ4WsgroFbV5Cr0
         Mz2eUTUSy93K4OwcwTjcl23Ymx2tJJsC9G+8I6gVQ9wbwRCY9Veocvf040RnyU0kwezZ
         isHNuk8eLsJzGkNPP1BSvi/uvUCRPgRAik7zLaH8hrbt5Wt5BynLFWL1193APC9FzecD
         ochuPmLC4g9wWaR172qFwmkLP6/n+UukYtFpW5LOvKsrBLs7DjOFZLTdtKtJv2psJH/U
         0UHcNHAEUMDl1fWp90anEkKEdiV2gGhn8oRAttkYG/xi1QWHBDJiNa2lROIRn3vPqkst
         GeZw==
X-Forwarded-Encrypted: i=1; AJvYcCVCui1QLu1Y9AJxuLWTuYhNhfT2Na8cFvQonYFFZzWx26Anbhe6D2h9fTSfvD3NiU5PPpjTb/cexB1zIUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3nDoKeeDkX1uyA3jy5wYNjOLF/eThRyDcPeATAoSR3VFHEG/R
	SCVu5EbhR/NtPWO/faq4sfrSPiK6qlgf1Yv8R30s4lo5M5dQbQXJpZOmdKgG5ZG5HDDj93W9F7Y
	r
X-Google-Smtp-Source: AGHT+IEsKw2w0npL9vAIavU+xOz72lv/4yYm7bIFXNJNBiMeGLYo2E5L9eQql41jREtPnllvu+qejg==
X-Received: by 2002:a05:6830:65c4:b0:709:3b70:3bb6 with SMTP id 46e09a7af769-70cac8b1bb4mr21411837a34.28.1724167122483;
        Tue, 20 Aug 2024 08:18:42 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca64945d0sm2744941a34.18.2024.08.20.08.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:18:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 20 Aug 2024 10:18:24 -0500
Subject: [PATCH] iio: ABI: remove duplicate in_resistance_calibbias
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-iio-abi-remove-dup-in_resistance_calibbias-v1-1-e64e58cabb14@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAL+zxGYC/x3NQQrCMBBG4auUWTsQg4vWq4iUyXSqP2hSMrYIp
 Xc3uPw27+3kVmFO126nahscJTecTx3pU/LDGFMzxRAvoY+BgcKSwNXeZTOe1oWRx2oO/0hWG1V
 eSAniPKuEMIgOsVdqwaXajO9/drsfxw/3kfx/fAAAAA==
To: Jonathan Cameron <jic23@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stephen Rothwell <sfr@canb.auug.org.au>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

In commit 0f718e10da81 ("iio: ABI: add missing calibbias attributes"),
the in_resistance_calibbias attribute was added to the main IIO ABI
documentation. This attribute is was already documented in
sysfs-bus-iio-chemical-sgp40. This resulted in a duplicate entry that is
causing documentation build warnings.

This removes the attribute from the sgp40 documentation in favor of the
main IIO ABI documentation since this attribute fits the established
pattern of standard IIO attributes.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20240820134739.50c771cb@canb.auug.org.au/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40 | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40 b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
index 469a7c00fad4..a95547e874f1 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
+++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
@@ -15,17 +15,3 @@ Description:
 		Set the relative humidity. This value is sent to the sensor for
 		humidity compensation.
 		Default value: 50000 (50 % relative humidity)
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_calibbias
-Date:		August 2021
-KernelVersion:	5.15
-Contact:	Andreas Klinger <ak@it-klinger.de>
-Description:
-		Set the bias value for the resistance which is used for
-		calculation of in_concentration_input as follows:
-
-		x = (in_resistance_raw - in_resistance_calibbias) * 0.65
-
-		in_concentration_input = 500 / (1 + e^x)
-
-		Default value: 30000

---
base-commit: 0f718e10da81446df0909c9939dff2b77e3b4e95
change-id: 20240820-iio-abi-remove-dup-in_resistance_calibbias-fca009ac928c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


