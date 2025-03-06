Return-Path: <linux-kernel+bounces-549769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A2A55717
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068423A6584
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6D1270EDA;
	Thu,  6 Mar 2025 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVyteuIh"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAC81FC0F9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290554; cv=none; b=NICUDcFQZbeFYdmMGXNGYRFvrcCJ9SoJ7R07cegdq3jaqx2VJmNTz1JT63trb9fnVJNJEr46k3WVhOrPbJn734VBYjEmE3brJRIv1XfYxFUWyKQ8GXV6FjNC7lXAIGc5JHghEYb9Aej9cKaxExq4ixMQjPb9kxCbdJ6I/e++mqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290554; c=relaxed/simple;
	bh=XJfj2IjX+cfbBfCUZB15uM51uhBAxMUtheYDfRvrsG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H2oyjEGc96jiJ/G4M4Z6z/fzrL3F3LZ6bydMFmcHn/70i5P+kLgFmo1Vi8jugH8mv3ELl5tuNAu8Pxar1aH92XjnMQyAS5EWAZaYTJeAgO+dDt555PRdqzYzNmcB1Ja90wJwBWMtlIUbNZuFyHMDwSRW5NN23EhL0I4f2Nl6eok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AVyteuIh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390e6ac844fso953269f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 11:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741290551; x=1741895351; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12HOUV0N5LQ2gOm+72FrFChkl6gwbWnu1Vh8fRPsrGk=;
        b=AVyteuIhnvCmOWtB8xDnGN7AoQjB/ZixK8AXKWqiBM49ds/a59/XAWlGmALEwapeAV
         XH0w3zJtNUtGOA4kWDnAckb1EdkT9gjoNH8TH1XC7UuszbDgWeDkLppRxPkYC9+a9M0v
         ldwxyvkCV7w6Xooj0+pfe6bw68tOX251ygnZcH/7Fq//9A27s4L2mQYUCMSE8vruSURC
         fUNoU/ZSI9OpM3dsoXTguVtw87ngXax+OEkNNTbzYzV1sLLmLaay6NkTrlDKOFicdhAG
         o0C7h6XjuQzUhzhKoOeA5Z9693rXZz6IDJQ6SdCTf8KJsaNK2KNOnftwxpMbyvOhyYw7
         qV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290551; x=1741895351;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12HOUV0N5LQ2gOm+72FrFChkl6gwbWnu1Vh8fRPsrGk=;
        b=PPzHBa/4lDxg52+JCEX6G6gOA3ZgpNVTlub5MeexwXzGq6xfaRTXCcHsLZl1PJg7C2
         vXNb/3h7mMAAT3Kl5/8TIneRyGcr8FmjkyBUtApdO6IcTgE0M3SmliSiUspVOORBa+Ha
         LrqeNHL7YU9l3mG7lYPS6HEziMzxz0aIB4THo/OWzkYoD5/Wl4vSO9rxtA6Jt141abqR
         2iFujXGFtgTWVYW4uPjqkIfR6HNHB+AbLUwYQM7ml/uWZJ7w0h6z1pFELnt0vWNvPTQE
         5W8zLgl2sEPcaa1AdqAkP+5ZuH0R4I1XLNoMX4q+XnGGHfHguRorAtftfEMQSIVDkWx7
         MpWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ6YTTJ62fCx56zkCKhUQxftF08YTSh9/5ovHp/3VEqxFq4PqX+zqcZeQm2yc82fecPztu8imtzBrRSjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze9mD50BcnAYDNOZ5qb7Wzt2/Amq206vd/5KL6zu/88f/VaB7e
	ihtAiQS+C2CB14iveoyQa3AVixd1SzmnyqXeQ4CXCAQK4QUofkJZKd0nTbAmnwg=
X-Gm-Gg: ASbGncsiA5aN4aVEI1Uw6EqcjL4yVewhh2pGh/2PoT1zP+6F8kdeJhwj8LOz+8kkEgt
	i3t79MWTw7za1eEKEugdrvc9qgapHg6BgoeYHyoq0kOaJiVlb25NwrcxcApNZXd4hoK2Z3ngGFw
	RbWoHwi9kare3p8UY5ToeCypHDV3H/cDaI8XO0G578eeE/Zd4IsJH4a5ul3n0DdKwgtj5+cdcJt
	ET5oqs1mrmKte2bHnQl1ApgqShEF+6RVBdKUo0Ms17qLVm3vyRXkZHXa6uGX9BSDlaAWrtCtDGP
	ugyr8c57gN2dYDcCojBroO5zKek9E0o0qah/PIiC77CqZtHiKQ==
X-Google-Smtp-Source: AGHT+IGs4Yei7Uj3yACj+GZktDDXIAXgpcENDsnATVmO5YWfHDh8m1kzphPMYmCnef1sPY9l6157dQ==
X-Received: by 2002:a5d:6d09:0:b0:38f:4d20:4a17 with SMTP id ffacd0b85a97d-39132d1f8acmr264061f8f.13.1741290551233;
        Thu, 06 Mar 2025 11:49:11 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfdff72sm3009082f8f.36.2025.03.06.11.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:49:10 -0800 (PST)
Date: Thu, 6 Mar 2025 22:49:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] RDMA/mana_ib: Use safer allocation function()
Message-ID: <58439ac0-1ee5-4f96-a595-7ab83b59139b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

My static checker says this multiplication can overflow.  I'm not an
expert in this code but the call tree would be:

ib_uverbs_handler_UVERBS_METHOD_QP_CREATE() <- reads cap from the user
-> ib_create_qp_user()
   -> create_qp()
      -> mana_ib_create_qp()
         -> mana_ib_create_ud_qp()
            -> create_shadow_queue()

It can't hurt to use safer interfaces.

Cc: stable@vger.kernel.org
Fixes: c8017f5b4856 ("RDMA/mana_ib: UD/GSI work requests")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
There seems to be another integer overflow bug in mana_ib_queue_size() as
well?  It's basically the exact same issue.  Maybe we could put a cap on
attr->cap.max_send/recv_wr at a lower level.  Maybe there already is some
bounds checking that I have missed...

 drivers/infiniband/hw/mana/shadow_queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/shadow_queue.h b/drivers/infiniband/hw/mana/shadow_queue.h
index d8bfb4c712d5..a4b3818f9c39 100644
--- a/drivers/infiniband/hw/mana/shadow_queue.h
+++ b/drivers/infiniband/hw/mana/shadow_queue.h
@@ -40,7 +40,7 @@ struct shadow_queue {
 
 static inline int create_shadow_queue(struct shadow_queue *queue, uint32_t length, uint32_t stride)
 {
-	queue->buffer = kvmalloc(length * stride, GFP_KERNEL);
+	queue->buffer = kvmalloc_array(length, stride, GFP_KERNEL);
 	if (!queue->buffer)
 		return -ENOMEM;
 
-- 
2.47.2


