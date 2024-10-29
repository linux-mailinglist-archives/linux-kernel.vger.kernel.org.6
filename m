Return-Path: <linux-kernel+bounces-386845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824C59B4894
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C671F23949
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EB120606B;
	Tue, 29 Oct 2024 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KKPTYpwp"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42595206040
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202398; cv=none; b=bxJTuZbPjV05uioqN8ExXT6fsIeBOgCN/CQT9chMDM/5OqlZVAmECQ4d5Mw5jNfy3Owlw0Ufnykp9Y3pprImbo41EmCVa5dbiv04Fwrf0yBxYWt44BXRjNcoknC3aUGkv3gDWECz0G9zFXaOwqBY0LGcu1hAS46K6KGawMoxXgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202398; c=relaxed/simple;
	bh=qRJCyHLXDHPViQRK0r4I6eZdcHjED1uaQM2TcWTM2SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ni57tQigeoDWsrCzxHP3ZBCFzs+fEldRn1AEycxGcJAmqgeH+tiC5KeuDbCwFP4/p/FMRSdwuAxoBZaACkotCakt+dBAxuRvI/6dV5N+WYoYA/l24e8iZ+i1LZiTS6B0LanHuRmXIl6Vra7B7SzoC7aaYEau0Vo1IRm+h06SxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KKPTYpwp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c99be0a4bbso7286346a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730202393; x=1730807193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nbw+NGEXr7m2rV0cbMmuavLOG9IUHHd4c12xVVX95f4=;
        b=KKPTYpwpGfJYnK8yiiOwUCNWDVQm+yMX+2hDpdwFuWDJ9OGSVnLvmfHnSrGLvFkXcs
         RvmZYOufCG4tGn2y6L+mt6R9u6KjKhKciJHmr/+a5o+cus1R7WE2ee9v7IFykQu5/x0c
         tQlIld4ZucFYl/LBHURhVuD9JYt7V1l6Rx25g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202393; x=1730807193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nbw+NGEXr7m2rV0cbMmuavLOG9IUHHd4c12xVVX95f4=;
        b=raLTBnHLH6SJc/BAI+hO6ll/EESAavMtG/jJBSS79piJaTfWz2hNC5Yup4oGMV2SE5
         7Y6bfjSNgXaye/PqhBPE+MFCk/D0oQA/qerFzKj2SA/nX+U14KFK1TArvBkTgMGgZH5X
         FD6bsDgsAKOp/GAWmb9B5DnIwynvR3HLQrrFqJ5ii2SLwlGmUAjBeFAypsChxVnUNULP
         j9H9M3VWQIyeZoa48BFlbflhT5SYsKF8fSerX+DFEQq0F4ssyxAMEAxWLUPMgeEOoDpW
         wgjM8knNo/u4eVa6oLkF4rmbakqitKNMjU8tu9oF1dXdnGTEuXyPWFsm/ceVlyqY9UMF
         FPfA==
X-Gm-Message-State: AOJu0Yx1xm3cdze7ZStZR9Y7jA9uDc8ZSUuZRR9efqY5VPXOMXVs1lz1
	2omhXbCtJgYA15GmICM01lFrHju4eDulefCTWBTVPFXDr9K/xPoQqV+sHB2SX2xf/b6W3Jtly1B
	fIsM=
X-Google-Smtp-Source: AGHT+IEr9NBZlyeYnYIfXfkfSPE8h1G/DkRYurTn5HC8Kw95XILRDI+sujvZBHNAwQ/Z179qoYcvZg==
X-Received: by 2002:a05:6402:3787:b0:5c8:95ce:8cc2 with SMTP id 4fb4d7f45d1cf-5cbbf8b20c8mr8968166a12.16.1730202393242;
        Tue, 29 Oct 2024 04:46:33 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.41.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm3869301a12.21.2024.10.29.04.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:46:32 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [RFC PATCH v3 3/6] can: dev: add helpers to setup an error frame
Date: Tue, 29 Oct 2024 12:45:27 +0100
Message-ID: <20241029114622.2989827-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
References: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
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

Changes in v3:
- Drop the check of "cf" parameter not NULL

Changes in v2:
- Replace macros with static inline functions
- Update the commit message

 include/linux/can/dev.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 0977656b366d..da85c44808d5 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -168,6 +168,43 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	return can_dropped_invalid_skb(dev, skb);
 }
 
+static inline void can_frame_error_init(struct can_frame *cf)
+{
+	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+}
+
+static inline void can_frame_set_err_bit0(struct can_frame *cf)
+{
+	cf->data[2] |= CAN_ERR_PROT_BIT0;
+}
+
+static inline void can_frame_set_err_bit1(struct can_frame *cf)
+{
+	cf->data[2] |= CAN_ERR_PROT_BIT1;
+}
+
+static inline void can_frame_set_err_ack(struct can_frame *cf)
+{
+	cf->can_id |= CAN_ERR_ACK;
+	cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+}
+
+static inline void can_frame_set_err_crc(struct can_frame *cf)
+{
+	cf->data[2] |= CAN_ERR_PROT_BIT;
+	cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+}
+
+static inline void can_frame_set_err_form(struct can_frame *cf)
+{
+	cf->data[2] |= CAN_ERR_PROT_FORM;
+}
+
+static inline void can_frame_set_err_stuff(struct can_frame *cf)
+{
+	cf->data[2] |= CAN_ERR_PROT_STUFF;
+}
+
 void can_setup(struct net_device *dev);
 
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
-- 
2.43.0


