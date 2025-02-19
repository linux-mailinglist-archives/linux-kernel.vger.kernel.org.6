Return-Path: <linux-kernel+bounces-522313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAB3A3C887
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68BE189BD61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551822AE74;
	Wed, 19 Feb 2025 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR92terH"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B622A81D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993073; cv=none; b=ZZUDGLqJSQnQCvRBdBQLUuZ2jUtsjgANircCsycQjclW48nSLhIOZZwBYxBwc1k+sLeSqlTd+ETvmULeKV9hZ26iJ9Clitv6OrpQI2AHQ2PGJ1zGpTjPCD6YBimY7jXRWHI7ZFxjzobpxhiwDZ1Fx6iNtrDqZ9ilx9pXLHsNgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993073; c=relaxed/simple;
	bh=LiS4mnlWu2zof0Q0NXCLUaMP7qwyKNJ4WDvYNH34N2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=he3MtmM8DW6GiPRY4NtHKHSP2ue7+bXrOrAlFsnWI/2sC0wiTO2Y1wj0ddrFRh9IK6XzHLxs6FT3JXLIml3oK5zSR1iQ5OYY9HuuE++3JrVKMyDv7W3AHCDxgkcRdEBC66Y8NVNX0Wnad/vyFrxOHKwvg+f5qsCSQrM8TNIx0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR92terH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220c8f38febso1505435ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739993071; x=1740597871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abXA5gn58gOqmxfZxf0dJZRdbphFcAQMJmB/EVciDU0=;
        b=BR92terHweZa+Y4ngcFHJXVk0NruMCsUCSFhinVdTw2wKtomP58wbCyqA1c8cYuqcF
         NQI3dGaW4layqEEHbxz80KaCQffdFXxOj3TI2GEY+BotNhZqNMOjWmuQsAjSkr/Vzz+V
         X0LRhHqGm/N08dW0OR4uDbJ9co5+chZPZKO2v1nqwUOtjFePjcSOLTJuIlhXyH2ZRh+V
         PeimA5hJQLv2jg9WR88HJCfhshHPWfleq90/eQXrojnPY1A+YEdMPv4ZgtvLjJAdvJA0
         KQinw1kp34KG+VpFpN5oh/wRUgdnEgbgOCpZ1pdh/bj+8s8R9BAu5ec6d6XwEcXYR5Z6
         x2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739993071; x=1740597871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abXA5gn58gOqmxfZxf0dJZRdbphFcAQMJmB/EVciDU0=;
        b=Zuk5IUnTCy+OpgbAJLRhQ69I563YYyu7jdqzbqPmXh+RUn39nRgDmyntysR+DALEsZ
         SehM5ArdvIX4ypUtBKV18K7CujoPV2q5EAeYX2GJCN2h1Gp+rWWheG1OU4Os+SfRZqDF
         UetYIn1rbfoq4P0wadLrCbk+WolO6wyv7RN5UL3jjeEWXuGgKGSCNphbh00RhMb0ckb/
         vYUyHoeT8bhg3qzuJezrgLInbjmmrWWbSNX92wiI49rEyFa1va88IRy1fPkHvOyx6zpE
         Wzy3UDrxFJozYsvwH2LLioDKen+9r2O8yGI15VkcnnSOC9DeTupkjGrhPFOUlDAxVkhE
         rsUA==
X-Gm-Message-State: AOJu0YxwKGzj3V2dLKD5DXNPDqom+ULelt2lBBVYyRk74eDYWX9RwVnj
	J1IDRg1li1oIqulwwDhOfHmKOkW61DTIYSx5nKV8xvaUQn2K7JTya5DXiF2ZoaE=
X-Gm-Gg: ASbGnctndHSQuTCz0FAkJnpeBBzt6T4gg/BkjmWjMYxhMJ7AyVL3WigLTE4pJUFGq57
	H4dl1fWUXCQyMAlOnUlFECnf7XP1Y4/Yqabqf3TzXksMASbuhoevxqzZ1qs2/hLE18BfjUSdTo6
	S4ko26+XeK3pqUxL3uI7FoHnILmiTMItmTSwNKQ85sZ5IMUKEnpZc7sZ+dMOiH85++NZSWNWD5f
	6MozKcYOdUGSBXPuEYhKFbudFXs+l7pMOutb96FF+ujwGfUbp37h1W02+V3TUZtXz0bMkN1yGPO
	2Hg6g5GNRREsj8wKPQDv/YwLUsUUCl29pRA3aijdfzhU3AyanmuPIDfTFFY88/S9BElvtlxwrE/
	mYh8U65M7
X-Google-Smtp-Source: AGHT+IHRoLyWURcDArBppzmCFxeidvQk/qhhWncqhDS+ZbV1+BKcvtAhDqyuqOYcNkjTRBgv5OXOPA==
X-Received: by 2002:a05:6a21:3394:b0:1ee:d7b1:38ae with SMTP id adf61e73a8af0-1eed7b1398fmr6220208637.39.1739993070953;
        Wed, 19 Feb 2025 11:24:30 -0800 (PST)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb58618479sm9615322a12.33.2025.02.19.11.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 11:24:30 -0800 (PST)
From: Suraj Patil <surajpatil522@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	Suraj Patil <surajpatil522@gmail.com>
Subject: [PATCH] gpio: max732x: Remove deprecated irq_base assignment
Date: Wed, 19 Feb 2025 19:24:25 +0000
Message-ID: <20250219192426.164654-2-surajpatil522@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219192426.164654-1-surajpatil522@gmail.com>
References: <20250219192426.164654-1-surajpatil522@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
---
 drivers/gpio/gpio-max732x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-max732x.c b/drivers/gpio/gpio-max732x.c
index 49d362907bc7..bc30cb57e222 100644
--- a/drivers/gpio/gpio-max732x.c
+++ b/drivers/gpio/gpio-max732x.c
@@ -525,7 +525,7 @@ static int max732x_irq_setup(struct max732x_chip *chip,
 		girq->default_type = IRQ_TYPE_NONE;
 		girq->handler = handle_simple_irq;
 		girq->threaded = true;
-		girq->first = irq_base; /* FIXME: get rid of this */
+		/* FIXME: get rid of this */
 	}
 
 	return 0;
-- 
2.43.0


