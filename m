Return-Path: <linux-kernel+bounces-300628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AAB95E640
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720DD280FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524AC9450;
	Mon, 26 Aug 2024 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drQPqcMk"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E387E6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724635471; cv=none; b=G1MIv4CFYoRq49apGfLSHXoDT5XXzRHvhMCcXPED1yf/pJqi1yAcHoAWQ4maGm1V9IeG8pOmGXQx5cPb3ZaY2iMtIKPZZghyWLv0tZrffJefRXjDsTPbS2wid2QtCx2m3fs9XNY7daTaVoyIihlW3hSiduxvr2qobkK9AXvytfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724635471; c=relaxed/simple;
	bh=v8CqMHpiNm6zgNc1xMEA91mJlgj+PJNewbSN6i13o+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rv75LSPnNS7X8EA/Ffun1OJzvR3q7/PtuFdv5gs3oqSYASTlt7hyUugL7SXOf67OIgKA6kyWbaaapUnA2wAA205+QlvRQGng+nxpxDGrecU2Xjn+1tpqkw5OhGHthRcuZdOaKgLYCR6z+AaX3B525dc3x5iU8k2EHIEwccnZAt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drQPqcMk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a83597ce5beso585206466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724635468; x=1725240268; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pUSw3Wg+po+7sALfeoiLGusw6fGKrBQSg5ZAiP4ecJM=;
        b=drQPqcMkDAnHCXBSa+b78MnULGMLYsYTpUNJVjsbNjghqTmsrITdfHhVxOCk19FsTJ
         C66Vc+yy7uTo5zt8ikcdmma1KhqNd3mCO19nZWpQQc0m6RdqTJEvtI4iyG8tg1uheN6c
         Cet0HgAKgMxNRX7E5N3XdRQmoSJWREkk4dLLFqpECPh1MnRprHaiuZuAtsrsmHkts+bU
         Oy2hEtUubYZTFm9cxFMhDWh9p7GLlGdWke1yVZJwJ92jLWyMBbcFEVZSHODqxejy/COV
         kiAWfooPF/wLRF+Y1rL15GYg327BpURM7G4RFdDRgPl2dhyUA54O1U9FvCJTd9vrD+sB
         uV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724635468; x=1725240268;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUSw3Wg+po+7sALfeoiLGusw6fGKrBQSg5ZAiP4ecJM=;
        b=fWf2LVzbgMoRkvs55r+6EGRjDKZI1F5DuIZJKv7HB8jFKpcB+CFqiWsik/uYIW0nhS
         ATdN8sPoyHvU5coF5qnoxK1TyZ4LEm+72NxKk8SJ6tBfqqZLdurwLiq2i+LvjlvsHcnV
         XkPbcB3p6Jl4OkpqrqhNskWIDZs34PNQiOSc3oUL25j9t+xIkCjh7T7j91reFbDknO7d
         e14Up9Gc2e9ROkq/YNhc+QzNWrlZovthd3y6FLLdmuZukyzjO/W3L/vkKotsJoVDW483
         Nfgz6qY7WvHgRX9ivdD49NMYzwpyBh+ayLoLJ1tsKN6o8coJ+wycIYjaC5ISe3xj5ko5
         ZfCw==
X-Gm-Message-State: AOJu0YwtP8v35qTNmqEQ3mExDrUNuJIvw1I6Lk0BPVLz0tfGnYJxnTX5
	eGnBwbzto3ZQZD+cgeng9jDVhM17XAcje3XzShFArrlvbMTG55hY2LoJhA==
X-Google-Smtp-Source: AGHT+IGzJj7AI1xKj8Aylj+B2KgoRqxprOA85NfD05rzI2Hd3HdS6Y4Y711KqlxwqOZs+k7kul4PZA==
X-Received: by 2002:a17:907:d9e:b0:a86:9ff9:6768 with SMTP id a640c23a62f3a-a869ff96e96mr859055166b.22.1724635468218;
        Sun, 25 Aug 2024 18:24:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436351sm599022366b.103.2024.08.25.18.24.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Aug 2024 18:24:26 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/2] maple_tree: dump error message based on format
Date: Mon, 26 Aug 2024 01:24:22 +0000
Message-Id: <20240826012422.29935-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240826012422.29935-1-richard.weiyang@gmail.com>
References: <20240826012422.29935-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Just do what mt_dump_range64() does.

Dump the error message based on format.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/maple_tree.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 236b58fd9be4..0c06a4c6d3bd 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7217,9 +7217,15 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 		if (last == max)
 			break;
 		if (last > max) {
-			pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
+			switch(format) {
+			case mt_dump_hex:
+				pr_err("node %p last (%lx) > max (%lx) at pivot %d!\n",
 					node, last, max, i);
-			break;
+				break;
+			case mt_dump_dec:
+				pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
+					node, last, max, i);
+			}
 		}
 		first = last + 1;
 	}
-- 
2.34.1


