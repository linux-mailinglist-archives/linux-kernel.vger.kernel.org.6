Return-Path: <linux-kernel+bounces-294834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F6D959331
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511D3284E40
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3116B39F;
	Wed, 21 Aug 2024 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Wc/5fvyG"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B915C155
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724209747; cv=none; b=BYFsfi+J3mdgzT7G0xEk2M1n7eDSl12qtCf0GNPj6XpCGE0ldn8EwDwj/3IQRM0l9GPuj8Uvylp43Yn0tjjomy1QvObiahjpUDM4hOYvwZxLsXGVMQ+BTIw/sAtJ5VrLN82Z0pSfN1VfUYK2L24vBzF8NG0nzGNCq+ynCxT8qiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724209747; c=relaxed/simple;
	bh=orq4AOpe2A4MAVmAmJWoBbmSVKM15piDP70UVzCBGCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRC+ssGfjgWJDW/I8OOJ7Y8ZS/KFXKNe7v8x4AC81gGdonESUIQrQOMkjRdM6xQgn2Lgm4awlhDT++xEewcvQCtkvKKrDWwiWcMzcp48evPqufSAKLJP0G1SmQ7larKXQApgXNXYQrJEDR9/LmV6sGPgM+LNsjf8nThSsFk0dWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Wc/5fvyG; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db35ec5688so3448348b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 20:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724209745; x=1724814545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVBGOBsFjhhHQX6+UrHG33RkHi2SZZr6hZZuy7ptMZg=;
        b=Wc/5fvyGxy0IlcCJPX9qCdfNd4SVEr1XnKJG3s7GCvxUVHXZI2GADiQigweOelVps8
         QBbkaL6AkrUxHBeLneKCH6K3US8pmxHrO1ZdnNJ1ZkvPf43QBBc2okuXvBUjOjTAN5J4
         Lw8iUcgdQg4qpoMlNlex9I6R6Jnb/TdnPbcc1RtlK6XsHEHcYdptsbW8vfRC4erc3ING
         09g7SUpOFvaD8n/W0hmVMttCWHqazMSSFbadmolFzajGYlALusKWVLtSrmWDrYPybHiU
         aysnloCgFz4aSoTG/UUJ4+WlLS5bmM2259ebojCOAAAm0S8m/g93nsT56ld29OChipdI
         +pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724209745; x=1724814545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVBGOBsFjhhHQX6+UrHG33RkHi2SZZr6hZZuy7ptMZg=;
        b=Q87LA2S70ZPxRnyJqX9AI3cG/ltbQdgJm7W2NwRpovfFjZejj2LU3vTL25HW6GwrbW
         TGfNf9DF23j8ukotO4ADzJg3zHl3/4Vl7dweJ55b8DpwMfM5CKYa/0tC5WVBSh6zTg9T
         eQmrtL7x5dknfkhqAFr52FRpfQ30+LpCdGDGTD9Orlrg8Cissx+6VJMDt5mjlcSW9TFZ
         nUbq6MopcGRYgBnOTqIQ8EiDaID9pjdDaIfhCB0CSYTm1Qu5X3JVj/htcIeSUQJwY5MP
         vWp374VWdZbIoYO4Ye7fMZ9hAxH/vjkAusZpMQehVp4Urx6ZlLsV9aMB2DOCH7mS467x
         LIkw==
X-Forwarded-Encrypted: i=1; AJvYcCXDAL1hB8qMVvvEKn0BagpQPN3azD1OPrsgjLah8TIsdckSwxNY0581fA0PSGXnp0bkuNAVpllWs07MtXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIO2B1wYDKxaZsiLBOlo/fpdZHZcr6uASTBXWpb256P99JDbG
	L+qcKq3+JEuRg+4fUYTVjr+tMeQd3eQiyCz+yPRAVppSTG7feKQvBormNk1/xZM=
X-Google-Smtp-Source: AGHT+IFG2vtbi33lLjwU/yG0Oi+F22M1hsLLaxAG9l65XXErsGpslWlqApqGEGFA3jK+JlUW5qYoFQ==
X-Received: by 2002:a05:6808:2105:b0:3dc:16ca:d9d9 with SMTP id 5614622812f47-3de19d34adamr1157324b6e.46.1724209745191;
        Tue, 20 Aug 2024 20:09:05 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add75dbsm8934404b3a.44.2024.08.20.20.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 20:09:04 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 6/6] Staging: rtl8192e: Rename variable CmdID_WritePortUchar
Date: Tue, 20 Aug 2024 20:08:56 -0700
Message-Id: <20240821030856.57423-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240821030856.57423-1-tdavies@darkphysics.net>
References: <20240821030856.57423-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CmdID_WritePortUchar to cmd_id_write_port_uchar
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index c49dd8094c7c..0e8ca8bef00d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -624,7 +624,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
 				rtl92e_writew(dev, CurrentCmd->Para1,
 					      CurrentCmd->Para2);
 				break;
-			case CmdID_WritePortUchar:
+			case cmd_id_write_port_uchar:
 				rtl92e_writeb(dev, CurrentCmd->Para1,
 					      CurrentCmd->Para2);
 				break;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0850ae0015d0..fe81cf9aa862 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -158,7 +158,7 @@ enum sw_chnl_cmd_id {
 	cmd_id_bbreg_write10,
 	cmd_id_write_port_ulong,
 	cmd_id_write_port_ushort,
-	CmdID_WritePortUchar,
+	cmd_id_write_port_uchar,
 	CmdID_RF_WriteReg,
 };
 
-- 
2.30.2


