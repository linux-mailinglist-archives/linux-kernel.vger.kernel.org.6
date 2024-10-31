Return-Path: <linux-kernel+bounces-390279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1958D9B77DE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33C1B24CEF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F271198A2F;
	Thu, 31 Oct 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAzIx1n0"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE629193439
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368118; cv=none; b=mIlNQoekgnSEPgwxw03CI7T0PDP0NMiJXOWjyZ/xGKkoVnDBX1ngOSibspRfuWL+2xpi7v5dH0Vxd3YFEEN2m/j4C+rL1qVHToBKE2a2/T2EJ00JY1YtASprDL5LIotlUQkcndwOSnGnDsrDKXlak0OaDd8afVxSzEnPHrHQG5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368118; c=relaxed/simple;
	bh=hFyuHVXE7Cz0qm3Tp1AuH1uPL3q7XxKfNijEB1y1rRU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R/slBheQeoZyCmrWuu3jpgU+OaFwr4bhudk5PE5Jgcdp4zTEhVdly+NayQs1GvJhuxNjOmkW6vDcXbrxbtcZmuvXaDNDrTFPBsfdepTB2lodqn506MHz4P2mYK5obDqpy9sG7nYbj8slcmvyXnyu8RYYWf+t2FvjFMcZKbTqAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FAzIx1n0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4c482844so454806f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730368114; x=1730972914; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aa5olyViLFOojnVkbBw9OEdbllf8/WSVMeqMqmVU3qY=;
        b=FAzIx1n0LalqJbEpPVEW6D8y3W+Qm0r/LFHg3iaat9dhHTnT7yjUs1JxMtgwjJ+SSS
         f0FF8aKvjcuXXsZzIPTUWZD89/ctTY0GJr9OCenu2RMi5AzxGmsBgtSDVvRHGdvH9UAe
         K1hZItVRNrNgM9/bY8y2D/IALOWqJ3Qh64VehHAsLeRR3ne6fG4ZompxRAqz5H+acAnU
         Retk+MlXtu8wiJovnF1QACeff198pAnZQvg1xf1dsnM5IHYe2bnMdAKGUv8Mmkl2Fbmm
         zDb7H9q9TrFb2kGTdjh8JcOCdYUgdwtPRuWvsglBZeIBsHhjYE0BX5MtGom+kuPCu1wC
         tfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730368114; x=1730972914;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aa5olyViLFOojnVkbBw9OEdbllf8/WSVMeqMqmVU3qY=;
        b=Cm2xQ/YEzOCbo7qBjCLVZtMHFxzNwr3fIcDZM824UgIhb0pzsLiCajt3KMP6CkezVv
         cWL9FCOwHJTd5WauKCb9yaWDSbuhdj05l96tfhiTrwcuey15I0bs5K2UmFw8RfW/HwY9
         UZFmfUvfj/jiOMW10O4Ro5d8HivpjhXNkWigx10rn22wRMsrfiiXIF6GdiMGtFrJHNKg
         PWmM5CRpd+h0+qrRPJsC61R4K9O216vZj0BJbKXoHHy5eXwC00dSQAyk3Uqt//R1PiC6
         V5qKURkZLZscflHkgjIDFXznB8AIMvU87uR1ZEaFr2clEcUroLzbApNrzJS9tSaRJHE5
         lItQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGNUK//DsonarnXkcugpK8nBRwLe786O2wpaactZDbwg1a+nVXN/N9Uq2ejldVjAng5Cb+uuRQOWUZAiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXJA5ZoFZdy7hb5PAbPlMbXSvtO/VKn9dBLGtVnziJaojdcLK
	lcp0GrCd99M9n/lFNYQ9RuSDtJy3Sov+xZ7FbbV1msiGfZmZjcNlWh0K23IiTJQ=
X-Google-Smtp-Source: AGHT+IGDxQJ/A5r0ClIpNqfZIzOIlvOQbqpKCuPfpxpKxXQvewn/QL8mRGK7ukGONcoXjVByhTIArA==
X-Received: by 2002:a5d:5146:0:b0:37d:5496:290c with SMTP id ffacd0b85a97d-380610f255fmr13644733f8f.7.1730368114185;
        Thu, 31 Oct 2024 02:48:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d437bsm1589665f8f.30.2024.10.31.02.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:48:33 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:48:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] USB: serial: io_edgeport: Fix use after free in debug
 printk
Message-ID: <93490900-d2c6-45e6-b008-8d264e4c11b0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "dev_dbg(&urb->dev->dev, ..." which happens after usb_free_urb(urb)
is a use after free of the "urb" pointer.  Store the "dev" pointer at the
start of the function to avoid this issue.

Fixes: 984f68683298 ("USB: serial: io_edgeport.c: remove dbg() usage")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Fix the subsystem prefix and use a "dev" pointer.  It brings the
style in line with the rest of the file, and it's more future proof in
case someone adds a new dev_dbg() later.

 drivers/usb/serial/io_edgeport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index c7d6b5e3f898..28c71d99e857 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -770,11 +770,12 @@ static void edge_bulk_out_data_callback(struct urb *urb)
 static void edge_bulk_out_cmd_callback(struct urb *urb)
 {
 	struct edgeport_port *edge_port = urb->context;
+	struct device *dev = &urb->dev->dev;
 	int status = urb->status;
 
 	atomic_dec(&CmdUrbs);
-	dev_dbg(&urb->dev->dev, "%s - FREE URB %p (outstanding %d)\n",
-		__func__, urb, atomic_read(&CmdUrbs));
+	dev_dbg(dev, "%s - FREE URB %p (outstanding %d)\n", __func__, urb,
+		atomic_read(&CmdUrbs));
 
 
 	/* clean up the transfer buffer */
@@ -784,8 +785,7 @@ static void edge_bulk_out_cmd_callback(struct urb *urb)
 	usb_free_urb(urb);
 
 	if (status) {
-		dev_dbg(&urb->dev->dev,
-			"%s - nonzero write bulk status received: %d\n",
+		dev_dbg(dev, "%s - nonzero write bulk status received: %d\n",
 			__func__, status);
 		return;
 	}
-- 
2.45.2


