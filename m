Return-Path: <linux-kernel+bounces-322450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA451972920
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD3861C23DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B84175568;
	Tue, 10 Sep 2024 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC6x/GlP"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF9E175D5A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947838; cv=none; b=hCjr2BRZ0oZdswzOh0FZCM08JwqWAQ3rE7Fi48UBfzARtzNEQsaysT4Q0GvmjMJE5RHb2PYdzkQcA97yUaio390v3pfdLw95nJSjblkr5IkAXO+BL78r28ZIonl3E63c+TR4eayOL2v8tWx5QQLpyBU2R2Q7mDlt8TshLVjwgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947838; c=relaxed/simple;
	bh=GjD1+cqrYDDCv9oW4pmBoO7f61jaeoVA19IC4+k5neg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWK+WkUOXif2+aB6QGXLMREtrR+01gqWXc/w6fTS9I/brIsVheH/NuxFjCavc3rbFcDehs4zKoQW4B2VjrHtPJqU9AIFbRw7lV8aT7TlOLg3K3dUjgNBDf3pV9VTzfijtuEhpuvInwKg7raivS0DjJzvEgfSrf65mhwMiPu9uR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC6x/GlP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a83562f9be9so24441066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725947835; x=1726552635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tePldyBpNEa31DXvu0Aldal89bpR30+3gXC9Cqz0/Pg=;
        b=FC6x/GlPXjqv+SWPNJEKAbhE1Zp6NT5h9FkIKbqiZys4qRb9cY58yChi05HK5Nx+sN
         NuGUOnMqf8wFInghoFj+2f81IJ0CVfJF/0JOe8Aw3PebsdpHnMoscy4gWYhS204Jsegp
         T23nrJyyL5vQRe5ozWtIXtCrlkXLVbGu23RX53jBlvq+/ek7quJkpk7hj06ZrFYVyXMw
         nx87TaCtdIAlKgsP3bBX5sLtpnQEjvT2uqwSJUfIdv+UrPo9f0O8Iku+AwflxoXdnYta
         RsPWLVQaHCrzQ5jy3QlJwdDZdhWuV4YjWZph9MztqugpJ5xdEe1Oh0EhNNXoV+RxwZgo
         dGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725947835; x=1726552635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tePldyBpNEa31DXvu0Aldal89bpR30+3gXC9Cqz0/Pg=;
        b=EHo1cooJ6/f4howGs6q5CpEIxqR0id5oKmFILX5DljqL3ZpR641HVS0h8dEB6F+gjA
         UXXbGlToChld+tY5zPb/Rw05VgxlEzYX5jIuuzMvGAWhnWH44vD+tykplvV5rH2X9Ir3
         uNUHThzDELl3CXgwfCZv7Iq6sb+lHdPoh3YbJS4iF92ORBWoDqc8GOFdRgdnUJlDbwRg
         z0EJcOT339Y5Gl99cbIBMA4CjS18HDHLOUa/GqWWlyt6JyRHnxGlhLt0/OglDAJTknL9
         m/airV00Ukkcb2FPiM8EXRixcsqVHJSVyMRZrKQdBWro/Z/LlWsJylu4WmDxh1p0bA4f
         /4kg==
X-Forwarded-Encrypted: i=1; AJvYcCUCTtXJ7d3OdHFx94IIU00eSskUtazl+Gx/DjI361rprCbM23PKrMrNFoh4ANr535BJqfXf8hpt1R5+OWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXO4FB0VjgF9LezQ7nDTMxqztKVwEHyzpkpM/ogHVk2JSlA3Rp
	y7WQvTtncd9SIsFnbkKWM6cI2psNjB9IWVdMu6yQxiiSG8iYUOI6OGOMY92a
X-Google-Smtp-Source: AGHT+IHV4mjA4sC8rik5Mjnzo6idwKMvwTYeBLZTq5jHvy7NLw1Dt9UcveafTnEQ+1cqw1/YByl+Ug==
X-Received: by 2002:a17:907:9346:b0:a8a:809b:14ed with SMTP id a640c23a62f3a-a8a88856872mr967993366b.44.1725947835332;
        Mon, 09 Sep 2024 22:57:15 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f2a8598b80c2d4e9a813f29.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d65742sm430765066b.216.2024.09.09.22.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:57:15 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:57:13 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] staging: rtl8723bs: Remove unused function
 dump_4_rf_regs
Message-ID: <b660342da763d1e03c44f2b3fdac0378b077e6b9.1725826273.git.philipp.g.hortmann@gmail.com>
References: <cover.1725826273.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725826273.git.philipp.g.hortmann@gmail.com>

Remove unused function dump_4_rf_regs.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 33d27680a276..0edd7b6e4f21 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -42,16 +42,3 @@ void bb_reg_dump(struct adapter *adapter)
 	for (i = 0x800; i < 0x1000 ; i += 4)
 		dump_4_regs(adapter, i);
 }
-
-static void dump_4_rf_regs(struct adapter *adapter, int path, int offset)
-{
-	u8 reg[4];
-	int i;
-
-	for (i = 0; i < 4; i++)
-		reg[i] = rtw_hal_read_rfreg(adapter, path, offset + i,
-					    0xffffffff);
-
-	netdev_dbg(adapter->pnetdev, "0x%02x 0x%08x 0x%08x 0x%08x 0x%08x\n",
-		   i, reg[0], reg[1], reg[2], reg[3]);
-}
-- 
2.46.0


