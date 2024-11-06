Return-Path: <linux-kernel+bounces-398002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DFB9BE412
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8EBB23ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6AD1DDC34;
	Wed,  6 Nov 2024 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsDTdUhj"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3DA1DD9AB;
	Wed,  6 Nov 2024 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888300; cv=none; b=pvy5FCJarEbML+HWAMPJM2PjhyOG/91o5ykZ+uWaMH80B9F7uzb/lueFG+l4yf8u/wrl+WHoSBoJt7/5berk9VYjyVjgK/m4QkqvjH/0P1G9KSgDOrYIx75wEYYtGEKa4Buy7L+C8CLs4gi1bLLEfLhKnTZM2ZitYXGVUNBzvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888300; c=relaxed/simple;
	bh=bx5wR4OF+tSWOY1oFXdc8WR6H4liG92KD1Gs9ncyhKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bF3hPJJRBtFGfksH5oqNJep9sxaw7qxY/XR/ZNSqkAJqhEswLhnkTvv6jARFSMBSSFrEbSpQm6h80eRtSTGjO6fl6j3aP0rsVeN3s4VTycxl8vZDASXcWi6yZvFRYOF6bN4x1jbt6n7kL6CgiDAQTX3qL/k3CNHjgAD7hPNwsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsDTdUhj; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20cf3e36a76so68360305ad.0;
        Wed, 06 Nov 2024 02:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730888299; x=1731493099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBQMgshDmVosjPwIQ+cfXZfVAtw+llxJuRu3FIFY5fQ=;
        b=CsDTdUhj4CBWD8IZ+a/IDMumOLQWDR58/OwkKtaLtgoE2oC+NXfWxuY7khzhfl/V8h
         rBDS4qYpqXhlytubzc7MdRdYGOIhqnce7Za/ttn7ics6INRfCSmoM5d6ITAX0dWdHd22
         bGDsgCq8Lh4Q7VV1mv6zxL67FtyAu9K56M60O9/B1ALVwvDnnsFFw7NjacYdI7uzKxBF
         sdy7HnGFDcAxJS06m3axT6JGiO+Bom8Fc+34jWQreUwxVYeahCPIElX10JJMgMW4plOX
         eOZEtqKAIsNGmQ08WAj0Ef0LvGH7JBXZ2TizANhhv851HGmD0xWS5+nnrFJvEPrYHNNl
         Tr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730888299; x=1731493099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBQMgshDmVosjPwIQ+cfXZfVAtw+llxJuRu3FIFY5fQ=;
        b=Wa1Iy4I08RyUSf8C7PeE+fxtdJ3Ad+qmlhDsBiJjt4p1xzZuYMeZFM7juxrL26ingL
         epNmWc1wOeZHCzd4DFvUH+awoiCbUtmQXwtGATyN6iu4qivEexKmD0qoxTbCFerNtWJ0
         PmrqHA4Y02kCuDzMKgm5MYp3XIzYDTP4V8paqWw/AbjNuhd9ycPMeksHCZVuHFzcvi5N
         FpPb5cZ2qSLUsnP8JJTyB5tzQlVmuv0ftnONIBX0/Y/YndmNcYMfAFMJ4uluqlVy+0pY
         NxACm3Zp5MYcuqxHvbTUXbFgy7wCizWqa/28hlZgHrmlCigQI7KYxoiMTVjEWlWoPVmr
         ExOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFMBjPTu+ntV32S30omflJM/4Ok74aiM+8XpCkzYZ2qN+/+seuQH5erKncCyDLo/FMjQAr0UcxiSdx3Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE4e4Rmcp0h0zC9+Vq2xQJzPINgeP80Hco4GBfVTaCappi+kLQ
	JSwX2ONyQMDhEnHX8xTP8VeQ86XzKAciUT6uhE9yXLDbuvkHOlSM
X-Google-Smtp-Source: AGHT+IEpXOsaxdQpIGS3apfFuoV3E2KP3OR89WilS8+1iGZz+JdeLo1o/PLSlHFW+9XlzKT+FnvNNA==
X-Received: by 2002:a17:903:2286:b0:20c:5fd7:d71 with SMTP id d9443c01a7336-21103ace2aemr326528375ad.22.1730888298685;
        Wed, 06 Nov 2024 02:18:18 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([106.39.42.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c0f11sm91831425ad.200.2024.11.06.02.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:18:18 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>
Subject: [PATCH] fdti_sio: Fix atomicity violation in get_serial_info()
Date: Wed,  6 Nov 2024 18:18:09 +0800
Message-Id: <20241106101809.17632-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our static checker found a bug where set_serial_info() uses a mutex, but 
get_serial_info() does not. Fortunately, the impact of this is relatively 
minor. It doesn't cause a crash or any other serious issues. However, if a 
race condition occurs between set_serial_info() and get_serial_info(), 
there is a chance that the data returned by get_serial_info() will be 
meaningless.

Similar issues have been submitted or confirmed: 
https://lore.kernel.org/all/20241002125845.785464707@linuxfoundation.org/ 
https://lore.kernel.org/all/20241106095819.15194-1-chenqiuji666@gmail.com/

Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Fixes: 3ae36bed3a93 ("fdti_sio: switch to ->[sg]et_serial()")
---
 drivers/usb/serial/ftdi_sio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index c6f17d732b95..e07c5e3eb18c 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1443,9 +1443,11 @@ static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss)
 	struct usb_serial_port *port = tty->driver_data;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 
+	mutex_lock(&priv->cfg_lock);
 	ss->flags = priv->flags;
 	ss->baud_base = priv->baud_base;
 	ss->custom_divisor = priv->custom_divisor;
+	mutex_unlock(&priv->cfg_lock);
 }
 
 static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
-- 
2.34.1


