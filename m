Return-Path: <linux-kernel+bounces-241334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4568E9279DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E529A1F25A74
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52441B1411;
	Thu,  4 Jul 2024 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXzjIbhW"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE641B120A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106390; cv=none; b=DFmP+H/suq7P1qzp75J+mF+e7fdtHJM1cMTlGtS69andWKubIuN9jTOPRWIfoVFGfAwcR+nZaniljD15jsDC6XAN4vaHQqL7r5TtAYH06cij8R3IBWcD6vh32kxmFND1md5Jnnteys7mHrCYo27LHUphThOwXhwDccxV4KqE9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106390; c=relaxed/simple;
	bh=rTi+HSfP+CDmR9Y8iR5mkNNK7g6n1NJse0dPKt9usAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s0WrNMW+KybhsY5IMolGQhXd0BhjfKeZcMY3SDiiCw9IKEjq+aH0atq46m5eObP38a2qzfIyUhhLNPZv6n4Xeh3SGWEvb0GfUVmvHYuM9AtBI+OGB85y485ZNMxirvIGs9hgHt3g+Y35sBJ+oj+zzCjJC+HyQZtCeqNmNT9xJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UXzjIbhW; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d5c9e76954so758316b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720106388; x=1720711188; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+zXDUJM7lfgygxbXYWjttEkeiLpdqmsPDn2aj5otxo=;
        b=UXzjIbhWdbJVnmk8NcCSyTsGxcyvFq8rI2NHjlztAfFJvEFpFRzOIQBo9zbc++1grb
         +DMep5I7UP2shvYsgBq93mwvK8m41NT4PRKNMKTgUUSGV72r0fJrvQBDSOGxMsbHAyqM
         LqsxqSi2LlYXNf7r9I9adPOcbmoiMACmUrKQ8sJJOJTNdGAU+XMsi/0pLqydeNoXYlh3
         8FfTL8yr8Bt20+yggYZHdOTppE6hH/p2bulYSMFKOSqNYy2/a17ed1YvDDjF5tDaP26h
         XhnzzoFx5Tpmawfqn8DHYGEqVxJMoHCNG6azd70OWOsB6XAyKSnYRLCM9SPLR6Gvg1rW
         iCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106388; x=1720711188;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+zXDUJM7lfgygxbXYWjttEkeiLpdqmsPDn2aj5otxo=;
        b=cnX/xJbObLMwLvCvz5VI78lRoS+Lc0NxJAe9ajC8B02KaPmSsDt3P42tSdS03tsPnW
         0DWvpPjyqcislxvOUhCcYYYnITmB2GcjEEJOhdpF//6X0/dKvThakLYeUuTgtN6ObYUn
         5t2o4rRPgU4jckOLZT4nd8cVMPKUVMM9xZxHmgMVRTd6b5oDLxA5i4oXjYTI4HuFSFnW
         PALGGOpnOnKpp79A/P4OXKqTehFJEpkBAPUiUz6Rve7L6U/J4/j5FZD6/fvbAasdOvNS
         HW9ZQaTB3QVQNzWNjVVuA1eAPJvPmMOQgMKY9xq9gm7LXR1siqLm5WNhkiu8ydguXU4M
         HGSg==
X-Forwarded-Encrypted: i=1; AJvYcCXZn2A4amL+upRDMKtFtn497VVg60azX4jfKV4h0tF3McY27EuZf3SlbCJUBRCDdkeSznllHHrBn7jx5k6ovnuXeIKBFOJW4+S4Y9Lr
X-Gm-Message-State: AOJu0YxSw2BiLyz/HroiFuuZTAs98Eh9bIA6COm9NOe3bCpKEEHCDSp8
	8kbqUB83seE8kOIrA0fb+6vwj5erPLQtVkPyGrilJTBnRbOVT/EQNlBh4TzWlOc=
X-Google-Smtp-Source: AGHT+IHAWyWPp3t/3hLm3p6DC0AvvzzmljGLCooD0y9pIZ4rkXDGF9k2VyEEwC6Rp+KB4ThglvcN9A==
X-Received: by 2002:a05:6808:1b14:b0:3d5:1f50:1860 with SMTP id 5614622812f47-3d915d2d73amr612153b6e.27.1720106387688;
        Thu, 04 Jul 2024 08:19:47 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:96a0:e6e9:112e:f4c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62f9c7c51sm2442474b6e.18.2024.07.04.08.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:19:47 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:19:44 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: bcmasp: Fix error code in probe()
Message-ID: <ZoWKBkHH9D1fqV4r@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return an error code if bcmasp_interface_create() fails.  Don't return
success.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index a806dadc4196..20c6529ec135 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1380,6 +1380,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 			dev_err(dev, "Cannot create eth interface %d\n", i);
 			bcmasp_remove_intfs(priv);
 			of_node_put(intf_node);
+			ret = -ENOMEM;
 			goto of_put_exit;
 		}
 		list_add_tail(&intf->list, &priv->intfs);
-- 
2.43.0


