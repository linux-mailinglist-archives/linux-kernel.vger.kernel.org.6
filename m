Return-Path: <linux-kernel+bounces-444960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E559F0F16
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B7D1632DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608341E1C03;
	Fri, 13 Dec 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GykInT51"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FB61E0E15
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100098; cv=none; b=hLGJ6blao7hX6ykJcZ3nOzMfsmIyto8p4yiwuZeOeS36naNjChwVE3L8AL1BGMvqylLiL2474HUwuwODmg/I4+fgIT0h+BwvxNAB/qAl5fn2IkSadJnlZV6+GZv4AuJuzB1DRJyDftiXzKXUy7Btf8+8euaUU3gs3eEBXtbIwHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100098; c=relaxed/simple;
	bh=ycSL9pobM2GhQ8mh8TcgkFJoZAB71btUIwZlSI8OBQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n9g+zqFCghDw5BlpP7djV1kU/BRY/YgmETD7Z0WFwWZOeyptWn6PxmB7XIbZJE0dO508ugUZn8vgU7GpnFa+OnDWU7StrqJyP5w9mdKD4lfhcIrypw6N5HMnZ1wpgVpelz67lU/k5Ro44eTbnkiCQCxUarXq5gLX5kMcCNZ5Lz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GykInT51; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa67333f7d2so273627366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734100095; x=1734704895; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HgAV16YkdRGlFfEMnvEaWjST0Bhl3h+Wb8WzngoB54=;
        b=GykInT51SChvGiDEfeYGzIpfxjxZnSLyHN6saQXW62tSB3pMMm2Y2Xhc7LGknP+bzC
         BiBTo5GyCes6qwTWuBbzekG1bi8FWoAGKd7gGL564zQh2QMU16FTlQ5ROWLPlLh1Vi9u
         pdcO1rnWcxJ8Lk8CHe+/2m8PXgaJI1nqvNix/EEKiuGLugc+yFC/3WIH+84G6hleQkfh
         /Zcc5wH1X3FjPr23RVnt559R6Jd22E6oe+d2NlobGQBVC23HKgGtubwkNA/cM28ShEYI
         w3pOScruyWraGjM2xnhQQOK4DqQY6R9f5ybfuWjaGoSDJQb2Zqk8SfTPgxFrdttq031Z
         5NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100095; x=1734704895;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HgAV16YkdRGlFfEMnvEaWjST0Bhl3h+Wb8WzngoB54=;
        b=Wn3X+REX7bECpnLR4ZRsYA6gu6fzMwiA+QotmW8P9G5aF94g0duFpnbrKGrKuNu8Ls
         10DjrWseYVJ+OxjWPK9zYz0PXcG4KoXNdTETzFw2Ftjsauid3Y+FAfj10J1qliSju+0R
         GqlskDA3uCw+hyc+Qk8oJBbHGh6CW9FfJM9Am0mZLLl++0AsbeXxpiULQBxoHqi6RPaG
         wdkM8vfgrQ+I+a8auwEucYYl+EgR7pOJeSMNDFfGibxoR9go7d9CV1k0jtEZ9u7pt4k1
         YUJSan3m4zNVHfoorWZ1fEuBMf6GIijm+J/RZ45YxJerpyRfxfkaWPeIf20A31/zr+J3
         EJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvgJjEnzxBmqmb6j2XZqplq2xNdtK2ic5NCIm8aJmeCV7ycdym4Q8jWcKEusStkw2TpNW46pl62xOpojA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0TawJs+GsyRblRTS8iWeaSdJaxyfx5RtoI92dqIFx7y+4fD+
	byRx6cK+3FhqoeHMK3I1RKVJ8X5vfE06uaRCFnb6P1D7NZ9jo91VSO27mq5p6uA=
X-Gm-Gg: ASbGncuRCHmT2jJBydP4MXOcAB1oSemYc2SSCQe0wM1yDq2TywrF0Xwvyc07pcR73Xs
	Xe8rdG8h1hlqqY3grcohSIcVTjqXOodhT19HRyvPVQk28rBVrJaRMdjJ5+qEQI022IdhkmyuQxG
	5Kjr5DX06BtGLgKrAx7wrOCxu/UucIsR5l+w6eFk3MAlMb/FoKTyM6JQCbdKJREp9lyGtvdWgk7
	y7hSoaaI5L2IgUQKpAAuH0PjwNHVWuZ7m0bSFXuV0FMUC1BPlpB5hKjRgI0sw==
X-Google-Smtp-Source: AGHT+IGJkag4RDJORMNjsRd1byODIzZaljb10SMvh4Y3I8u2YSlY83WcCmGpoYoRVmZz3xf2h0z1zQ==
X-Received: by 2002:a17:906:7944:b0:aa6:6e04:eef6 with SMTP id a640c23a62f3a-aab77f07a24mr319003966b.61.1734100095261;
        Fri, 13 Dec 2024 06:28:15 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6773936c8sm808925466b.85.2024.12.13.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:28:14 -0800 (PST)
Date: Fri, 13 Dec 2024 17:28:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aviad Krawczyk <aviad.krawczyk@huawei.com>
Cc: Cai Huoqing <cai.huoqing@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Zhao Chen <zhaochen6@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: hinic: Fix cleanup in create_rxqs/txqs()
Message-ID: <0cc98faf-a0ed-4565-a55b-0fa2734bc205@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a check for NULL at the start of create_txqs() and
create_rxqs() which tess if "nic_dev->txqs" is non-NULL.  The
intention is that if the device is already open and the queues
are already created then we don't create them a second time.

However, the bug is that if we have an error in the create_txqs()
then the pointer doesn't get set back to NULL.  The NULL check
at the start of the function will say that it's already open when
it's not and the device can't be used.

Set ->txqs back to NULL on cleanup on error.

Fixes: c3e79baf1b03 ("net-next/hinic: Add logical Txq and Rxq")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/huawei/hinic/hinic_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 890f213da8d1..ae1f523d6841 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -172,6 +172,7 @@ static int create_txqs(struct hinic_dev *nic_dev)
 	hinic_sq_dbgfs_uninit(nic_dev);
 
 	devm_kfree(&netdev->dev, nic_dev->txqs);
+	nic_dev->txqs = NULL;
 	return err;
 }
 
@@ -268,6 +269,7 @@ static int create_rxqs(struct hinic_dev *nic_dev)
 	hinic_rq_dbgfs_uninit(nic_dev);
 
 	devm_kfree(&netdev->dev, nic_dev->rxqs);
+	nic_dev->rxqs = NULL;
 	return err;
 }
 
-- 
2.45.2


