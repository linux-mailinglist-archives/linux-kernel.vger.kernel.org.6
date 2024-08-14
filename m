Return-Path: <linux-kernel+bounces-287201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D86695248C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3028928408D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F431C825F;
	Wed, 14 Aug 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGiOsIRo"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136201C9EA8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669934; cv=none; b=kG3k77t6mXo7PS/c0bp4Qwlt/tTYjLa3BUcpSWayJPtqHW8A/MWtitm89+Ecqr9+rv1Zwp95enecROSEmD+Nrb6OT2X65YVO9q8WCeAtcyHU40iqGmqiMVG1eqIZdn6L0UnF+oYz72o2nhvqt8f//pLS9h1t8DzyWElxHB0J104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669934; c=relaxed/simple;
	bh=NrYy3KCJ93XBrlv0fDajDdUpZNCCuP92065pd5XQ7L0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Y1aJ5rCUQ+vKX0GnPIWD/NAd1NhVQ48zxenNsKIKQpjhJFK4UDZsu9L0GUZjiFuR7ScQ7K17yA68BFTY3t3KWfhvZmfhJhDjf4s+l8HshbTeAsAuMT8K2khENqMsf+WLXmxcTq6qrO+xxHJ8itj3ZQOF9GogInK+2z2pMT5j/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TGiOsIRo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428fb103724so7481535e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723669928; x=1724274728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvinTXy1Pu55Z1s2JUlMWc8o/CYhTf2Gu4R5avb3VKA=;
        b=TGiOsIRooyHcS0msmiFeN891Da1wTkpXIWki0edp2EJhLLJ5MfAF2+UaqSC7QZqsjq
         P4pG3F4eXgjKsYFGFNc8arEneEmNwa2Sk9X+2G9pkyhO84FPDWYW3MI0ykjj/ZzReNqx
         Porr53d+ZJxTxO6HUganSeTyl0D5o0hutV1elxJW5L0KjR7JZQOrAS/7x0bp7WuCID4r
         I+XxvjEgk+0K8kqORFkKnCfB7H85kEglUhfwVAH8zA9b88YTdK7JCd18LbfJoYpnF5o0
         Rz7QnFMOX7h4UlWrQ0LjfDy3GZPaGINO3ymfbvcoO4eI/YHsPdKQ8trmkfCJUiMauFiF
         leWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669928; x=1724274728;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvinTXy1Pu55Z1s2JUlMWc8o/CYhTf2Gu4R5avb3VKA=;
        b=J1EBk6AIBrCPx2c39Fg0jJQ69mQsHod9GGHlp27BZYVtqcYkJZBzhLTBgSB9LQUaCx
         nuxTWmb8vFQw+BEb/OQIExBlcEPra1ZKpyF7U8KxnJdmJB5IbO+dPHvvaLVqOmQ9dDJn
         X54wQ9nLJrO91hf8JXr+SFdYMwJWrmrbXxLshHRWGcGRxB2w+s5MwVZpHGgDJTjBUH1m
         YWqIwtBvR/PdJddydDKRbgKi93CemuWffhv/+VBuaOrOqaURWX4zMJ5dCdR+oevFYb4s
         wDPi+sIhFWCCLgfSxoCP0NA0vaU6yBi445MpAZEF7DQ8RcWwL3+/g7S71VskEDvMFIqx
         oONA==
X-Forwarded-Encrypted: i=1; AJvYcCXKddZjpI0eoMwRZTRB+um0D0T4tXgF2F2pnlHLWTHgRKEaRH4V3Brsx2/gx5AG/GCzx5xsznEmVd/5J92x0X3hm83WL+bN0SzKO4Mf
X-Gm-Message-State: AOJu0YzNTN1c8WFsKoJWIwDTwXupHm+Wqx0TviU4cBG0WmcWY81QHdbH
	rQiiGZTQdcpYoxHn1g3tWMMEaAm3INP7hN2tQv2oIXW78CVPaD3vhFNtXtS4yRrkwbSMWV4EidH
	T
X-Google-Smtp-Source: AGHT+IH6g79uU3REsY1aYPRVUa3GzDJE31zY/2sWg+HmnohPnve8H/2pByk8jsfDM46XuWz95tP5uQ==
X-Received: by 2002:adf:e609:0:b0:36b:ea3c:5c00 with SMTP id ffacd0b85a97d-37186bea9a7mr629717f8f.9.1723669928337;
        Wed, 14 Aug 2024 14:12:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7e1c5f2sm1477435e9.40.2024.08.14.14.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:12:08 -0700 (PDT)
Date: Thu, 15 Aug 2024 00:12:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
	Ruud Derwig <Ruud.Derwig@synopsys.com>,
	Bhoomika K <bhoomikak@vayavyalabs.com>,
	Pavitrakumar M <pavitrakumarm@vayavyalabs.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] crypto: spacc - Add a new line in spacc_open()
Message-ID: <6e603578-2250-4ace-aa43-818b8f23e2e9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c12622ca-923e-4aa5-993b-36cee7442ed2@stanley.mountain>

Put the break statement should be on its own line.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/crypto/dwc-spacc/spacc_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/dwc-spacc/spacc_core.c b/drivers/crypto/dwc-spacc/spacc_core.c
index b7630f559973..b9e0d3227f81 100644
--- a/drivers/crypto/dwc-spacc/spacc_core.c
+++ b/drivers/crypto/dwc-spacc/spacc_core.c
@@ -1904,7 +1904,8 @@ int spacc_open(struct spacc_device *spacc, int enc, int hash, int ctxid,
 		ctrl |= SPACC_CTRL_SET(SPACC_CTRL_HASH_ALG,
 				H_SHAKE256);
 		ctrl |= SPACC_CTRL_SET(SPACC_CTRL_HASH_MODE,
-				HM_SHAKE_KMAC); break;
+				HM_SHAKE_KMAC);
+		break;
 	case CRYPTO_MODE_MAC_KMACXOF128:
 		ctrl |= SPACC_CTRL_SET(SPACC_CTRL_HASH_ALG,
 				H_SHAKE128);
-- 
2.43.0


