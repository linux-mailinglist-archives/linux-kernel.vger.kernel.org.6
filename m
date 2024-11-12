Return-Path: <linux-kernel+bounces-406866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315B79C6548
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE31E28466F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB3121C18A;
	Tue, 12 Nov 2024 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="UkuUvAje"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC021B42A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454675; cv=none; b=DEdRspTuKdNF3YkHOB1dh7mxwS1i8xvWhz8DPAX6Ci1R+b6SXRZQSEJNqQz8UoeuR03lXNsWA/IHIxFlILZzGzWN4mphQferOiP0nmVVJj/YVAlAY0pzfWlMgvRPe5znNVhQemAdc0mv9oGBfvU4Yzx1FtC/9kYmnhX82vtLOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454675; c=relaxed/simple;
	bh=NS0oEJGLQMzwsxiRqjLbzLHQvzAKQUI4puz5ttzO3ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTKT3rwcMhFQJdb1Gq1+MxcFX4AmSvVJvz14NHtj0vMaq7zzLTkJvu2TV+hrD+SPDlHqYDjdjQjQe0b4h8u8AyXgEyp4CepHHZT+V1FPzlMpUCZs7uQ7DpbRb9ymqR/qPMFJUtiN2YFVqS84VDOwjK5l5pm1DYKFtVBeC8PplaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=UkuUvAje; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c6f492d2dso69606215ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1731454673; x=1732059473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YqXhkb9k4iQOMcnVT7rmgsvdL5//NXM53qxV9Inaccs=;
        b=UkuUvAjedCivHk8wUefarjgCbvX6sxpQhad9uSYvae4Y7SCA6LsaaAbncBANSPycIP
         25xFVgUpBGbzAoYX1LShImqwlWtjLW6BsyYi42Ip3HBqfPueFt0hPrBtz8HPi5Rv/tnL
         PegsAl58dcohWZUF/GkVeBrsHknReeK+PdyFF860CA376W3jNEj7qfxWfY4guJSb9NWJ
         sGS7ZDbnnm0FqzEaCaUim6ExSFfM80ZWQnUprQzBBFTcyj4sCRytd9l3670iWpn3U5qr
         u5JW2f5Q4DDPLSwh8ajthDHEo7f0G8U7XlMbMN2TxiakNZhOwwc39FfMZGL5UfBuuh+T
         Qz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731454673; x=1732059473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqXhkb9k4iQOMcnVT7rmgsvdL5//NXM53qxV9Inaccs=;
        b=kqOk6lNPcIakuNu5y7iZZTqIl4Rq748ZYQaeR8f5C9gv0yFenCcne6UiSudZFJqjbo
         SyVkDLwEqYFO+9pbDLSyU+GBR/v4of2Z9Ii2VaWH/2ACL1x3CmG3UK3Z7RVtjwUQ8+cM
         t13ewGRF4i3Qu/040mQvzwx38QbHontR/6mUFuGgxVOKtcn7ZGTSapEJzoh3tlMyAMrG
         tv7e3bNpQ5Wxya0PzNQqHmuuXqedNz6nyVNHiRsEWNh6HjKQW/AxLP+Hcgs3q7NpddoC
         XgDvon4RFgtq1EkfnE/6tUh3qNCkp4b2wSFSsn40GmU56p2lLkSgm5yqzesfL+n7qZuP
         4nMg==
X-Forwarded-Encrypted: i=1; AJvYcCXoIYCGy1yY+lGn+9KRb2i/1IJjldY2sDbVo3xdGHT5MQtyCijeWRiXGuKptTv7Vc7blQjktearALcUWUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCl67xR/WXRZ2AsJckZlf6gv4vUPIvPJQYD1jZm8zCfAKjPSt+
	4E2HgNKc5LGTco3FRHqG2Y5kAB0LYrP2VOBrNIgXZOyW9Sunh9CPVyHtWhPrgZAtTe/n3R4KHhY
	kv7o=
X-Google-Smtp-Source: AGHT+IGASecOiEAWmurWKnj+5DHPb4A0So/iYD/w6/x8Nel5WVXfgUdx9n98XhVQcCgEmMcc4HQFpA==
X-Received: by 2002:a17:903:1246:b0:20b:ab6a:3a18 with SMTP id d9443c01a7336-2118350d16fmr263060925ad.17.1731454673455;
        Tue, 12 Nov 2024 15:37:53 -0800 (PST)
Received: from localhost.localdomain ([91.196.220.163])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21177e419a4sm99549815ad.149.2024.11.12.15.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:37:52 -0800 (PST)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] xfrm: Add error handling when nla_put_u32() returns an error
Date: Tue, 12 Nov 2024 16:36:06 -0700
Message-ID: <20241112233613.6444-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error handling is missing when call to nla_put_u32() fails.
Handle the error when the call to nla_put_u32() returns an error.

The error was reported by Coverity Scan.
Report:
CID 1601525: (#1 of 1): Unused value (UNUSED_VALUE)
returned_value: Assigning value from nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num)
to err here, but that stored value is overwritten before it can be used

Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 net/xfrm/xfrm_user.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index f0ee0c7a59dd..a784598cc7cf 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2607,9 +2607,12 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
 	err = xfrm_if_id_put(skb, x->if_id);
 	if (err)
 		goto out_cancel;
-	if (x->pcpu_num != UINT_MAX)
+	if (x->pcpu_num != UINT_MAX) {
 		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
-
+		if (err)
+			goto out_cancel;
+	}
+
 	if (x->dir) {
 		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
 		if (err)
-- 
2.43.0


