Return-Path: <linux-kernel+bounces-335227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C156C97E2D2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 19:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA33B21117
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22353839C;
	Sun, 22 Sep 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phewedz9"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C929406
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727027204; cv=none; b=gvDz6SMfnZiriex/U2pR3QQHZBAeEwfkNcLaL7gO2RfIkMC1N6EmepQJKyTjlYrfTqzBbHdbpZEWUxTZnAJJq3Smq40s47bW1WhVgV9UUbBOj4TOlBwcqHbjc9YGLMZxTV6H6I7QuzkSIIO3SmT3a660oWGU6nynrFqrJfsEdhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727027204; c=relaxed/simple;
	bh=yT+e9cLg5KAO0dTu4tupxiWtJbh7rtcCL19uffi9RgE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fyh6gs9n5sJcMfSooOZmmuNNqwZiW+ngLkop0nTwSgXbh4uHD2gw5/d7wIUL3WodDec3lk5y0XOpEQEJDQT/K1HgTf9J2h4s4RCMTQKisGLf19IbdZq/o9dxk6mlEEblPlRZzuDoLapUw6PrGcdmR2Ad9AZVoY3KswcoZSDihGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phewedz9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37a33e55d01so2689552f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727027201; x=1727632001; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnvWdvuJww5fvZzybivqOBV/MrLD4R7C4eLuYWt9SS4=;
        b=Phewedz9BjlAikKbrWeEEiHRB0GLODjO6HUqXT//Jt+oFcd8vz+5NoAdMTtdz8nrdE
         xPldcDqQGO7lXTgD+xG03rsPYjnuJH7Z3YxH7M2cjRiJAS+ahdqgfNDhoX7CmMFXfpds
         J0jtl+UMEJzQgXMQ7sKy1cPVXbHzmE7Z2LW1wDdD/o2+P29R2FvOjazFCwMDus7kMfKI
         cu5aOqb9H8u8k0WekOx89OTWYvZkJwkeSKFR83lHJyM/YPjBoUkXLe5hwAD/eDv9i9ps
         mFRzCeRo6Kr/Dcy7rvFZLOd48OxBjvAm/3/aOyFu/LDSFBlRSF0U19j18qPxRZPssqSr
         oU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727027201; x=1727632001;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnvWdvuJww5fvZzybivqOBV/MrLD4R7C4eLuYWt9SS4=;
        b=YirOhtJsmhpnUoLE8xp3jxEVSJToE9F97iu1FXY7JYgdMJ07Fy0tWdiz5i/b4gTFcj
         b8kcWwTvLcKNQrSNCSMeaYLY/VVXSVynITW1X2CDF/xfkzPwuPczMo2fBUHG4sp8CHGE
         BzAW5Wdjmx0YIOjIyl1Wp3C2m9cUJAXxJBYj68Zawtzj4bh18tdtOJVDYBWcvrxetBJn
         Gunl6t6rZy09WaoIYT1V0XXlVlj3ScSnYqjYnpelT1nTMGk5fkLewnhZoqpsVOF4FaWN
         ppTirPDG27TRUA5QXgCeTN4qC2wGCFotIWg9BUFetAVs+ohnGoTPt8lDGu589CzkiYYY
         NIRg==
X-Forwarded-Encrypted: i=1; AJvYcCUg3aPxH4w2YgaZFgwL7IYIkwO6jxYHTAvPZ0nwFDTz5y08hP94eFkByfVF4EOoYf6Ii2PPXAXrHxvcWzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN3vqRzd3pvwWbNBrImKs0ZaJQbZ/8zg3IQ5B2ZLgfnwouMocw
	wAL9R9KSoiE7spyBXpTPvau6PJmNylfCrekfhI5bCucm/qmLLt9I
X-Google-Smtp-Source: AGHT+IEAmoezQCA58M7TxZTjw6/mEmIIL64WX7bl++fzagineoSx+pCSZHhasoNQ7HRuUt+XEqcSwQ==
X-Received: by 2002:a5d:4488:0:b0:377:9867:9028 with SMTP id ffacd0b85a97d-37a431ad4dbmr4816905f8f.44.1727027200813;
        Sun, 22 Sep 2024 10:46:40 -0700 (PDT)
Received: from MacBook-Pro.local ([79.115.63.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f649dsm22543392f8f.53.2024.09.22.10.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 10:46:40 -0700 (PDT)
Date: Sun, 22 Sep 2024 20:46:38 +0300
From: Tudor Gheorghiu <tudor.reda@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Linux Driver Project Developer List <driverdev-devel@linuxdriverproject.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: use kmalloc_array
Message-ID: <ZvBX_mugFRQHMq1r@MacBook-Pro.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

use kmalloc_array instead of kmalloc with multiply

Signed-off-by: Tudor Gheorghiu <tudor.reda@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 408616e9afcf..a0f29fab3dce 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -117,7 +117,7 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	/*init xmit_buf*/
 	_init_queue(&pxmitpriv->free_xmitbuf_queue);
 	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
-	pxmitpriv->pxmitbuf = kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf), GFP_ATOMIC);
+	pxmitpriv->pxmitbuf = kmalloc_array(NR_XMITBUFF, sizeof(struct xmit_buf), GFP_ATOMIC);
 	if (!pxmitpriv->pxmitbuf)
 		goto clean_up_frame_buf;
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
-- 
2.43.0


