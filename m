Return-Path: <linux-kernel+bounces-266886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAACC940909
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA61282071
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D75818FC88;
	Tue, 30 Jul 2024 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwkf0Avu"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DFF15FCE5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322755; cv=none; b=nOu1i+zc/99LjAZPJ+LSOuj+9tXDbaqpEjPHO385KB0L2l6iahffNDMXopsKtdvJUjLRDna/aZCGVPYylZiEfH33hJ4oxoRHbf2oyX9HvyfGF8pnMQHVRNGJz81QJisCNXK4dp0dXgFcQF1XAMhyyUe+9kp4vhzVANiqLx07OXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322755; c=relaxed/simple;
	bh=aOINiKi8h9bi8olxYJIxv55XJ4wLBEoWJa6Rw/bhqIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=twC0GLSwKuCjk+tBpsvKu5JjvA/C2Cs0hC5juAnuUI4M1dGt9qt84EdKUyw5VRP+aRkegUBUhbG/oyLXfwW4Ix+5sb+9PTLVVtoQpmbTuyrRm0zY9Ggg5aRGJBJyxKKXys1PhCgHBwsmt8lM0bxdFTkgtsAa02KvZVD3D4+dRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwkf0Avu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fec34f94abso27911635ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722322754; x=1722927554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BRZxFFJxsWDQZRh+bmJi1OBc9hBJcJtDXXsB0kvWwMM=;
        b=mwkf0AvuiuKZ6QApD4rLqmXfJugvkWbm+BLUSpcm7rkEBxKrd44H0nOTtUeocsJGve
         xRquzo0OdqiZoTMNQ0YtDQ+jFs0OGXJwEQID+IKGBs3qLgmiou1DLWrkMzwiPH7Wsvo+
         jzctYGQ1d28qfsWN4Osws1wgeZthZB70AWI4msPMvIxAImQSTSTHhMc3Xlzq01MzTter
         Kc/PYQSRFiDiUZXU7RAaIj4FV8l4GGm0/SqVoDYrXgJjZWy23UKjsKyYxFzEId2oZpS9
         wrVOPtgOC8E2EVcihTArGLZW1urtIgzB+fkr5JbbENd937lD2wRF5H4E0OZ1whiqgti6
         qqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722322754; x=1722927554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRZxFFJxsWDQZRh+bmJi1OBc9hBJcJtDXXsB0kvWwMM=;
        b=qpWukz74HcDQKB0w52Lb4cCzabsq3CzIDkBd4jm92PqFYZ0z76N6E3ARzI+1r1LQgG
         4E1Rm4UJsPUg2ClnDkTuOxGKwWrUiTYpmzvNSNI/E1pyT4lhhEDt0FLtvWt5a2z+vY0Z
         wDjnsazQ9RBeYx5YaAl4B0/qLovSS+SugueBzbLjtM5QN2DvOPpIvrAjaeW2bhtCh9aV
         mrs1cS9vf/X7pIKwu9PCAqjL3nZdq6hpDS34EDIip08n4l1lfphBZRcyrstwqyNORkNL
         6A3FQqbCWiCqzHlegpwxy2eIkuWejZLcfz6bC3Od7m8+IOhOjHecVjgHlJTYRje6cy1r
         VzJg==
X-Forwarded-Encrypted: i=1; AJvYcCXdZXsTrjbKKeMWDHYYUYlCRo6yAEJYsAOhoaUqVWukWLy4AaJfi4X8uTqiFUIG8WNgXMaq+DJ+mZR7IOQke7UvAsWlO8GwPuEoV6oS
X-Gm-Message-State: AOJu0YykD2r5RCsbs8f7v3DNnqOdNRiJ87gV/kAWIrs/PavPQ0++IvBF
	n7wSoealCjxdThLcvcCqUXh50qwYGJ9+TLfgCTKCpJk9CX812WlC
X-Google-Smtp-Source: AGHT+IFlkzD18e53lfpx2YGQDksypAKMBrVfclfV1BiDSbW2j7Wy3xsFQ1mMR/7wvPWF2e0Fp4yNJw==
X-Received: by 2002:a17:902:f681:b0:1fb:973f:87f with SMTP id d9443c01a7336-1ff048e1b5emr83515545ad.45.1722322753576;
        Mon, 29 Jul 2024 23:59:13 -0700 (PDT)
Received: from 3a25d514abef.debconf24.debconf.org ([116.89.172.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fc9cc0sm94075425ad.279.2024.07.29.23.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:59:13 -0700 (PDT)
From: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	helen.koike@collabora.com
Subject: [PATCH v2] staging: rtl8723bs: style fix open brace on new line
Date: Tue, 30 Jul 2024 06:59:01 +0000
Message-Id: <20240730065901.35254-1-sskartheekadivi@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It fixes the following checkpatch.pl error
"ERROR: that open brace { should be on the previous line" and avoids the
warning "WARNING: braces {} are not necessary for single statement blocks".

Signed-off-by: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
---
Updated the commit message.
This is my first contribution. Hope I did everything right!

 drivers/staging/rtl8723bs/include/osdep_service.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_service.h b/drivers/staging/rtl8723bs/include/osdep_service.h
index cf96b5f7a..5629123cd 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service.h
@@ -81,9 +81,7 @@ static inline void thread_enter(char *name)
 static inline void flush_signals_thread(void)
 {
 	if (signal_pending(current))
-	{
 		flush_signals(current);
-	}
 }
 
 #define rtw_warn_on(condition) WARN_ON(condition)
-- 
2.20.1


