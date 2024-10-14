Return-Path: <linux-kernel+bounces-364325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7971B99D27F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FC61F24143
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75641C7B6F;
	Mon, 14 Oct 2024 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kgqMEN2N"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF501C2439
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919490; cv=none; b=o/riON2tD4NZWsrzxz0ABUmfAmtg72DVst7dnKmTbycH1QdmLT2RNc78Wn+2SfKQZ9g9nSM3Daw0X4/6SWdQVoN3Xc2cmcDu7zzKTbpZep/Dg4xCJotKUivR8hAWiq2Sh0byXSfQn2zm0JMR2jXAbYGue6KV2d2lTYtZyp8iDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919490; c=relaxed/simple;
	bh=lh4Nux2BM9KA0YnyuwNNz2cQ4XebGG7dievfjnPe1gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6Csy14bzHXLf3xIzf3oJ+9XltpKNNDSkFnxhKwM40hDVKtgohcqGi5/+yZLfpX74K7+YvMWU3suEgIUPs3Wb+nTMYZtirvYdauTYpaJfcuLt86PDp0Fz5LVINlmIM3qisprwl8OwPMT/gNFAr4hptmbgagw8vM6x+3oYuVEnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=kgqMEN2N; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so3138158f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728919486; x=1729524286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl0FvaCWPNne/T/X4eNpX+jzq6AP7zoJV76Sz9wGAY8=;
        b=kgqMEN2NGsm6oSSnGHkwr3FvdGlXbmgdvPwthFXpJXxa33BOzWIBBlD8tKeJztLda4
         Lq0oUqTexGkUDSEVfRcZuy868suTbFfldNnsf0Pcg9Fo7l5ESp/CR8UkpVu66dNtMAKz
         hsluwVNNq7V3WEOt/jUUKw8h3q/bdKrWxa64A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919486; x=1729524286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl0FvaCWPNne/T/X4eNpX+jzq6AP7zoJV76Sz9wGAY8=;
        b=hSt2mcQvN4kXVieSFXct8XEiMydXPSNZABad2tjUBoknOS9MTnBxPTuFSMoMveOez+
         V3OgMO7H1e22TU+kkUuqXfext4vJVp4XkclR2HEUb4SfqR7l7LGbFlbqaVi1L8izPxmO
         iboBGSFhMyTe/F/rn0r/dnocRDQE0/NYyhQIQaGkd7PC2yZknB3pjHfMZaw4HLNjDOOz
         Ey4hvWjIBgSiWDWGWuROjH/FwXg1DVH6Iac///b35FiRWaXe4yPaFe2zk0Bm2lfO84Yx
         wZ//wALo+wV/rf3n9d9wLkmbbs/oSqVw43/rm9yGZ0CuRjhyZlTlf4WzJ8QQEJFWvAvJ
         l9mg==
X-Gm-Message-State: AOJu0YxOFmeJxMYUQyvnemZTqD6hhpfb+yKUXdud7U0YRYgIcT6IZtX2
	r+qXFlCPtWKymGdE04PHZxNu3yx7/aaTGRcxQACbTbjFleNZzARzm6tTm/p1Dy/O8hIN20Fb1md
	AfME=
X-Google-Smtp-Source: AGHT+IHXtA2bKleaKXoB33rt2FVydaPUB5ihn14r2Ga+SIzk48TF91MSDXc9jkxNU0eOVF1n5dQXhw==
X-Received: by 2002:a5d:684b:0:b0:37d:52d0:a59d with SMTP id ffacd0b85a97d-37d551ab465mr9434826f8f.10.1728919486433;
        Mon, 14 Oct 2024 08:24:46 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd1b7sm11629911f8f.37.2024.10.14.08.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:24:46 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [RFC PATCH 3/6] can: dev: add helper macros to setup an error frame
Date: Mon, 14 Oct 2024 17:24:18 +0200
Message-ID: <20241014152431.2045377-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
References: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
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

 include/linux/can/dev.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 0977656b366d..0202526be6b0 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -23,6 +23,33 @@
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
 
+#define CAN_FRAME_ERROR_INIT(cf) \
+	((cf)->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR)
+
+#define CAN_FRAME_SET_ERR_BIT0(cf) \
+	((cf)->data[2] |= CAN_ERR_PROT_BIT0)
+
+#define CAN_FRAME_SET_ERR_BIT1(cf) \
+	((cf)->data[2] |= CAN_ERR_PROT_BIT1)
+
+#define CAN_FRAME_SET_ERR_ACK(cf) \
+	do { \
+		((cf)->can_id |= CAN_ERR_ACK); \
+		((cf)->data[3] = CAN_ERR_PROT_LOC_ACK); \
+	} while (0)
+
+#define CAN_FRAME_SET_ERR_CRC(cf) \
+	do { \
+		((cf)->data[2] |= CAN_ERR_PROT_BIT); \
+		((cf)->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ); \
+	} while (0)
+
+#define CAN_FRAME_SET_ERR_FORM(cf) \
+	((cf)->data[2] |= CAN_ERR_PROT_FORM)
+
+#define CAN_FRAME_SET_ERR_STUFF(cf) \
+	((cf)->data[2] |= CAN_ERR_PROT_STUFF)
+
 /*
  * CAN mode
  */
-- 
2.43.0


