Return-Path: <linux-kernel+bounces-381073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B01FB9AF9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BF9B22977
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0701B0F0A;
	Fri, 25 Oct 2024 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yozff18C"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8AB1AF0CA;
	Fri, 25 Oct 2024 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837240; cv=none; b=Mn/dGeEHWxX5ncJWB3W2mbzr7KSEidRMWA+5BKWpIl4HNiXodWZgFcZFC5TxDhuzp7cIjreRzFPlCoHPPKe49EDap6biSox9jiWgvzmIR5z0ylB2TrfhOwZIIM3g/XXv3FgPR15GIxemcwqtcg004OEPLdnqhZa8adyHDclHQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837240; c=relaxed/simple;
	bh=hF5GrOs/71tmQ86vyjwtkUojfhnj2UiQabC1Ht7tW2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c7f8RUT59LtX2d17nkA53ifolUg8eeZXmIbBYGab7mvfspzDwwfhE959Ea9nZUHWk2VQA/X/EaI7lo8kU+ZqB17yi4LaSUBcqKv+YzSVhKiveljMDMDtEu6z1z+I2Mr9WzMvsBdVPDLW+/REqC7Hm8HJnSDCGGMLnlJEcvu29DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yozff18C; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea9739647bso1118256a12.0;
        Thu, 24 Oct 2024 23:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729837237; x=1730442037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tYNG+78DBNn93GWBi+9KVe/Zt15FWTJVd95+HyWo90=;
        b=Yozff18CiMx5KeKHSV2FJlozoDCztWSsvwSEPvNIwWkfcK9AKMiLorZmNWZ7hU9dGR
         ih0N6iZXcxeJoyI7EecemG7bltDXH9XfsoiL8mGAznn4Gy4A3ZllA/vG6I2pPcK8Z4qe
         iohC4iiuhs8K3fQ/zh2ZuRVhla8A2M7Fh0G519i/KAA3K4hY9PZ0GIRSMhZBdaFWJ1UF
         saULnbeflR426e8iQskzGmy4U6Z548zP/azb5bbZd9OMP+V0X7Xfx5Bi8xFbn69IXVfT
         oiD975awq/GbVKDWlsp0xbcpbY3UGLgkIdDJ0M1NnsNV+lMEEMzoAlUaXkfeE02z2CAz
         Gr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729837237; x=1730442037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tYNG+78DBNn93GWBi+9KVe/Zt15FWTJVd95+HyWo90=;
        b=mSt7GIFmvHEiJKmtVFbg3r0d+UKEdDuHWub3JxO/GrVCMdr8XWWnUK6Ahm3vwykcRs
         OTI3QQwcV4cjkXaTJfVL6b2bYUSbMTjKJKVi+fRlSddi0Rw5t/FSqtcfW0L/of4x+zkj
         RnQRyaPYtlgSwKGuIxyEBn3HaG7CnlpxHvthY9AK9crE6guMgXhww+s4oPzxSKMjIJtX
         k0ZuFBEDwCXcDDYKapa95SUcF0r8YzBhsDIONS/KaPBHza2aATVtTzxRI0Am36OzOgsa
         vSaMmd9ENLcFx4bdY2rrGuW/8AtGvdlECwmpsEf+aGVr2vqGP9+irfkojOGkPMuepXcs
         RiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzreDXCxQqtvbQn44Gu1wmAWnXPRA0k7t3Qh3Tl9m6vBygYxlRv7fKdMm6GxD8nnt+Imp6ztOTuHOir0s=@vger.kernel.org, AJvYcCVIj2+LXK30rhR0q9mId9DDI5MXUf+WzvYWOqPPDmYBnn0WuFc4DO6TRfncEoN1FiwIdMK61ykSXj4h@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwlduJOF/Ls5qyfbh5X3srUc+p3NiHCl5EnsgNST/wfkJHcgq
	wajhpQJfq/oZZpMl7Pt1sSWx0HVFq7cFmIIBz2jFAizxDOKgFvlE
X-Google-Smtp-Source: AGHT+IGSsmBebJa0EIwShAd8d+WR0b3Fy7UirrEelOmW5ccH+xCGPrdFCKThKORHx4Bd4qrDPbQl5A==
X-Received: by 2002:a05:6a21:6282:b0:1d9:2694:44df with SMTP id adf61e73a8af0-1d989d20f14mr5373119637.43.1729837237498;
        Thu, 24 Oct 2024 23:20:37 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:550b:d387:a102:1511:5e8b:8a24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e578001sm2566697a91.43.2024.10.24.23.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:20:37 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH v2 6/6] drivers: usb: serial: mos7840: fix the quoted string split across lines
Date: Fri, 25 Oct 2024 14:17:18 +0800
Message-Id: <20241025061711.198933-7-tony467913@gmail.com>
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

fix the coding style warning: quoted string split across lines

Signed-off-by: Tony Chung <tony467913@gmail.com>
---
 drivers/usb/serial/mos7840.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index d2cae6619..e3100ebbc 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -920,8 +920,9 @@ static int mos7840_write(struct tty_struct *tty, struct usb_serial_port *port,
 
 	if (status) {
 		mos7840_port->busy[i] = 0;
-		dev_err_console(port, "%s - usb_submit_urb(write bulk) failed "
-			"with status = %d\n", __func__, status);
+		dev_err_console(port,
+			"%s - usb_submit_urb(write bulk) failed with status = %d\n",
+			__func__, status);
 		bytes_sent = status;
 		goto exit;
 	}
-- 
2.34.1


