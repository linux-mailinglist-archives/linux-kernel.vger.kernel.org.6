Return-Path: <linux-kernel+bounces-305693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3D09632E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F9EB21F89
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EBD1B2539;
	Wed, 28 Aug 2024 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y11AU5Ew"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF3D1B29C9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878010; cv=none; b=UAaxiQptvaNAi0RYeoSZB6ESoOIvpbIjSS/Fnzi9mSBo7mEn6bQNo79WTa1PoQ4E7OayuooIZThOvpshGxbgf8EtNsxRqR4fNXXPsWulcXU2YWC5b0bKNKgh6sp/wC6+hJd4vhJb8Y3k+NtpItaYcHUY7QQJ/exrnO70gha80eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878010; c=relaxed/simple;
	bh=HrxIsLX1t8fqUKStXlSKad6YGkhD4DzNg9xJcaB84l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5PJMhJbMBd38nqMqpu0pt3foi6NN/hkbhY+pg7CzquGpFrvZSLhhJoNw5SMrX9RNk/ceLM+LF7fesvYgznH/DLbAZju9R0NP8E1WY34YiRLMx1rOep8uuNrmN3eq6mWToGrFNKMDFbfhQvkKeM16g7G+FCoPy5HgaFo78aqw+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y11AU5Ew; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7143185edf2so5984701b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724878008; x=1725482808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLjai+LBEjlJGkvV4zgGzDy9TLZP9iYjURA2R/8vQGU=;
        b=Y11AU5Ew4au48a29ZM5Rn5e+Ykzm23yKhJTm2gkuuoXn/+knRevcR8od7UFe5yG5QQ
         05WFxZiZuSkfg8w0b6xEG0IyowGroGzNLJY6cvx5h/qBtPMhptC2Fm60S9Gp4RngXDA4
         KktUMfByEZ+/lECGrPtpDHfnd0NQUDe/l/sfTlS6YUrDJM2QCJVuAMaVyLW/de8AzLvj
         X0rpUBSkLTUkkj2wVOrbH7GfCHgrSjxo8HeOKZnCHNlkN/N4+fgsqCxOwJ5Fxp/NfrqY
         5nC/ZxqGQjDZXZ3savZIXFNoKi6YcbpTtCCf3/LNfeP3laRLKaOBhP9/yvkVkDkcnerl
         qO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878008; x=1725482808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLjai+LBEjlJGkvV4zgGzDy9TLZP9iYjURA2R/8vQGU=;
        b=Uy1v+qlJcYHlWmdmuQB8IRHkX+GRG7pKts2svAUR08tpsititVRRKisgKenJmpiYaT
         w5Nj6CBs/WtK/F0gm5US8hzPe1r7r4RhRSUfi95JcdFCI6Glc7hWzam0aVcovnTIJ0h8
         WUqncRe0Yk0fKa8IulRlwYi94n4QMRW67ZS0PTAYtOq6Lis6IhCzJzpX5JZCoYLAaDip
         40DEnp2FV4Jp4w+pzphFtFRqaIlbM8nH5gLnl0T7wilQB/SyCe02f7kwTFpYyS93mWDN
         tWvaeidyeWZ+jfK+G5xbQquAvksr/cdyZEBp5fjFuVAWY3EOQWmozNEXG7vBXVxZNdkG
         j13Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/Q7525eC/IkoKd7GyCFprT5+lhZ7EgvE98eoloKDiuEiXe7VYDDPjnhWqaLrBj3Pso8oBa2kzCGD+1Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAYJlXSXFIYVOa2Ihc31xglHWQJh1T5CMtuOYiCKWZKcogMxKh
	oma5Zl0TsY8F8NHsxyMf+5T8KwIf/qjAvbGGHaY9qUaqGHWkTYhq
X-Google-Smtp-Source: AGHT+IFa/o5P0sWqycj/85Ak8c7rm3mlx92GxwtrAUqvBzQi66wBS6D1TrAdoAQ8/Dc/n/6TaNpXWA==
X-Received: by 2002:a17:902:fb83:b0:201:e65b:500b with SMTP id d9443c01a7336-2050c497d69mr6929785ad.63.1724878007774;
        Wed, 28 Aug 2024 13:46:47 -0700 (PDT)
Received: from masingh-thinkpad.. ([49.207.54.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038556667bsm103351525ad.7.2024.08.28.13.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:46:47 -0700 (PDT)
From: Manisha Singh <masingh.linux@gmail.com>
To: florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: philipp.g.hortmann@gmail.com,
	Manisha Singh <masingh.linux@gmail.com>
Subject: [PATCH v2 2/2] staging: rtl8712: Calculate size from pointer
Date: Thu, 29 Aug 2024 02:15:54 +0530
Message-ID: <20240828204552.26790-4-masingh.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828204552.26790-2-masingh.linux@gmail.com>
References: <20240828204552.26790-2-masingh.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calculate the size from the pointer instead of struct

CHECK: Prefer kmalloc(sizeof(*pintf_hdl->pintfpriv)...) over
kmalloc(sizeof(struct intf_priv)...)

Signed-off-by: Manisha Singh <masingh.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
index 6311ac15c581..8ad4647dad2f 100644
--- a/drivers/staging/rtl8712/rtl871x_io.c
+++ b/drivers/staging/rtl8712/rtl871x_io.c
@@ -48,7 +48,7 @@ static uint _init_intf_hdl(struct _adapter *padapter,
 	set_intf_funs = &(r8712_usb_set_intf_funs);
 	set_intf_ops = &r8712_usb_set_intf_ops;
 	init_intf_priv = &r8712_usb_init_intf_priv;
-	pintf_priv = kmalloc(sizeof(struct intf_priv), GFP_ATOMIC);
+	pintf_priv = kmalloc(sizeof(*pintf_priv), GFP_ATOMIC);
 	if (!pintf_priv)
 		goto _init_intf_hdl_fail;
 	pintf_hdl->pintfpriv = pintf_priv;
-- 
2.43.0


