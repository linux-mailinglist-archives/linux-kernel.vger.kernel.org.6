Return-Path: <linux-kernel+bounces-310303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D40AA967933
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4181F2167C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799D01822F8;
	Sun,  1 Sep 2024 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="AmT+thGX"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A06317E8EA
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208855; cv=none; b=AM61lf+6XV1OaHE2P2UvST4EwQj3R5qEQkSrfXeOux8e0bFo7bg7KOLGrEOi7laZCSV1+Ck3oo8dVLu56awscxa2jaHt4uQINATAhMUXd9nIf8KcEViKtauhkStCOEZqbWANLQoAbD8jGykekzHXRDBHEd0o31GG7ImCu45S4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208855; c=relaxed/simple;
	bh=iUpl83bfR0Ipvut4oGsYgDirYKG9fQxE+Ew3JiD6dOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmzRYrERGsNr5Tyklv9QkJo1MYYYE32TOMnpThGbDaYVdTF77zt9YlYiMv139AhgnPcF/RyugMpnZKNRaoz2hLJbq6t+VSTTR8TiR4YrfjWG9kwDR1f1GXWjVhtLvK6WPR85R/B18A6ribe/48lKROl+lCQWhSYb4KGJ8JneErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=AmT+thGX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bafd879aeso4744285e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1725208853; x=1725813653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqKffVzCatspkF3hdT8rjFuwjdyFjJBW3hMnTSV2ivA=;
        b=AmT+thGX8X8BWeqT7QNlNmoj+KykJY+2J01Uilxcx74PpYl5kYmOu/tGhb5aJvzFwY
         IiQ9eKNnaWWBaVXCsMmlyVmAnnkrq/GgeEN4BZj8Xjpa/CyFVe+lUfR6+sxBtNc/qz3e
         LDGVI5/DeOEcBwMrJpvQ3l4Pzp5OZIDOVt34k4uF+vEOXmo2pUbB07+05QKDS/olJuJ4
         f8YmRGJIGjrduVNRDJjSFfkNzNDD16J1QrCYNvPmDxF8F1rBxTV4r6RUoMzyacbOcuDQ
         cb9cI9+e+XnCxdvkxLRwZK02NpMS6F7IzwvzxlLN4mvA2vFF8Obnk2OL2V9K94abi2z6
         TFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725208853; x=1725813653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqKffVzCatspkF3hdT8rjFuwjdyFjJBW3hMnTSV2ivA=;
        b=c3XRyLQ0HSVYM9vCd5rSS/XAacPHDsevNui28HEFwMypZpDW6n+ZKbEgIu+gTWIW+4
         9M6fUsT9MbA0NejBlU45G/SC2sh0/N3yXodEVG+5nOBDUTGLh72r9AmPS667LvG7N33i
         IqLWLNFgPl/Re23XDBIhNPnhRngimijIW8ir28ePsISxhlpL3v7xXOOX31wDQ5tX8++q
         s26r5pGj6ViPoi589xCnzRi30EU7KosKBZp0gEb10zyAJSV4T2PLb+dJtwv8zwK1ulxb
         b1jnOEq5ly/8fWVRNOGy7bq9GeaThUOhjLp9ec92UwKMKUlbMmoAOt1RYjS2b6m6FhPE
         Z4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqYmto+iGz3y2THZXrVfTGwLn0OdtbeIPK/0GaFjTAP1U7Hd740kToqfESxmz9Y9+NL8AI0caOBExkdj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrrEfuHWnOCDgsFFVCa1QyqzUdLK54GfA+9zZFZxWtf968P8e4
	z7pAyvWutLgd6nisHZJLISskvJwWDWeGn68wIzluQu+rn9st1nnx07H+GPxa5hk=
X-Google-Smtp-Source: AGHT+IHDHDxYouHkMBLT+9d48IRoCtSbwadnJjfsZAP9i1xo5gy1S3ARpQgQQ985elwg7rOLNUNUnA==
X-Received: by 2002:a5d:47af:0:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-374a941a7fbmr3372288f8f.0.1725208852763;
        Sun, 01 Sep 2024 09:40:52 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898919670asm460323566b.140.2024.09.01.09.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:40:52 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: sfrench@samba.org,
	pc@manguebit.com,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com
Cc: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] smb3: Use min() to improve _smbd_get_connection()
Date: Sun,  1 Sep 2024 18:40:03 +0200
Message-ID: <20240901164002.117305-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the min() macro to simplify the _smbd_get_connection() function and
improve its readability.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/smb/client/smbdirect.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 7bcc379014ca..8f782edc3fd7 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1585,10 +1585,8 @@ static struct smbd_connection *_smbd_get_connection(
 	conn_param.initiator_depth = 0;
 
 	conn_param.responder_resources =
-		info->id->device->attrs.max_qp_rd_atom
-			< SMBD_CM_RESPONDER_RESOURCES ?
-		info->id->device->attrs.max_qp_rd_atom :
-		SMBD_CM_RESPONDER_RESOURCES;
+		min(info->id->device->attrs.max_qp_rd_atom,
+		    SMBD_CM_RESPONDER_RESOURCES);
 	info->responder_resources = conn_param.responder_resources;
 	log_rdma_mr(INFO, "responder_resources=%d\n",
 		info->responder_resources);
-- 
2.46.0


