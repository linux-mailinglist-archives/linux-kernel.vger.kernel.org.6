Return-Path: <linux-kernel+bounces-381953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6960E9B069B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7496B2127D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF2418859E;
	Fri, 25 Oct 2024 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRwxe262"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD9188588
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868335; cv=none; b=HoDOJitLJyk6/yQms8NQJu0LAIPAg/Sdhu+u9AYrk7DinkoVo+yruCElKddq6+oFxcsnjjNxkAUXa6REeqrnFt6fge/iyyN3pOm7fAciqXMIdB2SqevFBeaDn7LIJPO/G6ILWsNDCBzzHWWlBzbqu/t0qS9IkkYDpL7c2VDUvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868335; c=relaxed/simple;
	bh=sBG/dcLi08PfCfK8oMZfQK7/QZ48KUs5hSThy2bJzww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z6H57npeApG8Fq7re17rvLb8ImLV7E9sSj6wbfWTpIlvq7vHSeNel/twUmsRiF5Gz2fMqceUlgoD0AT+3d3qL/kGMVTiA3ifD3FKcFDXTGmMhPNcKUpvZPWHGW+njn36MHPkBY6gf5arEcbFJ+4c4wwQ+tHstgQPMyjLbejWOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRwxe262; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7203c431f93so1671833b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729868332; x=1730473132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GmnpJhJhZ+H4a0YQJ0NmfUt9oLEgwDhsqXS0+70xNtM=;
        b=iRwxe2629Qa92s0zlDRJmThnEGXOyX+/qoJvNCQyUrL5jgzvgaOnqy/kYVXwsowMId
         5uIzuYniwHlTdroS+IyEJA/9f/uebceP/SrEMSiT6tKrh0My3JwMAkG4/upvNI4F5Z0x
         yfMmcSMbnJYlZEE4rAI8X0ut2Zw1kSwtY0mdJAEq/quQnqQxZCCnjMjhl+3M+lP8lru8
         GJj5pDaAq9Lyz/VBAbJM/EsDTZo34YC4ueceSFYiKzK1Hb8YlWUAnDXCzes8BtfPKODH
         nlBZrT2M/rAcv0DL8cEsG1PWxBb8/emL1qPVACjwO0V+yDwvhXNdtHC58R/OOgyGk6zP
         Hhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868332; x=1730473132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmnpJhJhZ+H4a0YQJ0NmfUt9oLEgwDhsqXS0+70xNtM=;
        b=iMjtO2LvmS3tjiBm7RXnUpnZzrq0+vNY8jtq5CYkGVrbTINY95A7JXAhCXDf8FJyZR
         FFvOrGwyU1R0lNHa/7rG8uo1T3ca3HIzvsTfNxMjq9YG4vLT0hqs932iEZ2uLQ1xt1dK
         65GijI7/VAv9awLqLXqu124egLRa/ognn4wYWganmjpcRbMJ7gtlqrpuq5g41SZ1rG9T
         uhi+FGAQ9GS20AWr/1tCEf73TR1WFInRZluWYxEKyD/AD3Ah+XmVwSs+yfJcWRREvPGq
         DB+Fxcyc+YxH4lARYEsyJvSvG3lsrhpisjpMy9beCBydpnPEU3Y0/BXTHsV4xTNt821x
         1s8g==
X-Forwarded-Encrypted: i=1; AJvYcCUygiu77Xzlo8B3EcooDbzcHreCjeaZmEj3rB/ubs4geonbU/JzMcrqGsJXEGBbD+eTDjcNTD1O5j9d/zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwjQuaudAX+3dVsgyZKKgZf8NHSkrHzm9x0wdxWcEcGBK2ozoi
	BWlQtz1112eGtEAzxGhVnwXu4RUvIFWper+w23qiXhRH9k9gaint
X-Google-Smtp-Source: AGHT+IF7KtDeQ31S7AxZo2zL9s4UHqylhFu64vx6lAS8Pc9c0Lk5OAwAOuV3oQjRkjuiXO9mwWNDKg==
X-Received: by 2002:a05:6a00:cc9:b0:71e:5a6a:94ca with SMTP id d2e1a72fcca58-72030b7c2f4mr14573433b3a.19.1729868332106;
        Fri, 25 Oct 2024 07:58:52 -0700 (PDT)
Received: from TW-MATTJAN1.eu.trendnet.org (219-87-142-18.static.tfn.net.tw. [219.87.142.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205792198fsm1154200b3a.26.2024.10.25.07.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:58:51 -0700 (PDT)
From: Matt Jan <zoo868e@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Matt Jan <zoo868e@gmail.com>
Subject: [PATCH] jfs: UBSAN: shift-out-of-bounds in dbFindBits
Date: Fri, 25 Oct 2024 22:58:20 +0800
Message-Id: <20241025145820.96761-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The starting bit number of free bits should not be >= 32 as it is
0-indexed.Assert that the number of bits is < 32, or if it is 32, the
input word must be 0.

Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
 fs/jfs/jfs_dmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 974ecf5e0d95..b9eccf8900eb 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3015,7 +3015,7 @@ static int dbFindBits(u32 word, int l2nb)
 	/* get the number of bits.
 	 */
 	nb = 1 << l2nb;
-	assert(nb <= DBWORD);
+	assert(nb < DBWORD || (nb == DBWORD && !word));
 
 	/* complement the word so we can use a mask (i.e. 0s represent
 	 * free bits) and compute the mask.
-- 
2.25.1


