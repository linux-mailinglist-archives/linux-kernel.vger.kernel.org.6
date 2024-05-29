Return-Path: <linux-kernel+bounces-194078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE84C8D364D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F290A1C220E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3470180A91;
	Wed, 29 May 2024 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUl12+jB"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0443B295
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985413; cv=none; b=iEIzyoi8GwcfyB2u9LZjabqAKaPJLdEIuc+XuL+pOGVESPIBEWObjNAJbTmZlBNJ+t3kA0nMYPjXWky+jEuFQkQ46U7UIIAgq9yApMWLsjzKgbZcwgZqRS4o06m99l9Rttx5zAfIXZda1Llw+6rAlsWRSdm8y8qbqPoGxZKGlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985413; c=relaxed/simple;
	bh=SFsdFGM1tKYQjt5FyT4kYb2Qr9hSQyKl3hmka6u3AM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UwjkTisj1IeurcMPd/9ICJkEx5Zhl1PkSvt2IM8OC3pGLJs7SB9CVClkZTJmuJeNLrxMjs57cNHLakZXiphsr917nBHuQ6K0CW61GumpuRkLbodbw20ZOWaihLbX0x3JTeqEMRWZGL+E1RzQY1TZkHEzSoZimAl8iS2YMElHhqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUl12+jB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-65894e58b8aso1456746a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716985411; x=1717590211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu8X2LCUalqzu3Ya3NkSgnwgrwDIZEosx1eIzHQjc28=;
        b=nUl12+jBNxcKbDgzGtFZNYSQJFjwct7hD+x07oprx3hG30phMwzGbFiHg73VbyyoP7
         udbdlLPgjlkQHWdrh7hKJNOQoEhma+Fz6pDg2f30O4GJGPgoV2tJXg80U7kjbQ918nAQ
         0JExZ4qcFjew3KQewfiSp6M7HO57N5WaYmz2bqbkdJ14DqMWMP015Tjz/SFZQSPVwBQW
         TwNozyHdpK/iLh6SZazQMyxINCP8RRnFCnvyvyPBEEL0Plgt7ac0TSNQ981zXYqlCNqF
         l0zkr3ONjsHcFSXbcDVr7hDv214/f59nZa7U5ye/oIU/kmccEVxDamGuTAFCn8I74VDA
         YnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985411; x=1717590211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bu8X2LCUalqzu3Ya3NkSgnwgrwDIZEosx1eIzHQjc28=;
        b=LjELYBzY58mysHb2F7gju+PFbS/mvFZd1x2UTHe2gXTlU+CU65GQkuO8v91NAfIcGl
         kngxnlxJfV9sPRmLrGHTVZ1ret6R/qQqpbOkXm4u3RyDsmZvyAjCWe/YegL/6C762cdO
         /goQTgzNwLOVZjsppzI/epXT9R26A8ybv+QiCWieukWTKMpOtqm9/kKuVBX1A1GTrgrI
         T10zF5RtN97cPyh//bgcy3koVKyl3W/u3fnUlP+knybKOz2KE74SlwLXzpUDRTXpBUM+
         fRpXvQPgpeoh8eGxtoGCF2p8lnSxmTRKiO3yitSCgQDjR53iZKFiIGSlSirID1vpP+VP
         +zsg==
X-Forwarded-Encrypted: i=1; AJvYcCVbgKyGeDKn+rCzHkBHh2rr0wiRUneSwpA7kUXvOqo2E4v970ATI/Ykfwkik4w1jOK0Ad1IPgn4TlIneEfXEY59Ktnu75UldDvg68i0
X-Gm-Message-State: AOJu0YyJsNo/klkN7mA4XKx8XKc9TgjXaFOu4gkvTVf8Y7ECbO9BkWvQ
	3Q68qjXFEHU/osnMHcilP30TbB/B06EFnazOrfIS5lOgYdDTfyn2
X-Google-Smtp-Source: AGHT+IGpop5Rh0Gl6NPGn+yzSeNeXcyhhaZwMs48bAu4Ha451DIdYSt4ISyatz1BTqz9iqNA8XPlsg==
X-Received: by 2002:a17:90b:46d3:b0:2ae:7f27:82cd with SMTP id 98e67ed59e1d1-2bf5e171f8amr12877376a91.7.1716985411004;
        Wed, 29 May 2024 05:23:31 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f987248sm9399359a91.44.2024.05.29.05.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 05:23:30 -0700 (PDT)
From: yskelg@gmail.com
To: Stefano Stabellini <sstabellini@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: skhan@linuxfoundation.org,
	sj@kernel.org,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] xen/xenbus: handle potential dangling pointer issue in xen_pcibk_xenbus_probe
Date: Wed, 29 May 2024 21:22:33 +0900
Message-Id: <20240529122232.25360-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

If 'xen_pcibk_init_devices()' fails. This ensures that 'pdev->xdev' does
not point to 'xdev' when 'pdev' is freed.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 drivers/xen/xen-pciback/xenbus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
index b11e401f1b1e..348d6803b8c0 100644
--- a/drivers/xen/xen-pciback/xenbus.c
+++ b/drivers/xen/xen-pciback/xenbus.c
@@ -54,6 +54,7 @@ static struct xen_pcibk_device *alloc_pdev(struct xenbus_device *xdev)
 	INIT_WORK(&pdev->op_work, xen_pcibk_do_op);
 
 	if (xen_pcibk_init_devices(pdev)) {
+		pdev->xdev = NULL;
 		kfree(pdev);
 		pdev = NULL;
 	}
-- 
2.34.1


