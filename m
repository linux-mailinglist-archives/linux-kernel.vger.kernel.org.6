Return-Path: <linux-kernel+bounces-335246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9789F97E30B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 21:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA531F211EE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 19:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D349631;
	Sun, 22 Sep 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLrmFxLX"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03D2F2D
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727034080; cv=none; b=dC/xsZ4nOwd6XRtgQvJK7DaRodCzIC81MsmvfqGOFSYl6BRdftFaEzXknXGVjlh15b31pUuhTx+G2pHxgH19IWlg6V19cMom19lcBVZ5jNbayGYYQHQQC+U/QYI+7L7JQfhRxpTzqj88ArIxWmmFoIFoVqiwVU3jsjTBc+IpzkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727034080; c=relaxed/simple;
	bh=pse7K2BaMu2aE5LI1j2rQa3cafHBfIlygb5qm7lvpxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NKKOlQSMWcwvglRT9+iVOdE1stN0boMcJ7XMGccpOEcO9GJd5EeW/gSenigBrO3xOfQj65o6ZKDJivg7Ij8fe3z2DAzeIoLaP0A1LpL5xcICsDYcrYse9JLMiwXpuoYl/nZP6ZkQC2a1QZ/R2P7+WTBrDfCps2NCoxmEMjcGsTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLrmFxLX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso46985235e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727034077; x=1727638877; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdOsRVJOv+qCDZ5vFVWSC0So4+sCV1euWD4zZOd815w=;
        b=PLrmFxLXq8y0A+Eym4e+KFcrGS5ijHl0LPPElOXvbZwCzbmsPjo2MqWvYLYULa36Rb
         WnUwZgx9kCBeT8r+75r7Qc0lFyDA5KQ0Cwfm3czQFoU4Ya1rCj4P+S6wnvs8biNKaEkv
         Y1wHcUcv/GEdnM8w5TnVRJuOhXmuZdEPrJrJyUdFj07nsKBlbAaygQhg/+5ml1cTuNE/
         ESdThXKM1tq781H95U7RDAFdHJfj4i82FrW4O4xSLktq2EZ6lMVfgaw44ytmv0Me1LHC
         SMpZHKsauZy6gfR0iVHgXbboXqvw6TvGwLD7O22mnHEgt7/bFVr4JyXi0Q9PBFg3b98I
         ty9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727034077; x=1727638877;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdOsRVJOv+qCDZ5vFVWSC0So4+sCV1euWD4zZOd815w=;
        b=EKVRNB6DRza7m64lRyV9fCiKQ+Ey9OInRnh1eKMhnD7JkjVgizz72+YXNrc1l2NHG/
         wkNyakRycJl+rjCUuUdJkdYFlIXuZ90aGPquEFx03/Kk5nbEQ86dgiy/RYSP56VGnDAN
         1QZwl4OW/gb1kCwG0zWqVNArd2r0pMMvRn1gdP9z1vm6hJRRzGEcV3Djg19pHWTMV3gi
         bNdMWO1YSiQAbLIc42dPiTdLPWbG1UwPF/UhQrfRd/vv+xQy8lyzlVZnYqBeAzicFER1
         RqttMIhskMTtGY3EnxBb031WIbmwLKTifPGBp+CIh/EEeqHoqaUskHFAG+3oDifJX+oD
         tIfg==
X-Forwarded-Encrypted: i=1; AJvYcCXVA3dmhrTUhELorBsMFZccbZ3SKh579PLgf7frnQao+U0q/xPdO7G+Yx9OnfcflUN1M/njdI1sLcjPqS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4hmusBSx6PdT1C9ae4HR1MqqNXtbvoYV6SZCUHlJs37qvoyPj
	71D9M6otyAtORU1xC/gAg+ZQGvLBI1p9hpF92OpS9uzn0c23zwRd
X-Google-Smtp-Source: AGHT+IFrDmRddqyKmVVU/VMVZubH681CkPHQIvvZAySlGFypDBscZvtqR9eBRJfDHu1Szn35ZtOvdg==
X-Received: by 2002:a05:600c:314c:b0:42c:bb58:a077 with SMTP id 5b1f17b1804b1-42e7ac30863mr97223205e9.14.1727034076607;
        Sun, 22 Sep 2024 12:41:16 -0700 (PDT)
Received: from redaops ([79.115.63.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7ae5fc75sm82341015e9.9.2024.09.22.12.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 12:41:16 -0700 (PDT)
Date: Sun, 22 Sep 2024 22:41:14 +0300
From: Tudor Gheorghiu <tudor.reda@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Linux Driver Project Developer List <driverdev-devel@linuxdriverproject.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8712: use kmalloc_array
Message-ID: <ZvBy2lB_ok_OCmVI@redaops>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: Prefer kmalloc_array over kmalloc with multiply
+       pxmitpriv->pxmitbuf = kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf), GFP_ATOMIC);

Signed-off-by: Tudor Gheorghiu <tudor.reda@gmail.com>
---
v2: Update patch description
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


