Return-Path: <linux-kernel+bounces-300615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A295E606
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383711C20968
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130E21DFD8;
	Mon, 26 Aug 2024 00:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="X+DIeyQM"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A11C2E3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724631456; cv=none; b=ZF/u85K71XxafJXVIZ5LJG9SU+2pG/QUHn4ada6WIZMEuPeHhL4cO3aWhCcTK7BnUoCiDaudN3aEEzKgPuY9M06+GNVJk5fX9evQrQULm2OKuvLxildC8De/kJWvf0CJdvJnBlgYswuKEsrVArRxhUS54C4THTgtpB1oESAUWZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724631456; c=relaxed/simple;
	bh=U8Xm/y50TYb27am9v2OHA9PvMfxSVUOSHwJFDd45XuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VeU86jCW7U/9d5RKIQSIGqkwhcx5XJ7qKAH1yvcFcD6xE9I0RsYFoK6lLYyqCixxdDjWjbGi2JLSt59grKqRHmwTZBAvkyPNmSdq+FvXrTqV+SFOy+TphVr5GH/73NlXfWN/2G8B7cBqwE7euDLY5mNJejDYWKLiil+k3AOkkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=X+DIeyQM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-202318c4f45so37820385ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724631454; x=1725236254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHz7KjczPD5dDFgUNUfs9FbKXGjP2F/Q4jVorZwSFug=;
        b=X+DIeyQMlgZzyAwTMT1JAVHxUWqCq5pFyE5IPNNpgl2TKuJj2WfaWORlZVON04bkyO
         hfArKKdzpJQc8TZjpYcBZx033IU0hBjIHCb5vRhaPET6Q0xXouXMa1xLOcT59qQoXy9j
         OnCZqoJtp0R2BtLRl+5Ou0Dhy7Wb/UMzQ8/xAVc75aRgoaYikf2cr1SlURkbGU9Wl3Fa
         H5KacRBcZ3MB+xL4qI5/K597gGm2W4R6nItejcXinNYbGaYebbPhFdprcXJk7AEXdujB
         odLd5X3jCnXzWg1XVCDunvUctMccsJ4EvBeao8vzoMsb1xzlIsjBGtpb6Zqo/MeGKMVR
         XgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724631454; x=1725236254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHz7KjczPD5dDFgUNUfs9FbKXGjP2F/Q4jVorZwSFug=;
        b=Kt27yKG5sqShF1b1NLF8N8DB4TvbP7bsQ9DAlDRORTLfuAoiTninMTUQla8BHRzIc6
         QwLpwuNyEqDv3qK35pJg7rhQ3kqY1eoROKSGXJDRqKhpaC8eyyPhpxStlSoTY++uaEyO
         3yB7QSnNznEXdcdYHxDElL7BF2ZKocG+eNCRwnQXlDUxxSg2jm4HleXN5WcXLQyHC1mc
         hm/BkdwjdjVaYFoYJAUE+/s+fJDlUdf3WMjJ448V2N0HubidnnwIl8gNZrzNrfumaqki
         Ralg9prVxSPov0lHsm/9jJebRqUfu8Z01yewY5/D6fSjs/OLY0+g3yMKDqj1U06r2Lkn
         puuw==
X-Forwarded-Encrypted: i=1; AJvYcCUtL0mXJGtbRHPklJ04Rl6FeGurOPV1+eb302D3Eot5peIek4DNvRpDd0d3rZ7x0x0qyxXzapil6fDPAWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrX3HWAf9Dniubmyh3PfztXlFnh5cTjgIiJzhw8oAm5Xy6Tg7U
	MtQwfeei/+gviCuFPBEEhOsJLlhfpqcN66qYvkmNixp9lvHotUxZh7BaiuS/Kscr11C2j2EOHuV
	F9kw=
X-Google-Smtp-Source: AGHT+IG6BLml6t4Phbdh6hdqMVF+7TfApMh+gCeN/uuPSdC6h7NSSS9hkB+6SojsGJEQDMvkOuGSRw==
X-Received: by 2002:a17:902:e84f:b0:202:3a75:ec89 with SMTP id d9443c01a7336-2039e4cf0d7mr100653765ad.31.1724631454351;
        Sun, 25 Aug 2024 17:17:34 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203857051b9sm58695955ad.234.2024.08.25.17.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 17:17:34 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 6/6] Staging: rtl8192e: Rename variable bCmdOrInit
Date: Sun, 25 Aug 2024 17:17:24 -0700
Message-Id: <20240826001724.274811-7-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240826001724.274811-1-tdavies@darkphysics.net>
References: <20240826001724.274811-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bCmdOrInit to cmd_or_init
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c    | 2 +-
 drivers/staging/rtl8192e/rtllib.h                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
index 8247f22454cd..533cc4e723f6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
@@ -42,7 +42,7 @@ bool rtl92e_send_cmd_pkt(struct net_device *dev, u32 type, const void *data,
 		memcpy((unsigned char *)(skb->cb), &dev, sizeof(dev));
 		tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
 		tcb_desc->queue_index = TXCMD_QUEUE;
-		tcb_desc->bCmdOrInit = type;
+		tcb_desc->cmd_or_init = type;
 		tcb_desc->last_ini_pkt = last_ini_pkt;
 
 		if (type == DESC_PACKET_TYPE_NORMAL) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 8ca7eb6b8e75..519cad9e1106 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -990,7 +990,7 @@ void  rtl92e_fill_tx_cmd_desc(struct net_device *dev, struct tx_desc_cmd *entry,
 	entry->LINIP = cb_desc->last_ini_pkt;
 	entry->FirstSeg = 1;
 	entry->LastSeg = 1;
-	if (cb_desc->bCmdOrInit == DESC_PACKET_TYPE_INIT) {
+	if (cb_desc->cmd_or_init == DESC_PACKET_TYPE_INIT) {
 		entry->CmdInit = DESC_PACKET_TYPE_INIT;
 	} else {
 		struct tx_desc *entry_tmp = (struct tx_desc *)entry;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index a5ce3d2b8600..7a1a68317a49 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -102,7 +102,7 @@ static inline void *netdev_priv_rsl(struct net_device *dev)
 struct cb_desc {
 	/* Tx Desc Related flags (8-9) */
 	u8 last_ini_pkt:1;
-	u8 bCmdOrInit:1;
+	u8 cmd_or_init:1;
 	u8 tx_dis_rate_fallback:1;
 	u8 tx_use_drv_assinged_rate:1;
 	u8 hw_sec:1;
-- 
2.30.2


