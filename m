Return-Path: <linux-kernel+bounces-444529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ED99F085B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19EAF1691FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AAC1B3943;
	Fri, 13 Dec 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wqX9myFf"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5091D1B392E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083254; cv=none; b=VT3wwfgLuzhULXF5DmTSfBgGoZsGrw4Hm2Ztd1Kdt0bfAMqiZHOkwQSlfM2btP3jsVi8fIvnQwvZpVEv/1+QorbVUt7Ss/GI8EcKwdh0PafL4qQbx6WTP/Tytj7rOzhemLt3njdKuJkZUG6vpBHCPN/+we/3tchHug+AVUqsNUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083254; c=relaxed/simple;
	bh=QftEkgPw/0GI0tdyO/fV+/Wq6wLc69fz7Mk4V7VnBf4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qFCIz3WJ9LIxqv9WbZXeQmFcXX8budc5RIdXTm/+HF8vDGLtnM4UzE0Rez1VOrLzZf6kozzEKDSEDx2DuDry3YuXxiYaVsbmCHhlKnxRFa+eNw5ZRP3/sda5abDZGpOSY3RxHLnNgDPACCKpEsvdM5YFEL3YBNpOjkAi/DV+VGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wqX9myFf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so204976666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734083251; x=1734688051; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rdxFYaYZsFwA6EnsM4K6iSZW6gjULgohyiFusWzHRuE=;
        b=wqX9myFfGq1RC5tbQJD7JL0OKd4Xbtx3irGbR2FR7CjeHh5YUUoLRZf/3G4Igx7EgD
         YS2F7+bDyBoAbimKmbco76d1K03ooFDYvVO4rsUvZZhlpnnQgA/L4CX+IGC7UsZCvGuP
         B6uOLcit1bxqK47Np9dp3jYtJQJ+B5FbeNwmOGmconQjCwWjxcRidQSSq+6titNrHvF/
         tGGmITnkGYO2RN06J6vJZfdJywPzv/6jFNlL6lgnicWJghJ1A1AlcFS+gSVcN+4YeeIZ
         Q7gbXzQgaMBhB7eHhO7Ye6n8YWq8zpxG0lfwui74XS1IxZs4epXQwwhQvIjTrLg3EhuQ
         g70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734083251; x=1734688051;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdxFYaYZsFwA6EnsM4K6iSZW6gjULgohyiFusWzHRuE=;
        b=uvp0wU++so/kS+HXGpWJ41ypvjvzfiv1hlWk+IxDEvEppF0OKbY33HxI/1Go2PT7ZO
         KRccDFOzbLS3QQV9kZDnd9iQ3BuWA1rnXuXJD4Hs/hZbDKTW+368wZeR167jgRJyZ9nH
         VSvXU7hidUzpXZ+p0c7+pHsyKq4fP/13Isv8VW+WNjIA2mRaX3tP7cZrG6KNolUSXMnQ
         dOOHWUJmhnsE45Fvgd6+jsnDOX8Oez9LkTq4Kl8VQrVAF6htFTaqZk5stIMJIT0NleNK
         r1Zu2CZXjcvoeQnQKgWLb1LmAVR6hwAoaF8SvaLznV+rK+JlcWmfb/63IR1rsIhyeg7y
         HJqw==
X-Forwarded-Encrypted: i=1; AJvYcCUkexLQNb2BzU5cfvDfoBWPgt4W5Rc19UywR4NvHv+rkzX7kUwWCMIGlZ09U8IeUOx3XZC+j2+aVUnvwng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7SyScJr0nFWu+W8s/l25a00PGL+2ROoWr1PUtdSj9bMEJ/Qy
	y3064dGosEjtzmQnX0cRYssnIgnk+jMPi9ucYKFi4qlJXENZlgeq74T2Qlt7XlQ=
X-Gm-Gg: ASbGncuR3zFK0GGZ268w0yHa6jhxJtkC2mCoN9+MonxuTpOhkNozuWdBSVJKvKJABpV
	g45oREL/u6VHnPUrVL8dwWNl2gE9bsj89wAcggGlYyuYO16+vMawTxMq3NVeYIiSSwnQLceGiCP
	zJCiT0RrpCbRwBpwFRcnTmuYF42QbNUajcArM2P66gKRKyjX/3vkQAoSnH/6tkegVFaOp1Um7JC
	Za5/3RMINoYcGixdJHghu+HDT5R4suz3TP/GIDBku+KLGPkkC9qmG1wv8k4tQ==
X-Google-Smtp-Source: AGHT+IGltlAdrz0s/05wujMEiapProTMuSaTetpEvSQ5pgYx7uxayECdPRY4Y4KRwu3RO0NYkPh3qg==
X-Received: by 2002:a05:6402:390a:b0:5d4:2ef7:1c with SMTP id 4fb4d7f45d1cf-5d63c3db8d9mr4114411a12.24.1734083250584;
        Fri, 13 Dec 2024 01:47:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa671136c3esm814037566b.7.2024.12.13.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 01:47:30 -0800 (PST)
Date: Fri, 13 Dec 2024 12:47:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Atul Gupta <atul.gupta@chelsio.com>
Cc: Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Zubkov <green@qrator.net>,
	Simon Horman <horms@kernel.org>,
	Michael Werner <werner@chelsio.com>,
	Casey Leedom <leedom@chelsio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH net] chelsio/chtls: prevent potential integer overflow on
 32bit
Message-ID: <c6bfb23c-2db2-4e1b-b8ab-ba3925c82ef5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "gl->tot_len" variable is controlled by the user.  It comes from
process_responses().  On 32bit systems, the "gl->tot_len +
sizeof(struct cpl_pass_accept_req) + sizeof(struct rss_header)" addition
could have an integer wrapping bug.  Use size_add() to prevent this.

Fixes: a08943947873 ("crypto: chtls - Register chtls with net tls")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I fixed a similar bug earlier:
https://lore.kernel.org/all/86b404e1-4a75-4a35-a34e-e3054fa554c7@stanley.mountain

 .../net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c    | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
index 96fd31d75dfd..daa1ebaef511 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
@@ -346,8 +346,9 @@ static struct sk_buff *copy_gl_to_skb_pkt(const struct pkt_gl *gl,
 	 * driver. Once driver synthesizes cpl_pass_accept_req the skb will go
 	 * through the regular cpl_pass_accept_req processing in TOM.
 	 */
-	skb = alloc_skb(gl->tot_len + sizeof(struct cpl_pass_accept_req)
-			- pktshift, GFP_ATOMIC);
+	skb = alloc_skb(size_add(gl->tot_len,
+				 sizeof(struct cpl_pass_accept_req)) -
+			pktshift, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 	__skb_put(skb, gl->tot_len + sizeof(struct cpl_pass_accept_req)
-- 
2.45.2


