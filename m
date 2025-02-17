Return-Path: <linux-kernel+bounces-517634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7777EA3838B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F4018949A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7D21B8F7;
	Mon, 17 Feb 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3ld8TPW"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB5D219E9E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797014; cv=none; b=Jg1YXVtK52CNTJQvMnKNmxfcjiD1vNfQK4MaCNAWTkB9V2Q/DcZqJTDGl3/LQI845oxeGSmmhikmqZYVWMkjqE7AeAXsChn7cVWD7zu/XbdU1ZCi47T27ci+81LLSdTndT5EoL88jgUvZJ32VPR9wg/4W9hav5vf7CimltwWa0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797014; c=relaxed/simple;
	bh=Tj1MUtrrHYN3dtuh02om2PeXmRrh4rBT8jyqsExbAhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prruqRkabfFmWRwBFLHbHHWWNXk67KkyHPt5ZDB5FXOXR4pQlzNiZJc9XLxGvDa/BwvR2+7e66ERXaB1vXj9ZtwNF81i9kYIbKDyf/V2Xnz+U0QanaZ5jW8SWNHk/E3tbu9JhrUi5S9EwJ+Jba/rUwAtH2kmUuMfGgZwDG3Cw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3ld8TPW; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-219f8263ae0so75941955ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739797012; x=1740401812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqT+HtUapWQjxJsoaklq/LsDFIgfZnyX69Um1q4t73o=;
        b=D3ld8TPWGpXs3FAAk88sMig97W15NoCKXJD1MqLML9u4gnk/hC3t41Ml7iKtGIYulY
         N+8yaYHHfohL8hTh4CfG2vk+ZxhR3gb5CieW/JKKV/V4B4ZCkzh/0iGE9ZIi0e1aMUwv
         GxulbNRQNomgnbKiRAyqwIjWXazj8ehO0ogFB2dnlawHqzhh3+YxSe3s6+znYKiZ3cxW
         kmhtEs3btqS6vH2dDZvflQLB/7GVIv1WswuXUcaT+/KwbVeqbEgtNTDYRXw48q0Ac34O
         +veTVtzG03ZdQkZ6WytM6NA20JfLDdcnFwH/XUq78OUXljro2n2rFyEmCfy3KPBxq/bV
         9K+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739797012; x=1740401812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqT+HtUapWQjxJsoaklq/LsDFIgfZnyX69Um1q4t73o=;
        b=PaXcbFnf12O2A0SzsfYuSYYC1pO5VDwe6EKHNqwH/yhTIQkZFLWUE93Qys0+8SyZbI
         BQKXye3u1mXF6tB0r+jQPpmcvG/JHMtCUZE2lyQTIlyOKs3zgjVfRB/uMNoKhGmHruPr
         yusEkIA+RFFGVjUEYrfN62EDbZv6xycD7DliU6UYYM382ooE4QK0NN1ujejr5Ik7XwoM
         9G4d6RUExMvZuZQ7JeCTVok2/G4NrE9Dh1uUr49LHrqPzWHZKrRbExNEXRL3cFaZAkB4
         ddB2I5eAkr6baGoL9z0g/X9ztJXZHE0sXwCCY6XvS7mm9oBBMy504znk4PV5Vs46PvTQ
         vrvA==
X-Forwarded-Encrypted: i=1; AJvYcCWM7iZK9ZVXm2hKUWHnU2HhLcimoyoczTExF+yIVWRebd6gw6h7Ktlmr9X3Xodo0nDHhEqsfMasZnvg+Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyLZR1xyDL1W98ZRqT2X/G/pAvZ5M+l3+JYP4dnW7/Lskjgwc
	mE2X5vyKyW1HfAprnLKf1UmZYNnaBxoArIUdkzmi2S3CwVX3pWcL
X-Gm-Gg: ASbGncsJbfzT1Mj+nQpz9roguNwRnacWHQOG5ZNf2PC2SJnF0mToY0+YVZ3pXV/IDAt
	rO/mq8JFR+pN//O8JsjFb27wvYv5PPmnhDkjOSE3qPRIv1l/lYiyfA5XqyXa18i20g1eH/qFzSO
	SqAlg8pj52QWLRjmbxVtO6+FZtPLMCi8XUt6W7HLHxsqxldz3xY2RxSllhybMqmBv06htUT3HiS
	vzCGXRFfbAGIPbNI0TIEVXgdxb/ZX3uGDD/7j99a9H0PayFa8O6KiHupO+mK02YUdy6VL1eYTQp
	fRhkrJhBLPBhEdgrPBtg
X-Google-Smtp-Source: AGHT+IFQsDLLICtZTwp1fHa3MkySuBKcyWhJhsaW31e/cQmIMTsA8p9xCDYokjLDXm1wveuKaXpjdg==
X-Received: by 2002:a17:902:e54e:b0:220:ff3f:6cc5 with SMTP id d9443c01a7336-221040bf806mr162699635ad.35.1739797011931;
        Mon, 17 Feb 2025 04:56:51 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556d45dsm71102925ad.168.2025.02.17.04.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:56:51 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	kuba@kernel.org,
	rmk+kernel@armlinux.org.uk,
	broonie@kernel.org
Cc: arnd@arndb.de,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH 2/2] [PATCH 2/2] staging:glib:hp_82335: Refactor kzalloc size calculation to use pointer dereference
Date: Mon, 17 Feb 2025 18:26:17 +0530
Message-ID: <b3358e0d2c50a7d0777dd11d6e34ed9a52c00377.1739794938.git.kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739794938.git.kumarkairiravi@gmail.com>
References: <cover.1739794938.git.kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

Replaced sizeof(struct hp82335_priv) with sizeof(*board->private_data)
*as checkpatch* suggested.

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/gpib/hp_82335/hp82335.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/staging/gpib/hp_82335/hp82335.c
index f1c2045570..66557d6964 100644
--- a/drivers/staging/gpib/hp_82335/hp82335.c
+++ b/drivers/staging/gpib/hp_82335/hp82335.c
@@ -205,7 +205,7 @@ static gpib_interface_t hp82335_interface = {
 
 static int hp82335_allocate_private(gpib_board_t *board)
 {
-	board->private_data = kzalloc(sizeof(struct hp82335_priv), GFP_KERNEL);
+	board->private_data = kzalloc(sizeof(*board->private_data), GFP_KERNEL);
 	if (!board->private_data)
 		return -1;
 	return 0;
-- 
2.48.1


