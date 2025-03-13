Return-Path: <linux-kernel+bounces-559598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B4A5F5F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CB71884B30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A34267731;
	Thu, 13 Mar 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYLjxB9n"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4041F2641FD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872516; cv=none; b=s7TxruCez0MEYcYVyers5XzemqwhP5We0vonsT70e/4TK0I5YRl1ZbPsQsUAvl2NeGNqCpKs6vIbrvInP+yY46veS/7nfih6t6WcXbQ7P4FyNh8Yql0q9HrGHWih6qlZLeafUuzHGLpdM0RJmUDIs0C5xkiRCJrBrFo8EN2nLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872516; c=relaxed/simple;
	bh=Ibh63Cc9hvzyDUgJiiuJB7Zg93I8n7Kb3hQB2he5yfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j7ZOKf8pfgWQnUTxWHkXwXww8dUi/HJ8xMWx1+PQvSXMfjm6ylhA/Mg3j6ow81gHtmNNoZaOLzzi0bY0YQziqN6m22Pl1IV7mZD2DAbrGbYFbYQ49hl5k3Af8QduY5dPyX9wupwBVj27RietWoAH80DBe7C55olwJ4mZ3UwPOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYLjxB9n; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5b56fc863so1294551a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741872513; x=1742477313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21+yrU9yGO9isu/UiB7h5VTDLe1lgFL6lFq3DMWFhU0=;
        b=eYLjxB9n9DCHYaS/J5zB+HIc0jMWTTqYm1pGFGa1Xaw7uvlidhEH5dPT08Ch7LXyrX
         rarK4Vte2anqZH037lSaDrfvaKmKXJGWE9bYMqgDrakifn1qXCoqNClYr3Cou8Cm3Q6I
         sIQMrLqefoF4n5LpEqg5bTGbislaZDfZ1NKu6ZKoB1SZ5ofN6ZKY5Wn3IyclgEO7Xtct
         VbAwBtOFAhJrZxB2jYeRZyw4Kv8UTk1jQdLd4yD7U+hVRQ7Cul9/kU+foc0x1grEyw4L
         6cVBjAw3GCEKZMU21Q2ewaSRcz11ICt9lnyOTns4mzCnPmNBLOynj1GnwVUHwJpnqHif
         N3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741872513; x=1742477313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21+yrU9yGO9isu/UiB7h5VTDLe1lgFL6lFq3DMWFhU0=;
        b=I/5mtEXEykc8H+HwkBtk44v/UhE9pFcmIGbYsoo9hfzNaAomFBem0KPVkOJUI5kRK6
         7fnLS3mF5XX+FPf9vdV605mVkytZxPbwronN60gEaja+NNLqhx15hmSV3xK+/yCUw6Lf
         /WEVRbvdBw1t4aGhCq7vrmak5jAQhQWTClPhiE9hyKckJMMj7cKcb8JwZEMU6LxWYZ0r
         aIVeFGaIdEOlcuxF+Fs8/q/cMLMRawTIkkPSQ1JuQWtdLJNe5pL4eP94ws3es6Os/DGF
         cpR0qyiZC9rcKzYugS6FF9X2x3V5IcTvtXtbj07dMGThEAHBfTrqLwAB/usM4e39dTQ2
         fJsQ==
X-Gm-Message-State: AOJu0Yz6QaP9Ho1OShbhaScixO+LrqcWETpWP2yDcEmH3mU7SyshlU5x
	Ksn6qHUy2sfk5/4CJCybk6FpzEhH4zgfoTK3+UQtKE0ieU5MqMuFCvSPCA==
X-Gm-Gg: ASbGncvvYRq+oISZxVmQRX8in1Wl5m8qs//pCiFYB4ixeNO4t5obCVmNp2GBOO8y/rA
	2R+5SMikltKmCtulkRAbfyqt3/ulGgXX7yQVnfNHpKpww6KJWRMPRc8oRPXJKgxU99zUa0r9obp
	FZgeZmTgsJ81+Zk3n9LpmbrNfDiJq1krveBZ+YyOHpIDVW3Z59OcSzugOGYd+P0drrbDvkCW/1x
	FRDjUb9x6epJOZYmPDYc29uWfZ+9WTcDoKfZTgIb10pgx8p8Y6oo5VbwqQPA70S/ob6JyXBFQlZ
	wb0Yt3930MEJ4mwOpGcPfuqjopx3e+ax2LptnXfOdHAOht3tSLJuFesy
X-Google-Smtp-Source: AGHT+IGIDNcQXGKVFw4f5sbUHzsaOfKCmeDEH8uRzVD/6M0uqLjjp3ePOoYFBmun7sBmtFYIrPcTqw==
X-Received: by 2002:a05:6402:1e88:b0:5de:dd6b:a7b0 with SMTP id 4fb4d7f45d1cf-5e75de57dd4mr14483661a12.1.1741872513200;
        Thu, 13 Mar 2025 06:28:33 -0700 (PDT)
Received: from localhost.localdomain ([46.53.242.22])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad27c1sm747705a12.59.2025.03.13.06.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:28:32 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: regmap-irq.c: correct way to unmask interrupt in driver?
Date: Thu, 13 Mar 2025 16:28:30 +0300
Message-Id: <20250313132830.2514224-1-dsankouski@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My device interrupts is described with `struct regmap_irq_chip` and
`struct regmap_irq` [1]. After driver probe, all interrupts is masked by
`regmap_add_irq_chip_fwnode` function.

I tried to unmask by writing INT_A_ENABLE_L_REG, and interrupt is unmasked
and fired, but it is NOT cleared, i.e. INT_A_CLEAR_L_REG is not written. It
happens, because `regmap_irq_thread` still thinks that interrupt is masked.

What is a correct way to unmask?

[1]: device interrupts declarations:

```
static const struct regmap_irq p9320_irqs_a[] = {
	{ .mask = IRQA_H_TRX_DATA_RECEIVED_MASK, .reg_offset = 1 },
	{ .mask = IRQA_H_TX_OCP_MASK, .reg_offset = 1 },
	{ .mask = IRQA_H_TX_MODE_RX_NOT_DET_MASK, .reg_offset = 1 },
	{ .mask = IRQA_H_TX_FOD_MASK, .reg_offset = 1 },
	{ .mask = IRQA_H_TX_CON_DISCON_MASK, .reg_offset = 1 },
	{ .mask = IRQA_H_AC_MISSING_DET_MASK, .reg_offset = 1 },
	{ .mask = IRQA_H_ADT_RECEIVED_MASK, .reg_offset = 1 },
	{ .mask = IRQA_H_ADT_SENT_MASK, .reg_offset = 1 },
	{ .mask = IRQA_L_STAT_VOUT_MASK },
	{ .mask = IRQA_L_STAT_VRECT_MASK },
	{ .mask = IRQA_L_OP_MODE_MASK },
	{ .mask = IRQA_L_OVER_VOL_MASK },
	{ .mask = IRQA_L_OVER_CURR_MASK },
	{ .mask = IRQA_L_OVER_TEMP_MASK },
	{ .mask = IRQA_L_TXCONFLICT_MASK },
	{ .mask = IRQA_L_RESERVED0_MASK },
};

static struct regmap_irq_chip idt_p9320_charger_irq_a_chip = {
	.name			= "wpc-irq-a",
	.status_base		= INT_A_L_REG,
	.unmask_base		= INT_A_ENABLE_L_REG,
	.ack_base		= INT_A_CLEAR_L_REG,
	.handle_pre_irq	=	mfc_wpc_irq_thread,
	.handle_post_irq	= mfc_wpc_post_irq_thread,
	.num_regs		= 2,
	.irqs			= p9320_irqs_a,
	.num_irqs		= ARRAY_SIZE(p9320_irqs_a),
};
```

best regards, Dzmitry

