Return-Path: <linux-kernel+bounces-386538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F69B44CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DCEB2217A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4512022DE;
	Tue, 29 Oct 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gAc8yFXj"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083B3204011
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191621; cv=none; b=nBMleia9eXnvGBwmS1qBguCeG6FcgF6iTB8SefH8VtnoHXI+H27UhNH9Rw7/SQgdPlvJDAOYCWizEYza8e1lEi6yIJE4LtsHYrnDjcnCLRTN65FKLV473Gr/jj3AU2yW9Z1HpM11KMWop+tjUAwIMoz72GJ/dFxBln8F9iZ7TRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191621; c=relaxed/simple;
	bh=WGBkDV8arAy6CfiLdJelnTLqBaVzdhNXtSwP5pyuq2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6Tf9N7kUwaEkEyX9G+orEOGITgOTqVmq+2OSJKaLHj3hbZ0id3enzCB6t6tSwzX5SxQCM4NPZ1+qN30SFdQUK7BLBbsRSKcKRaukFozaUMpYUDiG/z2mzarD7Hj/U/ht4OaAtgnWgHDmfQG2PRGOfOiIv4MRGk+VD0rQpQgO20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=gAc8yFXj; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99f629a7aaso823160066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730191617; x=1730796417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZlCPcUtK7nW0/9iHLjxsFqERMJTARHO2kYU3JNPHEY=;
        b=gAc8yFXjx5ZD/I4+ytWcJqa/FtHwonmJGy9lU1nGirduKpO8E+8YMrST/o7jgADYq3
         DMcm48IW4B+cV/zNM3AF6kk3kL8yMKvaND/KGtjg29KbJFIV1CIz1USNMi1ZHNToczTn
         rjGPRGk8KXA1NLiOCdzVfJgeGshXh55uk68XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191617; x=1730796417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZlCPcUtK7nW0/9iHLjxsFqERMJTARHO2kYU3JNPHEY=;
        b=mCUoon/AoHMlD2u7sGRKaJYh244UryFDTiUdp4QGuQ+PiwTC0J6soKIkm4uPjH8+hK
         ueETy2gQAeuqld+W8rtPFsInwcUQAsKQbardfAAJTAD/EAkJd4K3uPW7TLdeJXb/DrHH
         c9R8OiBPalolsUpIRnNGuoTgdk79CpNk8gSsE1Wk+JPHl8q6NCkrCv4YxY2qUoGEgsne
         Owkf5mO69qQshOTwfD/8z6OJtMoPSpqCV2y/EwhMeKD2MtC0hp9tAPIH5HrXbbOoOvta
         z8sbcLa8pznqLEcqSruEIZbnXgXzH0sw8cCfcRVlUeLhM0ddx3gqZLB4lTFQ5bKIP5cP
         Wcwg==
X-Gm-Message-State: AOJu0YxsLuifN0lpr8ViPGgyGP1kkglVZOd17MCVbfrZTb8CDE/wfru9
	B4gQQYxvCWUM3XFvOt4VsY/rIwNk8qhvGesMB7+TmyTCXQYAVZIL6BH1qoqXi3f14UDUYMKn0aZ
	D
X-Google-Smtp-Source: AGHT+IFQKxzB5f0b2booGkn8USFXJ1j1E1yGV/InkFemJevruCFVY1P+YAKXx0raKflfOBnPOBgf2Q==
X-Received: by 2002:a17:907:9814:b0:a9a:ca:4436 with SMTP id a640c23a62f3a-a9e2ad15f3fmr140074766b.13.1730191617226;
        Tue, 29 Oct 2024 01:46:57 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-68-117.business.telecomitalia.it. [79.40.68.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7dacsm450134166b.9.2024.10.29.01.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:46:56 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [RFC PATCH v2 3/6] can: dev: add helpers to setup an error frame
Date: Tue, 29 Oct 2024 09:44:47 +0100
Message-ID: <20241029084525.2858224-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
References: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These helpers can prevent errors and code duplication when setting up a
CAN error frame.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Replace macros with static inline functions
- Update the commit message

 include/linux/can/dev.h | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 0977656b366d..1b09d30dae32 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -168,6 +168,52 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	return can_dropped_invalid_skb(dev, skb);
 }
 
+static inline void can_frame_error_init(struct can_frame *cf)
+{
+	if (cf)
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+}
+
+static inline void can_frame_set_err_bit0(struct can_frame *cf)
+{
+	if (cf)
+		cf->data[2] |= CAN_ERR_PROT_BIT0;
+}
+
+static inline void can_frame_set_err_bit1(struct can_frame *cf)
+{
+	if (cf)
+		cf->data[2] |= CAN_ERR_PROT_BIT1;
+}
+
+static inline void can_frame_set_err_ack(struct can_frame *cf)
+{
+	if (cf) {
+		cf->can_id |= CAN_ERR_ACK;
+		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+	}
+}
+
+static inline void can_frame_set_err_crc(struct can_frame *cf)
+{
+	if (cf) {
+		cf->data[2] |= CAN_ERR_PROT_BIT;
+		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+	}
+}
+
+static inline void can_frame_set_err_form(struct can_frame *cf)
+{
+	if (cf)
+		cf->data[2] |= CAN_ERR_PROT_FORM;
+}
+
+static inline void can_frame_set_err_stuff(struct can_frame *cf)
+{
+	if (cf)
+		cf->data[2] |= CAN_ERR_PROT_STUFF;
+}
+
 void can_setup(struct net_device *dev);
 
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
-- 
2.43.0


