Return-Path: <linux-kernel+bounces-525246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5FEA3ECF4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5CE19C5890
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE671FF7D9;
	Fri, 21 Feb 2025 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct1FvoNB"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8396B1FDE04;
	Fri, 21 Feb 2025 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119748; cv=none; b=Ye8cgQ4e1XAHotDqYJw+MJOZMvC12E+BJa4X12uhG9EetDJ6T2d4/2OaiFJCzMOSCtEqVhhtOiXrzWr0VywW1sADGmvoF5da1VlDPMpRzDNYNnXGfC/+IAin+gi0GdbJtcO97e617RRYgobGkXqXMjoD3u9rvuL9OGBr81u2eDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119748; c=relaxed/simple;
	bh=fCnsMmvBfXbLmKzAaz03hxr2mpj9BZlX2vlKfj7SNQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H678K/nCoLNQsJHw87LWgri4B/ynhEKQ7OU4t70GrjJ5obGH3EBWr/UHCjADVBfM/jxzRchTRolKVRAEgrrH6AMmUKgdaFnyaS7y/HvywUAsPShI3SFWR3JLqTrn7utaXd2cHSQytMYOsKKBYB5eoBd2oeEy9vES7VcecLDENN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct1FvoNB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221206dbd7eso34327755ad.2;
        Thu, 20 Feb 2025 22:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740119747; x=1740724547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJZZgP9u7QVUH6ZPvsc3Z9sNtX4BPyeqrHPYvkDLOq8=;
        b=Ct1FvoNBXoIC8JJWMFuwEh+nx0ufjWU7ENdt0/1WNSfe9EmWNybaVG+h0wjxE94Wrj
         ZTNW6+MrU/TTqzfkRe9IFfsHh+kkOTp/Z7vp91e0v1Yl872WD/wliigOjFOdVZFGVu0R
         pWKV7+04oNo7m4AyAeexfeuSu8187S/m6Emr6voQuj8IHhe7hKeEnm8RZIW80/Ruz1fb
         l0wrRuVYk5d90U1eKgHLE3X2r5oyprfxVxdc/YNWx6n0lyC6xd3f0VF0OAFskd/RUPKJ
         zF9GNA71Vs5YPEoe9+mtT1b9UFwUoo1dsfVX3cFgk45mt/mB2P2oC4BdkDjRatMU4OiB
         dgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740119747; x=1740724547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJZZgP9u7QVUH6ZPvsc3Z9sNtX4BPyeqrHPYvkDLOq8=;
        b=M4XXis+A7Zi181Fs6zmQ5ztnuZGqAaGTBnTjzlCBW0FJUsTr/axr0/M0iZBbovpdQv
         8Xcn1LvZWsVQ53DeNomPMUOH3/Lhr4oA81liws2T0+erDQs8em6TfLlnGWNLHvBOA8qS
         wVvQ1xKVpl5JOZfEYGMx7zTK2bJ3z95qSq+uuHQisa+EagJ5nVWG/h+wTgWShFEj+lzU
         EbQV0srCBsYhneStBa0yifi6sSLWECaijEJsu2ZblCFvcJOI2mTy9PAtf3bl2yuhe1BG
         77cN07FiqiSYjZiSBpB/hebANivnXZNJw2egnZAuQb2XSg3bHeFxjRS4yfwwh7JRjPEJ
         SXRg==
X-Forwarded-Encrypted: i=1; AJvYcCUjwrPGDsaot6A4lWeOP2h7jLuLGjsuzbOLXOYzAjJLZv6maSmiwEGdbnSpNL0kLlpx2bznCuXfQ2gB@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXDXpMim6lON87oHVoOdtZqDXgrnNOcmbqyCNX9+krtM7Lw2j
	NWwY79PR9YeEG6GUZrNl4vGzgyi0k9u46XqZVgJFkQh7u+efvWJm
X-Gm-Gg: ASbGnctb/TTG721AgKorIOQCd6CYOKvQc1sgJh2FzGaKoZhFh0ppT91oKbl5ZyfB3ce
	Qk3XQpXqfD8y4eGbllqF2kOo2YzfDt78Ej5cuSPCYkWpnsfL8eL710srLqoVELlX3DXm4lIpBKX
	LIdhGfNjtw8p5QVoZlC/Xsh1nN27uaQfPdOmq61QGzB2kCZvLtYr6R1xbkv+sKz24xlRjv1AKlT
	C2wQ6c80ZcVEy7WOShD810vFUrQPYGg9W11A9yJOz6st6R9/LGAb7f5KAq5Pj8+AnHf1U0bFaeb
	CUtgHh94GcZ43ypNEH9LeKKVKdzL5TZhc3IX
X-Google-Smtp-Source: AGHT+IEMTD799IywAKKBFI7G5hTdovwrBgU4HCYvF55pPKJBN3Js9sdTAyBxkVcKXr1qHK/d9ElnHA==
X-Received: by 2002:a05:6a20:914a:b0:1ee:88f1:e840 with SMTP id adf61e73a8af0-1eef3ca3f4fmr3727034637.19.1740119746868;
        Thu, 20 Feb 2025 22:35:46 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5dc68sm13777275a12.9.2025.02.20.22.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:35:46 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 4/4] i3c: master: svc: Fix npcm845 invalid slvstart event
Date: Fri, 21 Feb 2025 14:35:28 +0800
Message-Id: <20250221063528.1810007-5-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221063528.1810007-1-yschu@nuvoton.com>
References: <20250221063528.1810007-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

I3C HW may generate an invalid SlvStart event when emitting a STOP.
If it is a true SlvStart, the MSTATUS state is SLVREQ. Check the
MSTATUS state to ignore the false event.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7919a49e97c7..fca4848d02e5 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -58,6 +58,7 @@
 #define SVC_I3C_MSTATUS      0x088
 #define   SVC_I3C_MSTATUS_STATE(x) FIELD_GET(GENMASK(2, 0), (x))
 #define   SVC_I3C_MSTATUS_STATE_DAA(x) (SVC_I3C_MSTATUS_STATE(x) == 5)
+#define   SVC_I3C_MSTATUS_STATE_SLVREQ(x) (SVC_I3C_MSTATUS_STATE(x) == 1)
 #define   SVC_I3C_MSTATUS_STATE_IDLE(x) (SVC_I3C_MSTATUS_STATE(x) == 0)
 #define   SVC_I3C_MSTATUS_BETWEEN(x) FIELD_GET(BIT(4), (x))
 #define   SVC_I3C_MSTATUS_NACKED(x) FIELD_GET(BIT(5), (x))
@@ -594,6 +595,11 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 	/* Clear the interrupt status */
 	writel(SVC_I3C_MINT_SLVSTART, master->regs + SVC_I3C_MSTATUS);
 
+	/* Ignore the false event */
+	if (svc_has_quirk(master, SVC_I3C_QUIRK_FALSE_SLVSTART) &&
+	    !SVC_I3C_MSTATUS_STATE_SLVREQ(active))
+		return IRQ_HANDLED;
+
 	svc_i3c_master_disable_interrupts(master);
 
 	/* Handle the interrupt in a non atomic context */
-- 
2.34.1


