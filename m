Return-Path: <linux-kernel+bounces-300627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5732E95E63E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D8A1C20906
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD1029AF;
	Mon, 26 Aug 2024 01:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtkBfM28"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732BC635
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635470; cv=none; b=IHhv/OnZ74DIiQF9A+WpBBWm/41Lf8RNvgwNHcOsb+9/AW/QS7tFS05Q/RZcKBy5uBubBxHsXoqZjNWDMv1taIEpTHwpdHtP4eJnXCYf3dXMlNQ3SMjFnQXMWqOynUdI7e0jwVRq5XDDQec0NvPzgW5ggjVUPdRRQDP5eUU+26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635470; c=relaxed/simple;
	bh=TZU8bwJqotCyEVnLJ+fb/WMNQ7JQcC2cs0lhlT8+6XI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QHoNPa4xiwvdroawLTWsLAMKgTXDTlKBeTr23/ZWllpCsrkFkiooR7O6o5rBSg3C5N14CKOsDly5kljmHZVRViu/7J7yTV99EbHx73DOboyVeBSv6q92UADK+FMg+MWQ/Ey0RbKemg6lh67V9jYn79XIlSoHPzqMH49B2p5tBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtkBfM28; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c07eebf29eso1474014a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724635467; x=1725240267; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iAVxjKshVn9IsHqD/wT/MHx6+yiCMsIWecHqmYT9HI=;
        b=jtkBfM28e9Ue7bIppOniheccnBVHprKii6AflA3PShvbY3U5HOPxbjfMWLlLWJfJE5
         PLJ0lcrQRngd0LBvSa1y6nap02/N9W5N9npZ6J+d6vCjeYdTYPDv1QtkRT0k9cOnOTLM
         ba5UqRqGWGDtTSf7u/tWEiSUXkTC2vaboBj5buByEn0xtas/KCPFBG/qyfpx2m+3O78n
         t0EFlR/6dFU4QamOwcFfxV0WcXvv0iYw6DdZ1YD5nbuLP71kVPqUDS44cHpEzejklZ1e
         ggk/losKUdh5iobfhe7dMEa0kWX3hI9O85dXyQ71Hr4tA0LoXl7idFNG6FXYaMAUGL1c
         lzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724635467; x=1725240267;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iAVxjKshVn9IsHqD/wT/MHx6+yiCMsIWecHqmYT9HI=;
        b=XsqmuFe7P2cV4R72wgSY22Bq152exR2d88zv5CQbPJOh0SUIlk/r3NPiFRgI24VNMG
         QajREA+rel+Eptd31zyul6DqiICsktco/YOaXwrAgwRVooSbChnyRSDHJ25h4/dUxTbn
         GEzaUGJutp4UTjuaDEIhMUNMAqBUTXI6yvlT/IS0Zti2UsL+EqQoH5Jk2K8amqPp4w+K
         d750fWnBLZJlvFeEth58DOfvXzGMXEujVax6pALI5CttI94bSDiEjYp8B65LPXSY2bG3
         w/zmHPZz+nVJUKQoCwhGyfaoD2H1LQmiqSzLALQ9XFsOVBwSflcoz9vFUBQt1NeEDDcv
         UsKg==
X-Gm-Message-State: AOJu0YyKj/ZlaMKl1u60VCh04cOjZlHvP9fWwpWas18oHh3Z80wRu+pb
	xm8PMUwy+oHEHLmEQwQHvwjWrdHXi5+2sY25IDPtwQGtjmf7nkEs9ELjuQ==
X-Google-Smtp-Source: AGHT+IH4ZftfX9hQAMXwPumBz79vqOaKu+0te+GsHQglZiQvbGvJSLiXsE+PjYMokwsI2aNgYk3U+A==
X-Received: by 2002:a05:6402:278e:b0:5be:dd2d:83 with SMTP id 4fb4d7f45d1cf-5c08915b969mr8586045a12.6.1724635466420;
        Sun, 25 Aug 2024 18:24:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c43dcsm5221768a12.69.2024.08.25.18.24.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Aug 2024 18:24:25 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/2] maple_tree: arange64 node is not a leaf node
Date: Mon, 26 Aug 2024 01:24:21 +0000
Message-Id: <20240826012422.29935-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

mt_dump_arange64() only applies to an entry whose type is
maple_arange_64, in which mte_is_leaf() must return false.

Since mte_is_leaf() here is always false, we can remove this condition
check.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/maple_tree.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5dd9d9db4fdc..236b58fd9be4 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7177,7 +7177,6 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 	enum mt_dump_format format)
 {
 	struct maple_arange_64 *node = &mte_to_node(entry)->ma64;
-	bool leaf = mte_is_leaf(entry);
 	unsigned long first = min;
 	int i;
 
@@ -7211,10 +7210,7 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 			break;
 		if (last == 0 && i > 0)
 			break;
-		if (leaf)
-			mt_dump_entry(mt_slot(mt, node->slot, i),
-					first, last, depth + 1, format);
-		else if (node->slot[i])
+		if (node->slot[i])
 			mt_dump_node(mt, mt_slot(mt, node->slot, i),
 					first, last, depth + 1, format);
 
-- 
2.34.1


