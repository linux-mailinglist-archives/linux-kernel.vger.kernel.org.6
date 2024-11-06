Return-Path: <linux-kernel+bounces-398746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E401B9BF55D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218C21C23B65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DA020C00B;
	Wed,  6 Nov 2024 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnLdjUrH"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5320ADC2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918045; cv=none; b=P7hikigC/zbGjcxYnHKB3oWf0/hpyv5wdNSAatK01ZbMsY6ZjvrfuBFaDR/No5+gPhhnSv8aX5lklZ4J3hABmztqLte9HpgqS3oFqxhsqzycOBxzeiGtkqoa0rc3cnoOaN+avovuluxK88MdsvLROyxAVJ8JLobTphozZFLZs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918045; c=relaxed/simple;
	bh=BRamlqcU9smyKVEO1s9mrweQyRqmIhJQTYicabrXoMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfV9fHxD7SQfx0ZIwCYWoXNKZEdc+1woGASzxhDQVgUzlS+3c/RtoG8KN7P0t1agj5R8mmKAOnBhZvzbifrSxJdKgkQfomhiSo0BqyHWUttjrMdbj8pnpcq4mZeYzjfhk9iEeGkjJNerRb0/nObKFYKgR+ha4N+S+eYj8qKy394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnLdjUrH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d495d217bso59532f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730918042; x=1731522842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyLzRQG7ihdVYjFiiq9DJdAmiKxXolSxLLfYzOn7lDg=;
        b=cnLdjUrHIbqFXhOyhF+B/ItzwjimgJKwVrkorCQ0GVl9wFkzrHFIpARMGTfAPeGaZr
         TUTqvZMv+a3QDR+Wom6haF8L+WDdCg7nJ0Kq4IFqs3TgTkS0NuAGmNUa6EQ5QBy8icsa
         GDNRU7LO3qp5jJ0vIOrZ0ERBtw/55koCr6UeqIMftgctVgq+pIKxn4SvYEGasUmYTOwJ
         bo664fkE/fWf4ISCPTfsGcls0ZVnub+lL9Zsvz+zNEFCbuith6ITjTXmMlr9a2fuHjo2
         ZM4EqLD2dp2mhSEzEdWNK8NBoa2NEyLazuxv9jJZHI3kH3AfCK8MMwmKFn1/9/XFs1p6
         5lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730918042; x=1731522842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyLzRQG7ihdVYjFiiq9DJdAmiKxXolSxLLfYzOn7lDg=;
        b=DsOWzMOml+suRe7UW18/FdM6d0/ICeNGb0e+Z4YjsT5jlGUmNGVQ2ehOKEkPkc5/yq
         9duxwYJgUPJG6iBHM7JJ1kirWc6tKlGvUqeP4Jt9GNaTxlNO+fEGaGWHlZEKLgu2yRlw
         1n+hIGxCHeYUBR2gi4c8KtQJlx9GNZR+O4yttkaTxrstCiJ7KJJ6SpmI0lIc03M+ebUA
         0PWnojn/8mKdHYLrHAMqx/KLQE0fk2BQFugUDx7YPJPJ+YW4ngv4Ctb6fGpH6qABkS8E
         cvpWqFxPwCuSsHwmRPnNvOBRZFJ/ft56bbc7iyRPGSWSpxXpkaskJEW8/Q+W6O4eS5UB
         8JtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOYVLtiDRXqz41haGuV+zD/52LK1t24oiJe0v3bAgsytEvUqls9Q9EvDzJim8/g5UsQOG+2WcDfQTOPoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDdYMHp76OeMuBYJ4MU23UsIf+QsO2eMtbnJLxV6paQqHa5Gg
	a8wkMcxGrlNmHvzqPbDVAm79+zNkjMT+pb7E5BQXiEEWv855PRYpFVznrA==
X-Google-Smtp-Source: AGHT+IFjuWtWMDwHauyIWQ6P4zJUpK0pb6PnGe7aA5sK+TB19g+3jJkYFGG6MD9MZmLpxBwDgcN7aw==
X-Received: by 2002:a05:6000:1848:b0:37d:5359:6753 with SMTP id ffacd0b85a97d-381c7a5ccbamr21342955f8f.15.1730918041628;
        Wed, 06 Nov 2024 10:34:01 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb1813a07sm315298966b.190.2024.11.06.10.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:34:01 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 12/16] staging: rtl8723bs: Remove unused function hal_EfusePgCheckAvailableAddr
Date: Wed,  6 Nov 2024 19:33:41 +0100
Message-ID: <414a3575073d4f78bd1132ccee6851d93cb59284.1730916582.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730916582.git.philipp.g.hortmann@gmail.com>
References: <cover.1730916582.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused function hal_EfusePgCheckAvailableAddr to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c   | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index acd9c8128f94..9231a4bffb5f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1151,23 +1151,6 @@ static u8 Hal_EfuseWordEnableDataWrite(
 	return badworden;
 }
 
-static u8 hal_EfusePgCheckAvailableAddr(
-	struct adapter *padapter, u8 efuseType, u8 bPseudoTest
-)
-{
-	u16 max_available = 0;
-	u16 current_size;
-
-
-	EFUSE_GetEfuseDefinition(padapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, &max_available, bPseudoTest);
-
-	current_size = Efuse_GetCurrentSize(padapter, efuseType, bPseudoTest);
-	if (current_size >= max_available)
-		return false;
-
-	return true;
-}
-
 static u8 hal_EfusePgPacketWrite1ByteHeader(
 	struct adapter *padapter,
 	u8 efuseType,
-- 
2.43.0


