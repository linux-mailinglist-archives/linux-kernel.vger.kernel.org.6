Return-Path: <linux-kernel+bounces-558195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E8A5E2B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03AB1899B06
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8905258CD8;
	Wed, 12 Mar 2025 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="troX6rnO"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238F2580F3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800081; cv=none; b=Dsu88vLNkbQtOO0d61lOkuqnzi4LjBE0GYZN3Wo5VkGhjKpWb47ukEwmEE3bhMNoH0YCbrFbZ2R+jr2QVwC3xE/6IU9t0PlFFU6mX52xPjZGfPdDkqPgzKSgsMJ05N3LS/Q0wlEt29LMgHUrrdiArp4XacnYSRgFW8k2t0NN8/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800081; c=relaxed/simple;
	bh=wjnq/u21AuKdRgrNZm75J0lF8ufWmfGo4o4NzXDo8ds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cI5m7mssFIg59mJaESQvBpGLG8h0TfMNQCyzXGsdXJ30H+Vu7ddFPOdUhIVNqHHfYQbtUYuXHkR2wI/ShOd7Rg3lECPZINdNnHlkqgV59LPIuhanK1hoIjl8dU8eANV032xv5PXXhhgr4hQBl2JX4uKDx6BOQYHoxd7FIzrisfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=troX6rnO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso82613f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741800077; x=1742404877; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HB9xS8FxfigF4WYPPRbbcyxASGClaI6fGW/tpj8nUVs=;
        b=troX6rnO482hE4d2rEQdQiinHkcPuf3jS4eVdVQqoSyMj84BMwyxpA8uIxZF9E9ic2
         Qk/dvynGMlLj16cBYY70WyHusatcx2/362aLln3GnrnYlvdWRxckWs53pMKIcdYFH435
         l4qJT7p6ytgpdWwlN+CcU8VFUHHl935bxRlbJos2BRmL4jPdqLZylrk0VoSNwCbUiAFo
         03N4zhciH9p+DB9oRUXcSKtsu0t+7iIPWsW7YE+zrg1+JYsczy6JUaUrbsL6FY3ip3q3
         OxY7FtYamqGi8HmskmjwY8lK/Nm+A+Ylrb6d217HixvV3OCYCZjyfJsb93IF7vtN+MiP
         INvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741800077; x=1742404877;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HB9xS8FxfigF4WYPPRbbcyxASGClaI6fGW/tpj8nUVs=;
        b=vlXiyidc3gykzxbQ42+x2LYSipMV5lp4NxB5VRbMpdAILG+PcnxGRDuLXVrskQMd7W
         oEWenuw22EkSCl2F0zTe8J5ahnhK1Qx949mKIZvcNW+As/mUwVwAQwvqdm5+vbx1ZcOL
         O6zgMvDzoht5fJc4QdT5MXMouHUduYkHQCUCdnIIrfQkwgmmhYnmLOFPNyS6oS+KFmNu
         Wb9kuDA2GGouCFYiVdVjwujSjfK95EdDR95zYob+p6q+VgWAA/p/KkkghSlSQB19DkKv
         8abomVv3AksyFMUlU1C5SqD/64IE6gQsDIBhPk2Jk3TDPFHSL+EUOox+ELK1SqBF4flX
         jXDw==
X-Forwarded-Encrypted: i=1; AJvYcCUFc5FxtiG75r8M+AcGbB4pPKGbUKM550uvc7cjQHUIngWvpiRQlcKjGkkUvR6wieyU9GT0LCKda71UpWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycSoh123ovScGeCiXlYNvn80yYexruTL+aWzgoJe+k2LDf4mg/
	a5S/Ays0XoM/UQ+gntKzwlNDAYrnpzUfZHWU68l9SstGf8uhEFkl2+QEgdmyYus=
X-Gm-Gg: ASbGncuhDIGHGwRqoeQzNYpF5Jb2UR/K/PqP+mzCaLKy2tzCI7y9hMYb6M/WMIZxP+W
	Jxm9S2vYXTKATPH0zoIdSLPk43v/pm5OpPGsPgV5n5NmJaTBNHGvY+I75ClX2vWwMi5bQz7mBG5
	rkxOkMTVL4wE/DvTeIcFjNqMJpKmZ17ZiyIFZ+LUobX/d0BNYi+eSLiwn0jh0RFQdeOkfb7t/bE
	zL8l82MgGocJ9S22L2h7ejDtwVUwFkZBos/xsW1CNbnB2Ad0MD0rQo0rr4rSu4ap4GE7BNkqBO7
	uM8+FmylakQMxF9HskKafvRQU/Aibj/awEZAPpm6Rt3vQf1DOQ==
X-Google-Smtp-Source: AGHT+IHj/Sj6ykxoYXb50k6xZbXFvzcbHYh/wf0blrf/4M8wSJId+CUZ1HfJtS6QVZFmpy/JDyUI5Q==
X-Received: by 2002:a05:6000:1448:b0:391:487f:280b with SMTP id ffacd0b85a97d-391487f29camr12619009f8f.10.1741800077411;
        Wed, 12 Mar 2025 10:21:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0e2bb7sm21940643f8f.63.2025.03.12.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 10:21:17 -0700 (PDT)
Date: Wed, 12 Mar 2025 20:21:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] xfrm: Remove unnecessary NULL check in
 xfrm_lookup_with_ifid()
Message-ID: <2eebea1e-5258-4bcb-9127-ca4d7c59e0e2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This NULL check is unnecessary and can be removed.  It confuses
Smatch static analysis tool because it makes Smatch think that
xfrm_lookup_with_ifid() can return a mix of NULL pointers and errors so
it creates a lot of false positives.  Remove it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I have wanted to remove this NULL check for a long time.  Someone
said it could be done safely.  But please, please, review this
carefully.

 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6551e588fe52..30970d40a454 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3294,7 +3294,7 @@ struct dst_entry *xfrm_lookup_with_ifid(struct net *net,
 
 ok:
 	xfrm_pols_put(pols, drop_pols);
-	if (dst && dst->xfrm &&
+	if (dst->xfrm &&
 	    (dst->xfrm->props.mode == XFRM_MODE_TUNNEL ||
 	     dst->xfrm->props.mode == XFRM_MODE_IPTFS))
 		dst->flags |= DST_XFRM_TUNNEL;
-- 
2.47.2


