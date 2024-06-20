Return-Path: <linux-kernel+bounces-222514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C091031D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8801C21358
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C621AD413;
	Thu, 20 Jun 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="QKqQ0Je0"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017DB1ABCCB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883338; cv=none; b=f0OpCqf7sn8duCzbVh/Njnc1NwOtTfmKLe9C2wYpm0RwhbPF3QxTz5hEU5/JXHhZiIEMXD2W4VcuC+VEq0NSviwSqdtgDYZnfyADN791Imlsli1iQiC+TsqpbdqgXU9VxfwZJsn2cQ3AiWf48ONmxFRBtoVKaaJJngddTX5Zcjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883338; c=relaxed/simple;
	bh=x7omDxUPbZV7/HufJPxDWQarrRBoOigY55WGBtYBibA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJ0ja3Ob50f03wFYeM6N09WaQt1suSzerqGEgAmOsvOC80SRP6Ge4biixKTGMbfPFBYiQnEJwe4p3T8prX+uL9x6p3EBz882ktqjTZlMMNwKCV6iFb6XgGtik5+VXqMW72yaFbsu4/LetmjOoKkp41PXTA2wTRIWA4mayvUNFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=QKqQ0Je0; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c2d25b5432so639518a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1718883335; x=1719488135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dVIO9B/gKgBOADV8jO7dDGNIDax+746A0tzxgyv+QQ=;
        b=QKqQ0Je0QBdrTIm8zqLUzlEAZfwYryBBrosrKrNumTWbU2c4RQYEvfuwNdRlN9r+0j
         xJP+tZjJBgDxmloGyr3PS/91c+WIwWnTstxMODex64/Ro5jY+CJm2VdcVPGuzsUPUp/K
         19GBDtOX6vYyZTBSGHX1vgKtXTAwscV+A/o05ZSWh9/hwda+qM91oI26q09SqwFs67s1
         /9lgW/tDvqC93K/Z22g9PxCbfGI61H5HzngcxENS5stf7Y1QdRWerdyGOqkC2rTKX/WE
         usB8dVaE7ATi2L7NTHJFfng2Tn9TfxyYzmeojwkJP9+N+MHWokTrbERGiLpuIH0e0z6J
         4+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718883335; x=1719488135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dVIO9B/gKgBOADV8jO7dDGNIDax+746A0tzxgyv+QQ=;
        b=tNfO0+MDuzFa1MsYNUcyFY4R68hBQ2A/MOkSnGqWoHKOB0yDwIjt3EbJdBb2QmE0Yb
         h3XhmPPfJ1bc1+vXXV63H3vohAxBkJe7kHSfFTa0ifiddjexeitDFRJwERkg7LTdEESz
         STVS6L7CSVWp7wNo5rg4hC9l2c/na0upyF9ojOs+tF0e9pGaj8P2evVA69ujhDCTrbq0
         VrcmD+QHLm00Cg1PAX+AtZjLImSco0XVSqzNwYIIUjqiz79m51f/MWZo2dMcwn4cOgAL
         7RfVMW1z7faXKn6J97bdw1SfSLJQV3Mp/Qp+wvptod/+PCo9zt7TlCo7A/miX4o0mPDw
         zGCw==
X-Forwarded-Encrypted: i=1; AJvYcCXDgs0k+SdS8Se6NyIsdfDF1QQ5/He7wmQIxSH3oehHkOaZaxaIBA0xSKuGtxnrCg/3l2i5ySWdrApVUvf2E/I0iuZ7sWGCPcfONVpN
X-Gm-Message-State: AOJu0Yy1nfId19shdwKeJis1TlyvE8yP3o/P7cOkVWCLRteRfSF0xnwk
	gsNYO52ueLZUhT49Lr0NIGoTY3cl9rNTOV4T3DJ2x2x14bVcGprY4Ziu12azVdI=
X-Google-Smtp-Source: AGHT+IFRllndN6Xym3DAVRxuUPeCS0DRq1KGMb2aEJa7kDuGQNYUEeIY8ehUjwujMjdb446BuXz+yg==
X-Received: by 2002:a17:90b:104c:b0:2c7:6305:9905 with SMTP id 98e67ed59e1d1-2c7b57ff1f9mr4863150a91.10.1718883334926;
        Thu, 20 Jun 2024 04:35:34 -0700 (PDT)
Received: from remote.smartx.com ([1.202.18.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e5af9db7sm1442885a91.40.2024.06.20.04.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:35:34 -0700 (PDT)
From: Changliang Wu <changliang.wu@smartx.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changliang Wu <changliang.wu@smartx.com>
Subject: [PATCH] netfilter: ctnetlink: support CTA_FILTER for flush
Date: Thu, 20 Jun 2024 19:35:27 +0800
Message-ID: <20240620113527.7789-1-changliang.wu@smartx.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From cb8aa9a, we can use kernel side filtering for dump, but
this capability is not available for flush.

This Patch allows advanced filter with CTA_FILTER for flush

Performace
1048576 ct flows in total, delete 50,000 flows by origin src ip
3.06s -> dump all, compare and delete
584ms -> directly flush with filter

Signed-off-by: Changliang Wu <changliang.wu@smartx.com>
---
 net/netfilter/nf_conntrack_netlink.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 3b846cbdc..93afe57d9 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1579,9 +1579,6 @@ static int ctnetlink_flush_conntrack(struct net *net,
 	};
 
 	if (ctnetlink_needs_filter(family, cda)) {
-		if (cda[CTA_FILTER])
-			return -EOPNOTSUPP;
-
 		filter = ctnetlink_alloc_filter(cda, family);
 		if (IS_ERR(filter))
 			return PTR_ERR(filter);
@@ -1610,14 +1607,14 @@ static int ctnetlink_del_conntrack(struct sk_buff *skb,
 	if (err < 0)
 		return err;
 
-	if (cda[CTA_TUPLE_ORIG])
+	if (cda[CTA_TUPLE_ORIG] && !cda[CTA_FILTER])
 		err = ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_ORIG,
 					    family, &zone);
-	else if (cda[CTA_TUPLE_REPLY])
+	else if (cda[CTA_TUPLE_REPLY] && !cda[CTA_FILTER])
 		err = ctnetlink_parse_tuple(cda, &tuple, CTA_TUPLE_REPLY,
 					    family, &zone);
 	else {
-		u_int8_t u3 = info->nfmsg->version ? family : AF_UNSPEC;
+		u8 u3 = info->nfmsg->version || cda[CTA_FILTER] ? family : AF_UNSPEC;
 
 		return ctnetlink_flush_conntrack(info->net, cda,
 						 NETLINK_CB(skb).portid,
-- 
2.43.0


