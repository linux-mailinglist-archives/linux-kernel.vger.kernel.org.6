Return-Path: <linux-kernel+bounces-563354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89177A63F75
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7EB1890345
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DBC2192E2;
	Mon, 17 Mar 2025 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZpwjXV4"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9970B218E92
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742188804; cv=none; b=V9CbSjud/m2qsT64QdotNse8L1UsaTX8yit6dT1zTufmCEE725Gz1cVcjKZYKF9Tub+9/f6bvgOKXNwCoQxTl18TuEZWxNse5gUcFhFW3aRywZ7g39kL/eXZsqBpbznt2F+LajiMgFFqaOHmoxET1WCgSM4CIdF0p9hhHAiGW3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742188804; c=relaxed/simple;
	bh=ZvUxiJNGJUJ6eSLy6xmqeIcDyL3ulL7Wf4C669XW1MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kbVbwM1xMkUID/jWEAQuFNHiWl0+VvOHz9v+GaFKikYT8/+SJ97X8XUXaiVlqcRyPLVCyBo8nh4g7v+M4K41PxM8P39EpalaX+r8l5F+p6rF4iC8zed5dUVnX9rKBngs7EyzmKtTUQEzZyBzHoHDMV/StO6+gGZWbIa7kBGUV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZpwjXV4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225d66a4839so45586035ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 22:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742188802; x=1742793602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAEvizj50eAxWAKykJSsmzW28jqssjw0r0XHccdzS7k=;
        b=UZpwjXV4ydW/GGuQ5Uc8qPu7hZJelZw2221/rtXS3zPGCYZgMHCWp/cjF7ChUV2Ngh
         zUr5xhNKZjrZKdG7Bx+5Equ2eNCTnRKN2ii9gbb5xH1ta7z/i+FMnOWNDKOosMXCawun
         ViGxflPFNd6KFEINQqLhOAKk6nyFbkFnlAFVjNAy5IcE4EIdqc++7FXO3+/ye7DhVjJB
         Y70bh85tfpGK1op+vsxAoZDuqxjdVJ23vZ50/WgjTevRknxBGGsB1wIZ/T7BfXoKPlr4
         Oc4ZCj1fi2xbejjb0W6oAt2ih7lIqKcD1/WCX2iuLRdN62trpZ908+HEOdEYYwoCi+Yf
         z9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742188802; x=1742793602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAEvizj50eAxWAKykJSsmzW28jqssjw0r0XHccdzS7k=;
        b=WCjO2BmknXdhMc2Q9xgM7c8mn3ROqkqe/bY5WLIl/uBfUP4ksHNJS6iVaIToXGrZGR
         +HwvtUTw49Wi3fYPApDJT0bmBGoeA8ehBhnXrSgEphT7fm+0bY5etsl/5xHPrPUp0LGF
         aQ+h57ad9YWeQkEB6MT2lZj11vcx4bky0RLj35is0bdB2sz2y2/dUKLGyeR5ovDjkFvO
         L7quRaLru3vMwfPq82mZQX2SI3V8Bkj6w0zU7jm+nWKmtCWnyTzIj3UZNf5AvjI3GdJt
         y4J7T7caKUewQ233AiHnDzSpqYKWqL/axbCz+Skv7CGkmjyopDp0QpgJ+krw2x41Eq7v
         EOOg==
X-Gm-Message-State: AOJu0YxFlJDJJ/hrBrj3L4HwQOJtsr79k0UmAz9Adfh+K04M81du7RWW
	uVN86n4YnaEoWCcZO/CHso+S3xjQ8Gyaxc98/Ydhqa6NWMDPJgZ5
X-Gm-Gg: ASbGncvcG8lt3OMnsHsU9GIdXwCqy6sB9bZiDd0ii+o1MpMCd1+wL1JLFNBFQiOv9Re
	ui2cmoti65dXcWe8NeOcZ+yQen5Ihg/P9waXf1G9xie0/QksdikJay//nm94K9ZNugAJ7R4Qtz3
	FWpr9RpbRdppYMSkOs/cIIFgtGWk0Bxa5IMKKGVoAaOAMvIM4VdBTEsckLU1FIDrtWAA9otFsXe
	XWI/2duKJ14o+uOz80wfNHu2XBt3HWv4WRv5WtM/0n8mvfzj3cg7TdlGgZHSEQ65oNsmabqJL+q
	LgpvrmY5hLQZoDL3JK0KQDU53uaYyrysKiu/SM/2w/Vgs6FO8/cY5Lg=
X-Google-Smtp-Source: AGHT+IEHB6SBZYCHYVZ9nI0CRHRWXDHgiOP2L/CSK0IC9gfbmhq+cygXWU14lVnZh41QKkaCLFkxmQ==
X-Received: by 2002:a17:902:e750:b0:223:607c:1d99 with SMTP id d9443c01a7336-225e1594eacmr155354065ad.0.1742188801791;
        Sun, 16 Mar 2025 22:20:01 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:df04:8817:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba721esm66029975ad.149.2025.03.16.22.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 22:20:01 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v1 2/3] i3c: master: svc: Use readsb helper for reading MDB
Date: Mon, 17 Mar 2025 13:19:50 +0800
Message-Id: <20250317051951.3065011-3-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317051951.3065011-1-yschu@nuvoton.com>
References: <20250317051951.3065011-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

The target can send the MDB byte followed by additional data bytes.
The readl on MRDATAB reads one actual byte, but the readsl advances
the destination pointer by 4 bytes. This causes the subsequent payload
to be copied to wrong position in the destination buffer.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index a72ba5a7edd4..57b9dec6b5a8 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -425,7 +425,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	       slot->len < SVC_I3C_FIFO_SIZE) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
 		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
-		readsl(master->regs + SVC_I3C_MRDATAB, buf, count);
+		readsb(master->regs + SVC_I3C_MRDATAB, buf, count);
 		slot->len += count;
 		buf += count;
 	}
-- 
2.34.1


