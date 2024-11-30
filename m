Return-Path: <linux-kernel+bounces-426169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75F9DEFCB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 192D6B21BDA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB9155336;
	Sat, 30 Nov 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXY3bTJa"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5C14D28C
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960904; cv=none; b=FgJx+uRa95U3FkttIeCcaNHJ4MzO/QOGRyoJcOWuegkRRFrnxbbQ3aqR+fLXN9yEXCcy2/hIUkUr7rwqnCyXbwzT+d2dDBS2gf95N0wGOcyJW+fHR5EhaE4KE8cCz74FyOTDGXIxwxsi3VAJile+mECHADL6DZOngDE5F6g9sag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960904; c=relaxed/simple;
	bh=SIBkMDM9PgjbFAyR8EA5YSQSJxCLhTUPXO4IfXW4hxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b/m37dVSO+YF7uYezxcubiljIVKd6SbnZqOQmYfXlDeeFnXvKAzo/KZBfeDgvJaQgvWsNrrAMBERH83zZ+1sibT+Lkp/P95N7fT+XOkPOAxXW9uPak8akGCLP5EPV15LbYx4JJtEMVgdjw7Iq6gWDpSfoXrn5nUDueo/IGQ+jcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LXY3bTJa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so3003627a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732960901; x=1733565701; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gI0rRaj3h2iBiBAn9r1ZitfB9ykqVmf7MWwf3cvySCI=;
        b=LXY3bTJajK069OeOXmcH4TERJntYiYTHdfzKYaSPfOBG7gGyEX5hJw0BCwUSEBOu0m
         jMBXCzQ0WqpllbX36EYDR2r1yJABe11sJcH/cO9L1bxoACo+0sUqJcoHdGhppLppr7MP
         98b6m2lJ7X6L1m7ou8nXwNYmJXhJUqnXuzPGYQOs8JFOC9xsv5OwTKmEL7W4Hx8n9HSS
         SgBXocONN4dVhs43GA0x4c6Ei1RGFZ1Iacx9YliDpBAKM4wEtzz55bIQ2bkfKCJFoOEL
         6v+1cANgeDDsS8TXibQDrH4gHSETrRVlj+uoF95WHEJq+SMMAkM9+hJMAtM5b4BRXtcK
         Bk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732960901; x=1733565701;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gI0rRaj3h2iBiBAn9r1ZitfB9ykqVmf7MWwf3cvySCI=;
        b=eQ6O0zNabqmWPgWV2Qt+DWOQVa8UWNVVnZ1jOEswzV1krCySscyKn6Kz3rYJiZhtfN
         cw4ed38XzOymgPKUa9zB89cq4sK+g9qZlXmo5MmcGW9RoTRJutchJRXXnKVMhG70+n8g
         2DnKxFW8r9zxir4W7u1Ct5AfULwiKdFV5wDDQ4mH7VTu8AO1V2/4mAmf+P0PzxeMD1KE
         qVwkomv1L2WjosMrwJey/XfJiTfnFcLWIfD3zPmJcRb0fqWeZVjitW+58TJmRanypaRO
         LdQFKnXPpVA5Lksik3uuFkZ9qjlK7ENT6+UUY2/KI/nuNK6UsvlLJmhc4jtrgoAsmKC3
         L+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsXfpSHoGaHNw2Dm0RbhGL6SsU402x75uLcMXXIwu0mXWTG3MDd3xEuPrZNCO8vM2YfxM389dmu7GFksI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNeUBUqS9o7euhwFQI0JiuCQS9Gg7b6l1Fk41ix4YLfAcZqZr
	qrWR+IxVRkodOG/hvQWU4dzgfNbFRrV1D56Ki/mcMD9IeL/bauuVVOlTnDRxw1s=
X-Gm-Gg: ASbGncve9yAnh9qEnijq8NixEhjbsDc9u/49b/uCR9l/M49nYROqDYOCbXCa/4nZkKP
	0PcPMod5i55PuWRft8PQBTzITF5eo46jJd6hiNuNyxsHkX6qVWUqYMOSXXkbrsTNrhUld1BkSBG
	+Fd/hCkVzZGlMjGcMCIkLNRV7uCINY5kRWt0ISE9KmJf1cV/jONjhRjZXeJrhR6/uzjWhWQpWNA
	1k3xqnwJ5VLcTaKA6n0MPAUhaBgYGlNRdWUkacnUMDCRYkW8aB3aJQJa/VUzxhS0mQdU3Za
X-Google-Smtp-Source: AGHT+IEFpMg8pm0uwYaiFZHM3DW/3ch6uaXaKn10ANQVIeghH2SzJao+XGL30yqtSajOxrJ4Wm207w==
X-Received: by 2002:a05:6402:1d4f:b0:5d0:840d:ed04 with SMTP id 4fb4d7f45d1cf-5d0840deeb0mr13550421a12.8.1732960901059;
        Sat, 30 Nov 2024 02:01:41 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0d0a026e6sm222374a12.80.2024.11.30.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:01:40 -0800 (PST)
Date: Sat, 30 Nov 2024 13:01:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Atul Gupta <atul.gupta@chelsio.com>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Casey Leedom <leedom@chelsio.com>,
	Michael Werner <werner@chelsio.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cxgb4: prevent potential integer overflow on 32bit
Message-ID: <86b404e1-4a75-4a35-a34e-e3054fa554c7@stanley.mountain>
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
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is from static analysis.  I've spent some time reviewing this code
but I might be wrong.

 drivers/infiniband/hw/cxgb4/device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 80970a1738f8..034b85c42255 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -1114,8 +1114,10 @@ static inline struct sk_buff *copy_gl_to_skb_pkt(const struct pkt_gl *gl,
 	 * The math here assumes sizeof cpl_pass_accept_req >= sizeof
 	 * cpl_rx_pkt.
 	 */
-	skb = alloc_skb(gl->tot_len + sizeof(struct cpl_pass_accept_req) +
-			sizeof(struct rss_header) - pktshift, GFP_ATOMIC);
+	skb = alloc_skb(size_add(gl->tot_len,
+				 sizeof(struct cpl_pass_accept_req) +
+				 sizeof(struct rss_header)) - pktshift,
+			GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 
-- 
2.45.2


