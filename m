Return-Path: <linux-kernel+bounces-381069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D09109AF9D5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917A1283A59
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DE51AF0BA;
	Fri, 25 Oct 2024 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMb6fv8u"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6FB13049E;
	Fri, 25 Oct 2024 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837180; cv=none; b=La1OviOJE5M2erDfh6fesAeN9jm8PUhCSuQFz5xCIkbc3RBr1Z0VknMi9QbCd0OGaiBc3qrSXf0cNsVoTVg3286m3ycaasr6ssXwnSYJQfCjm35xtFUkM0b1nq1zHIJ6rhJZ0d1bwVAGb1oE5cgyIXaa+emw5JXwa/yE8FvxHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837180; c=relaxed/simple;
	bh=rifYc4joS+y4M62HPI3QWAZUqoJ5yl1ftC0NWAuHLF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gF1XsrqIMqi+f2zyFfyJ4zLPY/uPGuYB/pDkUTL+L2g6G5283FQdbgPiupiy3xgVy51jnn4w/XQgyLdM0GqW1gGs63/qgjC7Wk5C51O390if3jzcTgD5EOsIZ+/BCXiOifVz2QGLQLRZImnYRumJu6jY1eXJQMsTSrnw8hulbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMb6fv8u; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e34a089cd3so1318584a91.3;
        Thu, 24 Oct 2024 23:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729837178; x=1730441978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ6TfJkvEYmWf6I8Vd95RAcRiXRvQlRHKesn8/Q2iag=;
        b=VMb6fv8u6etaNa1wXVkIRVIqwy4bAp68RgsUqvjy8R0g/ynisEkzcymwT/Yi5HxjCU
         EFIRPTrs7URFeH48L1kvV1ytiOvI3E7OeNKnOuOKpSkTy/Yzx6q0SPylXARdMQ4Uc899
         qMmNUrtMwJ2hYGrCvc5V5hNLiYElZsnK6de8reXp/A9lGUtIqfaeZ36wjeiGhYRDvJEG
         AcBZiWF6QZpmeTM5Yc4BQg+0i8DFoQHSuYr8LuRBEUjzSj9hrw3KRUcWFoPf2HoaEye9
         ypHtC9VaeIKauiBV7nOJM0KdG4mOBsVXA3if73aZYw4XV+K+LnAP1RklFdibUVzS75pv
         idGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729837178; x=1730441978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQ6TfJkvEYmWf6I8Vd95RAcRiXRvQlRHKesn8/Q2iag=;
        b=wtE2AniwTASpmHvzFmOOSaDZrVPUI03EoMQSom9zieWuefUKsBQ/qm13xXZBHXuQwf
         YzDTnf30LI5y7lIQgBHB9MEy75ZgeOiZ+oD3j0vwISxDy79EpOBsVlve30YrGoWTiKHv
         62vJsNh6GHRAz1pStqWZWJ2nP7lvP8pyzIsl4Rmk235lCg4o9q1u3wPs+mWnmyvl8E8X
         YJZH08U6tHfIcKOyvh0nFpqHsnJ0US5dpVW+9sCC19BoIizuOxIffvpAOFoOqfAcSA7W
         u+gYFIPhqJC5wo0LPtr9FQZoObtn0vCbbb242Sko8XEDgiy+0jwz3XKHk5AzNs12zk2Y
         mkuw==
X-Forwarded-Encrypted: i=1; AJvYcCWLBcbWuzJhhJmhFbRd6RJkhlFID81jHMgcaP6BG1kg6gVjvZcs/SL7ecp4Ns0SCWKMIL6DVIjgyEcd@vger.kernel.org, AJvYcCXgO1IqLPTpbt2rx0fpSSYts4shFZgIfBcfaoh6OYlCiCb9cKCSvqBT2b83JjkVfP+SzLWYcskZR24KQl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAkPEai+Ak2rYjOHH6vdVpEonLYXX1gBOOg0/fAdG3naVOW2e
	JQ6AizzvUPVh8snW0lc2rHAxf3NTMXHImW/U4XGzoi7NC7N5kjpp
X-Google-Smtp-Source: AGHT+IGb41h5T2OqQiAP29qHlV7LUZg0Ln+kj93y610F15nJ/W3vun72o97u4ZZJNoI6CwrIRAYRYw==
X-Received: by 2002:a17:90a:5508:b0:2e2:c6b9:fd4a with SMTP id 98e67ed59e1d1-2e77f45cb87mr5442836a91.18.1729837177582;
        Thu, 24 Oct 2024 23:19:37 -0700 (PDT)
Received: from asix-MS-7816.. ([2403:c300:550b:d387:a102:1511:5e8b:8a24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e578001sm2566697a91.43.2024.10.24.23.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:19:37 -0700 (PDT)
From: Tony Chung <tony467913@gmail.com>
To: johan@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Tony Chung <tony467913@gmail.com>
Subject: [PATCH v2 4/6] drivers: usb: serial: mos7840: using '__func__' to replace function name in dbg message
Date: Fri, 25 Oct 2024 14:17:14 +0800
Message-Id: <20241025061711.198933-5-tony467913@gmail.com>
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

fix warning of Prefer '"%s...",__func__' to using 'function name'.

Signed-off-by: Tony Chung <tony467913@gmail.com>
---
 drivers/usb/serial/mos7840.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index b48a26468..31ec2cf1b 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -230,7 +230,7 @@ static int mos7840_set_reg_sync(struct usb_serial_port *port, __u16 reg,
 	struct usb_device *dev = port->serial->dev;
 
 	val = val & 0x00ff;
-	dev_dbg(&port->dev, "mos7840_set_reg_sync offset is %x, value %x\n", reg, val);
+	dev_dbg(&port->dev, "%s offset is %x, value %x\n", __func__, reg, val);
 
 	return usb_control_msg(dev, usb_sndctrlpipe(dev, 0), MCS_WRREQ,
 			       MCS_WR_RTYPE, val, reg, NULL, 0,
-- 
2.34.1


