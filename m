Return-Path: <linux-kernel+bounces-538184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B2A49573
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367CB188010B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EA02580CD;
	Fri, 28 Feb 2025 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxI6KwEg"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE549256C9A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735590; cv=none; b=N/JaIr1qXzcX7DqJ4ij3kB/h17xjiww1gfPSyhCRcpRNXBAK2zeBQV/reJDes07vuwvHQTZLVD6GAle7VMsuHbVLPzFTaNOx+oJS41a3FNXJzaqbSgJRqPcuHLpwVCANn+xAZjuh8uC/fT6g2QM5mz1DXCjVSnVpXrhvDhxk/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735590; c=relaxed/simple;
	bh=/NzJlIrCLPmoVtSm4UXmmVH9i0UM47OMoq0AeT6Hgms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DVD4QHfkO7napFHJZj94k3prGX2swXlpFTIIYEqPGi3ux+eS2KsUa89caDpkTgAEnSDa7f4R57aZSzDzAHqAL4KT9xQqJVJv3peCLv3PdYs5q0nSRfspbvVj2ggkosVSUV8f4DgloYzQJhQuGBhKP1M2xC+BYOrVvDkAyeclX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gxI6KwEg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso2445760a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740735586; x=1741340386; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1EmXzog6dpvM5CsDQvgfubk16lqeEYHkBYJ9o/E4yE=;
        b=gxI6KwEgYivTdYyj5c9+kzZfptHdpVKwx3o5FvzPgl9/9yAZbRfoOOSYQ5SVJVT8ZU
         DtfGPlXJtQcwVSeV9LaIYJ/V6+UBiyEYfW+Pe86eLfpOdD1+dEPs38ENESzHf0jvPX8k
         jQ7bly+/cQeVM58CF8H/4ZxKjy0tFCW+PIXLisfItMvERcvN1YLWUg8rpIVS7H5bD6pa
         ZyYCvOuBTNiy5zQ3STY0LniqFzxjxh9jEJp80MZvh2aHNoFV5RG6+rUj86HOHv6/3t6+
         ZYxt+nkFCrcLRvYzouMVHwydklG9Uf1ZrKFqV8hbaVk4Z8fKBzDc3IwZbvQx5dm19gzu
         8Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740735586; x=1741340386;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1EmXzog6dpvM5CsDQvgfubk16lqeEYHkBYJ9o/E4yE=;
        b=MXAkQxAZ7WAQcrj81U6pDh2Np2Q20E8FrLZ3oPYo3CvVysq+1g9JqN/r+YXyCUtFd+
         Hdxntv9WxwWO0r63NIZ+9FKFkctXcwcVhO9HZuA+hiqoJXvM6aiGvRKunztyAMOAfmyu
         FW9EtlwIBy5u6f5h6QhQxsfJZxEIJvWfptdIGGX/mSYCRTQbhKetC5JY1lOjtJ6BDMwt
         1gXsd28YgkomI/v59B7laB5hNViRBgmef/vPWDENUDeHK7FAGbcGdVN5ss226GV3rCZ2
         RuuD8Wum4Ziu2nm41GWZZ48DdQeVtYoFQxmEI0jw1feuOGB4ZqO2JBRN/nndjV8H6g0F
         kZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2wzcsUu0oBX1OElT83FpVon3M4Da53ZJLjXAjyJmmV7+LO1ZePgOBGDkgV1dQckvKu8X0K7AT1HdeRWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxURggpEHVJp6vZIQsLw8+/MAQIqcRTn9TJvDE411ngQ7o+K4EY
	kEtJWpZ0JWd4q36StWW2/KP6nSGeilclYo7vgnkShiXenCXstwXVDB/z49xwFR0=
X-Gm-Gg: ASbGncspaUNlKBaJ7LsQ/3B4b4s9hfGtCgFEf9qkzY0fzSHfZa4sc+A/yQnG/lDJsvL
	gjQNOgDQRZaJPyWuYYmSRZ8DEPzCn33IzdBfFdc7dmTW4+F96T/tjoeOZo7uQN83Pr8kkAFFWf3
	yIZeYw3qwyybb8NmGPkGdefQet6LhfApxu4R6jeL91D5o7qv4fN3JFTe3/JeSqIhUiYrwhpuujA
	/oTAP8TqnxnEyQaNk5P9nkBC597Xb7Aw3NYonyoskig2jQJXVn1J/kTvgNhaesXOsPVDOX9r3ON
	xLkQBXfOCYF6kyDoq68U+4IG5qpUUsY=
X-Google-Smtp-Source: AGHT+IHJ9U6y6nhglkIHEC0ZWjrm3br0eCOOxp9U+sAhp0Pingxi86o1xuAOO8VfOthG6xXZZgYDuQ==
X-Received: by 2002:a17:907:3fa3:b0:abb:e961:ca32 with SMTP id a640c23a62f3a-abf2642bc10mr250079766b.21.1740735586007;
        Fri, 28 Feb 2025 01:39:46 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c6ed7f1sm261343266b.120.2025.02.28.01.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:39:45 -0800 (PST)
Date: Fri, 28 Feb 2025 12:39:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nvme-tcp: fix signedness bug in nvme_tcp_init_connection()
Message-ID: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kernel_recvmsg() function returns an int which could be either
negative error codes or the number of bytes received.  The problem is
that the condition:

	if (ret < sizeof(*icresp)) {

is type promoted to type unsigned long and negative values are treated
as high positive values which is success, when they should be treated as
failure.  Add a cast so to avoid the type promotion.

Fixes: 578539e09690 ("nvme-tcp: fix connect failure on receiving partial ICResp PDU")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8a9131c95a3d..361b04ec5b5d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1495,7 +1495,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	msg.msg_flags = MSG_WAITALL;
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (ret < sizeof(*icresp)) {
+	if (ret < (int)sizeof(*icresp)) {
 		pr_warn("queue %d: failed to receive icresp, error %d\n",
 			nvme_tcp_queue_id(queue), ret);
 		if (ret >= 0)
-- 
2.47.2


