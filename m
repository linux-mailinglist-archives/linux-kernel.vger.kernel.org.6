Return-Path: <linux-kernel+bounces-373024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC569A50B8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 22:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B5D2843DA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 20:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3044191F70;
	Sat, 19 Oct 2024 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtQLsqdk"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BE5188CB5
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729369637; cv=none; b=iL/xgngVR2M/AyGpq4FGp/N1OjoZgcWzLtU+bFPa4q5ppIqr16V/CS9bltSMOeXAsZa7yplO9oRFz/uSSSpX4Yk1/Fr1fZQTztbYRYwhqqH+uejYs5voXJZy+UoB3544Aso4U5fRPbNz56KjxIAeHeKgneDSx5wygEnWYqRTSyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729369637; c=relaxed/simple;
	bh=LBnesBq89KSC51zuhzUSl3t74J8Uundxu5xjmBRJm4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zu6JAyaw4xWNklK2TXXfQRoApn2z9+wJct1GdlYeZa4+Zj5RS4cRb0TwaPoVDwxBTy6qQywPJ0rCo4mowwWRTjy+eNMFITTkS8EPaNmldRS6QwjLOz6oBYLgwonzrYjXH7epRlWe3O9D+Ski/zmFpRQuyeZZTgjI0Juv/oEGIL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtQLsqdk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315abed18aso28074085e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729369633; x=1729974433; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nD95+paDqPhoKnttXW4GGB9gi2jM5a9pY8Vq229MVI=;
        b=NtQLsqdke9bnx4t7HrPDW5CfGHRRofxUMtJtmhfGRUexbdEiYFnsr5cJqz0zKSLU9b
         GgQzVoBf/pH7wgC8qBXGQ0+uxqA+N4p9DK7zGCFzMLBA4NpqPFRN5WSN8E+49pxNLWKp
         eobAGtrw6kYvdQORnYEff1erUYbjGnKGTNK8akTU/AIiz0DXPpMkr4hPlVyJT/OOVCbT
         UeE7xHTNPw2h9errCApM2O32u/X3i6CDqBfiA20ER+FQ6LPpUy8xoNf7XlneBxtpAWe4
         Z4DhLY6tw1gU9+sh9zFckgpaDIOJuLyRvlsnpd0RQ0xzz80RPs/gaIIxNj0FEmCEmdCx
         h2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729369633; x=1729974433;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nD95+paDqPhoKnttXW4GGB9gi2jM5a9pY8Vq229MVI=;
        b=JxG8sI3d8nANIVi4GvOTuGB/ImFZQAO1xDMDGMviuI6hcWt6M2W6jUMIIaaqCFDjkQ
         IDCeVEg3o5Z53m6KhVi5HMV7d41QIpvcrXoNXv+UXq69i4dBLnlNXahNBzvHjx2JNY9X
         sJoPp2qj544r3fY8YGibS9e63HiuMP/Tq4wIpbMFDR88hvN2+p+j13YU1gvpN+Yz9HIv
         poZQVO+p33ISEB+OkYOIO6oAmhe8k9zb2TwstmIF9/AEW5Sj8MVwLM1v1xrqS0Zg10Bd
         c5BI0Sa0jC1V429k4dDoB6ny8ZhhnEzYqqwA6ko8ENDmnRl6nAVUchKYW/dSGPzUT0fd
         DUsA==
X-Forwarded-Encrypted: i=1; AJvYcCX9jY54bSmdH4woo46t3UaloM1RJdQ9Dh5s3EtAqBSOurrbRnT6JNGTADby2L8KH4vUQji7I2VzcJeFpBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcWp6mPzqGHp+JiqQB0d0ckHd8wNSaxbBwrogwSQ9Y9YlsKWIH
	FQFnDLCw32lQGBVINowq0MWQZv3hnEI6aW43MPOgTlf2gMbK8NlyyPXRSMgY
X-Google-Smtp-Source: AGHT+IFqWdIVbCM0yk8+9sAkm44Z3tf7BcWnp68nXIygEX4xf6LyXZR+Wf21jJu1onW5Yy0/OZijgQ==
X-Received: by 2002:a05:600c:c89:b0:431:5c1c:250b with SMTP id 5b1f17b1804b1-43161633321mr54075625e9.1.1729369633428;
        Sat, 19 Oct 2024 13:27:13 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-f8f1-d6d3-1513-aa34.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f8f1:d6d3:1513:aa34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2ca6sm3522335e9.35.2024.10.19.13.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 13:27:12 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 19 Oct 2024 22:27:03 +0200
Subject: [PATCH] mtd: ubi: fix unreleased fwnode_handle in
 find_volume_fwnode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-mtd-uvi-fwnode_handle_put-v1-1-f5ef0d0cf9c8@gmail.com>
X-B4-Tracking: v=1; b=H4sIABYWFGcC/x2MWwqDMBAAryL73YVkUVJ7lVKCumtdaKMkvkC8u
 8HPgZk5IElUSfAqDoiyatIxZLCPArqhCV9B5cxAhkprbI3/mXFZFfstjCw+O/wTPy0zupbIMDn
 3bCvI/RSl1/1+vz/neQEuVfhPawAAAA==
To: Richard Weinberger <richard@nod.at>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Daniel Golle <daniel@makrotopia.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729369632; l=1049;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=LBnesBq89KSC51zuhzUSl3t74J8Uundxu5xjmBRJm4I=;
 b=5XWXmVX0aTuUbbi65O7kwMZS1Hs2SdW8I2KvToKPxcjdMPBlAcKzFt1jjCUA9V9csr3UFhKo0
 kGlZUUDxvyGDH6CUMfTRSHLNrLzH+Ri6g6tTR3abywZKzYAe1bpkRk7
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'fw_vols' fwnode_handle initialized via
device_get_named_child_node() requires explicit calls to
fwnode_handle_put() when the variable is no longer required.

Add the missing calls to fwnode_handle_put() before the function
returns.

Fixes: 51932f9fc487 ("mtd: ubi: populate ubi volume fwnode")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/mtd/ubi/vmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 5a3558bbb903..e5cf3bdca3b0 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -143,8 +143,10 @@ static struct fwnode_handle *find_volume_fwnode(struct ubi_volume *vol)
 		    vol->vol_id != volid)
 			continue;
 
+		fwnode_handle_put(fw_vols);
 		return fw_vol;
 	}
+	fwnode_handle_put(fw_vols);
 
 	return NULL;
 }

---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241019-mtd-uvi-fwnode_handle_put-7b220d2778b5

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


