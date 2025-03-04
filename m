Return-Path: <linux-kernel+bounces-543315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD6A4D432
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6104516EDE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D681F4624;
	Tue,  4 Mar 2025 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFLca5Hb"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6D218CBF2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071671; cv=none; b=G7Uc65GQG5un9rCAJOUuTjZvaD21YakkX3jPut7+83l3yblNxWgntQkM3ia/m8dsZKmf/KXaBS/ByTC3o823FTLcFjn7zGm85mjsJdfvOOkGrD87cOz+DJmgwpAt/tQZhg86RbjrUzaEfnucyuc5rqRfWTHcG3lEe9iP/7f/PfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071671; c=relaxed/simple;
	bh=WeoK4O4lNVf1jf3RL4kog/vPaezBLPVB+yX+IBUebZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GZkRCkEnJRfO88qn6hofQteVK8oxCj5XzkU7raq0oUDkiRfVgpfbcvCSv29T1spSftSUCwYhZTeMtGmIXLzzXYtI9d3FdB2Xc8O1DVK/Mdcx7aFU5Ik4yBqJhp58hzTXM/DbGhPwr3D9nik6q/UK58lqS2bn76sH2d3CQNJbZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kFLca5Hb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf42913e95so523499466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741071668; x=1741676468; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YSdQFiVMCrS5O9/EkwHKFfamzvbURyk8m93xw+1w4DU=;
        b=kFLca5Hb30n3UWwFIlGhDXf1JnSJVCgZRapyX4U4p6xFm5XzpGBl29g+frv7oCXOc7
         ta2gpOe2KP5V1EPggK0a+7F6kmNbqFylwINo3CSM0bPka3+YDtOUO+/H7ASDh5Ybusva
         DRkowRgqE58lU/5kZWOCYTUARzc/hnwuvLuAWNhZa2TQ0RbiaT7++XaR7u/yEIMih9py
         rscFulH1qYeIpkY5Un8kYCytSCezAOBYT5W6m2l4pHgKAvG76nlSBLOOvsXoR5he7Cw5
         TSut2iecizCnAQton7W/GtOT/Qz0RwdHps1q0CJ5IPjmsxc4YFn5EeOKdrGEvKVD6C3O
         suvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741071668; x=1741676468;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSdQFiVMCrS5O9/EkwHKFfamzvbURyk8m93xw+1w4DU=;
        b=wONQWiaQ3mFxUCm2Q/kGWtWn4n4csMrEzCfLjvf1PlTg7GBMxVyojoj2BcAcSIBVTc
         K261aDPjJF/MX+YUyzZbiwPusPNkMuwba67geTH4ljvLqBdk8X56pWOatjWPlf4U1biJ
         OAYf8XD68kXJ3/F69tnAVjYLUyYWUbpZ42xg5UzrSNZpWPkPurqpqXsCs+i12NlEjcpQ
         fqWy+cc8yfRJqrQQBf1youOtpdQCriVw744BW8I9fvtE1Ixz42cNIa1qTinm/qoQ3wqK
         Pdgh1N0XZW239zOq6uN2L/GoLrxDzmfXfe6KYv3lZToLjRe6E7gBSeQ8GwQa5NcCihu8
         DPkA==
X-Forwarded-Encrypted: i=1; AJvYcCXTnd3ThJv/ihENx5hn16jdrDeTTZnRJrw8kQL9LMzvqadLG7HlKb+ZCjDNU+bYqZ7/bmKrFrmgIy+3j2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9MJRcZ7x8SGOgUzOsUByPT+M/o8c5jDppE0SRnk74hQplZ3U1
	OhgAv2KaLYXrTgZiVLcc8Fz/Zm2KfGxJ5Wmw5TohwB5vr6DckuGEphyu7W/jKI8=
X-Gm-Gg: ASbGnctjhr28D7HAjHaA3m+MXM0a9+0i8KA1Q8raEvOK1ckJ8EE4alh9chCYh/b+gRM
	nouyPs88soHTtqikRYMGLgJgDX9QBrpR5NbweGDs3I45KSESd4nkIY4STMmof3Y/Mw9ZQB0WYkX
	zU2aoyHT7YnRZWEUFr1zrJmpQRXyXSFEYlDUxJifIqLCKJ6OzVu7uV8VCGjms/uY+ioQdu1ewcH
	VZQ94a2ekw4aa0OQnkAEePTiTdvDg6jfZ2kcvtukpGGiYgqw8HuO3lG3f2dyau3DqCTmYPGCK6T
	wRY4XuJCD2qFW+Ks6v61z3c9p/8q+HPdWmmDKvo6kbI8JcaKzQ==
X-Google-Smtp-Source: AGHT+IGxyBW63fSgEIDkdKmUigp27y49JS7UkTA+NZOY+d9+or8SnPNDX/CPFO1XI+oWKppLDaoD5Q==
X-Received: by 2002:a17:907:86a9:b0:abf:6424:79fa with SMTP id a640c23a62f3a-abf6424d073mr1083370966b.28.1741071668220;
        Mon, 03 Mar 2025 23:01:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf7981482csm286996066b.122.2025.03.03.23.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:01:07 -0800 (PST)
Date: Tue, 4 Mar 2025 10:01:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net-next] net: Silence use after free static checker
 warning
Message-ID: <Z8alMHz89jH3uPJ9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The cpu_rmap_put() will call kfree() when the last reference is dropped.

Fortunately, this is not the the last reference so it won't free it
here.  Unfortunately, static checkers are not clever enough and they
still warn that this could lead to a use after free on the next line.
Flip these two statements around to silence the static checker false
positve.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9189c4a048d7..c102349e04ee 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7072,8 +7072,8 @@ void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
 put_rmap:
 #ifdef CONFIG_RFS_ACCEL
 	if (napi->dev->rx_cpu_rmap_auto) {
-		cpu_rmap_put(napi->dev->rx_cpu_rmap);
 		napi->dev->rx_cpu_rmap->obj[napi->napi_rmap_idx] = NULL;
+		cpu_rmap_put(napi->dev->rx_cpu_rmap);
 		napi->napi_rmap_idx = -1;
 	}
 #endif
-- 
2.47.2


